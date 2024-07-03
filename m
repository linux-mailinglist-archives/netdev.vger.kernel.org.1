Return-Path: <netdev+bounces-108879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B527926224
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D140D282B9A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5E180A8A;
	Wed,  3 Jul 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kps1hx/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFB417C9E8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014422; cv=none; b=oPyp1KgL+vYl6YDbRRUjJhReh/yyLSbigfzRIJ6rs15oJX8lJd2Fw/iJycCGCHs83N0hywVGhOV6FYwkveezfpJwki9+jFacDJfK8y65/ZR3FA6jnXdKHaq3iAf6zn7S41geyLHsW9Kw5C1wrUxD0e5HG8EEBet4yHvJtlBP030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014422; c=relaxed/simple;
	bh=5WVExtaEHDKto3KKgolPo6JtDfTL/rQ7o/bxZ1uFyC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoTUs6WAPwvALRqXaKbLWvoVxozzKK1Usx2CWiYZeBDOJGPBmFtLw3LpDp9H/Ais5o7DuRTxQNYgJ0PDa4ENuSwH4yLG+zdtU/77CexDqPVzM7q8/CBK47DBoKqAdefCYR11qPtV3TLanyEkZbcTYeO6pF3WlDerYVEBYgcMy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kps1hx/k; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fa07e4f44eso35812655ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720014420; x=1720619220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sw99LfshwrAWELMzadgmDLcrDXjQox7eX5nx5nWqw9o=;
        b=kps1hx/kD7aJwWFXDox2Hn3yGWMyczEMJTzLqFVMaapKLrJVfohSqfsmyUC3Imm8t4
         hVBx/7u3pRuVISegmbo7Uv6B26A4ydCfl+7mKZiQJYjssknPp23Oc7+kBf3bbxyqBqei
         e6Gqh0Pcqez/X/YLEbl6cGJ7+HZUi7KNocX5x1WxJKZVrNjpWIZhZcBJ8u4MhNixr/nz
         4loK3XNBTLDTSOnWshXCawl7qvnmFlSJSMlGtLi3y8cP3I/u/ayaEL1B4jMum+/tw53L
         IOfTR3fnvuKmtWCbJ61Ao7pNKmmb3FGRWfd+NNoU4cmS58msXR5uR8a2NVtghaK+DkVu
         jvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014420; x=1720619220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sw99LfshwrAWELMzadgmDLcrDXjQox7eX5nx5nWqw9o=;
        b=npjLXq5tYs09pbfzUd4NYXGT73Qzgp4k9fKEbDFInlUkNFvT0/ZpOVi9isjxQ38FsH
         71ci3tXaEye49bm9e+AIaQoDE+JV2+RD30P10nuSfxTpiL5pVcdC9VlIseNu9AUwnBRZ
         RituA8yv6Mnb1TTx5VD9Qwv13xk7JDooweceMLCjOElLFYnXIG83xzPtYjnJO3/mE8Q2
         IUthoQbIexaaFm2EPrgnc84CsD5ydgfCzwgy13HFK5pZWDQLrJ2a2FvnZXQasLcpSmX5
         jBnsVfU+1Pl0pUb9Z//BwwfAfkniHQMXQMrTWxL8Smht47MgegX5jjjHbRtIrrpj7g7H
         NF0A==
X-Forwarded-Encrypted: i=1; AJvYcCUOoauPdJCG3cb1/I7A9UBkDZmQ07CxJiRnVNHOZz7c+InT/dn4PLLMN5MUEpsv/steaji3A9EJwiigLsF4Gq9B9D1QqazV
X-Gm-Message-State: AOJu0YwBkkQSRJjxwe3DlOwvjng8R8XUqIqU3H2uAvbHMONlxfhjvSyF
	2XRZ4NlX2LN34sPv0PYJgSVpxdTPmWDyWlPlxCBx9//KSeS/iCjzpmAUAc4UreOTMihOJvIQ7+0
	=
X-Google-Smtp-Source: AGHT+IE4BSW435CJ7S1sExcvff+VTjaUh0Rva08TLajdYQovnLK0ErBFW3QyOK8Bt86yYhlFMSktsA==
X-Received: by 2002:a17:90b:1294:b0:2c7:c6c4:1693 with SMTP id 98e67ed59e1d1-2c93d71f47emr10181146a91.21.1720014420134;
        Wed, 03 Jul 2024 06:47:00 -0700 (PDT)
Received: from thinkpad ([220.158.156.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce43303sm10740716a91.17.2024.07.03.06.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:46:59 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:16:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] net: wwan: mhi: make default data link id
 configurable
Message-ID: <20240703134655.GD4342@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
 <20240701021216.17734-3-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701021216.17734-3-slark_xiao@163.com>

On Mon, Jul 01, 2024 at 10:12:16AM +0800, Slark Xiao wrote:
> For SDX72 MBIM mode, it starts data mux id from 112 instead of 0.
> This would lead to device can't ping outside successfully.
> Also MBIM side would report "bad packet session (112)". In order
> to fix this issue, we decide to use the device name of MHI
> controller to do a match in wwan side. Then wwan driver could
> set a corresponding mux_id value according to the MHI product.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to mhi-next with Jakub's ACK!

- Mani

> ---
> v2: Remove Fix flag
> v3: Use name match solution instead of use mux_id
> ---
>  drivers/net/wwan/mhi_wwan_mbim.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index 3f72ae943b29..e481ced496d8 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -42,6 +42,8 @@
>  #define MHI_MBIM_LINK_HASH_SIZE 8
>  #define LINK_HASH(session) ((session) % MHI_MBIM_LINK_HASH_SIZE)
>  
> +#define WDS_BIND_MUX_DATA_PORT_MUX_ID 112
> +
>  struct mhi_mbim_link {
>  	struct mhi_mbim_context *mbim;
>  	struct net_device *ndev;
> @@ -93,6 +95,15 @@ static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim
>  	return NULL;
>  }
>  
> +static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
> +{
> +	if (strcmp(cntrl->name, "foxconn-dw5934e") == 0 ||
> +	    strcmp(cntrl->name, "foxconn-t99w515") == 0)
> +		return WDS_BIND_MUX_DATA_PORT_MUX_ID;
> +
> +	return 0;
> +}
> +
>  static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
>  				     u16 tx_seq)
>  {
> @@ -596,7 +607,7 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
>  {
>  	struct mhi_controller *cntrl = mhi_dev->mhi_cntrl;
>  	struct mhi_mbim_context *mbim;
> -	int err;
> +	int err, link_id;
>  
>  	mbim = devm_kzalloc(&mhi_dev->dev, sizeof(*mbim), GFP_KERNEL);
>  	if (!mbim)
> @@ -617,8 +628,11 @@ static int mhi_mbim_probe(struct mhi_device *mhi_dev, const struct mhi_device_id
>  	/* Number of transfer descriptors determines size of the queue */
>  	mbim->rx_queue_sz = mhi_get_free_desc_count(mhi_dev, DMA_FROM_DEVICE);
>  
> +	/* Get the corresponding mux_id from mhi */
> +	link_id = mhi_mbim_get_link_mux_id(cntrl);
> +
>  	/* Register wwan link ops with MHI controller representing WWAN instance */
> -	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, 0);
> +	return wwan_register_ops(&cntrl->mhi_dev->dev, &mhi_mbim_wwan_ops, mbim, link_id);
>  }
>  
>  static void mhi_mbim_remove(struct mhi_device *mhi_dev)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

