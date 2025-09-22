Return-Path: <netdev+bounces-225346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B212B92790
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 19:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F348D444855
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37C3164DF;
	Mon, 22 Sep 2025 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbLtNcFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E944314D34
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563305; cv=none; b=H4aeeIDmF0yMA9dFshykdWv/mPa6/zDQEHCpy4iycizFbPuiksJb8UzkSCJnKEkGpPcNiIQsoq0fXMvjf5N11h9Ar8x2LdX3VC7aH90+q/zZVR5hTZPoP5zzl25M9JQAXIH1Biztktbb16e+cWtMhVNfdCCDY5mcsYVlAhXWo1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563305; c=relaxed/simple;
	bh=1w4FXAPOpO6lZePfVgvRDrGvKETBniGKn/1UgGH2E1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu9HoCDPDbiAjRCOiX/OYEKjL6eLwdz9+SYQVg0p5VzrKPJZQSzDB+CdkadU4RD+M6MCsYeTcDr+9lbaHjJu49GIpcVYkFxdAl78YW1Q1wkzXiwekAaLIOoNYeYnLCYxyybY/15vOi4cgX6V0ZCNsg0q+qJnxaJRKLGvdo+gtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbLtNcFA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24456ce0b96so52244305ad.0
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 10:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563303; x=1759168103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6i11OsMA+MsaYaarT5KCIEcTCRNZhOeBzabcsiYfVKs=;
        b=TbLtNcFATnbfXMZ7ZOXJ9Dvj+G8MXuN/4BtZy2FklojqYfFPLOUOkxPrPgkqUl6RN0
         gLFGoQCZ3OnA5MpTOQ2OgrZrbwuUyrMPdEbtUYjkn3OdApUobn6EL2c5+FF3n4AGECd+
         fnhX9ntkOwIoJkoGVB09y+oRbd6MwMme8we1SqPWryiqwHb8xyzQ2CSYVu8MQw7Yb4HZ
         dAsg3zBlfm0SsccJnTvw4yGbP/nHwOCfwMZHQPUTskDMYnWe2RvQERIBKdG+bbr4qGSo
         4vDsRaTvJJPHEDp4BZbNqC8JVyPT0oaVoudRtoxJ/3HtiMcKNm++fxeLzRJw18Bmo3F5
         cpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563303; x=1759168103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i11OsMA+MsaYaarT5KCIEcTCRNZhOeBzabcsiYfVKs=;
        b=QhCUZDd4EENhbHZzATXpCM2T+qlbopL+IBSqri2c5fOsljsfuxOPWOYJzSkWb2A/vA
         VYTJH00no83OCRV8uELyVAWASpAux9C2fcbQhEmTm3UwmKEulqWSg6D6+BOztrr1HuWV
         VjrIwUHPw0F5o+/B5P1bMbYgE4gdF6ePSvKPHgW0Kwo++fMFrupcP7FFQqwBK5BbC7Gd
         JC478m8fTPWK+02sMkzt5zUwbg0NI6weh1Y3TFIjHz/ovEnQbjj7bAu2vDdo7JxEKb+9
         7ri1AJH9O0/k64Tp7KN9z+mIprE7eCly7V1Q2e53Ib7azwN+aWxqZpDPx0bFXxgQ7xqO
         E8nA==
X-Forwarded-Encrypted: i=1; AJvYcCVw6AwNyX37w8SF4iQ/LCIYp1a4qE/Mfiw55je98g5O4MlSQ0EZAhqaMWFNlTkjB4tvNtNTxQI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlABEzzcqjzXnQwpOWFDBTJUqaF+WIK8RyB0Oz0tkp1tem3ZG
	sxLnJ7+Kz6oz2pkowaIfMoKk3F7PIy7/fUfmFczIHtGsVbRtjXHEBM4=
X-Gm-Gg: ASbGncvXgW+KNUXT2njlJpkteh3Jrv898gpF0lkijBTLtzf5+rVp9yaRpGAT2y4l/xh
	nf1oiQi6s5e46+kM0oUpyw960sns2yWAA2KmRO1ZMYbgw3+uo0J8SeYI7GMN1CfjsHS11moTJ2V
	VMHyeASCSc6Ujvf1USVHb4CvB/jeTOi+lHgiEAXaubAGlOHZu0AOjdfr/ModQkjxivm4Vl4Kgwr
	7OCgRzir8h19iVuI7oRgbb+SNhzmadPYDhFl303xMy4V2/smLqaol2PuHugVsyFHf4d7xDeJvvV
	zKdACcpCq/FzSj3g4wgXv+hNmd3qrSX+GUd1xYuMzGYdNlALabMRv/caM+LHnFyAdxHBCgy8CBW
	qZiBfR5Eae7wZdlj4KYJ5ihoRXPqPWYudF978OywEq/lmNLZ8sv+UVevoTnR4AtKtmCdRO6sQr5
	kvvZ3NlTNp46ndtf8Xhi1jlLOJY8x4jpodb51hZD/fhLDNHzxcoAsTUwqSgShP/w5gR9oGJ+/Jp
	cti
