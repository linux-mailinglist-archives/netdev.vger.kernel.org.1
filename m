Return-Path: <netdev+bounces-126321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8B1970B57
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 03:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B8BDB20F01
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E620DC3;
	Mon,  9 Sep 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dgb6vJDH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87911B28A;
	Mon,  9 Sep 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845807; cv=fail; b=jBvyEc7RHIqqnY4K0AvZCQpvAtMdoS/9PRwgs8A5A12CRLROEcOtb6kp+Kcb//pxNQq9gra4hoXeZJdZayP2L550sYST1YFZHTpOHhZcRSvp31fohzZqccmUncL4JEhfP22w9swYFuS9PIbrgi+xfGoMwoTbBRptO0l/zQ+E1/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845807; c=relaxed/simple;
	bh=ezp/DM3ZYTXMLM4T+RzKkM2SBT7PEO3cu+Ct/bnOlsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K59fHZpSLwoTsLQTlGpjkCISKMAWgYpA5/WEuTlt6+1/+QIH7AHLudj5TBKjM1N1oVFBh2037ScukwHzN1Dl3CGDiowuFMg1fIoZu/7wMu6uRvYcIojUZF5o5lHChNtf+5Flme17KuPfsFpaSvFEJlT5SgI1I3n9nWVxthKoRD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dgb6vJDH; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7J18XKS80FLRK46p55NCyfHNERu489p+Z/HSqg0CsQ+ZAXwg5C6JXofB44JZ9UBBdMeOfL2ARTiAv0cd6pxBqOM9IENlFZv7yrLsKmhDf0iBWmrdWQfAm8VYzQVDo3rD7qX8zJd7+YBkUaeMeM1YyAITChO0i/bJnfNldu58EiP2YWIMVANTZpjgg5TspOfVCVgQe2ZacETnm576qezTh39ljHDCsZ9xYJhesrGW/F2aAdyA0IdQsF0IrMKgP4ZZpKG96hX0neeQk/JrFLvebdJI7lkEo4HNj1CbgAYLh1QRF8+U/oVE5+WZpnlwt/gghaEiHBQPOT8mew2kiilPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcztvXqRPthcdid682MfSOoXMzAibxkpyqXXs2/pckc=;
 b=kTicsD3JqP4wk+8KLaXwThsK7NJC+Coyquf0vPBwCugtedjV8v4vockpyZtOuX5JUAKV0zTP+0LC/e1DLbG/LZSb+X1F6fGm5z0ry1L0lHJKaAEvCcPsO6Ry12hdKpUEOxFsiRekbT3+CvwvvsVGuYazbSDkZuIl1ek/DCX9yhZKbY8ieHIE5xoF90oy46TlLLigrv+ReP1Y8tI7+zXWSKDVRdJn/dlLkWnOugkhmkT4Q631n1I71OgMssNURXToSPgHwq2V4SSPxjpuUHTw4i6/0aLlLlnxPv8Onbmleng089Sg/2LZDUFX3LZD82mkqlH/H7erTMJdISpV+r6pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcztvXqRPthcdid682MfSOoXMzAibxkpyqXXs2/pckc=;
 b=Dgb6vJDHHg/4n2xX6tH5wEu/fyL108/AciLfo3fLhKsfYY4TZiL8FgI6DOEHSS9utTMjN04tqaG+ImYlvZAnGKDeqTJfL9DBBxjI63Ev3WWeh/oy1QnUU6rDAR34wOpmNph80CffmcUFPsvuJT5Ay3zf6csBKXFGlzlLxAlYHq6GV/p6axUMRrGPTPFESgkyVIdcP70Dxo920XrlfHWfELv4hY9RYmVGX9PkE00o9fALTQV+FHTbLXe+q2B4YG4ad6Tpr8+CL4EiyD5VIRJLhlRbVnC487YTmiZ6BUqbeOprigD2o4UmNaian+sCFHHOtXiqLbGiXf+z1mCV3fqG2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8451.eurprd04.prod.outlook.com (2603:10a6:20b:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 01:36:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 01:36:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net] dt-bindings: net: tja11xx: fix the broken binding
