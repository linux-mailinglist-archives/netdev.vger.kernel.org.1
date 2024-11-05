Return-Path: <netdev+bounces-141871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A669BC941
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329DB1F23A8E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BB41D14E3;
	Tue,  5 Nov 2024 09:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEweUbvm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755951C8773;
	Tue,  5 Nov 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799200; cv=none; b=qRvP7Cj95T/BXgRT94bndgAKjNeK/hpVoTGvesqifc9T+BUbR5rwLqHOk0z8vMXmwipuzyNx6IUktvmKTiOBtR7NQNr5uPs/t3vSKR8/z4T1IrDwB3ISaB7C5TqeAvPrU34vBWQhJAm3oDAiOG10qjgtpocF0M55rRP2dgGWFBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799200; c=relaxed/simple;
	bh=Ev8WZLsZnrXAntY2juW4W/wFPcpwZJqLtE5+58qy/UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUgzefUeD3KnmuhyBD4FB7eBdZXfVhfkmevvx4pSna4BjORRbwZNDlVZomTfwHA7oGMgRakKMbOWd1iB4KQnnFEVImTtqEz2k3qz2yx9afShdx42livjUgbXJdw5MC0hPw1Z71ADmzzewC+YalT2KiVC+l32D+WXpTTqnVjDO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEweUbvm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-431695fa98bso41190025e9.3;
        Tue, 05 Nov 2024 01:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799197; x=1731403997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEDkcblSiaDg4JBMdCKLxzgwQ3nqXTykPXRo9QdrPnc=;
        b=FEweUbvmXc049bF+nUSYEeFPUZ1FCSePvu/k+bA6hyo2Bfy80WVB+y45Wec2rwTPy5
         AGjdD2LlMOlfDitCWS7YExYfRn7PmCWy81A6eYiIm4gOR5LxBFydxJuA1fc/rV2cIpoi
         eqb+9EXW4QwRCNC6EGYqhuWfQaDmaOUt6tIcqpNYV1VwT1hxNg/FgXvrraw78zoDVx6A
         JuHzetbkJ/57CFkyJ/zBYLbu7+DIBhKI7KCIdZEIb14yCbL88JxmbxAp2AlMvtyO4IQk
         jhfRmfQo0LMM6V7bAqfhu1n+UY5gmEY+K8tv77/S8WnXsPhrBEKer/H/janOVrf0xIof
         2ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799197; x=1731403997;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEDkcblSiaDg4JBMdCKLxzgwQ3nqXTykPXRo9QdrPnc=;
        b=CPh84q2ykLe4E7BUwN9t6UwIlw1IeO+V1hmhco+P+99Rocow4p2iTyVm4ueAgFNY7E
         5X2Kl9u4P3JH2bF8ChoTEoyhoWyiJH1oAiZdmew/P9KAMDThDMXoTnfZ7WqUCafuLUYQ
         l7uUiKEMwRVAtZpvusJaGx6Lr+ZvBjvYo+DV71l4psNEEHw1mySzA8mYSS4XR9WoMJlc
         ZCu9wtLBaYQ9/F3PR5Q66UAjZLhcm6VGtbcJnHLCnsIbRE4dzaEI9TAHHvWcNR/kWk6+
         DTc0Gv48+ZQyuooshrWYEbznIyBQF8qtp9/O77oxTja8hSudcc3WOqH3nCGdntTQsaJl
         5r2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUF1zw8VZ07Ih7O+zARWBmFLeQrGvJn24y0jxxNwkrzLCdndXYC4KsmmswDYp8w6OMrDplRA8Xr@vger.kernel.org, AJvYcCVtx5EKe71VaACtkPIIqA3ebRRmSnZwWJiGQVuFxLy2fuYHRHx9UCDhnHGcXh8aUybOhCMBQh5O2ON98VE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTlgSWKJD/Yqd37uGAnwc89K7C6SPyR3JFs3Uvh4esADoj6yn
	0PP83L3/35FdCu6R/Mn3D7IAWxXaXQEpTCAeB01DiQt3VLOPPs9s
X-Google-Smtp-Source: AGHT+IE+hruKwLlOFKrR4x1b+E765n86HLQepq/a4QyzRv7c6UYsPTtHPRFhTG1xBNiaugXWFGfxxQ==
X-Received: by 2002:a05:600c:4fd3:b0:431:60d0:9088 with SMTP id 5b1f17b1804b1-4319ac9acedmr323535205e9.13.1730799196662;
        Tue, 05 Nov 2024 01:33:16 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd8e8471sm217379765e9.4.2024.11.05.01.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:33:16 -0800 (PST)
