Return-Path: <netdev+bounces-231993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC4DBFF79A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DC23A53ED
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172752BF016;
	Thu, 23 Oct 2025 07:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nTW+oZUz"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC282C033C;
	Thu, 23 Oct 2025 07:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203784; cv=fail; b=ifXF9yMezt/BCzUI1PElvcierHayaAGg2cgGdkydIW0xAJvSqKqtd8RajUeQKtt2Z10fYh8xAQ442rwdgg49aKbjqWnwklqTSzm+ItHL9gQbDTE1onCAKWgarHKUuQBtqL1lvJREbtfNKv07rjLH+fI04GGCNBEKTCbMIawds/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203784; c=relaxed/simple;
	bh=FP1P/y7my8T/hNt4yjfAP01XbCJa0tIrY6oh+g6XmQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4ETTW4kUAomIVDaTBuGAFjq2X46BBiqvLiDACvuPK74pASvsqQMc4ckSFlHfAxwPXMCCVURh6lntPgIFHmRsD+SfZu7ycps4oomUPRiVaPOOaj5NnzC618YmQUMdrJKOfIf01tdh1PjW4Vn8DvUeivufUQAv7z719Cifq8ArTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nTW+oZUz; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjgcIzIW9zTzJ2z3uNjkpqPTmJx5RiTxC2cFKu5gCcyVuDCENGmywoKaggg1R6BlUDoyefH8d2FB8fXLtjoftJvg3Fk8+bdHZMo+w/3fWF/+zfeV6QFh7aMH+vOOkIJY06b7qLOqpM/Ntkwk0l+xPeC5p8Ue+cXrEzN1hsXVYImsquND2S1YdzfEmASh5iq5ZEc+W3AdtE/riB0JcX2d6ot3giqZ0ZtCxLsTcn76soMUP4rX9v3Fsg+dtB0TSV+3f+BmROB3ZDLnV3+aOKzel0BW/0lxScRRnGBxoZaY4ZydjUuc/jAO/KZWsS0r2YFcnbCjHl1LI3ALJZ1qWnJQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=CMC5TMh1XY5ySoB2I9ejXOgS4fiaS2fZDD9lzXRqmY99MR8CUXb8TafZctn06vbrcPqyPr17gwRpgjMsNaCSsPg5ZDRDIr0idvTf8HiJLfgMg2CNl2tx58CHjDrbiM1KFsTcLOcl+2SoVMnN6RcdoJbxUeLfRDDsDYGPPQVvfMI+upH/AaeanEQ90KNFI9xtV4iae0VjT9hK+jGzhYV/hTOhAPBXzj6YVdR1HzrEsO4Zv/702TAcNeY3jSMPOJhAUlCpKsEqGQk/3bx7i1lthNurK0sgKTg1GXKijiout1UM69QsgbUepMu3cma0dV4j9vVFpHgKZowcjzsHen8Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=nTW+oZUzixwp1z8GI5VwGNKWZqTE1MBaZMIBsOuucoZ+R97vwBekLc8sY1rL0gUBoT7zWtwpsNtqXTHGJ+kFAvMIGKiQKYgMyoMnkrb+4MxFN3hM8+VfGtByOUACK6b9DYkD38c6EMvAkAYjzf1T1uEI3KYidhXhHiq7WrGmRz2RhYy+kmmfIEsgd5XYpmKk7xztY39vbuXITkzrxWki5vCOt0sVQko+zJ6WcdbN3n4BUHZRgb0zhCMGSJzs05G7yxRhM16oADNwLi7Avpl9ui70BYNTMnx//EM+H/5Ic3c7XtYvkw7fpPHWI706GjmhzNCZSzhrMXelLxt7gaMvjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11697.eurprd04.prod.outlook.com (2603:10a6:800:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:16:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 2/6] dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
