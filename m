Return-Path: <netdev+bounces-198551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697FADCA86
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DA816776F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3F62E889A;
	Tue, 17 Jun 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MZIuKXmN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27602E8894;
	Tue, 17 Jun 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162046; cv=none; b=nny7zXd/wCMQvTRMcZqJQwz4cRGJxUiDxWm5IAhVU6kp56vl8J2feNVXYNYGaBECEGgcdxb9sQ8WHDPQQZ1+fuZXtphMIW44fEZK5/nxCqffeeLLH+0UuiuGaMaramvSu+hU/uWN9zsH9o7+f02t6vC/3x8WwhgYOUB2X+Lcmlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162046; c=relaxed/simple;
	bh=gJ/Lge6tluRXH2x/fH1u45HbZ1TFyYzVXHj5AJjWl9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cH3bJvYALUYLz6+yt3pflRYeOyagQRLMl5CzZQX/gYE4XZh/LBAbud23OrAxkvLYla3+HzExYHASktifadRObJP0mx5xFxDM/t8pJiYfJOIjCJxzZXK38HCB4+sXZsviafgLHUSOR4z1vY6lmS+bjpbl1JW5wCso+OyM7geF5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MZIuKXmN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H80HIt016706;
	Tue, 17 Jun 2025 12:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3dcV9zYrDpm2W+ZIlFACOHCeRzOfs+h8NxseSoLwYq4=; b=MZIuKXmNvK/at/cx
	BVgezOZL679Anmb5CvSYnDlrd1pcwqO/Yht16hJgLkFbeAtwvqmRP+63/M6QjUbj
	97hq7HL0EooduHc4OWvh1H+ZgtbcZxvVIrhx0mxCCaTZ0pPHUEeqVUiAB0tWKnwq
	6AgF9oNKccYGSd8W4ILF8sXPv4qySonVfFxpNmY7ovmoDUORPkvFz9zLBiHOy99n
	CItud3YXhi/JtMSbk6jTp+C5nw3NdgaGghkEItF4koTKIJcD4v/Pwt7sUIbz6qg2
	ugF85HLnjkodl/uvZIihjCpEwnWCUGaPqpRNUY6qxFzc8d0Dpk50xTFLB4xHJHJ3
	kMrq3A==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791hfga9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55HC7Cp2004640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jun 2025 12:07:12 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Jun 2025 05:07:06 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 17 Jun 2025 20:06:36 +0800
Subject: [PATCH 5/8] dt-bindings: clock: qcom: Add NSS clock controller for
 IPQ5424 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250617-qcom_ipq5424_nsscc-v1-5-4dc2d6b3cdfc@quicinc.com>
References: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
In-Reply-To: <20250617-qcom_ipq5424_nsscc-v1-0-4dc2d6b3cdfc@quicinc.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Anusha Rao <quic_anusha@quicinc.com>,
        "Richard
 Cochran" <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750161999; l=10167;
 i=quic_luoj@quicinc.com; s=20250209; h=from:subject:message-id;
 bh=gJ/Lge6tluRXH2x/fH1u45HbZ1TFyYzVXHj5AJjWl9E=;
 b=jJ/Hy9D383NJpRrrqh6quydYTMmCC4BqZZ4AmoIZm2+42kO7/bLAm4Ms9jieD7Nj6etMDS3Z0
 86UUa+Ns+rCBmZZcgh3Jq2QvHUeceaFaS/WeoaxUMyE3sh+bGfSOjY1
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=pzwy8bU5tJZ5UKGTv28n+QOuktaWuriznGmriA9Qkfc=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA5NiBTYWx0ZWRfXz7BcBUOWHCnm
 GnQ1qmE9Z0hPceWBYo9gs81Bpnq1dLvMlxASDNqRiOeM4BQ6KZAterH8pdhCBdUkAbATNT1BMPR
 c86/qoQ2GEpES/Kp+DVQEh4FLSw6IDrsm9o4OumS7DxjO1TrGpfrvfUi1gsfqeCtcA1sVtpzChe
 qFs1k4EaQG42bH578XIG0VAXiaekfQpHF/XSHjX+uigyirp1Fd5F54AW+f1BF8AKGsXmPvGj4gB
 nRJ50OTLreRz/8RFTih/NMAoF1VxPeeljG2RNDlIC13jG1ajCjYus1H6KpB0/WN/MwP2D4Hw9SB
 SJOFEGDtmnJHL60x6P6uSloqFMWGtx9Or7Z7YVjrwZHaFu4vkxqAOCQWVsmMxG9Amtsxf2+LtjI
 EvZBgFFBuneK8Hs7ACHnE9ndGO4XCwxKPqfeSDmztAtXiAw14Q2JfWKvNdExJ16UikXwqclk
