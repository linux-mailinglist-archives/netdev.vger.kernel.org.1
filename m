Return-Path: <netdev+bounces-109967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978CF92A8BD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2681A1F22149
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B6C149C64;
	Mon,  8 Jul 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Im/CN6gh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D101E1474A8;
	Mon,  8 Jul 2024 18:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462212; cv=fail; b=by+D06qa97/3VNhlB2PtRD+MxwS5aktAFVueEMpATqmlOFSTTF0SbKnVCMPSZ7QC5GWG+JLYFfSNBbQC9Umbvia1aGaOyuuWkYZNufGgC1wPSz4CjNrOG9zQxziCruOKZvei8/A9HAce25KmYDtzIRdQdr6d7QlfRI6Wugh9hZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462212; c=relaxed/simple;
	bh=YwMBMv1nm5n5PvzGzTbkJwgY6VCcisCEVOK7o9VG0iU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iDSxtz5QQEXLaclFact+Wq9kA5zjfBxpHDh3k4sjuVjgtIglAxCNNT9VnE1T1SQjT6kcuA6SWkBrbRKFYnmlG3TP31RqVIV/wA8ZI8IMt8AML6p05olJ3Cc7XCNbEW18pdOdYH/gbLwt390ytcgrv7U/GsV98VSjsue7XwMLRoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Im/CN6gh; arc=fail smtp.client-ip=40.107.22.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdFpqfKQx+pEgSbxkB65qeLAzF4MQz/m0+4/76hOuGZjk+J+SiwUXF6d6nByMAXPXjdeRHFnVNrTXvf7IeEzhGoLHuJUDD/aazLecphvJFdDVHtmkXecDNLa7p+ELqKH3xKIgydrynKwEsyc3syZReedzLjQdF9JB+UX4aFaBSIZ5ZGvvW+2qNHPyhVheIA7STPUYyLRBfbH3ovVS1PEYPTlRbOeVCoUmakK2IlpK4WE+ywlgLtYT+BKjOOnuA/Czor/BukRfrjbtp+Jg4razyHgUeI1MhRjEDj6WQsoV1QdOlEubS6Cz9Sh0WoqnTWBn77ABejta0z4BsN3FBNMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6SZegi29mgToJvuxxVFI4wHMVCd6Z/YcqcexKDKZBo=;
 b=FVj7IuTDsHabw4HtJCJlxfeROCXazwJwggAeahCDYRk2ozSh5RnHFUvMCNxA4I9H00zviDLGnsZVLbk4at7TDRirIcLRXkmLdqY2U1O7KEBNGuLXxQ1q5LYUBKUdTclVm8sX5SXFcnfMwV2ehjFanJFTVn2VrQ7+IH+PfOgb4rPuzfGxVZcb9tWxxK6CagSgudbTSYxYiBf1MOlX1L8YwT8oysTcBOICjmRI4bTJyDcOmOo4yVjxHYk/w82tToVvC9VFKTYOHkWJarY6FdL6ziJYgaW2kNTPyaHqpEg19353mGJBTFQnsni/z5Bh9AbzuvL+A3HYv9PXjdkdfgOWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6SZegi29mgToJvuxxVFI4wHMVCd6Z/YcqcexKDKZBo=;
 b=Im/CN6ghBtWOh+ousA8XYtQD1PBGTS57OU2hr1/015+Lr9hRU2ktcE9Yg3Dq4Hu5psIU8hC3YXWFWkwy6vitPb0aqWYcBtgxPSaZU1wW0MCl73cGrl3J1RFuLOp0ecom0h97UhM2F5SkMpgp5ASPCCQWFw1p5ffA1xuoGmaZkTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10718.eurprd04.prod.outlook.com (2603:10a6:10:58f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 18:10:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 18:10:06 +0000
From: Frank Li <Frank.Li@nxp.com>
To: robh@kernel.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	imx@lists.linux.dev,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	madalin.bucur@nxp.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sean.anderson@seco.com
Subject: [PATCH v4 1/2] dt-bindings: net: fsl,fman: allow dma-coherent property
Date: Mon,  8 Jul 2024 14:09:48 -0400
Message-Id: <20240708180949.1898495-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10718:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ee5708-905c-4b28-919c-08dc9f79326a
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?wSnEGdU3JAolR/UCMAQZVbXfwDc5YikgC7vk/gmASvV+MLxcIziAoqJZZ/Gf?=
 =?us-ascii?Q?rZs7sjFJTUGuMiTBZQtWEe7lDPLyX26bPPa/GnzP8E4a5KlhuNjH4jpW/SF0?=
 =?us-ascii?Q?3uHMfJcY/PKT1Ao+KtK3Vdz+DK2susxpoj7H7YzQ/N4YRXnGpxHwFKqHiUwI?=
 =?us-ascii?Q?P3ulf1qraUv5Kez2107+PY/v1hY70J41zqEDuIhFK6JDFQuVJ/IcY+9pffIe?=
 =?us-ascii?Q?kaItMVI4s2wQgnHm2Cks1ntP+wgkG+beoXc5zhCXkR8Cxo/lpT0JST8mzjFc?=
 =?us-ascii?Q?N+8a8TdObc+CDZgs5BIzi2fuLDlGPf7xf01epp/VFxINIWU8Ij4LmprNRW7n?=
 =?us-ascii?Q?xKF9GjXl4AsUOyCb/3uNvnCnDA1/zTBWeTybF1lWWhO6jetTdUDLLppe3QgH?=
 =?us-ascii?Q?eK6M/aRKo9qgkeGvi1a81oGGdc7vNCjW0oII/vSsHCI5Qmxn8GSaiFFlX4QR?=
 =?us-ascii?Q?v1m0qvxykC62ZQRPXcWsYRnDSgvV00jgF0/3PUS2QS1tz9EPvlKWG7hYGMX4?=
 =?us-ascii?Q?OR4RqpHqTlzH2WciFobiJ1LzEj1/5+5dBYUnZd8qZbcYSMIJc6K6RFolJaut?=
 =?us-ascii?Q?LKMoYPtaGQSwiQvI1tY5eFTZyi1dlZYwcvGbvy/3wL4GIPA+0kDVgxDk7+S9?=
 =?us-ascii?Q?Zoc2EvWivtC0pFN1rnuVNbDqhiT4JCjwnBD6bOu0wlmYfqDtG5E0XLdonFfL?=
 =?us-ascii?Q?y5Uzx54FAQ23b6dwsbY9xgk+T2fg3pTg96uOKEtFFrXZfNMd9Cs4bObKalmI?=
 =?us-ascii?Q?gt5zgcpF68hXGndxrhwW0bTSz40e7+QvEBMfDqsvpRdga3PdcKs00mfh4bat?=
 =?us-ascii?Q?DQbaWf7yQeq8Lfpc3+V87Y18FPdgGW4H4V/t2WsAfF/ChsICrWPWBYIAK2Qe?=
 =?us-ascii?Q?9YC4815F9sp2KHbs+lml65SomPLcWcVcsbGONEVzi3LRa8Z9AIvrsHLjnJZK?=
 =?us-ascii?Q?MKHYtnEMKYVMmpa8n53tyv2HG/4kiLo4O+/bS9ZmbhDaw0xYZJw71+XJ4eCT?=
 =?us-ascii?Q?ZP40/gQ5gDVOKy7/7QeVvSkLqQJ7eTGvqBAeX+Z/4uVtHX33HR9OGmdWNvki?=
 =?us-ascii?Q?9B+qH8NkfY2GY2VBcHsVm1YgN+TTbYD5aSIvgbC80s22n4c6qmA1z93pipaJ?=
 =?us-ascii?Q?7J2Y2Cyr3VypZtSE9ovYYXrtixnXvQIjhcbUZzLNxnTm3NmDFCGv3/IbA6UV?=
 =?us-ascii?Q?53FLu11y2vvoN/B6ozJrzCenUbog2KbJWHmrBm7jSxQLOQ15p3wCxFoy6qmk?=
 =?us-ascii?Q?XgY/arYEhQuQaKqaXkpf7B26R9dOGwO8bYf5rM3AG3gxV34u3ZmD4V3UHU/S?=
 =?us-ascii?Q?bCQnPuk5AA/cWjAU4Vg/Lt+lxn6s080+XWXOrSpE4QA4GOd8xb3UmV4lT2Ci?=
 =?us-ascii?Q?yI4ewhI=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?2XQghh603LoJm6wlcRgZE3zvtVJ5RJZwDzkD5ZCP+tbfsiROGaa3X0sHfDBI?=
 =?us-ascii?Q?EkI7t33qKA5YMk1j6wpaFLZ6ErsCcB3o4rewVjOvQHBq4IgMf1CA/ZU9JU6s?=
 =?us-ascii?Q?Fsvry97qVKkt5N+MPTZ01Z0CT3784PZjyHuiHzbGgDvndug0c89PAal/Muqb?=
 =?us-ascii?Q?6ddJxwqHIjhvLYvei+XPCqpQexEp8rOw34ScAJ5bH2AwPCtgwoc+CeI50Plg?=
 =?us-ascii?Q?bxJJgSbMaKOIwpMedj5RzIYtq6y2SsTi4Nd3VBc8nbpXKuXeI6WXZbOfK5aU?=
 =?us-ascii?Q?n5wTRTsAsZ1A8zmk/SmIXJuQAAMgvL1hZOyl3m8XAtn/KypWnxklL4uO4CrH?=
 =?us-ascii?Q?pCa5W8pHj2U+OarAWhzpumPcPKVfKHQv1vjFvLNOog7cMcO+K7d/yD7K/Il5?=
 =?us-ascii?Q?uONf1MbJIL2fHlDOH1eJGPSbepBsBEwHR6sqp/Xgwpa7ox2Skd3k92mi8K5w?=
 =?us-ascii?Q?ypIbT12Or+WYQHO9LERO7JIpQfO0yjKoxM5YNzp6no5uFBV9u5vQjY/6rz7I?=
 =?us-ascii?Q?TNOU3rN5l26SiK2v6BpMvrM/QXuXV/fM6kQveKlgjWVwGlWudoUdRUUeP5Hp?=
 =?us-ascii?Q?XJaYntrEpeUISfwo6yitM9rwlkI7O9F3Q5g3fNybZR1CUZW0t6REjb3wBhNT?=
 =?us-ascii?Q?757ESL7EVpqCXCWlNvXvM5Su5z113e+k7dpVHHOzMUGugCmqvHdT4nLp7hJq?=
 =?us-ascii?Q?G7XQsungdZLG7E7SqwJvs78JdeWtFjPTyKDlsoRjRYSzTsjKkSMFN2nNEQqQ?=
 =?us-ascii?Q?NzFP/0wd1BGWU2jJjIy5cUgZcPfUGYQYl4kEHTqQPuzRU3MPcqgQFvX6KPa3?=
 =?us-ascii?Q?nF4U4SIqi7N4cuookYyWKVozrK3gVnnjvIN4oduCC9W2sCHrx0XeZWQmEWBK?=
 =?us-ascii?Q?zVII1xnPdC7SKRFMNTUNDyE5W78WkyzNMJZ1zc3+R9eZ2zAF347SkSJ/Y1VO?=
 =?us-ascii?Q?UoIqAIUejkYSBwVzP5MIreG+ke8OLhEldQpqH3h1G4hPUDAulfIijNm9ZOpq?=
 =?us-ascii?Q?sWK+Aj0rIRnv4WdH8Xjyob1JM2+BDlSaVfsGcLzqsvgRnFWnB+jiE8eHeaZh?=
 =?us-ascii?Q?Gj5P9XrjOxephG91+fWh4Dt0nunEYy49KC5EyAU6dpIL5ZrC/6lth9qSKmRc?=
 =?us-ascii?Q?UABfv7yy3Z0c5M0+VjzEzEh4nKXiq7GwIFA7otA4sOYC4Xnqp1L1W+Le6eMR?=
 =?us-ascii?Q?CO8DUQboeSoEPBkt5Uj37J6c3aAK7NhiTbJ1AOA7aF//k/E2sZJYsLsIKBw3?=
 =?us-ascii?Q?K61YHXbuYadWP3sP3zm+i93e9mYdJyoYGQ0Q1W/5xeFnFsgMFYKehPLkLFFb?=
 =?us-ascii?Q?nVSbLo+cLehqyQIVVKTtXSQByVulR1IsWpBTuW71srNEqRbVEUoRZX0LdzeR?=
 =?us-ascii?Q?jdbBfOrMMA3konP0jaA8jjbSGaTArpXnWayRbL7obx+lYXWRk49vnFGw+wwe?=
 =?us-ascii?Q?sBPjfrH+Us7QY9da/2TSnaRbgf/6JCrQ5UlFMft9odpg1SwdTWz98QiwCN9V?=
 =?us-ascii?Q?EDdEB64OMmbMQXOpdKOxpJU7tuuMlxRH83Eo077R1Da6KAJGgfvBISP5Jcge?=
 =?us-ascii?Q?kfsw50K4Bxu05YDxK9K6y7IFQ11Um0s6Lei8OhSa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee5708-905c-4b28-919c-08dc9f79326a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 18:10:06.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kwyxd4LvEQart3XXwvK8duycEAuv1tZKozhMq8Fjxr6Ey6IwFkypmjpuVVrKpN7gzewL69tNoxukEk+jhHczug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10718

Add dma-coherent property to fix below warning.
arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dtb: fman@1a00000: 'dma-coherent', 'ptimer-handle' do not match any of the regexes: '^ethernet@[a-f0-9]+$', '^mdio@[a-f0-9]+$', '^muram@[a-f0-9]+$', '^phc@[a-f0-9]+$', '^port@[a-f0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/fsl,fman.yaml#

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- Fix title with dma-coherent
- Add rob's review tag
Change from v2 to v3
- Fix missed one rob's comments about 'dma-coherent property' in commit
message.
Change from v1 to v2
- Fix paste wrong warning mesg.
---
 Documentation/devicetree/bindings/net/fsl,fman.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,fman.yaml b/Documentation/devicetree/bindings/net/fsl,fman.yaml
index 7908f67413dea..f0261861f3cb2 100644
--- a/Documentation/devicetree/bindings/net/fsl,fman.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,fman.yaml
@@ -78,6 +78,8 @@ properties:
       - description: The first element is associated with the event interrupts.
       - description: the second element is associated with the error interrupts.
 
+  dma-coherent: true
+
   fsl,qman-channel-range:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.34.1


