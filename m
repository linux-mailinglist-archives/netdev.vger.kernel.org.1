Return-Path: <netdev+bounces-164544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE00A2E224
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 03:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0572C3A4752
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 02:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933A25760;
	Mon, 10 Feb 2025 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YIktDj/C"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75283D3B3
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739153578; cv=none; b=aO/znD7rjDZsA+7bDgXpzD2w4vIPHBpgGVEpYaVNGCdyAZJfZNyk445lJNGvNnR5us/FaYTkXdUA/Iv0ykVK1AK8C99Lt41Y7P7rWvtz9fKnzBJp0IoZM7OfcfjFtm4iIg986yOXPrw/f3BDAzK1QsJQFgx2RQN4FL0IRTi2Zjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739153578; c=relaxed/simple;
	bh=zg0532LxoHL6vEbEEc7retLEcn74qqIhiqcJ4chtAOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPa21dHHwh/CxiEfQ7/6Lqya46reotPfNsFSIcm4nQJxOlVPjYm/p4zzzJF6hHyg4IcNl7f9zb5wPZoC/5z6MRWeuukmmGurexV0x071WpjbWo8QJXsTcOTraFUiNi5pCLyVrI6h0m42vdehJB1s+X9xeJrYuGHu1HA8KNGLoCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YIktDj/C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519KBsDE024312
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rpmdF1Rnc9/NsCNm9SOlPO1mOdH4yrsT2cCwJQzffRQ=; b=YIktDj/CUkyF9Eq+
	UC6aCpjjBva8cqkEMUfw8BI++vIHraGRoq2ooUb/9453QTZZlSCzByCmGS3ZiLrn
	5F1xFmGolbaeL9kl/1VizdAWVI8gC5GXZ/uXio6y9Nc4r5sAt9NfWzm5Ranwz88e
	TNj/vBBKs7wXqk2E5pSOB7J0oPB8YjX+WtjNyfkFlqCOaqNjhlTN/XdDZ3v4pe7e
	KUJ0ThxG4RE7TiF7c+fa7QO4CgXT4qRbATZ1zHRKFAuwd0F9UL/sEyQMX5ajh/lP
	RvZjbJ4MMGSXxzRJixJpvQ539dbU5QCMnDziX22myvKy3NfgA4OUP+ik/ogB8vUK
	jfnxFQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dxjtgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 02:12:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f464b9954so60818735ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Feb 2025 18:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739153567; x=1739758367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpmdF1Rnc9/NsCNm9SOlPO1mOdH4yrsT2cCwJQzffRQ=;
        b=FqC+yLa8mjhcorrZwFzXoe4f39wl/gCVIaUa3xZWAF1YVbD890r9rwtdUAvObumcqC
         JjMhUzhyA8ltoazVpVE7kRHOlEJ4e7uOkvJKYo5yoRKwxZ+TLCrkYj+V6K4cUJV0i05x
         ErDFKyEL0UPsYCDzQZBm9yE3j72Xv2GEEaVAO7GKVRrZw5v/2E7yPjIKKQdgoEa2J1m6
         yURFqfux1cFP9WBxAidOZJC450uCcSMauz+3ueejhZ6hlWXBVGJd+dOJg1ajC3YsC5z4
         wYF4MwTE+YtwiLN2vEBhpToMay264cRE07UN10l1CsFHsPRCoNnzeWGM/fbidjM2A3Sb
         0VDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU35leCPClPPTIr738vtumiHmJvr7LiO2M4fFg7h/VdMNyePY4EL+Lc9HOpXP0qOmuc08757HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMf+MjUQVlO9khfsAvzTZb+7z5qGrOz2qD8zLITvyVBmxre9J
	pO2EelpBp8/2Gi65ohWHCmziFcolWKFm+rMOcrimqY2NSB5gPEplELhxAOKRmQUECcYY1V/T1UW
	ZPX+jILL4Vn4tnSSHQyccKtGT8MeQY8n3tSl+hZW8i70Xjo0gTDo2VyM=
X-Gm-Gg: ASbGncumVgb8ElkSi2j96bZ4KlGNQx9nd9qkRdkKv+12atKrIrvBhmJMLOWk1c+Nzwm
	y9wCjONpEN0A30/OTrZqcGg+8T4rSUoFFq44byyJIw3NJOMC4cvVyETRl7BMj3+h/mfJJL8XW1O
	/m9Lt07UoxpMAriT8dyqryLbobmTAV+zx8y6Tl0RsyGfWpcmpz6iZj27InqAoqolwsZB5gh59Am
	4HJBcMQSggbbozuqmWEYU08+LNcG7f6KMn271+KlyR3kD1+HMnfFcsRXwI6t1u0+yLIE5YaKYz/
	28+4PK4UR9WGX6UmqVwtHy6rVE5tblBrGu/xcD0UwX2wyX7XA2MgE7rC5L27D+Q=
