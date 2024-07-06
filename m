Return-Path: <netdev+bounces-109628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397BA9293C5
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 15:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF5B1C20E00
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 13:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E771B52;
	Sat,  6 Jul 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTX1vNb5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1113482D3;
	Sat,  6 Jul 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720272580; cv=none; b=VZbv9EnihSYlKThRU7OXPgZE0PqcgeCwNSRI+mBYs/fJMx+Hh5PMlT641c+H23jL4ya/X40ZKjAU5lx+g51zqYtgACB/PxHyUAs9CyJeS1HeanI5raQnOmq479wIMbG+YkBbZS6MRfRPeWW6KW45uvn1aswSm49gW81Huhyeomw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720272580; c=relaxed/simple;
	bh=tyWj4fij4P/SkbMsqeIBPpxU0hUoLxa3AxMnnTqsQRg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ej3XYt25+mN7ol6yYUVtOKRrpCTanfzOgzB/sJtO8vqnqsM1h9QfG9Onf4ZvTWXnhIN/r2Narh2+AJCe8pMZfhOTySlBl0M6xlJ1LdG0tnV0IeLHajrYJ2m23aj329QZhDy2fdJVeIAu437z+aLRdyHVZ/KaU/030jLdMYjASGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTX1vNb5; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-654cf0a069eso9071327b3.1;
        Sat, 06 Jul 2024 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720272578; x=1720877378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+0C3hzJM3P4EhoexxB9qMOOcPx/HYZc4cqwJ6D3Ay8=;
        b=WTX1vNb5OTQGanO6EW1o3iFrD04IQZ/mXvnLolJ9LuEyV2L7QU6ZFU3yqP2LmkjEdB
         uPNr8pdrlOZ1iRpxJIywS/3T0CzTlmyCCGUp8HGYXJon92VCUGcupDvh+kVIJUYK9qW/
         fd4AjyDygokegs+4h3et7qyWVI7ZbzlBIQgqbZWO5yE3l6oBM1/e5CCjGPOtKvFuCtJg
         y4nfC8fDxivV/iQ/K5MsJDlQvjcoUnJ9RnVMSfYbM2LLcCYfvcGM6H3gB+xhnw+vHk7l
         LeGu75fuFLKvN5GWKwLQy1HFkbi93ut1eyUtEWGyWo6Oayn2FVttdRWBMCL9jknG3Hb7
         SVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720272578; x=1720877378;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u+0C3hzJM3P4EhoexxB9qMOOcPx/HYZc4cqwJ6D3Ay8=;
        b=TjIzUxZUA6Vf8v3w4Cm5+kFCqejT5LIR1PJO3UQqiQY7d3b7hXpNzRN/NZywkjIovb
         vWa4l7KRmUVe2hadtKYZ2JWP0Hz72N8vlXHKHEmdFl9EizQGltl12icBVjUsFmAxeRjC
         PbbMESUOjCrgx5P2nXtNkTAcNe5uvO13aNqDSSdj2DKIUtdlMLRNvunr/epXxRExP7F9
         SrdrxzRAN3sjT5u8SuRllp562Iy74PkzqKJpqG4wxsH9a+B+t9FGx0hRfXBsUzG7Y4jY
         cmSk8XadhuB1pmg6W37BegmtcFy8J9nQdHIcRLGWswhwFlThJ/ew2hq7+kVjwxqZOYih
         RGSw==
X-Forwarded-Encrypted: i=1; AJvYcCXOjKLbeNdfukzwUGcY9z3+OPWECU5FHbo1W2bpl92Cp+zNgxnof4p+MhH3/cGsfXpywHhE8YI9bM9kbEsqjewrb9lDpf3gq+uk8x1yPq1mgLnUF++APhKgXf35wxq4fxqJxKZ8
X-Gm-Message-State: AOJu0YzP81MBMewbFmeJablPIeF/yYHW1SP+39hWMr0TJWmvmoDMar1H
	BxnkOiLZ6Wxa1fSxL/cBlG9QGXGTJxQ88WracQ6DJFqhH0OzU13G
X-Google-Smtp-Source: AGHT+IFwfFMQQZX1qK22eMO9B7PVE3XTEtpharBfanLuZEq+jgSO/uqHA520GfSsvYfac2XRjx1Mpw==
X-Received: by 2002:a05:690c:ec4:b0:64a:956b:c063 with SMTP id 00721157ae682-652d8438d69mr90724117b3.39.1720272577785;
        Sat, 06 Jul 2024 06:29:37 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d692f0aafsm876897985a.77.2024.07.06.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 06:29:37 -0700 (PDT)
Date: Sat, 06 Jul 2024 09:29:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 David Ahern <dsahern@kernel.org>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <668946c1ddef_12869e29412@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240703150342.1435976-4-aleksander.lobakin@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
 <20240703150342.1435976-4-aleksander.lobakin@intel.com>
Subject: Re: [PATCH net-next v2 3/5] netdev_features: convert NETIF_F_LLTX to
 dev->lltx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> NETIF_F_LLTX can't be changed via Ethtool and is not a feature,
> rather an attribute, very similar to IFF_NO_QUEUE (and hot).
> Free one netdev_features_t bit and make it a "hot" private flag.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

