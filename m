Return-Path: <netdev+bounces-141879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312D9BC977
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B8B282A47
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A21D04A9;
	Tue,  5 Nov 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E78q8WV+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01441CEE88;
	Tue,  5 Nov 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799697; cv=none; b=qb3pEypt3L2i6vHMTZcFtRCikSIpYD9AJ1IpclFHa13JZ6AKWPV7Pp1hPP1QidVq3ikpUOnrHIMx93wBwNnqvHz5Xpl55zHHtYT6Cw8cAi2fxSeExz7fWzZRokebSHCGpCCyM9I0WDeJuVyS2JDv0W8jNGZ0BgLR/SL1G2uc9pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799697; c=relaxed/simple;
	bh=Esle46g2r6vGzDfdonN5bFNiQxombSjfYzpsiyhbzyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdEtyPeYGfVQB8WsxRepWmld6GVujwq51AARqLI1BfP7XL++kmnwG6XTycFXkK0GGQKcWWWjPuo0g8vW6KbniPcMX/o98A1/z7+PTUsi65XH1aZhxCq8lHKRdh341QUjntZRBEOAKfzGQiGcJe4ikPlgYK1ZIVjM77ihgWjcgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E78q8WV+; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d47b38336so3893989f8f.3;
        Tue, 05 Nov 2024 01:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799693; x=1731404493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pxj7n9pQtteZXiJ4zDjYrdOfABrHps1CNDR4Tb2fTrM=;
        b=E78q8WV+S1zj5Tx8RFsmE29gLM+QjyMGmiPlvfJAc7kyL2NuPuj86S3S/4fQbBYkIt
         pVYW3RRcgHjm8oRlV8aUnuN0hn0tZLXNt69iGYHkvjUAWEaT5+iiH0R8m/pVecOfC+TT
         Qske1ye12VOXNWmmtL18c9UiH8v01lqAFhgpvNRaJsYa0Z7gyn3ihTnCsxS3G4fgAoan
         XLCf3ENuy+sbJ5XChjJ7jPI1KxSRxmDuqXicAgIsiDewAYXwj0blmP0+lMjLuKT6Q2ba
         2gwJU71LjdGkOVBVGsuzwOGjazvxY7pDXDhWNButEGc6lCnDZlZKX7OBxQuPEqGn1hET
         RRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799693; x=1731404493;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pxj7n9pQtteZXiJ4zDjYrdOfABrHps1CNDR4Tb2fTrM=;
        b=BVYeLACdva15wyd8MZ/YXOq3EUEIjd6dNyEdGZDArJbiLNI93TR+d5esNYJibcffPT
         vzsh+x1K1qg9RpaadQ58nSMcYjjrd+fEa4EtpHIN7PGpa8jORTQ1wXBMsmJR/f7F8xe2
         Nv21MjJ117vP/dTf/E6fMx1J4aprxRRyVssykBLTwagZAAksBtjmLvpYM2W/GaQPH/jk
         ysyogyIcFewQeO8k5jAqgyJoRxCYgmuLLVyXXwrt+phZejynN6ajf1XqtEzVGIBr0jB3
         f7zBSiCGzCvE9Wh+vTCxI/krElRKDC/GHgKHZ1Z8vDisHVrxLfP6QmR8aUWCMQmck5M5
         zxgw==
X-Forwarded-Encrypted: i=1; AJvYcCUsMQD0IAZIouATJ9PiZO45R/gIM0VyQlb3ewJcsKJeuG1+pQSxp1QB3mKlZqzGuts68WGoci//zjPfjQI=@vger.kernel.org, AJvYcCVv/Ly6J95LnlEYS5IqWs107+irhIq7bpB51I1qg6LLm7uf33a9JxyFkf1JhZVQGz/S+v9Bbc3x@vger.kernel.org
X-Gm-Message-State: AOJu0YzU5Ih65Y/z+mqA/IBdkbWYQrpFfz8ZrRd3YSX/fpED80brHVpe
	Y4L5EjBEwelIT615vllpBFjlYUlcIz80w2ku0xVyRTg1Utpl3dEC