X-Received: by 2002:a05:6a20:9c9a:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1ee052ce872mr19099364637.12.1739153566965;
        Sun, 09 Feb 2025 18:12:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFc5O/uCO3z9TBjwxHuwPv68BL++jliZvMnB6lrZNaTSTkptrnCAXOUYjybUKCxsKhWaSBCvA==
X-Received: by 2002:a05:6a20:9c9a:b0:1e0:c166:18ba with SMTP id adf61e73a8af0-1ee052ce872mr19099316637.12.1739153566489;
        Sun, 09 Feb 2025 18:12:46 -0800 (PST)
Received: from [10.133.33.8] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7308c4d0d3esm1120722b3a.31.2025.02.09.18.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 18:12:45 -0800 (PST)
Message-ID: <58e05149-abc2-4cf4-a6e8-35380823d94a@oss.qualcomm.com>
Date: Mon, 10 Feb 2025 10:12:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 03/14] net: ethernet: qualcomm: Add PPE driver
 for IPQ9574 SoC
To: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com,
        srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org,
        john@phrozen.org
References: <20250209-qcom_ipq_ppe-v3-0-453ea18d3271@quicinc.com>
 <20250209-qcom_ipq_ppe-v3-3-453ea18d3271@quicinc.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250209-qcom_ipq_ppe-v3-3-453ea18d3271@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Qtfb9oRDzPiOTsX0_Frcnzv3Az7BWr-3
X-Proofpoint-ORIG-GUID: Qtfb9oRDzPiOTsX0_Frcnzv3Az7BWr-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_01,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502100016



