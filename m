Return-Path: <netdev+bounces-221829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9779B5207E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F296B7B2CCC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5F2D839F;
	Wed, 10 Sep 2025 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CfT4gWvo"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4D12D77FA;
	Wed, 10 Sep 2025 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530382; cv=fail; b=C+UfnugVbRoq+UBLDaIO8isHIUoBwyWhcOAMDfClbQ/TWZYWhR4eYVTsUUydU0aHE8a1KY5j+86wfyOuxnyPux4qThmiXgolb2Ef0YvEXX3bht0mgDZeZ6GaXkkeRDh5WqoyCP2P8dv2wG6n3jwsZ++Amtm7nyCA4n70D1qAw4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530382; c=relaxed/simple;
	bh=G2JYCyiqOKKd8MQpwlc3j7y3zYiZ2Gyr6hRk4rvdtsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iY2ExWJm71SRzEtcY3gyYucMH0884H+N8fshQi8e+I7sI5al6B6ix0bdk7D15dmvQpqbotDV2A5HnqrN+Rljt5d5SDAwrvAkXMqo+uO0+DOJveX/jX+vUmyVPVe0wQuNCrVPA7eDaBiPcE6Vni4B+LShze3UsJ5nMi5Xcu7UKbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CfT4gWvo; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx3ok8k+ucDJrbM8JTQOQB8IE/Y63ZMGvGzP98sYV+bFC3wiI9DiPp+fb/4yTanjfaB0PmmU9rzSekGtfpRiiG43e4da5ccy++mJ1hmEcJnEj2dwtqTPmey+bBZTQ/T4NYtoq+1SgZjXVmy1j1BhviQg+P5ZpmdJHR0sMldI4+k0kHj9Fusl6ZzpjUiUzo6FcKdu+c+k76MKoQCN3YOGt0tbRKD+mKdnPYTrTBX3JR2vZg85yYI+u1MfT+hEbLfZUycs2XoyjbMfs/maOUKc+4e2A3trmqOWBVrUNWrk+2lAxjObGa6zUUvkxKtyfv69w5Gf8pPTkthL4xi4KJctXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEm4w01ijwmRVhX6OVqU2FsPYh41mFdTNhxAChM6NfM=;
 b=sDfQT6Uju43at3oDS2DVh1HDJoJ0g1Q6C/jjDq9g+8eM26dovtI72nCHqPK183JQ766BBhU4C55rKGjG1WlXElBcj6p4Wla1wpnI0JUDim8u5A9M1llwThtbNnjInnslQXQauyuz0VYAXObRk5AJWCP+v45eguLtDNwVg8nhUro/EK9C/2E+u/CJqh0to/rcSP6VdzVSCGPjgd3EE0GHfUotRA7aPQ1gfI8oao+FkNOMdewjTaTiD7gzeVkjkEs7zCgsVDqAaBeLRitVoau+++xCsA+n4tXVxdSaEFyswDxQbJky8oQbhjTQdla6zuogpQz2D4dvyG5GGWgUUo0K9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEm4w01ijwmRVhX6OVqU2FsPYh41mFdTNhxAChM6NfM=;
 b=CfT4gWvo3SzsiWmHaFBYdOlLEIlLBMT5GsGR3AxCl6I32/jdpHyaSKs/FgNFGf3NMg6OkmvZgwLzElGBjvmxTqounuF1PJKb7FZ/mZjBDO8R+uAQyRlf5BfhTmbCgwNZfQrpC6n4fSF3cmQyoBatFt8fQupWZpPPWTRzm3DAVAhMCjIR2pxJ8ZXVzY9lxuA4Nq70z8djo41XlHrg/TDRc2wAXyPi1DakqotUfgeSsQM3+Oh9iBdu07jAHlxjGY0wWqSfvYyBpUagPLgOj4A8V1P8/+59298bfi38W14CZvyUD8oTTFHHyLKnJvr7eRHIwotOjbf2xE648FnIxx5peQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:57 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:57 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: [PATCH v7 net-next 6/6] net: fec: enable the Jumbo frame support for i.MX8QM
