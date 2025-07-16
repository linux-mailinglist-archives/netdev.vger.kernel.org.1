Return-Path: <netdev+bounces-207388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF6B06F6B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 682884A3337
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93481291C18;
	Wed, 16 Jul 2025 07:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dqT1w5WR"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E6291C0B;
	Wed, 16 Jul 2025 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652276; cv=fail; b=k8zIWrmFupXzB6jUSWpQrd/A1Sk8pBrY/m0ey++LD1DabrNl/aBU9xr8JYh40SqM/i9XtnRcfdhH1CZGcYIms0Ie99KOWApQyryvzDVLXlYQdfjRrRMrqzbqQ9EFMCXf2rxagscTu15cywdfuNru/Yps9q/0R5yRRs1oyT5r4YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652276; c=relaxed/simple;
	bh=LR3ySI37YYWWiAVuqHNsDqp/7XnXxc5rXm015QCjIyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jndhIs1uqZIUz3Tvpm/Aq5EBWXXMTiT9Al3V2/aXeOabZZfF8aB1tGFFgOU5rZUVs/8m81n3hzI6WrQQurggUkGTjZ62IjVE+CvRIACc8i+O3WfMHqZnDkEQKapq4m8Of4TRAUjVot58CGwinDGTi8imz5TZSn+BV0PPzBQwUoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dqT1w5WR; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iks8ElxNQPmoRcNMJm+we/X2m05AAMDjr0ZUZnMZddoBlm/VgB48OpR4hVc99OOjnWQAczQneBlzUrnj6AhhloXKUpXftrORp1KHP7ynnscRlc96jAKuS22TxusYausLbnwt6vLRSpA9Ld4hXxOSG+SYA1nGJzIv+Jl4yRH3z9SaBu6U1eUDy4+H9rn5u5f6vKv4p8wtw4RNsLySFROLidNiH1hupwh791BrzW6o8tKwRO5Uc1aiV6zozKYmm1AOaqpIV0vQ5IVbwRBBeSvPmzh6qu/Qq3Vt7TgqX+FZvLt2miv9SNUGmo4TuthWfh0bN5aoWn2lAKZjNac7AH5odA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPKfC77TmBHw25HzjGS6TRA5PLMcVBUiPgNOOXboiQI=;
 b=cQD9sLFIfcHDhtcT99B+tRIYt+7uhO9+YzL8v+zFu6sVLa1G8+H5q/rOPCkWQ3Jn8XvNGECiipwf75EOI/t2NzPbrK+OArY5diAY62in5BGQeFEDActmBtVnsBridbZjU6JTXpZAFlF0+fKWCMPCi041RgQzo4qGuu1KmlVL1R8dFQWARKNbzJyntZ5iBUD50POmpSuVqUSbJN1jvYahKXra/63+4WRHEmtmo0f4UtJWouC84iKdSgS4nytrhXedKhXjxE/0YxSwuBGrwoY2kDnnAuCGJ6L4LtimfjK/XNDKpqbgI51upan9WiC3SvAjby5VTxpbUD0VXy44cXAddw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPKfC77TmBHw25HzjGS6TRA5PLMcVBUiPgNOOXboiQI=;
 b=dqT1w5WRcl+pO57kOKafgwvPXZwRWnGptTInRELfYrlL5aB01RJBqVGU4iDPirkfE+8YxwBh+1UCOWnuk0P3uZTmk3oYv5PQ0kADjdFNLDAQFVEO4wVP5ybs/0O/7EosrX4jJCjYgR9VMq68IXjrHOAhx9xxZsULPxw9Du0oKKiUKYJp87UmLCtZFPbm44Z4h4QAdArqSwQEhZyETPNde3uDpkvAAWRRPkqUYctzijOPE/Fq4BNFiQUenH1oOuwu5AN86HQXATpdUxJJ20zlIAXIP5KulBfLpWIiCI/yxUCovTIKqhnG+69+59FYjZbmaEN0zzdBnAbd1aOlXsakeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10358.eurprd04.prod.outlook.com (2603:10a6:102:453::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:51:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:51:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v2 net-next 02/14] dt-bindings: net: add nxp,netc-timer property
