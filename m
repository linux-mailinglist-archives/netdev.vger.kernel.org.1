Return-Path: <netdev+bounces-201601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9999AEA0B5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924081C40448
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C42ECD0A;
	Thu, 26 Jun 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X1sczBfQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A982EBDD9;
	Thu, 26 Jun 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948313; cv=none; b=mHjDmFKU9g+LUhzUj5IxXiAEPQPGjxOofFLiFf5E/xPpuala/aUCA1XO6mgwAw/1Mtw2fFaYGEF8YdCz+jxJtxjtwG3oBhM7KoPhlJYxLceMUdREDOQs1NZzeAyMZi+Ohp627x9K+wVsNOEonacnh7dWYSIXy2rxlqmaofy3qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948313; c=relaxed/simple;
	bh=lkmTN4t4WivbNTxAHDqiJIKhuSJDIQsCTqueN+9FQJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AL2bFmfw6+2Km0CisiVnSpdjrFoIl40Is8pGULWnxmfJdOAAPlY/NQfLZc9nmE8y/jnpBq6ACceWqsGlbWiEIv2sVXhgNoNf+Pg0qPtKXYvaiNF7SJSwlij4aenoVwnWkArO0MmQOU4YZcliz6reiWHxHwZoiNBk9N7wtcw7lD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X1sczBfQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9Un0T026632;
	Thu, 26 Jun 2025 14:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bhvMdAKHRb9G1OrvV/mMdinuEbMVMbqMl7vnW8xfDTk=; b=X1sczBfQVBb+hfO6
	srjB95v76gxmL3Nf1XCcC55XPvpRvdAqvJIFbE01k2pvioUjrhoYZiysr/7J+Vu+
	gUkEeFxPx5F6bsxR4KJCQvfIXuOWulNUop7vS53+ZFxyx/pf4bAh/Jxg63k9y0yl
	WuzNoqzVGdp6ocmn0SpR76tz1pvOb2h5JxDKCRA29071z4g8hL+8UJl7JHHTJj1P
	XAl+QplUGu3oKNYWMj/CObfnMjkgV867xO5uuAWefaEheCa7JsxhFb7USSnfFQYX
	oVJ/M3h+4kldr/MUZoY5i1g2MoOmkoY4ux3U6cI9+cNhrSFHKFSskiYCaeaaQ3+M
	DOYEug==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5vt0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 14:31:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55QEVcQl026710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 14:31:38 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 26 Jun 2025 07:31:33 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Thu, 26 Jun 2025 22:31:02 +0800
Subject: [PATCH net-next v5 03/14] net: ethernet: qualcomm: Add PPE driver
 for IPQ9574 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250626-qcom_ipq_ppe-v5-3-95bdc6b8f6ff@quicinc.com>
References: <20250626-qcom_ipq_ppe-v5-0-95bdc6b8f6ff@quicinc.com>
In-Reply-To: <20250626-qcom_ipq_ppe-v5-0-95bdc6b8f6ff@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal
	<quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>,
        "Simon
 Horman" <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook
	<kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <quic_kkumarcs@quicinc.com>, <quic_linchen@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750948277; l=10777;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=lkmTN4t4WivbNTxAHDqiJIKhuSJDIQsCTqueN+9FQJI=;
 b=gVQCqPgQ6j9/PvQFSZrvbRnQjgrkQVeXKGWo44eF3Duh9jtzpdtVirYMROG3MFMB+6Sh89383
 3S27c90FAn6Awa2a8OlaHqDO2H4u+m19Lf3FjmswkcI/b4n2Ijt7eeq
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SPzoNvDrPcWyEVbUj-QonIcq5AX1-3NB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEyMyBTYWx0ZWRfX8AzhBNmbpyah
 7clzDPRVjUAYDE/uWYeX+qJaJDzaRP7SbpEm1AgEhdETyRar+zPsAsIjIQ5BWIqXLoMrcZqmYWa
 o+aQ8CbkB0qlNUDOMygff2om2SEkQ4/pHq3lYrMHfs7KW5Uqim84SokYZGTX3AL+jUbybpJisJd
 V2dqRbm5ZKTiN1GlEZWttbLcCwBwMt6Rxu439IDIBvY71Z7QcTrhBIhDHPYmko8Lxnv/ZkoxUlx
 Z8PKvYqQOLu5Lm9vRQmPyXI+QvjHmYKYILMXOPvSh8czbvPSAm3sj4uIfOwGrzY7V3IZ32vEIaQ
 AWk+WEZVTenXvcoGNuPl1FXer+YCvdlOysZIbv/ACDds+azAVKCr1riwcjsbBc1ZY6r5xiooMB7
 IbD/aAcR8/kgZuDqaDDt4zjdb6jqtp3O4I/25iHKxN2LOoPERkVuydzW/GzAHI4sbTpAAhGh
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685d59cb cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=PqS_UfTMPIexogC6Pa0A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SPzoNvDrPcWyEVbUj-QonIcq5AX1-3NB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260123

