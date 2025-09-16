Return-Path: <netdev+bounces-223473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E787B59455
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097741B20F7F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5D92D061B;
	Tue, 16 Sep 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Oq/+pReo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EKkd/8xf"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035562C0260
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758019756; cv=none; b=rtwNIX0p7bHHEHTiwa98GWx+U1GqHpqD9aWtvJYm3SPuqgvbmQmF9f+3QPCw7MlOe8vCiKQbfwd0ExunBqGF9Gv6amOlDay+1V5OLvzTQSIzmyE+V5MGc6J5lH9YAW4fOto6DYqwIVNcWcbKD+Mku3XEycnsGuGckD8dDdzxeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758019756; c=relaxed/simple;
	bh=zfofnVit7UaoJJOJBVcBczeEYQOm39KLMtHO0d+/Gcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skyq06ub7og4+C0sEtKtyAVYl2TKxKTv8dvmmc0N8xpIYuXdUCVJCT7yAo7LE0t8xsfZmlZwBRaDzD99jaOTZ7BI2/0saJw7Y9mDL3yv2dfmoZRkGsnpkrmVSggtNhRN49zMksLThZEtc79Y0awpqz5YnNitUZOBcOaK4n3ujWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Oq/+pReo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EKkd/8xf; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A46E140026B;
	Tue, 16 Sep 2025 06:49:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 16 Sep 2025 06:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1758019753; x=
	1758106153; bh=jtE2sZrc5BsGYgirP+qIMiHYZnyG7yFufZXGvsKIWhc=; b=O
	q/+pReoE3PSK7GWkH37aukUhoaZKos7bedlsS2EXCf0LXCdeAIJY880DoOnWA7cq
	16YjFyM/dGlEkHeOydj/gBhOWn57YHqiILrBACOxTgUNqLrZ6GExoQqV0+16aCLt
	e0ZEh+7HGcEk81hjIvajThw4bKcHnUj5656btAyX61E6rb+bXzDj7c0LRi7crKYW
	JagNLUvxJ7UX3dM7S9pAQ2kHepkj9bpsNuRKml7emmLMQ2Dsjr+LKYl/NVtQZGsZ
	IvUC8b7fy8LZIaC51A/222yyU4x8LdH1F1jc8n8zVmCZRkrrQgNx8G7Ftterpe4l
	xJ4L20NLR6CwS5YixQehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758019753; x=1758106153; bh=jtE2sZrc5BsGYgirP+qIMiHYZnyG7yFufZX
	GvsKIWhc=; b=EKkd/8xfZwJ+IWHY2IUQhMX0hoKcdxQXquf6GD6aKynse7IOEtQ
	hAneoMzJo+SXZ/qHoHPxLFYFJyXJ148PZfUZanO7wAgQtPyTifxpyJehA14a9vSf
	0GIxKTSwKdRzxitHJDwTk4Ti0QMu5sKCyym+mfwAI9f3r9/hGtpzphaEiPXH9zFM
	9bYOxHDFoBrxm/9TEHWHH/Z4WXa8BEkvatOxn9mma8RKOvuyRwPuL05gH/tKMEBF
	LqPEUw7vXzVxdHsCVOhltNDRU/1BSVlPceSUcjDLDSZTMNfbrPdX5w8qQSfIt7dG
	BS04RfnlcTLINfGMq2Rt7swxeir6Bn5DwUw==
X-ME-Sender: <xms:qEDJaO8tG1KCI1K2U6-QWhQt_7CjtefYzuesIoVdyXFg3_gJ7IU1cQ>
    <xme:qEDJaL0FQTAGQTzF_3Fe3Esbx4drPZwXTPNTRKpn4OCd2K7TkyddWFnYsz8-2zQY6
    UadnPrS0Y0epiLw4jA>
X-ME-Received: <xmr:qEDJaDCZDytfgOSd2JH76M8n8-qFnBacDzntg0MPvWwXzG2ciydKWxoRkIsj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtdefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeejkeelveelkeefgfeuheevjeeukedvhedvueegvdekleeghfelgeeiveff
    tdeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhhmihgvthhusheljeeshigrhhhoohdrtghomh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegrnhhtohhnihhosehophgvnhhvphhnrdhnvghtpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehophgvnhhvphhnqdguvghvvghlsehlihhs
    thhsrdhsohhurhgtvghfohhrghgvrdhnvght
