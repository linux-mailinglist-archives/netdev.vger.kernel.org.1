Return-Path: <netdev+bounces-230002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB34ABE2E43
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46F5C5032C7
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5FB32E6B4;
	Thu, 16 Oct 2025 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kPiu6/4B"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F913307487;
	Thu, 16 Oct 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611396; cv=fail; b=TSqCjIsQ8UDu0kyn5ZJyKOz0iLtiCIgKjWFjcItLmN6GpYhWR4TKL9jP6Qfgxbi7YYm5ObVsO0KreoyRneedfzX29CgVdBbu+IhnujbDVJYFzLgjS1FNghM/SJ0/3YDJqZiduFVkWNAbuxOVTyeHW8nn0As0cng9QdJAjsY4PoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611396; c=relaxed/simple;
	bh=vcfTUnd7ZxR7sWQwA5h/siIU+DXktGBfHPo4txpGWE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AnaSxSXcJldUUeSvn35yK5jYzYD3TW5D+uxr0aO/JnhM7mg+EGetsWh4ELJT+66e51BIVHQL6V2N2GMM/LW2SyFvoNIMnb9pAXfTAZQXBJdPbMUqFRvccUxEYjupf+Ys4l8OJlzdrltCQhRou+iAa1SctYkUdFCuKdU/MsZhBAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kPiu6/4B; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ursCMLiPLYjNt3QsmQYOavAaDbnRWu6lKyPc5cyXJqz40o8OHIlbsWG1cnhXA04jbOu3PTUcrSpveMrDIMs508Lt2vMErEInJMEet7Yltejk9MV+2SY0jIwPnSHZUo3cGt9GUIJ3a2fCZHqqpsmJGlawQ0rgnPhm05YVq9If5Eau4s5+geT31gvWs9L5ehGL9ywXWUoLsLo4xrDWfyk+HHWL8SHmV7qGcb5IoZOwjO3wYWCLCUEkvpw0CC6YTPB/CZz081qrtMeOO4iVDn+pTmEagk3bkaoz47IJ5LlGiIXbjYvBuBQ31t3zcgcVypso/Px4DlO35K8epse6zScKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WYVZMTSSEEzS/qn/TQPunQD8OA7+yRyamV5dDDeY6w=;
 b=YMSg8ZkxqEcZOv5LItFz96gxVJ4x/CnM/kMfkEylXyJ5DMrEp8Re7XV8EegV0gKOInLdtbpOMxmoJilfsCu+T2RK0HMJ1edNY9dXBlDdfppwjjzf9jhtOxOEvDbZvIPcxuWWvJFZiaurUzVrOatYJC3IRsXtk0LMwqtg0SEBKv29izpEpw+xqFyA3MBI8tyHZG4fc24lQWe4eGJftEiGWKwKn9CulqlV/go6WzJjmayPmf6k8GY6A0uHkh48KUg5Kn+4qeEl1IWWcawMOVcspCQyDZ6PSb5Mpu14bGnoK3EfKx0VPdV4hwwCLIjMam8VCDKqPc7UqQmeKo7qC32TwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WYVZMTSSEEzS/qn/TQPunQD8OA7+yRyamV5dDDeY6w=;
 b=kPiu6/4BJeEEEaYaW+YkkpyYCa7pCiQdATjjPVGM/I89xGPZrUm0FvmVdDQnE7oLqWdItqN/ByVLC5B4VaZwMO0BYI4IX2oyLk2m5jtcLg7Bs2FxiSKcuth1u5MyZMMX0AMhfDQuPTzEUMnzbFBi66P7l/TqyvFs4G5W7Fojyr9i7Q4IkpyTJxWbIGiRgCziZkV3pbnUltUtK5XG/3eEm2hHZGmX5Z8nHQ+O7vOx4+13tNaGxgeTry8tO69m5lzEszfou+wDms/ttzAOJiBTPBcV0T2tkZe5CZ+4xQ3avA0jqSq8f/ySouFqf/WTN/RNGUVFg52rRQBH9CQIdRuAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:12 +0000
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
Subject: [PATCH net-next 4/8] net: enetc: add preliminary i.MX94 NETC blocks control support
Date: Thu, 16 Oct 2025 18:20:15 +0800
Message-Id: <20251016102020.3218579-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc078cc-172b-4df2-3488-08de0ca0cddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1caESAKGhipB0uFaLiJW90cFybAaEngXyd2wj/Fdh7jWEmOIPmhpecVaz1qt?=
 =?us-ascii?Q?if9jSNtWxfRG7Ct+AhyjLp+aP+er8NYxDE26IW8L1echaRMsJM47bz6vmKZw?=
 =?us-ascii?Q?ZgfKEslsdVBQHU83A2lVdnW8oyro+9b9DzPMAD3Gh4xQ2ZiMJi+yc7z7DUlO?=
 =?us-ascii?Q?awIsQqtAN0o7bFmE0IncZHGFNCrBfFoaxAN4UW7vqT4ZJTU9GjBEtPIgj/c4?=
 =?us-ascii?Q?j2o/8ECWqs0cjSPZ7a5Q2nd4XJC1yDNwXjqVGs5GZYzHk4za0DjDf+SxVrYu?=
 =?us-ascii?Q?g0AZCZZEbRpT2gDtojwA1iw7Wonotab7wIKoR+jCK9Ps5tCmGI4q97SejtHk?=
 =?us-ascii?Q?8r2n3xpJh5kRv+25iHpyGdDxSFnRGL8nUveSBTla1MZ65WdIQzy073j7IHZj?=
 =?us-ascii?Q?i+iQnJBdRPabPWBDFqFUHJAeUD0iBSWOUopmumcB33vi+Q/zk/yRsbbevUTU?=
 =?us-ascii?Q?Vr+yIhAjI1/nzzuzSx1qiWZUbTPlRY/5kc8h/lEhcSzD1UbBcyEpAOhyYZGZ?=
 =?us-ascii?Q?ycPM7L4cm70ogJh5fV0DeXfKsKNC7Z7y8FEaPSZYnCh4useVnTUjyQ4sN+36?=
 =?us-ascii?Q?8aTsPj4ZLppr4c9fJLyR+Ko5vQPAxZ2vdLKQKavzWmyCLKjbTasmMmqpiLcn?=
 =?us-ascii?Q?ml9QCF+YLWHK070BiNjIfgxCgctMVgE63s8BbxMAwC2GP8EHvqtSQRpVQOKx?=
 =?us-ascii?Q?CejDrlh2EeAPV4XUw10w8OzsU3ypYWKxV373tLlzGWJjZ49ZkDhyFG8o+1S/?=
 =?us-ascii?Q?8XEWRasTXE2/GAJioR+XUmsqHtNRBhZyrmdilzquKnj+u8S+Bl+2pG03Mtzk?=
 =?us-ascii?Q?/RUi8eHOLIMyxUkYBqpUgEgNumU04jZFGMI+200AMUWKTHgXqh1rthb53Hki?=
 =?us-ascii?Q?29dSZvIi7Iceif/EaziXZUHtcOqq5T+ZTf7LBtVFpJvKJXohTLcsOVzS7am3?=
 =?us-ascii?Q?zZ8ElSOQ4rKzZcrY3AeHu+ZHtWedUbIV16s8FjxzX/w/65dy6gRsscsjU+2j?=
 =?us-ascii?Q?mChPA5bBs+/tOfPqtutwvQGv4xy8yuzqH2lPPig/Q1Pd/OyQye3BWeqlEEub?=
 =?us-ascii?Q?oc4UYoxYplQC7Ax2jAj6jLgGQPI4ZguX3V2/TmuFEce9I76N2hmNFjkk3T8v?=
 =?us-ascii?Q?X7R8xf/2/qfNosf3EG8K2XGKyHwvJ1OVALRHqYAyxzy+JL64S/uT48rIrR/X?=
 =?us-ascii?Q?6hLxHlkMiaOdtRKOzsVAj4DEezZSEMtRkNpVw9UYdMwfcsW2WYLG78LbW/eM?=
 =?us-ascii?Q?nilHMKCys2vBvsBk8xGJI6nlVOgXSRlxL3QF6YV2ddbh0bVSi1mQWi8DNoPi?=
 =?us-ascii?Q?1rVSaTDQHr8uiO66+yALY2EI39pccyh+JLoZ3sTX7cgeQWcgwGfUH/gqOKGB?=
 =?us-ascii?Q?eQ5VwzajzCsikw/2cctV4sLor9momfXG7+KiH3G9Fn3oVp68RNtxv9sR4sAO?=
 =?us-ascii?Q?YbRgBlxd+uIHpVX+8qbmUL47m1BMwjz9h1Y+GBPM+oI69ZxTiWIhv4yoQRvn?=
 =?us-ascii?Q?2hyou524ThT7roV2PHDCcOkDCDdJ6FZp7UWFpN2botDingkGD2SkG4UChA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPfCJeY4NUGtZYfYfdoXPksFlBOzKHhWUCAdYxzREbHybBQfGzyF0iffHmbv?=
 =?us-ascii?Q?5Ks09U1kpR8/V5TB4DrlUaJVhgrtsbP4dLz7I9v4hQXeZ3cSfRBcfyj/+Yor?=
 =?us-ascii?Q?RRVm1WqKVyki1aqH/tuFhyZuaGxCSC5EIudQ5froQk9bTDFGabQpdIxgllxj?=
 =?us-ascii?Q?EWhNJ1ZlSMjpwzjgl3ZDVKbM7wDCUxOXzy/UvZtoF5w/Wjj/Ss2v6uKG26Im?=
 =?us-ascii?Q?4ljQoxclLdS8+gPzGRoZyXfW8s3FbmtZ8e6I9WpuHWtRSFDhxc+CbTpBfh79?=
 =?us-ascii?Q?EMMKiCEXHuTA/D8dDufcVJnsHIgSk6fsqaB4ThE62WTUUgVMOy2vuvOVpegN?=
 =?us-ascii?Q?gI+NLjmLqHiWZdEO1c3Mkiht6exbZNlOfgqKUDHYlBuQsr9Jx+NpQiKslWRp?=
 =?us-ascii?Q?SChBVf2+Y3z9wVqTJmlEMFXBsTFLeJ66dXiybHgaHtQ3uUtl3BUAgFoVrV/1?=
 =?us-ascii?Q?xosTeGPOaEgzRQRiW7snVrX3cPVJVvIzd73CmOOFdEu4qihbLt3U0qAwu8ys?=
 =?us-ascii?Q?kfWk1C8/A7mDYMgkAIdUm2+BvQsSSzrdL/xUC3Pq/EvKbNWPOw0fWe0cYCLB?=
 =?us-ascii?Q?CpcckYhQpbOMnE+gxpVj/1JdzteJ7qZASveJaQSuiyEfk6lKbv+gbkcydAWo?=
 =?us-ascii?Q?RVH0ti8caAShfAnSfMNKN4RlJiyZAoC9vkgOqb4cC//d1JujcMpTO9ySh4VM?=
 =?us-ascii?Q?sB32XHrzdMSMbMQuVUhxGyl2pJd00YtM/qwPpR8wyjKV7U775hgevHhPwV6j?=
 =?us-ascii?Q?/UKerXtVjDPWy9uT3N1KOO1BWpYANsCtRKw32PjGFMSGR9mOlgXFJa/rMPxx?=
 =?us-ascii?Q?A6So/Q0K8JiLj6Ln2hwtCA22Fu2NR5cAukwt1ybI6SJw8Lt0tFs8cXdYuthh?=
 =?us-ascii?Q?CQ6X3ZXeISRDfWtJ7HMFqUyIAp4Afs1nglc7ErRyVIbDWmF8M2UldN30izTZ?=
 =?us-ascii?Q?1OmCna38iKOrTED59lmWR22pVZV4VSBE4nf7pUAis0xwGuYNXyE9gtsnFbCW?=
 =?us-ascii?Q?sXk8FiabbTdIdEyucn9IC8tWNTw2+IiU84uSojOpOC44iv20dPMI0r4NttvH?=
 =?us-ascii?Q?KCjzMaDIn2xCaO5eN4IX6/3k6DfZs6KWjylvnTMfAgGPEzSu1kQAMnGmnO2D?=
 =?us-ascii?Q?uD5RCt27hBVqI0/gn6LKD5Kar90OOFYMAobv5lzh6RYJtZY7e+gSDvmFe5mN?=
 =?us-ascii?Q?JevIiWR2wzFqeQz8Owe6je10RWc02v48xOiU+pR4KpuLj1KfGeYfclFw9okv?=
 =?us-ascii?Q?6B+dTRyiNi/AdNyyRo1/hgFLH8GcV/LQFGaxgxdFvektySV3gOPzU5kQUzaw?=
 =?us-ascii?Q?opwBirWtD8pbBtP23EwITNndCUDekZFW56OmsayyHnveEjzgNPEIo0z2uBkQ?=
 =?us-ascii?Q?ehJoJ46yBq/2eGcF5H6Lij7za89af11t3G9a8ZPGCj85y+0nwx3MEcO9cqxK?=
 =?us-ascii?Q?GDGdVFSrNqzsrDJ/kXXj9lhI7L0dXpgMJ+kiU7wUrfIBXdsXlJJDrLODFXwa?=
 =?us-ascii?Q?MRBz72EmDYS/Hcrm4hQVG4/vUO7oIUBRPf4PcXj49o/x3BwvKtNfPUkpcxvh?=
 =?us-ascii?Q?F7HlBi/gqQbq6Q5KkR87/PKOfKH7wf3op72rRqHf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc078cc-172b-4df2-3488-08de0ca0cddf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:12.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uFEcNH/jLq+E5ZD2QrHpDDdjPZnxV1T5xNWa/xWSyyOiKA51rautUiGtcNoGXc5aNPptH0Pqew+EtZ7+91BOVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

