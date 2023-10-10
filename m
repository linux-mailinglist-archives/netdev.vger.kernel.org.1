Return-Path: <netdev+bounces-39545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5840C7BFBA8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A791C20B60
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72554101DA;
	Tue, 10 Oct 2023 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F58F58
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:43:03 +0000 (UTC)
X-Greylist: delayed 1952 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 05:43:01 PDT
Received: from janet.servers.dxld.at (mail.servers.dxld.at [IPv6:2001:678:4d8:200::1a57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFB491
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:43:01 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 10 Oct 2023 14:10:09 +0200
Date: Tue, 10 Oct 2023 14:10:03 +0200
From: Daniel =?utf-8?Q?Gr=C3=B6ber?= <dxld@darkboxed.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: [BUG] rtnl_newlink: Rogue MOVE event delivered on netns change
Message-ID: <20231010121003.x3yi6fihecewjy4e@House.clients.dxld.at>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi netdev,

Changing a device's netns and renaming it with one RTM_NEWLINK call causes
a rogue MOVE uevent to be delivered to the new netns in addition to the
expected ADD uevent.

iproute2 reproducer:

    $ ip netns add test
    $ ip link add dev eth0 netns test type dummy
    $ ip link add dev eth0 type dummy

    $ ip -netns test link set dev eth0 netns 1 name eth123

With the last command, which renames the device and moves it out of the
netns, we get the following:

    $ udevadm monitor -k
    KERNEL[230953.424834] add      /devices/virtual/net/eth0 (net)
    KERNEL[230953.424914] move     /devices/virtual/net/eth0 (net)
    KERNEL[230953.425066] move     /devices/virtual/net/eth123 (net)

The problem is the MOVE event hooribly confuses userspace. The particular
symptom we're seing is that systemd will bring down the ifup@eth0.service
on the host as it handles the MOVE of eth0->eth123 as a stop for the
BoundTo sys-subsystem-net-devices-eth0.device unit.

I also create a clashing eth0 device on the host in the repro to
demonstrate that the RTM_NETLINK move+rename call is atomic and so the MOVE
event is entirely nonsensical.

Looking at the code in __rtnl_newlink I see do_setlink first calls
__dev_change_net_namespace and then dev_change_name. My guess is the order
is just wrong here.

Thanks,
--Daniel

PS: Full debugging log in https://github.com/lxc/incus/issues/146