On 2/9/2025 10:29 PM, Luo Jie wrote:
> The PPE (Packet Process Engine) hardware block is available
> on Qualcomm IPQ SoC that support PPE architecture, such as
> IPQ9574.
> 
> The PPE in IPQ9574 includes six integrated ethernet MAC
> (for 6 PPE ports), buffer management, queue management and
> scheduler functions. The MACs can connect with the external
> PHY or switch devices using the UNIPHY PCS block available
> in the SoC.
> 
> The PPE also includes various packet processing offload
> capabilities such as L3 routing and L2 bridging, VLAN and
> tunnel processing offload. It also includes Ethernet DMA
> function for transferring packets between ARM cores and
> PPE ethernet ports.
> 
> This patch adds the base source files and Makefiles for
> the PPE driver such as platform driver registration,
> clock initialization, and PPE reset routines.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>   drivers/net/ethernet/qualcomm/Kconfig      |  15 ++
>   drivers/net/ethernet/qualcomm/Makefile     |   1 +
>   drivers/net/ethernet/qualcomm/ppe/Makefile |   7 +
>   drivers/net/ethernet/qualcomm/ppe/ppe.c    | 218 +++++++++++++++++++++++++++++
>   drivers/net/ethernet/qualcomm/ppe/ppe.h    |  36 +++++
>   5 files changed, 277 insertions(+)
> 
> diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
> index 9210ff360fdc..59931c4edbeb 100644
> --- a/drivers/net/ethernet/qualcomm/Kconfig
> +++ b/drivers/net/ethernet/qualcomm/Kconfig
> @@ -61,6 +61,21 @@ config QCOM_EMAC
>   	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
>   	  Precision Clock Synchronization Protocol.
>   
> +config QCOM_PPE
> +	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK
> +	select REGMAP_MMIO
> +	help
> +	  This driver supports the Qualcomm Technologies, Inc. packet
> +	  process engine (PPE) available with IPQ SoC. The PPE includes
> +	  the ethernet MACs, Ethernet DMA (EDMA) and switch core that
> +	  supports L3 flow offload, L2 switch function, RSS and tunnel
> +	  offload.
> +
> +	  To compile this driver as a module, choose M here. The module
> +	  will be called qcom-ppe.
> +
>   source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
>   
>   endif # NET_VENDOR_QUALCOMM
> diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
> index 9250976dd884..166a59aea363 100644
> --- a/drivers/net/ethernet/qualcomm/Makefile
> +++ b/drivers/net/ethernet/qualcomm/Makefile
> @@ -11,4 +11,5 @@ qcauart-objs := qca_uart.o
>   
>   obj-y += emac/
>   
> +obj-$(CONFIG_QCOM_PPE) += ppe/
>   obj-$(CONFIG_RMNET) += rmnet/
> diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
> new file mode 100644
> index 000000000000..63d50d3b4f2e
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the device driver of PPE (Packet Process Engine) in IPQ SoC
> +#
> +
> +obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
> +qcom-ppe-objs := ppe.o
> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> new file mode 100644
> index 000000000000..40da7d240594
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/* PPE platform device probe, DTSI parser and PPE clock initializations. */
> +
> +#include <linux/clk.h>
> +#include <linux/interconnect.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "ppe.h"
> +
> +#define PPE_PORT_MAX		8
> +#define PPE_CLK_RATE		353000000
> +
> +/* ICC clocks for enabling PPE device. The avg_bw and peak_bw with value 0
> + * will be updated by the clock rate of PPE.
> + */
> +static const struct icc_bulk_data ppe_icc_data[] = {
> +	{
> +		.name = "ppe",
> +		.avg_bw = 0,
> +		.peak_bw = 0,
> +	},
> +	{
> +		.name = "ppe_cfg",
> +		.avg_bw = 0,
> +		.peak_bw = 0,
> +	},
> +	{
> +		.name = "qos_gen",
> +		.avg_bw = 6000,
> +		.peak_bw = 6000,
> +	},
> +	{
> +		.name = "timeout_ref",
> +		.avg_bw = 6000,
> +		.peak_bw = 6000,
> +	},
> +	{
> +		.name = "nssnoc_memnoc",
> +		.avg_bw = 533333,
> +		.peak_bw = 533333,
> +	},
> +	{
> +		.name = "memnoc_nssnoc",
> +		.avg_bw = 533333,
> +		.peak_bw = 533333,
> +	},
> +	{
> +		.name = "memnoc_nssnoc_1",
> +		.avg_bw = 533333,
> +		.peak_bw = 533333,
> +	},
> +};
> +
> +static const struct regmap_range ppe_readable_ranges[] = {
> +	regmap_reg_range(0x0, 0x1ff),		/* Global */
> +	regmap_reg_range(0x400, 0x5ff),		/* LPI CSR */
> +	regmap_reg_range(0x1000, 0x11ff),	/* GMAC0 */
> +	regmap_reg_range(0x1200, 0x13ff),	/* GMAC1 */
> +	regmap_reg_range(0x1400, 0x15ff),	/* GMAC2 */
> +	regmap_reg_range(0x1600, 0x17ff),	/* GMAC3 */
> +	regmap_reg_range(0x1800, 0x19ff),	/* GMAC4 */
> +	regmap_reg_range(0x1a00, 0x1bff),	/* GMAC5 */
> +	regmap_reg_range(0xb000, 0xefff),	/* PRX CSR */
> +	regmap_reg_range(0xf000, 0x1efff),	/* IPE */
> +	regmap_reg_range(0x20000, 0x5ffff),	/* PTX CSR */
> +	regmap_reg_range(0x60000, 0x9ffff),	/* IPE L2 CSR */
> +	regmap_reg_range(0xb0000, 0xeffff),	/* IPO CSR */
> +	regmap_reg_range(0x100000, 0x17ffff),	/* IPE PC */
> +	regmap_reg_range(0x180000, 0x1bffff),	/* PRE IPO CSR */
> +	regmap_reg_range(0x1d0000, 0x1dffff),	/* Tunnel parser */
> +	regmap_reg_range(0x1e0000, 0x1effff),	/* Ingress parse */
> +	regmap_reg_range(0x200000, 0x2fffff),	/* IPE L3 */
> +	regmap_reg_range(0x300000, 0x3fffff),	/* IPE tunnel */
> +	regmap_reg_range(0x400000, 0x4fffff),	/* Scheduler */
> +	regmap_reg_range(0x500000, 0x503fff),	/* XGMAC0 */
> +	regmap_reg_range(0x504000, 0x507fff),	/* XGMAC1 */
> +	regmap_reg_range(0x508000, 0x50bfff),	/* XGMAC2 */
> +	regmap_reg_range(0x50c000, 0x50ffff),	/* XGMAC3 */
> +	regmap_reg_range(0x510000, 0x513fff),	/* XGMAC4 */
> +	regmap_reg_range(0x514000, 0x517fff),	/* XGMAC5 */
> +	regmap_reg_range(0x600000, 0x6fffff),	/* BM */
> +	regmap_reg_range(0x800000, 0x9fffff),	/* QM */
> +	regmap_reg_range(0xb00000, 0xbef800),	/* EDMA */
> +};
> +
> +static const struct regmap_access_table ppe_reg_table = {
> +	.yes_ranges = ppe_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ppe_readable_ranges),
> +};
> +
> +static const struct regmap_config regmap_config_ipq9574 = {
> +	.reg_bits = 32,
> +	.reg_stride = 4,
> +	.val_bits = 32,
> +	.rd_table = &ppe_reg_table,
> +	.wr_table = &ppe_reg_table,
> +	.max_register = 0xbef800,
> +	.fast_io = true,
> +};
> +
> +static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
> +{
> +	unsigned long ppe_rate = ppe_dev->clk_rate;
> +	struct device *dev = ppe_dev->dev;
> +	struct reset_control *rstc;
> +	struct clk_bulk_data *clks;
> +	struct clk *clk;
> +	int ret, i;
> +
> +	for (i = 0; i < ppe_dev->num_icc_paths; i++) {
> +		ppe_dev->icc_paths[i].name = ppe_icc_data[i].name;
> +		ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? :
> +					       Bps_to_icc(ppe_rate);
it's ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? 
ppe_icc_data[i].avg_bw : Bps_to_icc(ppe_rate);  ?


> +		ppe_dev->icc_paths[i].peak_bw = ppe_icc_data[i].peak_bw ? :
> +						Bps_to_icc(ppe_rate);
Same with previous one?

> +	}
> +
> +	ret = devm_of_icc_bulk_get(dev, ppe_dev->num_icc_paths,
> +				   ppe_dev->icc_paths);
> +	if (ret)
> +		return ret;
> +
> +	ret = icc_bulk_set_bw(ppe_dev->num_icc_paths, ppe_dev->icc_paths);
> +	if (ret)
> +		return ret;
> +
> +	/* The PPE clocks have a common parent clock. Setting the clock
Should be:
/*
  * The PPE clocks have a common parent clock. Setting the clock
  * rate of "ppe" ensures the clock rate of all PPE clocks is
  * configured to the same rate.
  */

BTW, it's better wrapped with ~75 characters per line.

> +	 * rate of "ppe" ensures the clock rate of all PPE clocks is
> +	 * configured to the same rate.
> +	 */
> +	clk = devm_clk_get(dev, "ppe");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	ret = clk_set_rate(clk, ppe_rate);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Reset the PPE. */
> +	rstc = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(rstc))
> +		return PTR_ERR(rstc);
> +
> +	ret = reset_control_assert(rstc);
> +	if (ret)
> +		return ret;
> +
> +	/* The delay 10 ms of assert is necessary for resetting PPE. */
> +	usleep_range(10000, 11000);
> +
> +	return reset_control_deassert(rstc);
> +}
> +
> +static int qcom_ppe_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ppe_device *ppe_dev;
> +	void __iomem *base;
> +	int ret, num_icc;
I think it's better with:
	int num_icc = ARRAY_SIZE(ppe_icc_data);

