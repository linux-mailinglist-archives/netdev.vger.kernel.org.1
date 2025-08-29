Return-Path: <netdev+bounces-218267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F92DB3BBA1
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BE931CC061C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28631282F;
	Fri, 29 Aug 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="NmYRV5vQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF9317715;
	Fri, 29 Aug 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471747; cv=fail; b=ZpGrNqSiuf2gpLiHZ+s8w+R2SyKVyXMdQu7nZJuoVrPYKGEZ6t5RSFMLS081ChuO/bju964CPsVtLVOUC82Rj6OjipNJY2nPSnGHupva71ACzC7jsVSaY9va/XFguVPGfhCuJUKnFpa8p/2rANNlQRIDZrNPQZ+G3UwzolgVg9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471747; c=relaxed/simple;
	bh=DvmAfgdc7KfUQFfAHbiPm5O17mz7kbA8LQz582pdzXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSAbnCvVdrLrMfvUc6LK7zmUmZD8KNveBVNS4BYwgKsvGWVBvdgWob/do9hg5AD2Opp1v6eOrdJMPAKGVlKyCfN/w4PSnRRKQA1lQFjT2dTzUL6Fg9mwDbTDuzzWkhP03wCFCbzMhHLnwVzyOYbZ9vo/v3yEPAbEqAkwA8AIIFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=NmYRV5vQ; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsCBkeoSelJp1QXkf504JzjKQZDjNnoaciDES625wgN3naiaFSg2a98wq2gOfmZEtl5lfXK/oEqqcNiVYYscHSINxEATZCbQ8Hp2FMRhDzLjz9aISlQKGxyCMpc5jhFB0SoCAyevpuAQgRobAocl1hM65aVArsB/ev0SR5eg8D/KvUTnXly6eDHbtc1xQxw9PmSZ3sUcwQdU7PMOJ0vNqjGy3+tt9koPv9xuXeUXassrphZieY+EVUTpfEpB/xZyf5bU95Inckxy4svBSzMTcdjVeMOdDN/xNvtIU8RoLY3DOsSXASfXD/FOAEbzKEHjxhyGCExLL1NIUHczyEg8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqPlkrMpCCCWizw4J2xwvDYatSHwkvIAW+P3GvPSugQ=;
 b=HZ5n1Jr2gXjyTGLtXbGb45x6/PXucqvgw6fOtRVmKUbAhELAqMCplBOpDvlafw+mxrp2erp0594AY38xP621HQn0vkeg+udhQWup2Piwy8zZEj7HaDin7n2SojkB9Fulj4K+lZqI+7RuqikfWRGGkvjHKVgXCe5Lp9yX19OgHKiASjXjtGLjuTFu0wvSoO19KZrX2Hn03374bUgvDksv9Mxq/ReOlEMQNXBI1F4d/4EgPlsz8zO+gFuAgeP4xgA0YCmIJMt+q3LteHNbF5C7Ftw8qCbh2wnQz7uFfQinFnjDEKBVc99XR+b33qkFNMxhk4Me9UO/nSDgKsZTWnpFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 174.47.1.92) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=maxlinear.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=maxlinear.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqPlkrMpCCCWizw4J2xwvDYatSHwkvIAW+P3GvPSugQ=;
 b=NmYRV5vQkbwFwiXJU+/vq5W14rEPmzX5s0X0xTqS8JxdZqlq0p+Nvj5OhvJ+xxTUy+UltLmFOcpqjYkg7Dkc3KBzpRrHfE3iHk51VxK6GH2KOeFFyPOASJIPepQA+v/h6fp/I5svFstlYl//cCOtSWHkuz+D8CkszCuD2kGEVG3k5v1rHCx699xdjorQPeaVmO2kKJsoHZsDOuDwJqYfExzW27/x7rQhBf+E3nzXliSmxr2hylZHWylHaox0yXhaMXcfv77QeX+OZSVthdFV+e3OY6mlT6C+hP5oLLOfvAPjzbl6MCi+wfogY0+CdsaaljYp1VF5xis/p8xaIFpDIw==
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by MW3PR19MB4300.namprd19.prod.outlook.com (2603:10b6:303:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 29 Aug
 2025 12:49:02 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::fb) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.10 via Frontend Transport; Fri,
 29 Aug 2025 12:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 174.47.1.92)
 smtp.mailfrom=maxlinear.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=maxlinear.com;
