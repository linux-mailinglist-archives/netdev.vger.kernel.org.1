Return-Path: <netdev+bounces-215966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CCEB31295
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 861264E5DBA
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C112EE261;
	Fri, 22 Aug 2025 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="04ko8mCC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C72EDD7A;
	Fri, 22 Aug 2025 09:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853728; cv=fail; b=PG7liuf9w6aw2fygfdsaTiZrtvdPWpAlK7ORmPZX13AIcMgJLRAxb2o5NAD8YPXlUULS7Yh+fRetcE6y25+W6Un6wksESoIZuRfwY6LxXCLqvTT1gBmGoGcQf0f04z881Hr4j7FkhtX/FqNW9w+HGu7Gdu598Z/AR0M37IxFld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853728; c=relaxed/simple;
	bh=dnkGlYNdfWisJBB/iGKZb5Y2mazC19vbTbI/VvZg3Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UC1q6Ul/9EtchrtAa42eFFcP0AhGMtE6xrh0oGwhD8XOHIowC0fVdY8zuh4B9CBCbSnTGHguVS3Ur8SeiDbMhJrRtL/ssNGcqg5qqSAVYwtirvlWe4I45GyVUIk1JUyFxVOlwtbATq1kJ/c81XlzLWSaib/EJVlcfvajHfxI84E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=04ko8mCC; arc=fail smtp.client-ip=40.107.236.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+YKmohAe4caoMcnl4qhIqEKp0zSB5KTtS4ll3RLL+o7r8zsW2a5lpSVHjGvlkJN1ck4kNI2evZ58VSFZY1UMltF6+Qc4q1YPWelSjl4qAoOybd+2LYf7/vtFxOiXEEsI99XIxoiU2oeI3LPy7PIG1kRlXS7XFPBOsUUmiCdJnzPPI2FE4R7qjtdbAFLXD9/2Nz/o8im931pAZlxNx9g7bdcmgs5g9C62C8M3rrRCyvdAKE2eQPUG8DYo53fuMi6a/yzdbEcWhZGO2E7GAm3+PKhAQmJ5Qe75Jeb+dxut/KszEza4Sp5Yr/GS0r6/q4uchZpGNkrooSMvhCvOlAung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbiLe+ugs1t7S0iZpY8wcF///8N+AG1hOaI2I+/kD0c=;
 b=l2p4DsLdOO7JRc3Tt4qAotWRBifcS+6K+6UJD28sD3ijUnl0WQtvUHy5Wa2WanpvBeOylsrgTYz1wTKLqT03XuiWqa+BMlz6w0yAunsTQeNV1LYhe8/4uupsvipYKvPIfPCVoNhQlQZjTgoIIMiYYxyzW5bC6U/KtSOYCxyVjIpBYrrq4IUeg6gAJBrI59JBxwSzmyfXpBOVKPPLDzCqJsbHBtXtteQTnI50Oj7uC1U0U0i8kbOcr6mDLhMnt8lF/Wrb/2gM2V82Ki6NGpmRa8buohxRs9iv8NrGR4Q3kzlwuWjTrP/SquPRHvJWcu7rQP6vkP/foQV+KzbCDNaWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbiLe+ugs1t7S0iZpY8wcF///8N+AG1hOaI2I+/kD0c=;
 b=04ko8mCCVMIebMxW4M1kl9HyQgy/W2/m8Cuy9r5l7ePYq85LadOUYK+i3Yz2ULBmPfDmrFV8c7IZ+gO7GwwWG/Veuhz7UOPTSH98HOAqmR93FaHfJslGftNCNBJx4+Ft1Mre9X1mUKYEe/IPAnb1ivnwX6zwYgduFfEP7EDq+VPDJHs+/N80tH+LlkJnU+PXlbprdUqnysVv/qq0JHHNGJO5GeZ42BbX4hr8lsHqemjkSgcCvNNWXqild8Tah/vAp1gfQt8bDI7kEpYi+bX4GB08H8CvUaneZvgdkxvTKSiUG0Wo7s/mgOhFkajxYZJsEScmdupBKkB2ZRR8aW2BFA==
Received: from BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::11)
 by LV3PR19MB8368.namprd19.prod.outlook.com (2603:10b6:408:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 09:08:39 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::e4) by BL1P223CA0006.outlook.office365.com
 (2603:10b6:208:2c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.18 via Frontend Transport; Fri,
 22 Aug 2025 09:08:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.83)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.83; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.83) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 09:08:38 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.120) with Microsoft SMTP Server id 15.1.2507.55; Fri, 22 Aug 2025
 02:08:34 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next 2/2] dt-bindings: net: mxl: Add MxL LGM Network Processor SoC
