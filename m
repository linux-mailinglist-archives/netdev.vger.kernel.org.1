Return-Path: <netdev+bounces-233759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D15C17FCC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C181C2110E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FEF2E9741;
	Wed, 29 Oct 2025 02:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MKKJJmN3"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011055.outbound.protection.outlook.com [52.101.65.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C0B2E5D32;
	Wed, 29 Oct 2025 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703290; cv=fail; b=n0Te+tEcz0FyjGrnS4UYfC3nlbX0bOnFpyQePSpzQWkieHctyUlfnD5ZfCbiFbGcHPJTP1D69BDMcY3fSJSMSa0E9RO8OFq8jY1DFFhXDopmnulA2+mQdjyumpPnbLLDqhXkecoryS91Jo0z4wz/ks6vXjlqIGuSF9XQiAsMq7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703290; c=relaxed/simple;
	bh=qWe51aLin6ot6guVSVmD6D+ybuwLiwJYL1wEw3jVqhc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nm8c5kEoMEQ6uvEcbnCir/dJWx9WqWaqZD+hguMmlkkqV/hR+n6lLSe82xGcepGF9KhJdnSZ/GOKEkvDC1ynPc8HIWly205/MEQxw2drBCZoIPJyTTAahBH0wk9U1R8urSd/1Cay2vXJX+vv70CaZKmP3OU7toIEAtQnqGoFSyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MKKJJmN3; arc=fail smtp.client-ip=52.101.65.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbce3fW3D1I/HN32dVs+B8WC3QC2YTqGOOgF7klBM52fc3EBcI0YcckmamuJvj6VBDjlBY71pcKhnKFhjlunoXHn/uOqeYLJdDhYDdZWlTn48Ukjqau1E/4tZhAXhY2/UC4Nu1u/CI+uJUVBs0aPj35XpVkMsKwzn1+RxqEjsNR8L1sFqAQ5BiyWs0i5xjUBIqK3d0J0D4WEKp4pDIzx/DJWSuFQqa75wPAsooEY8ng41wUVUK3JfDEAOiVyC7eBeWqzOFZ1a6c0XhHpLTyJLqXlB8A5Ix8WBfOHTgyWUsvHo77s9/+mC2WHPJhLyA+wMj2ORX6fpt/XqNI4tdew3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxiqVhxrf4biqiifqrwXOZ5fQltK5A7B+XZXNRWG/YU=;
 b=snpL/+TOHKFSpiggbCXKKfeNk6xJ+prCGVHVP823OqLD1wJvZ8ElzChL59iJq4ewEKdfREyIebtzasckg0HqSlo5UOqSEICD4OKIfv7G7r7rMMezeIItWot3nV/XZOb0hmqG+Xh6KTyk5yXokSSzPmhOC1qsoc9U88RfXVgAjiVJmSIlkn0q9QjdvdlErVHEgZ28xW+0tptpFFfwym+KOg+cY5LHhYyTE0SRjg5G7rm+W2kcfg8Ua0n264TWa1VgFDFYSmyMy5JTgTKYw5c4NlHUzPy4vxUqSMmXPPbnrJpe2YEGvdc0QAC7ElpNykP49b7g9JmDx/hITENHOeNWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxiqVhxrf4biqiifqrwXOZ5fQltK5A7B+XZXNRWG/YU=;
 b=MKKJJmN3RmkWHUV5i2EsExMzjtcQXLQoZd3o1z4ucSI7QUy4szqouz3dWoiGIIOxOIM9j66rNh04ew2DgtDLGFeklckiivYVS9Bs16kxqnTw6mZzDzFQREVfg8shmTxWXZLfN6TagFuTQiAbyxNpFA/uo33W0c2kE701KNTFWYOJ2J5rWbO/Y4XW8AY3LWB5S4Z5c2Xh/kzcq4YSqjOEB6SGOc+f/4A4jQl8d9S03s7AY4a1gtDel0gNrbh+cWev8G6abm0NYqQ0UdJt7lwHGpAi3xOhq78QaQ2zIOMICI5/TCNlXor8hF7zEm+4t2IdWTEJ8t6sz4B605271l5v9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:24 +0000
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
Subject: [PATCH v4 net-next 4/6] net: enetc: add ptp timer binding support for i.MX94
Date: Wed, 29 Oct 2025 09:38:58 +0800
Message-Id: <20251029013900.407583-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a2f9f2-96d7-471e-bac0-08de168f106d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fuCdvQADHYP1KgawJ9h04vIieuPwvHHvzLxcuZeT0yT+9XEH82fhyANuhFVG?=
 =?us-ascii?Q?oMXu80NdEFTkO2IhX/53WrOWd/BjrwEVI1/3Q7o8SpZ217rHfbLUTad34tYR?=
 =?us-ascii?Q?bCrO3rRpZAArcd8a7N5/CnrBZ8GrMy4ITTg2VNt6y9cvkUCiB1x4IxFcz6rE?=
 =?us-ascii?Q?XwFOcSXdMr/bgW5DzWtLj2Z2Qdfo28KKrWkERvZ7HRcFge9vlTKnVYqR9r1s?=
 =?us-ascii?Q?DIQeGMNK90Tb56A1OlSye03GtBgm8mr8GbPHVU5dTtsWLLJXOOXWKx+PxGAy?=
 =?us-ascii?Q?EfleeGT8vMl38jSvM7M1g+FD/hsYe4fp7v9Hp2Gb3ky7Dfl/BFAudZLJ5t5H?=
 =?us-ascii?Q?J+H8lUlJlVc5KhAuGJJcEmNIpesUhg2vFPQnlvIBxBlfMp7MsS++bumrx6IM?=
 =?us-ascii?Q?9SiPDYjmG0+9jhyVqBDa0AsztrPEvDJJm21sb4GlMEZv+ls419vHwSrxoCiX?=
 =?us-ascii?Q?eI4kWxiX7UMNhySpXaGuhZIKKAmbDOXmWkM0DklM2dL/5x2iXt1SdxGcN4C4?=
 =?us-ascii?Q?3BPkEjWSTN9NPWv74h/v4rcOPzrypMsyHw5UCElGzAew7rStIHrBKWlJ7t7a?=
 =?us-ascii?Q?OBdA+FfRpvaITAWqfUhyvhaLrGZXKyr2nqrVgA9OmCWw4AKSvjYrQ6XvZVnl?=
 =?us-ascii?Q?MQ6saArzYvpQRT2zejZ0oNRRG4VRI2LvbB/2PiBYbzljEmndItZam26w/Cl/?=
 =?us-ascii?Q?D9QE0G8Ou5qpCDsr5DEYLk3RCMNnEZNuuTD/DhcQfAYHkt+Tw1eGl7wQ4ABD?=
 =?us-ascii?Q?h2UNCT4MqkS07z3/7FHDuGrsSwDD4LZ1JaPSYQ5vPIPKWcsZHtBtPlDOAUml?=
 =?us-ascii?Q?8xtjG9aOaAjslRM6PFSyAlkN1LYu8DzHRmyEmgy92ajnopymv6dFTKU4UXnR?=
 =?us-ascii?Q?Uh+7Byhp1UoVi7/vZVSiVYhC58QSxeHOxLBcFCcmtTeRibPVGcKuH5g/pKSH?=
 =?us-ascii?Q?8InmMTegw260srEXkTHP1zJLk7byLDb7UH/NyXgTYDZjSwbFs5V8n/PpyX3p?=
 =?us-ascii?Q?a+E2B7UCsAQSmPnlgx1tHx4360U+RKgzVTO3tZmQAc314Lk6/K3C6p5zV5PQ?=
 =?us-ascii?Q?sfSNSR+AfnWXE26vQ2BK4Q1jWlRh8R9I8XYc0Xc59NBlw00wnIyqIR7k50rI?=
 =?us-ascii?Q?AIFhOKM/6/tLkzkYg+mHRMJQ5eMfvTp/SsZheeGcmk24ABh3aJHnf2hwo90K?=
 =?us-ascii?Q?VCtgFjT4OJEVZv5w80wjfgN1XwaX3Oy/qsCJe/hG3rnBtV3gdtMVCQeG4FO8?=
 =?us-ascii?Q?UDZBcY4soWFI5wV98Q0JkxtF4F2ShIvQ+ttp8IOu72rXMXBVITfL4vPxB3xa?=
 =?us-ascii?Q?XjhXWO0TWz1IGGMMRymCJWvFQm3J3nL/UmhZnV06d3u7Hhat1gIV05GqAIWM?=
 =?us-ascii?Q?Kvwy2NVvjj3qbxnvXu3FYOcLE6bMs9XxJt0vRR3XrE5QF111cejybjK6/NHb?=
 =?us-ascii?Q?iCs8YydHOUq7bhhgit09m+ouh5nYH3Eqeuw//y0pIEdcTvMEmDWD4+sexNXk?=
 =?us-ascii?Q?Rz6uK0B6xGO3zyOdoxbW5/w5nkKHr9NdnaIA6q4L2AZOGDBI39CPKFvuog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aPlYgXzlB4Nc4uxIipDUDqMx0v09CCKcdFdnS7bgmsG5Cr3L6zdV5WKWdjZb?=
 =?us-ascii?Q?gbcXQHoD7pGLuYIqsG1QqbCvEeml1tQBGUHGWWmFgFGkQjm7i2tWfS7Y+xlq?=
 =?us-ascii?Q?HiTpcgbyoDSlkYdccxEMR46WyPJv050EOfFFaFtNPlLxLGbLHXg9olYgpsss?=
 =?us-ascii?Q?APK1VKp/OHiZ5j8NxVh8nW7BX3VvV0ozwAkXRF1ZhBXn0CetZpB+FhYCRXB9?=
 =?us-ascii?Q?4gOQqLp5OagiIqYziLkoLeGqlXM+ufsaSjilKSyk3zVwNQQoxeH4ZPZeaG0Y?=
 =?us-ascii?Q?OtEQyafiJNMsFdbwj5YClwQvSi3Koik0HUlFydhBMf9QOB51A6QNGJtGDOgy?=
 =?us-ascii?Q?/RJHaBgdWUYqn9lQ3IYk1QFMIfmabXnlkXaKlB8qhVS9/Kq421UxBy4TKu7J?=
 =?us-ascii?Q?Z4kDfWMWHzf5p7mO4NiPDgT0EhzP89DYabVS2IXwSttlbG8z+IPC5FMT9rW+?=
 =?us-ascii?Q?uUujPG2QBmuLtIznLam+NjPBF5OVGMxEF72fRovIgACbLqhDmx4e9o58SlKt?=
 =?us-ascii?Q?hl9WNLkeRI5YxDUdNSzhlyANR3kBa5JvYew/YeClYhJTMh7BhwNk3pqrmKo4?=
 =?us-ascii?Q?hi0JSxp+mOuzKllR+BZAEazpDU0X+neeJrnRwgCHDnOnlkWgQhpc2fsVAFVu?=
 =?us-ascii?Q?+9kU3zt/vfEGmxivldNNlKYlw22+nrvhciTP3E9mkhWqIoIbddaFmY7C44xD?=
 =?us-ascii?Q?TLLXa2ibAldSKQovIJL5mxhTHZWw5+MUnEUR4vK3eBNgQsk95tVnnXsi499r?=
 =?us-ascii?Q?RBM1NctCPxuxO/46Hkdx9cN3wfq44rqi+6jvAKolQ+9KC9829QlLMhlATKi/?=
 =?us-ascii?Q?wZe50U8b2MFxGAoB3S8JJrOVW4Bf9p3xvTNDHyhyzXp9q3suJw/9ioeFn7fS?=
 =?us-ascii?Q?Gb7FueXBmg8nKATjVK9xnCMgKJ3HL27vvLG5S9gQTBlROVCVLCbgNRMfVKF2?=
 =?us-ascii?Q?99fXKkiVK3giXpBadl8wrkwWguGJXY0DCa8SqpqL6ThKZoeXW+FcdjYIspmD?=
 =?us-ascii?Q?WLoHlw/UEuzVYnbZaUO4tNlF4yHovdiFYa4l/b/ACDeZzfvsdemEL+qlZpmG?=
 =?us-ascii?Q?E13C+Zr9ASzCR9h94P9r7e4AfE6eVsXMfwASeFvuEALl47cuaEkluHxy6g9L?=
 =?us-ascii?Q?n2yHG55kCh4Yvtdvab302w16Bh9XxDIHVcJMHWucEvbleP++GsNo3Ga6qR73?=
 =?us-ascii?Q?rzT2LZFaWDv+gv+WMj42NYHWbcNSIN226BOvzGeO1vv+qWCTOdmXxRi10qKU?=
 =?us-ascii?Q?7Kpj8VAeuZgM36xh9pHY/DgYU0MoQ8z0IumAFJo27q5CaQsowIN7sv7gGt0N?=
 =?us-ascii?Q?4x2jV+UIRI365OOCTz6Yp/tSEUUw7/XJF2CdIyZYlvhxk0zN4hqdYJdnOp/x?=
 =?us-ascii?Q?4Rf5uMsehmnqhVuJwpDz29BFSJpjgHeUgKw3up5/SIlCEf1yAoC9LH8rYHt7?=
 =?us-ascii?Q?sX/AEdQDDC566SUXUUYALjqFi02mVsbWw2ePf5kGnL6mlLZJ/1MsGwTNo0fb?=
 =?us-ascii?Q?cQEt/pbzbbpcJJ5YJ7DovU3q79uBa5abV61Yqeu7x8ERrfV4G4McJqtNwmPM?=
 =?us-ascii?Q?afo1kPlvGqwHHJwJhckM3O1vWg+aH+lBxGAgYiAX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a2f9f2-96d7-471e-bac0-08de168f106d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:24.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBHfRAC2Q/z877UHMuJ/NQwxZ0Yl6QZjAaakOwjIaqK7IdBtS8+NM3Rgf5MpqyNbX9O1hRTCtB9vHg24xRUJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