The PPE (Packet Process Engine) hardware block is available on Qualcomm
IPQ SoC that support PPE architecture, such as IPQ9574.

The PPE in IPQ9574 includes six integrated ethernet MAC for 6 PPE ports,
buffer management, queue management and scheduler functions. The MACs
can connect with the external PHY or switch devices using the UNIPHY PCS
block available in the SoC.

The PPE also includes various packet processing offload capabilities
such as L3 routing and L2 bridging, VLAN and tunnel processing offload.
It also includes Ethernet DMA function for transferring packets between
ARM cores and PPE ethernet ports.

This patch adds the base source files and Makefiles for the PPE driver
such as platform driver registration, clock initialization, and PPE
reset routines.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/Kconfig      |  15 ++
 drivers/net/ethernet/qualcomm/Makefile     |   1 +
 drivers/net/ethernet/qualcomm/ppe/Makefile |   7 +
 drivers/net/ethernet/qualcomm/ppe/ppe.c    | 218 +++++++++++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe.h    |  36 +++++
 5 files changed, 277 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/Kconfig b/drivers/net/ethernet/qualcomm/Kconfig
index a4434eb38950..6e56b022fc2d 100644
--- a/drivers/net/ethernet/qualcomm/Kconfig
+++ b/drivers/net/ethernet/qualcomm/Kconfig
@@ -60,6 +60,21 @@ config QCOM_EMAC
 	  low power, Receive-Side Scaling (RSS), and IEEE 1588-2008
 	  Precision Clock Synchronization Protocol.
 
+config QCOM_PPE
+	tristate "Qualcomm Technologies, Inc. PPE Ethernet support"
+	depends on HAS_IOMEM && OF
+	depends on COMMON_CLK
+	select REGMAP_MMIO
+	help
+	  This driver supports the Qualcomm Technologies, Inc. packet
+	  process engine (PPE) available with IPQ SoC. The PPE includes
+	  the ethernet MACs, Ethernet DMA (EDMA) and switch core that
+	  supports L3 flow offload, L2 switch function, RSS and tunnel
+	  offload.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called qcom-ppe.
+
 source "drivers/net/ethernet/qualcomm/rmnet/Kconfig"
 
 endif # NET_VENDOR_QUALCOMM
diff --git a/drivers/net/ethernet/qualcomm/Makefile b/drivers/net/ethernet/qualcomm/Makefile
index 9250976dd884..166a59aea363 100644
--- a/drivers/net/ethernet/qualcomm/Makefile
+++ b/drivers/net/ethernet/qualcomm/Makefile
@@ -11,4 +11,5 @@ qcauart-objs := qca_uart.o
 
 obj-y += emac/
 
+obj-$(CONFIG_QCOM_PPE) += ppe/
 obj-$(CONFIG_RMNET) += rmnet/
diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
new file mode 100644
index 000000000000..63d50d3b4f2e
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the device driver of PPE (Packet Process Engine) in IPQ SoC
+#
+
+obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
+qcom-ppe-objs := ppe.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
new file mode 100644
index 000000000000..40da7d240594
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE platform device probe, DTSI parser and PPE clock initializations. */
+
+#include <linux/clk.h>
+#include <linux/interconnect.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include "ppe.h"
+
+#define PPE_PORT_MAX		8
+#define PPE_CLK_RATE		353000000
+
+/* ICC clocks for enabling PPE device. The avg_bw and peak_bw with value 0
+ * will be updated by the clock rate of PPE.
+ */
+static const struct icc_bulk_data ppe_icc_data[] = {
+	{
+		.name = "ppe",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "ppe_cfg",
+		.avg_bw = 0,
+		.peak_bw = 0,
+	},
+	{
+		.name = "qos_gen",
+		.avg_bw = 6000,
+		.peak_bw = 6000,
+	},
+	{
+		.name = "timeout_ref",
+		.avg_bw = 6000,
+		.peak_bw = 6000,
+	},
+	{
+		.name = "nssnoc_memnoc",
+		.avg_bw = 533333,
+		.peak_bw = 533333,
+	},
+	{
+		.name = "memnoc_nssnoc",
+		.avg_bw = 533333,
+		.peak_bw = 533333,
+	},
+	{
+		.name = "memnoc_nssnoc_1",
+		.avg_bw = 533333,
+		.peak_bw = 533333,
+	},
+};
+
+static const struct regmap_range ppe_readable_ranges[] = {
+	regmap_reg_range(0x0, 0x1ff),		/* Global */
+	regmap_reg_range(0x400, 0x5ff),		/* LPI CSR */
+	regmap_reg_range(0x1000, 0x11ff),	/* GMAC0 */
+	regmap_reg_range(0x1200, 0x13ff),	/* GMAC1 */
+	regmap_reg_range(0x1400, 0x15ff),	/* GMAC2 */
+	regmap_reg_range(0x1600, 0x17ff),	/* GMAC3 */
+	regmap_reg_range(0x1800, 0x19ff),	/* GMAC4 */
+	regmap_reg_range(0x1a00, 0x1bff),	/* GMAC5 */
+	regmap_reg_range(0xb000, 0xefff),	/* PRX CSR */
+	regmap_reg_range(0xf000, 0x1efff),	/* IPE */
+	regmap_reg_range(0x20000, 0x5ffff),	/* PTX CSR */
+	regmap_reg_range(0x60000, 0x9ffff),	/* IPE L2 CSR */
+	regmap_reg_range(0xb0000, 0xeffff),	/* IPO CSR */
+	regmap_reg_range(0x100000, 0x17ffff),	/* IPE PC */
+	regmap_reg_range(0x180000, 0x1bffff),	/* PRE IPO CSR */
+	regmap_reg_range(0x1d0000, 0x1dffff),	/* Tunnel parser */
+	regmap_reg_range(0x1e0000, 0x1effff),	/* Ingress parse */
+	regmap_reg_range(0x200000, 0x2fffff),	/* IPE L3 */
+	regmap_reg_range(0x300000, 0x3fffff),	/* IPE tunnel */
+	regmap_reg_range(0x400000, 0x4fffff),	/* Scheduler */
+	regmap_reg_range(0x500000, 0x503fff),	/* XGMAC0 */
+	regmap_reg_range(0x504000, 0x507fff),	/* XGMAC1 */
+	regmap_reg_range(0x508000, 0x50bfff),	/* XGMAC2 */
+	regmap_reg_range(0x50c000, 0x50ffff),	/* XGMAC3 */
+	regmap_reg_range(0x510000, 0x513fff),	/* XGMAC4 */
+	regmap_reg_range(0x514000, 0x517fff),	/* XGMAC5 */
+	regmap_reg_range(0x600000, 0x6fffff),	/* BM */
+	regmap_reg_range(0x800000, 0x9fffff),	/* QM */
+	regmap_reg_range(0xb00000, 0xbef800),	/* EDMA */
+};
+
+static const struct regmap_access_table ppe_reg_table = {
+	.yes_ranges = ppe_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ppe_readable_ranges),
+};
+
+static const struct regmap_config regmap_config_ipq9574 = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.rd_table = &ppe_reg_table,
+	.wr_table = &ppe_reg_table,
+	.max_register = 0xbef800,
+	.fast_io = true,
+};
+
+static int ppe_clock_init_and_reset(struct ppe_device *ppe_dev)
+{
+	unsigned long ppe_rate = ppe_dev->clk_rate;
+	struct device *dev = ppe_dev->dev;
+	struct reset_control *rstc;
+	struct clk_bulk_data *clks;
+	struct clk *clk;
+	int ret, i;
+
+	for (i = 0; i < ppe_dev->num_icc_paths; i++) {
+		ppe_dev->icc_paths[i].name = ppe_icc_data[i].name;
+		ppe_dev->icc_paths[i].avg_bw = ppe_icc_data[i].avg_bw ? :
+					       Bps_to_icc(ppe_rate);
+		ppe_dev->icc_paths[i].peak_bw = ppe_icc_data[i].peak_bw ? :
+						Bps_to_icc(ppe_rate);
+	}
+
+	ret = devm_of_icc_bulk_get(dev, ppe_dev->num_icc_paths,
+				   ppe_dev->icc_paths);
+	if (ret)
+		return ret;
+
+	ret = icc_bulk_set_bw(ppe_dev->num_icc_paths, ppe_dev->icc_paths);
+	if (ret)
+		return ret;
+
+	/* The PPE clocks have a common parent clock. Setting the clock
+	 * rate of "ppe" ensures the clock rate of all PPE clocks is
+	 * configured to the same rate.
+	 */
+	clk = devm_clk_get(dev, "ppe");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_set_rate(clk, ppe_rate);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_bulk_get_all_enabled(dev, &clks);
+	if (ret < 0)
+		return ret;
+
+	/* Reset the PPE. */
+	rstc = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
+
+	ret = reset_control_assert(rstc);
+	if (ret)
+		return ret;
+
+	/* The delay 10 ms of assert is necessary for resetting PPE. */
+	usleep_range(10000, 11000);
+
+	return reset_control_deassert(rstc);
+}
+
+static int qcom_ppe_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ppe_device *ppe_dev;
+	void __iomem *base;
+	int ret, num_icc;
+
+	num_icc = ARRAY_SIZE(ppe_icc_data);
+	ppe_dev = devm_kzalloc(dev, struct_size(ppe_dev, icc_paths, num_icc),
+			       GFP_KERNEL);
+	if (!ppe_dev)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "PPE ioremap failed\n");
+
+	ppe_dev->regmap = devm_regmap_init_mmio(dev, base, &regmap_config_ipq9574);
+	if (IS_ERR(ppe_dev->regmap))
+		return dev_err_probe(dev, PTR_ERR(ppe_dev->regmap),
+				     "PPE initialize regmap failed\n");
+	ppe_dev->dev = dev;
+	ppe_dev->clk_rate = PPE_CLK_RATE;
+	ppe_dev->num_ports = PPE_PORT_MAX;
+	ppe_dev->num_icc_paths = num_icc;
+
+	ret = ppe_clock_init_and_reset(ppe_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "PPE clock config failed\n");
+
+	platform_set_drvdata(pdev, ppe_dev);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_ppe_of_match[] = {
+	{ .compatible = "qcom,ipq9574-ppe" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_ppe_of_match);
+
+static struct platform_driver qcom_ppe_driver = {
+	.driver = {
+		.name = "qcom_ppe",
+		.of_match_table = qcom_ppe_of_match,
+	},
+	.probe	= qcom_ppe_probe,
+};
+module_platform_driver(qcom_ppe_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. IPQ PPE driver");
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
new file mode 100644
index 000000000000..cc6767b7c2b8
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __PPE_H__
+#define __PPE_H__
+
+#include <linux/compiler.h>
+#include <linux/interconnect.h>
+
+struct device;
+struct regmap;
+
+/**
+ * struct ppe_device - PPE device private data.
+ * @dev: PPE device structure.
+ * @regmap: PPE register map.
+ * @clk_rate: PPE clock rate.
+ * @num_ports: Number of PPE ports.
+ * @num_icc_paths: Number of interconnect paths.
+ * @icc_paths: Interconnect path array.
+ *
+ * PPE device is the instance of PPE hardware, which is used to
+ * configure PPE packet process modules such as BM (buffer management),
+ * QM (queue management), and scheduler.
+ */
+struct ppe_device {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned long clk_rate;
+	unsigned int num_ports;
+	unsigned int num_icc_paths;
+	struct icc_bulk_data icc_paths[] __counted_by(num_icc_paths);
+};
+#endif

-- 
2.34.1


