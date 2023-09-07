Return-Path: <netdev+bounces-32471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CAC797B9F
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C011C20B55
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8AB14003;
	Thu,  7 Sep 2023 18:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22D134DD
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:22:15 +0000 (UTC)
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777B9B9
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 11:22:08 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 634241CE0E;
	Thu,  7 Sep 2023 08:57:05 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
	by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 493AC1CE0D;
	Thu,  7 Sep 2023 08:57:05 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by ink.ssi.bg (Postfix) with ESMTPSA id 256643C0439;
	Thu,  7 Sep 2023 08:57:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
	t=1694066223; bh=Nr7L0X1CSqRwD5JbJ86atDo045oNSIx4pVamgZyf6ms=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=cI9JbXJCBw+dR69f6fJXvkPYnQMhHomz26vqUaPvKp/u6X3+dnz7qP2y2owCoXwe6
	 ohKMo+VrisIYKsDSW2hF3bKydcnVJ09Wq1cRdAuUpru63+Ar/x0n82R6wvABuR6Pw6
	 jqoKJJVuZe4noqvGmooc+hGP9+NfsMKGCRi9CDiM=
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 3875urGA005192;
	Thu, 7 Sep 2023 08:56:54 +0300
Date: Thu, 7 Sep 2023 08:56:53 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Liu Jian <liujian56@huawei.com>
cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hadi@cyberus.ca,
        netdev@vger.kernel.org
Subject: Re: [PATCH net v2] net: ipv4: fix one memleak in __inet_del_ifa()
In-Reply-To: <20230907025709.3409515-1-liujian56@huawei.com>
Message-ID: <a52a9eed-decf-d180-5c7a-8da41b82cf23@ssi.bg>
References: <20230907025709.3409515-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


	Hello,

On Thu, 7 Sep 2023, Liu Jian wrote:

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
> Fix this problem:
> Look for 'last_prim' starting at location of the deleted IP and inserting
> the promoted IP into the location of 'last_prim'.
> 
> Fixes: 0ff60a45678e ("[IPV4]: Fix secondary IP addresses after promotion")
> Signed-off-by: Liu Jian <liujian56@huawei.com>

	Looks good to me, thanks!

Signed-off-by: Julian Anastasov <ja@ssi.bg>

> ---
> v1->v2: Change the implementation to Julian's.
> 	The commit message is modified.
>  net/ipv4/devinet.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 9cf64ee47dd2..ca0ff15dc8fa 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -355,14 +355,14 @@ static void __inet_del_ifa(struct in_device *in_dev,
>  {
>  	struct in_ifaddr *promote = NULL;
>  	struct in_ifaddr *ifa, *ifa1;
> -	struct in_ifaddr *last_prim;
> +	struct in_ifaddr __rcu **last_prim;
>  	struct in_ifaddr *prev_prom = NULL;
>  	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
>  
>  	ASSERT_RTNL();
>  
>  	ifa1 = rtnl_dereference(*ifap);
> -	last_prim = rtnl_dereference(in_dev->ifa_list);
> +	last_prim = ifap;
>  	if (in_dev->dead)
>  		goto no_promotions;
>  
> @@ -376,7 +376,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
>  		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
>  			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
>  			    ifa1->ifa_scope <= ifa->ifa_scope)
> -				last_prim = ifa;
> +				last_prim = &ifa->ifa_next;
>  
>  			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
>  			    ifa1->ifa_mask != ifa->ifa_mask ||
> @@ -440,9 +440,9 @@ static void __inet_del_ifa(struct in_device *in_dev,
>  
>  			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
>  
> -			last_sec = rtnl_dereference(last_prim->ifa_next);
> +			last_sec = rtnl_dereference(*last_prim);
>  			rcu_assign_pointer(promote->ifa_next, last_sec);
> -			rcu_assign_pointer(last_prim->ifa_next, promote);
> +			rcu_assign_pointer(*last_prim, promote);
>  		}
>  
>  		promote->ifa_flags &= ~IFA_F_SECONDARY;
> -- 
> 2.34.1

Regards

--
Julian Anastasov <ja@ssi.bg>


