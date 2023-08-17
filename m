Return-Path: <netdev+bounces-28384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D577F462
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC90281EC7
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F09D314;
	Thu, 17 Aug 2023 10:38:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA068492
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 10:38:48 +0000 (UTC)
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF952D6D
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:38:46 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <n0-1@orbyte.nwl.cc>)
	id 1qWaOo-00081c-Bb; Thu, 17 Aug 2023 12:38:42 +0200
Date: Thu, 17 Aug 2023 12:38:42 +0200
From: Phil Sutter <phil@nwl.cc>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zhengchao Shao <shaozhengchao@huawei.com>
Subject: Re: [PATCH net] selftests: bonding: do not set port down before
 adding to bond
Message-ID: <ZN34sjMg+SkG4Yz+@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zhengchao Shao <shaozhengchao@huawei.com>
References: <20230817082459.1685972-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817082459.1685972-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 04:24:59PM +0800, Hangbin Liu wrote:
> Before adding a port to bond, it need to be set down first. In the
> lacpdu test the author set the port down specifically. But commit
> a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> changed the operation order, the kernel will set the port down _after_
> adding to bond. So all the ports will be down at last and the test failed.
> 
> In fact, the veth interfaces are already inactive when added. This
> means there's no need to set them down again before adding to the bond.
> Let's just remove the link down operation.
> 
> Reported-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Closes: https://lore.kernel.org/netdev/a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com/
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> PS: I'm not sure if this should be a regression of a4abfa627c38.

Well, in theory it might be as ip-link's behaviour changed in this
detail. Yet:

> -ip link set veth1-bond down master fbond

Without prior knowledge of kernel interna[1], one would expect this
command to result in veth1-bond being enslaved and down, irrespective of
in which order the link changes happen.

The command my patch enables, namely:

| ip link set veth1-bond up master fbond

is actually intuitive. OK, it won't work if veth1-bond is up already.
But I guess that's rather a missing feature (bridge driver supports it
for instance).

Cheers, Phil

[1] - link-state change happens before master assignment
    - bond driver "ups" newly attached ports

