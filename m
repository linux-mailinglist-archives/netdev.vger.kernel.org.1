Return-Path: <netdev+bounces-141865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED809BC91B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 546AD28325B
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0341CEEB8;
	Tue,  5 Nov 2024 09:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpB4VIKL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B01070837;
	Tue,  5 Nov 2024 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730798896; cv=none; b=HIMLc1hEwKX8nw+OXVYiepUzMgQbTX4wwepwgJ9VoCorc4NATdwl/Q1XDYqW6tAK5UQ+u29zmvKMnEXxayBs7k+uSFs/78Hp1Jb7jyvkKoKzhy6OzUWxDZWQYEUpB+HOKYbFADITcgLIA1Ppcx8RuWV8nPnlAAuE0Bk+4iPDwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730798896; c=relaxed/simple;
	bh=SOqA2KiSZ66RBSDN2Mzk1Ili+tcTWEUSzG2MTS2LVAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFPYFhj6/8tw0wzFKnZW3WJa1bTgEpvz3izQA0od5pNR2x060S5VPnNZeqGFGMAn/EoU1rvF+joGlffofPLJdJTq1v3RsV8QY3+p6pdDsqmPs+IVk/6+wfnpxdiCx9zwvZRzNBeRX4/gn5IAB7r1k92g6Xq0CGhEe9za8jEV3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpB4VIKL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d462c91a9so3068554f8f.2;
        Tue, 05 Nov 2024 01:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730798893; x=1731403693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfYpsiaVhokXvMRE5Ly3ANC1QV6XyEt1nW28Am+u6yM=;
        b=cpB4VIKLRo+biLeU7uth0wOg04Hh3BKEzc5w45caHRW2qCunbuzkI69SELOq/i04yf
         UaHvov29iygUR/hK4tAEhjYWkyjLxfDEU3H/eaudwRJjtovzyDRGoujfNFvHA9vt8Ats
         8qcy6eSvtVqxj30YclccOIDriAn8TCrF4K9uM20/J6hOa6GhiwEnUrLt69FtWPHgr8oI
         CkRpJ7MjrF17c/GBVqI2prCIGqsUBIyV6imsiNppVdDi6WczRrjlhYItGzu2cnU7fA4v
         1jix8OFR+hNW7UwKyLm2FRKbGV6stiPzGrPBP9P3fg2WQNe/q/ce7oYxeLotKprEDOjf
         ebLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730798893; x=1731403693;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfYpsiaVhokXvMRE5Ly3ANC1QV6XyEt1nW28Am+u6yM=;
        b=S69IaRBBcdW0MtuT7JNxFCEth1LtuHGT5I/NryVV4CtqHW1ITsGHaSn4Y7Gyn5Yh/N
         uKw5VlMR2ax4OuJbfG1vdurmxWpA2ygFkPcfKlguqaZwBcWIdO0M5K0MQ79kw5ekyqGn
         Sr6rzyOsrGa4sEtq52PyDIvwodvWcVkEKCwSctd0wCRcjBoDGx/1rEg+NNtVIzgSdljx
         /PdJIyLkcuUGhllDmxXg77CxLZcuIdkq3KR4ftV2U/3MBSlYjTQk2wbTNNfJemdLuJ5k
         mNoRMGKXTsTzDWFqtvcFTewXBto8IXUzRMci8VZbXMXHZ1vB7htX/qa52J+JmNaV3S8u
         3kjw==
X-Forwarded-Encrypted: i=1; AJvYcCWbu6X0iI87zXgdLtF0RNmvXTfAxkPQN9VlHF51YngRzZyVV+/TIezRoa7U/6c8X9aZZ6JwQGmi@vger.kernel.org, AJvYcCXZOld9RAhPEk/7HEial9ieiXZfDdz+1l4gl5h1n6TKQ+Up8jM1mXxySGB1/FS/fDfDFwWneHDI02Lt9Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ9MT3ZkHbKs8T0WSK83FlbxHnOM837ODF1u8RysFA1/H++PX7
	erG87viVEXgu3zJc2QesS+n7If4nhiT93vzvW9wpL2EFsO/LFQTo
