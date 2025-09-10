Return-Path: <netdev+bounces-221828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A3B5207C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 20:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE211BC72DC
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168102D321D;
	Wed, 10 Sep 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYafp8HE"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08A82D781E;
	Wed, 10 Sep 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530378; cv=fail; b=T4OBhOGcMPBwkKsLq31YOw+wRJeSJ7W2qHwNvGFnONqVgnTEbtytBUSejBHGbVp0HiWROiPDFlnK9o40thZyHhqlZ0QKyMNZ8/Vtp5El/7EZ5QL9Im0Tx00/cr261hQ4MDG/4ry9+FHekDyfOocvvscEXGwioWe/KdjSaDgFM44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530378; c=relaxed/simple;
	bh=nMN5r/BGJStOdrPTotRNejkdt2n/q5KllSPcxiMs7aU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pS73qSUyG7yxuEHT0WlygrffJv//Suy1iqjp+9RZJyxiwPC3rUGA4k535fPKu3x8/zhLto4CKvIfuDL1QGIVrhsS3vY7JEcRXMKCpdDjglX2n6YIQE+XBH+/ab5zB3ahRKW5Zg4POINhtxsQHPGklCFa1DdmOlx9xVuM8J8V8Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYafp8HE; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol/EACfva9DBiD/bMVmjmMwvOO8W+Mfblk4RCa5KdpFXF3gffVjlRP7fEkhZE1ZWMEgr+vYZ8M3jvB8NutKkcp1+3lz4JoCS2YXR9Sn/6eo8lNIOuoaQAuhMTTiYrI1Y6eiyclFJAKdCYZGpGPwtMpc3Q5UQYbVqmANrbRz4Ww73BhlgcpUNZZskFwLCPYc8suP8Url3IjYtsxo9LjpyeCRuiTfhfOmOyMu9rMqEJLOd+wJalZyrlfTl2OKhGK6VsDcq1AxRT4z/sXgWKxX4wTZyo9NwlXQvCfE5cTtSGLuWavMh0Lso5t6O6eFn1yOFqwgma/i4NVvhFfFMg+RdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypydnwJzCoPnshjCmWDZZCFm1mDYHA8T196fz/xpN1w=;
 b=DamvOVzMBRtp4QsbMsG3MLOIuxfEEHUO7g7b/vwn/BbntHKXGkuDOzNUGwmiDHE4ucW9H9jXPI53KlraUaR0kAteGeMfjoDBc7TSLVqYctXc4Ul3t/oQvuX/lFFuvvmBXh2NnJaJXf5Yc8Je3LeucBCoA0AVeUeL4itt+ZnbcHcDRtVG2huFeT9kJrQ6UkYJ1Fd7/9bK1YG8z/qcX487E3Q7SWiXtLOe1OPEJ2rQ+YL9vZN+pmo6ys4VbJpJF/ofBD5T3FYeIQ/IOuu45rFTdG2nILV9L6kOkznl9m55wgFdxwdgn4V2Tri3LowjZNwaqRUtsG/q2Vtk5/RPygb9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypydnwJzCoPnshjCmWDZZCFm1mDYHA8T196fz/xpN1w=;
 b=hYafp8HEB0JUugycZvNtY876paYxqOnmWXKq0ejS1KZbMvJRNLFRN9AqYdQitOkbp7RkpWXCrkvstuR6H7+sDt5ntp1tlfqhUnC1NEkk+gkHOfRnwieCD7SIGuwCXzc38CRqjPrqi5c3Ilaeoh2tFFlqEZrySvnF1zeaQtfn9NufPahYd1j/cb3L+IBz78z/RR7dYYZdKiLENOhNNetgCc5lYGp5bYxBrDPu90ZThlDW5rXQFLE6RtzAwDlAVnWms9ps9TLe2CLLQ+zmHOEj4aUzyCHjq0LI6PgPc9uTxLjF/Qi+tU2A6D/W3iFd7V3F/mVplbyyjmSvSqYasfgrxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DBBPR04MB7724.eurprd04.prod.outlook.com (2603:10a6:10:209::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Wed, 10 Sep
 2025 18:52:52 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 18:52:52 +0000
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
Subject: [PATCH v7 net-next 5/6] net: fec: add change_mtu to support dynamic buffer allocation
Date: Wed, 10 Sep 2025 13:52:10 -0500
Message-ID: <20250910185211.721341-6-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910185211.721341-1-shenwei.wang@nxp.com>
References: <20250910185211.721341-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0163.namprd05.prod.outlook.com
 (2603:10b6:a03:339::18) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DBBPR04MB7724:EE_
X-MS-Office365-Filtering-Correlation-Id: de3575ce-f49a-4e32-8b9e-08ddf09b3ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?toT+HSnLPlV27bYz+PNsluk22JHw3XQSOavtCsvvS3N3yz07kevZH4EVF38C?=
 =?us-ascii?Q?YCIetIy/+GleWG9D+6bJopwoLYcVPyHxCBqCtsZea6pIy6X6dO0eQ52aEiIw?=
 =?us-ascii?Q?XTM3+ZcY3V2MJdYbo9QeVmg7S1fi/fSmmPvQsJfhYaN0TeS4iC10VL7BzeK5?=
 =?us-ascii?Q?+eljDhXVENQvP8Ha0W8yD9MY7tW1pra1ZGMsnMt5OXJh37hZ344zXy+JpIQf?=
 =?us-ascii?Q?mxUSyKKN0hLSz7dH04pUtGDarUvy7SoY0BylgcVA2tg/7kPt3YE+DZgtaiJi?=
 =?us-ascii?Q?M03brPbSj9FutKfnJ90QRv9jlFu7loKId2eViYjpcTGk6GyFr0jqRo7eJM3W?=
 =?us-ascii?Q?fFFVhLviQVa/z+/OQv6R2jYjPVP+kkD/e79KqRF/hsYBSmnq28YGjY1HYITQ?=
 =?us-ascii?Q?5uxl7yCQ4qNbkxEmOhCHDvruSZXSdKZJln/x1SQVjtxgKy3gT+6hncoyZsHS?=
 =?us-ascii?Q?gSPSlv0vAG8Ac57GZXzVvxzleJ56tKssgg5lESRxgjCQzq+93K3F3YcPbaRy?=
 =?us-ascii?Q?ecx3jMHodNzW3s5FqDFw27zm/UmZ52JlqPlFTzzqYyvg1uEhrK6EYyi6uYhL?=
 =?us-ascii?Q?5BaeAgABIUyqNpbQMFuX1Pb7HrT6CjS7ik0AUkKsUxAG1iGSOHX3HwNiOp7q?=
 =?us-ascii?Q?fYYRY60bqAPPGpE+McmcuatLQWhZcZ333cKHnmcBvPYmlkFRHC3vtiIZ7YEq?=
 =?us-ascii?Q?NkCLCDWcAcPSVoq2suZvCRpqpIyVgQ980SYDaO9Vw8+HIJ/Zu94fEnc36wT6?=
 =?us-ascii?Q?3q3O3LxcIpd8/gTNfQ9wfGmDYpASk8W6+JONF7ysTOKywb9JTnz970XTa8Iu?=
 =?us-ascii?Q?DwXJQ4y5Tv4n09EJjzAFA5TxP3T16rLYgtMpP/6hz1nyQDhXrZdyQAa5XLvf?=
 =?us-ascii?Q?saTQoDlC2L1zsoEEaT/7Jom1SVa04pN3IKopHRWGlcW9l8PCtierJRplenaE?=
 =?us-ascii?Q?dru+FHYiii972/v0QaS7/2yqvHs8KQYydIxf9p7RZPZT0RQLapaCck6dcJuV?=
 =?us-ascii?Q?Riuv+s8eHnwww+2CMLe0hOGaKlUvxqw4avGlf538uDqZI49qziNj2A/YHR5/?=
 =?us-ascii?Q?A/u4zhqJSt7aWArPNb4ZeC91fHqLAIACLmy7y3C5dc5M1v44qCDbT3Xhmt09?=
 =?us-ascii?Q?wsObCEK059ZNNyKFw7dICnlCoUrEQOmkn/aDfVZPA0EA+4pEDEg3VR7YnVl6?=
 =?us-ascii?Q?o156opc9FQwH2Q5T7KjlQ2QYqv9LeTBY3C8iX9l3HuHx7vqf5FvOev8NHbgn?=
 =?us-ascii?Q?2it+4gPxeJ6J9odTphzSXUCQTeuwkibj/TnSujFVz1tcZr/IjJbG/mZD23Kt?=
 =?us-ascii?Q?Dy0jxbbEsg44ZpMiN9bwzzgJAxWXEjfRXd8c9Ba08FrUhHFI1fw+S6/BAPxT?=
 =?us-ascii?Q?R0ljLG0dEzE/GjBou4eo49f6pUEpKyZzWmZeUMkvoi5kPb7UIdA5alO6zGou?=
 =?us-ascii?Q?7Q8ZVMoBvaFtRWAQekHxwwF10oMzsNrruF81baPxr0n4hlTm4tm7qss4ZhaN?=
 =?us-ascii?Q?4DwBx2oXik6ZPPU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00KXAuEj6CVXjD7PZv+QKKmvuZDAbORyukSHmdDnwiD6r9FaMWLQFIWbnJFo?=
 =?us-ascii?Q?z93LkjBSuBiorAGBecqD3Klwv7ypuhUWmL0IaFbogi6rc9iOebM4DRfPUwgP?=
 =?us-ascii?Q?2GYp1fOtXutGMCv1Mu4MlsQ/bbIuX7DDDCxeVK7xL2/vQYcZf7kiGJbpnvEo?=
 =?us-ascii?Q?vRMcjdCUMCKG5z46o1yXTu9cPBsXRtgl3PzHkZN8LOg9U4ivK0MG9KNiIsde?=
 =?us-ascii?Q?78pc3NY/2NE0y0q2ZgjV4xfZRRasbb76mFQkE0WPMA5pw2T3Xi6i/NqKlfST?=
 =?us-ascii?Q?7pOFxxFTuRRlbCxcDKGCfqgzkQ3GfA0T8Ju6IPvg70nTQE7DbBmYIIFGX1cq?=
 =?us-ascii?Q?95qRmLxUZtSgWXDVurn5FTgCXm7cLIK0gTInsVZcAWRRmd6u8t/4yzh9sitD?=
 =?us-ascii?Q?8mlUUYsW5VZ6dDaBb50WaMVRT+RJTaLicjgRNufatjgv+eln6B6lx454YGnN?=
 =?us-ascii?Q?+P0G+hCaGJ0Z3xvIQeS2zS1o+i3qxbRBo/iH8QaRs5CJYUYV0NdCG6ahvJ8y?=
 =?us-ascii?Q?m2dko9QLjBz9x3v6oEFB130IJHaUX41sFrdWL83KtGk14TcWBSf+ctU7gL4p?=
 =?us-ascii?Q?/8b9IDUWCYvQRFDNJ849VGxN+gBN27x7cfqz69B8u9DsiopOMVH62EKOd+In?=
 =?us-ascii?Q?Tk4TisS3IQv9Fu7aryQkEUmAsNVFwnvmiaxxbg7nXVDFngCIzJoqwt2ZRsZ4?=
 =?us-ascii?Q?bT1dNjdXEcfo0YF9Oy19+H5A+ofdpV3YxlelOuHXxRDEfu/E/KWyQbVZQDnS?=
 =?us-ascii?Q?HVrnbeN03a1Fq5yn0ZxctrPaXRQsAnt4IsLGSUMKyQNzjrXHMQHirwUD1F0z?=
 =?us-ascii?Q?3OZD10RQ2u2YeAfp+LB3YZzzwRh8khQ+X9LVxWM22d6I5hXcTiyevHGTMsBs?=
 =?us-ascii?Q?BJVE/6pPJaepc5D3nfoo8ecDbB+r2htdqsR6Y7gUxz4BfW87x5IzeXQqn7dy?=
 =?us-ascii?Q?HdUwK+lx854QOeQY3y9hqXt4BJbmhNxUp0SeYs4sJJV98xBj1bmzs/qfnSbM?=
 =?us-ascii?Q?Sj1qAkAnJxR4MWtk7saQHZaizJLaKqNz9UuCTlMpOc/fFGG9Gw79n7ahp5Ek?=
 =?us-ascii?Q?Fhy2YUfbKPa9mph0BzgInynMNA2yuZ+IFuMwpnVCfqwhhS4S27NSXVH+0Ld6?=
 =?us-ascii?Q?fM1Rc81zZ/KN6qJA4wyAbDbFY8U3WFjhu57LIGOcIcxBpBq3/Xi+wykt1Wfv?=
 =?us-ascii?Q?J8tlICpeQf0d5vuoIRcL4/BJWyx8zCW1NvqtXD+9DO2eI5KM6dqqhNyxML+C?=
 =?us-ascii?Q?wkd1w3f4blia77/1EKJyR/YhR5+EaHxTGbv4w7+Xn2hWlkD2YMU6gns6mCbS?=
 =?us-ascii?Q?QosHVkwU6NZMZ+H8XS6Sg2sKuTQMv1AxGDNCBbfMjQt4JKHZ0o6+HqIw7ouY?=
 =?us-ascii?Q?8kca6z2SPCa4elfr92jHeztFmp0U7VZTwURaIc2wHRoIDezbW4AtirmjXyxg?=
 =?us-ascii?Q?ya19Ii4Ma9RgJ2XRMOPfLznZkSKv7QIjMFvJwANXrhFvrKhvmyr6pzPeTKfs?=
 =?us-ascii?Q?J4NiEPi8Pvs+uMh/9BGsaf0bYThZsNueasRWSoPEhVyYAGlanTDoB6lC+9GQ?=
 =?us-ascii?Q?DA3kumeTfghqh1n+he8gZ+g27KJwVZhpgfYLFt1f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de3575ce-f49a-4e32-8b9e-08ddf09b3ea1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 18:52:52.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsMAQ8G0pAyMb4cc3pbXAxrrTJr+B+5I8o1KZtej4WShXxYsRjwI8KTkNpePeXeJmYh3Lut1Z5TA/zLSVWSW5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7724

Add a fec_change_mtu() handler to recalculate the pagepool_order based on
the new_mtu value. And update the rx_frame_size accordingly when
pagepool_order changes.

MTU changes are only allowed when the adater is not running.

Reviewed-by: Wei Fang <wei.fang@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  5 +++--
 drivers/net/ethernet/freescale/fec_main.c | 22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index f1032a11aa76..0127cfa5529f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -348,10 +348,11 @@ struct bufdesc_ex {
  * the skbuffer directly.
  */

+#define FEC_DRV_RESERVE_SPACE (XDP_PACKET_HEADROOM + \
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 #define FEC_ENET_XDP_HEADROOM	(XDP_PACKET_HEADROOM)
 #define FEC_ENET_RX_PAGES	256
-#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_ENET_XDP_HEADROOM \
-		- SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+#define FEC_ENET_RX_FRSIZE	(PAGE_SIZE - FEC_DRV_RESERVE_SPACE)
 #define FEC_ENET_RX_FRPPG	(PAGE_SIZE / FEC_ENET_RX_FRSIZE)
 #define RX_RING_SIZE		(FEC_ENET_RX_FRPPG * FEC_ENET_RX_PAGES)
 #define FEC_ENET_TX_FRSIZE	2048
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 96322187a220..7d336d1b2c00 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -470,14 +470,14 @@ fec_enet_create_page_pool(struct fec_enet_private *fep,
 {
 	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
 	struct page_pool_params pp_params = {
-		.order = 0,
+		.order = fep->pagepool_order,
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = size,
 		.nid = dev_to_node(&fep->pdev->dev),
 		.dev = &fep->pdev->dev,
 		.dma_dir = xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE,
 		.offset = FEC_ENET_XDP_HEADROOM,
-		.max_len = FEC_ENET_RX_FRSIZE,
+		.max_len = fep->rx_frame_size,
 	};
 	int err;

@@ -4024,6 +4024,23 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	return fec_ptp_set(ndev, config, extack);
 }

+static int fec_change_mtu(struct net_device *ndev, int new_mtu)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+	int order;
+
+	if (netif_running(ndev))
+		return -EBUSY;
+
+	order = get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN
+			  + FEC_DRV_RESERVE_SPACE);
+	fep->rx_frame_size = (PAGE_SIZE << order) - FEC_DRV_RESERVE_SPACE;
+	fep->pagepool_order = order;
+	WRITE_ONCE(ndev->mtu, new_mtu);
+
+	return 0;
+}
+
 static const struct net_device_ops fec_netdev_ops = {
 	.ndo_open		= fec_enet_open,
 	.ndo_stop		= fec_enet_close,
@@ -4033,6 +4050,7 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
+	.ndo_change_mtu		= fec_change_mtu,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
--
2.43.0


