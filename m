Return-Path: <netdev+bounces-124127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09696830B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7EB1C22226
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849C91C330B;
	Mon,  2 Sep 2024 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vyzTpUcB"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F31C3317
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268900; cv=none; b=SIlSHM+n86px3zIIoSl9Lxh1gdGznFAQIJ0Olt2MpbWLNAu+7bP1Lm9J6JWoJMtAlGTGlE1hNUEVmfq2UoXbkUBoqnEt3D8Qr09yQsc+slvtfh77e1ak0zhQMvDPdHrofLMP2VCy2HDmrDzLRrghApJZWoynMFLJLLteLtDbPhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268900; c=relaxed/simple;
	bh=iDsmshXJVD8s3yK38VMnLizfEcJ1C8YUXn9FCOR9xPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSjA7/PM7AKyUC7OkWPRP03noTVqjnzoSX6RC/Rnu1ntW+AR1Ro2yKMeFt7SxWB6vr93u3Vz/7gOeye4SEwruFxr1OZe89CE3WHk5Nf1MjeY/rQQw7cvTsVLmyN2sNuINBiA1towBWCYnGXOPEEVpU52ME2snZAiwNWICyiifzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vyzTpUcB; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ecd830fe-28a8-4995-b4d3-fa4e5312b305@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725268896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVYaX6g3/9KxekRmpAlwPapjsoVSFfqI4FmyNybVBuc=;
	b=vyzTpUcBP3UMOUXYAA2H108EVl6cc0yNZCo+rXQFd7u7GYlfNn6hTFF6KmJg+3O3+3XT8W
	he7atWWCGVwsceABuLL6Bb8nI/6TdLr8ujRfLJRRaGBIjHyRxSSaqz71s+091hWmxd9fo2
	GHn59yip/DqQ5m5+F6fT5YFpknFO35I=
Date: Mon, 2 Sep 2024 10:21:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: enetc: Replace ifdef with IS_ENABLED
To: Martyn Welch <martyn.welch@collabora.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830175052.1463711-1-martyn.welch@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240830175052.1463711-1-martyn.welch@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/08/2024 18:50, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a
> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>   drivers/net/ethernet/freescale/enetc/enetc.c         | 8 ++++----
>   drivers/net/ethernet/freescale/enetc/enetc.h         | 4 ++--
>   drivers/net/ethernet/freescale/enetc/enetc_ethtool.c | 2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 5c45f42232d3..276bc96dd1ef 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -977,7 +977,7 @@ static int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt)
>   	return j;
>   }
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   static void enetc_get_rx_tstamp(struct net_device *ndev,
>   				union enetc_rx_bd *rxbd,
>   				struct sk_buff *skb)
> @@ -1041,7 +1041,7 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
>   		__vlan_hwaccel_put_tag(skb, tpid, le16_to_cpu(rxbd->r.vlan_opt));
>   	}
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   	if (priv->active_offloads & ENETC_F_RX_TSTAMP)
>   		enetc_get_rx_tstamp(rx_ring->ndev, rxbd, skb);

I believe IS_ENABLED can go directly to if statement and there should be
no macros dances anymore. You can change these lines into
	if (IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK) &&
	    priv->active_offloads & ENETC_F_RX_TSTAMP)

The same applies to other spots in the patch.

>   #endif
> @@ -2882,7 +2882,7 @@ void enetc_set_features(struct net_device *ndev, netdev_features_t features)
>   }
>   EXPORT_SYMBOL_GPL(enetc_set_features);
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   static int enetc_hwtstamp_set(struct net_device *ndev, struct ifreq *ifr)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> @@ -2956,7 +2956,7 @@ static int enetc_hwtstamp_get(struct net_device *ndev, struct ifreq *ifr)
>   int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
>   {
>   	struct enetc_ndev_priv *priv = netdev_priv(ndev);
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   	if (cmd == SIOCSHWTSTAMP)
>   		return enetc_hwtstamp_set(ndev, rq);
>   	if (cmd == SIOCGHWTSTAMP)
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
> index a9c2ff22431c..b527bb3d51b4 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> @@ -184,7 +184,7 @@ static inline union enetc_rx_bd *enetc_rxbd(struct enetc_bdr *rx_ring, int i)
>   {
>   	int hw_idx = i;
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   	if (rx_ring->ext_en)
>   		hw_idx = 2 * i;
>   #endif
> @@ -199,7 +199,7 @@ static inline void enetc_rxbd_next(struct enetc_bdr *rx_ring,
>   
>   	new_rxbd++;
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   	if (rx_ring->ext_en)
>   		new_rxbd++;
>   #endif
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> index 5e684b23c5f5..d6fdec2220ce 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> @@ -853,7 +853,7 @@ static int enetc_get_ts_info(struct net_device *ndev,
>   		info->phc_index = -1;
>   	}
>   
> -#ifdef CONFIG_FSL_ENETC_PTP_CLOCK
> +#if IS_ENABLED(CONFIG_FSL_ENETC_PTP_CLOCK)
>   	info->so_timestamping = SOF_TIMESTAMPING_TX_HARDWARE |
>   				SOF_TIMESTAMPING_RX_HARDWARE |
>   				SOF_TIMESTAMPING_RAW_HARDWARE |


