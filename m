Return-Path: <netdev+bounces-108873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DBF9261D6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB05E1C2322A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80917C23F;
	Wed,  3 Jul 2024 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vh3rUtmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D217C22D
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013306; cv=none; b=s5vRyMDKL1XKb/1JBCGLJRKjoxbJ64CiMGh570HUKtC6BT+kjBzME7B3oT25JEe3M0BLwtVWnEVTf+1UXBRYqLOH07uhc5QvVvB5ZR5NevbYmMZqKODjSxCsoI07hN5TU7r7zP8eJnZDSTmZJrY12e17uDSo+lORcdPok2gVZsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013306; c=relaxed/simple;
	bh=tpnBZGHozvIvo/13Y7whqzVlbGgfm6DdOHnFbtutDFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYH5rYdYuUoVzcgw6GuWyII/WBb/U9Fz0chlV6I5JuGKDhOWSVl140ZocHc8cqMaxiVYDmVJGhTS+vz/w99f+GU/nkR/MXu3DBVtHfWn5/wSXaj1wFe7Tu9IU58Dgt6fp8jHQ4q0ALi6xlEaeHo4i75g5Qk/QdrSpbTGCVEcS4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vh3rUtmm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70af8128081so65112b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 06:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720013304; x=1720618104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rdkiZRSMI+iDCKKPaGVtyVAOwgzU2h9uBT7MdiDgcgg=;
        b=vh3rUtmmO71pRYmwnHTm0jUBV/e2kN9UGI1dY+389u0jIWTV06SiuCcu0r6poBqML3
         RaN8gzbQ1lwx28EEQBpv4fhSlkYJGNjzff6YaalrA69EWleG9pPQVSxKcYrlPFJ5tjj1
         VEpePh5mPCQS3JKoSkHq0BggXcJgi+kEB4IjGWt6VT0VlhVvZgBTxJgLftFX0yOEYjlD
         THg/HoXwzdoQmYExE5CFx7Ajb7SHqDqdzpDqzuio6BgDofKLLERNimCXHcEsbSRj3qAs
         FIXyV0azsPTa+EWTbbi868L9AlS+Y0IsVMRtCnl/4KNvf0Y/uQjoiz6rf4zteDSUnATZ
         LtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720013304; x=1720618104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdkiZRSMI+iDCKKPaGVtyVAOwgzU2h9uBT7MdiDgcgg=;
        b=Iemux6Yzq0zyorgqWdx/P4C1Nc+t7+VK3Rk4zMwdf7FPzVTUaDb//6Vn5/QZ7habv3
         dqJHXy0HY7OU3trQlIh+NSt40Qv1q+NnEwU0jEDQ8++eadeEHZRqgdtwT8wmzd2yvFhU
         NadLyyV5knzz1T9cH7tZo6JXA6sLGz6R7hNlEESB4HproSzPSXcN9e9VJz5hWLqhTLYX
         EBpf1Ke5PD7MfOhoTJZLWS69tixxl38a0nmpB0zRByiKxD2ZPM233jsfCgK7mMsvSmK+
         GIs7zSzrfBwyO/vnIqaH+p1sjDiULq0FFQpzP8MNoP68/KufW0/Mw5gu8eyQ1H3Vfie3
         UTFg==
X-Forwarded-Encrypted: i=1; AJvYcCVJPXJs/2rz4V7eFvYSfvnKdEx37VP44+jJd5qQNpzw/Jr315IGJsTgg3SwWnTiBmXkNajp0MznwBjNOHtJgjP0TP2bPR06
X-Gm-Message-State: AOJu0YzzKMwaAcvfYRvvJzaXRBRcweL0eDEc0NmjkC7ZfPm9mzLXmNCU
	G9W6UGZZQdnDA8jywuF6waFOwIsuiZwVHMNCg3aMT8MuNbOLXwBjM8Zz+y5yAw==
X-Google-Smtp-Source: AGHT+IFnNm+vMtCK3Yp65be/YsX5bllZfe6RwxOWz/1G+jPzJyCYGnW9HxLNT/hKV+v73WnI/scHLg==
X-Received: by 2002:a05:6a20:12c3:b0:1be:bff2:b1b5 with SMTP id adf61e73a8af0-1bef60fedf7mr9222938637.15.1720013303748;
        Wed, 03 Jul 2024 06:28:23 -0700 (PDT)