From: Clark Wang <xiaoning.wang@nxp.com>

The i.MX94 has three PTP timers, and all standalone ENETCs can select
one of them to bind to as their PHC. The 'ptp-timer' property is used
to represent the PTP device of the Ethernet controller. So users can
add 'ptp-timer' to the ENETC node to specify the PTP timer. The driver
parses this property to bind the two hardware devices.

If the "ptp-timer" property is not present, the first timer of the PCIe
bus where the ENETC is located is used as the default bound PTP timer.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index 5978ea096e80..d7aee3c934d3 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -66,6 +66,7 @@
 /* NETC integrated endpoint register block register */
 #define IERB_EMDIOFAUXR			0x344
 #define IERB_T0FAUXR			0x444
+#define IERB_ETBCR(a)			(0x300c + 0x100 * (a))
 #define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
 #define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
 #define FAUXR_LDID			GENMASK(3, 0)
@@ -78,10 +79,16 @@
 #define IMX94_ENETC0_BUS_DEVFN		0x100
 #define IMX94_ENETC1_BUS_DEVFN		0x140
 #define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_TIMER0_BUS_DEVFN		0x1
+#define IMX94_TIMER1_BUS_DEVFN		0x101
+#define IMX94_TIMER2_BUS_DEVFN		0x181
 #define IMX94_ENETC0_LINK		3
 #define IMX94_ENETC1_LINK		4
 #define IMX94_ENETC2_LINK		5
 
