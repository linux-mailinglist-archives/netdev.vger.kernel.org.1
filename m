Return-Path: <netdev+bounces-212774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F4BB21DE8
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711A73AF49D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 06:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988B2D948C;
	Tue, 12 Aug 2025 06:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Oe6iIyCx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E193229BDBF;
	Tue, 12 Aug 2025 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978609; cv=none; b=eQgngeTaucNzSYkfnzEp56A+vzLfdh+mJjxvl30wc+bu2oBP4eVVItRdypF1kD10x8EeO1sY/ZTh0ZW34GomkEQnulREVOsr6U/COmaU8x5umC5CrxRTI6a1OGinzeNdkh/XOSuM09eD6kSOk7BgRVUESVC5n+6T4RHQUAnARTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978609; c=relaxed/simple;
	bh=BOm7AEsgiMrW87suG/yLBgr60mr9/oXp7XxqveuKoPo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8PplqVAY06IWU6KgtzIhf60QsgicwGmFVH7thT1uoYeAXdWEYandRwxDbNPi2S5qVLODTDxEENtt1Hqn7XDVzP6gxrOziniDfGhkqIqG6TQ2APvLaAejkxAxf6OVy0PbfMMqP8whgcuvObBFtK+dw7cs+sLdkhT5o1CNky0OFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Oe6iIyCx; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BM1jLK021525;
	Mon, 11 Aug 2025 23:03:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=HZSBUEJQgQ67pMhpOI+NcoleH
	XpTN1lryOy8bcl66uk=; b=Oe6iIyCxYAswin6m1cJihtFJJNy6XDRsq4tCvEjoa
	YcIoAHIpefZZ6dHoc22EJipU4BAc54Z4AfG3lTzsZDuH3AiDV8Dg/9zA6TRtRttk
	f/c/KGPikrM2Oo9w/N9WCkZ46RxlACxN5mhQNALQXJ+6fGNDk+8VH/xs+vSZj5fD
	sYevLGu9zmyxsqtEiHZnWsgwJ0656ZXbsbIRDljzfLwei6F6ZuVxzeUplG3QXaDr
	Roh7TAudVYY8YIbl19dMqoExFZH1bI+fUQT2j/xAAd1rqYl8rGWxV0XQxZZc/N1V
	at20mW6NVfzU/+Qc+ZZY0HCybUfFmHJxGRFeeZZzFkfxA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48frxm8vxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:03:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 11 Aug 2025 23:03:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 11 Aug 2025 23:03:03 -0700
Received: from test-OptiPlex-Tower-Plus-7010 (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with SMTP id 0BA963F703F;
	Mon, 11 Aug 2025 23:02:51 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:32:48 +0530
From: Hariprasad Kelam <hkelam@marvell.com>
To: Vishal Badole <Vishal.Badole@amd.com>
CC: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] amd-xgbe: Configure and retrieve 'tx-usecs'
 for Tx coalescing
Message-ID: <aJrZCPV+QFVXoHVn@test-OptiPlex-Tower-Plus-7010>
References: <20250812045035.3376179-1-Vishal.Badole@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812045035.3376179-1-Vishal.Badole@amd.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA1NCBTYWx0ZWRfX0pAskhp2mLF4 J94xMtLPcV0Giq1b9fY63fS4NNE8XopqdEo2qvxFUUHX2KiD6ScQP0fpe3r5SgvVsyt/kKy5EmN rBwhhc9b2t5uB/KXWvUGSW+aAf2dro4NyRyJ/0fN9iiPoNQn/k1C6T0uXIe4YBCHpTHVc+BGnZN
 OpDlHg07He2MJNJ9wvPxtsUZANUn3FrCMVryPJHr5wCMXLDX2VsiqW9r59kajVHDpHhUj5dfnXT oH7WP4YwSQIUoISTKwepVj/XYvKZ7ldUHdLTSHzl9QPng9CtxdlLo3vH1fA9A6gY5tdxgklrb/7 YgAF/7Y6d73NZw8SxzQLLEcugmDPsuzzpUa8MEBuD2WrDoJTi+Kfx8jEixhfLM8L1JD+zqULlW5
 RTXPwTHEGccUMJbxtcEIFaXalX6x5pH+LXQFC/YEGVtiRH7hrntpxLYGlPxCHE5uT+Jks6zx