X-Google-Smtp-Source: AGHT+IHSIm7YyJ7tIlnXXnQYXgLSSY1yNj5/Ic8h4kFjLi0jQrWKCtJcJOW3S4lKcs+sxaecJgfr7w==
X-Received: by 2002:a05:6000:d0f:b0:378:e8a9:98c5 with SMTP id ffacd0b85a97d-381b708b566mr15215408f8f.34.1730798893173;
        Tue, 05 Nov 2024 01:28:13 -0800 (PST)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e69fsm15508974f8f.69.2024.11.05.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 01:28:12 -0800 (PST)
Date: Tue, 5 Nov 2024 09:28:17 +0000
From: Martin Habets <habetsm.xilinx@gmail.com>
To: linux@treblig.org
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] sfc: Remove unused efx_mae_mport_vf
Message-ID: <20241105092817.GB595392@gmail.com>
Mail-Followup-To: linux@treblig.org, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20241102151625.39535-1-linux@treblig.org>
 <20241102151625.39535-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102151625.39535-3-linux@treblig.org>

On Sat, Nov 02, 2024 at 03:16:23PM +0000, linux@treblig.org wrote:
> 
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> efx_mae_mport_vf() has been unused since
> commit 5227adff37af ("sfc: add mport lookup based on driver's mport data")
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Acked-by: Martin Habets <habetsm.xilinx@gmail.com>

> ---
>  drivers/net/ethernet/sfc/mae.c | 11 -----------
>  drivers/net/ethernet/sfc/mae.h |  1 -
>  2 files changed, 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
> index 10709d828a63..50f097487b14 100644
> --- a/drivers/net/ethernet/sfc/mae.c
> +++ b/drivers/net/ethernet/sfc/mae.c
> @@ -76,17 +76,6 @@ void efx_mae_mport_uplink(struct efx_nic *efx __always_unused, u32 *out)
>  	*out = EFX_DWORD_VAL(mport);
>  }
>  
> -void efx_mae_mport_vf(struct efx_nic *efx __always_unused, u32 vf_id, u32 *out)
> -{
> -	efx_dword_t mport;
> -
> -	EFX_POPULATE_DWORD_3(mport,
> -			     MAE_MPORT_SELECTOR_TYPE, MAE_MPORT_SELECTOR_TYPE_FUNC,
> -			     MAE_MPORT_SELECTOR_FUNC_PF_ID, MAE_MPORT_SELECTOR_FUNC_PF_ID_CALLER,
> -			     MAE_MPORT_SELECTOR_FUNC_VF_ID, vf_id);
> -	*out = EFX_DWORD_VAL(mport);
> -}
> -
>  /* Constructs an mport selector from an mport ID, because they're not the same */
>  void efx_mae_mport_mport(struct efx_nic *efx __always_unused, u32 mport_id, u32 *out)
>  {
> diff --git a/drivers/net/ethernet/sfc/mae.h b/drivers/net/ethernet/sfc/mae.h
> index 8df30bc4f3ba..db79912c86d8 100644
> --- a/drivers/net/ethernet/sfc/mae.h
> +++ b/drivers/net/ethernet/sfc/mae.h
> @@ -23,7 +23,6 @@ int efx_mae_free_mport(struct efx_nic *efx, u32 id);
>  
>  void efx_mae_mport_wire(struct efx_nic *efx, u32 *out);
>  void efx_mae_mport_uplink(struct efx_nic *efx, u32 *out);
> -void efx_mae_mport_vf(struct efx_nic *efx, u32 vf_id, u32 *out);
>  void efx_mae_mport_mport(struct efx_nic *efx, u32 mport_id, u32 *out);
>  
>  int efx_mae_lookup_mport(struct efx_nic *efx, u32 selector, u32 *id);
> -- 
> 2.47.0
> 

