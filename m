Return-Path: <netdev+bounces-116652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB794B511
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37324B23CEC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A602CD2E5;
	Thu,  8 Aug 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbdW1mtV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DF2C2E3
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723084162; cv=none; b=Rs7o0Anhxvqi07GdwZx7g8uLzzQrCywnNanM8ngJS5jYn8hgfaZ+dyIJpr8T4t76b6ibpqQVBlxVYYSw5/51YuovOGxFSCqZRUQpaZw4azx7f9cI7OP6WI3YiCibuDNBTM4oeTg7Taz8IuqrVGTKdvGowVr18TaakXEYX0CLTqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723084162; c=relaxed/simple;
	bh=Ujr1cCw5+sKlrOyf94Aid0TXRG5ddnJ/a2+PsF/zDIc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ngnUM7rgoDPxRxNMaeIaGYhycpEuaMirtnaYNylC8fYNKie4eck3gQARcf3TKPLxrruZxAc6fFoLPd83PY1Op+Y0Xuluu6P8ChSzVVXHa8U4Zwb88k5ItVy0ySgrzXFawtAi+h+HnuHaHtcCYlnF3+jTE8YVqHbWFn2u9+3eQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbdW1mtV; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6c136a947so287470e0c.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723084160; x=1723688960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nqeUTJfgv3cDBj1hMMFfguQr4A83IVuLfq9QtNnlnw=;
        b=IbdW1mtV7JluCUdOAFZFzlnnbufVZVyagFMYjsWmUWOtwc6KrquH3WFnn/FVAb8jir
         1nZvpLL4nOr0h3APLjpo6hKxWfmqjavz4NETo279CJZIU+77CN/uYt0Y07SQLKWLkKod
         3lMZLK4T/0gEdaw0KJO+zoR4Ungrbssz4etENCsr0cznOusx33lxXMQVeRMYHmZMLrtj
         KMJRDWfImbjzK0LDStyaNV6WEsfo43VcE1iiPfZZ0CYMhpoEseymvHDhrU5XGvMQnZxG
         7IbW8Sb6nJIQH9QfU5p5/ulrp+wa63eg60WOXjc18NUOaTbHLYCybmjvTzCW4H32DkIt
         ifkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723084160; x=1723688960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3nqeUTJfgv3cDBj1hMMFfguQr4A83IVuLfq9QtNnlnw=;
        b=hnzck6l2lH09K7WuyL0yedRL6xsXzxmBpqhHaht7kGQthNlI+n2vBxjIJogNYGmYYx
         11XNqumNxi1eFKxfbru52M6lAbZdBOinqc6lxlYl02YOo51v+jStyuE9mj/HwdsYqIcA
         BBP5qxh8Ybn3WZqmOMf26CBeg9W7YTOtzpwXy8o3C9/baAwbolGMimVKP5sCQwH5PvFv
         usglN2Jx6/nKhLe6RyiR/DCGcfPCZYFUdmChDEAoAZC7zw+E9tqpejEtx0PJD/vzO0cl
         M16Kkl3N2nW7PHA1ufOSkdhnNvGSzTLjGwN2BF3BgJ0yD6l+xAVCRbZ6Mc0JCXL4hv6R
         KHMA==
X-Forwarded-Encrypted: i=1; AJvYcCWly6rIjF3UJJTqfXdZLqvRG+r++Ep0v3H8bSUNqesbLNxStV8Ts/0xE528X+AYgKrwO2a0b5PNNdA1lBahEm2Gl0fjoa96
X-Gm-Message-State: AOJu0Yy6XyA4OEUH7gvZKJ3rYIbiy9Zows69tMH56qV8nva1ZBDvWWp2
	X2d1FzqtKELRgewO9rp72s3EiDUUBCJ/2Yos2strKYB724ftyYcd
