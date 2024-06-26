Return-Path: <netdev+bounces-106998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A202A918740
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA511F23E8F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD018EFF6;
	Wed, 26 Jun 2024 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TshAX6CC"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2078.outbound.protection.outlook.com [40.107.241.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3FD18EFCA;
	Wed, 26 Jun 2024 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419015; cv=fail; b=LwxUHD8m/dUCnG7FUmqH6L5fC8pj7qTZIS/vjh5q9acxvr/tBQPlj8AjehfhwzWSsOE9ukuj7wojyziIwIUkxrfpKzLlVKrpNmpoKyVvPfrK/iCnz5kUgr+yUvy8Wl6IgBab0vmorCqgYA3d68gwAgPqRElR8d/nWEv7SQPN4W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419015; c=relaxed/simple;
	bh=HnUmKtm8IYuAlz2NKhIF9N7D9pHIOVQcjj8WGLhCa1I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YvvMb2x6RvvDprVOwygqkgjHfOlg03ee0t4FRLvL1YHWemR08CItkZi3vbdrZmTUL1SShKBgqnYNCf8XdlIF3ijxj1+XydjIWgu/obX9K4J48Msqa9OA4QlhCMGcY3OkJV5S+1eMsWQh/9fpmvISsBPBHve2xLucRb7PnlWTjeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TshAX6CC; arc=fail smtp.client-ip=40.107.241.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHDEj/Vz2bAmTT5dPtSJNcg6Ha+fh5Z5WOmeKLRJZFYb1pPI3Whv3C6mfBylVv3mWwqbx3TvQgMnZd/PnblaxuOuaiDeYzC5adWGh+U7Rb3lg1y9byB1mK4NkxmFhl9sET3ruKy3ZWAQ7VROQRu81H1xtkKbzq5TuJaPVC0HU226lyJuGA1TqUIOTU52gyUCqAH9/ZHODEpH87sh5jkolWZS8fSjKpoWGY9IPMFaMqIOBti4suFJ1CIsif+uIgsJNYTryjBFmP8s+gJjnJvalKV+4DCx0JPQWjXw3myB9RY7FnPeTOPF/CAvq7F0gSnILYPx4a09moWpmz9v976K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXJ/Lew46VwXSUqdTwDtk/jxfV+likybFQmXm3AIvN0=;
 b=asdtEHJ0jm1352M4bEekjwxkjUTXj3z7nGh/ErauCK2XfB+VWR5mPvaLKCIshCm9nUQSCzZGzs1JUhsXBZH5qWlPLwRpWD4CUNJGgoGjjr0m223IUGqqOBioCv2jWbckTo12m5ziY8vxU1j2fq8eSiQRJnbdSE62BLZwMKPfReTKDYQp5gQXPHvvC8mx6SJA7LCLQKQPHanmt4RhQFDHbZkJ2VNZokktYa/eFHUDJmtqEJXGOUf0WnIGIfqwC/jxKRmtPJQvA2PHdhLjQEZ86c9lT+/IBlzxUX2g2WjE/48RT5W+EPvbEghrtH7Gp6gCtsydl228CtUd5XCH8/GJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXJ/Lew46VwXSUqdTwDtk/jxfV+likybFQmXm3AIvN0=;
 b=TshAX6CCNLhs4RlBcDhru3FZ5NeP4m7vUpiNvo9F/U1ZGXIxi8fxszftVVDR8yajfW8jL7zlBGW5t0qWQ+3ExjIdK+kVBo75UO2FSmd/VHBcTnS08582XvG8h1FHPuEjlUC2GLV+8Hj72nDH6ngvKJa8NbqldDZCgNBHlcRT5lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 16:23:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 16:23:24 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzk@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org