Received-SPF: Pass (protection.outlook.com: domain of maxlinear.com designates
 174.47.1.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=174.47.1.92; helo=usmxlcas.maxlinear.com; pr=C
Received: from usmxlcas.maxlinear.com (174.47.1.92) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 12:49:02 +0000
Received: from sgb016.sgsw.maxlinear.com (10.23.238.16) by mail.maxlinear.com
 (10.23.38.31) with Microsoft SMTP Server id 15.2.1544.25; Fri, 29 Aug 2025
 05:48:58 -0700
From: Jack Ping CHNG <jchng@maxlinear.com>
To: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <yzhu@maxlinear.com>,
	<sureshnagaraj@maxlinear.com>, Jack Ping CHNG <jchng@maxlinear.com>
Subject: [PATCH net-next v3 1/2] dt-bindings: net: mxl: Add MxL LGM Network Processor SoC
Date: Fri, 29 Aug 2025 20:48:42 +0800
Message-ID: <20250829124843.881786-2-jchng@maxlinear.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829124843.881786-1-jchng@maxlinear.com>
References: <20250829124843.881786-1-jchng@maxlinear.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MW3PR19MB4300:EE_
X-MS-Office365-Filtering-Correlation-Id: 2290c1f1-a5cc-4117-4d9b-08dde6fa6e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4LK6a+/fEqWxLuWmcMAR77N+mdpvpVaB3hLumBbAX6SR5wI6xXsGw/xr7CbO?=
 =?us-ascii?Q?BV1JrAMRoMWSV/sYLbBCMqfx30rNpO3u043OS6D9K/bIK9uN4pBJlvOytzk7?=
 =?us-ascii?Q?/+ehrpldcCmdvwmEOPla9MthdTZ1Aq183lwJGxLrZFcmOi+H89YhhEDske1T?=
 =?us-ascii?Q?fNeXzUnk+tHufgRAF3zi9WhXHZSiv6IkaxkOQCHuGXk3I5l/pN4vS+eWP/Tr?=
 =?us-ascii?Q?hCR1uctXwfPUUQ5JdUeO+UXpITpkzzzl7gzZIgBQuOZdl8jhUbyAvJ455HQs?=
 =?us-ascii?Q?JAEzhEsVLMtrnn6FIgIRdJk4YaCRe2O7P25hXz/EgjP2qlBs5fYi4+KRUU4J?=
 =?us-ascii?Q?tWlPjfkzQ4MnMiUIa38JXPe3GBeelfG8b7JH4f3FehIAZQ50tDoakNl9+Dl4?=
 =?us-ascii?Q?P0ldmgrmKzJqEm5fMvjyeIZRwDOPlyVBckSj3pCjiGCvRmpfjJf+/K6/SG8W?=
 =?us-ascii?Q?lJEuDe9H8pCBgBgH15CMm7o25gub1uoZsEHqgpe8ggJ1Oy2s/VmjRQ4SqJ6h?=
 =?us-ascii?Q?1HWJEGbQEBYa/XvnPCZ9Pa7MryPo4OIo6ol5B3/JR9w+SfFyH+sYRYMpXnCq?=
 =?us-ascii?Q?Lu3bnIPI/K/MujtyzZ4BpeYOrTJa7LGTDyv3vXIoHLXIy1s5GRVimS8ujbr6?=
 =?us-ascii?Q?oJuFra2LErXNjTWvxOCT9AskLSnO5hGumOOhjqQuNE4f56tUGJ9qevy9IQH7?=
 =?us-ascii?Q?TVdTLqnbooof/1cQJukUZ8G/oRCMju96htrrcbp+Wnh65VAjUP+g0gucpDTV?=
 =?us-ascii?Q?HNVsrlnDJOQojsqmAas3GJezdT7HxeEdiMdYN0m8pjKK6OZeliqcEWaE9Gjm?=
 =?us-ascii?Q?hcq10JmJmCAcWs5TD4d5DUmkQz+GFp4UUrwOakbmZmj+ie1+X0GnFkGCCG6v?=
 =?us-ascii?Q?kMNaoJbYlKpjuoDAUQ3VIyZ+Za8urhxaDtMJr9y/UAQUDoTByfwHnDDJt6W4?=
 =?us-ascii?Q?hH8VBj/LhIzSmYD0+hUUlhWPAck5lexwTd28Phgp1XBVeS+r2n7JoDcVEIMp?=
 =?us-ascii?Q?YhPqA5M2pVCHmgHOCDk0SqXoeMsWHwQamtfrGi9fF8isgu30t6O4a+nEW2KW?=
 =?us-ascii?Q?ceOcEvUEr5ESCbc1E2xmzgAmHfw/h/xVtkn5qo9g2WLST4arWJlOlsoRStnR?=
 =?us-ascii?Q?7t4qlVZ1od1pAnsn9NgktXFe8eLVxzvn4u+LKDVHEfLZmqEt+kgzXTf2ZB3y?=
 =?us-ascii?Q?lIqxdUFOAoQDtRt2oTUajYJrgR2jInrUj5lRiWpO9acZgI0b6ly4ZXycvjXI?=
 =?us-ascii?Q?DF+X0IxjQ21i0nOCbWhphbqmEYJ3X3zPWVo077etmXztgY0y53tMeKlyQoGD?=
 =?us-ascii?Q?lN9p6QA38LjHESUoDyfr1STk8Am0HoUNuopnQpW9LBAs9wCW3x5+eg5AF9pQ?=
 =?us-ascii?Q?srhagMVLSmNEdbYp2LirEdaTeciGZQb7zfVt0WRySFrgp75CX8hF9SLZ+nY6?=
 =?us-ascii?Q?808042+fFr6XmbSpkkB2waHZLD4yJJfLbDxjG5GRoUEmPbUR6aj8gw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:174.47.1.92;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:usmxlcas.maxlinear.com;PTR:174-47-1-92.static.ctl.one;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:49:02.2748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2290c1f1-a5cc-4117-4d9b-08dde6fa6e51
X-MS-Exchange-CrossTenant-Id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=dac28005-13e0-41b8-8280-7663835f2b1d;Ip=[174.47.1.92];Helo=[usmxlcas.maxlinear.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR19MB4300

Add devicetree binding documentation for the MaxLinear LGM SoC
Ethernet controller.

Signed-off-by: Jack Ping CHNG <jchng@maxlinear.com>
---
 .../bindings/net/maxlinear,lgm-eth.yaml       | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml

diff --git a/Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml b/Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml
new file mode 100644
index 000000000000..d613f4e535f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/maxlinear,lgm-eth.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/maxlinear,lgm-eth.yaml#
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
+      - maxlinear,lgm-eth
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: port
+      - const: ctrl
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
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^port@[0-3]$":
+        type: object
+        $ref: ethernet-controller.yaml#
+        additionalProperties: false
+
+        properties:
+          reg:
+            description: port id
+            maxItems: 1
+
+          phy-handle:
+            maxItems: 1
+
+        required:
+          - reg
+          - phy-handle
+
+  mdio:
+    $ref: mdio.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - mdio
+
+examples:
+  - |
+    ethernet@e7140000 {
+        compatible = "maxlinear,lgm-eth";
+        reg = <0xe7140000 0x1200>,<0xe7150000 0x4000>;
+        reg-names = "port", "ctrl";
+        clocks = <&cgu0 32>;
+        clock-names = "ethif";
+        resets = <&rcu0 0x70 8>;
+
+        ethernet-ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                phy-handle = <&eth_phy0>;
+            };
+
+            port@1 {
+                reg = <1>;
+                phy-handle = <&eth_phy1>;
+            };
+        };
+
+        mdio {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eth_phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+
+            eth_phy1: ethernet-phy@1 {
+                reg = <1>;
+            };
+        };
+    };
-- 
2.34.1