X-Authority-Analysis: v=2.4 cv=VvEjA/2n c=1 sm=1 tr=0 ts=68515a70 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gEfo2CItAAAA:8
 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=MNkOokDTngcochq761IA:9 a=QEXdDO2ut3YA:10
 a=sptkURWiP4Gy88Gu7hUp:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OJ0IytjRnXXgksEvLdCtrKaFalaox2xr
X-Proofpoint-ORIG-GUID: OJ0IytjRnXXgksEvLdCtrKaFalaox2xr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_05,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170096

NSS clock controller provides the clocks and resets to the
networking blocks such as PPE (Packet Process Engine) and
UNIPHY (PCS) on IPQ5424 devices.

Add the compatible "qcom,ipq5424-nsscc" support based on the
current IPQ9574 NSS clock controller DT binding file.
ICC clocks are always provided by the NSS clock controller
of IPQ9574 and IPQ5424, so add interconnect-cells as required
DT property.

Also add master/slave ids for IPQ5424 networking interfaces,
which is used by nss-ipq5424 driver for providing interconnect
services using icc-clk framework.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../bindings/clock/qcom,ipq9574-nsscc.yaml         | 66 +++++++++++++++++++---
 include/dt-bindings/clock/qcom,ipq5424-nsscc.h     | 65 +++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq5424.h    | 13 +++++
 include/dt-bindings/reset/qcom,ipq5424-nsscc.h     | 46 +++++++++++++++
 4 files changed, 182 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
index 17252b6ea3be..5bc2fe049b26 100644
--- a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
+title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574 and IPQ5424
 
 maintainers:
   - Bjorn Andersson <andersson@kernel.org>
@@ -12,21 +12,25 @@ maintainers:
 
 description: |
   Qualcomm networking sub system clock control module provides the clocks,
-  resets on IPQ9574
+  resets on IPQ9574 and IPQ5424
 
-  See also::
+  See also:
+    include/dt-bindings/clock/qcom,ipq5424-nsscc.h
     include/dt-bindings/clock/qcom,ipq9574-nsscc.h
+    include/dt-bindings/reset/qcom,ipq5424-nsscc.h
     include/dt-bindings/reset/qcom,ipq9574-nsscc.h
 
 properties:
   compatible:
-    const: qcom,ipq9574-nsscc
+    enum:
+      - qcom,ipq5424-nsscc
+      - qcom,ipq9574-nsscc
 
   clocks:
     items:
       - description: Board XO source
-      - description: CMN_PLL NSS 1200MHz (Bias PLL cc) clock source
-      - description: CMN_PLL PPE 353MHz (Bias PLL ubi nc) clock source
+      - description: CMN_PLL NSS 1200 MHz or 300 MHZ (Bias PLL cc) clock source
+      - description: CMN_PLL PPE 353 MHz  or 375 MHZ (Bias PLL ubi nc) clock source
       - description: GCC GPLL0 OUT AUX clock source
       - description: Uniphy0 NSS Rx clock source
       - description: Uniphy0 NSS Tx clock source
@@ -42,8 +46,12 @@ properties:
   clock-names:
     items:
       - const: xo
-      - const: nss_1200
-      - const: ppe_353
+      - enum:
+          - nss_1200
+          - nss_300
+      - enum:
+          - ppe_353
+          - ppe_375
       - const: gpll0_out
       - const: uniphy0_rx
       - const: uniphy0_tx
@@ -57,9 +65,50 @@ required:
   - compatible
   - clocks
   - clock-names
+  - '#interconnect-cells'
 
 allOf:
   - $ref: qcom,gcc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq9574-nsscc
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: xo
+            - const: nss_1200
+            - const: ppe_353
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,ipq5424-nsscc
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: xo
+            - const: nss_300
+            - const: ppe_375
+            - const: gpll0_out
+            - const: uniphy0_rx
+            - const: uniphy0_tx
+            - const: uniphy1_rx
+            - const: uniphy1_tx
+            - const: uniphy2_rx
+            - const: uniphy2_tx
+            - const: bus
 
 unevaluatedProperties: false
 