Date: Wed, 10 Sep 2025 13:52:11 -0500
Message-ID: <20250910185211.721341-7-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d5885e-2a5c-46e7-992e-08ddf09b41cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?om5Njk/kqkg42RUh9EhBlycwWKpk+W2crlbHhmcQxz0F4/wdYOMyP/yjx+j2?=
 =?us-ascii?Q?feVVsbLNAIqWzf79qgx8ez3nzsFLYl8rtzrTPhOmc1ydnoHuA/n3uFHvgnzo?=
 =?us-ascii?Q?cCK5xhJkq5xTCPmKlQ3Lw1SYZfNDEuXIqmC9BuvA3BrIuq6XSjhIACBixe5k?=
 =?us-ascii?Q?eqYxKBZQuBTx32GqZlR9q3m+GeAg24Vvmd+BboSLc2MhJKw+vc5bzQUdVIbX?=
 =?us-ascii?Q?iA06tKB39wS90j5TOdNU1xAInkYWODkoXD5kaqzEf66XxaoQJvj1xGWAjnve?=
 =?us-ascii?Q?XWMEBxdt86Z5/qMP5GZCji6ScoceQkxHOTd9hdcG6Bu3Nyd/kGwmaiizVH/W?=
 =?us-ascii?Q?M0xlIn0YN/88+dauKTjC5YobBfyI9+IYAH06CRJIVM+vSQY3gTl+6ohZjsc6?=
 =?us-ascii?Q?0rkVQygB5venJkvxjgx+GMxYh3Nq0QaVmJtZFn+NkQfunccohpIhzGX41uko?=
 =?us-ascii?Q?qbPn3MbWdf6d/+QWLrVTiMRTf97qDIx93UG3wXPMvDgjC2bqzONfJjTMikdg?=
 =?us-ascii?Q?yV2+Pv2QQ8yoe7be3Gqo/QCDnZ1M5bFpcVAKWwprNI+OHWnIXbiFAA2uv5gw?=
 =?us-ascii?Q?8K4/LADVZ4D3OtUEL1vxljgqSsF6y8igxJ+uglE8i2749UNJ8cAOtIDGrZyK?=
 =?us-ascii?Q?3IFVEB5mu8XJtOqA01CpH0rgNb16Y973WRbvHrqqCMKbW/WRWfYF3dxhfovU?=
 =?us-ascii?Q?hOpjBjcrG8QqcXngB/dZG5xCBalv1IUqUjk55jTyzLCSjB6B8mtujAPap3Fo?=
 =?us-ascii?Q?uEgSCwATmdm/hLg1Ic0G/FRvVAHd356REhM7wYWtaaEWvuGP2/OjcnS51DXh?=
 =?us-ascii?Q?xGI2sjzUrcJs4dtGa9S9WD0swuWQRlC8Ph7+0tIMbD4rQ4APHlc7roB5G2lk?=
 =?us-ascii?Q?os8SKx7YkErYu7gQS9njQs2H4SdLWzzMW9uc5HDPVtVUOSXpcSh9Hc3Utp3q?=
 =?us-ascii?Q?lQC26Y8esk2va34x9g1EDxxf1n2iGyO/31xBttwC+dEmSQqlBUGUGEG8ysFx?=
 =?us-ascii?Q?7jz2YLTl4Un7veuETd3uEFAgJn12fuFHOyQHkFinJrZj1vXSb9h56xA/w1hk?=
 =?us-ascii?Q?f/dBNZwjKbjxABAVL3IVw4uAfJam+/yeQIHPigiLu6ubASQ640i7iteVw6I/?=
 =?us-ascii?Q?5k68/nikOGEw0LF4wAO0OS/N35IzGIVQMKPUbyqlgBZVAurNsKUTLsyQuSvo?=
 =?us-ascii?Q?ewcO7mf86l2rg9k7PqiMdLbh5558AHutSPcJ/TR0/7w2U3HrUTphTkjFXleP?=
 =?us-ascii?Q?wkTTd0+umqR7y1XH5IUtzSoSl2c9pzjlpJPHz6+LwU6pCv0FxuRzKM2g06QJ?=
 =?us-ascii?Q?eKktK8cq2WkkqGJJJjWo7KCBxqcg8Qtewzr5wn8FVMwnOybJ0FTRTeXMrjMm?=
 =?us-ascii?Q?6YvENRrtgI6NrPy6wdHqD5deuMlkpiNatBS9Z/ZiCaU/BllEs6JxX/myAjfl?=
 =?us-ascii?Q?6v69reUxMQnnoY1rzznt3KimXXqJM4R9AygmHaaRX/1alDREgKPyXAdAxcrW?=
 =?us-ascii?Q?qCinaSHMDZUrfYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P+znlM9D1DV4xBOTb9cIA7I7sbiLDvgQ39ePZ4q9Xe/SmfHVAGb+HSJZeqnO?=
 =?us-ascii?Q?EcXa67Xx71xIDN4vrUz2AzpB5VQ9MY3iVSMQx4X2vhErywCaZ9VMbZJAtKNs?=
 =?us-ascii?Q?9+gmcFvHgjA+W8hwaH2Z/6uR1WNyr3CbnllTNV6M0tKA0LRk2TMfLzgUxMDm?=
 =?us-ascii?Q?0uEpBqGqfQA3Y70Z1ayY5arOjb4N5dZlroZcC4erZJHVbqiIi8ZxFYehYPr+?=
 =?us-ascii?Q?Kf9Ijt29ehbnwyWWcP4Qd2NCy30zfNBPewejoS493th/x1qbjePHMliYMIYm?=
 =?us-ascii?Q?IGbfABTMpFxRBrt4K9VBfg2iLaHWu02aSJs8qhtfMn+FXoYrE32Q8WzokAHW?=
 =?us-ascii?Q?oBdKgWshnNXYPYbOkMT5UFgIyc+bcbJ5T1nPvWrcBbz3sFrR1QZreBGy3xrJ?=
 =?us-ascii?Q?MAwczoB+6AiKfyq+MfdEyN/x53OcWkMea404qo5OCxftdevYJR9dVewyp5Ns?=
 =?us-ascii?Q?vX3aSoRq7Js6AfzeOGHjmJUrmhBfOlFhnnZVioi3vtx3RG4kWbBmohir89Mz?=
 =?us-ascii?Q?XyMZwaiT3DskZzHNudVJQekVVmEDaqZsGrcxvxtYFNTO0daSdjsujn6kUnHb?=
 =?us-ascii?Q?FeNGJlGMP5AJ+GkH6IuL47E5cUgEEZHpTrsTkCr7vg93//J67X6L9godPt7L?=
 =?us-ascii?Q?zw7khR4/wW9apL1xhRWqyaF3OxEyBVx2TSY1c4R+DGhnRkx2XFEpcLbDJEbJ?=
 =?us-ascii?Q?BVhxqKn0hoyEM7W134msuQIdj+s+TkMWmtcSMIzVPqfPgWxdGtWYUP3NWCDd?=
 =?us-ascii?Q?WmwEfL0swRyNVRssGlYL2dSMc55W6b5fWoU8tkSOvwuIqxcgkQzN8G8t4cDQ?=
 =?us-ascii?Q?lhdsAFTJHDg13ibBOdTOR3aV+Tad1PtV5l13uIegBLHBzVWwii6x6In3QvCS?=
 =?us-ascii?Q?nrnmHZNjd5Xg7dUz6hoEKXisha+bUn5kBjCLqHLi0VYrG23egZPtJFiAOv2y?=
 =?us-ascii?Q?IiMrb15GU2eEpPYSNsbpvQX09llatJAzrhX6BwKaQ/G3XJBpoKJNZDsglR5Z?=
 =?us-ascii?Q?sOQtZxtljzhrnzX+Exd4ITqYwEFSC2MW78s3KyibXBzzo5xdZZYn6QfQvNq8?=
 =?us-ascii?Q?cBtUYcltzRTSiYsSW4r7H2qpYuyRy8QW5UAihzwJjeItdpcRyf7bW9g3HPkm?=
 =?us-ascii?Q?ZL4og8sra1gqxRJfD4FrOiG00HamaUcaua8jbNteyDO8z9OF5dM7R0keyf/u?=
 =?us-ascii?Q?fQH9KPr8EmxX1cTnd1KrVrdsyiHNjGR52yP0kh5lctwdhEpuA87lIOvxf2WU?=
 =?us-ascii?Q?PNX9MHo9ODbW2O3pGvOtS/igQkZ5diTKMlZ3DwxqNmkTqg4qUdIZLQfwgZ6a?=
 =?us-ascii?Q?AFA61pvueCPUtWS9Vvnn/KM892ITgcXkHePPIlnmsE56oI8v5gmZum0DhlI3?=
 =?us-ascii?Q?QuhkdanpbTgrPwbdnRdxjW/VS3IjTI24YS65HdLSjBiDFIl6k0NWbPJhQ8WE?=
 =?us-ascii?Q?axEgb03QlS6Z0oUgbwEx3xQcHdeYsU0M9gs3GF00LJDOoZhl45AHsJ1x+XB6?=
 =?us-ascii?Q?yCP0WISBNLU/UJ2fZsnDaqAxlsryyAYvaAD1Ie/WLs02D1iRyi3bgHtjtGaO?=
 =?us-ascii?Q?5NJ+VdyNJ+QY8oA+IABVH4GGjJm4/Q9dJf/jN7Uo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d5885e-2a5c-46e7-992e-08ddf09b41cd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:57.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oCZGCm/5PDdJLDMQzwsOJBtw5coXRuv3Q6C7k441xH83bTXdv67TK1bBMxEgM5ABq7v2JOb6W8BY9ooMa/oDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