Received: from thinkpad ([220.158.156.98])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c7067sm103413965ad.51.2024.07.03.06.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:28:23 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:58:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v4 1/3] bus: mhi: host: Add Foxconn SDX72 related
 support
Message-ID: <20240703132819.GA4342@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
 <20240701162523.GC133366@thinkpad>
 <c156594.626c.190722739f2.Coremail.slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c156594.626c.190722739f2.Coremail.slark_xiao@163.com>

On Tue, Jul 02, 2024 at 02:34:51PM +0800, Slark Xiao wrote:
> 
> At 2024-07-02 00:25:23, "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org> wrote:
> >On Mon, Jul 01, 2024 at 10:12:14AM +0800, Slark Xiao wrote:
> >> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> >> And also, add firehose support since SDX72.
> >> 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> >> ---
> >> v2: (1). Update the edl file path and name (2). Set SDX72 support
> >> trigger edl mode by default
> >> v3: Divide into 2 parts for Foxconn sdx72 platform
> >> ---
> >>  drivers/bus/mhi/host/pci_generic.c | 43 ++++++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >> 
> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> index 35ae7cd0711f..1fb1c2f2fe12 100644
> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> @@ -399,6 +399,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
> >>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
> >>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
> >>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> >> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> >> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
> >>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
> >>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
> >>  };
> >> @@ -419,6 +421,16 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
> >>  	.event_cfg = mhi_foxconn_sdx55_events,
> >>  };
> >>  
> >> +static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> >> +	.max_channels = 128,
> >> +	.timeout_ms = 20000,
> >> +	.ready_timeout_ms = 50000,
> >> +	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> >> +	.ch_cfg = mhi_foxconn_sdx55_channels,
> >> +	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> >> +	.event_cfg = mhi_foxconn_sdx55_events,
> >
> >Weird. Why this modem is using all SDX55 configs? Reusing is fine, but it is
> >strange to see only this SDX72 modem using different config than the others
> >added below.
> >
> >- Mani
> >
> 
> There is a settings ".ready_timeout_ms = 50000," for SDX72/SDX75 only.
> It aligns with Qcom SDX72/SDX75 in case of timeout issue.
> 
> >> +};
> >> +
> >>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> >>  	.name = "foxconn-sdx55",
> >>  	.fw = "qcom/sdx55m/sbl1.mbn",
> >> @@ -488,6 +500,28 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
> >>  	.sideband_wake = false,
> >>  };
> >>  
> >> +static const struct mhi_pci_dev_info mhi_foxconn_t99w515_info = {
> >> +	.name = "foxconn-t99w515",
> >> +	.edl = "fox/sdx72m/edl.mbn",
> >> +	.edl_trigger = true,
> >> +	.config = &modem_foxconn_sdx72_config,
> >> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> +	.dma_data_width = 32,
> >> +	.mru_default = 32768,
> >> +	.sideband_wake = false,
> >> +};
> >> +
> >> +static const struct mhi_pci_dev_info mhi_foxconn_dw5934e_info = {
> >> +	.name = "foxconn-dw5934e",
> >> +	.edl = "fox/sdx72m/edl.mbn",
> >> +	.edl_trigger = true,
> >> +	.config = &modem_foxconn_sdx72_config,
> >> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> +	.dma_data_width = 32,
> >> +	.mru_default = 32768,
> >> +	.sideband_wake = false,
> >> +};
> >> +
> >>  static const struct mhi_channel_config mhi_mv3x_channels[] = {
> >>  	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
> >>  	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
> >> @@ -720,6 +754,15 @@ static const struct pci_device_id mhi_pci_id_table[] = {
> >>  	/* DW5932e (sdx62), Non-eSIM */
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
> >>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
> >> +	/* T99W515 (sdx72) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe118),
> >> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w515_info },
> >> +	/* DW5934e(sdx72), With eSIM */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11d),
> >> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5934e_info },
> >> +	/* DW5934e(sdx72), Non-eSIM */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11e),
> >> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5934e_info },
> >>  	/* MV31-W (Cinterion) */
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
> >>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> >> -- 
> >> 2.25.1
> >> 
> >
> >-- 
> >மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

