Return-Path: <netdev+bounces-190035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF5AAB50A9
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 591711B44C1D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D34A24395C;
	Tue, 13 May 2025 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VVSXO7s9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805C242D80;
	Tue, 13 May 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130355; cv=none; b=qr86HsW6gjs933tETXq4OVQyrbZGngLcPkOY/M7xk70KcMFVcvUFPCbNseUvEn4+7e+jWBDEqUTeO7nBu1w+WpJqaogYOHbKTwTlCQQ5FBlXv0lsN2vnWqkgQ7765V+CyLnuzIb3nmT8lO5TpVT0xCgp0HPa4lnJFqurlpC5yx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130355; c=relaxed/simple;
	bh=jWPcURL+0L0W3avRP5+U8C+wdBvdvLWTTxVUqtswa3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=F1nkxFjntClrx7Ujt9+5IH/QhkKFQPJu+ycE/ToXvTbhGMgJEmxgwv/bOggttRq+4M5mvf8Te9yWggo+syi/Q07QP4QQWdpza7ATSS2MfNKipxcLc/jxMHfr0UnMdem6DJwNqXrdfrgRTuGOHom+tKBKWyAIhu6h+2D/osRUA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VVSXO7s9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D6Rxwf022717;
	Tue, 13 May 2025 09:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FwTFZdO1trvZeIQI0U4G5F5YJdlq99g0pB2GV7ULfjQ=; b=VVSXO7s9J4PAucMR
	fm0wbilz+1Am8BS6yALX/0Th4ejAyf4PF/hXXIsgzBW7ghB0XGrLgirwgWnQaeNq
	keK6yxW84gxy1h2weu+1n5i7EBszvyxVGWggaZlgXp71u62pcgv/2gIK3370R2D8
	MMTupsS0DChAKSCy16bSq3RuK+bSgYX7tBp94WumzjYxi0cByPv88+SkS+PrZ5w9
	/gREMoj+LE6FDUCnoiSmUBN7nHEUlw+B4TRaJIqO0TmFiQH+BVNquEqP6varXhVC
	OuNgzJqlcv7UM9oOT9GYYLbPHttyNW4UMW3AJ/BmM7MkeZqw8xfrRQ4yO9xJdXXN
	vdVNrg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46kdsp3gev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 09:59:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54D9ww31003650
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 09:58:58 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 13 May 2025 02:58:53 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 13 May 2025 17:58:24 +0800
Subject: [PATCH net-next v4 04/14] net: ethernet: qualcomm: Initialize PPE
 buffer management for IPQ9574
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250513-qcom_ipq_ppe-v4-4-4fbe40cbbb71@quicinc.com>
References: <20250513-qcom_ipq_ppe-v4-0-4fbe40cbbb71@quicinc.com>
In-Reply-To: <20250513-qcom_ipq_ppe-v4-0-4fbe40cbbb71@quicinc.com>
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
        <srinivas.kandagatla@linaro.org>, <bartosz.golaszewski@linaro.org>,
        <john@phrozen.org>, Luo Jie <quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747130310; l=11690;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=jWPcURL+0L0W3avRP5+U8C+wdBvdvLWTTxVUqtswa3U=;
 b=5utXa8Wgz2ivFWvnqzcP5UF08eNOcYQ4ey4f+8bSAOIZ4I53vBfXv8IhKrwYnwmtlah75PL4Q
 5Y2il/nK2gRCmhniFgoTJbSxcAD0Trl+T5b73wRY/qc903rb1V/dveK
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AdeQzgN880gC9YN96OAru2vmNZBbzcO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5NCBTYWx0ZWRfXzHfRmywgQvWH
 b+ghXia6wXZzmEez9bZcJweTq+SQoWZaHSg32la7TNR8ZP8xeET0Al3RI8uj7+yeODwlZKKSaFK
 vpMKyTCGNIfUT+rFtEX0aFC5bx+49FWDPF8dH0lpEmuUgbLfDCdgYPE/EXJxP3l4N69Imul39Nf
 S17MvokvxPBDnzpND82m4xuvuqetHCT5anM9lO0Nec5DhVODR1ukuXzRoX/6e/yvDC/jLi8XGyE
 QLPKHKECXJ94CAFAXa9KwJxSoQDVCHAL99qAyBnXlR1tJrZBkxvugrRaOAPza5rohU5A/bcJ3QE
 9W7Ge0ZXAzMRWN3pFGlYfzAZb1Zy9nBFiTTIqmfNKPnKlh4shFO1g6M+Hu2/4GR7BiY8UVUE1PP
 Z3+kpvIOMjGiQX2pxDdGaPBqCouhrwAFnKKYZnQfKYLUl27RxI3+4TR40TOo4rCAaUTIUWlX
