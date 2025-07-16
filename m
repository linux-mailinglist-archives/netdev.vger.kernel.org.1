Return-Path: <netdev+bounces-207399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC8B06FA5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D847A21B6
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710C291C26;
	Wed, 16 Jul 2025 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MqymESud"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011013.outbound.protection.outlook.com [40.107.130.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A25296150;
	Wed, 16 Jul 2025 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652360; cv=fail; b=KJUpYv/wGVWo0hyoQHY2rEC9GKhXGRfLI+y3wffiLoxP2Hj6XFdYhBJj/V5hxt0u6KUyG531ctZy4ptOtFXUEGSCKU3vEh+QO5M9Hx2DUGqcBiZ+sQfVpnoFxPp+xGnB2/L98GD/+P0wwZHGDHS7KkbAppQ9Ye+Y8OLLMRTTbgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652360; c=relaxed/simple;
	bh=HSnrVp0ozWn5I3ggTDQ2pLI3mgf8wiqH4j7dBm9QE3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rU7nEH1l+QGRDSxoPC/X5Tk9xsr/VmKwtb9Bd83VnYT5HCLKm87kvkt8mZbQ4ytSw3wDhuNmT0M4kGR5Z8B787D3b1KgFRlJyFnMxNcN1IcD7ermDHBkiwpxjarkT4QIdGIZQTxh7SYRCb4IgpbD5zrFdXP52hMqKDG6Begn8WA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MqymESud; arc=fail smtp.client-ip=40.107.130.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs7JkaCqm1kvVMAdy4Wozk5RbbM+vPDIthbhWs9c3vnSIUacFD84NDY3pk9u94JemjBgUMq0fMCxtXMTIfHdnh3h5W0zjTxI0MjUiz+RaTVpfVwZoKTd9rLdgCyw20v06lUE9MIQCl8u4c59mw4QO0t3IWRbBIVHDs11R1OqCYFE1reV6+7e5GITrcWB8pL39Tr/Eetw4eYcrtisGm9/08iyjc57ce6rlXFcFuC6XnRuU3zVFMiGI0h0VKu7oOGFYlltYS3l2AXi8wUVI2v9J1c/ibEaurpJXsE311W2eKXGtyTVST/tOEIE0NMIlSZtEp4Cn3EDCZemlSy3XP7LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iD4Dhs5cNDhmUTJEBH/01v9XDnV2TK+P5rhG1VqJapI=;
 b=n1Fu/0B6DmTYr89ckHxvlhtmLJAvhzI1A3E6UTRjGKGzP3EOydaO9LONggRrWHSWX4lxvPiP60G+YmSfq8/0Y7Q5PJyfxhN3sYFX+ZLvy4JgT7QS1lqvDUnNTOnpi0u00zhQ077O8WBQvisH0uKT9VTMpMEbyIl3VMEZ4gIyJqw8JTvA8ye06Bc0iXpIWv0ufPBkxZlvrXfYoaQK5Ooimzez4+I1FsZJAF0KdphjTmiY4cpEKIwv18m1+Qs7OqiIymKUnEOKn8TdtlCK/ad+ioA4OrQN6hiPEEYzFzjr7a0XXSnE3QyCB46a0FsU136lpI2se/D3kSV60Sqn0j5Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD4Dhs5cNDhmUTJEBH/01v9XDnV2TK+P5rhG1VqJapI=;
 b=MqymESudsrcfIVFlacAt73GvPVOuzxeIb9stSfnI+Nqn+tNUtuR041ElZiAxOoSmSjpeQlHlxJiFucE3rRWYFvaGbPQrD7gczDrhAWG6s7oJEjtp0+L2JZwAqku0Y5IgRCvSbuLxSdfYDz3ClLpnv3+BSRbWjzTa9+N3XsBaVTXFTtWfTeQNap/rzvDiwaSDS69J4l9lkiTkkxZti3bMfPdqxNv9riTCeZvJXKELi5ejdArnq+8JcwDz0tarcQllmIKV0o3oApaNtL+29vDPxcJpdcd6AvZveCMacgLLRmyoeq04twCVg2/72zGG7CMuxPyx8AAbQIzVKWujxJxTFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8736.eurprd04.prod.outlook.com (2603:10a6:102:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Wed, 16 Jul
 2025 07:52:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:52:35 +0000
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
Subject: [PATCH v2 net-next 13/14] net: enetc: don't update sync packet checksum if checksum offload is used
Date: Wed, 16 Jul 2025 15:31:10 +0800
Message-Id: <20250716073111.367382-14-wei.fang@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: ce81b835-46cc-449a-73d3-08ddc43dba34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ks6NbOK5c1AQAiNmJ0ery9tR/g/1c7Js2w3cdlm8kxp1EsuSSIC0O/TuddsL?=
 =?us-ascii?Q?smlQJsJp8Wfc2Abv5CtQU6L59W/gJm1KdK6Yvpz131NEz6BCTEGvYYjJiScD?=
 =?us-ascii?Q?neVC0x9SZXcGrricf7gcIx06dAF4zG/hc3ZdQzZHXGnNIaPaJyM6cy+7fcUD?=
 =?us-ascii?Q?yx/6RumCWInh6dObMDLApXxcAWV1gkxjkzUzhN2OhEoFM36HllfWzqiJla5K?=
 =?us-ascii?Q?C+QnOsZiMvevEvyCtVbSDwE9n1O5zi2NdxOLmmpwys9aJZlwnc4tQhYw2hGh?=
 =?us-ascii?Q?DyQlf59XUQnYPDhgIN1BAPWFUD1QvOznPrOxFr3z1lJeUn8V/aKE/UN6uMUm?=
 =?us-ascii?Q?a0UXlymjpPd608ztLoMR8m+8incM1MSxKzzvWWlMQ/eGuVAurjhKeXlKptxd?=
 =?us-ascii?Q?SMM414ASU5ibIeeNqL4UF5D7gu5zwb7nujpb1y4Spz9yeOjdGcsW/1O1f2or?=
 =?us-ascii?Q?TToAZWrQkvIULhz8/nEFW0a6d2KX39AeXVjrVRHklVDAGomKER1Fx05dUuzr?=
 =?us-ascii?Q?XFoIOCpaCVzoxhsSD6Wq1notx1FGjT0fLcLWvMZmsO1/Hf7nGHjSoGDhciA9?=
 =?us-ascii?Q?h1wP6+DHMDCcMm+JmmuBrDtGe2qQSObQlwNOvU1Eau4SYZP+voFyUXXiP7jy?=
 =?us-ascii?Q?/XmDTwvfSNKnwKzFSlZGs3+MLyWL2mYkyWlpCha0PxeTVddh12xe+4uWnG/+?=
 =?us-ascii?Q?MsjZjeB/qxFxYBkjL4nUzwVrswkpaom6w9OkoQOdfsZKfluwzYOFW3PbRcvF?=
 =?us-ascii?Q?+MbA/5PGcSi8I+zzE6KNr5x3FcLreOBt9yMg+YCRI6sx7kGbG/vZDMw2vGi9?=
 =?us-ascii?Q?QDUUrz5S4ZKdMGR/ZxcXOS2xVGLD/9PWwu86JyLfM89M9GZE/X8il7inB1II?=
 =?us-ascii?Q?JaTXJYcOq3ZL5KsIBeHB9hnSJwLf/96fQ5bOaD4cgqs4SX9qj5ELP5zkFdih?=
 =?us-ascii?Q?dQThw20lQu15ROw9AKyPCeu1kQZM2dg+5l9CE028VJwzPQPesDL05LAABno1?=
 =?us-ascii?Q?UtQ0+t/LdQqA9SWRc3saJfc93Vt4b5jUXAN7/W5iXyOqplhI6Nb2GCiCdbwd?=
 =?us-ascii?Q?wtinhK3eCO+FCh9+6vahFBfCu9UJ0CyugPEzEMs2gSrSX5O9+L6ejKTXqMAf?=
 =?us-ascii?Q?/tfav67iNLpN89PO2t3p/ykosxkDgEnd7dc15fZDCdX1e2zow9qeD2BR0pIn?=
 =?us-ascii?Q?1ZEpQVMGEhIYYJVlc2jRNEL3WWExLwQ2EgLaHao5JZLjtjfGOYUbug85ai7U?=
 =?us-ascii?Q?86TlABwXLjRKCScB1FxCp0FQeSCS3Yak+4L+kNRE32XFsoU0A/lo3ZO317Qa?=
 =?us-ascii?Q?yJsoTfcZ54/AFSz4Xx+zpgofHLbGHt73FRXHjbqzSmmadPbaaBIneEy0iLuL?=
 =?us-ascii?Q?zZvSwevXaH8vVMzJy8zBolnOXePbCOAze+UtDDy2/DpGexsW3yPJpM0sBa/T?=
 =?us-ascii?Q?idUznyAzOKTD3zvj2xC/athCf//k10Xv2vf8PkIYwjF87zcrQaBJhSBYqJCV?=
 =?us-ascii?Q?XAcjczGDW+i1j0Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v+YMNoZzDQXYf3CbPUmJY4YFYtCEq7w2y4O3nV7TupHNYA+G5j5QEBfGrNlj?=
 =?us-ascii?Q?9Pu+sAdIVG9MIQKCS1SBzG+Ja/YIG74AYw4+gXqfteCHHeQpUTqXFVToEPa0?=
 =?us-ascii?Q?QQ7Rn0gpanDTTcXheqYq/esrekzla6/Ro9gjTI6YUdyfIZoiCBPFU/spLJd6?=
 =?us-ascii?Q?tSEDn2M7n+PY42WbZKtAPtYkMUTJhYHQDR9GsqdeqnLMqg/Cb4T7xFBFrHs+?=
 =?us-ascii?Q?6o6BlJNEwR7VpH7CGc0MBqy+wzaFMk8tv2wwBUTOhRS4w4n19w8PFButfXdd?=
 =?us-ascii?Q?jfMxIRy9CVMV/2s2Zp4MqpHFTd91br3q2aZijT1VdZ11sLbz9RnJuHHU9g+L?=
 =?us-ascii?Q?HyC9hPJMv/MYCujXS+1JZCttWPCZImQo6MHI4mRIjYhT3u/k6lAAEPK6A73y?=
 =?us-ascii?Q?6y12ZPGYOHoKqGwvO97SXq/1kjx3+/lbabsvFUD96U4OMBbE8OScgdR4iKNy?=
 =?us-ascii?Q?qV0Q1rgCdiqA6G2aC3LxbIXpc5L9DlY+tMk5HiqHwIwGGG1PiNf89yp0FOlC?=
 =?us-ascii?Q?/c/nZbw8RMQ7RPc8P9L1S5o+SpvW4chjOEFPdJ0IHInrLA6+uLUSv2Ur0wTl?=
 =?us-ascii?Q?evXqaHBsMph17GvEQBPs8Xg91Pm64UfULSn8UeNooIbrJv0qY0WMskopMLig?=
 =?us-ascii?Q?iyZYiZKjwvuAkWTNCZJBE+nY4rqGL0mgHlrnwEUm6Eu+lsGBjRE3CzWq7GN7?=
 =?us-ascii?Q?AIUAfNuiW4ZuCCWq+TNIR27cTAuxYK9Rod73DFHQrcYRYH3AwLAf1SNKadZm?=
 =?us-ascii?Q?LN6uh2uTqfZmnpS253KrUlfU1Yqc0urNLpytwy9osJxovDsuqjdFA/3pnxea?=
 =?us-ascii?Q?9nWfRJmh4iRj22imRz9V/uNdSzqGm1NuJH+mjEPaNy++np5XiLnCAE/1ONlZ?=
 =?us-ascii?Q?AR1uR9N3f9jZfCEEfYKfG6HmfUjpHPWmemOAnQ6EyyVWTCtBK4SjRVeD9AHF?=
 =?us-ascii?Q?huxd0+yiZZa98yU33HGFP6RUb8iJOJkqK1c+J9Elw1GMTiB1Cu9TWx12lGI2?=
 =?us-ascii?Q?lI2do5/S2V0TIQG8wN7KKcg45hUcr8rDdl4FeVxscUleh88G0yPZ1GsIjfNN?=
 =?us-ascii?Q?PC6JI/gj1JrDJjAVszIL5PthuwoS/YUMIR5MQz+ygCXMKgVE5pfeU2tk+9JE?=
 =?us-ascii?Q?+16BriNOWiCVw95R5UtC4AqgaoRf/TOvsbTkIjkhZ06z5Ibxt0jLn0pOHwwc?=
 =?us-ascii?Q?Ero4831zERIsIZqs3Nul/ciNsUXaN8m8zI8heBrvSnRsrpSSxdWQTi3A6qj2?=
 =?us-ascii?Q?DmCgP3xYh5gaY1FfhajmAmAm6qQa0+lAyZWb8RXCUfI5zbdvpV1zEDg2/T6y?=
 =?us-ascii?Q?YO+VnW3zCvUz0R+tL6UuMA9jxjnQXHzo4pTqRBRoDXBY0v8c28xzdkSFJ62b?=
 =?us-ascii?Q?83hMEi25+R3cYg4gCgv++WbXIKFb1+VeWPqon2+9i3mHWo7fk14shpsUj4xA?=
 =?us-ascii?Q?YXDnAWjQBz8iAhybpianHAjxY19ylijJmG6whiovtY3yQ0LFdfZn2Se4jrfb?=
 =?us-ascii?Q?uxfpeTSdcbarrrpIYbxjuw2t42Hf9KX9olJVA27+MkFDNiZDSB3kRpQ30/+F?=
 =?us-ascii?Q?+VnoDg6pPGS3W47o/vny/Dqf7+ajpG5g9B1KJBtS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce81b835-46cc-449a-73d3-08ddc43dba34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:52:35.7201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6OO0ANtbfY/+Lbtkg0gdhvpomgJKXSTdxgLmDJwlBKQLnMnEwW+Ei5T6LGgBe7dRcKXKIejXk77A3/EY2I+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8736

For ENETC v4, the hardware has the capability to support Tx checksum
offload. so the enetc driver does not need to update the UDP checksum
of PTP sync packets if Tx checksum offload is enabled.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 6e04dd825a95..cf72d50246a9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -247,7 +247,7 @@ static void enetc4_set_one_step_ts(struct enetc_si *si, bool udp, int offset)
 }
 
 static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