Date: Thu, 23 Oct 2025 14:54:12 +0800
Message-Id: <20251023065416.30404-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023065416.30404-1-wei.fang@nxp.com>
References: <20251023065416.30404-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB11697:EE_
X-MS-Office365-Filtering-Correlation-Id: c1318496-730a-4e06-b277-08de120410b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|52116014|1800799024|376014|7053199007|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PCQ8O586iPMt41f/H5PiE8vTEmfHJDJ+qlgXt+QYctK4gBumFFSh3iiO4Sqe?=
 =?us-ascii?Q?Y3hQV89dhZ12cplpShXW4bebmO/1RFUoeGdre4pcdEu7K8D3LF5nvYIbnb57?=
 =?us-ascii?Q?DBybZfqx1Gwl98Wb2zWcUKqK9v/XsKMuIlwrk+ntwnrB8GI0q/vIbPxwFle1?=
 =?us-ascii?Q?9j08XfXSI0JB5MQh1z/AdgUgLoZwFYd0URLmOPncUOIz+DClwbFolszPUtNb?=
 =?us-ascii?Q?+kiPcFWCw6FU6MfCoJE3NgBTVEme61rI1AsjdRWzcrArupO0S6bf8epn9yh/?=
 =?us-ascii?Q?K0OXhlwLtWfYVv22mmFHjR3E+MtWChRoC3nN4Wa6etzi64iyCPKLFLVDFp0j?=
 =?us-ascii?Q?OA1xW9pkaREvzMX955dcxfeEAi6ycDNhgYj1seRzk5XsCPi/40CI7Smom8b2?=
 =?us-ascii?Q?NVJ1r+Zct8wk+W107fcd/Fvm+d8R1e4AF5xn51VUWXQbUwCzp2a/h75UuB5q?=
 =?us-ascii?Q?TCqo13xWJTF3115C62+Nkr+Zy3dRYlEJXgCmxDjY4vOoH/66/T1eGPXuZV0W?=
 =?us-ascii?Q?18z9oEFpYo752JLUIpfG5a9qQf2wYCyzLFKkFHrQMZ7PL65S6yANqXEfN0IA?=
 =?us-ascii?Q?ERT+1RD4gYye65Um2DoMWNRiT7P5sPG+EzhLmCydufJ/flkSSbtJJ1GVUAa+?=
 =?us-ascii?Q?PnaoAL+huJ6l6Po7KNC6FV2g2nsKE2xmoPSpSMgpGTylJlUevB24NGObCZEr?=
 =?us-ascii?Q?qH+RVXYW/U+K6QSgqnv3WyFUu0QFM/AK/vLGYFqGPSSZ39dgiIw2+6VKpT//?=
 =?us-ascii?Q?ma/Skenvu/zR1cQl8SuboMoiEohVFbNQK9c8waPJmHTy/ne5U+zdx70FsNlv?=
 =?us-ascii?Q?MZjVJ/UAdc/3Jt3L4CeXuyjxESsM08gYPSOO77TQv7Qcsn+jyc4+yUdx26Ik?=
 =?us-ascii?Q?ZXs0J5E3vHY/DiXDxtiXUK4kh/STWBBPWqMFMW20ZTEMNRRsRp6/4O/oHwgx?=
 =?us-ascii?Q?VFvzUY3H6X9UTmPJItoRad3CaqiCSzPxqvXxy/gYLLpAqAYjv4hY2JHcWkPL?=
 =?us-ascii?Q?bvv99mv0GSqmUscBbzPcRYhfuVWLGBT6ajlaw//NN2lmlj0IP7AvPndCqSya?=
 =?us-ascii?Q?eQ5aP5G52fQIjzk8H7aGK3Q2+Z9AVi083SgY7/5a+ivYyJXTpX7MuPionhI+?=
 =?us-ascii?Q?L8521X5cc7FUnMStS77VbUTsms46kDaz2IJHnYBLcKcXUWwCUrPL3rIady10?=
 =?us-ascii?Q?V9f50H5cG0Pgc+FG2reefbx8ew6AFqYH8th0sGTYgkpE4rOsbxQZ3OoFJNW6?=
 =?us-ascii?Q?4leNAYUkZCM8tZt546RRFjqXj/T0K4Q+5yXqCodgGQ1qkUPV+WdAz9zBb8Rg?=
 =?us-ascii?Q?I6IN2bESJWDiqABYSjHrTnF+PNjD+XsgAQPeKHjRPmswxSWxopMuwzEIQUhF?=
 =?us-ascii?Q?rXcdOY1RNcviBtOav96BZgnZ7fhOWELi01AknLEohELFIPBYXnfgOPmVKev3?=
 =?us-ascii?Q?DhItUEB7wxYCLfAZNQ5eCg3+YTpTRq24RNB3qt1t8rDDB1edo9V6NaEj9EON?=
 =?us-ascii?Q?EBDCQQOwjY6CBBPM1U6lqTxXL48L9siWmgddbMgxneB5+AdX5FMu0Apicg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(52116014)(1800799024)(376014)(7053199007)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RL/mo332tv3aqmxpibkGk9QquGHtGqPAqGaNari0qoLJ/+p+b26JLnesSGvo?=
 =?us-ascii?Q?qRrV2fifuWvWxV1wtK2NMJvX7sxu4nbyawl8OwsGPqNrxmaQgZZCZPc+pwCK?=
 =?us-ascii?Q?eWsNGr9kbcWiLTAt5ZuSpnhtAjiogJfch1DdAPrJgb4AVjsj8xECt8VS5nj8?=
 =?us-ascii?Q?ZW4KsgyCl0ylIhMSQMwYwCKFlwlSWBhbV4VNf+ga3TLVAMgJ+r20P2dPH8AK?=
 =?us-ascii?Q?lNJ3PPSobBbxutX3ajijeirsMxDW0+dx6gBI8bpbrTr/c3kaTAl/0G72nREb?=
 =?us-ascii?Q?5WaZc35swuaN4e2/W26GeIAfb4zdy5l6ZzoWy2eKm19j621pTvVDlybiJiYC?=
 =?us-ascii?Q?4+OqGw/z78RoVen0TBEHPxVYOavOTgmEzwHtGTWxVju5vjnQ4s824/ZN8Zzt?=
 =?us-ascii?Q?DJwPEEGvd417Y04hxTTuO+pm7fmvtC24S2rdgCO3lnZi1qlhiZSOqXIcsHmG?=
 =?us-ascii?Q?CzTahsNUztZLEfA2d2YPyrQrPAC2m3RguIFZoH+rt9wULE+zoJDelIHLAgoo?=
 =?us-ascii?Q?PSmhYNwWf2V8pfrJFdgaxnmFFA0xijG9QDncRAk9AZFhGnoRFg64GgNHWQnP?=
 =?us-ascii?Q?ERmxky7aJNPidxbe6BPN4Y3vZnsFoDYHQOUBTjKNe7QRMy2CIUET0XoMil6P?=
 =?us-ascii?Q?JMb/nYFG828X0w9N4B/v6Rdr/XebeaW/4BfpbnGuFrZgpZ4pc/k65Xh8Q5uu?=
 =?us-ascii?Q?fhnFVZFp3LcVdWy87h2JD2n7EoWls5GAW+g6glqCCHTixiv20y5CRIj6pDEW?=
 =?us-ascii?Q?DZvE3XcbHG6KTrS7cW0YAlBLAW0fYwPR1ug/Go/wW1PX1Cp9oKIdxA34cqF/?=
 =?us-ascii?Q?VSPsvhlkjVA9YBCzp9Q7Lwl0mZg6x6YpSzF+wx+PIiIKUGp7WoX+lliLAWna?=
 =?us-ascii?Q?/xfQL5tFkm9px0YVX4I66mqaUNHagFtiUHLBL+aluWcbVdH1UdCfCPrdokQw?=
 =?us-ascii?Q?bt0+r9Ecc9VlGoBtN9ohG2nvn0o/Rg+KNSIP2ENeWecJl71aJNZ+jl/Ft5yI?=
 =?us-ascii?Q?jHrdIze0ghNMSEweuprqXG2zmtzXXHk1oXvVnB8Vt/Ijas63AvZgBOxA7tSR?=
 =?us-ascii?Q?I6t9YEPmw+B8JNuZE+ceS/3aB1rAQtkWCUN8O/BhCCFWy/g429H5unHpgF7r?=
 =?us-ascii?Q?pxogTi65jF7hysW5Yps3u878WEXYPeF4J1cxalEr7vrcc/fzr4/hPWjIWDOv?=
 =?us-ascii?Q?OgSb3AyUHufp1fQhMyWIO2dFXYrVrNHVGHnh9p9n5ql9l8LMPvnIrTAZrewZ?=
 =?us-ascii?Q?VRkReo+UBepcjTRJxqcunzHa/0BT9trqAXWsGN198UhC+cszx3c00Kv2M+cj?=
 =?us-ascii?Q?ATf5uBuJ3VzR95EgT2ObcnbhkJFQZYJdipPNsDg3HebSA20dFzTh2J6P6b+0?=
 =?us-ascii?Q?t7Z8nB6s9zdxM/a5o5eaLe+b0dbDPfgY5ycBO55H8RktmvBDC5o2XBR2AA+5?=
 =?us-ascii?Q?ccgNdxk61cTV+UbidMD35G1+hHZJ9OciRNL9vYpvLhNwilelPkerKdFoAARX?=
 =?us-ascii?Q?55/31mcp2nhlqC6dgWLaYTiKQkh26kjoRZ1CEw49FYsZeFdFcXpGBvyoP5Kg?=
 =?us-ascii?Q?EONPwOMi5rSbBThnxFiOFJ2v77Y2n0jfLGnm2KMp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1318496-730a-4e06-b277-08de120410b0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:20.5635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljkWMyyjhijR2rwRJDGu12sDplVRszDCdzms87SIoUg453KLW7QX52qNpH//VGJf5Af6yJYM5mZMVkl+mdDlGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11697

The ENETC with pseudo MAC is used to connect to the CPU port of the NETC
switch. This ENETC has a different PCI device ID, so add a standard PCI
device compatible string to it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/fsl,enetc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..aac20ab72ace 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -27,6 +27,7 @@ properties:
           - const: fsl,enetc
       - enum:
           - pci1131,e101
+          - pci1131,e110
 
   reg:
     maxItems: 1
-- 
2.34.1


