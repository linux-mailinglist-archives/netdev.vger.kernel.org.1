Return-Path: <netdev+bounces-32107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2585792441
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16B461C2042F
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F14D537;
	Tue,  5 Sep 2023 15:57:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F52D535
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 15:57:45 +0000 (UTC)
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE712A
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:57:44 -0700 (PDT)
Message-ID: <5e06cdbc-b3aa-3809-5e47-6d92e5c4274e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693929459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYd3qVIakEj91Zg/GHolPlzu7QHDMPsltlgq1lem4h4=;
	b=akF07PYn5wewNMe12bQ3DbYD/Hb1xP+G2O5oUMCC1Ge5lVPaUZNKTl49zMioHtu+zJJCIb
	YrzaqaQ9SbMLqo2WW2/a97kmvMxYCWwzK573A8LpInwQ2h3Qbtu68XkBiKsCGScYg6sEda
	gUPHaWp3cGLTK/xPPyfSovjYqwVq0fY=
Date: Tue, 5 Sep 2023 23:57:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: ipv4: fix one memleak in __inet_del_ifa()
To: Liu Jian <liujian56@huawei.com>, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, hadi@cyberus.ca,
 netdev@vger.kernel.org
References: <20230905135554.1958156-1-liujian56@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230905135554.1958156-1-liujian56@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/9/5 21:55, Liu Jian 写道:
> I got the below warning when do fuzzing test:
> unregister_netdevice: waiting for bond0 to become free. Usage count = 2
> 
> It can be repoduced via:
> 
> ip link add bond0 type bond
> sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
> ip addr add 4.117.174.103/0 scope 0x40 dev bond0
> ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
> ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
> ip addr del 4.117.174.103/0 scope 0x40 dev bond0
> ip link delete bond0 type bond
> 
> In this reproduction test case, an incorrect 'last_prim' is found in
> __inet_del_ifa(), as a result, the secondary address(0.0.0.4/0 scope 0x40)
> is lost. The memory of the secondary address is leaked and the reference of
> in_device and net_device is leaked.
> 
> Fix this problem by modifying the PROMOTE_SECONDANCE behavior as follows:
> 1. Traverse in_dev->ifa_list to search for the actual 'last_prim'.
> 2. When last_prim is empty, move 'promote' to the in_dev->ifa_list header.
> 
> Fixes: 0ff60a45678e ("[IPV4]: Fix secondary IP addresses after promotion")
> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
>   net/ipv4/devinet.c | 26 ++++++++++++++++++++------
>   1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 9cf64ee47dd2..99278f4b58e0 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -355,14 +355,13 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   {
>   	struct in_ifaddr *promote = NULL;
>   	struct in_ifaddr *ifa, *ifa1;
> -	struct in_ifaddr *last_prim;
> +	struct in_ifaddr *last_prim = NULL;
>   	struct in_ifaddr *prev_prom = NULL;
>   	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
>   
>   	ASSERT_RTNL();
>   
>   	ifa1 = rtnl_dereference(*ifap);
> -	last_prim = rtnl_dereference(in_dev->ifa_list);
>   	if (in_dev->dead)
>   		goto no_promotions;
>   
> @@ -371,7 +370,16 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   	 **/
>   
>   	if (!(ifa1->ifa_flags & IFA_F_SECONDARY)) {
> -		struct in_ifaddr __rcu **ifap1 = &ifa1->ifa_next;
> +		struct in_ifaddr __rcu **ifap1 = &in_dev->ifa_list;
> +
> +		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {

while ((ifa = rtnl_dereference(*ifap1))) should be enough.

Zhu Yanjun

> +			if (ifa1 == ifa)
> +				break;
> +			last_prim = ifa;
> +			ifap1 = &ifa->ifa_next;
> +		}
> +
> +		ifap1 = &ifa1->ifa_next;
>   
>   		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
>   			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
> @@ -440,9 +448,15 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   
>   			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
>   
> -			last_sec = rtnl_dereference(last_prim->ifa_next);
> -			rcu_assign_pointer(promote->ifa_next, last_sec);
> -			rcu_assign_pointer(last_prim->ifa_next, promote);
> +			if (last_prim) {
> +				last_sec = rtnl_dereference(last_prim->ifa_next);
> +				rcu_assign_pointer(promote->ifa_next, last_sec);
> +				rcu_assign_pointer(last_prim->ifa_next, promote);
> +			} else {
> +				rcu_assign_pointer(promote->ifa_next,
> +						   rtnl_dereference(in_dev->ifa_list));
> +				rcu_assign_pointer(in_dev->ifa_list, promote);
> +			}
>   		}
>   
>   		promote->ifa_flags &= ~IFA_F_SECONDARY;


