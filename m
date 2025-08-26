Return-Path: <netdev+bounces-216781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843EBB3521A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 05:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E605682A28
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B04E2D2384;
	Tue, 26 Aug 2025 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="3knld3LU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD062D0C80;
	Tue, 26 Aug 2025 03:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177871; cv=fail; b=PN4JX8/vIewLsqXEqTGYtdbAHdjeUj8uH6uGXwe2vuWskdaQBOpm285M4iIPJG6X+EUmj3QKcI7yGpn7dEpa2/Om2d/+pqcRO0HLBSj3alw9mJES09Vf47PkFmfScNh2vXtFZdnHfqNapngiM05mVJ3pabzd2YeoCsb2+o9F0Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177871; c=relaxed/simple;
	bh=JFjctsSQX53eEaL0SxYXFAHYXDbk9DkK7OKws8qafu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lbr8Xnjbpg9W/DpQXRmalC9E8HwsYegM25IWq9h1Ap710XsYkhSvld+uV/D87I78jjFoRgaNB7rXsdvBanSHjbRR25L480K+KHZJZ/KJAe2bf9kEmU8ch4DRpcrbBCgn8QDLKiqvQEJ2RJUB1wh4jcnUHN+pXhr1zPNTusR9DDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=3knld3LU; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2ltaE/MvBmtEkbWwaJ7HQ2Sejucjv0Y6ZsyYQXDbmQ3jvJXAth9utSTaEZ07mr1OOJhB5xT8z7e4nFFjUChizwfUMtMtQaRMh0u2iohn2qECi4aOuBLfXNfgHj3ClZOBi+IEjflXRtoxmYgaikysDe5vdqezzn/FbTdoXFgWBGjcyS2c23YeuS8c9BFMz8bUnesLYlPMm29CX8TGA/sk34k2tDzdKubshaXw5+NAihHCtB5P/Qgx443yL0jgSTZ6g7IhlMSCPecgz9N9mfmOa0vqcRdllftxsvyDIDM/vJa42dCeiORXlIIj1HMg5u3n6z00j7n5T1FuaryRPCAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qh6YkT2TTsU7RXW5D6ZukMo0h0bS7fLJ2PDQkdTtrMo=;
 b=LzIsXsHB0S8KkVWzYSN/jaxv6yDMfSLPZg70fSRCItr+0+cHpeK24Sxgu7XnW9eXtVqXfST30mcX9SX2QOwjj/bGXZe2wtCblmCSweVGKCtIGBGMUsoeF9L0dc7LYlsugR5FRNCMWehGKf/YFqKcFXoMMg4EpkxvsEuepF/Jp+SVrx07xEbCTBVLfrzjH/B+jNH6AISGX/oLRGrcaHvWI7dGeSmm2CLtVmlAbr3plEQm2IOLMpr9Y0XpXHiDDhDzAVqPZGZr2M0Nz4lMN8s0atuKkFgyoayKmSJ+uDKB8vMt78pN3nSiZBTtgJ+IPxDqbVOxYbrWw++Polew2sfHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh6YkT2TTsU7RXW5D6ZukMo0h0bS7fLJ2PDQkdTtrMo=;
 b=3knld3LUUzHZpVh7+/1mWoofR27XO1cDLsJ3d+lUUbtWP6UWVNI9TIJXZdtrss/xxoFUK+iOZbHlRiJR2gJwrcz/ZXKK05oWB21uj/FuMwGK2gw3XIaS7/5K40gFr8awW8clNZ9W/gm3QP39fVKBDYNMF6WC4uVD6qj16ZnFwqi3s7s682KboHhfSDVYtQM+WFNbxVay6RtWvObgFfH3Mbt9MKpAC+LI9EwBDRsyeo9LMcpik0XJ+omn70K3dxZ4uJoPRivLHBQ9L+1glSQll4wQvdkHWUS9qX3+QdnMQLzbDhjIgTU3DWFmgevkWIywRo4vviryqPoV7OAK+bPE+w==
