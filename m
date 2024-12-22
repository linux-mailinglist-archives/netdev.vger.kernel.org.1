Return-Path: <netdev+bounces-153966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F779FA52E
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 11:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B3516651C
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6E18A6A3;
	Sun, 22 Dec 2024 10:10:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23608189BAC
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734862231; cv=none; b=boybrStv/B7Mz1c0LnWR+QTIYbc+W+VfDNgUloWw10YpDAegba0ipktuxBLi2AI2b6Al7EakzqMahLZHaAdM662g5wHhv/r9AN5gybSMtgoOpQ/qTufPzP3G0LAhJuqn/rIgthkQepY7i+H/nPUeS0hfrMYuVldCCxZxtq5HP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734862231; c=relaxed/simple;
	bh=7cxod7YMtFZbl1nd7C03CZeqcHCX9KD/Uj/6Ti5dt2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtx/Sw6RSVubto+Y4S5DC8JUX9HRNPsvdqsqYsUtFlurAAfdtgCq5A6cgwKgddm+rEnyHE3Quh4c0L+wiAYSG2PvB/fRfqIys4ukW5CCmZ9tIbkiybKV+FloLEKPl45GlUkFK6LOrR/wsaFisCmfTQL3v8XRDs12XMniRIWEmBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Sun, 22 Dec 2024 11:10:25 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	stephen@networkplumber.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, kuba@kernel.org, yanan@huawei.com,
	caowangbao@huawei.com, fengtao40@huawei.com
Subject: Re: [PATCH] vrf: Revert:"run conntrack only in context of
 lower/physdev for locally generated packets"
Message-ID: <Z2flkWyQNwiClcUg@calendula>
References: <20241221113308.1003995-1-hanhuihui5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241221113308.1003995-1-hanhuihui5@huawei.com>

Hi,

On Sat, Dec 21, 2024 at 07:33:08PM +0800, hanhuihui wrote:
> In commit 8e0538d8, netfilter skips the NAT hook in the VRF context. This solves the problems mentioned in commit 
> in 8c9c296 and d43b75f. Therefore, we no longer need to set "untracked" to avoid any conntrack 
> participation in round 1.So maybe we can reverts commit 8c9c296a and d43b75fb because we don't need them now.

Did you run netfilter selftests?

> Fixes: 8c9c296 ("vrf: run conntrack only in context of lower/physdev for locally generated packets")
> Fixes: d43b75f ("vrf: don't run conntrack on vrf with !dflt qdisc")

These tags do not look fine.

Thanks.

> Signed-off-by: hanhuihui hanhuihui5@huawei.com
> ---
>  drivers/net/vrf.c | 28 ++++------------------------
>  1 file changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> index b90dccdc2..7b0c35003 100644
> --- a/drivers/net/vrf.c
> +++ b/drivers/net/vrf.c
> @@ -36,7 +36,6 @@
>  #include <net/fib_rules.h>
>  #include <net/sch_generic.h>
>  #include <net/netns/generic.h>
> -#include <net/netfilter/nf_conntrack.h>
>  
>  #define DRV_NAME	"vrf"
>  #define DRV_VERSION	"1.1"
> @@ -416,26 +415,12 @@ static int vrf_local_xmit(struct sk_buff *skb, struct net_device *dev,
>  	return NETDEV_TX_OK;
>  }
>  
> -static void vrf_nf_set_untracked(struct sk_buff *skb)
> -{
> -	if (skb_get_nfct(skb) == 0)
> -		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
> -}
> -
> -static void vrf_nf_reset_ct(struct sk_buff *skb)
> -{
> -	if (skb_get_nfct(skb) == IP_CT_UNTRACKED)
> -		nf_reset_ct(skb);
> -}
> -
>  #if IS_ENABLED(CONFIG_IPV6)
>  static int vrf_ip6_local_out(struct net *net, struct sock *sk,
>  			     struct sk_buff *skb)
>  {
>  	int err;
>  
> -	vrf_nf_reset_ct(skb);
> -
>  	err = nf_hook(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net,
>  		      sk, skb, NULL, skb_dst(skb)->dev, dst_output);
>  
> @@ -514,8 +499,6 @@ static int vrf_ip_local_out(struct net *net, struct sock *sk,
>  {
>  	int err;
>  
> -	vrf_nf_reset_ct(skb);
> -
>  	err = nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT, net, sk,
>  		      skb, NULL, skb_dst(skb)->dev, dst_output);
>  	if (likely(err == 1))
> @@ -633,7 +616,8 @@ static void vrf_finish_direct(struct sk_buff *skb)
>  		skb_pull(skb, ETH_HLEN);
>  	}
>  
> -	vrf_nf_reset_ct(skb);
> +	/* reset skb device */
> +	nf_reset_ct(skb);
>  }
>  
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -647,7 +631,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
>  	struct neighbour *neigh;
>  	int ret;
>  
> -	vrf_nf_reset_ct(skb);
> +	nf_reset_ct(skb);
>  
>  	skb->protocol = htons(ETH_P_IPV6);
>  	skb->dev = dev;
> @@ -778,8 +762,6 @@ static struct sk_buff *vrf_ip6_out(struct net_device *vrf_dev,
>  	if (rt6_need_strict(&ipv6_hdr(skb)->daddr))
>  		return skb;
>  
> -	vrf_nf_set_untracked(skb);
> -
>  	if (qdisc_tx_is_default(vrf_dev) ||
>  	    IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED)
>  		return vrf_ip6_out_direct(vrf_dev, sk, skb);
> @@ -866,7 +848,7 @@ static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *s
>  	struct neighbour *neigh;
>  	bool is_v6gw = false;
>  
> -	vrf_nf_reset_ct(skb);
> +	nf_reset_ct(skb);
>  
>  	/* Be paranoid, rather than too clever. */
>  	if (unlikely(skb_headroom(skb) < hh_len && dev->header_ops)) {
> @@ -1009,8 +991,6 @@ static struct sk_buff *vrf_ip_out(struct net_device *vrf_dev,
>  	    ipv4_is_lbcast(ip_hdr(skb)->daddr))
>  		return skb;
>  
> -	vrf_nf_set_untracked(skb);
> -
>  	if (qdisc_tx_is_default(vrf_dev) ||
>  	    IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED)
>  		return vrf_ip_out_direct(vrf_dev, sk, skb);
> -- 
> 2.43.0
> 
> 