Date: Mon,  9 Sep 2024 09:21:52 +0800
Message-Id: <20240909012152.431647-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 51496558-9aa5-44b4-cdbc-08dcd06fdaf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nd+0MzhSBmEw92xZj2xo/9EwfMX5eSmhJBH1YuAg1tlARKPjHtIbhRvuOcGV?=
 =?us-ascii?Q?To8q4MmNuUgNFDzcsVVkG9TIKa7qDPJnjbaj3XXd/mGfbxjKtfp9TEKGOY7/?=
 =?us-ascii?Q?lICsqMDuW7gdOM2uYuGs/RTToU3jvnceIfZ32Sr5DalaSyo9YNHJZysRYySf?=
 =?us-ascii?Q?qD0DLIF0MQNHEAkcM9ii+mHeBJ9bceSv/w3s9aclDRXoWzXWviShDZmE5zH2?=
 =?us-ascii?Q?BvtQ1KWQxaxp934/0FMWhmHwvtuI5ZeBHfsAN1fCD76c+gzIVDVAVh9MRe2p?=
 =?us-ascii?Q?z9GcUV9miIBr65/X2kJ4v/IbpDLj/9dypHa1fLu3t9j86PVJx2D0AWrI9p4w?=
 =?us-ascii?Q?nHq2Ch9t+w+2fGVIbXpgTpiqia7FPcuuWidI0HavlzhZumoNMTWXdzw6KCqI?=
 =?us-ascii?Q?AK2AmlB2RdnTSFS1+TsOlCmWGEjmDUOcv74kfaeTVt0noUBbFdctlfVXfTOQ?=
 =?us-ascii?Q?9AfELQR9fPJfvcsTTYDuSBKfNwSxmO1YgRBAgUqJslGT+lfqfNyOuZcBsZJ7?=
 =?us-ascii?Q?6Poh5FJiDyJRW6cqSFQw9cfjJHrerefWTc03euSciUUd3o5C/j2h2c2lozse?=
 =?us-ascii?Q?xekWYXb2Bgr+IQq1fVip7zHiNJjO/eyEKy4d3eIJi7ADIj2ZTMIkg8eJCJlw?=
 =?us-ascii?Q?ljvZbXAKo4Nf8NavZMgbnC1eG7auc5Knw44bbg5oVMILwOw5DASpo6uo/hl5?=
 =?us-ascii?Q?okGkmKPspleyf3PlIxvLIPJOx8AJeY/MXWFqUr72CuaqwaCDxvw5V67t/lZQ?=
 =?us-ascii?Q?gs6SQQPc93/seCeyIFpy2KmBuEhe6VACedyKxD29luc7Tx+1Fw0JskR9tDDr?=
 =?us-ascii?Q?35fqfOZRQD7xrFwrGQ0Xx0Y8UA1ueQipprlofFlW+aevtsWMepPmoJmq75Cd?=
 =?us-ascii?Q?/mAXNb5ey67lmZBhDWdUe2m/6D+j4E3+P7rQdMbOhlDmlpOe/itwYw7Cqtl4?=
 =?us-ascii?Q?pwcyN1RGlPE/Z2BMDdqq/KHAPmBx8XQxFB7HnYnKTC7o5NZHmJsplGdR27ro?=
 =?us-ascii?Q?cx4H+Btbrd1mrJkDu8GFrqkVmEQ7yBlyvfzGVZX9CXjV8F9acDFuo2SuGhEk?=
 =?us-ascii?Q?aTz9M215N5Y1b71gUawfIl6BYRXqM6ru1Tu4s+g7BmkgTr8zcKFtJj7IXaoa?=
 =?us-ascii?Q?sHQdE//FzlV8TE973ykDrlAo9Koe6suwe2I7v2dy4dEsfMaHASulaLRfUYAz?=
 =?us-ascii?Q?pNUIDBzUXXmLBzXeyQ3sIw2w8nHxg8IgDworlF6QQFKK3jfVsESig+hkv3f/?=
 =?us-ascii?Q?B69VOp8hGYYGnAVZdMyYS/FJ5HJGjwE/DOWYI7eud4vCFM93AyaoaTyRnamm?=
 =?us-ascii?Q?B1uf7LgPZt4Y5hL4lMlv+FteFWj4hLtDIqFssFODoQNa0/W7ICm2zopGsDJ2?=
 =?us-ascii?Q?eeCHt4v9Ib6Q8wDGxD2amKqHANGwd0BKNt/qip6bmelEWg0+uA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aj/g6kZ822nKK/U8BUTxLUbDSvKmzJEE3sKU8FkX8GiwI10pIVAocje41CXp?=
 =?us-ascii?Q?i4fFCEHWKUcIyTQmkGFM9Jy3jHr4kMxIr2r0f2VkjcDvFykcUchjo4LzmR4/?=
 =?us-ascii?Q?2olXXLGye4PuHquK66zj1kAzMwy9CWmU5367Viy9QzneHna2SLZXKV3l4qVv?=
 =?us-ascii?Q?asohft9IqjPWQZ337PruAWRXDjsub6EuBLux1BEO7c49m+o2zt0OY+IsxJtS?=
 =?us-ascii?Q?3qYXoPy0BJgf8paxIi/P/4gGqzfHq5oAZDwX4L4wkOB5PqrUxKmfUoECpuCy?=
 =?us-ascii?Q?uMIGAjBvY/GRqzv0uxjsPCovYKWUKXOnPuAFhPMDjn1UfnMiT+Hwwx2tjGpS?=
 =?us-ascii?Q?agOvukJrTJrliD0rvuh/7EWTteMttgMbwdV7pH6LfbtrQsaCFTV3aPb9oXzv?=
 =?us-ascii?Q?xWyCz+Ukl7bBkcAx7XyuZagmtF3A96kzs7IgHiZrfaqNG3DiC/LoZt0ib3KW?=
 =?us-ascii?Q?TEkD5VTKOGe8MeYENEKm973ixFbVwQ88CCLOI78UOcjpg/d9FPRhPNoX+OBV?=
 =?us-ascii?Q?IEZSLd1jADVcoOIxGX/AptUmkKgQPVCMjV25M1aE6XrGf1VZGq8khuY9BuPH?=
 =?us-ascii?Q?fbB7CCQib6CvmzC07TmMFEKh3gY/UTK+OncccvRCS8TvcJAnTeSUo+LL88pc?=
 =?us-ascii?Q?bYGK5pt/N6sIOhiQAKej/Ooreqqu8ojw03BDsC0RxNKqkxQVEpsg+N2pdeC3?=
 =?us-ascii?Q?/C6otTS2ZL67msdfSEhPky/TMHU9QqZm+Tn+Y7EAnec+vTsy8T/mk5M+IUaS?=
 =?us-ascii?Q?auH30jxtGXPOmeRvSFU+GtEYyG1vRFWBvAzJzVDJkCH1b7zEA9CE6ypFHl27?=
 =?us-ascii?Q?AGYhdhybs5KKs2BfyJrQeR7DMU19Nzd/q3knktISf3g/QYPCuVt9yP7126y4?=
 =?us-ascii?Q?E4JMHlWFEwlyfQdOvcxNMtjP1Us/pMvC38y0NaMa8tc+boQAQoPopaGXWiTY?=
 =?us-ascii?Q?MNf++82MxmxxJ1wzWYoz2zwv2V/eIV3AaOkPf7SiEwlRjh/hGq9N/thzjdMn?=
 =?us-ascii?Q?7x/KFIEzP2JErJJ9B943LjuCzypYzGhkcBfgX3PgEorp9EOcDlM1uzz5wdPq?=
 =?us-ascii?Q?OmemLjNI6aLuSlx+zb1k97FSeOYHedKZYf9GZgO2kMmqYfkQUx3MrVC6LNtb?=
 =?us-ascii?Q?5oQshadTvh0OT+6JWmNcOsw1+ydn/e7T+W1RXstrph+WUugYGmjcyBgMW9yj?=
 =?us-ascii?Q?RI0/5m6FOJoyK5sjhvRiznFKJZHjfgfF3Yw6HPR2vOzhLkOe0KOYOgEjeifv?=
 =?us-ascii?Q?PaiMySzZdHrBTXVeJ+niI/TV+NVg7Y8sQQJvLa0/LKSacOiu1BW2W5P2jpmh?=
 =?us-ascii?Q?PCdpbZka845U0zZihYOR2il79E4tsbDuqzMtgb14haS0G9Vs1av8e4axVHgh?=
 =?us-ascii?Q?j+WwdTMF5PvCAV7j7X/xfu7CCiVlEOGJkamYgWuVTv26L0ljPrnk29lYgSFw?=
 =?us-ascii?Q?DWsDBkUqOQT8FEgA2yVI6+V56OXRgvKrKUmCDiMMidmCIwx56QuOSORjcI3I?=
 =?us-ascii?Q?/KVCaUHtbjnb7iDHjW/8kkvgDUgQ0yAChyiAfBtr4PK2RQOArMTO2m4NRdtH?=
 =?us-ascii?Q?WMq2yGaZlcHnE/Bspfl2JLqc1w+Jd9OdiLmB1l2Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51496558-9aa5-44b4-cdbc-08dcd06fdaf5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 01:36:41.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+tdVOWVuwthnvtAlxR/U6BpKcrrI00rdmIk8pAexeCgaaZ3slXMx7CHODVmvPVYRvLITv7pXoZeZHcB91PxNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