X-Google-Smtp-Source: AGHT+IG/HWVokxnuCJ5TJghrX0JL7HHnR6eo/qLuIl9rcXPR7t1hbPD/Soe2fR+mjpZUrk7kEkAfTg==
X-Received: by 2002:adf:f282:0:b0:37d:4a00:5704 with SMTP id ffacd0b85a97d-38061200c32mr24048161f8f.38.1730799692917;
        Tue, 05 Nov 2024 01:41:32 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4bc8sm15591813f8f.39.2024.11.05.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:41:32 -0800 (PST)
Date: Tue, 5 Nov 2024 09:41:30 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: linux@treblig.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] sfc: Remove more unused functions
Message-ID: <20241105094130.GD595392@gmail.com>
Mail-Followup-To: linux@treblig.org, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20241102151625.39535-1-linux@treblig.org>
 <20241102151625.39535-5-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151625.39535-5-linux@treblig.org>

On Sat, Nov 02, 2024 at 03:16:25PM +0000, linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> efx_ticks_to_usecs(), efx_reconfigure_port(), efx_ptp_get_mode(), and
> efx_tx_get_copy_buffer_limited() are unused.
> They seem to be partially due to the later splits to Siena, but
> some seem unused for longer.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/efx.c        |  8 --------
>  drivers/net/ethernet/sfc/efx.h        |  1 -
>  drivers/net/ethernet/sfc/efx_common.c | 16 ----------------
>  drivers/net/ethernet/sfc/efx_common.h |  1 -
>  drivers/net/ethernet/sfc/ptp.c        |  5 -----
>  drivers/net/ethernet/sfc/ptp.h        |  1 -
>  drivers/net/ethernet/sfc/tx.c         |  8 --------
>  drivers/net/ethernet/sfc/tx.h         |  3 ---
>  8 files changed, 43 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> index 36b3b57e2055..0382ac30d1aa 100644
> --- a/drivers/net/ethernet/sfc/efx.c
> +++ b/drivers/net/ethernet/sfc/efx.c
> @@ -417,14 +417,6 @@ unsigned int efx_usecs_to_ticks(struct efx_nic *efx, unsigned int usecs)
>  	return usecs * 1000 / efx->timer_quantum_ns;
>  }
>  
> -unsigned int efx_ticks_to_usecs(struct efx_nic *efx, unsigned int ticks)
> -{
> -	/* We must round up when converting ticks to microseconds
> -	 * because we round down when converting the other way.
> -	 */
> -	return DIV_ROUND_UP(ticks * efx->timer_quantum_ns, 1000);
> -}
> -
>  /* Set interrupt moderation parameters */
>  int efx_init_irq_moderation(struct efx_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 7a6cab883d66..45e191686625 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -168,7 +168,6 @@ extern const struct ethtool_ops efx_ethtool_ops;
>  
>  /* Global */
>  unsigned int efx_usecs_to_ticks(struct efx_nic *efx, unsigned int usecs);
> -unsigned int efx_ticks_to_usecs(struct efx_nic *efx, unsigned int ticks);
>  int efx_init_irq_moderation(struct efx_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
>  			    bool rx_may_override_tx);
> diff --git a/drivers/net/ethernet/sfc/efx_common.c b/drivers/net/ethernet/sfc/efx_common.c
> index 13cf647051af..c88ec3e24836 100644
> --- a/drivers/net/ethernet/sfc/efx_common.c
> +++ b/drivers/net/ethernet/sfc/efx_common.c
> @@ -635,22 +635,6 @@ int __efx_reconfigure_port(struct efx_nic *efx)
>  	return rc;
>  }
>  
> -/* Reinitialise the MAC to pick up new PHY settings, even if the port is
> - * disabled.
> - */
> -int efx_reconfigure_port(struct efx_nic *efx)
> -{
> -	int rc;
> -
> -	EFX_ASSERT_RESET_SERIALISED(efx);
> -
> -	mutex_lock(&efx->mac_lock);
> -	rc = __efx_reconfigure_port(efx);
> -	mutex_unlock(&efx->mac_lock);
> -
> -	return rc;
> -}
> -
>  /**************************************************************************
>   *
>   * Device reset and suspend
> diff --git a/drivers/net/ethernet/sfc/efx_common.h b/drivers/net/ethernet/sfc/efx_common.h
> index 2c54dac3e662..19a8ca530969 100644
> --- a/drivers/net/ethernet/sfc/efx_common.h
> +++ b/drivers/net/ethernet/sfc/efx_common.h
> @@ -40,7 +40,6 @@ void efx_destroy_reset_workqueue(void);
>  void efx_start_monitor(struct efx_nic *efx);
>  
>  int __efx_reconfigure_port(struct efx_nic *efx);
> -int efx_reconfigure_port(struct efx_nic *efx);
>  
>  #define EFX_ASSERT_RESET_SERIALISED(efx)				\
>  	do {								\
> diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
> index aaacdcfa54ae..36bceeeb6483 100644
> --- a/drivers/net/ethernet/sfc/ptp.c
> +++ b/drivers/net/ethernet/sfc/ptp.c
> @@ -1800,11 +1800,6 @@ int efx_ptp_tx(struct efx_nic *efx, struct sk_buff *skb)
>  	return NETDEV_TX_OK;
>  }
>  
> -int efx_ptp_get_mode(struct efx_nic *efx)
> -{
> -	return efx->ptp_data->mode;
> -}
> -
>  int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
>  			unsigned int new_mode)
>  {
> diff --git a/drivers/net/ethernet/sfc/ptp.h b/drivers/net/ethernet/sfc/ptp.h
> index 6946203499ef..feab7bdd7889 100644
> --- a/drivers/net/ethernet/sfc/ptp.h
> +++ b/drivers/net/ethernet/sfc/ptp.h
> @@ -26,7 +26,6 @@ int efx_ptp_get_ts_config(struct efx_nic *efx,
>  void efx_ptp_get_ts_info(struct efx_nic *efx,
>  			 struct kernel_ethtool_ts_info *ts_info);
>  bool efx_ptp_is_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
> -int efx_ptp_get_mode(struct efx_nic *efx);
>  int efx_ptp_change_mode(struct efx_nic *efx, bool enable_wanted,
>  			unsigned int new_mode);
>  int efx_ptp_tx(struct efx_nic *efx, struct sk_buff *skb);
> diff --git a/drivers/net/ethernet/sfc/tx.c b/drivers/net/ethernet/sfc/tx.c
> index fe2d476028e7..6b4a343a455d 100644
> --- a/drivers/net/ethernet/sfc/tx.c
> +++ b/drivers/net/ethernet/sfc/tx.c
> @@ -49,14 +49,6 @@ static inline u8 *efx_tx_get_copy_buffer(struct efx_tx_queue *tx_queue,
>  	return (u8 *)page_buf->addr + offset;
>  }
>  
> -u8 *efx_tx_get_copy_buffer_limited(struct efx_tx_queue *tx_queue,
> -				   struct efx_tx_buffer *buffer, size_t len)
> -{
> -	if (len > EFX_TX_CB_SIZE)
> -		return NULL;
> -	return efx_tx_get_copy_buffer(tx_queue, buffer);
> -}
> -
>  static void efx_tx_maybe_stop_queue(struct efx_tx_queue *txq1)
>  {
>  	/* We need to consider all queues that the net core sees as one */
> diff --git a/drivers/net/ethernet/sfc/tx.h b/drivers/net/ethernet/sfc/tx.h
> index f2c4d2f89919..f882749af8c3 100644
> --- a/drivers/net/ethernet/sfc/tx.h
> +++ b/drivers/net/ethernet/sfc/tx.h
> @@ -15,9 +15,6 @@
>  unsigned int efx_tx_limit_len(struct efx_tx_queue *tx_queue,
>  			      dma_addr_t dma_addr, unsigned int len);
>  
> -u8 *efx_tx_get_copy_buffer_limited(struct efx_tx_queue *tx_queue,
> -				   struct efx_tx_buffer *buffer, size_t len);
> -
>  /* What TXQ type will satisfy the checksum offloads required for this skb? */
>  static inline unsigned int efx_tx_csum_type_skb(struct sk_buff *skb)
>  {
> -- 
> 2.47.0
> 

