Return-Path: <netdev+bounces-212958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E7CB22A7A
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3281BC41E2
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BC2F5337;
	Tue, 12 Aug 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bTsFhY6r"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE622C3245;
	Tue, 12 Aug 2025 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007930; cv=none; b=swB77vQ7lfT6+WaIx0UzxWefbS8fYt1kxt6oq5r0UumHfciz2AmLKnlJHomYDi5jy8TC4kmIy1cCI7aBno40NjdnnSxGPVp6G8UviqpQk/+6SD5uuhGP0MltouSoDE4NGnzWn238Gabe3/L0EW+kYRKPDsUqj5LYuDVlgUM7Wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007930; c=relaxed/simple;
	bh=S9mSrk749VGVRpK+cR8jyiQclprWojRkNzJpCFICLgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m4Fu/grGAt+yvBUET+UkJezFCOU3Nd+JqCg5EKF5x2gJpc48W/6sXiICUE/j7HCI7gI/fGxbP3T04x8SXMzKNqUNQKbVHIoqfjeo4bKnc5HLhqTUgwz4kul5L6wJFd0/caXa5o0Ddp9S7PxTWXzktGlxjHMHuyWz8PUMg29cdyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bTsFhY6r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvkjG032275;
	Tue, 12 Aug 2025 14:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMT7oW9299bRDoY3finOoLrU6CPDKm4iishJlJUAZQM=; b=bTsFhY6rWI3UQf4g
	C6sN0B3Y/Ez+OfgOwtw8z1J/yLEzl7mDPWIZbaQcs/QxnPFVk0+mG3/TCGNZDiZC
	kI9r3+SP84jrd2+D6S7cE65Jo5zIRSS+nD37f+XMV2XHIfHEhjsG+A3FIph6G/ZO
	fJD081QFDcGRRxwdPCjTUw3tEvnMxfs2DeVuUMoulIkK/qGnAAJR3ux9Tp/9Z+2B
	ODXkvhV+efvZ9W59g032QdQqopBylR+dSqq1hwJy6HSD3JGs2TVVvkzmAvU1gKTc
	C1oNdgJCpm1tdU8sqRbVEStxWzZ6fWGMd7hSjRWqAFBNpCHBmaH1n7QqORqig6f6
	vqTsZg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vk9e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CEBqcG026598
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:53 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 07:11:47 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 12 Aug 2025 22:10:37 +0800
Subject: [PATCH net-next v7 13/14] net: ethernet: qualcomm: Add PPE debugfs
 support for PPE counters
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-qcom_ipq_ppe-v7-13-789404bdbc9a@quicinc.com>
References: <20250812-qcom_ipq_ppe-v7-0-789404bdbc9a@quicinc.com>
In-Reply-To: <20250812-qcom_ipq_ppe-v7-0-789404bdbc9a@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755007841; l=35109;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=S9mSrk749VGVRpK+cR8jyiQclprWojRkNzJpCFICLgM=;
 b=Bvy/nabZLlAkdaJNBLKjZzVnzlueKJPdN3l2FuoQbBprR+bJx7NYLBKvwB5rzdNtRfXslwWCH
 aNvwN6D/xh4AjgKQWmx0AZSHpHIRHKRGBkuHIqUm2i1Ifk/9dDLF825
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX3Sq2+bLeENJ4
 VAZd1FgahNURtTIs/czs68uXJonvoH5Bt9vsPi96gLU1KSG9ahUVkUWT1eTyAELFUYEOueAxGlp
 WJx9wrqcpZjWixDzcXwA7MVvs3ePrLgVVniCzmrGm66GbpfJX+1FESp3G2YNx3UU8TsfE3j2QKL
 PWmB1pxL5hdrUg58DJpUN/CpiKj48NvLdR1WiDFTB/A/WCT4T0WF9yy4g8tEq/DaUJggvdro/0P
 YPP/wgMB8ydFEaVYnoKVje8CRTJmlD4s5ZrNaXfSuPFbMScjBFpEyJRrgQ3iKsRV0/Jnf8VEFJS
 Cjv/eDlWyFkbshRrmPSF7E0ZHBMb1u6aeQnud0FaXBlM8lDjyoxRt0jrul+wNrh8gGImeCRNBqe
 OIXlqz8E
X-Proofpoint-GUID: ZtWBK2IePbKWzCBtp4tk-609z2lQtNj2
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689b4baa cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=MspgthAmHNcfwDQz_goA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZtWBK2IePbKWzCBtp4tk-609z2lQtNj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

The PPE hardware counters maintain counters for packets handled by the
various functional blocks of PPE. They help in tracing the packets
passed through PPE and debugging any packet drops.

The counters displayed by this debugfs file are ones that are common
for all Ethernet ports, and they do not include the counters that are
specific for a MAC port. Hence they cannot be displayed using ethtool.
The per-MAC counters will be supported using "ethtool -S" along with
the netdevice driver.

The PPE hardware various type counters are made available through the
debugfs files under directory "/sys/kernel/debug/ppe/".

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/Makefile      |   2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c         |  11 +
 drivers/net/ethernet/qualcomm/ppe/ppe.h         |   3 +
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c | 847 ++++++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h |  16 +
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h    | 134 ++++
 6 files changed, 1012 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