As Rob pointed in another mail thread [1], the binding of tja11xx PHY
is completely broken, the schema cannot catch the error in the DTS. A
compatiable string must be needed if we want to add a custom propety.
So extract known PHY IDs from the tja11xx PHY drivers and convert them
into supported compatible string list to fix the broken binding issue.

[1]: https://lore.kernel.org/netdev/31058f49-bac5-49a9-a422-c43b121bf049@kernel.org/T/

Fixes: 52b2fe4535ad ("dt-bindings: net: tja11xx: add nxp,refclk_in property")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Add more compatible strings based on TJA11xx data sheets.
V1 link: https://lore.kernel.org/imx/20240904145720.GA2552590-robh@kernel.org/T/
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 62 ++++++++++++++-----
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index 85bfa45f5122..a754a61adc2d 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -14,8 +14,53 @@ maintainers:
 description:
   Bindings for NXP TJA11xx automotive PHYs
 
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id0180.dc40
+      - ethernet-phy-id0180.dc41
+      - ethernet-phy-id0180.dc48
+      - ethernet-phy-id0180.dd00
+      - ethernet-phy-id0180.dd01
+      - ethernet-phy-id0180.dd02
+      - ethernet-phy-id0180.dc80
+      - ethernet-phy-id0180.dc82
+      - ethernet-phy-id001b.b010
+      - ethernet-phy-id001b.b013
+      - ethernet-phy-id001b.b030
+      - ethernet-phy-id001b.b031
+
 allOf:
   - $ref: ethernet-phy.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id0180.dc40