Date: Fri, 22 Aug 2025 17:08:09 +0800
Message-ID: <20250822090809.1464232-3-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822090809.1464232-1-jchng@maxlinear.com>
References: <20250822090809.1464232-1-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|LV3PR19MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d383de8-5cf5-49d9-f888-08dde15b7b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9Ckd9EUA0UhZ+cDr8MBPEHkazaujphYpKN9lNoCeoD1rCImDLaZa72efpBf?=
 =?us-ascii?Q?jre2Bv5TJ22Fm9Pf8urGGM1Jrlg9H4/8prbgFYtp1GYZ83oq/UA5K3/LywjE?=
 =?us-ascii?Q?gorna73BIs8k3TB+WmPENzgXIAAW9DPTe4OLGK0fH23klrTbm0mYEPFV9x0j?=
 =?us-ascii?Q?QqjYdA5ss9qhDYLE1JA6JqROQZUUSR/m4nFLbkBTH1G/4tO26vrKGGsyXrOI?=
 =?us-ascii?Q?fDRpt+k8AxhpyVXzhG7ASp/oLQ137e3rBtw9DgUxkYRuBiDDIwmzsTG+nFWd?=
 =?us-ascii?Q?UwBHqU2DgAIb7vsdwrnhDFFyx33zxKWV0yAN1vCLQ7Bg+5ou3EiwxrKpO5QK?=
 =?us-ascii?Q?weTNgmfdUc3cBzNRsEuGDMkIrXc5lFlJI3NmNRKr39QI/0ZTjAMM4jAhK9/b?=
 =?us-ascii?Q?TKoqsp1Da6lfLC253L58vJcARR+mxcW2YHTdIu1W39Jrw2/P8r1Vo12DsC75?=
 =?us-ascii?Q?Rqn16Wya44hBHk3W/C1P7WWUQ0y8lsocpsq/8AoWsEGSETV//FzZMW0xkuR1?=
 =?us-ascii?Q?MPsi4+blRSlPX091fIB7fBhrY1WO5qYN8Kgyuq6vVdnxmQwIzzgcnWhKDBuj?=
 =?us-ascii?Q?6aSDfG5+4gnCfq26jMalvdnTZFklxcs1+0IHJ2nod+avmsNoMw1ZA9nGi7uY?=
 =?us-ascii?Q?NEoCme4gRKNNe5dbP812V7QjRsy53iZSUlerzwzzDqYjC92IjguhhWpGzD7x?=
 =?us-ascii?Q?86TerZZr5ucqbUNakJLghzsbFTab0Zu0UN/JJTA3nhyk2tonCd4PsV8dsad5?=
 =?us-ascii?Q?5z6FVkb/Y5jyx0sgEkxZdmGsqvx9rDAT6/uygVJ8NVK/yrxOU5oxdUA6o8/N?=
 =?us-ascii?Q?o1YxXIlHl5+A8S0Fv78IWUfxmJMBSJtMP8txm3PWEWFBuNFNCBff8wDvx2KJ?=
 =?us-ascii?Q?DqEfqhqJIMpjauMsK1dia4MW9ZsMWaDmSsw/zD2NzX7yOuf3IFWsDIf8W/Cp?=
 =?us-ascii?Q?wTSxFcxSkaj6LmEsPPtDGxgxev8oRpRZzrJLoYwwRGBuwJBYDFxgTAZLiBM9?=
 =?us-ascii?Q?F9gPHj5Lfg3u9Fe3I2fVmLeu+FxK2Hp/Zfj8C3rlHgBIbgB7j/gkHraSGTVs?=
 =?us-ascii?Q?bCzWI5kdaTSUV+yRMKO7g9Q3tGzT5WaFVvLmrpXLeWdUTjY2isg6bQm+HZlG?=
 =?us-ascii?Q?4V1Oc9CGbDo0awQrt7hF8JiZWYyaGOI2Vn45V1Plj/xq1ljO0SeXX55FqEMj?=
 =?us-ascii?Q?DZNjeLCXpmaakOJomHVmC2ccNdW5+dqyZbfKg3lYY5BsplIlhTrvk9uQVRE0?=
 =?us-ascii?Q?sJ06yvTSrw0y/yYN4YtK7k8ufPJbxoVp7NNIIGvOu8MNmUCI19pPhL8ob21R?=
 =?us-ascii?Q?mr8AG7v79DAVdD+QWx6qdaz2N4unXkhr81PJRaqCHpSNtH+jiS0yVE084WJX?=
 =?us-ascii?Q?rrhKs8bPb4GLplItTUb00GKafd7aPvwc4tjey14vU4Ugp2Z7V3exTgcdrASj?=
 =?us-ascii?Q?2pjFOjebJ8j7fZ8Y3U7W/SC5ID76FBkxr3WtJsn4PMKvqMMkznRrIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-83.static.ctl.one;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 09:08:38.6758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d383de8-5cf5-49d9-f888-08dde15b7b97
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.83];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8368

Introduce device-tree binding documentation for
MaxLinear LGM Network Processor

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../devicetree/bindings/net/mxl,lgm-eth.yaml  | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml b/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
new file mode 100644
index 000000000000..3d5b32b5b650
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/net/mxl,lgm-eth.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MaxLinear LGM Ethernet Controller
+
+maintainers:
+  - Jack Ping Chng <jchng@maxlinear.com>
+
+description:
+  Binding for MaxLinear LGM Ethernet controller
+
+properties:
+  compatible:
+    enum:
+      - mxl,lgm-eth
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: ethif
+
+  resets:
+    maxItems: 1
+
+patternProperties:
+  "^interface$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - mxl,lgm-mac
+    required:
+      - compatible
+    additionalProperties: false
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    eth {
+      compatible = "mxl,lgm-eth";
+      clocks = <&cgu0 32>;
+      clock-names = "ethif";
+      resets = <&rcu0 0x70 8>;
+
+      interface {
+          compatible = "mxl,lgm-mac";
+      };
+    };
-- 
2.34.1


