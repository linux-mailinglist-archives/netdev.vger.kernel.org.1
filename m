Return-Path: <netdev+bounces-188310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BC2AAC17B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 12:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1B4C851C
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 10:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE6E278741;
	Tue,  6 May 2025 10:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlUkXv8E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B519278146
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746527827; cv=none; b=J4izaFgpHrcVVgEw+9yhLecIbv9goTPVhOdxd6nXcxPyl4f2g0BZKSWEVdzS3wYPKshtTCa9Z2iRJKa3G9ZdF1HlX+/jr/Kpzry0aayzGuyA2cHSWuOrlW4CBm8TsdzX9g89sZ6nReWzPmVGrVkA1vaXPhSDxn0VCnBu4GXtDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746527827; c=relaxed/simple;
	bh=bGLHeOo/UPh/FsvGzBipG1630hXDqTjfzmZD/hU1dOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyniloRJ7saG4iQQuXcpLSf/aj1duFPCqMAnY/iwG7+wspbmoyfDlv02ial73PUD8WrtWNmJy27VkRmXOUt0Qm7tj6d/XqSOGGKTb4djSHyx4UBy6/UnzepOe3ZjRaq6rNLIYbdTOPGqkg0Ff7I0Zve8l+h3OujWBT0wdOZ8B5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlUkXv8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746527824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqJrxIoT0NsSUqxGw8G610oIR60/B2YKtR0eMCHfHoU=;
	b=DlUkXv8EfCo0ILG0N+pgQwQDvZLnRgWggoAG98Zk1MD3C4kDF4br+PBJ/MvkgrQj6YfY9Z
	JLoVW5YRxK757Zd9j3UXOzBTS7eXskM/1XpJpqPPTSpgTjC0fkPpCgZIYAnx3jTaIrpWZu
	QaJWgrHunTrmhCYnbTRMmP37nm+CP/E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-rY1fFFvCP46tKbdABHqxCw-1; Tue, 06 May 2025 06:37:03 -0400
X-MC-Unique: rY1fFFvCP46tKbdABHqxCw-1
X-Mimecast-MFC-AGG-ID: rY1fFFvCP46tKbdABHqxCw_1746527822
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39c30f26e31so3193312f8f.3
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 03:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746527822; x=1747132622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqJrxIoT0NsSUqxGw8G610oIR60/B2YKtR0eMCHfHoU=;
        b=wrQZvyvYzBjTL3AGk73Uy/XuXybxx3siYlUGmcb/zX0GIqngw6yjLrgKbrXESqmknl
         EnICvZahDXWPQ1T1dJ3c7pJwoj0Sf4Xwyx/FlDRWGSVp1WCH8WqMMyXWxDAKXGdgeDbb
         OAZ42bMyKLXsN0gyW8MUb9dZxx1DENpb+uDy2RLUuhruWVYKCmgjoV7U30fwyt6LdEpn
         xDSuIyLHjNZAaDV99+C2TE/mpewArngSXI0cP2bOJec0tTkw8nl56MiISvXONsNQY5RB
         e4ttbbdkb4x4EIqO4TTvuKAO89CGO/xno7t1/YcCm4ngpMyOMnjTh3zM2spSkRo+k78p
         Qn/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwnfgYRbWngHxZ4jqSahhyWkD04EUVjHZTy/wYNQigI84v+YZChnzH+CmzEZ7x7PNpZfC8IMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5YdWHq1XP3vwDXMEQB+zyy7XpbKuTTvrJ5Jup2RuKkqqJ1dnO
	IvPkdWdE83Y4u2fCQRqDBnGKiCYcRZWO11EHELU1p76KADl1cI0GPYHnMjV7Z8vbklXn3Nmgewt
	+6MhAdDkkpmDrggLKjJ7/HxLLmGTDQJ5f9TZSEtDnX3BWlx/gTNJ33w==