Received: from CH0PR03CA0088.namprd03.prod.outlook.com (2603:10b6:610:cc::33)
 by SJ4PPFC796E2723.namprd19.prod.outlook.com (2603:10b6:a0f:fc02::a4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 03:11:06 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::51) by CH0PR03CA0088.outlook.office365.com
 (2603:10b6:610:cc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 03:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 03:11:05 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Mon, 25 Aug 2025
 20:11:01 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: mxl: Add MxL LGM Network Processor SoC
Date: Tue, 26 Aug 2025 11:10:43 +0800
Message-ID: <20250826031044.563778-2-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826031044.563778-1-jchng@maxlinear.com>
References: <20250826031044.563778-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SJ4PPFC796E2723:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf97653-a5be-444b-45b0-08dde44e31f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xl91ScAZn+XmNBvFwVaBrC9m8UaPc7nm6fdVNG2nLMP2zxSYIZ45xatlgoM4?=
 =?us-ascii?Q?LEkBQCA7a6v9flwKJeZ4yta/Enu11IOO0wtTsoGK1TMd0UDLguM5J4mk9n6s?=
 =?us-ascii?Q?4wnAQVmSx50/wi7Md4K8A0qoTdg7rBVecOuQcm/njJZN8ARI25jQdjGhUGW8?=
 =?us-ascii?Q?IrH5JewxIN27cmNPy/w+IY/5NDz307BRjBN9wu53Tj1Tj/CpRlmuqhn6wmn+?=
 =?us-ascii?Q?G/XcZ+ML2wCRv3Cg+7aeaKPR1vER66Pb/8vDIIvtZzjF95XGXt9aBolGUPra?=
 =?us-ascii?Q?ah/GtDCIUpzOelxAhEtTjTYDwc4Ov/P6TdbmfiB7e390wQ+kFnXU+YvKQ9mi?=
 =?us-ascii?Q?Oga02JZ76nkOlDhtSgivWU3bLkIKvZGWrCcmRh+84FsaeLqD0gMIjHGZso0m?=
 =?us-ascii?Q?J9ae9+g0USKWYiFjf+Wkd0+ismF4TqvNXQnm84RcT+itJG1fmkWln2yKDFvD?=
 =?us-ascii?Q?+HRcBQiE7d4Cfriyz8UnAsvrLa9CxM2NNxCLOUU+ZX6mYd/VgP5Yq+S91Vi9?=
 =?us-ascii?Q?I81tx1YDN0Mq7LXP/W52NoHiQUJD+7exLg+eE5yjC4U2mMFsVghZqzcFr5s6?=
 =?us-ascii?Q?SHoCVpg0UQ97ApLpFomEq38ksLYCjCteXJbLZSHji5pZR4lqEvos7t3r5VO2?=
 =?us-ascii?Q?asYOVyzYrTrze0YKzN5J3mGS+i6B2iiR0PZApLVPHgbijjz733pWmH4uXxMV?=
 =?us-ascii?Q?A2dC46rt5fGNuq2Bm1TWYVVJlfCl5TSHNATbimfJLUdehrK/jRXRnNMR9Ohj?=
 =?us-ascii?Q?EI3SXZ7Cxhrk5D3pIYsoB7uP4Pz72cbTidiU7GrKZIddXZ9o6LeeqhX9OL1c?=
 =?us-ascii?Q?Aa2y58sQuF0cNM7Mp6G2zeBVwC4sVFR80OLFFa3QRH1xFVQnUWij5LqUmB+Y?=
 =?us-ascii?Q?/Zaa+YorhZRvTvvmjwZejQkhW+Yval1JS82MM0lTIWu5jTYCadYdnkQJ/ns0?=
 =?us-ascii?Q?cncGTBGuD/Lu2ziqC5k73x0H7yEXgOgoTm77vB9Kkd1mrSZFSmW8RxbGfHFm?=
 =?us-ascii?Q?/bHE1AimVdU/OiSeyHs99V1ujfaKpK80Dlr03pHugR93ASj17Q/9Riy/nBVc?=
 =?us-ascii?Q?v0X4xEBkYNyOg9NVmt5dAyGFip67ws4Vt44lWnz3/ldeXnvEvWLdqbGykDZE?=
 =?us-ascii?Q?FA7RpVA+L7jGZ1Jot73SOyAUSNLBTn5LfQHvwmUpQS5dIqzThSv+TC7KlcgV?=
 =?us-ascii?Q?RyEgJGW0KEd/5QvHQdAiLxfF4QtQRkogndTKIXE9gLCX9MqYlfIrh45eELNz?=
 =?us-ascii?Q?E1+nc6kx37XtlHr65P7BCbcmkMDvYkrA3VzlnyewaAFIfVcoLkHtzxcicThf?=
 =?us-ascii?Q?xluNLVLXoPIxCBoR3T437pzoUMBPXCwxzOEOADFldy606XAx0R0yoETAkNBz?=
 =?us-ascii?Q?PNp6aPutGdecKpkUpNxvpsIrd5yPJWW3oyKFR9khhV5Z/q691VnMMgV4Bp3C?=
 =?us-ascii?Q?MXqQUgJYtjlHrwolorPhnJS+M/oRK2SGp0rzfSu7/ycpqhjRpEJVnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 03:11:05.1743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf97653-a5be-444b-45b0-08dde44e31f1
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPFC796E2723

Introduce device-tree binding documentation for MaxLinear LGM Network
Processor

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../devicetree/bindings/net/mxl,lgm-eth.yaml  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml b/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
new file mode 100644
index 000000000000..aa1c7d3609ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mxl,lgm-eth.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/mxl,lgm-eth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
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
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^interface@[1-4]$":
+    type: object
+    properties:
+      compatible:
+        const: mxl,lgm-mac
+
+      reg:
+        minimum: 1
+        maximum: 4
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mac: interface@1 {
+        compatible = "mxl,eth-mac";
+        reg = <1>;
+      };
+    };
-- 
2.34.1


