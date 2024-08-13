Return-Path: <netdev+bounces-117982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4A95027D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A273C1C20A97
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2711898E6;
	Tue, 13 Aug 2024 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SqNplxsL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D0E42AB9
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545073; cv=none; b=bmsV3EHCn1NKcIHEgUvafvgxVl5t5/Ns+k/SQhgBE48r7qcab1alfk3FzeEe+eFQ7tYSvUbv/9a2SGJ0FgI9VvWsblAXIvehyuZfcv1e4tdbLqyScg11EKDvFRCt8hIlBBsJdxTX/ygWpwIOQtm4i1Ged25mCn7r+U4zrORbh3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545073; c=relaxed/simple;
	bh=Qemy//FKBAOaddDCdfMrlr9kRUC4yXU0upqAkPghsKY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dmdRj5FSRROGznPYU5AYtWc+VSKnLtObW+DArjVttAxLjZL2mTH7M/AlqIcqqFAbxPZ2LUqAaIGoiRmSXZUKXaJCiP826cpQqsyOpQJIXZFWPQTG4o2ZJKqs30uzeU37/mDwK+NDrxyz9eGD48b9GwOkx1vEy5gbkv9cgI/KE1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SqNplxsL; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D9SJ8S005863;
	Tue, 13 Aug 2024 03:31:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=II9nA/T/OCR7vUWsar7cg39Az
	PisJqlMX1AJ4T49eAw=; b=SqNplxsLelrgU8tGGR6HjwRpDJ9iLvGQHIisB4ypW
	C6/NvNdMr5N+UVjRbG1+kTdu+l9TcHs+IdA2BMDRVMeljMnTSABCB/Yl4dVrVyWQ
	tRiTzxcLc+x+cXRJnI4agADCTu2T0bDVqvqsjSDNlxLEa+tEOdUYqrnmB7YHQBZc
	FcOVEATedj8Udein0NbvhzYWf5DK2GV0L+/7yw5jg4AaCdC+FfMQ1pfpYNnhVix0
	S9XfNUSjY9MELktG3wZHOJ9nc3p5So/f+LVP8nb/6PT9+NwQwMNN9EKP48CeiScc
	1IZjOb2ayi4ihVHy0evO3Khd7YR9FX8n088/kG6kpyjkw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4100cjh1g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 03:31:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 13 Aug 2024 03:30:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 13 Aug 2024 03:30:59 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 72ADD3F704B;
	Tue, 13 Aug 2024 03:30:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:00:54 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <willemb@google.com>,
        <jeroendb@google.com>, <shailend@google.com>, <hramamurthy@google.com>,
        <jfraker@google.com>, Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [PATCH net-next v3 1/2] gve: Add RSS device option
Message-ID: <Zrs13uJmpA2eD3Yb@test-OptiPlex-Tower-Plus-7010>
References: <20240812222013.1503584-1-pkaligineedi@google.com>
 <20240812222013.1503584-2-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812222013.1503584-2-pkaligineedi@google.com>
X-Proofpoint-ORIG-GUID: 2e3l2Ozkg9slSW-eZg96ypABoQF65BuJ
X-Proofpoint-GUID: 2e3l2Ozkg9slSW-eZg96ypABoQF65BuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_02,2024-08-13_01,2024-05-17_01

