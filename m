Return-Path: <netdev+bounces-102832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFF3904F8E
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC191C21018
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3C16E867;
	Wed, 12 Jun 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgHvjpG/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BBF16D9D7
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185588; cv=none; b=Mx9uv8VTCG2PNeaQhbve0IReuFLTFajYvGoXrQ7xvQ48s17RkgPYMtGfPuRfAbKiz9E8HTkbWKPkCmlvsrz05k/yc9xfO6C3odzrgZGfMzTd8+J+EHqQSTkLbsmx18Wheud6zlqd3irIqdWrd9vpfGvzwONzd29RFHDt1sKHr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185588; c=relaxed/simple;
	bh=W9ndXkFGN+0mJvooAoPTWczE53d1nQ0rmrqRu/keLPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExouU8yp0LYXUaSSSIIOXsZykaQc+l2Npt/XErxy8j0x1VLg9Hp8dZOWPFTA9Q2uM5cmWy/TXVT4K93qjkD7hkkXnFFPb5A2ahiqiEnOvo4V8DxumKrLoF2QoHNOWN6s4g31AKYBEYBFNlR775ZuRTtLMNJ7Ekm4B7T34EUQL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgHvjpG/; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5bb36de2171so448314eaf.2
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718185584; x=1718790384; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7o5lyLDpCnCOWAKSNy5bFFrbCTaImlxo26NRKCBcB40=;
        b=mgHvjpG//vBx3LRfzTNfIpoPV3IMScA6Qy2kCT2yyLBX2Ivm6isQLJotFrHcg6kRBN
         kXzsyraKDq/Y3mTFSLzIsf6/1pyXzJtpSJJphVh0PgnEEHQH5PIu6AUQ64dveFqXldDk
         bD+m2wHRpDk5v4qCCz2VsmUNS2xPj/UqXjBLmUzgl02GnyN6SOtJNkh/yok2s2MTNNZX
         xL+I2Idfvbtl4SwqiY+Q0AjoEVMDE7nJOZ4XS4knvaxptrt5h6TAHZZ+9IBVrF7EQfUR
         jbKRgy6uskUv/B5zJZXsUMDzkmxJatwd5hNFhqrcpvQPiN8rqa59gPLOPbfXWdIChNaR
         Lsmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718185584; x=1718790384;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7o5lyLDpCnCOWAKSNy5bFFrbCTaImlxo26NRKCBcB40=;
        b=R+vKNaZoghOMxwnxQcmuKAk4DXOLbii+phl/PVsGc0WOM/l+Ta70bUI8j3wAJLISl3
         It3/Lfl52l3E1z1mfm75IFrV6hb8EwbHTaA5kv4VSOaQWOIL2/l099Z2V5GPiClhiBVj
         ryk3hJC72L6osf3d+9vGUBH9B6xPDakHisPpVGRilMcxz6Ck56GssaWxV4Fwluy0wd/2
         5oOR/L0nsjQzD/gEatfon9kFT5Ws+KOSSz3R2MtFusEhrRn/EuqwjqJkPT9dLMOqfwvC
         /fglAEVvZlXBA0jNlsJKmN5HAPCnXOYx2uLBZ+GlH+/g700Xd44XHwofPl6ItB2Y3/KT
         ACSg==
X-Forwarded-Encrypted: i=1; AJvYcCX/2fdnhmGcC/VFiMQ5GIH1ueen1EXNVGmvlDK17I0AQ8zvW063yyA+uy1EbrUkWB4b4RCka69ppP56/qBZAk2HinbXuwRy
X-Gm-Message-State: AOJu0Yy8e61uugD1GRNlPsUAy4NtGIRqM28LTMjxESsN8M0W6DU5Z4MU
	SKU/lVi00VXbKMdAbGAfEE1lQ2Yeyo0yd6KoqJ+VxKxUYZEhY+SUnkbr9fGv5w==
X-Google-Smtp-Source: AGHT+IGmU2eeEDxojuHCD3Q7xWva5vETr3bu38Y0Bbw7SVri6LNH1NAs8U8qZoVnVXKsiVvHtXFhGw==
X-Received: by 2002:a05:6359:4c9d:b0:19f:48e8:2d with SMTP id e5c5f4694b2df-19f69cf6bbbmr142440955d.5.1718185584205;
        Wed, 12 Jun 2024 02:46:24 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6de200849b7sm8803874a12.18.2024.06.12.02.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 02:46:23 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:16:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] bus: mhi: host: Import mux_id item
Message-ID: <20240612094609.GA58302@thinkpad>
References: <20240612093842.359805-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612093842.359805-1-slark_xiao@163.com>

On Wed, Jun 12, 2024 at 05:38:42PM +0800, Slark Xiao wrote:

Subject could be improved:

bus: mhi: host: Add configurable mux_id for MBIM mode

> For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> This would lead to device can't ping outside successfully.
> Also MBIM side would report "bad packet session (112)".
> So we add a default mux_id value for SDX72. And this value
> would be transferred to wwan mbim side.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 3 +++
>  include/linux/mhi.h                | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 0b483c7c76a1..9e9adf8320d2 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -53,6 +53,7 @@ struct mhi_pci_dev_info {
>  	unsigned int dma_data_width;
>  	unsigned int mru_default;
>  	bool sideband_wake;
> +	unsigned int mux_id;
>  };
>  
>  #define MHI_CHANNEL_CONFIG_UL(ch_num, ch_name, el_count, ev_ring) \
> @@ -469,6 +470,7 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
>  	.dma_data_width = 32,
>  	.mru_default = 32768,
>  	.sideband_wake = false,
> +	.mux_id = 112,
>  };
>  
>  static const struct mhi_channel_config mhi_mv3x_channels[] = {
> @@ -1035,6 +1037,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
>  	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>  	mhi_cntrl->mru = info->mru_default;
> +	mhi_cntrl->link_id = info->mux_id;

Again, 'link_id' is just a WWAN term. Use 'mux_id' here also.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