Date: Wed, 16 Jul 2025 15:30:59 +0800
Message-Id: <20250716073111.367382-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716073111.367382-1-wei.fang@nxp.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10358:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c9fa01-30b1-41d8-b4a1-08ddc43d887b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|52116014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMBjiX8WG4023xQqMaL45aSnBfQGOy/rAdg8z/jNDhCNy7cCUpDy7w7mt7D0?=
 =?us-ascii?Q?8JR+r3kplKmVRyKTNYPcdlPAGwZp/AYCo0o2GY1zbpgMf8R43wo0sY9zzJvm?=
 =?us-ascii?Q?Qt6x9KgURQ2P/7seNyR898teYmzuz+aPjtRyXKnUSK1DVNZkGsKFpIaQ9cBt?=
 =?us-ascii?Q?AZSMpypfJf+GXutR93xkI2UKSOZ9eHHm3bdoH6E1387kUBkHAa247k04/tqw?=
 =?us-ascii?Q?kuRKFdzWBkkaLXBrIklfTcSHMD+ib1UlscHMXwN4SBrMgqF7XggkxPqhqlp3?=
 =?us-ascii?Q?F6JiU35QwUJaSwEY6lCWlSHZjp631ynVd4MJn4E3yeQ/PqN92kpMf97SQroP?=
 =?us-ascii?Q?FP3vQOsdfnWrQY5VxDqGDMrLgRAw7KcG5c6iXpn1Pl6rBVLv3KK0pNKAS87T?=
 =?us-ascii?Q?+hN6woHZRmKhniURoJ3RDHh1zJhQFzqGXu+fK0LuFO15sdrrdJJy9Ab/P23l?=
 =?us-ascii?Q?MyV4nAwk/1FltUWG+9S5Zj+41nBBPtpmlP+3cdByNHQtAwttvbuiy6mViY7J?=
 =?us-ascii?Q?qMT3uaNzL6Hvsk7qAo5s81bLX6UN5b055PsALKmDB3o8twlE9fEmJZivtfKt?=
 =?us-ascii?Q?2RoSwGQyE7TJqcBONZtn/uOJt4TJ45yHhEzcl8NoEceKJwYs0VNMpviG5Rou?=
 =?us-ascii?Q?ewFY35XeR+BB6h+jkJhSh0YOIMjjf5OVwvwEsOR7+8NxNPpApUeWD0xrRWcY?=
 =?us-ascii?Q?DQhoOm45q+n5R+Cf2frb/ecFuoViwN8xs2pZVpxOxI8UFca68O3V3qH8UzrQ?=
 =?us-ascii?Q?zIUfCswWN3C3xqzwCiMc+zl63T1a/upQMA+6IHPYu1bf2aWw5fDFyvz1LYvv?=
 =?us-ascii?Q?ptpl6Io0Spuy11tNKdyvMpOhzYAPymb4498pksWVu0fAGcdyD3gPFxa9U9sh?=
 =?us-ascii?Q?10aS6OY00zSIRyAfFc5xwKz+IEL0ssSWZX0/zO57PcCnHSkW+B/99hP4rNcp?=
 =?us-ascii?Q?GOdKC+d6HGfqZ502wgZ3KNqYLgt/35YLr7Pm+oL9u2r2CSw0ofOdaAdFFBZR?=
 =?us-ascii?Q?Np2vWtITE2/U2UwGIwn57uW34xhJfzUJvkWvRnlQOJvrlLtMazpVVPtlmwNz?=
 =?us-ascii?Q?E2vZkICmI3FvW9GGXSWbMnusbfiPnxmd6Xihl+cyBwEfJj1lWYEodOhb/Lyq?=
 =?us-ascii?Q?/tuh77hYZzo9rD9uzny90AwnzI8MbrxiLl0Uykh5cntafJwiq4O3GnSJuetW?=
 =?us-ascii?Q?Z+KpUT88Ozo/Xq4tkEiC2G9wT57lQQ+OaDbMcq+NxIrMYK9ZyS2FKfuZSOe1?=
 =?us-ascii?Q?EEODT/8s/cFslLjWD3klDAAsesz8nQ6FHvgrCRlBOeabJdFLjucUQGOPg3O6?=
 =?us-ascii?Q?peikZsARu6WOCzmYOQ8rUcH56TuoDZ0JjBXo3B8GRTPoZe1DEm2XVhaF4OR4?=
 =?us-ascii?Q?yDQX0PzirzR9E//eMsrClCTAhPKaIhgyYRncnU+ltI/0dxaHZ8FVGfom/D/z?=
 =?us-ascii?Q?haTg9iI9oXX8yfSrt0X3olYCqNN7Iq+2+CPd+2ugmf7uA0Q0QAOjumIJmW01?=
 =?us-ascii?Q?C+x7T94MWDsu0zI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(52116014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?spqcwio3zk7ke2waowrPm2FSfwJ9wwQdVDNJD8dxwblD+XBwoEp6/Qoea/cp?=
 =?us-ascii?Q?oLhrwHbaT1cnLrGZMIPIN2sAFn8TH1J1SP6ZVKLZAb52Qk+mfTWV396Zy/pJ?=
 =?us-ascii?Q?VB5G2pxp48rulwbOhdEVQNY7pJ7pir2l9wzT5cvSQ5S/1AkqaIHF3hLkAhlX?=
 =?us-ascii?Q?9fhn6cRNtFQUiQFnDH9HRTeW3c1q8HL8B6yEBE+Lg9LEGicBEgjzEJnge+94?=
 =?us-ascii?Q?DTq5VP3URdVnU54kqfp71LdFBosfqbc+mJk7sbZE0GMCNpwHEKMH6yu2j/KR?=
 =?us-ascii?Q?pCps23FQh0V1PLgtLM5criHdIfMQb2G225EjMtikkCMK7yAvv+VRgr1KMRic?=
 =?us-ascii?Q?EZFx20IIpMs+4cL19Yl2I7UUmvuWRs1zhAI92zb8330DAqLgkz+/bZZqAzoH?=
 =?us-ascii?Q?7acaulVbRr9HAlZuPr3fkiWvMtj3Smpc0Q0GQl+1MSSZ872qLsfCxiDo81/T?=
 =?us-ascii?Q?nxVt4r7v2vIVHcffgyhQoCH3KB2DpBrO8J6S8NOAxiYWlDczmDwhEu7Lbgk6?=
 =?us-ascii?Q?UBnX//hl0BhyYqwe9EnWMfTwIwKH1uWNyu6es34gPMvXfAZXTZYoV++OJa33?=
 =?us-ascii?Q?KkoStowqxywgMlYN3d5IfORRXYAmnU61D09R+nKKJ40na7XN8kGPU/CPZoww?=
 =?us-ascii?Q?b0dYFbMzrfdbv0uAIGOQlkpbYAlXdXwH24fLnN8apvQ4rhS5+zkbvD5a8vNg?=
 =?us-ascii?Q?eSFEB2HFigOYqes/XnOWqhLJXm5ryvURiqj2jc262A95t6IyWWg1xMCMq7jg?=
 =?us-ascii?Q?fNXb70I77QCWILV/0UFvdSLhiTl/wiT6hgtYuOpWddQQycwNcjMftVnJr1cX?=
 =?us-ascii?Q?ItmMBTD/mvYA8cmqVfFYaQ5uTf39qE3AYNrgPt+NA1V4cncC21SuNieycPUX?=
 =?us-ascii?Q?tFv5qBiKn+aV7ZFZtf0KG4zpqY5XrMxf4XV3SBY2lozUo3R0MvybYq3yxn2t?=
 =?us-ascii?Q?IBKCxHInMthSdyMz7i6Q439gFMSM4lX7bq/rVZ+wlNfauWPHEqHBtkL8TtEw?=
 =?us-ascii?Q?/pdof3uIWhFPv/Xd/rVOjOT+j7U4ayRXWj6YLhkyTIktUIrwDrRdhEn3MAbM?=
 =?us-ascii?Q?Ttyax3CLGoSEJN4JIUySbV7Y+Y6fPJNrqPVu8ag6hnQhnn3QMtjosFAM/HLl?=
 =?us-ascii?Q?C/BEgs90Nts1IQO/kMDW6JT8Mhf96ZyCWzzKxJ4jmL0/WpyetwOahjiMaQdC?=
 =?us-ascii?Q?CCjx8pjFvKYC2QpJczECRkU4x2Dvrmh6iyV9E154ln6ALEmHn8ngV1TK2fol?=
 =?us-ascii?Q?mJcozc1Radz/w99SBpDRiBWtMSqxMkuQRRNSHJ9UjJDTWAp7b7FUFJYtQbIW?=
 =?us-ascii?Q?0U1LPycQD/wORdc8rcSQl1/CWP4gqQRUPtPlZORCX4dSoGfxz4p3iHlht6FM?=
 =?us-ascii?Q?PBJ4aVwiFFXh9nF2QIyRhb6FNfM9XTXezVO6GijTFgoDHojgz3lmmXEaZGZG?=
 =?us-ascii?Q?EAk1Tp70XHE4ZJufYO2wZri4D+xx/E54FyM7INKMmDYmtdudZ2pOTl2fkUUY?=
 =?us-ascii?Q?n8nuSbSu/HRESsd9zsbNXHsQhf5fhrtEqxbGE4pWRvSDKPtSndZq7HBtMRnG?=
 =?us-ascii?Q?JPn3Q6oeDUyTr4S15T9850q6tb55LX90qHxiCVh+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c9fa01-30b1-41d8-b4a1-08ddc43d887b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:51:12.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: npCsF4DN0KBt4Difdp4n3mmZE0+KxZkl5p2zP7mIHihsJr+l91boY8xU7vRnSaoX3T2k3uyTN8GxpUfhKBqwLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10358

NETC is a multi-function PCIe Root Complex Integrated Endpoint (RCiEP)
that contains multiple PCIe functions, such as ENETC and Timer. Timer
provides PTP time synchronization functionality and ENETC provides the
NIC functionality.

For some platforms, such as i.MX95, it has only one timer instance, so
the binding relationship between Timer and ENETC is fixed. But for some
platforms, such as i.MX943, it has 3 Timer instances, by setting the
EaTBCR registers of the IERB module, we can specify any Timer instance
to be bound to the ENETC instance.

Therefore, add "nxp,netc-timer" property to bind ENETC instance to a
specified Timer instance so that ENETC can support PTP synchronization
through Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v2 changes:
new patch
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..ae05f2982653 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -44,6 +44,13 @@ properties:
     unevaluatedProperties: false
     description: Optional child node for ENETC instance, otherwise use NETC EMDIO.
 
+  nxp,netc-timer:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Specifies a reference to a node representing a NETC Timer device,
+      which provides time synchronization as required for IEEE 1588 and
+      IEEE 802.1AS-2020.
+
 required:
   - compatible
   - reg
@@ -62,6 +69,7 @@ allOf:
       properties:
         clocks: false
         clock-names: false
+        nxp,netc-timer: false
 
 unevaluatedProperties: false
 
@@ -86,3 +94,18 @@ examples:
             };
         };
     };
+  - |
+    pcie {
+      #address-cells = <3>;
+      #size-cells = <2>;
+
+      ethernet@0,0 {
+          compatible = "pci1131,e101";
+          reg = <0x000000 0 0 0 0>;
+          clocks = <&scmi_clk 102>;
+          clock-names = "ref";
+          nxp,netc-timer = <&netc_timer>;
+          phy-handle = <&ethphy0>;
+          phy-mode = "rgmii-id";
+      };
+    };
-- 
2.34.1


