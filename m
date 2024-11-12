Return-Path: <netdev+bounces-143931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63E9C4C3E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727C228A489
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F56204020;
	Tue, 12 Nov 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="aerelTLL"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CA433BE
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377426; cv=none; b=F2GgsyrAX1CYLiYRe/c0cc81tIuXLlOykrWK73CJITk7i9zJk8yEILvLf1DTFoTxdUqx5HLzafKxcf6Z8oHe3aGuwjJ/LkgiI8gerJEkxYwg6WlzGDNYu9qAcZr+AHWKiD1dcPPWXDKOndfaq6gqYR4qt6YRDHytOEhNbj5OZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377426; c=relaxed/simple;
	bh=Ivjmfehp21sJoOOTkDQKnovhf/CBif5FZeQ1rJTkvss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa9y94iaM43Y1TfsWtWjFMriPg40xTv4jVbhhiUuX/LoNbMEYFzOm98YjNferO1ttPnEqpmXL0r13Rfzq6RiIvRwdFYYQinOekpH0nUJBVMAA26djUuHGrVYqjtSDLw3gFYbn1SUnYOqsGmYu5+ryUPnxW5q2hO2Z7INHHjD5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=aerelTLL; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=taHJuz6JJ0iMeh2D3a7DTBHgPLCQhVvmKimv/h/JEy4=; b=aerelTLL07K2jJHNVI+QHS6Xji
	DYA8IajIOLFXVSufLSknqbCaGadu2RWRyk4XGxrVlbCH/OJCDkJnjnZ8hPd+M5GTjrg1S2sgfCb/e
	6bqpEvWxfNX+vVqPiUgWl8HHOcst9cdX4jv8Wi9IOJxu+Dx8B6oV5oe3S67N1TnrxmpXhZ3zNlogP
	weyW/xDfZxHEBBi0xuQhqb1himJWx8B+pcGBMUtqGqxi8aTE3kc1ZZh3snGXZp00b5hLXdAFR8d2i
	xnqAlN5pjlbCa9F3/qmMB1Wqt65N/rXfRanC4l1GJRZ1Ulle5jrVBsna7u3cFt9Oz0I+3SeogHNwX
	ORvGQQ+g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tAgM7-00G8Aq-2i;
	Tue, 12 Nov 2024 10:10:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Nov 2024 10:10:11 +0800
Date: Tue, 12 Nov 2024 10:10:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
Message-ID: <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
References: <20241111123915.3879488-1-dongchenchen2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111123915.3879488-1-dongchenchen2@huawei.com>

On Mon, Nov 11, 2024 at 08:39:15PM +0800, Dong Chenchen wrote:
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
> Similar to commit ed6e4ef836d4("netfilter: Fix ip_route_me_harder
> triggering ip_rt_bug"), avoid creating input routes with
> icmp_route_lookup() to fix it.
> 
> Fixes: 8b7817f3a959 ("[IPSEC]: Add ICMP host relookup support")
> Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
> ---
>  net/ipv4/icmp.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e1384e7331d8..11ef4eb5b659 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -490,6 +490,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  	struct dst_entry *dst, *dst2;
>  	struct rtable *rt, *rt2;
>  	struct flowi4 fl4_dec;
> +	unsigned int addr_type;
>  	int err;
>  
>  	memset(fl4, 0, sizeof(*fl4));
> @@ -528,31 +529,15 @@ static struct rtable *icmp_route_lookup(struct net *net,
>  	if (err)
>  		goto relookup_failed;
>  
> -	if (inet_addr_type_dev_table(net, route_lookup_dev,
> -				     fl4_dec.saddr) == RTN_LOCAL) {
> -		rt2 = __ip_route_output_key(net, &fl4_dec);
> -		if (IS_ERR(rt2))
> -			err = PTR_ERR(rt2);
> -	} else {

So you're saying that your packet triggered the else branch?

That I think is the bug here, not the input route lookup which
is the whole purpose of the original patch (simulate an input route
lookup in order to determine the correct policy).

AFAIK the packet that triggered the crash has a source address
of 192.168.141.111, which should definitely be local.  So why
is the RTN_LOCAL check failing?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

