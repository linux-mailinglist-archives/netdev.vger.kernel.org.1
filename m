Return-Path: <netdev+bounces-141863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C4A9BC911
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE01C20D37
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2B1CEAD3;
	Tue,  5 Nov 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnwzd8cF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961592C1A2;
	Tue,  5 Nov 2024 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798676; cv=none; b=uKMEhU7tiQ2LNzY2QthFZHFAUCGCeJerezNOdQ7MMrKmITQPoWgqa3vtNEA4HN+mXE7sZ/AUKMVaLXSmuuwjoHnXGkqCR0HyJAJdq9UpjbjGB8xKiWdVAkBDApN4Io+MS3jZbqpv1IRUjGiChfgTJu3JPMm3UkYS5s9wfDtQVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798676; c=relaxed/simple;
	bh=lHnyBfBTQjco+Q8/el5batnluEtnew7C0m7F2u1KFlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJOI+TN0rFa7KZwWJztkLZWz5cIENie3eX3QXHb1isf/aBJNpXD15q8A4turOCHeozhQKLa8R6TJXpJeTfb1gD9ibk4bpvmRwQbJ64PN1kH0OAzu47vJLgEXs3LtNX2IjjQ3MBMqtf/yUse9sM6k0kkISj1InjndtBeRNOUfs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnwzd8cF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43159c9f617so41135735e9.2;
        Tue, 05 Nov 2024 01:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730798673; x=1731403473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tohPMlVDZ5Y7WnOCAL63NhRehFzgQIDFb9lQrCWtJxM=;
        b=Rnwzd8cFOysLz1qKVAKtmBoJ8SCJv7BM4h+sn7Nm6UDSRZ3IbLLWspFeQuBpiCyBay
         FnAACekfZZFdF/BhrRKmO1hHrz7tc6Ls3yJEy3cddjpbwRsfrLLu3AbCUff5/EPUDm+d
         FCKZD7jlL1gb054VOgdq/I2GHPCKfcyEZs/3pQFYQVdbqEmrT+L30RFk+PruoKcFWJls
         3AogKLTF1yJTyirW9+hQcwF3rWhSotT6Wuc9WF90DDTbWkaMLAvTDMTrPlFwQ/OGsSts
         KCZUGC/wM6KcI6HGzdcHnxAClm6DrmCgfF0KcjmPmicJhqItEXg2AOO/BROPQE1d52k5
         pWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798673; x=1731403473;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tohPMlVDZ5Y7WnOCAL63NhRehFzgQIDFb9lQrCWtJxM=;
        b=hVJn864l5uEtd+v1/6GotW0wszN1zDVAibJ5M9e0KTUmUTYvOxlAlyGLlhkCaObkyb
         +ZqcpRXP+1gy3k9w4d/vKZw92uSbJ5HzTez9XeEw86cykpkXUETnByjGoluC+SAmZWAx
         gl7t6P/r5+xlv+vTsNkJ6J/oioog/tGgpUOp6pHSdVW6Iqjb8zRpiBR7T5WRyerFbBPK
         8ixLs3bznkARaKD9UeBf1ebsy+DfqwbQcsIuETVbkjiWfkGK1TfddYiDc2QNuTU7kMBq
         Xrw2hh29QgeeVY+j6evQs0zwMOy+HpDXDhuq3CXiKx6Mka7rYtLDOkoSRctGDOfxLd30
         HwPw==
X-Forwarded-Encrypted: i=1; AJvYcCUcCEUzMhnW+dOrs/vMCoesTL+FMKdCg5HuSvtxD7OpN9/kFbE/vUrUB1KkN02ZPn5HmfF3nTXyKKkrc58=@vger.kernel.org, AJvYcCUtMV15Kiba7lb8FleNOhHu20slw139Qj1kZ91Zl+ZJWOc12xiRbsN4pkSv4EJJ35S1Fk5Ztujv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw373bMiS//Z9RAjkN7/g/JudKNx2JIDCIGWV1A/qwyefaATfPS
	mIcxQkmhyNX//4WmhHShfH34y+WeCzcuwQpJt477NCip8q+P+/Aj
X-Google-Smtp-Source: AGHT+IF/2CLIWfbrKTuNSZg0B6hdDOQ8Fz2PgyDeRzWonkfc04jUv2Y2fF+uWwqftaeeLNWbf3iHug==
X-Received: by 2002:a5d:6192:0:b0:37d:4956:b0b4 with SMTP id ffacd0b85a97d-3806122fc7emr25371169f8f.59.1730798672486;
        Tue, 05 Nov 2024 01:24:32 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7b80sm15701472f8f.10.2024.11.05.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:24:31 -0800 (PST)
