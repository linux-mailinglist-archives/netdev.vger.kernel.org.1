Return-Path: <netdev+bounces-204932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A4AFC922
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7340F18949C2
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C87221561;
	Tue,  8 Jul 2025 11:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpzpIPXl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDC31E9B2D;
	Tue,  8 Jul 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972706; cv=none; b=JFDe1mXwP0ZMa5E2XUwlJP1v7h3lvO8zZolpqn3zgG8OYc+MhsY3fsrtEsvmCjjQCvP0jym1rZUWosybiWAsMhCl6xZu3p6fnQWC0RTVC6z/RpK6guFMFk3HOy11feVcoUtqVuDugQqNBYUOLkJAWcJufDyWKdTZzO6F+5Ozwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972706; c=relaxed/simple;
	bh=5cG4DeDqbfiWCmY8G3IQIEWAgFjNloJd5T7LEMyt5OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snfFrws8PHBe8XOLwwKnSR2anLx7F2o74AZAAKE9ZumVjdkVYq3C50TquxkjCy3skiFt4tDiDjMPV/64INxh2HPpXnFv6PjNr/QwEdBjf7Y/Pf2ZYQOplzqvaKtp8l1cq6j7ztyKTA6mHDqMw7Rf0NQvPTdf5okU0RhYF9xceVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpzpIPXl; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so704598166b.0;
        Tue, 08 Jul 2025 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751972702; x=1752577502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRU/+hFkoTw5qHqNwj6ei+Jmw40bwtYgcu8fT+5zfjE=;
        b=cpzpIPXl9e9zi4PLUSoLV9aiMMkD8aW4DKwSHb+Q7ORCU/DkX2CBCNWEWRwJplEqgf
         WGG0hecsc8V9GFAQZSBfglgIVEvzt32eEIGySMVHEFrbsEuI1Ngg0fayrcKo+wusPdcq
         U62qErTTcDOlOFEzBULfCQYySUYblVRnqNKfy2HWFxm2+GKjTdp/xlWtCm3R9vOWHirj
         XMr2S6rgaah2My5G9u9aRstX2Qgs/M3nkFrvmbdYeusKaWPD4gRd034p8T6io2LSH1eT
         iofdvg7ATVzKykeJYNrGdkk0x0z/lng4YPitBC2CsxqdApwprMSY0f3rBSKdHsv69BuC
         QCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972702; x=1752577502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRU/+hFkoTw5qHqNwj6ei+Jmw40bwtYgcu8fT+5zfjE=;
        b=QOREB9poCN5m/lsZXf7Rs6wMr1f3rp8d5M+oc6vSn8zT0lIJOLhlNgWmPffAzGmc8Y
         lSMEsFUiVH3QjC6su8K6u/koLMUqSWFRE4kTK/QXdAvZPQlDjvT3vseWxs2rC7D95tj2
         YjcpF+AcE7vtXrAsguup2FjlLGXIt6gdYAhwzDQK7Rb0LXWwarfuii2m957VVPAWeZJi
         LPqjmvdUJ7l7SW28NAmfDPi3D1oTbA1umNdKfOFILYJAY/RVRE7SlcVF/RruQFGWGEkC
         F0CmuNECQmbA33YYDtKEogHBCnx6pQpYhK9GNkNCmpfninuoxQVfKNkIkGNfNDk4R1Wb
         unMg==
X-Forwarded-Encrypted: i=1; AJvYcCVmjGf3uZWIhhIssHsZZytLlrMvLOlJvg4yv8lApOcRIL1gHbu+dHEM2JsG5/XxxT3YUwD5kGzhPhRDzuI=@vger.kernel.org, AJvYcCVnfxgMqEqWsSwZ7r7I+IS9cAaGl4RyawVSpFpI/JGFFtfbImSEVXtUZFgRecXIywu5kIiz5xZI@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcoEhJJKUbpFB0EV2Zgp6qf88kfaDI3B1P+DN9X9F8j9MtCDZ
	HjTIAIIpSKN/mcDz2kPgg4x7Wc3LrtSiut9V6jkkdb6INm3ekpWub9tq
X-Gm-Gg: ASbGncuJatOsX+F6PIcbbpE9g6PEq2cQvjYQlDXQVjxz9rDX3mbZEZbijTliRHLlmtL
	yJl7s/gqz4drcKXaeD60P27lX34SPoCXisGDVr5ty8KCVgWo5l/C3DOGbflsu8rFr00E/Iv2+rJ
	nGsBJYNWNGJkBYlv7xZLG1BPQnHSGyEygtbPMvQ7VhH8B/jSw7yWaxsCmdkxDfzA3DJwK4zGExq
	ox3G+pfieUS9qFUDldNTgU3lDJlN8wtzKYA4j2VrcEoTfJCVGOyRWmZaJMIMeQJjq0f1QFZD/b0
	tT/AleUslsyXB1yRL1cQAslPWR4FMe0WPF7sF7+cSbD444hlJnJPzJjyOKRnkunEEJKo63Jn/m4
	=
X-Google-Smtp-Source: AGHT+IG/xzC3tI0puBmckI4rTlIlwCBfe5a4dxt1kiLb4lcsEsza24eX2Ju6QgEjiCI465RP05ncRw==
X-Received: by 2002:a17:907:7287:b0:adb:23e0:9297 with SMTP id a640c23a62f3a-ae3fe6923b3mr1557685666b.17.1751972702138;
        Tue, 08 Jul 2025 04:05:02 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:4dfd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d93c8sm884341566b.11.2025.07.08.04.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:05:01 -0700 (PDT)
Message-ID: <32cb77d8-a4a5-4fc7-a427-d723e60efc59@gmail.com>
Date: Tue, 8 Jul 2025 12:06:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>, almasrymina@google.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250702172433.1738947-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/2/25 18:24, Dragos Tatulea wrote:
> For zerocopy (io_uring, devmem), there is an assumption that the
> parent device can do DMA. However that is not always the case:
> for example mlx5 SF devices have an auxiliary device as a parent.
> 
> This patch introduces the possibility for the driver to specify
> another DMA device to be used via the new dma_dev field. The field
> should be set before register_netdev().
> 
> A new helper function is added to get the DMA device or return NULL.
> The callers can check for NULL and fail early if the device is
> not capable of DMA.
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
>   include/linux/netdevice.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5847c20994d3..83faa2314c30 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2550,6 +2550,9 @@ struct net_device {
>   
>   	struct hwtstamp_provider __rcu	*hwprov;
>   
> +	/* To be set by devices that can do DMA but not via parent. */
> +	struct device		*dma_dev;
> +
>   	u8			priv[] ____cacheline_aligned
>   				       __counted_by(priv_len);
>   } ____cacheline_aligned;
> @@ -5560,4 +5563,14 @@ extern struct net_device *blackhole_netdev;
>   		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
>   #define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
>   
> +static inline struct device *netdev_get_dma_dev(const struct net_device *dev)
> +{
> +	struct device *dma_dev = dev->dma_dev ? dev->dma_dev : dev->dev.parent;
> +
> +	if (!dma_dev->dma_mask)

dev->dev.parent is NULL for veth and I assume other virtual devices as well.

Mina, can you verify that devmem checks that? Seems like veth is rejected
by netdev_need_ops_lock() in netdev_nl_bind_rx_doit(), but IIRC per netdev
locking came after devmem got merged, and there are other virt devices that
might already be converted.

> +		dma_dev = NULL;
> +
> +	return dma_dev;
> +}
> +
>   #endif	/* _LINUX_NETDEVICE_H */

-- 
Pavel Begunkov


