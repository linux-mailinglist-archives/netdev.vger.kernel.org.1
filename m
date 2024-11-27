Return-Path: <netdev+bounces-147617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00D9DAB08
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 16:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1293B164215
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 15:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB720010F;
	Wed, 27 Nov 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFINXRmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836C1FF7B6
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722634; cv=none; b=qprd4EISCZJDqOwn7R6uaUtLuKNJe9CCnLOOyviAbKvrk23wk4ozdLYkNMFPnnaUsyWIoFCLQaAM/MSdDnWzCAsvqYMxg2MYldsWoJu4NFe2FiA5hqNp0UmaSIGkCuNqMYjnC3PHxbLZkrIS1djC+dnws6gyh8hKQFhsdW0Kyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722634; c=relaxed/simple;
	bh=BGBbuZ/skHFcptvs9wLVWKp1f+epoYO3ACL2/oyI6/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGlLUPxDwBBI3ylFNZACLtX8JBJlePWDpVlLUdIJXEuYdK2uqPaa/1hmfbf581dbQq4jI9pLyCWlgLNfcrXtrE5POBnQfA9crsScaXfCiM+ytLVW6t0jiJoWSwSownsJQoGsuALNbE7BeCc6M7DcUmf3KHRJOsvfrxvhtb4pq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFINXRmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE11C4CED2;
	Wed, 27 Nov 2024 15:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732722634;
	bh=BGBbuZ/skHFcptvs9wLVWKp1f+epoYO3ACL2/oyI6/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eFINXRmrcLM1oe4ZdgqqxH8dNtTQKatsbaxncLFkNj1h9zwWiQ7KpNyRXo78zuDYX
	 ic/CDFlhPgfHjHIYR66qjN2Wdr6fIvlRblqDNx7Eg9+0wyee0vHprfNnPB+e8KnedR
	 FM+C7wMdsovF1ZsdYkAGsJr0NE4gRYWm8NOrrRFttCNW0KnAW/qoPTzpWrM73pI0Q9
	 jzPcejh3AUpZh/QC+bAlfJzEJpySZzCztgPEZNsVDnxRCGf0ApBXSLIvdN8LJNaGkL
	 EZCrU9xrkZ0Vm6gHe3HBeMCJ6QfrP+WJiMlZm+wn2/+jXnVZIAyC3U7e7JsmIR5D8g
	 /ocRAGQ3HAhgg==
Message-ID: <40d6550a-3246-490a-87ac-1f8e3eba3d98@kernel.org>
Date: Wed, 27 Nov 2024 08:50:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: Fix icmp host relookup triggering ip_rt_bug
Content-Language: en-US
To: Dong Chenchen <dongchenchen2@huawei.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 herbert@gondor.apana.org.au, steffen.klassert@secunet.com
Cc: netdev@vger.kernel.org, yuehaibing@huawei.com, zhangchangzhong@huawei.com
References: <20241127040850.1513135-1-dongchenchen2@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241127040850.1513135-1-dongchenchen2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/26/24 9:08 PM, Dong Chenchen wrote:
> arp link failure may trigger ip_rt_bug while xfrm enabled, call trace is:
> 
> WARNING: CPU: 0 PID: 0 at net/ipv4/route.c:1241 ip_rt_bug+0x14/0x20
> Modules linked in:
> CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.12.0-rc6-00077-g2e1b3cc9d7f7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> RIP: 0010:ip_rt_bug+0x14/0x20
> Call Trace:
>  <IRQ>
>  ip_send_skb+0x14/0x40
>  __icmp_send+0x42d/0x6a0
>  ipv4_link_failure+0xe2/0x1d0
>  arp_error_report+0x3c/0x50
>  neigh_invalidate+0x8d/0x100
>  neigh_timer_handler+0x2e1/0x330
>  call_timer_fn+0x21/0x120
>  __run_timer_base.part.0+0x1c9/0x270
>  run_timer_softirq+0x4c/0x80
>  handle_softirqs+0xac/0x280
>  irq_exit_rcu+0x62/0x80
>  sysvec_apic_timer_interrupt+0x77/0x90
> 
> The script below reproduces this scenario:
> ip xfrm policy add src 0.0.0.0/0 dst 0.0.0.0/0 \
> 	dir out priority 0 ptype main flag localok icmp
> ip l a veth1 type veth
> ip a a 192.168.141.111/24 dev veth0
> ip l s veth0 up
> ping 192.168.141.155 -c 1
> 
> icmp_route_lookup() create input routes for locally generated packets
> while xfrm relookup ICMP traffic.Then it will set input route
> (dst->out = ip_rt_bug) to skb for DESTUNREACH.
> 
> For ICMP err triggered by locally generated packets, dst->dev of output
> route is loopback. Generally, xfrm relookup verification is not required
> on loopback interfaces (net.ipv4.conf.lo.disable_xfrm = 1).
> 
> Skip icmp relookup for locally generated packets to fix it.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
> v3: avoid the expensive call to  inet_addr_type_dev_table()
> and addr_type variable suggested by Eric
> v2: Skip icmp relookup to fix bug
> ---
>  net/ipv4/icmp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 4f088fa1c2f2..963a89ae9c26 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -517,6 +517,9 @@ static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
>  	if (!IS_ERR(dst)) {
>  		if (rt != rt2)
>  			return rt;
> +		if (inet_addr_type_dev_table(net, route_lookup_dev,
> +					     fl4->daddr) == RTN_LOCAL)
> +			return rt;
>  	} else if (PTR_ERR(dst) == -EPERM) {
>  		rt = NULL;
>  	} else {

Reviewed-by: David Ahern <dsahern@kernel.org>