X-Gm-Gg: ASbGnctdUSh4j/mju9Qub8HZLs8NY2PcrUHa8ebDEHl7L6vNoiGdItE8qSSNpxv0b/p
	XU+IbI95Pbnumh44YqdRlVNnrFA6/C9sz9ujFs2/D/AzExFr4YMBb+nVSCjbD/BQ7PjCa6P/tl8
	FoFS+qqqqBM6DFdjlGCGkSKYy3bo8x7MMj161QcZ+NK6Z+p9VMHkGM6H31QaQPEaur9vJKvirxM
	TY/l/g1DpQqi4XzikVzsi0CcAhPiHPyYF+rDzWAgM9N+f045tAruWYKJYFbrv+q5MWCqbXgPOEt
	sLIO9jp3YdM+uOzh+jfootgOtXQdJQcGOFmvz3JANcvukkBxfzZyrcl17f4=
X-Received: by 2002:a05:6000:4383:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-3a0ac0ec4a6mr1662151f8f.33.1746527822096;
        Tue, 06 May 2025 03:37:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIqkSxt+T1Y7TtJsOmByWaD3BgViww9S8kLQLobpWHpxjPJOZvKt1Y7bskuQM3nS0/SlP2Zw==
X-Received: by 2002:a05:6000:4383:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-3a0ac0ec4a6mr1662118f8f.33.1746527821579;
        Tue, 06 May 2025 03:37:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a2874asm162916855e9.26.2025.05.06.03.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 03:37:01 -0700 (PDT)
Message-ID: <61ebe754-d895-47cb-a4b2-bb2650b9ff7b@redhat.com>
Date: Tue, 6 May 2025 12:36:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v11 4/7] net: mtip: The L2 switch driver for imx287
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Stefan Wahren <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250504145538.3881294-1-lukma@denx.de>
 <20250504145538.3881294-5-lukma@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250504145538.3881294-5-lukma@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/25 4:55 PM, Lukasz Majewski wrote:
> +		/* This does 16 byte alignment, exactly what we need.
> +		 * The packet length includes FCS, but we don't want to
> +		 * include that when passing upstream as it messes up
> +		 * bridging applications.
> +		 */
> +		skb = netdev_alloc_skb(pndev, pkt_len + NET_IP_ALIGN);
> +		if (unlikely(!skb)) {
> +			dev_dbg(&fep->pdev->dev,
> +				"%s: Memory squeeze, dropping packet.\n",
> +				pndev->name);
> +			pndev->stats.rx_dropped++;
> +			goto err_mem;
> +		} else {
> +			skb_reserve(skb, NET_IP_ALIGN);
> +			skb_put(skb, pkt_len);      /* Make room */
> +			skb_copy_to_linear_data(skb, data, pkt_len);
> +			skb->protocol = eth_type_trans(skb, pndev);
> +			napi_gro_receive(&fep->napi, skb);
> +		}
> +
> +		bdp->cbd_bufaddr = dma_map_single(&fep->pdev->dev, data,
> +						  bdp->cbd_datlen,
> +						  DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(&fep->pdev->dev,
> +					       bdp->cbd_bufaddr))) {
> +			dev_err(&fep->pdev->dev,
> +				"Failed to map descriptor rx buffer\n");
> +			pndev->stats.rx_errors++;
> +			pndev->stats.rx_dropped++;
> +			dev_kfree_skb_any(skb);
> +			goto err_mem;
> +		}

This is doing the mapping and ev. dropping the skb _after_ pushing the
skb up the stack, you must attempt the mapping first.

> +static void mtip_free_buffers(struct net_device *dev)
> +{
> +	struct mtip_ndev_priv *priv = netdev_priv(dev);
> +	struct switch_enet_private *fep = priv->fep;
> +	struct sk_buff *skb;
> +	struct cbd_t *bdp;
> +	int i;
> +
> +	bdp = fep->rx_bd_base;
> +	for (i = 0; i < RX_RING_SIZE; i++) {
> +		skb = fep->rx_skbuff[i];
> +
> +		if (bdp->cbd_bufaddr)
> +			dma_unmap_single(&fep->pdev->dev, bdp->cbd_bufaddr,
> +					 MTIP_SWITCH_RX_FRSIZE,
> +					 DMA_FROM_DEVICE);
> +		if (skb)
> +			dev_kfree_skb(skb);

I suspect that on error paths mtip_free_buffers() can be invoked
multiple consecutive times with any successful allocation in between:
skb will be freed twice. Likely you need to clear fep->rx_skbuff[i] here.

Side note: this patch is way too big for a proper review: you need to
break it in multiple smaller ones, introducing the basic features
separately.

Cheers,

Paolo