Subject: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Date: Wed, 26 Jun 2024 12:23:07 -0400
Message-Id: <20240626162307.1748759-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e547bb-1715-4717-78ad-08dc95fc4d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|376012|52116012|7416012|366014|1800799022|38350700012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZ+nPs01WJxympdNvrkSe+Qsje0yy4lMntN8LfzZECmqvO46KssgNbARVnL7?=
 =?us-ascii?Q?k61W8oq6ZGcWiP1dQPAJ0hIpLj55biZqhRg4/ZMJDnX55pdmcRBHx0TubTQ5?=
 =?us-ascii?Q?yoHyelWFZpVxqe9gu5YxaAego2HQ8vWHVOlUki7f3HocCEoInYu5gsQ2S0ev?=
 =?us-ascii?Q?RcN0xdKgWy+ER/cSKieoUrr4pmJRGZ3W1U4J3w7bA8YGMT2ctX/n/vD7rkxw?=
 =?us-ascii?Q?KVvD9t6W7JPvddnK+y7etAu+stCX/23GcUXYuN5iBIgZkwaMqSUrT0aQCoJc?=
 =?us-ascii?Q?h3/3N+nT6tGiokKEMcCw96ZlmkotxiHaBv0dEHqZPXg2ElQhMdRbA60j2JrA?=
 =?us-ascii?Q?T48OX0+vrf1ZIC4DTyHiyho/ok8H0DLEvjAYWtsdJSfeHxWH6P6czVSlXYkQ?=
 =?us-ascii?Q?nGmL1nOldiBZm1Vqby1Lidu3+bk59Ljigg4DUk0X5rGL+kQxGqmdxZI42UJp?=
 =?us-ascii?Q?zR+4HYun56fW0l6FcgxKFWp5odVMbcweJnkqVQebwl9Q0k+k7gxpjHbMm30a?=
 =?us-ascii?Q?XG1l7jkdhgPW+YwQaikzahbCdOO9jEthhTY6VTX/YTSsfHhkDVYJyZ//+eVu?=
 =?us-ascii?Q?JWjm5GBHT5egTWQ/XwGmqg6QW/xe+mL4FBu436G0FVP0/0zQxL9VjWZE/9nS?=
 =?us-ascii?Q?2KsG3Vhqp3CEJOJreUBNs2CVYi43KriTjhUY0kjJ00AKZAoHetG4oV2C/34G?=
 =?us-ascii?Q?zNbQF31qJq8YQIusmZZJYPs/IH+F2REKSkb36HrI4RNpnm75QUPDHFaO/dqR?=
 =?us-ascii?Q?BXF2S2tG/1HBq3CwhviL4fNYXhMrcbU8Qh6JE1xGpZaV2F8LzzxjZwT8/DpO?=
 =?us-ascii?Q?0Sdkev3FdxoR0jdJhtwESvzQIZafqgU2481Qmwe64od8rS8AsBheUJ/6hDLn?=
 =?us-ascii?Q?IvEFJsJ6ktr4fMTXGU8Rl7eAiVSkidMdUeLKocp032zqaBgcr18IJkRKvl9P?=
 =?us-ascii?Q?sI7X9c+x8uogOTSGYWQjmXDiaG/l1F4rSt1YWnh8O5O8LQX0fWDjVYmeVtLi?=
 =?us-ascii?Q?jOqDLIeZJhmK9pbQZnQnQjwiB79mXta3gPf0eL/PzvLdIk8VHL3Y1fyTR1Pw?=
 =?us-ascii?Q?0kLQCkvBm1Z6jhiSBDhvOKapDGxkdHm1ge7WntMPbSGpQwffuC/6eUEW63A0?=
 =?us-ascii?Q?RrQXZXBtWNikigA3FBeOOWnZk9T7Le1cGkpRECs/Fu0X3LYeA2Eo+bgFpRiE?=
 =?us-ascii?Q?4F01bzd83QH4++/409Z/lHZu9SEs9Nn4+GhzU40TzG48GccwDDrUHtq4UUR8?=
 =?us-ascii?Q?hdQh9EyJ4uRvP+XRxaoZs2/HvEWUsFTow/6cZqI8QdNzLjqlIv5q8kdMkB/1?=
 =?us-ascii?Q?uFaF31jIDzE5D3VTu0OmJ/+cHZLOt8O3qgPvz7mKlw+Mjba/DmFDtj+eZIXU?=
 =?us-ascii?Q?JuI2GBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(52116012)(7416012)(366014)(1800799022)(38350700012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGVJ+xo0VWZ889OYfcsmaJLfpsLFbG+xxrLr0zBtrWElicYSlFNSvUKbPXOq?=
 =?us-ascii?Q?DWeMzatcx6YYDX0L0tFd8XwCGFNdUNz0/MBlwqR8EBe+CYR5qtzpZdn8xMmz?=
 =?us-ascii?Q?Udy3ACM0UUW+qrQqh/CA3sDk/Z+8vJKhMRSKRPkyQekamLle1SxMETBHYPK6?=
 =?us-ascii?Q?EFjusaiXilvj7EqIxWGWyGW2PMI59YmGmD056GUITRoKWHRwZj8CkrWXnmj2?=
 =?us-ascii?Q?SwctR5KJJ+L0LNvYYm2MuS8RmmvyXntDNuOh26YZGvC8IuRWSg6S1qmHwbkl?=
 =?us-ascii?Q?EojBUyypBlaLCY8CZ5T8i7vLCOAGxJnXq7qDwBIEoMcoUtU7U/ONSHdqt4dI?=
 =?us-ascii?Q?buyySl4PFNOTt0A84qy+9McRiRwD4P9fDnIsza0ycfzGgayp1fz0orStgJjv?=
 =?us-ascii?Q?OgR6KzbeJQNkdXN566jJNKs1UYIpdnbAYH2/MjTUE93xJF1kfqOHT5ki5Aac?=
 =?us-ascii?Q?dPQmAWdtLmZw+MuvUI79FMWwUUb5T2A+sky+NazT46KIBXJky1tYy2YMEmww?=
 =?us-ascii?Q?W2ngNhL+sVCqESsWWbEKsuDSc654u45Ps0tXHbJ+LaM67fmhgoqvnC1WLVOK?=
 =?us-ascii?Q?rfKRf7CuyXQ5zO+5Ks680zX9wet2bwO8Laf2ecVPj1Vky8ZBhbXRiWigxUPy?=
 =?us-ascii?Q?Jh3qeY4w3cJSfhXnL3XtvksxnSO3kJ68i9I4PnJQW38WZOs29PMLnI9zwvxW?=
 =?us-ascii?Q?ut0rM8SJCHR+DhxVKNd123KYu09Y3cQLsESN0P34UTXLRtRKBwFR5kSOFQpC?=
 =?us-ascii?Q?BqbDiWKSf2PGSy8rkZuGinw+jxrvbmM3vQosCFlGBinkOuMrMKxbbMOVTmVN?=
 =?us-ascii?Q?Rm3IPdQpDHSsBrgZoNJwrvmpfIfLYpDewyaEMf4lc2Ve8z7AWWlfrbbXaiqf?=
 =?us-ascii?Q?CARAGECZaneFbFonHAQj5XsyIK4lXrDP2dkLVSXSIcn6nC8pAQ4X0TGJ5NWv?=
 =?us-ascii?Q?dmQMKmXqLoC/+flTdivmyWr9amxCCuabcSp9/u6+mB0dZC/0JAtwynYA6viJ?=
 =?us-ascii?Q?8PTtq9PT472ANLWJQB+9qdK++XhJxLOGaHECP7YlTgFdW4yjwp6rI8x6U6LC?=
 =?us-ascii?Q?oUZui4W1/Pn1lpkBKYiHSatdKx1/U+5y4bxXd7O7L+YH5DrNzNrFl+AmabqX?=
 =?us-ascii?Q?wPc0IKUUsY+L3hmjDPb5S1CvI/hTlhJa34PeBb+rLV+V2cnhGYpSvv+FAN/Y?=
 =?us-ascii?Q?cC2fta+rjN3AHfSZ02enYbW3HiK4sFq5ORjAEV/5Wif4Be+EUC+6pXWDpZe7?=
 =?us-ascii?Q?R4DsFcQ6X0CdQoagxNh2Kme9TBCQcFzrjuTcJ5nE8K7713PrN12I/wosEsck?=
 =?us-ascii?Q?Zni1MS0f3s1jccbAP6V0k8PW6modWBT6jEqpc4UOFq+t6nKghdi2wmXg1mkA?=
 =?us-ascii?Q?1iK65dQfYEpTsqksR7+9bIoeLpZbDHgDOEt87LyVY6Br4Tq17x/HYoyxB98A?=
 =?us-ascii?Q?hb8WdCDkTl5FJtdOKzzGaRE51qup30JjPpKE/eqZSqBDgZFlMAk644jWPC6C?=
 =?us-ascii?Q?WMh6ti0YyHhbBvZSMPfIgN1AVxcJsHo/YY0328rtZR0ur80K3fi+3OIybgMb?=
 =?us-ascii?Q?sZRLI+igQYva2QlQRlq4BOGyXqv1pzXtG5mpO+qX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e547bb-1715-4717-78ad-08dc95fc4d49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 16:23:24.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtgDAD+4WKPk0PrZV2ooJO0bHnBMa46HVK0ahaFAPE8LSJe3BgMVMk4IgT36AHKbusaGupz+cXQdkIU5N8Zg/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

Convert enetc device binding file to yaml. Split to 3 yaml files,
'fsl,enetc.yaml', 'fsl,enetc-mdio.yaml', 'fsl,enetc-ierb.yaml'.

Additional Changes:
- Add pci<vendor id>,<production id> in compatible string.
- Ref to common ethernet-controller.yaml and mdio.yaml.
- Remove fixed-link part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- renamee file as fsl,enetc-mdio.yaml, fsl,enetc-ierb.yaml, fsl,enetc.yaml
- example include pcie node
---
 .../bindings/net/fsl,enetc-ierb.yaml          |  35 ++++++
 .../bindings/net/fsl,enetc-mdio.yaml          |  53 ++++++++
 .../devicetree/bindings/net/fsl,enetc.yaml    |  50 ++++++++
 .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
 4 files changed, 138 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl,enetc.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
new file mode 100644
index 0000000000000..ce88d7ce07a5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-ierb.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc-ierb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Integrated Endpoint Register Block
+
+description:
+  The fsl_enetc driver can probe on the Integrated Endpoint Register
+  Block, which preconfigures the FIFO limits for the ENETC ports.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1028a-enetc-ierb
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    ierb@1f0800000 {
+        compatible = "fsl,ls1028a-enetc-ierb";
+        reg = <0xf0800000 0x10000>;
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
new file mode 100644
index 0000000000000..60740ea56cb08
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENETC the central MDIO PCIe endpoint device
+
+description:
+  In this case, the mdio node should be defined as another PCIe
+  endpoint node, at the same level with the ENETC port nodes
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - pci1957,ee01
+      - const: fsl,enetc-mdio
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: mdio.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie@1f0000000 {
+        compatible = "pci-host-ecam-generic";
+        reg = <0x01 0xf0000000 0x0 0x100000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        mdio@0,3 {
+            compatible = "pci1957,ee01", "fsl,enetc-mdio";
+            reg = <0x000300 0 0 0 0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ethernet-phy@2 {
+                reg = <0x2>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
new file mode 100644
index 0000000000000..843c27e357f2d
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl,enetc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENETC ethernet
+
+description:
+  Depending on board design and ENETC port type (internal or
+  external) there are two supported link modes specified by
+  below device tree bindings.
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - pci1957,e100
+      - const: fsl,enetc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: ethernet-controller.yaml
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie@1f0000000 {
+        compatible = "pci-host-ecam-generic";
+        reg = <0x01 0xf0000000 0x0 0x100000>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet@0,0 {
+            compatible = "pci1957,e100", "fsl,enetc";
+            reg = <0x000000 0 0 0 0>;
+            phy-handle = <&sgmii_phy0>;
+            phy-connection-type = "sgmii";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
deleted file mode 100644
index 9b9a3f197e2d3..0000000000000
--- a/Documentation/devicetree/bindings/net/fsl-enetc.txt
+++ /dev/null
@@ -1,119 +0,0 @@
-* ENETC ethernet device tree bindings
-
-Depending on board design and ENETC port type (internal or
-external) there are two supported link modes specified by
-below device tree bindings.
-
-Required properties:
-
-- reg		: Specifies PCIe Device Number and Function
-		  Number of the ENETC endpoint device, according
-		  to parent node bindings.
-- compatible	: Should be "fsl,enetc".
-
-1. The ENETC external port is connected to a MDIO configurable phy
-
-1.1. Using the local ENETC Port MDIO interface
-
-In this case, the ENETC node should include a "mdio" sub-node
-that in turn should contain the "ethernet-phy" node describing the
-external phy.  Below properties are required, their bindings
-already defined in Documentation/devicetree/bindings/net/ethernet.txt or
-Documentation/devicetree/bindings/net/phy.txt.
-
-Required:
-
-- phy-handle		: Phandle to a PHY on the MDIO bus.
-			  Defined in ethernet.txt.
-
-- phy-connection-type	: Defined in ethernet.txt.
-
-- mdio			: "mdio" node, defined in mdio.txt.
-
-- ethernet-phy		: "ethernet-phy" node, defined in phy.txt.
-
-Example:
-
-	ethernet@0,0 {
-		compatible = "fsl,enetc";
-		reg = <0x000000 0 0 0 0>;
-		phy-handle = <&sgmii_phy0>;
-		phy-connection-type = "sgmii";
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			sgmii_phy0: ethernet-phy@2 {
-				reg = <0x2>;
-			};
-		};
-	};
-
-1.2. Using the central MDIO PCIe endpoint device
-
-In this case, the mdio node should be defined as another PCIe
-endpoint node, at the same level with the ENETC port nodes.
-
-Required properties:
-
-- reg		: Specifies PCIe Device Number and Function
-		  Number of the ENETC endpoint device, according
-		  to parent node bindings.
-- compatible	: Should be "fsl,enetc-mdio".
-
-The remaining required mdio bus properties are standard, their bindings
-already defined in Documentation/devicetree/bindings/net/mdio.txt.
-
-Example:
-
-	ethernet@0,0 {
-		compatible = "fsl,enetc";
-		reg = <0x000000 0 0 0 0>;
-		phy-handle = <&sgmii_phy0>;
-		phy-connection-type = "sgmii";
-	};
-
-	mdio@0,3 {
-		compatible = "fsl,enetc-mdio";
-		reg = <0x000300 0 0 0 0>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sgmii_phy0: ethernet-phy@2 {
-			reg = <0x2>;
-		};
-	};
-
-2. The ENETC port is an internal port or has a fixed-link external
-connection
-
-In this case, the ENETC port node defines a fixed link connection,
-as specified by Documentation/devicetree/bindings/net/fixed-link.txt.
-
-Required:
-
-- fixed-link	: "fixed-link" node, defined in "fixed-link.txt".
-
-Example:
-	ethernet@0,2 {
-		compatible = "fsl,enetc";
-		reg = <0x000200 0 0 0 0>;
-		fixed-link {
-			speed = <1000>;
-			full-duplex;
-		};
-	};
-
-* Integrated Endpoint Register Block bindings
-
-Optionally, the fsl_enetc driver can probe on the Integrated Endpoint Register
-Block, which preconfigures the FIFO limits for the ENETC ports. This is a node
-with the following properties:
-
-- reg		: Specifies the address in the SoC memory space.
-- compatible	: Must be "fsl,ls1028a-enetc-ierb".
-
-Example:
-	ierb@1f0800000 {
-		compatible = "fsl,ls1028a-enetc-ierb";
-		reg = <0x01 0xf0800000 0x0 0x10000>;
-	};
-- 
2.34.1