X-Authority-Analysis: v=2.4 cv=TrfmhCXh c=1 sm=1 tr=0 ts=682317e4 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8
 a=hdbwrHnlPZYA2T6C3_4A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AdeQzgN880gC9YN96OAru2vmNZBbzcO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130094

The BM (Buffer Management) config controls the pause frame generated
on the PPE port. There are maximum 15 BM ports and 4 groups supported,
all BM ports are assigned to group 0 by default. The number of hardware
buffers configured for the port influence the threshold of the flow
control for that port.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/Makefile     |   2 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c        |   5 +
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 199 +++++++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_config.h |  12 ++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h   |  59 ++++++++
 5 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/Makefile b/drivers/net/ethernet/qualcomm/ppe/Makefile
index 63d50d3b4f2e..410a7bb54cfe 100644
--- a/drivers/net/ethernet/qualcomm/ppe/Makefile
+++ b/drivers/net/ethernet/qualcomm/ppe/Makefile
@@ -4,4 +4,4 @@
 #
 
 obj-$(CONFIG_QCOM_PPE) += qcom-ppe.o
-qcom-ppe-objs := ppe.o
+qcom-ppe-objs := ppe.o ppe_config.o
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 40da7d240594..253de6a15466 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -15,6 +15,7 @@
 #include <linux/reset.h>
 
 #include "ppe.h"
+#include "ppe_config.h"
 
 #define PPE_PORT_MAX		8
 #define PPE_CLK_RATE		353000000
@@ -194,6 +195,10 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "PPE clock config failed\n");
 