NETC blocks control is used for warm reset and pre-boot initialization.
Different versions of NETC blocks control are not exactly the same. We
need to add corresponding netc_devinfo data for each version. The NETC
version of i.MX94 is v4.3, which is different from i.MX95. Currently,
the patch adds the following configurations for ENETCs.

1. Set the link's MII protocol.
2. ENETC 0 (MAC 3) and the switch port 2 (MAC 2) share the same parallel
interface, but due to SoC constraint, they cannot be used simultaneously.
Since the switch is not supported yet, so the interface is assigned to
ENETC 0 by default.

The switch configuration will be added separately in a subsequent patch.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
index bcb8eefeb93c..35cfbee00133 100644
--- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -47,6 +47,13 @@
 #define PCS_PROT_SFI			BIT(4)
 #define PCS_PROT_10G_SXGMII		BIT(6)
 
+#define IMX94_EXT_PIN_CONTROL		0x10
+#define  MAC2_MAC3_SEL			BIT(1)
+
+#define IMX94_NETC_LINK_CFG(a)		(0x4c + (a) * 4)
+#define  NETC_LINK_CFG_MII_PROT		GENMASK(3, 0)
+#define  NETC_LINK_CFG_IO_VAR		GENMASK(19, 16)
+
 /* NETC privileged register block register */
 #define PRB_NETCRR			0x100
 #define  NETCRR_SR			BIT(0)