X-ME-Proxy: <xmx:qEDJaHehvodUkR0lMj1vFq6Ug6jfft2DINkZKf_bJ1wTHpivnTr_Lg>
    <xmx:qEDJaA7rYBSBoFj5yUUKPU7C2szcBq3irreL6pjX5JxIOwjKkx0Jjg>
    <xmx:qEDJaKUDHt4LEL4pv9KyV5K8Ze9ZuWQwKRVp9JhS9dlcVng8YCf0kQ>
    <xmx:qEDJaP46F-AvLF-HmMnFtO9Zvu7vCFxQGXp_HYH3RJYMT07F6N-tPw>
    <xmx:qUDJaNFnzw9gxXh7gRY19CaL8VPLcOMWt5nDbDt3yJH235qY-DIlWsOd>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 06:49:12 -0400 (EDT)
Date: Tue, 16 Sep 2025 12:49:10 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Marek Mietus <mmietus97@yahoo.com>
Cc: netdev@vger.kernel.org, antonio@openvpn.net, kuba@kernel.org,
	openvpn-devel@lists.sourceforge.net
Subject: Re: [PATCH net-next v2 3/3] net: ovpn: use new noref xmit flow in
 ovpn_udp4_output
Message-ID: <aMlApjuzBJsHVMjN@krikkit>
References: <20250912112420.4394-1-mmietus97@yahoo.com>
 <20250912112420.4394-4-mmietus97@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250912112420.4394-4-mmietus97@yahoo.com>

2025-09-12, 13:24:20 +0200, Marek Mietus wrote:
> ovpn_udp4_output unnecessarily references the dst_entry from the
> dst_cache.

This should probably include a description of why it's safe to skip
the reference in this context.

> Reduce this overhead by using the newly implemented
> udp_tunnel_xmit_skb_noref function and dst_cache helpers.
> 
> Signed-off-by: Marek Mietus <mmietus97@yahoo.com>
> ---
>  drivers/net/ovpn/udp.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index d6a0f7a0b75d..c5d289c23d2b 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -158,7 +158,7 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>  	int ret;
>  
>  	local_bh_disable();
> -	rt = dst_cache_get_ip4(cache, &fl.saddr);
> +	rt = dst_cache_get_ip4_rcu(cache, &fl.saddr);
>  	if (rt)
>  		goto transmit;
>  
> @@ -194,12 +194,12 @@ static int ovpn_udp4_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>  				    ret);
>  		goto err;
>  	}
> -	dst_cache_set_ip4(cache, &rt->dst, fl.saddr);
> +	dst_cache_steal_ip4(cache, &rt->dst, fl.saddr);
>  
>  transmit:
> -	udp_tunnel_xmit_skb(rt, sk, skb, fl.saddr, fl.daddr, 0,
> -			    ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
> -			    fl.fl4_dport, false, sk->sk_no_check_tx, 0);
> +	udp_tunnel_xmit_skb_noref(rt, sk, skb, fl.saddr, fl.daddr, 0,
> +				  ip4_dst_hoplimit(&rt->dst), 0, fl.fl4_sport,
> +				  fl.fl4_dport, false, sk->sk_no_check_tx, 0);
>  	ret = 0;
>  err:
>  	local_bh_enable();
> @@ -269,7 +269,7 @@ static int ovpn_udp6_output(struct ovpn_peer *peer, struct ovpn_bind *bind,
>  	 * fragment packets if needed.
>  	 *
>  	 * NOTE: this is not needed for IPv4 because we pass df=0 to
> -	 * udp_tunnel_xmit_skb()
> +	 * udp_tunnel_xmit_skb_noref()
>  	 */
>  	skb->ignore_df = 1;
>  	udp_tunnel6_xmit_skb(dst, sk, skb, skb->dev, &fl.saddr, &fl.daddr, 0,

Why are you changing only ipv4? Is there something in the ipv6 code
that prevents this?

-- 
Sabrina

