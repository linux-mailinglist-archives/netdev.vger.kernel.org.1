Return-Path: <netdev+bounces-94403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D59588BF590
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513941F24018
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 05:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED698171C8;
	Wed,  8 May 2024 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="oAVcA8fz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACA98BEC
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146382; cv=none; b=p5TWp8so2RdsJYe708u0epnUWEqxaaFXYX7IQAhShaMT6vt5U4smylsemys7pJqDhW4J0QXZti8TYIYZVjK1KEZAQVyCPxj8WhnkqeGtRSjDLp+Y9DwDv8nbWMZSHgrivWpLIRo3OvsLvFkgMEUg3nQXE734kFEUzTTvbK4ABpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146382; c=relaxed/simple;
	bh=uvlv85irOMn7K5jYsVKAs9qgW0mTbU+UpeSMMCX249k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PU4qwXc5aIhZyuxgNBtR/BYeRIHErp5s2ikKy4ZYltdxgRmxNWAWG/7FgNVTtlUb/Ih2vecbuabunZJpmtLbqJWpg5zfVbX0W+U/zxAC7ypg86oyEetgM0FWRZX/hOjujNJwhJobQv/mIDWkcGBBmAV7UFXl7TaPU97QkY+H6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=oAVcA8fz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so3688587b3a.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 22:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715146380; x=1715751180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7z2inzLi35jYcAozXrfSqIyI+3Z9eMChQC+kOQV6nc=;
        b=oAVcA8fzOg6eboS1FN6cKG1HEqjmpx8qVgmPMY0CW/PeSMVJRB+KjP2uk5fXmN+aqu
         Pil5mIz4J0NQNEWCrRN/k+9GBSQaHom97tjr1gPIooRe1y507Ka6+bQPHzoYP6AggXVV
         R33WbyaO6dOgbncti1gpvrtq8/78TAon56ojEzDW/CXSYcWmZBxWVvJ0o0uGxCQhXWQK
         72b37VK5RG110ljt1BEMzRe77Pwkq0sD9voQ3nXYRioIFZHYtnqc3DcK2huQju9WbMO3
         YcLIpRO988GoOztAQUFGuil8DW9FWW1ATiiZOWcuaOOcuQpkIdprIsKHnlu1PHkHyG5P
         Ee1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715146380; x=1715751180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7z2inzLi35jYcAozXrfSqIyI+3Z9eMChQC+kOQV6nc=;
        b=PP2aDjjuN3xQ9796v8MYgqmlvUSKwM+UOT6coeHQ2DXIrSdq5IiZYy1bgFSqvT+ZrP
         RTDl9baBD9FwatgKFAFdAYf0OAxQjvFma1tytYpRvHxP5gk4MB6TYf+MwgUgwuNv7jNf
         DZi0J/Ozmn49wukZ9549ltvmJ02pifrnw23Fsymuckd9gT6VJo7y6BqSh/r7FP9lQJZN
         CIdKF0O7fgYdR2kXsKOirqjPGYHhurbWbWE4qA0r2vsY7et6XzkdLxolEL25vW+beN6m
         P96ZKQ8MEyMT93mIfm30Qx+MOw+m5+y9QXFyOkI41cn7BEw61bdHJlB8aAK9TpJ/qrQP
         Z03Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0LU4+CysMb3gJZSQM8TSyhljCirMSRSMxWRxp9eF+0PlSULBMiyS9tx6QBW48r7S9oaFT5Hp463XL3yGA7Dop+j5mw6/d
X-Gm-Message-State: AOJu0YzgLkZIpw1NycXipc1nkDRndhN5GqamOqsYZxb1ewQTQ5zITW9h
	oE1icS6EUF0ncb1SK9DGzY3mXpEZ1r4xUF0FfXX1h4QkAjrfN6qvfKNx4FFcIFw=
X-Google-Smtp-Source: AGHT+IEI2Oe1zxJZFCfXAS+uoQqFyDaHNSMEFJjksj2JCwT4gEL7UHmwExgaxm7joPaYRsiGrVs16Q==
X-Received: by 2002:a05:6a20:9692:b0:1ad:7e66:659a with SMTP id adf61e73a8af0-1afc8d26376mr1637400637.15.1715146380290;
        Tue, 07 May 2024 22:33:00 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id d23-20020a17090ad3d700b002b439dc7b86sm512124pjw.7.2024.05.07.22.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 22:32:59 -0700 (PDT)
Message-ID: <6a98fda2-54f4-4c1d-9b4a-bd39abe27179@davidwei.uk>
Date: Tue, 7 May 2024 22:32:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] gve: Add flow steering device option
Content-Language: en-GB
To: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, hramamurthy@google.com,
 rushilg@google.com, jfraker@google.com, linux-kernel@vger.kernel.org
References: <20240507225945.1408516-1-ziweixiao@google.com>
 <20240507225945.1408516-4-ziweixiao@google.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240507225945.1408516-4-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-07 15:59, Ziwei Xiao wrote:
> From: Jeroen de Borst <jeroendb@google.com>
> 
> Add a new device option to signal to the driver that the device supports
> flow steering. This device option also carries the maximum number of
> flow steering rules that the device can store.
> 
> Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        |  2 +
>  drivers/net/ethernet/google/gve/gve_adminq.c | 42 ++++++++++++++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h | 11 +++++
>  3 files changed, 51 insertions(+), 4 deletions(-)

Think something went wrong here. The title is different but patch is
same as 2/5.

> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index ca7fce17f2c0..58213c15e084 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -786,6 +786,8 @@ struct gve_priv {
>  
>  	u16 header_buf_size; /* device configured, header-split supported if non-zero */
>  	bool header_split_enabled; /* True if the header split is enabled by the user */
> +
> +	u32 max_flow_rules;
>  };
>  
>  enum gve_service_task_flags_bit {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 514641b3ccc7..85d0d742ad21 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -44,6 +44,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
>  			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
> +			     struct gve_device_option_flow_steering **dev_op_flow_steering,
>  			     struct gve_device_option_modify_ring **dev_op_modify_ring)
>  {
>  	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
> @@ -189,6 +190,23 @@ void gve_parse_device_option(struct gve_priv *priv,
>  		if (option_length == GVE_DEVICE_OPTION_NO_MIN_RING_SIZE)
>  			priv->default_min_ring_size = true;
>  		break;
> +	case GVE_DEV_OPT_ID_FLOW_STEERING:
> +		if (option_length < sizeof(**dev_op_flow_steering) ||
> +		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING) {
> +			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
> +				 "Flow Steering",
> +				 (int)sizeof(**dev_op_flow_steering),
> +				 GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING,
> +				 option_length, req_feat_mask);
> +			break;
> +		}
> +
> +		if (option_length > sizeof(**dev_op_flow_steering))
> +			dev_warn(&priv->pdev->dev,
> +				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
> +				 "Flow Steering");
> +		*dev_op_flow_steering = (void *)(option + 1);
> +		break;
>  	default:
>  		/* If we don't recognize the option just continue
>  		 * without doing anything.
> @@ -208,6 +226,7 @@ gve_process_device_options(struct gve_priv *priv,
>  			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
>  			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
> +			   struct gve_device_option_flow_steering **dev_op_flow_steering,
>  			   struct gve_device_option_modify_ring **dev_op_modify_ring)
>  {
>  	const int num_options = be16_to_cpu(descriptor->num_device_options);
> @@ -230,7 +249,7 @@ gve_process_device_options(struct gve_priv *priv,
>  					dev_op_gqi_rda, dev_op_gqi_qpl,
>  					dev_op_dqo_rda, dev_op_jumbo_frames,
>  					dev_op_dqo_qpl, dev_op_buffer_sizes,
> -					dev_op_modify_ring);
> +					dev_op_flow_steering, dev_op_modify_ring);
>  		dev_opt = next_opt;
>  	}
>  
> @@ -838,6 +857,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  					  *dev_op_dqo_qpl,
>  					  const struct gve_device_option_buffer_sizes
>  					  *dev_op_buffer_sizes,
> +					  const struct gve_device_option_flow_steering
> +					  *dev_op_flow_steering,
>  					  const struct gve_device_option_modify_ring
>  					  *dev_op_modify_ring)
>  {
> @@ -890,10 +911,22 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  			priv->min_tx_desc_cnt = be16_to_cpu(dev_op_modify_ring->min_tx_ring_size);
>  		}
>  	}
> +
> +	if (dev_op_flow_steering &&
> +	    (supported_features_mask & GVE_SUP_FLOW_STEERING_MASK)) {
> +		if (dev_op_flow_steering->max_flow_rules) {
> +			priv->max_flow_rules =
> +				be32_to_cpu(dev_op_flow_steering->max_flow_rules);
> +			dev_info(&priv->pdev->dev,
> +				 "FLOW STEERING device option enabled with max rule limit of %u.\n",
> +				 priv->max_flow_rules);
> +		}
> +	}
>  }
>  
>  int gve_adminq_describe_device(struct gve_priv *priv)
>  {
> +	struct gve_device_option_flow_steering *dev_op_flow_steering = NULL;
>  	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
>  	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
>  	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
> @@ -930,6 +963,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
>  					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
>  					 &dev_op_buffer_sizes,
> +					 &dev_op_flow_steering,
>  					 &dev_op_modify_ring);
>  	if (err)
>  		goto free_device_descriptor;
> @@ -969,9 +1003,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	/* set default descriptor counts */
>  	gve_set_default_desc_cnt(priv, descriptor);
>  
> -	/* DQO supports LRO. */
>  	if (!gve_is_gqi(priv))
> -		priv->dev->hw_features |= NETIF_F_LRO;
> +		priv->dev->hw_features |= NETIF_F_LRO | NETIF_F_NTUPLE;
>  
>  	priv->max_registered_pages =
>  				be64_to_cpu(descriptor->max_registered_pages);
> @@ -991,7 +1024,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  
>  	gve_enable_supported_features(priv, supported_features_mask,
>  				      dev_op_jumbo_frames, dev_op_dqo_qpl,
> -				      dev_op_buffer_sizes, dev_op_modify_ring);
> +				      dev_op_buffer_sizes, dev_op_flow_steering,
> +				      dev_op_modify_ring);
>  
>  free_device_descriptor:
>  	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index e0370ace8397..e64a0e72e781 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -146,6 +146,14 @@ struct gve_device_option_modify_ring {
>  
>  static_assert(sizeof(struct gve_device_option_modify_ring) == 12);
>  
> +struct gve_device_option_flow_steering {
> +	__be32 supported_features_mask;
> +	__be32 reserved;
> +	__be32 max_flow_rules;
> +};
> +
> +static_assert(sizeof(struct gve_device_option_flow_steering) == 12);
> +
>  /* Terminology:
>   *
>   * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
> @@ -163,6 +171,7 @@ enum gve_dev_opt_id {
>  	GVE_DEV_OPT_ID_DQO_QPL			= 0x7,
>  	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
>  	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
> +	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
>  };
>  
>  enum gve_dev_opt_req_feat_mask {
> @@ -174,12 +183,14 @@ enum gve_dev_opt_req_feat_mask {
>  	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL		= 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
> +	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
>  };
>  
>  enum gve_sup_feature_mask {
>  	GVE_SUP_MODIFY_RING_MASK	= 1 << 0,
>  	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
>  	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
> +	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
>  };
>  
>  #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0