+	ret = ppe_hw_config(ppe_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "PPE HW config failed\n");
+
 	platform_set_drvdata(pdev, ppe_dev);
 
 	return 0;
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
new file mode 100644
index 000000000000..53efa2d4204e
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE HW initialization configs such as BM(buffer management),
+ * QM(queue management) and scheduler configs.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+
+#include "ppe.h"
+#include "ppe_config.h"
+#include "ppe_regs.h"
+
+/**
+ * struct ppe_bm_port_config - PPE BM port configuration.
+ * @port_id_start: The fist BM port ID to configure.
+ * @port_id_end: The last BM port ID to configure.
+ * @pre_alloc: BM port dedicated buffer number.
+ * @in_fly_buf: Buffer number for receiving the packet after pause frame sent.
+ * @ceil: Ceil to generate the back pressure.
+ * @weight: Weight value.
+ * @resume_offset: Resume offset from the threshold value.
+ * @resume_ceil: Ceil to resume from the back pressure state.
+ * @dynamic: Dynamic threshold used or not.
+ *
+ * The is for configuring the threshold that impacts the port
+ * flow control.
+ */
+struct ppe_bm_port_config {
+	unsigned int port_id_start;
+	unsigned int port_id_end;
+	unsigned int pre_alloc;
+	unsigned int in_fly_buf;
+	unsigned int ceil;
+	unsigned int weight;
+	unsigned int resume_offset;
+	unsigned int resume_ceil;
+	bool dynamic;
+};
+
+/* There are total 2048 buffers available in PPE, out of which some
+ * buffers are reserved for some specific purposes per PPE port. The
+ * rest of the pool of 1550 buffers are assigned to the general 'group0'
+ * which is shared among all ports of the PPE.
+ */
+static const int ipq9574_ppe_bm_group_config = 1550;
+
+/* The buffer configurations per PPE port. There are 15 BM ports and
+ * 4 BM groups supported by PPE. BM port (0-7) is for EDMA port 0,
+ * BM port (8-13) is for PPE physical port 1-6 and BM port 14 is for
+ * EIP port.
+ */
+static const struct ppe_bm_port_config ipq9574_ppe_bm_port_config[] = {
+	{
+		/* Buffer configuration for the BM port ID 0 of EDMA. */
+		.port_id_start	= 0,
+		.port_id_end	= 0,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 100,
+		.ceil		= 1146,
+		.weight		= 7,
+		.resume_offset	= 8,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 1-7 of EDMA. */
+		.port_id_start	= 1,
+		.port_id_end	= 7,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 100,
+		.ceil		= 250,
+		.weight		= 4,
+		.resume_offset	= 36,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 8-13 of PPE ports. */
+		.port_id_start	= 8,
+		.port_id_end	= 13,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 128,
+		.ceil		= 250,
+		.weight		= 4,
+		.resume_offset	= 36,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+	{
+		/* Buffer configuration for the BM port ID 14 of EIP. */
+		.port_id_start	= 14,
+		.port_id_end	= 14,
+		.pre_alloc	= 0,
+		.in_fly_buf	= 40,
+		.ceil		= 250,
+		.weight		= 4,
+		.resume_offset	= 36,
+		.resume_ceil	= 0,
+		.dynamic	= true,
+	},
+};
+
+static int ppe_config_bm_threshold(struct ppe_device *ppe_dev, int bm_port_id,
+				   const struct ppe_bm_port_config port_cfg)
+{
+	u32 reg, val, bm_fc_val[2];
+	int ret;
+
+	reg = PPE_BM_PORT_FC_CFG_TBL_ADDR + PPE_BM_PORT_FC_CFG_TBL_INC * bm_port_id;
+	ret = regmap_bulk_read(ppe_dev->regmap, reg,
+			       bm_fc_val, ARRAY_SIZE(bm_fc_val));
+	if (ret)
+		return ret;
+
+	/* Configure BM flow control related threshold. */
+	PPE_BM_PORT_FC_SET_WEIGHT(bm_fc_val, port_cfg.weight);
+	PPE_BM_PORT_FC_SET_RESUME_OFFSET(bm_fc_val, port_cfg.resume_offset);
+	PPE_BM_PORT_FC_SET_RESUME_THRESHOLD(bm_fc_val, port_cfg.resume_ceil);
+	PPE_BM_PORT_FC_SET_DYNAMIC(bm_fc_val, port_cfg.dynamic);
+	PPE_BM_PORT_FC_SET_REACT_LIMIT(bm_fc_val, port_cfg.in_fly_buf);
+	PPE_BM_PORT_FC_SET_PRE_ALLOC(bm_fc_val, port_cfg.pre_alloc);
+
+	/* Configure low/high bits of the ceiling for the BM port. */
+	val = FIELD_GET(GENMASK(2, 0), port_cfg.ceil);
+	PPE_BM_PORT_FC_SET_CEILING_LOW(bm_fc_val, val);
+	val = FIELD_GET(GENMASK(10, 3), port_cfg.ceil);
+	PPE_BM_PORT_FC_SET_CEILING_HIGH(bm_fc_val, val);
+
+	ret = regmap_bulk_write(ppe_dev->regmap, reg,
+				bm_fc_val, ARRAY_SIZE(bm_fc_val));
+	if (ret)
+		return ret;
+
+	/* Assign the default group ID 0 to the BM port. */
+	val = FIELD_PREP(PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID, 0);
+	reg = PPE_BM_PORT_GROUP_ID_ADDR + PPE_BM_PORT_GROUP_ID_INC * bm_port_id;
+	ret = regmap_update_bits(ppe_dev->regmap, reg,
+				 PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID,
+				 val);
+	if (ret)
+		return ret;
+
+	/* Enable BM port flow control. */
+	reg = PPE_BM_PORT_FC_MODE_ADDR + PPE_BM_PORT_FC_MODE_INC * bm_port_id;
+
+	return regmap_set_bits(ppe_dev->regmap, reg, PPE_BM_PORT_FC_MODE_EN);
+}
+
+/* Configure the buffer threshold for the port flow control function. */
+static int ppe_config_bm(struct ppe_device *ppe_dev)
+{
+	const struct ppe_bm_port_config *port_cfg;
+	unsigned int i, bm_port_id, port_cfg_cnt;
+	u32 reg, val;
+	int ret;
+
+	/* Configure the allocated buffer number only for group 0.
+	 * The buffer number of group 1-3 is already cleared to 0
+	 * after PPE reset during the probe of PPE driver.
+	 */
+	reg = PPE_BM_SHARED_GROUP_CFG_ADDR;
+	val = FIELD_PREP(PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
+			 ipq9574_ppe_bm_group_config);
+	ret = regmap_update_bits(ppe_dev->regmap, reg,
+				 PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT,
+				 val);
+	if (ret)
+		goto bm_config_fail;
+
+	/* Configure buffer thresholds for the BM ports. */
+	port_cfg = ipq9574_ppe_bm_port_config;
+	port_cfg_cnt = ARRAY_SIZE(ipq9574_ppe_bm_port_config);
+	for (i = 0; i < port_cfg_cnt; i++) {
+		for (bm_port_id = port_cfg[i].port_id_start;
+		     bm_port_id <= port_cfg[i].port_id_end; bm_port_id++) {
+			ret = ppe_config_bm_threshold(ppe_dev, bm_port_id,
+						      port_cfg[i]);
+			if (ret)
+				goto bm_config_fail;
+		}
+	}
+
+	return 0;
+
+bm_config_fail:
+	dev_err(ppe_dev->dev, "PPE BM config error %d\n", ret);
+	return ret;
+}
+
+int ppe_hw_config(struct ppe_device *ppe_dev)
+{
+	return ppe_config_bm(ppe_dev);
+}
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.h b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
new file mode 100644
index 000000000000..7b2f6a71cd4c
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef __PPE_CONFIG_H__
+#define __PPE_CONFIG_H__
+
+#include "ppe.h"
+
+int ppe_hw_config(struct ppe_device *ppe_dev);
+#endif
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
new file mode 100644
index 000000000000..3f982c6f42fa
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/* PPE hardware register and table declarations. */
+#ifndef __PPE_REGS_H__
+#define __PPE_REGS_H__
+
+#include <linux/bitfield.h>
+
+/* There are 15 BM ports and 4 BM groups supported by PPE.
+ * BM port (0-7) is for EDMA port 0, BM port (8-13) is for
+ * PPE physical port 1-6 and BM port 14 is for EIP port.
+ */
+#define PPE_BM_PORT_FC_MODE_ADDR		0x600100
+#define PPE_BM_PORT_FC_MODE_ENTRIES		15
+#define PPE_BM_PORT_FC_MODE_INC			0x4
+#define PPE_BM_PORT_FC_MODE_EN			BIT(0)
+
+#define PPE_BM_PORT_GROUP_ID_ADDR		0x600180
+#define PPE_BM_PORT_GROUP_ID_ENTRIES		15
+#define PPE_BM_PORT_GROUP_ID_INC		0x4
+#define PPE_BM_PORT_GROUP_ID_SHARED_GROUP_ID	GENMASK(1, 0)
+
+#define PPE_BM_SHARED_GROUP_CFG_ADDR		0x600290
+#define PPE_BM_SHARED_GROUP_CFG_ENTRIES		4
+#define PPE_BM_SHARED_GROUP_CFG_INC		0x4
+#define PPE_BM_SHARED_GROUP_CFG_SHARED_LIMIT	GENMASK(10, 0)
+
+#define PPE_BM_PORT_FC_CFG_TBL_ADDR		0x601000
+#define PPE_BM_PORT_FC_CFG_TBL_ENTRIES		15
+#define PPE_BM_PORT_FC_CFG_TBL_INC		0x10
+#define PPE_BM_PORT_FC_W0_REACT_LIMIT		GENMASK(8, 0)
+#define PPE_BM_PORT_FC_W0_RESUME_THRESHOLD	GENMASK(17, 9)
+#define PPE_BM_PORT_FC_W0_RESUME_OFFSET		GENMASK(28, 18)
+#define PPE_BM_PORT_FC_W0_CEILING_LOW		GENMASK(31, 29)
+#define PPE_BM_PORT_FC_W1_CEILING_HIGH		GENMASK(7, 0)
+#define PPE_BM_PORT_FC_W1_WEIGHT		GENMASK(10, 8)
+#define PPE_BM_PORT_FC_W1_DYNAMIC		BIT(11)
+#define PPE_BM_PORT_FC_W1_PRE_ALLOC		GENMASK(22, 12)
+
+#define PPE_BM_PORT_FC_SET_REACT_LIMIT(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W0_REACT_LIMIT, tbl_cfg, value)
+#define PPE_BM_PORT_FC_SET_RESUME_THRESHOLD(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W0_RESUME_THRESHOLD, tbl_cfg, value)
+#define PPE_BM_PORT_FC_SET_RESUME_OFFSET(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W0_RESUME_OFFSET, tbl_cfg, value)
+#define PPE_BM_PORT_FC_SET_CEILING_LOW(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W0_CEILING_LOW, tbl_cfg, value)
+#define PPE_BM_PORT_FC_SET_CEILING_HIGH(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W1_CEILING_HIGH, (tbl_cfg) + 0x1, value)
+#define PPE_BM_PORT_FC_SET_WEIGHT(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W1_WEIGHT, (tbl_cfg) + 0x1, value)
+#define PPE_BM_PORT_FC_SET_DYNAMIC(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W1_DYNAMIC, (tbl_cfg) + 0x1, value)
+#define PPE_BM_PORT_FC_SET_PRE_ALLOC(tbl_cfg, value)	\
+	FIELD_MODIFY(PPE_BM_PORT_FC_W1_PRE_ALLOC, (tbl_cfg) + 0x1, value)
+#endif

-- 
2.34.1


