Return-Path: <netdev+bounces-212949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F852B229CD
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 16:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F2D7B5565
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8E22E88B6;
	Tue, 12 Aug 2025 14:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nEWp/exp"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E092EBDD2;
	Tue, 12 Aug 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007881; cv=none; b=ihJogJPEUJuArRwIHRc8MdkDNrEw4EhPpw4wFBYsLanUVWLPRB4qXy39Xxjf7JTaQ64SDbGZDWzpdUWbumxV0ivarxkip2qd+9LsD/LYSmLLNEIsl6wj/mccfAen2Et8NL21wUgRIjYWsB60lvXyNvTx4GOMC+jqIY1dlTgpUEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007881; c=relaxed/simple;
	bh=yrQWzDV3xoPDSfEn03PQnVrIEcmVbGlNhAxKLdFIS54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jF9m6nDOcuAagDwRATOOAiRnJOGytusf9V4Ki7yaMpeW+henmuuMW9X/VId6Tr3ougALnVwRw76s3LRLTP5R7/gN6M2c/A5ZFH+g3L/V0ZTxniBrlRW5wx2yAKoA/sBgaJcOTBz8iNuyTv2esegj9bUTDcuUNSJvb7uxM829L1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nEWp/exp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAwHm4001246;
	Tue, 12 Aug 2025 14:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6FHyxBBE82YNX/Q2IGUrEicX5waTTaLpTnOWnTkJ45E=; b=nEWp/expESa9Tsju
	rznO8t2YSTnzbqvdqnLuTP78Dc5gW+TFoIh3+0B59QuTGcmfrS0ZjBGZxDzrzPLR
	E3oHdYsCD4F7QN9adevC60ulEgkpE+GIO4ni8ENRrZi5SdtwDWgCnB9XshKEZ2LI
	eN+CQQsrMpbvcB+8o17YlY8m69PPTp+TZJeLs8mffwNSHgOs9a6TjaCKltaZmB6+
	BMDnRXN131AWIsXaI3kuA5R3baT7i1wT2RFvu3tEvbBEXRJdIhO3yMsgPNR6n5Tu
	HL7CdKcyc5pqH4pDcgRvn86X6WtvItmRxZmZqM+LFjMd9RhQUJqlU1SRDHZAiwDo
	dVQLCw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vk9b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:08 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57CEB7fT028511
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 14:11:07 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 12 Aug 2025 07:11:02 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 12 Aug 2025 22:10:28 +0800
Subject: [PATCH net-next v7 04/14] net: ethernet: qualcomm: Initialize PPE
 buffer management for IPQ9574
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250812-qcom_ipq_ppe-v7-4-789404bdbc9a@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755007841; l=11672;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=yrQWzDV3xoPDSfEn03PQnVrIEcmVbGlNhAxKLdFIS54=;
 b=uzwWE32rAb2p2u1oG7IREB/qi5asboWjh4ZqQsfbrCV9TgaXfJjFEsouSISz8crePeiakrJFf
 pmdn7bnprhWB+9MSf99S1rCywPQrCfZ5olDpDHSlzsOsWMnwlyb2Eu9
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX5Xjn2AEKEMfo
 k69NanOwkCksAkTMSyTuLi5ZuCvuytjwwzDyhVbVjMfXfhvEWdjhpwCUwUVQSDtyhmAWWmML5Q4
 pc/0w2WU0TQxI9zz76fJZgMrJjQuClUK3LNWwxt6981DfswLBW0OjW1qIl1OWLbOBYZwOigE8P6
 p9tuxpDD2F4h2OuIfhJYBpjGdY3jao6DPMHNpk/Z0j9PPeuNJMxqMerOTkswWs6wzmKA17ylgtf
 hWIWc+tJYjnwRj+I9/mdGb757k1kJvdjjtNsxJAl/U4IkLeIvA8eVnVAeOrQWWP7GpwxxeKd4TO
 7DfjfNlV6m+ERIg2WcF1q75u/4BnPFMlN6BvHbOo8dt3M8AgDBEuHlj9P7xL6j9d+3BKRJk/A2s
 1bchPtt3
X-Proofpoint-GUID: O8ztIdUxBAkgraoUk-f94AYlnWwXkxeP
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689b4b7c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8
 a=hdbwrHnlPZYA2T6C3_4A:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: O8ztIdUxBAkgraoUk-f94AYlnWwXkxeP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107

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
index 3aacb8eddbae..6afeda082689 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -15,6 +15,7 @@
 #include <linux/reset.h>
 
 #include "ppe.h"
+#include "ppe_config.h"
 
 #define PPE_PORT_MAX		8
 #define PPE_CLK_RATE		353000000
@@ -199,6 +200,10 @@ static int qcom_ppe_probe(struct platform_device *pdev)
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
index 000000000000..45b031d4dd46
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
index 000000000000..8e032910bfe7
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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
index 000000000000..b89d717fdae8
--- /dev/null
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
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


