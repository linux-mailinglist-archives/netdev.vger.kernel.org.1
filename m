Return-Path: <netdev+bounces-106659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF32917277
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 22:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4113B21DF2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 20:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652517D36F;
	Tue, 25 Jun 2024 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rM/+Ob6C"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55916FF52;
	Tue, 25 Jun 2024 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719346997; cv=fail; b=YYli+BW0zCDcuNo0HqgUoSNDwVBnXcJ33klKcHqK6pUDxawltTC4O4za0Dwiq7goi8Cw3lwzWLsepMrYhb7UqoZoCINdwb1dYIRdq7iIUs/1rigdngrNA3JzLyKSdqAROklJyUE+hwpv4Xaz8NsamRqfwue+GmJHLFfEotUTg9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719346997; c=relaxed/simple;
	bh=xTBKHCbCX1GwY4F89Oq8jP63VwNrotcHUnTXC0IhfuY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NU6ouGVjzBpgYSlhR0tBiE1Pk+zvSSa9IeLlRKMFb6BC96YlOT+7iFQdrRPoacqxY2qzLRN5b3gMGi/4uq1tJFVVluE6khO2/VuDPQ9KEd7p0f6R/wn6TyBxKcPhkI9NAr4Lf5qoHItFAMkNxWNLt9dBk0SqxpN2ZPMoctM1f9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rM/+Ob6C; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fam3ymV9hWe/mh60QouREnp6GigrhwZNe7eZbP33oADVNblLBaoY02l6fT5VS7VOCeAbVyvRP98t2Fh+/vSgC3Vn3N3g85K74MCQfzI5NCMem4WjxaRKzGwE4VQgl5AwjutABIxbW75pTMGH8+Z3JL0NaVqJxMbuVvgoeIP+KYwxlQ6CeevsxJT6XjD3FJ7JTsCHSieNlCj0LIHO4MJ3ujAfm8cKF6GBkvZAtgUvO3hgmmCAkayxNCnwP4YEOp/qYWO0fEEyg1euCsIc1WVvqTUmx7XxF8XtzMR/oC2v9RF7cnzSOZw0by4MDMKbN07NhvOtiATdLmyVRodZZJS6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ccx6VuUFvyHFPnIXVSmKks2SSG+D8+HqQbZ2lY/iiY=;
 b=GaIWX+4Kul3g/l/ljhAlqruYr0oZ4hrgQh2hCZp4MREzXKE3AgSsKYKWFUFvIMiu54sm5WklHfQ0RtwGExEBYrc/fRDZs3vQT8G8Z5g0uLu4Y1qPRzJT16AenwMtydzWsBLZ9eYTg3+drLLW+DGs86RTE7tKKS0hyDcozVTqycB6Z6YxrZzJPeLDtDLhjn/lAQVnTr2fQspb9nIWYrcdNZQICm/PbIqmSbn6tgCaMRlvSMt8OYAt7AULpbA3M/wdEKUgzajIQ0Tr+ru4RoMuTIDezn29cwB2eXpg2k+8Flsa/ehVEUw2fS6AEhbsvYWNxGnMfWeoS+UrEPRpGWToWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ccx6VuUFvyHFPnIXVSmKks2SSG+D8+HqQbZ2lY/iiY=;
 b=rM/+Ob6CLU5Q4l8pbU3z8qDM41EoYd/KkQOxdZpESnJkHE3QxDBgzFJ6F/EvRkBDYqk9X/WJ3oly3rCFoxEAcyefMJnykMt/wbAimed3BRvDO69evO8uXnIe8NME4D7xCHz5tDYtrUM2IWyqimHoMx57kzOfPWWeTZZTDDytTmE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10434.eurprd04.prod.outlook.com (2603:10a6:10:55e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 20:23:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 20:23:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: convert enetc to yaml
Date: Tue, 25 Jun 2024 16:22:54 -0400
Message-Id: <20240625202255.3946515-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10434:EE_
X-MS-Office365-Filtering-Correlation-Id: 86598953-3d9a-4e58-4dd7-08dc9554a250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|366014|52116012|7416012|376012|38350700012|921018;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZZyc8q6GqsN85B2w3avHiHhXyOBZRs+tKhivZtjmtMcn6JMfFDTkxBpP9UId?=
 =?us-ascii?Q?voQpvie5m+2PQ7WkuaVBwsOi1U7wkFJ7OcpEiy94Wn/++bjeumzuaFW44mHa?=
 =?us-ascii?Q?1/pRk5ftwqQLDYGauXdLiTxCzAd+n/KMbUdomPOGAIjuEwDMr0Fb0wYwREbC?=
 =?us-ascii?Q?xmn8GcRV1bpB/9026iiY3dMpJ0UM+P3hwDB6tjC1B0A3HRmSMZdc9FeFE2RN?=
 =?us-ascii?Q?RTzv4UPU4QkMdUTNcDKyuM/oh2+5tut0ad96b8mpincfgOUaSnCJ/RazbaHP?=
 =?us-ascii?Q?wsUnHnwk/2zq+KCivM0hH6KLFvD3Y/40L3PzwDELzkuq9bWOT0TIsTVN4bCl?=
 =?us-ascii?Q?z+4r0+yaOsQZ1lQ+Kc9QnXRSVcNRWO1wERb13rY4TDNXp58sMf93BHlImnKZ?=
 =?us-ascii?Q?7TepAmpX/5oBwM3ZYhLqV6fuv5xGW29HnXKWJ5FY/x7DYRQnKq7ul5ayqeqP?=
 =?us-ascii?Q?72koxKrGfX+kcYV/mG6Qty1hqa6gHIy8nt2XZ2wjlzKMs7lvJlGlKWqeNpaS?=
 =?us-ascii?Q?InviWkx1twUny4GkEid5wa4Gn3/ENYi/kJNIT3WTVKCTfNINShvEOIcDvzJn?=
 =?us-ascii?Q?aPxgynrEmhFeRKkHpcI0aBeCozTDwrEuZVq4PGzX4yjOWHaVDiMVZLBgaeso?=
 =?us-ascii?Q?OS83vhUv52QRJg9tYI1RYiVSbwrp4ScCTF6cYFNRUiEDxR/0r/4EWpmx6eFq?=
 =?us-ascii?Q?H9CmeU6Xi2uilDz/TCnNPUq8J3J2DIWdDdgEYcbeKdvYHc9YwmCx9yqWYuSZ?=
 =?us-ascii?Q?oSiNXZ/RMSk93IElzfXBQ/GRR+R/f/bkHj2LpS/cYm2bB6oymbfRRUO/Wdmf?=
 =?us-ascii?Q?B3Fy8LTPjkcNOJrM/rdc9xYV5ftDWKuLwz+blF7zd+MyuYcdO0ibsxrL25YJ?=
 =?us-ascii?Q?S559BSbty6jxOVdr3q6Y1Z2OMF9HmjbvefaYP4ELjvWHja1f0uLOjjXp+a7C?=
 =?us-ascii?Q?WDw+i31PGru99RX28c1qTwgZ+roqbqRCGCHXB9tx3126PS5OSeRZgjMdthaf?=
 =?us-ascii?Q?itGdx/Wy3tnVN9fxiTDm7pI2s1iuwCD9IYew06+EDkJndx3uw42htzITL/ru?=
 =?us-ascii?Q?M030fF36NvhNIKlXy5WPCGVfWr3fHeEQ6pn9HCvMh251mEVY5LOVjnXpFGaG?=
 =?us-ascii?Q?6wov0BJm3+pXnTosLcIVUD1VDy1uXHX2ihaxTuppRm/qQporZS078DeH9dhk?=
 =?us-ascii?Q?A1SDZWlOSfNkvt4NVLdP8lgkx63wpMd9hMltHwi4EqxQau0L38Ts/dZFTDgY?=
 =?us-ascii?Q?zfQ59WvbA1I83rD0aNC0Y/j1NAHY9/s1WlYAK4WPJtoKZyUyZTFX6Wd88EC3?=
 =?us-ascii?Q?2XjfhwDLxg34QA6B2zwhGbCuRwRr7krt6vx8rdfnw9sQWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(1800799022)(366014)(52116012)(7416012)(376012)(38350700012)(921018);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0f9/2/URvC1eK7cfKJco2CpEn42CnLa2hW76g4s0lNjCyeGoFQV08/t+sQF?=
 =?us-ascii?Q?d51yivNawgW8HL4Q071Tov6JiUz6aYlJuVD4RDDTTXvk1+ouZE5adW50XgZ+?=
 =?us-ascii?Q?8uskZOioqdXIs04HGjRfiescR9u2h/tX5wtMqobja70d1RWI8iwNkLbjeoz2?=
 =?us-ascii?Q?A9ChJvo52A/z1Z10hXYol6f3iLfWv+dXy74jXLd4/FtLH7B6ebZ6cPr84HHx?=
 =?us-ascii?Q?CJDI1K8ibVyrSLaGxiYgryHXu2amXaLlovJ/VYm3SAJolY6JskQ4X6HX9k8Y?=
 =?us-ascii?Q?2QgXzcqmrLdoquf7h5OxR1uPSRZeOnkz5DEqxF5pDCIZngNRpIpzW8/g3P9q?=
 =?us-ascii?Q?VXfgDPuHb2mhk8LBa7EM0aZaL8ED/GYyx5qIwLYjOW5iMG3EhhbegxH8i1KE?=
 =?us-ascii?Q?eAWi6aRPecFvPmAUlBrWwY7F4kUuQI3o3yIs+9mZJHBXHF4IxuOB+FgIHvf5?=
 =?us-ascii?Q?5GGFyyz8ezmCEjJLXhov12JyGCTwHhHHQ1gr2B/mWth8p5PeW1TjUS8An6Gr?=
 =?us-ascii?Q?7R2k1941wPCmDN91+cLCLlJ7B6V8L00RW2Fd3HPKsNERthR8VtDh2Ac/UpKU?=
 =?us-ascii?Q?Iv6r9DxHS4YxZYu/8LQAC85Iu9DAy8NtOydD49IuQb1M7oLgTcyEhvgsmJn8?=
 =?us-ascii?Q?H4MBq6TN/7fvrw8aCvGcVTlnjrL+tYJWMqk4k0ISagzSuCjpMWHj2qtatF+e?=
 =?us-ascii?Q?tTJfX34vHP7rM0eZR9pG4MBcwFVAoAI0ZcLzc3bQ9p4t/C0brZ6tDhZlcJpD?=
 =?us-ascii?Q?OrNdhaGhFF6qpn43e+3iiurfgaBDL++rC2aceG3a/jF9rHhOXBWxMQnLkmuu?=
 =?us-ascii?Q?My/KWkYlecHsl7UMRn9T/6AzVzPF0D+Blj9RFjKWpySSPz/bcnPGCnoYyph9?=
 =?us-ascii?Q?QxJd35jpSzxHgQ0mA7fETW+LG7esbxCnC18Mx8dt3x0YTQvDmhyH1Dw9w9G8?=
 =?us-ascii?Q?lGXJEzxBrG6HVh74dXvXR8+f4amINy6Y402AVBnFAOJez6qD794YuNfGwAaA?=
 =?us-ascii?Q?+MXz38ENDxDk1c8QL93oNhY6EQ1WdLswdW7ReMDB5WX8Mqk6/maSwqy6NWSi?=
 =?us-ascii?Q?9cExW1lF9lthtzugwHUclfO7uDrSvwfRNlI69wD2gcY4VZ0FVfPPPo8AOtGK?=
 =?us-ascii?Q?gatctP3EyJeeXeb2bicmzpNURaslZP6by0CVzfWhdnnxxRJPT//ycd+VvNFC?=
 =?us-ascii?Q?D9kIWrbXfdHgorsfobHh2t2yo+5L+FGa4mnAsHrftVWoIxFN0mPfjzvBACQI?=
 =?us-ascii?Q?GNCRA3lfDm+7kGl+k42nua6DOT4BmCHw4qIO6xPQAthnBkRtOo+Guu4IDdGt?=
 =?us-ascii?Q?t4AWLNZ4+mpdv8XQSTSROLG7FrRmXLgdRkjNH7D00IvqZqLAT5bIbF5PVyBN?=
 =?us-ascii?Q?3uHb9+GHvG/Yhn4tOsIpCoOTpm6o6J4U0VzN0GaKnsGW7Xv33nVexLLPP0nz?=
 =?us-ascii?Q?8GjBjPUfQnxJSTmrQ82NAA3MbP9hG5Rwgxzqi/LRYjy+pF+v+mMSZ/PjGaAQ?=
 =?us-ascii?Q?BkibXalzOzv2P98KtIgIn4DGz9KD9bH5KzWda2KeLqwWSEXbqqJS5iC7x7Ej?=
 =?us-ascii?Q?rk6FJCli7D0rbvUj7Ow=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86598953-3d9a-4e58-4dd7-08dc9554a250
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 20:23:11.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyn1LluolaC933FQAHqKbV9TSmSNfZYRnjMq2idPnmnrc09w0XE+6h+HHb/rPn01ISRTiTrbHrNemlJMIH1hFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10434

Convert enetc device binding file to yaml. Split to 3 yaml files,
fsl-enetc.yaml, fsl-enetc-mdio.yaml, fsl-enetc-ierb.yaml.

Additional Changes:
- Add pci<vendor id>,<production id> in compatible string.
- Ref to common ethernet-controller.yaml and mdio.yaml.
- Remove fixed-link part.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/fsl-enetc-ierb.yaml          |  35 ++++++
 .../bindings/net/fsl-enetc-mdio.yaml          |  46 +++++++
 .../devicetree/bindings/net/fsl-enetc.txt     | 119 ------------------
 .../devicetree/bindings/net/fsl-enetc.yaml    |  43 +++++++
 4 files changed, 124 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.txt
 create mode 100644 Documentation/devicetree/bindings/net/fsl-enetc.yaml

diff --git a/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml b/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
new file mode 100644
index 0000000000000..bb083b2f8f399
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc-ierb.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl-enetc-ierb.yaml#
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
diff --git a/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
new file mode 100644
index 0000000000000..e8d0d4aa1112f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc-mdio.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl-enetc-mdio.yaml#
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
+    mdio@0,3 {
+        compatible = "pci1957,ee01", "fsl,enetc-mdio";
+        reg = <0x000300 0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        sgmii_phy0: ethernet-phy@2 {
+            reg = <0x2>;
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
diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.yaml b/Documentation/devicetree/bindings/net/fsl-enetc.yaml
new file mode 100644
index 0000000000000..e60b375395fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/fsl-enetc.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/fsl-enetc.yaml#
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
+    ethernet@0,0 {
+        compatible = "pci1957,e100", "fsl,enetc";
+        reg = <0x000000 0>;
+        phy-handle = <&sgmii_phy0>;
+        phy-connection-type = "sgmii";
+    };
-- 
2.34.1


