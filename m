Return-Path: <netdev+bounces-30893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9440789BCC
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 09:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166921C20929
	for <lists+netdev@lfdr.de>; Sun, 27 Aug 2023 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A635EBC;
	Sun, 27 Aug 2023 07:35:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D402A5D
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 07:35:24 +0000 (UTC)
X-Greylist: delayed 59964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 00:35:23 PDT
Received: from mail.redxen.eu (chisa.nurnberg.hetzner.redxen.eu [157.90.22.104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E22F1
	for <netdev@vger.kernel.org>; Sun, 27 Aug 2023 00:35:22 -0700 (PDT)
Received: from localhost (karu.nurnberg.hetzner.redxen.eu [157.90.160.106])
	by mail.redxen.eu (RedXen Mail Postfix) with ESMTPSA id A5A715FA70;
	Sun, 27 Aug 2023 07:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=redxen.eu;
	s=2021.05.31.01-mail; t=1693121720;
	bh=P0N/rGkIyDAR+j4UxcDvSI2BA8Pq3AuUTF7mtNeliJ4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To;
	b=lHnfRxmqKjV1N9AwEFCoBfaBHGhM4HwK92agGN7qXUxbdYqDNHON3BOn2Iv9d4K3Q
	 ToX236dKBxDWXrxYi3u1ZYfZyebf/lO4JEvpd2SlPdcWs+j7DLY8j4ff+pQPqyU0ep
	 /v8EHokHDc5ey6MrmKFAyyv0udALYq3WSYf8sb5xz3hgzgzaj+jah0oZ/xrNvqXOKe
	 E1jc2DOh79mg7DLMWpGKj2hIwQ0AIJEaZEdH4FUtfpG4fQn92vpbIU0y8tPvhM06I3
	 ts8zP3iqGKLqGCOj+guKfsQ9mZJXnQGNsVThNjABfbLbbw7bVEwkgnqGq2/2E5oMox
	 VErrenF+RMoAQ==
Authentication-Results: mail.redxen.eu;
	auth=pass smtp.auth=caskd smtp.mailfrom=caskd@redxen.eu
Date: Sun, 27 Aug 2023 07:35:17 +0000
To: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>
Cc: netdev@vger.kernel.org
Subject: Re: IPv6 multicast and snooping on bridges
From: caskd <caskd@redxen.eu>
References: <2GFL0JKN91JCI.2BNDSFI1J4DTV@unix.is.love.unix.is.life>
In-Reply-To: <2GFL0JKN91JCI.2BNDSFI1J4DTV@unix.is.love.unix.is.life>
Message-Id: <3A0UPE856X8FP.2IUCPPEM7A2R3@unix.is.love.unix.is.life>
User-Agent: mblaze/20220328-3140-g8658ea6aef
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello everyone,

> How to reproduce:=0D
>=20=0D
> - Create a bridge=0D
> - Activate multicast snooping=0D
> - Assign a address to the bridge=0D
> - Watch multicast database (especially the ones with the device and port =
both being the bridge)=0D
> - Wait 5-10 minutes (i wasn't able to pinpoint a exact interval but it us=
ually happens in this timeframe)=0D
>=20=0D
> During the waiting timeframe the interface's own host groups should disap=
pear from the bridge's database, resulting in the bridge not accepting any =
more packets for it's own group.=0D
>=20=0D
> Is this intended behaviour? It would seem like the interface can be used =
as a "switch-port" itself instead of configuring a dummy interface to be a =
part of the bridge, as it behaves correctly except for this one case. This =
isn't a problem in the IPv4 world but creates routing problems in the IPv6 =
world. If it is, could this be documented somewhere?=0D

After some futher investigation, i noticed i can only replicate this when t=
here is a VLAN interface as part of the bridge that is up. As soon as the i=
nterface goes up, it takes a bit and then the entries get deleted. I can re=
plicate this on 6.4 just fine while i cannot replicate it in 5.19, so it se=
ems to be something that used to work and broke during this period. I will =
build older kernels and try to pinpoint the breaking change(s).

--=20
Alex D.
RedXen System & Infrastructure Administration
https://redxen.eu/

