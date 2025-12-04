Return-Path: <netdev+bounces-243513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37385CA2DCC
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 09:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66A33016DE2
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DBC314B6C;
	Thu,  4 Dec 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxvWxeW4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DL441gLZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289628642A
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838443; cv=none; b=qOTRNmh4UucPfzgfn6DqbTRCE8ErjlbMTvuQt+JaKO8YJuVp88D4TNJDod4vXwmf4DYzdM/HULHP1961/4Wh9G/IT+gUtvkfJK7cHCXRJgWwf1x1pJyeKUsxqZJRBPBa+4MLP1slpf2VgeqWzc9aGpulOnnjVu+RP5OY3HVNfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838443; c=relaxed/simple;
	bh=Hnh7HF3toQOUTtMRZEW6IdEM1+kyGkkQr9xHVruOSFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFAb6z+ZIP44XatimT7ylRljxh6A3B1tt64FxnTlzSgi+bLx3uF+A4H1yBq5mVA7LNlsvf+yjBMZIpLcBmPC6NZr7MrkgcWGDg6BStBtJMjeagjH2dtZ3eUc2zi1Qs6OVJOq7ww60vPP+oZPJNBL940WLXblnLhyJshDt/JqFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XxvWxeW4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DL441gLZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764838440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+RROGbd82iRnOs3Nzwo2Z6WPhdY3ptA/NeS0/WSLQA=;
	b=XxvWxeW4BSKUJCoo3Yjx95WAQX+tSzSRuv5CzeUUK5IvgJApPq6IWM8/kgYoNT/zIwPxW0
	8tNrm8ofPJX6wprZ5N+nSWNdOkD6nBBvrl/XIEp5WvgXqYzttufc9cWVG1qesvLGwgcb3g
	pQGVkzHj+MZl0galcSYapBAAKThwO5s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-vADit8SbOb61ehxWUroYOg-1; Thu, 04 Dec 2025 03:53:58 -0500
X-MC-Unique: vADit8SbOb61ehxWUroYOg-1
X-Mimecast-MFC-AGG-ID: vADit8SbOb61ehxWUroYOg_1764838438
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so4213015e9.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 00:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764838437; x=1765443237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m+RROGbd82iRnOs3Nzwo2Z6WPhdY3ptA/NeS0/WSLQA=;
        b=DL441gLZDQ4615YkpUgiWgxHfcvhaTe7oCOeLld7/j1NqS9FJPWWl6mfoZyBCYmlZk
         yKlqWEKJRRCie2QqZkDzhPpUAJDSxlxSq2g1Prvlgs3/F8mrsJ/v7/qr0mQJxo9K4ekR
         HsC5y7+y2ihjAkuBvsaR3TmPanYBBjlfNa55dXNj6xjopj3ABSCt+XMd+xSm2ARTRHsf
         3uoMQ/nrU5r08o3e0njyxuGLOqQY3VhVZ6+iW14F3pSkUHfQNT69rgqZQq1rYBT4jZ5z
         7dK4eQ4GW68NK1nXzFCPzPajc3MHg/AqOh/jNT1OcVvYBG7iuo38u8IGDTG0RsUFueMR
         87AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838437; x=1765443237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+RROGbd82iRnOs3Nzwo2Z6WPhdY3ptA/NeS0/WSLQA=;
        b=PFGHdWXlZlXTpI92//6crrtJxNXtYCHl+uJK/e60ldG7EjsF+dIn6FhoXwJAy/jdYL
         y2bkBJlZa0qBECSUl2UOds550cl1Ps0YH5Qljf2N2m2yjbn+vqvTvBCo47lZYKd9lDAt
         6EietVXm3SL8DfaSE9awY6h+kx2aVdeEFW1ZLAhP2r6+Cw2S3PLIq07AZLCRYUDkNC/m
         PHUEQr31aA+I5mtfi8qs7hANF/j8RATXJoqp24Jh5kVrFZt0eyep0AQSqU/GsXdFnyhD
         thEjo2RttVkSQ6fGN/vSu9o+5LUaOLuDmaUjMkVyQHRztX2+il2yblSlRUqT9kmmsiHQ
         4EQw==