On 2024-08-13 at 03:50:12, Praveen Kaligineedi (pkaligineedi@google.com) wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> Add a device option to inform the driver about the hash key size and
> hash table size used by the device. This information will be stored and
> made available for RSS ethtool operations.
> 
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
> Changes in v2:
> 	- Unify the RSS argument order in related functions(Jakub Kicinski)
> 
>  drivers/net/ethernet/google/gve/gve.h        |  3 ++
>  drivers/net/ethernet/google/gve/gve_adminq.c | 36 ++++++++++++++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h | 15 +++++++-
>  3 files changed, 51 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 84ac004d3953..6c21f3c53619 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -831,6 +831,9 @@ struct gve_priv {
>  	u32 num_flow_rules;
>  
>  	struct gve_flow_rules_cache flow_rules_cache;
> +
> +	u16 rss_key_size;
> +	u16 rss_lut_size;
>  };
>  
>  enum gve_service_task_flags_bit {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index c5bbc1b7524e..b5c801d2f8b5 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -45,6 +45,7 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
>  			     struct gve_device_option_flow_steering **dev_op_flow_steering,
> +			     struct gve_device_option_rss_config **dev_op_rss_config,
>  			     struct gve_device_option_modify_ring **dev_op_modify_ring)
>  {
>  	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
> @@ -207,6 +208,23 @@ void gve_parse_device_option(struct gve_priv *priv,
>  				 "Flow Steering");
>  		*dev_op_flow_steering = (void *)(option + 1);
>  		break;
> +	case GVE_DEV_OPT_ID_RSS_CONFIG:
> +		if (option_length < sizeof(**dev_op_rss_config) ||
> +		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG) {
> +			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
> +				 "RSS config",
> +				 (int)sizeof(**dev_op_rss_config),
> +				 GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG,
> +				 option_length, req_feat_mask);
> +			break;
> +		}
> +
> +		if (option_length > sizeof(**dev_op_rss_config))
> +			dev_warn(&priv->pdev->dev,
> +				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
> +				 "RSS config");
> +		*dev_op_rss_config = (void *)(option + 1);
> +		break;
>  	default:
>  		/* If we don't recognize the option just continue
>  		 * without doing anything.
> @@ -227,6 +245,7 @@ gve_process_device_options(struct gve_priv *priv,
>  			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
>  			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes,
>  			   struct gve_device_option_flow_steering **dev_op_flow_steering,
> +			   struct gve_device_option_rss_config **dev_op_rss_config,
>  			   struct gve_device_option_modify_ring **dev_op_modify_ring)
>  {
>  	const int num_options = be16_to_cpu(descriptor->num_device_options);
> @@ -249,7 +268,8 @@ gve_process_device_options(struct gve_priv *priv,
>  					dev_op_gqi_rda, dev_op_gqi_qpl,
>  					dev_op_dqo_rda, dev_op_jumbo_frames,
>  					dev_op_dqo_qpl, dev_op_buffer_sizes,
> -					dev_op_flow_steering, dev_op_modify_ring);
> +					dev_op_flow_steering, dev_op_rss_config,
> +					dev_op_modify_ring);
>  		dev_opt = next_opt;
>  	}
>  
> @@ -867,6 +887,8 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  					  *dev_op_buffer_sizes,
>  					  const struct gve_device_option_flow_steering
>  					  *dev_op_flow_steering,
> +					  const struct gve_device_option_rss_config
> +					  *dev_op_rss_config,
>  					  const struct gve_device_option_modify_ring
>  					  *dev_op_modify_ring)
>  {
> @@ -931,6 +953,14 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  				 priv->max_flow_rules);
>  		}
>  	}
> +
> +	if (dev_op_rss_config &&
> +	    (supported_features_mask & GVE_SUP_RSS_CONFIG_MASK)) {
> +		priv->rss_key_size =
> +			be16_to_cpu(dev_op_rss_config->hash_key_size);
> +		priv->rss_lut_size =
> +			be16_to_cpu(dev_op_rss_config->hash_lut_size);
> +	}
>  }
>  
>  int gve_adminq_describe_device(struct gve_priv *priv)
> @@ -939,6 +969,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
>  	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
>  	struct gve_device_option_modify_ring *dev_op_modify_ring = NULL;
> +	struct gve_device_option_rss_config *dev_op_rss_config = NULL;
>  	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
>  	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
>  	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
> @@ -973,6 +1004,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  					 &dev_op_jumbo_frames, &dev_op_dqo_qpl,
>  					 &dev_op_buffer_sizes,
>  					 &dev_op_flow_steering,
> +					 &dev_op_rss_config,
>  					 &dev_op_modify_ring);
>  	if (err)
>  		goto free_device_descriptor;
> @@ -1035,7 +1067,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	gve_enable_supported_features(priv, supported_features_mask,
>  				      dev_op_jumbo_frames, dev_op_dqo_qpl,
>  				      dev_op_buffer_sizes, dev_op_flow_steering,
> -				      dev_op_modify_ring);
> +				      dev_op_rss_config, dev_op_modify_ring);
>  
>  free_device_descriptor:
>  	dma_pool_free(priv->adminq_pool, descriptor, descriptor_bus);
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index ed1370c9b197..7d9ef9a12fef 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -164,6 +164,14 @@ struct gve_device_option_flow_steering {
>  
>  static_assert(sizeof(struct gve_device_option_flow_steering) == 12);
>  
> +struct gve_device_option_rss_config {
> +	__be32 supported_features_mask;
> +	__be16 hash_key_size;
> +	__be16 hash_lut_size;
> +};
> +
> +static_assert(sizeof(struct gve_device_option_rss_config) == 8);
> +
>  /* Terminology:
>   *
>   * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
> @@ -182,6 +190,7 @@ enum gve_dev_opt_id {
>  	GVE_DEV_OPT_ID_JUMBO_FRAMES		= 0x8,
>  	GVE_DEV_OPT_ID_BUFFER_SIZES		= 0xa,
>  	GVE_DEV_OPT_ID_FLOW_STEERING		= 0xb,
> +	GVE_DEV_OPT_ID_RSS_CONFIG		= 0xe,
>  };
>  
>  enum gve_dev_opt_req_feat_mask {
> @@ -194,6 +203,7 @@ enum gve_dev_opt_req_feat_mask {
>  	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES		= 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_MODIFY_RING		= 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_FLOW_STEERING		= 0x0,
> +	GVE_DEV_OPT_REQ_FEAT_MASK_RSS_CONFIG		= 0x0,
>  };
>  
>  enum gve_sup_feature_mask {
> @@ -201,6 +211,7 @@ enum gve_sup_feature_mask {
>  	GVE_SUP_JUMBO_FRAMES_MASK	= 1 << 2,
>  	GVE_SUP_BUFFER_SIZES_MASK	= 1 << 4,
>  	GVE_SUP_FLOW_STEERING_MASK	= 1 << 5,
> +	GVE_SUP_RSS_CONFIG_MASK		= 1 << 7,
Use BIT()

Thanks,
Hariprasad k
>  };