+              - ethernet-phy-id0180.dc41
+              - ethernet-phy-id0180.dc48
+              - ethernet-phy-id0180.dd00
+              - ethernet-phy-id0180.dd01
+              - ethernet-phy-id0180.dd02
+
+    then:
+      properties:
+        nxp,rmii-refclk-in:
+          type: boolean
+          description: |
+            The REF_CLK is provided for both transmitted and received data
+            in RMII mode. This clock signal is provided by the PHY and is
+            typically derived from an external 25MHz crystal. Alternatively,
+            a 50MHz clock signal generated by an external oscillator can be
+            connected to pin REF_CLK. A third option is to connect a 25MHz
+            clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
+            as input or output according to the actual circuit connection.
+            If present, indicates that the REF_CLK will be configured as
+            interface reference clock input when RMII mode enabled.
+            If not present, the REF_CLK will be configured as interface
+            reference clock output when RMII mode enabled.
+            Only supported on TJA1100 and TJA1101.
 
 patternProperties:
   "^ethernet-phy@[0-9a-f]+$":
@@ -32,22 +77,6 @@ patternProperties:
         description:
           The ID number for the child PHY. Should be +1 of parent PHY.
 
-      nxp,rmii-refclk-in:
-        type: boolean
-        description: |
-          The REF_CLK is provided for both transmitted and received data
-          in RMII mode. This clock signal is provided by the PHY and is
-          typically derived from an external 25MHz crystal. Alternatively,
-          a 50MHz clock signal generated by an external oscillator can be
-          connected to pin REF_CLK. A third option is to connect a 25MHz
-          clock to pin CLK_IN_OUT. So, the REF_CLK should be configured
-          as input or output according to the actual circuit connection.
-          If present, indicates that the REF_CLK will be configured as
-          interface reference clock input when RMII mode enabled.
-          If not present, the REF_CLK will be configured as interface
-          reference clock output when RMII mode enabled.
-          Only supported on TJA1100 and TJA1101.
-
     required:
       - reg
 
@@ -60,6 +89,7 @@ examples:
         #size-cells = <0>;
 
         tja1101_phy0: ethernet-phy@4 {
+            compatible = "ethernet-phy-id0180.dc40";
             reg = <0x4>;
             nxp,rmii-refclk-in;
         };
-- 
2.34.1