@@ -94,5 +143,6 @@ examples:
                     "bus";
       #clock-cells = <1>;
       #reset-cells = <1>;
+      #interconnect-cells = <1>;
     };
 ...
diff --git a/include/dt-bindings/clock/qcom,ipq5424-nsscc.h b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
new file mode 100644
index 000000000000..59ce056ead93
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,ipq5424-nsscc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
+#define _DT_BINDINGS_CLOCK_QCOM_IPQ5424_NSSCC_H
+
+/* NSS_CC clocks */
+#define NSS_CC_CE_APB_CLK					0
+#define NSS_CC_CE_AXI_CLK					1
+#define NSS_CC_CE_CLK_SRC					2
+#define NSS_CC_CFG_CLK_SRC					3
+#define NSS_CC_DEBUG_CLK					4
+#define NSS_CC_EIP_BFDCD_CLK_SRC				5
+#define NSS_CC_EIP_CLK						6
+#define NSS_CC_NSS_CSR_CLK					7
+#define NSS_CC_NSSNOC_CE_APB_CLK				8
+#define NSS_CC_NSSNOC_CE_AXI_CLK				9
+#define NSS_CC_NSSNOC_EIP_CLK					10
+#define NSS_CC_NSSNOC_NSS_CSR_CLK				11
+#define NSS_CC_NSSNOC_PPE_CFG_CLK				12
+#define NSS_CC_NSSNOC_PPE_CLK					13
+#define NSS_CC_PORT1_MAC_CLK					14
+#define NSS_CC_PORT1_RX_CLK					15
+#define NSS_CC_PORT1_RX_CLK_SRC					16
+#define NSS_CC_PORT1_RX_DIV_CLK_SRC				17
+#define NSS_CC_PORT1_TX_CLK					18
+#define NSS_CC_PORT1_TX_CLK_SRC					19
+#define NSS_CC_PORT1_TX_DIV_CLK_SRC				20
+#define NSS_CC_PORT2_MAC_CLK					21
+#define NSS_CC_PORT2_RX_CLK					22
+#define NSS_CC_PORT2_RX_CLK_SRC					23
+#define NSS_CC_PORT2_RX_DIV_CLK_SRC				24
+#define NSS_CC_PORT2_TX_CLK					25
+#define NSS_CC_PORT2_TX_CLK_SRC					26
+#define NSS_CC_PORT2_TX_DIV_CLK_SRC				27
+#define NSS_CC_PORT3_MAC_CLK					28
+#define NSS_CC_PORT3_RX_CLK					29
+#define NSS_CC_PORT3_RX_CLK_SRC					30
+#define NSS_CC_PORT3_RX_DIV_CLK_SRC				31
+#define NSS_CC_PORT3_TX_CLK					32
+#define NSS_CC_PORT3_TX_CLK_SRC					33
+#define NSS_CC_PORT3_TX_DIV_CLK_SRC				34
+#define NSS_CC_PPE_CLK_SRC					35
+#define NSS_CC_PPE_EDMA_CFG_CLK					36
+#define NSS_CC_PPE_EDMA_CLK					37
+#define NSS_CC_PPE_SWITCH_BTQ_CLK				38
+#define NSS_CC_PPE_SWITCH_CFG_CLK				39
+#define NSS_CC_PPE_SWITCH_CLK					40
+#define NSS_CC_PPE_SWITCH_IPE_CLK				41
+#define NSS_CC_UNIPHY_PORT1_RX_CLK				42
+#define NSS_CC_UNIPHY_PORT1_TX_CLK				43
+#define NSS_CC_UNIPHY_PORT2_RX_CLK				44
+#define NSS_CC_UNIPHY_PORT2_TX_CLK				45
+#define NSS_CC_UNIPHY_PORT3_RX_CLK				46
+#define NSS_CC_UNIPHY_PORT3_TX_CLK				47
+#define NSS_CC_XGMAC0_PTP_REF_CLK				48
+#define NSS_CC_XGMAC0_PTP_REF_DIV_CLK_SRC			49
+#define NSS_CC_XGMAC1_PTP_REF_CLK				50
+#define NSS_CC_XGMAC1_PTP_REF_DIV_CLK_SRC			51
+#define NSS_CC_XGMAC2_PTP_REF_CLK				52
+#define NSS_CC_XGMAC2_PTP_REF_DIV_CLK_SRC			53
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index 66cd9a9ece03..a78604beff99 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -27,4 +27,17 @@
 #define MASTER_NSSNOC_SNOC_1		22
 #define SLAVE_NSSNOC_SNOC_1		23
 