X-Google-Smtp-Source: AGHT+IHUDy0ZQufI3qCkAjkE0KSsNFLxHCvTa+GOcUP4Sluj+Gp0eJPhppj2B88gBhPgIcCi1FwgVQ==
X-Received: by 2002:a17:902:ce09:b0:267:c1ae:8f04 with SMTP id d9443c01a7336-269b92f5037mr139480765ad.20.1758563303003;
        Mon, 22 Sep 2025 10:48:23 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-269802dec24sm139429825ad.95.2025.09.22.10.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:48:22 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:48:22 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, netdev@vger.kernel.org,
	magnus.karlsson@intel.com, kerneljasonxing@gmail.com
Subject: Re: [PATCH bpf-next 2/3] xsk: remove @first_frag from xsk_build_skb()
Message-ID: <aNGL5qS8aIfcSDnD@mini-arch>
References: <20250922152600.2455136-1-maciej.fijalkowski@intel.com>
 <20250922152600.2455136-3-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250922152600.2455136-3-maciej.fijalkowski@intel.com>

On 09/22, Maciej Fijalkowski wrote:
> Devices that set IFF_TX_SKB_NO_LINEAR will not execute branch that
> handles metadata, as we set @first_frag only for !IFF_TX_SKB_NO_LINEAR
> code in xsk_build_skb().
> 
> Same functionality can be achieved with checking if xsk_get_num_desc()
> returns 0. To replace current usage of @first_frag with
> XSKCB(skb)->num_descs check, pull out the code from
> xsk_set_destructor_arg() that initializes sk_buff::cb and call it before
> skb_store_bits() in branch that creates skb against first processed
> frag. This so error path has the XSKCB(skb)->num_descs initialized and
> can free skb in case skb_store_bits() failed.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  net/xdp/xsk.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 72194f0a3fc0..064238400036 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -605,6 +605,13 @@ static u32 xsk_get_num_desc(struct sk_buff *skb)
>  	return XSKCB(skb)->num_descs;
>  }
>  
> +static void xsk_init_cb(struct sk_buff *skb)
> +{
> +	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> +	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> +	XSKCB(skb)->num_descs = 0;
> +}
> +
>  static void xsk_destruct_skb(struct sk_buff *skb)
>  {
>  	struct xsk_tx_metadata_compl *compl = &skb_shinfo(skb)->xsk_meta;
> @@ -620,9 +627,6 @@ static void xsk_destruct_skb(struct sk_buff *skb)
>  
>  static void xsk_set_destructor_arg(struct sk_buff *skb, u64 addr)
>  {
> -	BUILD_BUG_ON(sizeof(struct xsk_addr_head) > sizeof(skb->cb));
> -	INIT_LIST_HEAD(&XSKCB(skb)->addrs_list);
> -	XSKCB(skb)->num_descs = 0;
>  	skb_shinfo(skb)->destructor_arg = (void *)(uintptr_t)addr;
>  }
>  
> @@ -672,7 +676,7 @@ static struct sk_buff *xsk_build_skb_zerocopy(struct xdp_sock *xs,
>  			return ERR_PTR(err);
>  
>  		skb_reserve(skb, hr);
> -
> +		xsk_init_cb(skb);
>  		xsk_set_destructor_arg(skb, desc->addr);
>  	} else {
>  		xsk_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> @@ -725,7 +729,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	struct xsk_tx_metadata *meta = NULL;
>  	struct net_device *dev = xs->dev;
>  	struct sk_buff *skb = xs->skb;
> -	bool first_frag = false;
>  	int err;
>  
>  	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> @@ -742,8 +745,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		len = desc->len;
>  
>  		if (!skb) {
> -			first_frag = true;
> -
>  			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
>  			tr = dev->needed_tailroom;
>  			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
> @@ -752,6 +753,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  
>  			skb_reserve(skb, hr);
>  			skb_put(skb, len);
> +			xsk_init_cb(skb);
>  
>  			err = skb_store_bits(skb, 0, buffer, len);
>  			if (unlikely(err))
> @@ -797,7 +799,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
>  		}
>  
> -		if (first_frag && desc->options & XDP_TX_METADATA) {
> +		if (!xsk_get_num_desc(skb) && desc->options & XDP_TX_METADATA) {
>  			if (unlikely(xs->pool->tx_metadata_len == 0)) {
>  				err = -EINVAL;
>  				goto free_err;
> @@ -839,7 +841,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  	return skb;
>  
>  free_err:
> -	if (first_frag && skb)

[..]

> +	if (skb && !xsk_get_num_desc(skb))
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {

For IFF_TX_SKB_NO_LINEAR case, the 'goto free_err' is super confusing.
xsk_build_skb_zerocopy either returns skb or an IS_ERR. Can we
add a separate label to jump directly to 'if err == -EOVERFLOW' for
the IFF_TX_SKB_NO_LINEAR case?

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72e34bd2d925..f56182c61c99 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -732,7 +732,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 		skb = xsk_build_skb_zerocopy(xs, desc);
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
-			goto free_err;
+			goto out;
 		}
 	} else {
 		u32 hr, tr, len;
@@ -842,6 +842,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	if (first_frag && skb)
 		kfree_skb(skb);
 
+out:
 	if (err == -EOVERFLOW) {
 		/* Drop the packet */
 		xsk_inc_num_desc(xs->skb);

After that, it seems we can look at skb_shinfo(skb)->nr_frags? Instead
of adding new xsk_init_cb, seems more robust?