X-Authority-Analysis: v=2.4 cv=eKQTjGp1 c=1 sm=1 tr=0 ts=689ad914 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=zd2uoN0lAAAA:8 a=M5GUcnROAAAA:8 a=Wfs76xZ8JWsxpH59smMA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: KIxthRt-1FEStnkqpHuDMypIniL63jcf
X-Proofpoint-GUID: KIxthRt-1FEStnkqpHuDMypIniL63jcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01

On 2025-08-12 at 10:20:35, Vishal Badole (Vishal.Badole@amd.com) wrote:
> Ethtool has advanced with additional configurable options, but the
> current driver does not support tx-usecs configuration.
> 
> Add support to configure and retrieve 'tx-usecs' using ethtool, which
> specifies the wait time before servicing an interrupt for Tx coalescing.
> 
> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> 
> ---
> v1 -> v2:
>     * Replace netdev_err() with extack interface for user error reporting.
> ---
>  drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
>  drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 12395428ffe1..19cb1e2b7d92 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
>  	ec->rx_coalesce_usecs = pdata->rx_usecs;
>  	ec->rx_max_coalesced_frames = pdata->rx_frames;
>  
> +	ec->tx_coalesce_usecs = pdata->tx_usecs;
>  	ec->tx_max_coalesced_frames = pdata->tx_frames;
>  
>  	return 0;
> @@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>  	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>  	struct xgbe_hw_if *hw_if = &pdata->hw_if;
>  	unsigned int rx_frames, rx_riwt, rx_usecs;
> -	unsigned int tx_frames;
> +	unsigned int tx_frames, tx_usecs;
>  
>  	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
>  	rx_usecs = ec->rx_coalesce_usecs;
> @@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>  		return -EINVAL;
>  	}
>  
> +	tx_usecs = ec->tx_coalesce_usecs;
>  	tx_frames = ec->tx_max_coalesced_frames;
>  
> +	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
> +	if (!tx_usecs && !tx_frames) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "tx_usecs and tx_frames must not be 0 together");
> +		return -EINVAL;
> +	}
> +
>  	/* Check the bounds of values for Tx */
> +	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack, "tx-usecs is limited to %d usec",
> +				       XGMAC_MAX_COAL_TX_TICK);
> +		return -EINVAL;
> +	}
>  	if (tx_frames > pdata->tx_desc_count) {
>  		netdev_err(netdev, "tx-frames is limited to %d frames\n",
>  			   pdata->tx_desc_count);
> @@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
>  	pdata->rx_frames = rx_frames;
>  	hw_if->config_rx_coalesce(pdata);
>  
> +	pdata->tx_usecs = tx_usecs;
>  	pdata->tx_frames = tx_frames;
>  	hw_if->config_tx_coalesce(pdata);
>  
> @@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device *netdev,
>  }
>  
>  static const struct ethtool_ops xgbe_ethtool_ops = {
> -	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
> +	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
>  	.get_drvinfo = xgbe_get_drvinfo,
>  	.get_msglevel = xgbe_get_msglevel,
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
> index 42fa4f84ff01..e330ae9ea685 100755
> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
> @@ -272,6 +272,7 @@
>  /* Default coalescing parameters */
>  #define XGMAC_INIT_DMA_TX_USECS		1000
>  #define XGMAC_INIT_DMA_TX_FRAMES	25
> +#define XGMAC_MAX_COAL_TX_TICK		100000
>  
>  #define XGMAC_MAX_DMA_RIWT		0xff
>  #define XGMAC_INIT_DMA_RX_USECS		30
> -- 
> 2.34.1
> 
Reviewed-by: Hariprasad Kelam <hkelam@marvell.com> 