> diff --git a/Documentation/networking/netdev-features.rst b/Documentation/networking/netdev-features.rst
> index d7b15bb64deb..f29d982ebf5d 100644
> --- a/Documentation/networking/netdev-features.rst
> +++ b/Documentation/networking/netdev-features.rst
> @@ -139,14 +139,6 @@ chained skbs (skb->next/prev list).
>  Features contained in NETIF_F_SOFT_FEATURES are features of networking
>  stack. Driver should not change behaviour based on them.
>  
> - * LLTX driver (deprecated for hardware drivers)
> -
> -NETIF_F_LLTX is meant to be used by drivers that don't need locking at all,
> -e.g. software tunnels.
> -
> -This is also used in a few legacy drivers that implement their
> -own locking, don't use it for new (hardware) drivers.
> -
>   * netns-local device
>  
>  NETIF_F_NETNS_LOCAL is set for devices that are not allowed to move between
> diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
> index c2476917a6c3..857c9784f87e 100644
> --- a/Documentation/networking/netdevices.rst
> +++ b/Documentation/networking/netdevices.rst
> @@ -258,11 +258,11 @@ ndo_get_stats:
>  ndo_start_xmit:
>  	Synchronization: __netif_tx_lock spinlock.
>  
> -	When the driver sets NETIF_F_LLTX in dev->features this will be
> +	When the driver sets dev->lltx this will be
>  	called without holding netif_tx_lock. In this case the driver
>  	has to lock by itself when needed.
>  	The locking there should also properly protect against
> -	set_rx_mode. WARNING: use of NETIF_F_LLTX is deprecated.
> +	set_rx_mode. WARNING: use of dev->lltx is deprecated.
>  	Don't use it for new drivers.
>  
>  	Context: Process with BHs disabled or BH (timer),
> diff --git a/drivers/net/ethernet/tehuti/tehuti.h b/drivers/net/ethernet/tehuti/tehuti.h
> index 909e7296cecf..47a2d3e5f8ed 100644
> --- a/drivers/net/ethernet/tehuti/tehuti.h
> +++ b/drivers/net/ethernet/tehuti/tehuti.h

> @@ -23,8 +23,6 @@ enum {
>  	NETIF_F_HW_VLAN_CTAG_FILTER_BIT,/* Receive filtering on VLAN CTAGs */
>  	NETIF_F_VLAN_CHALLENGED_BIT,	/* Device cannot handle VLAN packets */
>  	NETIF_F_GSO_BIT,		/* Enable software GSO. */
> -	NETIF_F_LLTX_BIT,		/* LockLess TX - deprecated. Please */
> -					/* do not use LLTX in new drivers */
>  	NETIF_F_NETNS_LOCAL_BIT,	/* Does not change network namespaces */
>  	NETIF_F_GRO_BIT,		/* Generic receive offload */
>  	NETIF_F_LRO_BIT,		/* large receive offload */

> @@ -1749,6 +1749,8 @@ enum netdev_reg_state {
>   *			booleans combined, only to assert cacheline placement
>   *	@priv_flags:	flags invisible to userspace defined as bits, see
>   *			enum netdev_priv_flags for the definitions
> + *	@lltx:		device supports lockless Tx. Mainly used by logical
> + *			interfaces, such as tunnels

This loses some of the explanation in the NETIF_F_LLTX documentation.

lltx is not deprecated, for software devices, existing documentation
is imprecise on that point. But don't use it for new hardware drivers
should remain clear.

>   *
>   *	@name:	This is the first field of the "visible" part of this structure
>   *		(i.e. as seen by users in the "Space.c" file).  It is the name

> @@ -3098,7 +3098,7 @@ static void amt_link_setup(struct net_device *dev)
>  	dev->hard_header_len	= 0;
>  	dev->addr_len		= 0;
>  	dev->priv_flags		|= IFF_NO_QUEUE;
> -	dev->features		|= NETIF_F_LLTX;
> +	dev->lltx		= true;
>  	dev->features		|= NETIF_F_GSO_SOFTWARE;
>  	dev->features		|= NETIF_F_NETNS_LOCAL;
>  	dev->hw_features	|= NETIF_F_SG | NETIF_F_HW_CSUM;

Since this is an integer type, use 1 instead of true?

Type conversion will convert true to 1. But especially when these are
integer bitfields, relying on conversion is a minor unnecessary risk.

>  int dsa_user_suspend(struct net_device *user_dev)
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index 6b2a360dcdf0..44199d1780d5 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -24,7 +24,6 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
>  	[NETIF_F_HW_VLAN_STAG_FILTER_BIT] = "rx-vlan-stag-filter",
>  	[NETIF_F_VLAN_CHALLENGED_BIT] =  "vlan-challenged",
>  	[NETIF_F_GSO_BIT] =              "tx-generic-segmentation",
> -	[NETIF_F_LLTX_BIT] =             "tx-lockless",
>  	[NETIF_F_NETNS_LOCAL_BIT] =      "netns-local",
>  	[NETIF_F_GRO_BIT] =              "rx-gro",
>  	[NETIF_F_GRO_HW_BIT] =           "rx-gro-hw",

Is tx-lockless no longer reported after this?

These features should ideally still be reported, even if not part of
the features bitmap in the kernel implementation.

This removal is what you hint at in the cover letter with

  Even shell scripts won't most likely break since the removed bits
  were always read-only, meaning nobody would try touching them from
  a script.

It is a risk. And an avoidable one?


 

