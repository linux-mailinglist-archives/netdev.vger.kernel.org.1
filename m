Return-Path: <netdev+bounces-140983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB6F9B8F4C
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A5AFB231C1
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A390199384;
	Fri,  1 Nov 2024 10:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ilR6ykCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F319340F;
	Fri,  1 Nov 2024 10:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457318; cv=none; b=nvp2se3E9mGJyVyEYiNq9DrqYMQSPiu/t+bVNm0nk9WvPeEe4ZWJFsKkPb+wXtr6FKI0SXZ/1/A/EbiZxED12z9SuamLoF81QQqCMbRAy69nNg6XJ2cvcMC973ZE9jTONeFJFj2QQSj2JJQVspNS86R8lDspDUrV7SqnspkWqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457318; c=relaxed/simple;
	bh=ez6Oz15e7tFtEnPxUJUUBU8yvslLppWCnlwtyGMKK9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NyZsJT3KalkCp+zbGOHsR2hYQbyWiHXySv1w7qccGxyCR4lWxAj45VYA8rk/vT7o82vezgoB5GlTqHJVx1JMbtULZRZkiWen/o44QqxKBIqSCEDzun8Q/6NmGqFZUO14jp0Sw4lLwtHnvtjqS+CH6vJst7ByLfMIQVQ+nE1QY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ilR6ykCQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A15H3pL004044;
	Fri, 1 Nov 2024 10:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U7OwHXkhaFAS6wHJUJWydfCSFr/5ZuJeSDfsL+eq3j8=; b=ilR6ykCQfItdqz+Q
	0viRMlPHKHES0UJo51Qt08iNFJK7cqQKQkfJaEznPC+kGIP8xaVXLWq1VdK/TK/H
	WjEoUDBwbxSeIVgU2alZO3eX1zvTQ6JAgdBmX1WHj2FkEI3wl2A/znRTQcKu+phE
	rf2VaGznG+zSSRLdk4R/AUtdI3Q5H/0TAdv1OzyiIJtUQ9YZ7x9DMEYESwAG2Zfp
	5m3TjZK8bR4a1zuC2rZmhDxjNeQvsMoC/8HNe1KrwJLp+NnebFjdw232hvcnMBD3
	4h/a1fmT5UNF4yJsW4HqVfYhzTMYPUUJfXkEytbK0IjWIAx98PPFgfnpjQQVjpbH
	2vkTbw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kns3pp8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 10:34:49 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1AYm8T022328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 10:34:48 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 03:34:43 -0700
From: Lei Wei <quic_leiwei@quicinc.com>
Date: Fri, 1 Nov 2024 18:32:49 +0800
Subject: [PATCH net-next 1/5] dt-bindings: net: pcs: Add Ethernet PCS for
 Qualcomm IPQ9574 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-ipq_pcs_rc1-v1-1-fdef575620cf@quicinc.com>
References: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
In-Reply-To: <20241101-ipq_pcs_rc1-v1-0-fdef575620cf@quicinc.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
	<andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_luoj@quicinc.com>,
        <quic_leiwei@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <bartosz.golaszewski@linaro.org>, <vsmuthu@qti.qualcomm.com>,
        <john@phrozen.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730457277; l=9926;
 i=quic_leiwei@quicinc.com; s=20240829; h=from:subject:message-id;
 bh=ez6Oz15e7tFtEnPxUJUUBU8yvslLppWCnlwtyGMKK9g=;
 b=aYmGYaeDinTCGwb554ZAlrnuvyJioK8lqorBpYiz4RD9jNVxuYMXQY75voC9q0lVpQO52GvjA
 kkv6Bg3kpCTBG+twmzJCBqYuSr8D2Eaa9wYWgbcSmh6jUdBm2YH5fmi
X-Developer-Key: i=quic_leiwei@quicinc.com; a=ed25519;
 pk=uFXBHtxtDjtIrTKpDEZlMLSn1i/sonZepYO8yioKACM=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YhtbEzaJUn-nt__9weaCOPKCU1zNqrWF
X-Proofpoint-ORIG-GUID: YhtbEzaJUn-nt__9weaCOPKCU1zNqrWF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010076