-				     struct sk_buff *skb)
+				     struct sk_buff *skb, bool csum_offload)
 {
 	struct enetc_skb_cb *enetc_cb = ENETC_SKB_CB(skb);
 	u16 tstamp_off = enetc_cb->origin_tstamp_off;
@@ -269,18 +269,17 @@ static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
 	 * - 48 bits seconds field
 	 * - 32 bits nanseconds field
 	 *
-	 * In addition, the UDP checksum needs to be updated
-	 * by software after updating originTimestamp field,
-	 * otherwise the hardware will calculate the wrong
-	 * checksum when updating the correction field and
-	 * update it to the packet.
+	 * In addition, if csum_offload is false, the UDP checksum needs
+	 * to be updated by software after updating originTimestamp field,
+	 * otherwise the hardware will calculate the wrong checksum when
+	 * updating the correction field and update it to the packet.
 	 */
 
 	data = skb_mac_header(skb);
 	new_sec_h = htons((sec >> 32) & 0xffff);
 	new_sec_l = htonl(sec & 0xffffffff);
 	new_nsec = htonl(nsec);
-	if (enetc_cb->udp) {
+	if (enetc_cb->udp && !csum_offload) {
 		struct udphdr *uh = udp_hdr(skb);
 		__be32 old_sec_l, old_nsec;
 		__be16 old_sec_h;
@@ -319,6 +318,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 	struct enetc_tx_swbd *tx_swbd;
 	int len = skb_headlen(skb);
 	union enetc_tx_bd temp_bd;
+	bool csum_offload = false;
 	union enetc_tx_bd *txbd;
 	int i, count = 0;
 	skb_frag_t *frag;
@@ -345,6 +345,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 				temp_bd.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T,
 							    ENETC_TXBD_L4T_UDP);
 			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
+			csum_offload = true;
 		} else if (skb_checksum_help(skb)) {
 			return 0;
 		}
@@ -352,7 +353,7 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 
 	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
 		do_onestep_tstamp = true;
-		tstamp = enetc_update_ptp_sync_msg(priv, skb);
+		tstamp = enetc_update_ptp_sync_msg(priv, skb, csum_offload);
 	} else if (enetc_cb->flag & ENETC_F_TX_TSTAMP) {
 		do_twostep_tstamp = true;
 	}
-- 
2.34.1