@@ -68,6 +75,13 @@
 #define IMX95_ENETC1_BUS_DEVFN		0x40
 #define IMX95_ENETC2_BUS_DEVFN		0x80
 
+#define IMX94_ENETC0_BUS_DEVFN		0x100
+#define IMX94_ENETC1_BUS_DEVFN		0x140
+#define IMX94_ENETC2_BUS_DEVFN		0x180
+#define IMX94_ENETC0_LINK		3
+#define IMX94_ENETC1_LINK		4
+#define IMX94_ENETC2_LINK		5
+
 /* Flags for different platforms */
 #define NETC_HAS_NETCMIX		BIT(0)
 
@@ -192,6 +206,89 @@ static int imx95_netcmix_init(struct platform_device *pdev)
 	return 0;
 }
 
+static int imx94_enetc_get_link_id(struct device_node *np)
+{
+	int bus_devfn = netc_of_pci_get_bus_devfn(np);
+
+	/* Parse ENETC link number */
+	switch (bus_devfn) {
+	case IMX94_ENETC0_BUS_DEVFN:
+		return IMX94_ENETC0_LINK;
+	case IMX94_ENETC1_BUS_DEVFN:
+		return IMX94_ENETC1_LINK;
+	case IMX94_ENETC2_BUS_DEVFN:
+		return IMX94_ENETC2_LINK;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx94_link_config(struct netc_blk_ctrl *priv,
+			     struct device_node *np, int link_id)
+{
+	phy_interface_t interface;
+	int mii_proto;
+	u32 val;
+
+	/* The node may be disabled and does not have a 'phy-mode'
+	 * or 'phy-connection-type' property.
+	 */
+	if (of_get_phy_mode(np, &interface))
+		return 0;
+
+	mii_proto = netc_get_link_mii_protocol(interface);
+	if (mii_proto < 0)
+		return mii_proto;
+
+	val = mii_proto & NETC_LINK_CFG_MII_PROT;
+	if (val == MII_PROT_SERIAL)
+		val = u32_replace_bits(val, IO_VAR_16FF_16G_SERDES,
+				       NETC_LINK_CFG_IO_VAR);
+
+	netc_reg_write(priv->netcmix, IMX94_NETC_LINK_CFG(link_id), val);
+
+	return 0;
+}
+
+static int imx94_enetc_link_config(struct netc_blk_ctrl *priv,
+				   struct device_node *np)
+{
+	int link_id = imx94_enetc_get_link_id(np);
+
+	if (link_id < 0)
+		return link_id;
+
+	return imx94_link_config(priv, np, link_id);
+}
+
+static int imx94_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	u32 val;
+	int err;
+
+	for_each_child_of_node_scoped(np, child) {
+		for_each_child_of_node_scoped(child, gchild) {
+			if (of_device_is_compatible(gchild, "pci1131,e101")) {
+				err = imx94_enetc_link_config(priv, gchild);
+				if (err)
+					return err;
+			}
+		}
+	}
+
+	/* ENETC 0 and switch port 2 share the same parallel interface.
+	 * Currently, the switch is not supported, so this interface is
+	 * used by ENETC 0 by default.
+	 */
+	val = netc_reg_read(priv->netcmix, IMX94_EXT_PIN_CONTROL);
+	val |= MAC2_MAC3_SEL;
+	netc_reg_write(priv->netcmix, IMX94_EXT_PIN_CONTROL, val);
+
+	return 0;
+}
+
 static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
 {
 	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
@@ -340,8 +437,14 @@ static const struct netc_devinfo imx95_devinfo = {
 	.ierb_init = imx95_ierb_init,
 };
 
+static const struct netc_devinfo imx94_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx94_netcmix_init,
+};
+
 static const struct of_device_id netc_blk_ctrl_match[] = {
 	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{ .compatible = "nxp,imx94-netc-blk-ctrl", .data = &imx94_devinfo },
 	{},
 };
 MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
-- 
2.34.1