Date: Tue, 5 Nov 2024 09:33:21 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: linux@treblig.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] sfc: Remove unused mcdi functions
Message-ID: <20241105093321.GC595392@gmail.com>
Mail-Followup-To: linux@treblig.org, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20241102151625.39535-1-linux@treblig.org>
 <20241102151625.39535-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151625.39535-4-linux@treblig.org>

On Sat, Nov 02, 2024 at 03:16:24PM +0000, linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> efx_mcdi_flush_rxqs(), efx_mcdi_rpc_async_quiet(),
> efx_mcdi_rpc_finish_quiet(), and efx_mcdi_wol_filter_get_magic()
> are unused.
> I think these are fall out from the split into Siena
> that happened in
> commit 4d49e5cd4b09 ("sfc/siena: Rename functions in mcdi headers to avoid
> conflicts with sfc")
> and
> commit d48523cb88e0 ("sfc: Copy shared files needed for Siena (part 2)")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks.

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/mcdi.c | 76 ---------------------------------
>  drivers/net/ethernet/sfc/mcdi.h | 10 -----
>  2 files changed, 86 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mcdi.c b/drivers/net/ethernet/sfc/mcdi.c
> index 76578502226e..d461b1a6ce81 100644
> --- a/drivers/net/ethernet/sfc/mcdi.c
> +++ b/drivers/net/ethernet/sfc/mcdi.c
> @@ -1051,15 +1051,6 @@ efx_mcdi_rpc_async(struct efx_nic *efx, unsigned int cmd,
>  				   cookie, false);
>  }
>  
> -int efx_mcdi_rpc_async_quiet(struct efx_nic *efx, unsigned int cmd,
> -			     const efx_dword_t *inbuf, size_t inlen,
> -			     size_t outlen, efx_mcdi_async_completer *complete,
> -			     unsigned long cookie)
> -{
> -	return _efx_mcdi_rpc_async(efx, cmd, inbuf, inlen, outlen, complete,
> -				   cookie, true);
> -}
> -
>  int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
>  			efx_dword_t *outbuf, size_t outlen,
>  			size_t *outlen_actual)
> @@ -1068,14 +1059,6 @@ int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
>  				    outlen_actual, false, NULL, NULL);
>  }
>  
> -int efx_mcdi_rpc_finish_quiet(struct efx_nic *efx, unsigned cmd, size_t inlen,
> -			      efx_dword_t *outbuf, size_t outlen,
> -			      size_t *outlen_actual)
> -{
> -	return _efx_mcdi_rpc_finish(efx, cmd, inlen, outbuf, outlen,
> -				    outlen_actual, true, NULL, NULL);
> -}
> -
>  void efx_mcdi_display_error(struct efx_nic *efx, unsigned cmd,
>  			    size_t inlen, efx_dword_t *outbuf,
>  			    size_t outlen, int rc)
> @@ -1982,33 +1965,6 @@ efx_mcdi_wol_filter_set_magic(struct efx_nic *efx,  const u8 *mac, int *id_out)
>  }
>  
>  
> -int efx_mcdi_wol_filter_get_magic(struct efx_nic *efx, int *id_out)
> -{
> -	MCDI_DECLARE_BUF(outbuf, MC_CMD_WOL_FILTER_GET_OUT_LEN);
> -	size_t outlen;
> -	int rc;
> -
> -	rc = efx_mcdi_rpc(efx, MC_CMD_WOL_FILTER_GET, NULL, 0,
> -			  outbuf, sizeof(outbuf), &outlen);
> -	if (rc)
> -		goto fail;
> -
> -	if (outlen < MC_CMD_WOL_FILTER_GET_OUT_LEN) {
> -		rc = -EIO;
> -		goto fail;
> -	}
> -
> -	*id_out = (int)MCDI_DWORD(outbuf, WOL_FILTER_GET_OUT_FILTER_ID);
> -
> -	return 0;
> -
> -fail:
> -	*id_out = -1;
> -	netif_err(efx, hw, efx->net_dev, "%s: failed rc=%d\n", __func__, rc);
> -	return rc;
> -}
> -
> -
>  int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id)
>  {
>  	MCDI_DECLARE_BUF(inbuf, MC_CMD_WOL_FILTER_REMOVE_IN_LEN);
> @@ -2021,38 +1977,6 @@ int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id)
>  	return rc;
>  }
>  
> -int efx_mcdi_flush_rxqs(struct efx_nic *efx)
> -{
> -	struct efx_channel *channel;
> -	struct efx_rx_queue *rx_queue;
> -	MCDI_DECLARE_BUF(inbuf,
> -			 MC_CMD_FLUSH_RX_QUEUES_IN_LEN(EFX_MAX_CHANNELS));
> -	int rc, count;
> -
> -	BUILD_BUG_ON(EFX_MAX_CHANNELS >
> -		     MC_CMD_FLUSH_RX_QUEUES_IN_QID_OFST_MAXNUM);
> -
> -	count = 0;
> -	efx_for_each_channel(channel, efx) {
> -		efx_for_each_channel_rx_queue(rx_queue, channel) {
> -			if (rx_queue->flush_pending) {
> -				rx_queue->flush_pending = false;
> -				atomic_dec(&efx->rxq_flush_pending);
> -				MCDI_SET_ARRAY_DWORD(
> -					inbuf, FLUSH_RX_QUEUES_IN_QID_OFST,
> -					count, efx_rx_queue_index(rx_queue));
> -				count++;
> -			}
> -		}
> -	}
> -
> -	rc = efx_mcdi_rpc(efx, MC_CMD_FLUSH_RX_QUEUES, inbuf,
> -			  MC_CMD_FLUSH_RX_QUEUES_IN_LEN(count), NULL, 0, NULL);
> -	WARN_ON(rc < 0);
> -
> -	return rc;
> -}
> -
>  int efx_mcdi_wol_filter_reset(struct efx_nic *efx)
>  {
>  	int rc;
> diff --git a/drivers/net/ethernet/sfc/mcdi.h b/drivers/net/ethernet/sfc/mcdi.h
> index ea612c619874..cdb17d7c147f 100644
> --- a/drivers/net/ethernet/sfc/mcdi.h
> +++ b/drivers/net/ethernet/sfc/mcdi.h
> @@ -155,9 +155,6 @@ int efx_mcdi_rpc_start(struct efx_nic *efx, unsigned cmd,
>  int efx_mcdi_rpc_finish(struct efx_nic *efx, unsigned cmd, size_t inlen,
>  			efx_dword_t *outbuf, size_t outlen,
>  			size_t *outlen_actual);
> -int efx_mcdi_rpc_finish_quiet(struct efx_nic *efx, unsigned cmd,
> -			      size_t inlen, efx_dword_t *outbuf,
> -			      size_t outlen, size_t *outlen_actual);
>  
>  typedef void efx_mcdi_async_completer(struct efx_nic *efx,
>  				      unsigned long cookie, int rc,
> @@ -167,11 +164,6 @@ int efx_mcdi_rpc_async(struct efx_nic *efx, unsigned int cmd,
>  		       const efx_dword_t *inbuf, size_t inlen, size_t outlen,
>  		       efx_mcdi_async_completer *complete,
>  		       unsigned long cookie);
> -int efx_mcdi_rpc_async_quiet(struct efx_nic *efx, unsigned int cmd,
> -			     const efx_dword_t *inbuf, size_t inlen,
> -			     size_t outlen,
> -			     efx_mcdi_async_completer *complete,
> -			     unsigned long cookie);
>  
>  void efx_mcdi_display_error(struct efx_nic *efx, unsigned cmd,
>  			    size_t inlen, efx_dword_t *outbuf,
> @@ -410,10 +402,8 @@ int efx_mcdi_handle_assertion(struct efx_nic *efx);
>  int efx_mcdi_set_id_led(struct efx_nic *efx, enum efx_led_mode mode);
>  int efx_mcdi_wol_filter_set_magic(struct efx_nic *efx, const u8 *mac,
>  				  int *id_out);
> -int efx_mcdi_wol_filter_get_magic(struct efx_nic *efx, int *id_out);
>  int efx_mcdi_wol_filter_remove(struct efx_nic *efx, int id);
>  int efx_mcdi_wol_filter_reset(struct efx_nic *efx);
> -int efx_mcdi_flush_rxqs(struct efx_nic *efx);
>  void efx_mcdi_process_link_change(struct efx_nic *efx, efx_qword_t *ev);
>  void efx_mcdi_mac_start_stats(struct efx_nic *efx);
>  void efx_mcdi_mac_stop_stats(struct efx_nic *efx);
> -- 
> 2.47.0
> 