index 410a7bb54cfe..9e60b2400c16 100644
--- a/drivers/net/ethernet/qualcomm/ppe/Makefile
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
-qcom-ppe-objs := ppe.o ppe_config.o
+qcom-ppe-objs := ppe.o ppe_config.o ppe_debugfs.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 6afeda082689..be747510d947 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -16,6 +16,7 @@
 
 #include "ppe.h"
 #include "ppe_config.h"
+#include "ppe_debugfs.h"
 
 #define PPE_PORT_MAX		8
 #define PPE_CLK_RATE		353000000
@@ -204,11 +205,20 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "PPE HW config failed\n");
 
+	ppe_debugfs_setup(ppe_dev);
 	platform_set_drvdata(pdev, ppe_dev);
 
 	return 0;
 }
 
+static void qcom_ppe_remove(struct platform_device *pdev)
+{
+	struct ppe_device *ppe_dev;
+
+	ppe_dev = platform_get_drvdata(pdev);
+	ppe_debugfs_teardown(ppe_dev);
+}
+
 static const struct of_device_id qcom_ppe_of_match[] = {
 	{ .compatible = "qcom,ipq9574-ppe" },
 	{}
@@ -221,6 +231,7 @@ static struct platform_driver qcom_ppe_driver = {
 		.of_match_table = qcom_ppe_of_match,
 	},
 	.probe	= qcom_ppe_probe,
+	.remove = qcom_ppe_remove,
 };
 module_platform_driver(qcom_ppe_driver);
 
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.h b/drivers/net/ethernet/qualcomm/ppe/ppe.h
index 779f39c9f098..27458f0bc206 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.h
@@ -11,6 +11,7 @@
 
 struct device;
 struct regmap;
