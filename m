Return-Path: <netdev+bounces-108877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C8926211
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4169C282C65
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F6617B418;
	Wed,  3 Jul 2024 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxnttMfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5217A5A9
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014383; cv=none; b=c/p/3hk5HHs+/xKAhepG0TCTIhozj55W9vKk1aTqjPoeD/RRHGmCcUki2klXRHfMc4mdjKYo4Ldlhpy7fnWD0oOe0047CNW1D6evmd4ZUCEpvW/6w3XcAWuIIFKOSa7EgYMcfrdusKwg72BgKZ7pABmI/8K5iqLpw1JmbHn/yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014383; c=relaxed/simple;
	bh=/m6A+sXoU4Olg6HTeHCABBg9ut0WZrDY9nPjeBeXu2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMzNGD6IBsxvNPsHqQYY/koHqVSI/vOTOjcWE1V0CkFonE9swj0RQTUWX/BKTHM7iEioyJEPPBvbpzWbAU/m4O5oOZLRCi3TtEwnmis9cbPE1gxF2nVbdlesC9AWzSFuSgiVoM7uy9PWip9LOmzedDyQ5nAB/HZ6P5RoaXsBxOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HxnttMfA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-75a6c290528so329786a12.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720014381; x=1720619181; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bf+gEq9Qv4j2DaejyoY0EnJO0snP/b2OWlh18sSmCtA=;
        b=HxnttMfAn3tuNMuEG6PxLR3uCCkn1CEHyb1QYrRd6ISEV3ezk6dr+FXFedyY4XcWn4
         gOqJRhG67Xj1TtUoxaRPpGHgAkzBFBzBa5cBv8pgPyzPvJxOKNGhHTkBV3RM9cxWWiSf
         rH08kpUyb1gdEbw1eKWkb4nmhLiK1VGbYHoDsS0JnqN1P3sTfK2aHuXkdq+5BKWm386d
         2Kx5OrWk7x8nIJLGowHsnEX6DVRFZkOAER/nfdXLsffCkuIOEmczPwHASREU8sX26Z8v
         K0+iKliW+ZMwe7GQTkL0DZHbC9KIo1jDxuMb/W3rrfyNi5MkauNoFd+77dnrNmiFX5xt
         xC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014381; x=1720619181;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf+gEq9Qv4j2DaejyoY0EnJO0snP/b2OWlh18sSmCtA=;
        b=Z2MvuQANwDTzsdDfSuxIZ3diDx6lbVXTujRSyIOMb1/pvi3toY4Pxfw/s3xq6gKUGM
         nTUnfBW+3mILSUvpKEVAGtpe7Ws3OIEusqNvufrIpbuPfDf8bIAPLW2is186PCH9FGSF
         87LlI29Qd7ID7COPGY7AOXe3rDYg4nLU+aJZBnyPgtPZ5CqblOKT4PmxX5Xr7ti5ghws
         ko9OFOvu2OAFaS5XBUX8odpBwc0fp2t6USZji7hDeI0phEftlan+LdjexN4D//sNrFyT
         vh9xk43uhXvAEV0CI0P9lT/EGzWwN26ahlMlowZdqEE4ehsuF/g4c/RukXX8U37gz/w3
         5r9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdJZDbcmiADspx64G5+ReyzGvbzuN/b4Q3FOpnXZzhLd4KcUpzG8UxK3eZNHEzqyN+Re6WkDprxrFwCyTcfHICJO4ysq/R
X-Gm-Message-State: AOJu0YwpwybGqluBzkpEQOVOs+bFitjidl9ugTqvMzqrrzlwgrQ7ewcs
	urAl9kNQxSfWO5HxN697Aa2ieMd4BEaevNjssQQwlLeDTPyLK9LJit8s2PYBug==
X-Google-Smtp-Source: AGHT+IFbgy8xFgSDq57ntgaSsYgc8vIgCPq4hdC8aq3qDRUkMazMF18pniYYlOiILpepBoDGTQuepQ==
X-Received: by 2002:a05:6a20:3c94:b0:1be:c4b9:c216 with SMTP id adf61e73a8af0-1bef60f3c38mr12064525637.7.1720014381428;
        Wed, 03 Jul 2024 06:46:21 -0700 (PDT)
Received: from thinkpad ([220.158.156.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3e7d7bsm10761774a91.47.2024.07.03.06.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:46:20 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:16:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] bus: mhi: host: Add name for mhi_controller
Message-ID: <20240703134616.GC4342@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
 <20240701021216.17734-2-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701021216.17734-2-slark_xiao@163.com>

On Mon, Jul 01, 2024 at 10:12:15AM +0800, Slark Xiao wrote:
> For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> This would lead to device can't ping outside successfully.
> Also MBIM side would report "bad packet session (112)".In order to
> fix this issue, we decide to use the device name of MHI controller
> to do a match in client driver side. Then client driver could set
> a corresponding mux_id value for this MHI product.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next with fixup to commit subject and description and also fixed
the issue spotted by Jeff!

- Mani

> ---
> v2: Remove Fix flag
> v3: Use name match solution instead of use mux_id
> v4: Update the description of new member 'name' and move it to
> right position
> ---
>  drivers/bus/mhi/host/pci_generic.c | 1 +
>  include/linux/mhi.h                | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 1fb1c2f2fe12..14a11880bcea 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1086,6 +1086,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_cntrl->runtime_get = mhi_pci_runtime_get;
>  	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
>  	mhi_cntrl->mru = info->mru_default;
> +	mhi_cntrl->name = info->name;
>  
>  	if (info->edl_trigger)
>  		mhi_cntrl->edl_trigger = mhi_pci_generic_edl_trigger;
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index b573f15762f8..d45058d3dbed 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -289,6 +289,7 @@ struct mhi_controller_config {
>  };
>  
>  /**
> + * @name: device name of the MHI controller
>   * struct mhi_controller - Master MHI controller structure
>   * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
>   *            controller (required)
> @@ -367,6 +368,7 @@ struct mhi_controller_config {
>   * they can be populated depending on the usecase.
>   */
>  struct mhi_controller {
> +	const char *name;
>  	struct device *cntrl_dev;
>  	struct mhi_device *mhi_dev;
>  	struct dentry *debugfs_dentry;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