> +
> +	num_icc = ARRAY_SIZE(ppe_icc_data);
> +	ppe_dev = devm_kzalloc(dev, struct_size(ppe_dev, icc_paths, num_icc),
> +			       GFP_KERNEL);
> +	if (!ppe_dev)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base), "PPE ioremap failed\n");
> +
> +	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, &regmap_config_ipq9574);
> +	if (IS_ERR(ppe_dev->regmap))
> +		return dev_err_probe(dev, PTR_ERR(ppe_dev->regmap),
> +				     "PPE initialize regmap failed\n");
> +	ppe_dev->dev = dev;
> +	ppe_dev->clk_rate = PPE_CLK_RATE;
> +	ppe_dev->num_ports = PPE_PORT_MAX;
> +	ppe_dev->num_icc_paths = num_icc;
> +
> +	ret = ppe_clock_init_and_reset(ppe_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "PPE clock config failed\n");
> +
> +	platform_set_drvdata(pdev, ppe_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_ppe_of_match[] = {
> +	{ .compatible = "qcom,ipq9574-ppe" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);
> +
> +static struct platform_driver qcom_ppe_driver = {
> +	.driver = {
> +		.name = "qcom_ppe",
> +		.of_match_table = qcom_ppe_of_match,
> +	},
> +	.probe	= qcom_ppe_probe,
> +};
> +module_platform_driver(qcom_ppe_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. IPQ PPE driver");
> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
> new file mode 100644
> index 000000000000..cc6767b7c2b8
> --- /dev/null
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0-only
> + *
> + * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef __PPE_H__
> +#define __PPE_H__
> +
> +#include <linux/compiler.h>
> +#include <linux/interconnect.h>
> +
> +struct device;
#include <linux/device.h> ?

> +struct regmap;
Same with previous one, include it's header file?

> +
> +/**
> + * struct ppe_device - PPE device private data.
> + * @dev: PPE device structure.
> + * @regmap: PPE register map.
> + * @clk_rate: PPE clock rate.
> + * @num_ports: Number of PPE ports.
> + * @num_icc_paths: Number of interconnect paths.
> + * @icc_paths: Interconnect path array.
> + *
> + * PPE device is the instance of PPE hardware, which is used to
> + * configure PPE packet process modules such as BM (buffer management),
> + * QM (queue management), and scheduler.
> + */
> +struct ppe_device {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	unsigned long clk_rate;
> +	unsigned int num_ports;
> +	unsigned int num_icc_paths;
> +	struct icc_bulk_data icc_paths[] __counted_by(num_icc_paths);
> +};
> +#endif
> 

Thanks,
Jie