+#define MASTER_NSSNOC_PPE		0
+#define SLAVE_NSSNOC_PPE		1
+#define MASTER_NSSNOC_PPE_CFG		2
+#define SLAVE_NSSNOC_PPE_CFG		3
+#define MASTER_NSSNOC_NSS_CSR		4
+#define SLAVE_NSSNOC_NSS_CSR		5
+#define MASTER_NSSNOC_CE_AXI		6
+#define SLAVE_NSSNOC_CE_AXI		7
+#define MASTER_NSSNOC_CE_APB		8
+#define SLAVE_NSSNOC_CE_APB		9
+#define MASTER_NSSNOC_EIP		10
+#define SLAVE_NSSNOC_EIP		11
+
 #endif /* INTERCONNECT_QCOM_IPQ5424_H */
diff --git a/include/dt-bindings/reset/qcom,ipq5424-nsscc.h b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
new file mode 100644
index 000000000000..f2f7eaa28b21
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,ipq5424-nsscc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
+#define _DT_BINDINGS_RESET_QCOM_IPQ5424_NSSCC_H
+
+#define NSS_CC_CE_APB_CLK_ARES					0
+#define NSS_CC_CE_AXI_CLK_ARES					1
+#define NSS_CC_DEBUG_CLK_ARES					2
+#define NSS_CC_EIP_CLK_ARES					3
+#define NSS_CC_NSS_CSR_CLK_ARES					4
+#define NSS_CC_NSSNOC_CE_APB_CLK_ARES				5
+#define NSS_CC_NSSNOC_CE_AXI_CLK_ARES				6
+#define NSS_CC_NSSNOC_EIP_CLK_ARES				7
+#define NSS_CC_NSSNOC_NSS_CSR_CLK_ARES				8
+#define NSS_CC_NSSNOC_PPE_CLK_ARES				9
+#define NSS_CC_NSSNOC_PPE_CFG_CLK_ARES				10
+#define NSS_CC_PORT1_MAC_CLK_ARES				11
+#define NSS_CC_PORT1_RX_CLK_ARES				12
+#define NSS_CC_PORT1_TX_CLK_ARES				13
+#define NSS_CC_PORT2_MAC_CLK_ARES				14
+#define NSS_CC_PORT2_RX_CLK_ARES				15
+#define NSS_CC_PORT2_TX_CLK_ARES				16
+#define NSS_CC_PORT3_MAC_CLK_ARES				17
+#define NSS_CC_PORT3_RX_CLK_ARES				18
+#define NSS_CC_PORT3_TX_CLK_ARES				19
+#define NSS_CC_PPE_BCR						20
+#define NSS_CC_PPE_EDMA_CLK_ARES				21
+#define NSS_CC_PPE_EDMA_CFG_CLK_ARES				22
+#define NSS_CC_PPE_SWITCH_BTQ_CLK_ARES				23
+#define NSS_CC_PPE_SWITCH_CLK_ARES				24
+#define NSS_CC_PPE_SWITCH_CFG_CLK_ARES				25
+#define NSS_CC_PPE_SWITCH_IPE_CLK_ARES				26
+#define NSS_CC_UNIPHY_PORT1_RX_CLK_ARES				27
+#define NSS_CC_UNIPHY_PORT1_TX_CLK_ARES				28
+#define NSS_CC_UNIPHY_PORT2_RX_CLK_ARES				29
+#define NSS_CC_UNIPHY_PORT2_TX_CLK_ARES				30
+#define NSS_CC_UNIPHY_PORT3_RX_CLK_ARES				31
+#define NSS_CC_UNIPHY_PORT3_TX_CLK_ARES				32
+#define NSS_CC_XGMAC0_PTP_REF_CLK_ARES				33
+#define NSS_CC_XGMAC1_PTP_REF_CLK_ARES				34
+#define NSS_CC_XGMAC2_PTP_REF_CLK_ARES				35
+
+#endif

-- 
2.34.1