X-Forwarded-Encrypted: i=1; AJvYcCXtqQgWRXAFOWtCJJM/erykzdyCtkdGQ873OvyK4lu094g09LZs9U9xmZlHqq0Q4whrqVuDPWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8nZhzX0HLVk7gbWh/Jb4DXsIrYBa4jyq2Z0URa98gaD2cqfu
	GdH1JTY5MjImNmpauljo9SL5uBSgQ1T4A+xZ+F2ycRpQa2rCSn36XwJfGLd0kH8nG5apXi3Nevq
	9zMy3rjZ4m+PTbAWrAQoB7SNEhHxg0NwMrFtGnVN7KhDnFVzuVVdWyT+57w==
X-Gm-Gg: ASbGncvTZIA7cWaF75rabq1OmIToOTQTxx1A/u5nyS/Lmq0pDW5oi8930aHCUvYmloC
	ps/SJgSAfXPvEaeXnojWmk2f0xLh4PA3Z7lzKit3tbkUbBlYArH0PmDSmwmplPNONczgkisDLCr
	W10YklMCfEIXmSO4Mz003RsiPFYo40R3jFsbOyIiFrSzuwyx+ILFEXgUs9/zXuyzyuX50zpTf1a
	gS2dZoituSPth6uy5NAeKOE0XJxfJYYu8GJLOkl/8qfxHiAZGgriI7m0mO5RBJ3Svym4pELhe3g
	TwErFzO7nJRSP064si3MaBwTuQmgz9xw2DZ6hefPg/8xFQg4sacSpUJiGG9MECtLKV8kmK90t/D
	RRHqVCLN0CJ/X
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-4792eb10e97mr24490195e9.4.1764838437607;
        Thu, 04 Dec 2025 00:53:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdoOoX89LYoqg9vGC/S46dUkmd/JqxNYom3WUE3CEBjnMhlYwrZPQ9lVJw/8DiVw0VpIa8aA==
X-Received: by 2002:a05:600c:3151:b0:479:255f:8805 with SMTP id 5b1f17b1804b1-4792eb10e97mr24489965e9.4.1764838437222;
        Thu, 04 Dec 2025 00:53:57 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4793093a9dcsm23134795e9.7.2025.12.04.00.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 00:53:56 -0800 (PST)
Message-ID: <cfc92b7c-b376-4de0-83a7-f7080c6f24d9@redhat.com>
Date: Thu, 4 Dec 2025 09:53:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fec: ERR007885 Workaround for XDP TX path
To: Wei Fang <wei.fang@nxp.com>, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251128025915.2486943-1-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128025915.2486943-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 3:59 AM, Wei Fang wrote:
> The ERR007885 will lead to a TDAR race condition for mutliQ when the
> driver sets TDAR and the UDMA clears TDAR simultaneously or in a small
> window (2-4 cycles). And it will cause the udma_tx and udma_tx_arbiter
> state machines to hang. Therefore, the commit 53bb20d1faba ("net: fec:
> add variable reg_desc_active to speed things up") and the commit
> a179aad12bad ("net: fec: ERR007885 Workaround for conventional TX") have
> added the workaround to fix the potential issue for the conventional TX
> path. Similarly, the XDP TX path should also have the potential hang
> issue, so add the workaround for XDP TX path.
> 
> Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 3222359ac15b..e2b75d1970ae 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3948,7 +3948,12 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>  	txq->bd.cur = bdp;
>  
>  	/* Trigger transmission start */
> -	writel(0, txq->bd.reg_desc_active);
> +	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active) ||
> +	    !readl(txq->bd.reg_desc_active))
> +		writel(0, txq->bd.reg_desc_active);
>  
>  	return 0;
>  }

LGTM!

Side note for a net-next follow-up: please consider moving this logic in
a reusable helper, since you already have a few potentials call sites.

/P