+#define NETC_ENETC_ID(a)		(a)
+#define NETC_TIMER_ID(a)		(a)
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -345,6 +352,98 @@ static int imx95_ierb_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_get_enetc_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC offset */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return NETC_ENETC_ID(0);
+	case IMX94_ENETC1_BUS_DEVFN:
+		return NETC_ENETC_ID(1);
+	case IMX94_ENETC2_BUS_DEVFN:
+		return NETC_ENETC_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_get_timer_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse NETC PTP timer ID, the timer0 is on bus 0,
+	 * the timer 1 and timer2 is on bus 1.
+	 */
+	switch (bus_devfn) {
+	case IMX94_TIMER0_BUS_DEVFN:
+		return NETC_TIMER_ID(0);
+	case IMX94_TIMER1_BUS_DEVFN:
+		return NETC_TIMER_ID(1);
+	case IMX94_TIMER2_BUS_DEVFN:
+		return NETC_TIMER_ID(2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_enetc_update_tid(struct netc_blk_ctrl *priv,
+				  struct device_node *np)
+{
+	struct device *dev = &priv->pdev->dev;
+	struct device_node *timer_np;
+	int eid, tid;
+
+	eid = imx94_get_enetc_id(np);
+	if (eid < 0) {
+		dev_err(dev, "Failed to get ENETC ID\n");
+		return eid;
+	}
+
+	timer_np = of_parse_phandle(np, "ptp-timer", 0);
+	if (!timer_np) {
+		/* If 'ptp-timer' is not present, the timer1 is the default
+		 * timer of all standalone ENETCs, which is on the same PCIe
+		 * bus as these ENETCs.
+		 */
+		tid = NETC_TIMER_ID(1);
+		goto end;
+	}
+
+	tid = imx94_get_timer_id(timer_np);
+	of_node_put(timer_np);
+	if (tid < 0) {
+		dev_err(dev, "Failed to get NETC Timer ID\n");
+		return tid;
+	}
+
+end:
+	netc_reg_write(priv->ierb, IERB_ETBCR(eid), tid);
+
+	return 0;
+}
+
+static int imx94_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			err = imx94_enetc_update_tid(priv, gchild);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
 static int netc_ierb_init(struct platform_device *pdev)
 {
 	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
@@ -441,6 +540,7 @@ static const struct netc_devinfo imx95_devinfo = {
 static const struct netc_devinfo imx94_devinfo = {
 	.flags = NETC_HAS_NETCMIX,
 	.netcmix_init = imx94_netcmix_init,
+	.ierb_init = imx94_ierb_init,
 };
 
 static const struct of_device_id netc_blk_ctrl_match[] = {
-- 
2.34.1