FEC hardware that supports Ethernet Jumbo frames with packet sizes
up to 16K bytes.

When Jumbo frames are supported, the TX FIFO may not be large enough
to hold an entire frame. To handle this, the FIFO is configured to
operate in cut-through mode when the frame size exceeds
(PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
to begin once the FIFO reaches a certain threshold.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  3 +++
 drivers/net/ethernet/freescale/fec_main.c | 25 +++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 0127cfa5529f..41e0d85d15da 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -514,6 +514,9 @@ struct bufdesc_ex {
  */
 #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)

+/* Jumbo Frame support */
+#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
+
 struct bufdesc_prop {
 	int qid;
 	/* Address of Rx and Tx buffers */
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 7d336d1b2c00..78b0ce862281 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info = {
 		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
 		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
 		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES |
-		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45,
+		  FEC_QUIRK_DELAYED_CLKS_SUPPORT | FEC_QUIRK_HAS_MDIO_C45 |
+		  FEC_QUIRK_JUMBO_FRAME,
 };

 static const struct fec_devinfo fec_s32v234_info = {
@@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
  * 2048 byte skbufs are allocated. However, alignment requirements
  * varies between FEC variants. Worst case is 64, so round down by 64.
  */
+#define MAX_JUMBO_BUF_SIZE	(round_down(16384 - FEC_DRV_RESERVE_SPACE - 64, 64))
 #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
 #define PKT_MINBUF_SIZE		64

@@ -1281,8 +1283,18 @@ fec_restart(struct net_device *ndev)
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
 		ecntl |= FEC_ECR_BYTESWP;
-		/* enable ENET store and forward mode */
-		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
+
+		/* When Jumbo Frame is enabled, the FIFO may not be large enough
+		 * to hold an entire frame. In such cases, if the MTU exceeds
+		 * (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), configure the interface
+		 * to operate in cut-through mode, triggered by the FIFO threshold.
+		 * Otherwise, enable the ENET store-and-forward mode.
+		 */
+		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
+		    (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
+			writel(0xF, fep->hwp + FEC_X_WMRK);
+		else
+			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}

 	if (fep->bufdesc_ex)
@@ -4583,7 +4595,12 @@ fec_probe(struct platform_device *pdev)

 	fep->pagepool_order = 0;
 	fep->rx_frame_size = FEC_ENET_RX_FRSIZE;
-	fep->max_buf_size = PKT_MAXBUF_SIZE;
+
+	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
+		fep->max_buf_size = MAX_JUMBO_BUF_SIZE;
+	else
+		fep->max_buf_size = PKT_MAXBUF_SIZE;
+
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;

 	ret = register_netdev(ndev);
--
2.43.0