+struct dentry;
 
 /**
  * struct ppe_device - PPE device private data.
@@ -18,6 +19,7 @@ struct regmap;
  * @regmap: PPE register map.
  * @clk_rate: PPE clock rate.
  * @num_ports: Number of PPE ports.
+ * @debugfs_root: Debugfs root entry.
  * @num_icc_paths: Number of interconnect paths.
  * @icc_paths: Interconnect path array.
  *
@@ -30,6 +32,7 @@ struct ppe_device {
 	struct regmap *regmap;
 	unsigned long clk_rate;
 	unsigned int num_ports;
+	struct dentry *debugfs_root;
 	unsigned int num_icc_paths;
 	struct icc_bulk_data icc_paths[] __counted_by(num_icc_paths);
 };
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
new file mode 100644
index 000000000000..fd959a76ff43
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.c
@@ -0,0 +1,847 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/* PPE debugfs routines for display of PPE counters useful for debug. */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/seq_file.h>
+
+#include "ppe.h"
+#include "ppe_config.h"
+#include "ppe_debugfs.h"
+#include "ppe_regs.h"
+
+#define PPE_PKT_CNT_TBL_SIZE				3
+#define PPE_DROP_PKT_CNT_TBL_SIZE			5
+
+#define PPE_W0_PKT_CNT					GENMASK(31, 0)
+#define PPE_W2_DROP_PKT_CNT_LOW				GENMASK(31, 8)
+#define PPE_W3_DROP_PKT_CNT_HIGH			GENMASK(7, 0)
+
+#define PPE_GET_PKT_CNT(tbl_cnt)			\
+	FIELD_GET(PPE_W0_PKT_CNT, *(tbl_cnt))
+#define PPE_GET_DROP_PKT_CNT_LOW(tbl_cnt)		\
+	FIELD_GET(PPE_W2_DROP_PKT_CNT_LOW, *((tbl_cnt) + 0x2))
+#define PPE_GET_DROP_PKT_CNT_HIGH(tbl_cnt)		\
+	FIELD_GET(PPE_W3_DROP_PKT_CNT_HIGH, *((tbl_cnt) + 0x3))
+
+/**
+ * enum ppe_cnt_size_type - PPE counter size type
+ * @PPE_PKT_CNT_SIZE_1WORD: Counter size with single register
+ * @PPE_PKT_CNT_SIZE_3WORD: Counter size with table of 3 words
+ * @PPE_PKT_CNT_SIZE_5WORD: Counter size with table of 5 words
+ *
+ * PPE takes the different register size to record the packet counters.
+ * It uses single register, or register table with 3 words or 5 words.
+ * The counter with table size 5 words also records the drop counter.
+ * There are also some other counter types occupying sizes less than 32
+ * bits, which is not covered by this enumeration type.
+ */
+enum ppe_cnt_size_type {
+	PPE_PKT_CNT_SIZE_1WORD,
+	PPE_PKT_CNT_SIZE_3WORD,
+	PPE_PKT_CNT_SIZE_5WORD,
+};
+
+/**
+ * enum ppe_cnt_type - PPE counter type.
+ * @PPE_CNT_BM: Packet counter processed by BM.
+ * @PPE_CNT_PARSE: Packet counter parsed on ingress.
+ * @PPE_CNT_PORT_RX: Packet counter on the ingress port.
+ * @PPE_CNT_VLAN_RX: VLAN packet counter received.
+ * @PPE_CNT_L2_FWD: Packet counter processed by L2 forwarding.
+ * @PPE_CNT_CPU_CODE: Packet counter marked with various CPU codes.
+ * @PPE_CNT_VLAN_TX: VLAN packet counter transmitted.
+ * @PPE_CNT_PORT_TX: Packet counter on the egress port.
+ * @PPE_CNT_QM: Packet counter processed by QM.
+ */
+enum ppe_cnt_type {
+	PPE_CNT_BM,
+	PPE_CNT_PARSE,
+	PPE_CNT_PORT_RX,
+	PPE_CNT_VLAN_RX,
+	PPE_CNT_L2_FWD,
+	PPE_CNT_CPU_CODE,
+	PPE_CNT_VLAN_TX,
+	PPE_CNT_PORT_TX,
+	PPE_CNT_QM,
+};
+
+/**
+ * struct ppe_debugfs_entry - PPE debugfs entry.
+ * @name: Debugfs file name.
+ * @counter_type: PPE packet counter type.
+ * @ppe: PPE device.
+ *
+ * The PPE debugfs entry is used to create the debugfs file and passed
+ * to debugfs_create_file() as private data.
+ */
+struct ppe_debugfs_entry {
+	const char *name;
+	enum ppe_cnt_type counter_type;
+	struct ppe_device *ppe;
+};
+
+static const struct ppe_debugfs_entry debugfs_files[] = {
+	{
+		.name			= "bm",
+		.counter_type		= PPE_CNT_BM,
+	},
+	{
+		.name			= "parse",
+		.counter_type		= PPE_CNT_PARSE,
+	},
+	{
+		.name			= "port_rx",
+		.counter_type		= PPE_CNT_PORT_RX,
+	},
+	{
+		.name			= "vlan_rx",
+		.counter_type		= PPE_CNT_VLAN_RX,
+	},
+	{
+		.name			= "l2_forward",
+		.counter_type		= PPE_CNT_L2_FWD,
+	},
+	{
+		.name			= "cpu_code",
+		.counter_type		= PPE_CNT_CPU_CODE,
+	},
+	{
+		.name			= "vlan_tx",
+		.counter_type		= PPE_CNT_VLAN_TX,
+	},
+	{
+		.name			= "port_tx",
+		.counter_type		= PPE_CNT_PORT_TX,
+	},
+	{
+		.name			= "qm",
+		.counter_type		= PPE_CNT_QM,
+	},
+};
+
+static int ppe_pkt_cnt_get(struct ppe_device *ppe_dev, u32 reg,
+			   enum ppe_cnt_size_type cnt_type,
+			   u32 *cnt, u32 *drop_cnt)
+{
+	u32 drop_pkt_cnt[PPE_DROP_PKT_CNT_TBL_SIZE];
+	u32 pkt_cnt[PPE_PKT_CNT_TBL_SIZE];
+	u32 value;
+	int ret;
+
+	switch (cnt_type) {
+	case PPE_PKT_CNT_SIZE_1WORD:
+		ret = regmap_read(ppe_dev->regmap, reg, &value);
+		if (ret)
+			return ret;
+
+		*cnt = value;
+		break;
+	case PPE_PKT_CNT_SIZE_3WORD:
+		ret = regmap_bulk_read(ppe_dev->regmap, reg,
+				       pkt_cnt, ARRAY_SIZE(pkt_cnt));
+		if (ret)
+			return ret;
+
+		*cnt = PPE_GET_PKT_CNT(pkt_cnt);
+		break;
+	case PPE_PKT_CNT_SIZE_5WORD:
+		ret = regmap_bulk_read(ppe_dev->regmap, reg,
+				       drop_pkt_cnt, ARRAY_SIZE(drop_pkt_cnt));
+		if (ret)
+			return ret;
+
+		*cnt = PPE_GET_PKT_CNT(drop_pkt_cnt);
+
+		/* Drop counter with low 24 bits. */
+		value  = PPE_GET_DROP_PKT_CNT_LOW(drop_pkt_cnt);
+		*drop_cnt = FIELD_PREP(GENMASK(23, 0), value);
+
+		/* Drop counter with high 8 bits. */
+		value  = PPE_GET_DROP_PKT_CNT_HIGH(drop_pkt_cnt);
+		*drop_cnt |= FIELD_PREP(GENMASK(31, 24), value);
+		break;
+	}
+
+	return 0;
+}
+
+static void ppe_tbl_pkt_cnt_clear(struct ppe_device *ppe_dev, u32 reg,
+				  enum ppe_cnt_size_type cnt_type)
+{
+	u32 drop_pkt_cnt[PPE_DROP_PKT_CNT_TBL_SIZE] = {};
+	u32 pkt_cnt[PPE_PKT_CNT_TBL_SIZE] = {};
+
+	switch (cnt_type) {
+	case PPE_PKT_CNT_SIZE_1WORD:
+		regmap_write(ppe_dev->regmap, reg, 0);
+		break;
+	case PPE_PKT_CNT_SIZE_3WORD:
+		regmap_bulk_write(ppe_dev->regmap, reg,
+				  pkt_cnt, ARRAY_SIZE(pkt_cnt));
+		break;
+	case PPE_PKT_CNT_SIZE_5WORD:
+		regmap_bulk_write(ppe_dev->regmap, reg,
+				  drop_pkt_cnt, ARRAY_SIZE(drop_pkt_cnt));
+		break;
+	}
+}
+
+static int ppe_bm_counter_get(struct ppe_device *ppe_dev, struct seq_file *seq)
+{
+	u32 reg, val, pkt_cnt, pkt_cnt1;
+	int ret, i, tag;
+
+	seq_printf(seq, "%-24s", "BM SILENT_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_DROP_CNT_TBL_ADDR + i * PPE_DROP_CNT_TBL_INC;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u(%s=%04d)", pkt_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	/* The number of packets dropped because hardware buffers were
+	 * available only partially for the packet.
+	 */
+	seq_printf(seq, "%-24s", "BM OVERFLOW_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES; i++) {
+		reg = PPE_DROP_STAT_TBL_ADDR + PPE_DROP_STAT_TBL_INC * i;
+
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u(%s=%04d)", pkt_cnt, "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	/* The number of currently occupied buffers, that can't be flushed. */
+	seq_printf(seq, "%-24s", "BM USED/REACT:");
+	tag = 0;
+	for (i = 0; i < PPE_BM_USED_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_BM_USED_CNT_TBL_ADDR + i * PPE_BM_USED_CNT_TBL_INC;
+		ret = regmap_read(ppe_dev->regmap, reg, &val);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		/* The number of PPE buffers used for caching the received
+		 * packets before the pause frame sent.
+		 */
+		pkt_cnt = FIELD_GET(PPE_BM_USED_CNT_VAL, val);
+
+		reg = PPE_BM_REACT_CNT_TBL_ADDR + i * PPE_BM_REACT_CNT_TBL_INC;
+		ret = regmap_read(ppe_dev->regmap, reg, &val);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		/* The number of PPE buffers used for caching the received
+		 * packets after pause frame sent out.
+		 */
+		pkt_cnt1 = FIELD_GET(PPE_BM_REACT_CNT_VAL, val);
+
+		if (pkt_cnt > 0 || pkt_cnt1 > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, pkt_cnt1,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets processed by the ingress parser module of PPE. */
+static int ppe_parse_pkt_counter_get(struct ppe_device *ppe_dev,
+				     struct seq_file *seq)
+{
+	u32 reg, cnt = 0, tunnel_cnt = 0;
+	int i, ret, tag = 0;
+
+	seq_printf(seq, "%-24s", "PARSE TPRX/IPRX:");
+	for (i = 0; i < PPE_IPR_PKT_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_TPR_PKT_CNT_TBL_ADDR + i * PPE_TPR_PKT_CNT_TBL_INC;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD,
+				      &tunnel_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		reg = PPE_IPR_PKT_CNT_TBL_ADDR + i * PPE_IPR_PKT_CNT_TBL_INC;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD,
+				      &cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (tunnel_cnt > 0 || cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", tunnel_cnt, cnt,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets received or dropped on the ingress port. */
+static int ppe_port_rx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0, drop_cnt = 0;
+	int ret, i, tag;
+
+	seq_printf(seq, "%-24s", "PORT RX/RX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PHY_PORT_RX_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_PHY_PORT_RX_CNT_TBL_ADDR + PPE_PHY_PORT_RX_CNT_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD,
+				      &pkt_cnt, &drop_cnt);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, drop_cnt,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	seq_printf(seq, "%-24s", "VPORT RX/RX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PORT_RX_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_PORT_RX_CNT_TBL_ADDR + PPE_PORT_RX_CNT_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD,
+				      &pkt_cnt, &drop_cnt);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, drop_cnt,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets received or dropped by layer 2 processing. */
+static int ppe_l2_counter_get(struct ppe_device *ppe_dev,
+			      struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0, drop_cnt = 0;
+	int ret, i, tag = 0;
+
+	seq_printf(seq, "%-24s", "L2 RX/RX_DROP:");
+	for (i = 0; i < PPE_PRE_L2_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_PRE_L2_CNT_TBL_ADDR + PPE_PRE_L2_CNT_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD,
+				      &pkt_cnt, &drop_cnt);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, drop_cnt,
+				   "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of VLAN packets received by PPE. */
+static int ppe_vlan_rx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0;
+	int ret, i, tag = 0;
+
+	seq_printf(seq, "%-24s", "VLAN RX:");
+	for (i = 0; i < PPE_VLAN_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_VLAN_CNT_TBL_ADDR + PPE_VLAN_CNT_TBL_INC * i;
+
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u(%s=%04d)", pkt_cnt, "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets handed to CPU by PPE. */
+static int ppe_cpu_code_counter_get(struct ppe_device *ppe_dev,
+				    struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0;
+	int ret, i;
+
+	seq_printf(seq, "%-24s", "CPU CODE:");
+	for (i = 0; i < PPE_DROP_CPU_CNT_TBL_ENTRIES; i++) {
+		reg = PPE_DROP_CPU_CNT_TBL_ADDR + PPE_DROP_CPU_CNT_TBL_INC * i;
+
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (!pkt_cnt)
+			continue;
+
+		/* There are 256 CPU codes saved in the first 256 entries
+		 * of register table, and 128 drop codes for each PPE port
+		 * (0-7), the total entries is 256 + 8 * 128.
+		 */
+		if (i < 256)
+			seq_printf(seq, "%10u(cpucode:%d)", pkt_cnt, i);
+		else
+			seq_printf(seq, "%10u(port=%04d),dropcode:%d", pkt_cnt,
+				   (i - 256) % 8, (i - 256) / 8);
+		seq_putc(seq, '\n');
+		seq_printf(seq, "%-24s", "");
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets forwarded by VLAN on the egress direction. */
+static int ppe_vlan_tx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0;
+	int ret, i, tag = 0;
+
+	seq_printf(seq, "%-24s", "VLAN TX:");
+	for (i = 0; i < PPE_EG_VSI_COUNTER_TBL_ENTRIES; i++) {
+		reg = PPE_EG_VSI_COUNTER_TBL_ADDR + PPE_EG_VSI_COUNTER_TBL_INC * i;
+
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u(%s=%04d)", pkt_cnt, "vsi", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets transmitted or dropped on the egress port. */
+static int ppe_port_tx_counter_get(struct ppe_device *ppe_dev,
+				   struct seq_file *seq)
+{
+	u32 reg, pkt_cnt = 0, drop_cnt = 0;
+	int ret, i, tag;
+
+	seq_printf(seq, "%-24s", "VPORT TX/TX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_VPORT_TX_COUNTER_TBL_ENTRIES; i++) {
+		reg = PPE_VPORT_TX_COUNTER_TBL_ADDR + PPE_VPORT_TX_COUNTER_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		reg = PPE_VPORT_TX_DROP_CNT_TBL_ADDR + PPE_VPORT_TX_DROP_CNT_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &drop_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0 || drop_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, drop_cnt,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	seq_printf(seq, "%-24s", "PORT TX/TX_DROP:");
+	tag = 0;
+	for (i = 0; i < PPE_PORT_TX_COUNTER_TBL_ENTRIES; i++) {
+		reg = PPE_PORT_TX_COUNTER_TBL_ADDR + PPE_PORT_TX_COUNTER_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		reg = PPE_PORT_TX_DROP_CNT_TBL_ADDR + PPE_PORT_TX_DROP_CNT_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &drop_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (pkt_cnt > 0 || drop_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u(%s=%04d)", pkt_cnt, drop_cnt,
+				   "port", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* The number of packets transmitted or pending by the PPE queue. */
+static int ppe_queue_counter_get(struct ppe_device *ppe_dev,
+				 struct seq_file *seq)
+{
+	u32 reg, val, pkt_cnt = 0, pend_cnt = 0, drop_cnt = 0;
+	int ret, i, tag = 0;
+
+	seq_printf(seq, "%-24s", "QUEUE TX/PEND/DROP:");
+	for (i = 0; i < PPE_QUEUE_TX_COUNTER_TBL_ENTRIES; i++) {
+		reg = PPE_QUEUE_TX_COUNTER_TBL_ADDR + PPE_QUEUE_TX_COUNTER_TBL_INC * i;
+		ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+				      &pkt_cnt, NULL);
+		if (ret) {
+			dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+			return ret;
+		}
+
+		if (i < PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES) {
+			reg = PPE_AC_UNICAST_QUEUE_CNT_TBL_ADDR +
+			      PPE_AC_UNICAST_QUEUE_CNT_TBL_INC * i;
+			ret = regmap_read(ppe_dev->regmap, reg, &val);
+			if (ret) {
+				dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+				return ret;
+			}
+
+			pend_cnt = FIELD_GET(PPE_AC_UNICAST_QUEUE_CNT_TBL_PEND_CNT, val);
+
+			reg = PPE_UNICAST_DROP_CNT_TBL_ADDR +
+			      PPE_AC_UNICAST_QUEUE_CNT_TBL_INC *
+			      (i * PPE_UNICAST_DROP_TYPES + PPE_UNICAST_DROP_FORCE_OFFSET);
+
+			ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+					      &drop_cnt, NULL);
+			if (ret) {
+				dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+				return ret;
+			}
+		} else {
+			int mq_offset = i - PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES;
+
+			reg = PPE_AC_MULTICAST_QUEUE_CNT_TBL_ADDR +
+			      PPE_AC_MULTICAST_QUEUE_CNT_TBL_INC * mq_offset;
+			ret = regmap_read(ppe_dev->regmap, reg, &val);
+			if (ret) {
+				dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+				return ret;
+			}
+
+			pend_cnt = FIELD_GET(PPE_AC_MULTICAST_QUEUE_CNT_TBL_PEND_CNT, val);
+
+			if (mq_offset < PPE_P0_MULTICAST_QUEUE_NUM) {
+				reg = PPE_CPU_PORT_MULTICAST_FORCE_DROP_CNT_TBL_ADDR(mq_offset);
+			} else {
+				mq_offset -= PPE_P0_MULTICAST_QUEUE_NUM;
+
+				reg = PPE_P1_MULTICAST_DROP_CNT_TBL_ADDR;
+				reg += (mq_offset / PPE_MULTICAST_QUEUE_NUM) *
+					PPE_MULTICAST_QUEUE_PORT_ADDR_INC;
+				reg += (mq_offset % PPE_MULTICAST_QUEUE_NUM) *
+					PPE_MULTICAST_DROP_CNT_TBL_INC *
+					PPE_MULTICAST_DROP_TYPES;
+			}
+
+			ret = ppe_pkt_cnt_get(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD,
+					      &drop_cnt, NULL);
+			if (ret) {
+				dev_err(ppe_dev->dev, "CNT ERROR %d\n", ret);
+				return ret;
+			}
+		}
+
+		if (pkt_cnt > 0 || pend_cnt > 0 || drop_cnt > 0) {
+			if (!((++tag) % 4))
+				seq_printf(seq, "\n%-24s", "");
+
+			seq_printf(seq, "%10u/%u/%u(%s=%04d)",
+				   pkt_cnt, pend_cnt, drop_cnt, "queue", i);
+		}
+	}
+
+	seq_putc(seq, '\n');
+
+	return 0;
+}
+
+/* Display the various packet counters of PPE. */
+static int ppe_packet_counter_show(struct seq_file *seq, void *v)
+{
+	struct ppe_debugfs_entry *entry = seq->private;
+	struct ppe_device *ppe_dev = entry->ppe;
+	int ret;
+
+	switch (entry->counter_type) {
+	case PPE_CNT_BM:
+		ret = ppe_bm_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_PARSE:
+		ret = ppe_parse_pkt_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_PORT_RX:
+		ret = ppe_port_rx_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_VLAN_RX:
+		ret = ppe_vlan_rx_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_L2_FWD:
+		ret = ppe_l2_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_CPU_CODE:
+		ret = ppe_cpu_code_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_VLAN_TX:
+		ret = ppe_vlan_tx_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_PORT_TX:
+		ret = ppe_port_tx_counter_get(ppe_dev, seq);
+		break;
+	case PPE_CNT_QM:
+		ret = ppe_queue_counter_get(ppe_dev, seq);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/* Flush the various packet counters of PPE. */
+static ssize_t ppe_packet_counter_write(struct file *file,
+					const char __user *buf,
+					size_t count, loff_t *pos)
+{
+	struct ppe_debugfs_entry *entry = file_inode(file)->i_private;
+	struct ppe_device *ppe_dev = entry->ppe;
+	u32 reg;
+	int i;
+
+	switch (entry->counter_type) {
+	case PPE_CNT_BM:
+		for (i = 0; i < PPE_DROP_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_DROP_CNT_TBL_ADDR + i * PPE_DROP_CNT_TBL_INC;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD);
+		}
+
+		for (i = 0; i < PPE_DROP_STAT_TBL_ENTRIES; i++) {
+			reg = PPE_DROP_STAT_TBL_ADDR + PPE_DROP_STAT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	case PPE_CNT_PARSE:
+		for (i = 0; i < PPE_IPR_PKT_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_IPR_PKT_CNT_TBL_ADDR + i * PPE_IPR_PKT_CNT_TBL_INC;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD);
+
+			reg = PPE_TPR_PKT_CNT_TBL_ADDR + i * PPE_TPR_PKT_CNT_TBL_INC;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_1WORD);
+		}
+
+		break;
+	case PPE_CNT_PORT_RX:
+		for (i = 0; i < PPE_PORT_RX_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_PORT_RX_CNT_TBL_ADDR + PPE_PORT_RX_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD);
+		}
+
+		for (i = 0; i < PPE_PHY_PORT_RX_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_PHY_PORT_RX_CNT_TBL_ADDR + PPE_PHY_PORT_RX_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD);
+		}
+
+		break;
+	case PPE_CNT_VLAN_RX:
+		for (i = 0; i < PPE_VLAN_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_VLAN_CNT_TBL_ADDR + PPE_VLAN_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	case PPE_CNT_L2_FWD:
+		for (i = 0; i < PPE_PRE_L2_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_PRE_L2_CNT_TBL_ADDR + PPE_PRE_L2_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_5WORD);
+		}
+
+		break;
+	case PPE_CNT_CPU_CODE:
+		for (i = 0; i < PPE_DROP_CPU_CNT_TBL_ENTRIES; i++) {
+			reg = PPE_DROP_CPU_CNT_TBL_ADDR + PPE_DROP_CPU_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	case PPE_CNT_VLAN_TX:
+		for (i = 0; i < PPE_EG_VSI_COUNTER_TBL_ENTRIES; i++) {
+			reg = PPE_EG_VSI_COUNTER_TBL_ADDR + PPE_EG_VSI_COUNTER_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	case PPE_CNT_PORT_TX:
+		for (i = 0; i < PPE_PORT_TX_COUNTER_TBL_ENTRIES; i++) {
+			reg = PPE_PORT_TX_DROP_CNT_TBL_ADDR + PPE_PORT_TX_DROP_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+
+			reg = PPE_PORT_TX_COUNTER_TBL_ADDR + PPE_PORT_TX_COUNTER_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		for (i = 0; i < PPE_VPORT_TX_COUNTER_TBL_ENTRIES; i++) {
+			reg = PPE_VPORT_TX_COUNTER_TBL_ADDR + PPE_VPORT_TX_COUNTER_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+
+			reg = PPE_VPORT_TX_DROP_CNT_TBL_ADDR + PPE_VPORT_TX_DROP_CNT_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	case PPE_CNT_QM:
+		for (i = 0; i < PPE_QUEUE_TX_COUNTER_TBL_ENTRIES; i++) {
+			reg = PPE_QUEUE_TX_COUNTER_TBL_ADDR + PPE_QUEUE_TX_COUNTER_TBL_INC * i;
+			ppe_tbl_pkt_cnt_clear(ppe_dev, reg, PPE_PKT_CNT_SIZE_3WORD);
+		}
+
+		break;
+	default:
+		break;
+	}
+
+	return count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(ppe_packet_counter);
+
+void ppe_debugfs_setup(struct ppe_device *ppe_dev)
+{
+	struct ppe_debugfs_entry *entry;
+	int i;
+
+	ppe_dev->debugfs_root = debugfs_create_dir("ppe", NULL);
+	if (IS_ERR(ppe_dev->debugfs_root))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(debugfs_files); i++) {
+		entry = devm_kzalloc(ppe_dev->dev, sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return;
+
+		entry->ppe = ppe_dev;
+		entry->counter_type = debugfs_files[i].counter_type;
+
+		debugfs_create_file(debugfs_files[i].name, 0444,
+				    ppe_dev->debugfs_root, entry,
+				    &ppe_packet_counter_fops);
+	}
+}
+
+void ppe_debugfs_teardown(struct ppe_device *ppe_dev)
+{
+	debugfs_remove_recursive(ppe_dev->debugfs_root);
+	ppe_dev->debugfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
new file mode 100644
index 000000000000..81f49a709123
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_debugfs.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/* PPE debugfs counters setup. */
+
+#ifndef __PPE_DEBUGFS_H__
+#define __PPE_DEBUGFS_H__
+
+#include "ppe.h"
+
+void ppe_debugfs_setup(struct ppe_device *ppe_dev);
+void ppe_debugfs_teardown(struct ppe_device *ppe_dev);
+
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 6fc63f82ee80..746dfbb5a682 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -16,6 +16,36 @@
 #define PPE_BM_SCH_CTRL_SCH_OFFSET		GENMASK(14, 8)
 #define PPE_BM_SCH_CTRL_SCH_EN			BIT(31)
 
+/* PPE drop counters. */
+#define PPE_DROP_CNT_TBL_ADDR			0xb024
+#define PPE_DROP_CNT_TBL_ENTRIES		8
+#define PPE_DROP_CNT_TBL_INC			4
+
+/* BM port drop counters. */
+#define PPE_DROP_STAT_TBL_ADDR			0xe000
+#define PPE_DROP_STAT_TBL_ENTRIES		30
+#define PPE_DROP_STAT_TBL_INC			0x10
+
+/* Egress VLAN counters. */
+#define PPE_EG_VSI_COUNTER_TBL_ADDR		0x41000
+#define PPE_EG_VSI_COUNTER_TBL_ENTRIES		64
+#define PPE_EG_VSI_COUNTER_TBL_INC		0x10
+
+/* Port TX counters. */
+#define PPE_PORT_TX_COUNTER_TBL_ADDR		0x45000
+#define PPE_PORT_TX_COUNTER_TBL_ENTRIES		8
+#define PPE_PORT_TX_COUNTER_TBL_INC		0x10
+
+/* Virtual port TX counters. */
+#define PPE_VPORT_TX_COUNTER_TBL_ADDR		0x47000
+#define PPE_VPORT_TX_COUNTER_TBL_ENTRIES	256
+#define PPE_VPORT_TX_COUNTER_TBL_INC		0x10
+
+/* Queue counters. */
+#define PPE_QUEUE_TX_COUNTER_TBL_ADDR		0x4a000
+#define PPE_QUEUE_TX_COUNTER_TBL_ENTRIES	300
+#define PPE_QUEUE_TX_COUNTER_TBL_INC		0x10
+
 /* RSS settings are to calculate the random RSS hash value generated during
  * packet receive to ARM cores. This hash is then used to generate the queue
  * offset used to determine the queue used to transmit the packet to ARM cores.
@@ -213,6 +243,51 @@
 #define PPE_L2_PORT_SET_DST_INFO(tbl_cfg, value)		\
 	FIELD_MODIFY(PPE_L2_VP_PORT_W0_DST_INFO, tbl_cfg, value)
 
+/* Port RX and RX drop counters. */
+#define PPE_PORT_RX_CNT_TBL_ADDR		0x150000
+#define PPE_PORT_RX_CNT_TBL_ENTRIES		256
+#define PPE_PORT_RX_CNT_TBL_INC			0x20
+
+/* Physical port RX and RX drop counters. */
+#define PPE_PHY_PORT_RX_CNT_TBL_ADDR		0x156000
+#define PPE_PHY_PORT_RX_CNT_TBL_ENTRIES		8
+#define PPE_PHY_PORT_RX_CNT_TBL_INC		0x20
+
+/* Counters for the packet to CPU port. */
+#define PPE_DROP_CPU_CNT_TBL_ADDR		0x160000
+#define PPE_DROP_CPU_CNT_TBL_ENTRIES		1280
+#define PPE_DROP_CPU_CNT_TBL_INC		0x10
+
+/* VLAN counters. */
+#define PPE_VLAN_CNT_TBL_ADDR			0x178000
+#define PPE_VLAN_CNT_TBL_ENTRIES		64
+#define PPE_VLAN_CNT_TBL_INC			0x10
+
+/* PPE L2 counters. */
+#define PPE_PRE_L2_CNT_TBL_ADDR			0x17c000
+#define PPE_PRE_L2_CNT_TBL_ENTRIES		64
+#define PPE_PRE_L2_CNT_TBL_INC			0x20
+
+/* Port TX drop counters. */
+#define PPE_PORT_TX_DROP_CNT_TBL_ADDR		0x17d000
+#define PPE_PORT_TX_DROP_CNT_TBL_ENTRIES	8
+#define PPE_PORT_TX_DROP_CNT_TBL_INC		0x10
+
+/* Virtual port TX counters. */
+#define PPE_VPORT_TX_DROP_CNT_TBL_ADDR		0x17e000
+#define PPE_VPORT_TX_DROP_CNT_TBL_ENTRIES	256
+#define PPE_VPORT_TX_DROP_CNT_TBL_INC		0x10
+
+/* Counters for the tunnel packet. */
+#define PPE_TPR_PKT_CNT_TBL_ADDR		0x1d0080
+#define PPE_TPR_PKT_CNT_TBL_ENTRIES		8
+#define PPE_TPR_PKT_CNT_TBL_INC			4
+
+/* Counters for the all packet received. */
+#define PPE_IPR_PKT_CNT_TBL_ADDR		0x1e0080
+#define PPE_IPR_PKT_CNT_TBL_ENTRIES		8
+#define PPE_IPR_PKT_CNT_TBL_INC			4
+
 /* PPE service code configuration for the tunnel packet. */
 #define PPE_TL_SERVICE_TBL_ADDR			0x306000
 #define PPE_TL_SERVICE_TBL_ENTRIES		256
@@ -325,6 +400,18 @@
 #define PPE_BM_PORT_GROUP_ID_INC		0x4
 #define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID	GENMASK(1, 0)
 
+/* Counters for PPE buffers used for packets cached. */
+#define PPE_BM_USED_CNT_TBL_ADDR		0x6001c0
+#define PPE_BM_USED_CNT_TBL_ENTRIES		15
+#define PPE_BM_USED_CNT_TBL_INC			0x4
+#define PPE_BM_USED_CNT_VAL			GENMASK(10, 0)
+
+/* Counters for PPE buffers used for packets received after pause frame sent. */
+#define PPE_BM_REACT_CNT_TBL_ADDR		0x600240
+#define PPE_BM_REACT_CNT_TBL_ENTRIES		15
+#define PPE_BM_REACT_CNT_TBL_INC		0x4
+#define PPE_BM_REACT_CNT_VAL			GENMASK(8, 0)
+
 #define PPE_BM_SHARED_GROUP_CFG_ADDR		0x600290
 #define PPE_BM_SHARED_GROUP_CFG_ENTRIES		4
 #define PPE_BM_SHARED_GROUP_CFG_INC		0x4
@@ -449,9 +536,56 @@
 #define PPE_AC_GRP_SET_BUF_LIMIT(tbl_cfg, value)	\
 	FIELD_MODIFY(PPE_AC_GRP_W1_BUF_LIMIT, (tbl_cfg) + 0x1, value)
 
+/* Counters for packets handled by unicast queues (0-255). */
+#define PPE_AC_UNICAST_QUEUE_CNT_TBL_ADDR	0x84e000
+#define PPE_AC_UNICAST_QUEUE_CNT_TBL_ENTRIES	256
+#define PPE_AC_UNICAST_QUEUE_CNT_TBL_INC	0x10
+#define PPE_AC_UNICAST_QUEUE_CNT_TBL_PEND_CNT	GENMASK(12, 0)
+
+/* Counters for packets handled by multicast queues (256-299). */
+#define PPE_AC_MULTICAST_QUEUE_CNT_TBL_ADDR	0x852000
+#define PPE_AC_MULTICAST_QUEUE_CNT_TBL_ENTRIES	44
+#define PPE_AC_MULTICAST_QUEUE_CNT_TBL_INC	0x10
+#define PPE_AC_MULTICAST_QUEUE_CNT_TBL_PEND_CNT	GENMASK(12, 0)
+
 /* Table addresses for per-queue enqueue setting. */
 #define PPE_ENQ_OPR_TBL_ADDR			0x85c000
 #define PPE_ENQ_OPR_TBL_ENTRIES			300
 #define PPE_ENQ_OPR_TBL_INC			0x10
 #define PPE_ENQ_OPR_TBL_ENQ_DISABLE		BIT(0)
+
+/* Unicast drop count includes the possible drops with WRED for the green,
+ * yellow and red categories.
+ */
+#define PPE_UNICAST_DROP_CNT_TBL_ADDR		0x9e0000
+#define PPE_UNICAST_DROP_CNT_TBL_ENTRIES	1536
+#define PPE_UNICAST_DROP_CNT_TBL_INC		0x10
+#define PPE_UNICAST_DROP_TYPES			6
+#define PPE_UNICAST_DROP_FORCE_OFFSET		3
+
+/* There are 16 multicast queues dedicated to CPU port 0. Multicast drop
+ * count includes the force drop for green, yellow and red category packets.
+ */
+#define PPE_P0_MULTICAST_DROP_CNT_TBL_ADDR	0x9f0000
+#define PPE_P0_MULTICAST_DROP_CNT_TBL_ENTRIES	48
+#define PPE_P0_MULTICAST_DROP_CNT_TBL_INC	0x10
+#define PPE_P0_MULTICAST_QUEUE_NUM		16
+
+/* Each PPE physical port has four dedicated multicast queues, providing
+ * a total of 12 entries per port. The multicast drop count includes forced
+ * drops for green, yellow, and red category packets.
+ */
+#define PPE_MULTICAST_QUEUE_PORT_ADDR_INC	0x1000
+#define PPE_MULTICAST_DROP_CNT_TBL_INC		0x10
+#define PPE_MULTICAST_DROP_TYPES		3
+#define PPE_MULTICAST_QUEUE_NUM			4
+#define PPE_MULTICAST_DROP_CNT_TBL_ENTRIES	12
+
+#define PPE_CPU_PORT_MULTICAST_FORCE_DROP_CNT_TBL_ADDR(mq_offset)	\
+	(PPE_P0_MULTICAST_DROP_CNT_TBL_ADDR +				\
+	 (mq_offset) * PPE_P0_MULTICAST_DROP_CNT_TBL_INC *		\
+	 PPE_MULTICAST_DROP_TYPES)
+
+#define PPE_P1_MULTICAST_DROP_CNT_TBL_ADDR	\
+	(PPE_P0_MULTICAST_DROP_CNT_TBL_ADDR + PPE_MULTICAST_QUEUE_PORT_ADDR_INC)
 #endif

-- 
2.34.1