X-Google-Smtp-Source: AGHT+IHcMLQrORMj/y60PaquG5Ypba9sBjoktgecU+R/u+IkXffDFPH8LFcpYbQheo2oHkyCC8ybQg==
X-Received: by 2002:a05:6122:16a8:b0:4f5:2aa9:a447 with SMTP id 71dfb90a1353d-4f9027a9c08mr779899e0c.11.1723084159663;
        Wed, 07 Aug 2024 19:29:19 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785ed05esm111533485a.53.2024.08.07.19.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 19:29:19 -0700 (PDT)
Date: Wed, 07 Aug 2024 22:29:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 kernel-team@cloudflare.com, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <66b42d7ee8ab0_3795002940@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240807-udp-gso-egress-from-tunnel-v3-1-8828d93c5b45@cloudflare.com>
References: <20240807-udp-gso-egress-from-tunnel-v3-0-8828d93c5b45@cloudflare.com>
 <20240807-udp-gso-egress-from-tunnel-v3-1-8828d93c5b45@cloudflare.com>
Subject: Re: [PATCH net v3 1/3] net: Make USO depend on CSUM offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> UDP segmentation offload inherently depends on checksum offload. It should
> not be possible to disable checksum offload while leaving USO enabled.
> Enforce this dependency in code.
> 
> There is a single tx-udp-segmentation feature flag to indicate support for
> both IPv4/6, hence the devices wishing to support USO must offer checksum
> offload for both IP versions.
> 
> Fixes: 83aa025f535f ("udp: add gso support to virtual devices")

Was this not introduced by removing the CHECKSUM_PARTIAL check in
udp_send_skb?

> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  net/core/dev.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 751d9b70e6ad..dfb12164b35d 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9912,6 +9912,16 @@ static void netdev_sync_lower_features(struct net_device *upper,
>  	}
>  }
>  
> +#define IP_CSUM_MASK (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)
> +

Perhaps NETIF_F_IP_CSUM_MASK in netdev_features.h right below

#define NETIF_F_CSUM_MASK

Then again, for a stable patch we want a small patch. Then I'd define
as a constant netdev_features_t inside the function scope.

Minor: still prefix with netdev_ even though it's a static function?


> +static bool has_ip_or_hw_csum(netdev_features_t features)
> +{
> +	bool ip_csum = (features & IP_CSUM_MASK) == IP_CSUM_MASK;
> +	bool hw_csum = features & NETIF_F_HW_CSUM;
> +
> +	return ip_csum || hw_csum;
> +}
> +
>  static netdev_features_t netdev_fix_features(struct net_device *dev,
>  	netdev_features_t features)
>  {
> @@ -9993,15 +10003,9 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
>  		features &= ~NETIF_F_LRO;
>  	}
>  
> -	if (features & NETIF_F_HW_TLS_TX) {
> -		bool ip_csum = (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) ==
> -			(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);
> -		bool hw_csum = features & NETIF_F_HW_CSUM;
> -
> -		if (!ip_csum && !hw_csum) {
> -			netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
> -			features &= ~NETIF_F_HW_TLS_TX;
> -		}
> +	if ((features & NETIF_F_HW_TLS_TX) && !has_ip_or_hw_csum(features)) {
> +		netdev_dbg(dev, "Dropping TLS TX HW offload feature since no CSUM feature.\n");
> +		features &= ~NETIF_F_HW_TLS_TX;
>  	}
>  
>  	if ((features & NETIF_F_HW_TLS_RX) && !(features & NETIF_F_RXCSUM)) {
> @@ -10009,6 +10013,11 @@ static netdev_features_t netdev_fix_features(struct net_device *dev,
>  		features &= ~NETIF_F_HW_TLS_RX;
>  	}
>  
> +	if ((features & NETIF_F_GSO_UDP_L4) && !has_ip_or_hw_csum(features)) {
> +		netdev_dbg(dev, "Dropping USO feature since no CSUM feature.\n");
> +		features &= ~NETIF_F_GSO_UDP_L4;
> +	}
> +
>  	return features;
>  }
>  
> 
> -- 
> 2.40.1
> 