The 'UNIPHY' PCS block in the IPQ9574 SoC includes PCS and SerDes
functions. It supports different interface modes to enable Ethernet
MAC connections to different types of external PHYs/switch. It includes
PCS functions for 1Gbps and 2.5Gbps interface modes and XPCS functions
for 10Gbps interface modes. There are three UNIPHY (PCS) instances
in IPQ9574 SoC which provide PCS/XPCS functions to the six Ethernet
ports.

Signed-off-by: Lei Wei <quic_leiwei@quicinc.com>
---
 .../bindings/net/pcs/qcom,ipq9574-pcs.yaml         | 230 +++++++++++++++++++++
 include/dt-bindings/net/pcs-qcom-ipq.h             |  15 ++
 2 files changed, 245 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
new file mode 100644
index 000000000000..a33873c7ad73
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/qcom,ipq9574-pcs.yaml
@@ -0,0 +1,230 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/qcom,ipq9574-pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ethernet PCS for Qualcomm IPQ SoC
+
+maintainers:
+  - Lei Wei <quic_leiwei@quicinc.com>
+
+description:
+  The UNIPHY hardware blocks in the Qualcomm IPQ SoC include PCS and SerDes
+  functions. They enable connectivity between the Ethernet MAC inside the
+  PPE (packet processing engine) and external Ethernet PHY/switch. There are
+  three UNIPHY instances in IPQ9574 SoC which provide PCS functions to the
+  six Ethernet ports.
+
+  For SGMII (1Gbps PHY) or 2500BASE-X (2.5Gbps PHY) interface modes, the PCS
+  function is enabled by using the PCS block inside UNIPHY. For USXGMII (10Gbps
+  PHY), the XPCS block in UNIPHY is used.
+
+  The SerDes provides 125M (1Gbps mode) or 312.5M (2.5Gbps and 10Gbps modes)
+  RX and TX clocks to the NSSCC (Networking Sub System Clock Controller). The
+  NSSCC divides these clocks and generates the MII RX and TX clocks to each
+  of the MII interfaces between the PCS and MAC, as per the link speeds and
+  interface modes.
+
+  Different IPQ SoC may support different number of UNIPHYs (PCSes) since the
+  number of ports and their capabilities can be different between these SoCs
+
+  Below diagram depicts the UNIPHY (PCS) connections for an IPQ9574 SoC based
+  board. In this example, the first PCS0 has four GMIIs/XGMIIs, which can connect
+  with four MACs to support QSGMII (4 x 1Gbps) or 10G_QXGMII (4 x 2.5Gbps)
+  interface modes.
+
+  -           +-------+ +---------+  +-------------------------+
+    +---------+CMN PLL| |  GCC    |  |   NSSCC (Divider)       |
+    |         +----+--+ +----+----+  +--+-------+--------------+
+    |              |         |          ^       |
+    |       31.25M |  SYS/AHB|clk  RX/TX|clk    +------------+
+    |       ref clk|         |          |       |            |
+    |              |         v          | MII RX|TX clk   MAC| RX/TX clk
+    |25/50M     +--+---------+----------+-------+---+      +-+---------+
+    |ref clk    |  |   +----------------+       |   |      | |     PPE |
+    v           |  |   |     UNIPHY0            V   |      | V         |
+  +-------+     |  v   |       +-----------+ (X)GMII|      |           |
+  |       |     |  +---+---+   |           |--------|------|-- MAC0    |
+  |       |     |  |       |   |           | (X)GMII|      |           |
+  |  Quad |     |  |SerDes |   | PCS/XPCS  |--------|------|-- MAC1    |
+  |       +<----+  |       |   |           | (X)GMII|      |           |
+  |(X)GPHY|     |  |       |   |           |--------|------|-- MAC2    |
+  |       |     |  |       |   |           | (X)GMII|      |           |
+  |       |     |  +-------+   |           |--------|------|-- MAC3    |
+  +-------+     |              |           |        |      |           |
+                |              +-----------+        |      |           |
+                +-----------------------------------+      |           |
+                +--+---------+----------+-------+---+      |           |
+  +-------+     |            UNIPHY1                |      |           |
+  |       |     |              +-----------+        |      |           |
+  |(X)GPHY|     | +-------+    |           | (X)GMII|      |           |
+  |       +<----+ |SerDes |    | PCS/XPCS  |--------|------|- MAC4     |
+  |       |     | |       |    |           |        |      |           |
+  +-------+     | +-------+    |           |        |      |           |
+                |              +-----------+        |      |           |
+                +-----------------------------------+      |           |
+                +--+---------+----------+-------+---+      |           |
+  +-------+     |           UNIPHY2                 |      |           |
+  |       |     |              +-----------+        |      |           |
+  |(X)GPHY|     | +-------+    |           | (X)GMII|      |           |
+  |       +<----+ |SerDes |    | PCS/XPCS  |--------|------|- MAC5     |
+  |       |     | |       |    |           |        |      |           |
+  +-------+     | +-------+    |           |        |      |           |
+                |              +-----------+        |      |           |
+                +-----------------------------------+      +-----------+
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq9574-pcs
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  clocks:
+    items:
+      - description: system clock
+      - description: AHB clock needed for register interface access
+
+  clock-names:
+    items:
+      - const: sys
+      - const: ahb
+
+  '#clock-cells':
+    const: 1
+    description: See include/dt-bindings/net/pcs-qcom-ipq.h for constants
+
+patternProperties:
+  "^pcs-mii@[0-4]$":
+    type: object
+    description: PCS MII interface.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 4
+        description: MII index
+
+      clocks:
+        items:
+          - description: PCS MII RX clock
+          - description: PCS MII TX clock
+
+      clock-names:
+        items:
+          - const: mii_rx
+          - const: mii_tx
+
+    required:
+      - reg
+      - clocks
+      - clock-names
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+
+    pcs0: ethernet-pcs@7a00000 {
+        compatible = "qcom,ipq9574-pcs";
+        reg = <0x7a00000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&gcc GCC_UNIPHY0_SYS_CLK>,
+                 <&gcc GCC_UNIPHY0_AHB_CLK>;
+        clock-names = "sys",
+                      "ahb";
+        #clock-cells = <1>;
+
+        pcs0_mii0: pcs-mii@0 {
+            reg = <0>;
+            clocks = <&nsscc 116>,
+                     <&nsscc 117>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+
+        pcs0_mii1: pcs-mii@1 {
+            reg = <1>;
+            clocks = <&nsscc 118>,
+                     <&nsscc 119>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+
+        pcs0_mii2: pcs-mii@2 {
+            reg = <2>;
+            clocks = <&nsscc 120>,
+                     <&nsscc 121>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+
+        pcs0_mii3: pcs-mii@3 {
+            reg = <3>;
+            clocks = <&nsscc 122>,
+                     <&nsscc 123>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+    };
+
+    pcs1: ethernet-pcs@7a10000 {
+        compatible = "qcom,ipq9574-pcs";
+        reg = <0x7a10000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&gcc GCC_UNIPHY1_SYS_CLK>,
+                 <&gcc GCC_UNIPHY1_AHB_CLK>;
+        clock-names = "sys",
+                      "ahb";
+        #clock-cells = <1>;
+
+        pcs1_mii0: pcs-mii@0 {
+            reg = <0>;
+            clocks = <&nsscc 124>,
+                     <&nsscc 125>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+    };
+
+    pcs2: ethernet-pcs@7a20000 {
+        compatible = "qcom,ipq9574-pcs";
+        reg = <0x7a20000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&gcc GCC_UNIPHY2_SYS_CLK>,
+                 <&gcc GCC_UNIPHY2_AHB_CLK>;
+        clock-names = "sys",
+                      "ahb";
+        #clock-cells = <1>;
+
+        pcs2_mii0: pcs-mii@0 {
+            reg = <0>;
+            clocks = <&nsscc 126>,
+                     <&nsscc 127>;
+            clock-names = "mii_rx",
+                          "mii_tx";
+        };
+    };
diff --git a/include/dt-bindings/net/pcs-qcom-ipq.h b/include/dt-bindings/net/pcs-qcom-ipq.h
new file mode 100644
index 000000000000..8d9124ffd75d
--- /dev/null
+++ b/include/dt-bindings/net/pcs-qcom-ipq.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ * Device Tree constants for the Qualcomm IPQ PCS
+ */
+
+#ifndef _DT_BINDINGS_PCS_QCOM_IPQ_H
+#define _DT_BINDINGS_PCS_QCOM_IPQ_H
+
+/* The RX and TX clocks which are provided from the SerDes to NSSCC. */
+#define PCS_RX_CLK		0
+#define PCS_TX_CLK		1
+
+#endif /* _DT_BINDINGS_PCS_QCOM_IPQ_H */

-- 
2.34.1