Date: Tue, 5 Nov 2024 09:24:36 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: linux@treblig.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] sfc: Remove falcon deadcode
Message-ID: <20241105092436.GA595392@gmail.com>
Mail-Followup-To: linux@treblig.org, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20241102151625.39535-1-linux@treblig.org>
 <20241102151625.39535-2-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151625.39535-2-linux@treblig.org>

On Sat, Nov 02, 2024 at 03:16:22PM +0000, linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> ef4_farch_dimension_resources(), ef4_nic_fix_nodesc_drop_stat(),
> ef4_ticks_to_usecs() and ef4_tx_get_copy_buffer_limited() were
> copied over from efx_ equivalents in 2016 but never used by
> commit 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into new
> sfc-falcon driver")
> 
> EF4_MAX_FLUSH_TIME is also unused.
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Many thanks David.

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/falcon/efx.c   |  8 --------
>  drivers/net/ethernet/sfc/falcon/efx.h   |  1 -
>  drivers/net/ethernet/sfc/falcon/farch.c | 22 ----------------------
>  drivers/net/ethernet/sfc/falcon/nic.c   | 11 -----------
>  drivers/net/ethernet/sfc/falcon/nic.h   |  5 -----
>  drivers/net/ethernet/sfc/falcon/tx.c    |  8 --------
>  drivers/net/ethernet/sfc/falcon/tx.h    |  3 ---
>  7 files changed, 58 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index 8925745f1c17..b07f7e4e2877 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -1886,14 +1886,6 @@ unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs)
>  	return usecs * 1000 / efx->timer_quantum_ns;
>  }
>  
> -unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks)
> -{
> -	/* We must round up when converting ticks to microseconds
> -	 * because we round down when converting the other way.
> -	 */
> -	return DIV_ROUND_UP(ticks * efx->timer_quantum_ns, 1000);
> -}
> -
>  /* Set interrupt moderation parameters */
>  int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.h b/drivers/net/ethernet/sfc/falcon/efx.h
> index d3b4646545fa..52508f2c8cb2 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.h
> +++ b/drivers/net/ethernet/sfc/falcon/efx.h
> @@ -198,7 +198,6 @@ int ef4_try_recovery(struct ef4_nic *efx);
>  /* Global */
>  void ef4_schedule_reset(struct ef4_nic *efx, enum reset_type type);
>  unsigned int ef4_usecs_to_ticks(struct ef4_nic *efx, unsigned int usecs);
> -unsigned int ef4_ticks_to_usecs(struct ef4_nic *efx, unsigned int ticks);
>  int ef4_init_irq_moderation(struct ef4_nic *efx, unsigned int tx_usecs,
>  			    unsigned int rx_usecs, bool rx_adaptive,
>  			    bool rx_may_override_tx);
> diff --git a/drivers/net/ethernet/sfc/falcon/farch.c b/drivers/net/ethernet/sfc/falcon/farch.c
> index c64623c2e80c..01017c41338e 100644
> --- a/drivers/net/ethernet/sfc/falcon/farch.c
> +++ b/drivers/net/ethernet/sfc/falcon/farch.c
> @@ -1631,28 +1631,6 @@ void ef4_farch_rx_push_indir_table(struct ef4_nic *efx)
>  	}
>  }
>  
> -/* Looks at available SRAM resources and works out how many queues we
> - * can support, and where things like descriptor caches should live.
> - *
> - * SRAM is split up as follows:
> - * 0                          buftbl entries for channels
> - * efx->vf_buftbl_base        buftbl entries for SR-IOV
> - * efx->rx_dc_base            RX descriptor caches
> - * efx->tx_dc_base            TX descriptor caches
> - */
> -void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw)
> -{
> -	unsigned vi_count;
> -
> -	/* Account for the buffer table entries backing the datapath channels
> -	 * and the descriptor caches for those channels.
> -	 */
> -	vi_count = max(efx->n_channels, efx->n_tx_channels * EF4_TXQ_TYPES);
> -
> -	efx->tx_dc_base = sram_lim_qw - vi_count * TX_DC_ENTRIES;
> -	efx->rx_dc_base = efx->tx_dc_base - vi_count * RX_DC_ENTRIES;
> -}
> -
>  u32 ef4_farch_fpga_ver(struct ef4_nic *efx)
>  {
>  	ef4_oword_t altera_build;
> diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethernet/sfc/falcon/nic.c
> index 78c851b5a56f..1b91992e3698 100644
> --- a/drivers/net/ethernet/sfc/falcon/nic.c
> +++ b/drivers/net/ethernet/sfc/falcon/nic.c
> @@ -511,14 +511,3 @@ void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  		}
>  	}
>  }
> -
> -void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *rx_nodesc_drops)
> -{
> -	/* if down, or this is the first update after coming up */
> -	if (!(efx->net_dev->flags & IFF_UP) || !efx->rx_nodesc_drops_prev_state)
> -		efx->rx_nodesc_drops_while_down +=
> -			*rx_nodesc_drops - efx->rx_nodesc_drops_total;
> -	efx->rx_nodesc_drops_total = *rx_nodesc_drops;
> -	efx->rx_nodesc_drops_prev_state = !!(efx->net_dev->flags & IFF_UP);
> -	*rx_nodesc_drops -= efx->rx_nodesc_drops_while_down;
> -}
> diff --git a/drivers/net/ethernet/sfc/falcon/nic.h b/drivers/net/ethernet/sfc/falcon/nic.h
> index ada6e036fd97..ac10c12967df 100644
> --- a/drivers/net/ethernet/sfc/falcon/nic.h
> +++ b/drivers/net/ethernet/sfc/falcon/nic.h
> @@ -477,7 +477,6 @@ void ef4_farch_finish_flr(struct ef4_nic *efx);
>  void falcon_start_nic_stats(struct ef4_nic *efx);
>  void falcon_stop_nic_stats(struct ef4_nic *efx);
>  int falcon_reset_xaui(struct ef4_nic *efx);
> -void ef4_farch_dimension_resources(struct ef4_nic *efx, unsigned sram_lim_qw);
>  void ef4_farch_init_common(struct ef4_nic *efx);
>  void ef4_farch_rx_push_indir_table(struct ef4_nic *efx);
>  
> @@ -502,10 +501,6 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  void ef4_nic_update_stats(const struct ef4_hw_stat_desc *desc, size_t count,
>  			  const unsigned long *mask, u64 *stats,
>  			  const void *dma_buf, bool accumulate);
> -void ef4_nic_fix_nodesc_drop_stat(struct ef4_nic *efx, u64 *stat);
> -
> -#define EF4_MAX_FLUSH_TIME 5000
> -
>  void ef4_farch_generate_event(struct ef4_nic *efx, unsigned int evq,
>  			      ef4_qword_t *event);
>  
> diff --git a/drivers/net/ethernet/sfc/falcon/tx.c b/drivers/net/ethernet/sfc/falcon/tx.c
> index b9369483758c..e6e80b039ca2 100644
> --- a/drivers/net/ethernet/sfc/falcon/tx.c
> +++ b/drivers/net/ethernet/sfc/falcon/tx.c
> @@ -40,14 +40,6 @@ static inline u8 *ef4_tx_get_copy_buffer(struct ef4_tx_queue *tx_queue,
>  	return (u8 *)page_buf->addr + offset;
>  }
>  
> -u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
> -				   struct ef4_tx_buffer *buffer, size_t len)
> -{
> -	if (len > EF4_TX_CB_SIZE)
> -		return NULL;
> -	return ef4_tx_get_copy_buffer(tx_queue, buffer);
> -}
> -
>  static void ef4_dequeue_buffer(struct ef4_tx_queue *tx_queue,
>  			       struct ef4_tx_buffer *buffer,
>  			       unsigned int *pkts_compl,
> diff --git a/drivers/net/ethernet/sfc/falcon/tx.h b/drivers/net/ethernet/sfc/falcon/tx.h
> index 2a88c59cbbbe..868ed8a861ab 100644
> --- a/drivers/net/ethernet/sfc/falcon/tx.h
> +++ b/drivers/net/ethernet/sfc/falcon/tx.h
> @@ -15,9 +15,6 @@
>  unsigned int ef4_tx_limit_len(struct ef4_tx_queue *tx_queue,
>  			      dma_addr_t dma_addr, unsigned int len);
>  
> -u8 *ef4_tx_get_copy_buffer_limited(struct ef4_tx_queue *tx_queue,
> -				   struct ef4_tx_buffer *buffer, size_t len);
> -
>  int ef4_enqueue_skb_tso(struct ef4_tx_queue *tx_queue, struct sk_buff *skb,
>  			bool *data_mapped);
>  
> -- 
> 2.47.0
> 

