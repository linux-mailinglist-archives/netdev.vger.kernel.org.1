Return-Path: <netdev+bounces-106188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0491525C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC4B1C20A2B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2D19D08E;
	Mon, 24 Jun 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="sNR5+Buv"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACB143743
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242948; cv=none; b=urjFjeBu3iCfQNzV0QQCcTnqy1JL+L9O+EuHDODK9gyazLbQAGQwbp1+1Bw2NLOF3X7be8qGu6a5+8/483R0OwIbNaJmfhzsn3vlpdpKOsiSzJF5fx33nEQYeuBg6OyeLLR0yZAJy6sP0xisXLxzQg5oRjJSKxepYrTx5pTJpQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242948; c=relaxed/simple;
	bh=EtEPfXihmnjNTaoDFa0DQ3qMcMUH9iQWmG8yqt8q7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjpNBCgQAL5HMpyu+daO/O7PqiduZ5NipzFAtYCwW1gOst+cHq4WOhMcSz6DYO0fOcLYObETKalcc9vA49HqR8f94R6jT5t6QkyFlrxhQwfJmKx/OZdzY7dPQz+X1kl8NenpgT+IJu9ATqDp0Rp2XC5tO60EKJKGL1bRlfFbGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=sNR5+Buv; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 53862cf6-323e-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 53862cf6-323e-11ef-836c-005056aba152;
	Mon, 24 Jun 2024 17:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=BvqYwY/FaSlrXXF68kEI95/y0gu1tYuFDSBsNXke4rM=;
	b=sNR5+BuvA1oXZyxKd72lBgFfNYFpXFlKEYOX18A9I6/gh1ze28a7QUg1QNmhKnyzkhy1na1VpjKoE
	 +W8HpyQqFisFYAQZxq6cRiZlWHL313KpC6jMormcVKajrnC37cb42vIHoEVul3UqRcLDLWf4n5Dpvx
	 u9ZfX4dDCPSV0zko=
X-KPN-MID: 33|Iro28UabrHI28KnT2R7zuf948ZxCw14OdqIEW9MS5stmSYTJ+YTxUyCGjmsOMQo
 DtgzihyWeYhXGQdAGupR0mWX9KPa1ZxAHnX8LRlC1SV4=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|CqV3Xyg8VWFlqkwtfhzizMQ4NtbRRygE4oKSRlvIeDJtyfHh4y6W3OQiHAj9/jH
 kmMMGr0rWWQFNjcrdDXtBOA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 5343b57a-323e-11ef-8146-005056ab1411;
	Mon, 24 Jun 2024 17:27:55 +0200 (CEST)
Date: Mon, 24 Jun 2024 17:27:53 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v4 17/18] xfrm: iptfs: only send
 the NL attrs that corr. to the SA dir
Message-ID: <ZnmQeZVYDC8rKLEe@Antony2201.local>
References: <20240617205316.939774-1-chopps@chopps.org>
 <20240617205316.939774-18-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617205316.939774-18-chopps@chopps.org>

On Mon, Jun 17, 2024 at 04:53:15PM -0400, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> When sending the netlink attributes to the user for a given SA, only
> send those NL attributes which correspond to the SA's direction.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 64 ++++++++++++++++++++++++-------------------
>  1 file changed, 36 insertions(+), 28 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 59fd8ee49cd4..049a94a5531b 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -2498,13 +2498,16 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>  	unsigned int l = 0;
>  
> -	if (xc->dont_frag)
> -		l += nla_total_size(0);
> -	l += nla_total_size(sizeof(xc->reorder_win_size));
> -	l += nla_total_size(sizeof(xc->pkt_size));
> -	l += nla_total_size(sizeof(xc->max_queue_size));
> -	l += nla_total_size(sizeof(u32)); /* drop time usec */
> -	l += nla_total_size(sizeof(u32)); /* init delay usec */
> +	if (x->dir == XFRM_SA_DIR_IN) {
> +		l += nla_total_size(sizeof(u32)); /* drop time usec */
> +		l += nla_total_size(sizeof(xc->reorder_win_size));
> +	} else {
> +		if (xc->dont_frag)
> +			l += nla_total_size(0);	  /* dont-frag flag */
> +		l += nla_total_size(sizeof(u32)); /* init delay usec */
> +		l += nla_total_size(sizeof(xc->max_queue_size));
> +		l += nla_total_size(sizeof(xc->pkt_size));
> +	}
>  
>  	return l;
>  }
> @@ -2516,30 +2519,35 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>  	int ret;
>  	u64 q;
>  
> -	if (xc->dont_frag) {
> -		ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
> +	if (x->dir == XFRM_SA_DIR_IN) {
> +		q = xtfs->drop_time_ns;
> +		(void)do_div(q, NSECS_IN_USEC);
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
> +		if (ret)
> +			return ret;
> +
> +		ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW,
> +				  xc->reorder_win_size);
> +	} else {
> +		if (xc->dont_frag) {
> +			ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		q = xtfs->init_delay_ns;
> +		(void)do_div(q, NSECS_IN_USEC);
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
> +		if (ret)
> +			return ret;
> +
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE,
> +				  xc->max_queue_size);
>  		if (ret)
>  			return ret;
> +
> +		ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
>  	}
> -	ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, xc->reorder_win_size);
> -	if (ret)
> -		return ret;
> -	ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
> -	if (ret)
> -		return ret;
> -	ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, xc->max_queue_size);
> -	if (ret)
> -		return ret;
> -
> -	q = xtfs->drop_time_ns;
> -	(void)do_div(q, NSECS_IN_USEC);
> -	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, q);
> -	if (ret)
> -		return ret;
> -
> -	q = xtfs->init_delay_ns;
> -	(void)do_div(q, NSECS_IN_USEC);
> -	ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, q);
>  
>  	return ret;
>  }

looking at this patch, why this should be seperate patch? why not squash 
into [PATCH ipsec-next v4 08/18] xfrm: iptfs: add new iptfs xfrm mode impl

I also think in the v3 it was squashed into some other patch.

-antony

