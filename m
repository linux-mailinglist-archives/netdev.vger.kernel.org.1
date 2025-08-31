Return-Path: <netdev+bounces-218576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FC4B3D53A
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 23:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FE87AC5BA
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA01E26CE1E;
	Sun, 31 Aug 2025 21:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KL8DhMln"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F643C17;
	Sun, 31 Aug 2025 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756674998; cv=fail; b=ivoAH/Mm5E4oLGTZkjZnb20D90T4ZCEZOEeWHauGcc/UmdbBitNl1sKM1Ml6adRGPL/4CFn6brVGfzHA3bMymU8oqaPN8QVhDJ2MagNq/kPkMjkHhpN8+xLXyR5Wq9WtCXT+ZqSWJheFV+0OlV4Bsx9rdOMnZhf553QNo9AH+Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756674998; c=relaxed/simple;
	bh=FOYor2uuPSV8S+RHskWBDCn+kede5xa4dXyab+5rfbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yqyu76d3X7lRFpI+sNLxDRS7JA6ksnt4sx4XSrmJvdpFI9c6qsthKcV/pLWJKGMaNHcE0JppQxvEr2VI52Wwcw+hjmolvhiJ+D5eoOlhnndH1nBqjsuavr2zzCQ8SR0XFhWg1JXTM9d6g+ugpizHnGmx2NqHy0Kqwqh+SEfI/EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KL8DhMln; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3VTBV6iocs37FCfJLvQo0uB8xsTivukf8vMisXBIhO6nuUAWB42W6mAF+MjNSDwamEOF0hmOfsDvJ5WYlghMdNJz+fXT4jhKPCjQX3O5WlmX7Rn8LS0+hWycvXCZnxSRz2NImOFiv01DHiMVe21VTRxUe0iW+KZWUSns6xq8nsRTL9+p7FsIOSjH/HPWOkIYcYKqjWLFWxeSJyhS6hbIo8Dh9sZUm0xf0gCuqcB14INFXb4SOMUTILh0BD+jLrR36H4VxCD7naoFF1mjtDj7nVPrgfEj+mrpp+ljwk+VoXP9PfDtECll29PKPDG4rQldKxbq7nxK0i2EgU9wJx+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuezJhzR0YGaH5S5CFv85rVip4KJjz/7NPhUIT0CAUU=;
 b=qUj1p5fGlKMbA870XwDr88n5tZctZWClx+mxHNIxMDhNhJ+/cecG2nFgLk4DE/aFH4pMo3wbJCAAScrasBpEmg3Jt6q9GkSvFKOA9rus9Z2S13d/b3Roex8eoLg8YHTqDCCVVskrlNuyjE5eOzCjX4fwKQu49UbA08TxqaV8lFJGH3m1e6ZbHW8WZK9FseegBzouBkjCjxAzrs614xgZfBWYHiBr4cIaxMX9Eu6Dz9kHS9U6Afs2bvbtWqoh63eJgNR70Tv1pPZf3OsGvkUDJHpc4/t9aCC/M3M0CEHqoGnM2emn5ck3MGMujXBKt4fsuFZpwJtTKP0Tq1ydQp6wZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuezJhzR0YGaH5S5CFv85rVip4KJjz/7NPhUIT0CAUU=;
 b=KL8DhMlnxW7twNSUdjF1z5oeJi3oUcGhPDwqszICzo9tdXgLxKL7ULD1nkAry5t2hxqUH+LjG++sj/uYSeF/IrjuMUvLxA4KX+De6SDYR+GvegDlJlVfZKMNukUCkG8SOT6AdbU7m+S8+fmL0imWmb5k8vO+KyuOWCuAIHsErwOOY9whYIB8OhP4TkaPXIMIG5rtia5uF7F+yzjxe9Co7j6VuEcVkO58zZIBWCx8wh8vuoU0tHgO3p424/I+/GYcJDFUFDKUwaeSpaled9yBzgpv1lmmCUaOZ4RxcyJBPG4mV/Aj1QptOCDJlIyzstC7D3ieK3e+RyQ/RSDdhDwW0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB9PR04MB8250.eurprd04.prod.outlook.com (2603:10a6:10:245::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Sun, 31 Aug
 2025 21:16:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9094.015; Sun, 31 Aug 2025
 21:16:33 +0000
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
	linux-imx@nxp.com,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4 net-next 2/5] net: fec: add pagepool_order to support variable page size
Date: Sun, 31 Aug 2025 16:15:54 -0500
Message-ID: <20250831211557.190141-3-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831211557.190141-1-shenwei.wang@nxp.com>
References: <20250831211557.190141-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB9PR04MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 717abf2c-b8c0-492b-eb17-08dde8d3a95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LAO5Cz724icb52HoPvxbylH3xlfJErB1uRZCFLY5rkKDf6d+JUVFCDBzxfcS?=
 =?us-ascii?Q?ET6J/yTI9mfqAem+aDB+pf/q7plaJ7BZcEysIaRHs6zyxtxzVozaxPdqUUCn?=
 =?us-ascii?Q?6ZVtuQZSaL/gX6IFAzJcHHAbPw8jJOYB1bzyS3c9E9AFVBJ6jdybBA+pLUjM?=
 =?us-ascii?Q?oN2V0nd0DBx8+Y3cvwkHLbLmockku49xFR/oTMgxg7fuAwBHvEDU23XaUofF?=
 =?us-ascii?Q?DiX70ZKthNIbIBwkfEr+cLPiese1Vs7zCkP3WvRB5E45U/FGye0Txn/sKIwZ?=
 =?us-ascii?Q?o0i9mwA0Cvg6EeEQIpBUl7odcawtF56YXmYKJ789OdIW0cQTxtC3fXu/XfFC?=
 =?us-ascii?Q?Q+oprtQO4pJbr0fvSTakke1iePuPMLc8XRyz9E/tSVneIFWnwVQSEGT/5gir?=
 =?us-ascii?Q?OiwSye8JKse0GxVoNJyIvRb+PZWk8gUBogKC5AZuEXUFViDVHhXz/rmp/XV8?=
 =?us-ascii?Q?1RNiXdeiNWFZ0POA3bx8geDV3D1L60RkTtLeJlHdwut6w4vBrnaIoGBEyG2I?=
 =?us-ascii?Q?U/yGuPWptY+GaegYTYj2rkS+RV33MEa7hKGu8qd+Sw61Si2E7UwwkENeM/YN?=
 =?us-ascii?Q?2c2rMcSOVRYF5pnxDTYNUELRo0EKLu4dfoThZoU4iBrIKTaFc96EVV8/RNIU?=
 =?us-ascii?Q?3+WoUZhLCYCwJl9ZWxwy1tqhSk9edeZeGsY5/Rs+W8ShlmJv2bHl2A1UjCXN?=
 =?us-ascii?Q?FJ+WRgd7NptDmQXfmg+rnk5/4bgIrNAIvNPCW4QYFduOfvWXePyKat4Osly5?=
 =?us-ascii?Q?MWmmhzOtWoa4Iirn1F/sVoU1IemA2cOP8a70RU/7kBl5AGa5iNezc683TmCS?=
 =?us-ascii?Q?hbcAOp03a1kX7QzKlQ3Ss6Om5eObtEBGrm5z0PO6m75LP9g358WOSBnKxzcD?=
 =?us-ascii?Q?Ltl3YPK6vX46FFtgSqUnSUSRhWpdURg2EvinXvqRoWJcHitnMARR+CVQ5OCw?=
 =?us-ascii?Q?8OYr15xop3g5tpdwpS05Ku40CFn5+B0qJr1DYW04mp3Zvi+ss4oYmA7f2/cV?=
 =?us-ascii?Q?q5sBZP5n2XY8ENQQzZ9iF225NIJJjnKQpMIc4ouyZSz+ctqaZoa3JshWkvPV?=
 =?us-ascii?Q?xvIoKs7J1TCObkKOd1ymex7x80jHZ9PJGOsaJu84L2yT5PMzG7BuH86G+QYY?=
 =?us-ascii?Q?jpGM+ZJTlphomKbd4+T7K+boU7q2QBGBMtBiunhrPkl/C2ujHsGQSx8MCvjc?=
 =?us-ascii?Q?MLcwbObBteojDH3n0XqyGyC1Jp2KoXiCJxqek5JBvByzihcgrxNvthJpkORT?=
 =?us-ascii?Q?locz7pbul593Gc4MSUO//LTV18cteAPcK9KSJFpe5M0Ay9jlEA7J83F9VhVi?=
 =?us-ascii?Q?W7/XofVeGm/es6AiVEbceiSizzUhO8NpFmhRv5PduUa6LXw2gTWAvq8Kty3A?=
 =?us-ascii?Q?i7LR01fV0Dh/UY2UadWY+z5c6l0UMimJpqo/EDW4ZeQhhWk6EbZJo0JCSk0c?=
 =?us-ascii?Q?hjkOK5C3XZS6rwjeeRUZDaQWRL4D3NNbRajNfLZoylP3w0o6CIxotBpO2A5z?=
 =?us-ascii?Q?fbzYSIsnRgaFDsU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?36Ma48xnK4C5ayQ0RXi10Bg525P4A3CDaPZEovxFt9gvs5IPkoYHtVFQIHqA?=
 =?us-ascii?Q?fS7328aLgZZLwHjqhvIHXOatr3mkNECcHJLWE1Lx6ysic5e1JdFIzsHzzx4f?=
 =?us-ascii?Q?nw/1CbFN50unydVCWkj1ZPUfNjOcATUDTxKuOWCYz9YxmX9wFP/pnP5BicW4?=
 =?us-ascii?Q?y9arRtD9CXugDn3TkjlX9V7FmEDniJoRzvmL2wsOKhQcm3S9yGq/IuDlowRT?=
 =?us-ascii?Q?NZ0LwklaM/MEmNav1EpcdJz2xVnT9VTXfieZe5hsrok4Wfm6KAD8DIL3cvXG?=
 =?us-ascii?Q?j8hmihkKyb+jgpjcPt4sWXoltV/+lvtodHTeFsYcqwo+k2YVHmqQexuwFzZo?=
 =?us-ascii?Q?vm5+Pdx1xeXTxJ0UEBNpMpNqiVlxx2ZeK+vaWdKowpBeKBncQmKLdwQwOl7d?=
 =?us-ascii?Q?BHMIMoiOyLMuqYAtSv+QG8UNAnULcVWVeUCsQGySUfGd2EgwlFsvUj4b24at?=
 =?us-ascii?Q?BsguJk2evtp40Q2MxL9nIRTPFFw2qb8+rQYhky0wNdwGE5oTyP0jIZhq2yjh?=
 =?us-ascii?Q?Pf0sE5hwD5OhGm0PTQQBg3we9kAkeV8OMpSHWmHufiEgW0tTF9JTPO6pgbXq?=
 =?us-ascii?Q?8IJI2wbsanvgHQTFM45D95juufLZZLLl4u/tV8/bnne3B7BQW6+xeasyjh8o?=
 =?us-ascii?Q?wnLPjEfiV2jdb+6PWseCUXeK4alV2gPHuRNJAfjmyuBiBiJiiTQOIdqN/sM0?=
 =?us-ascii?Q?g4YI17cVCBw6Rgh/bnOa04O+WW3jCuOepp5rr+IHSBjSs/p/kecqb6s52zLS?=
 =?us-ascii?Q?ixoWB/UmryCAFGRA8Qm6QLwnr7dIWguFPZBzNXawBTKrCu90gJDuSBBQJEzF?=
 =?us-ascii?Q?4+m5nDg9NpC26cYC6ZalpNotWUcAdUWxdL89+o57Wvpkz7qwe7QuYhQ8eQeG?=
 =?us-ascii?Q?hJO12RZIar9/cd7z+J/JOVI1OpaiVTJ+5QOJIscubfNFAXfh+f0gGKDwP/GQ?=
 =?us-ascii?Q?IZy5PtKva1vcPQiUSo02q/+GeWObTaYr2xM1CrK5iXvcskkYBTKMQUbd3ni6?=
 =?us-ascii?Q?wa01fsZ5ek1nSsqHfXnHxIdVdsB+6Z1hv4W2bAZamP9UND0Lz93FrYWwYWxW?=
 =?us-ascii?Q?qP2n/6JW5Pw34zT2EIavlomaOfb+tnmsKkCsgoeGgQfmKhX+fiGycK8Z1SjI?=
 =?us-ascii?Q?MgcN6V1aqUkYsYgNueNLpvs+uLmmx+m2TYzsgw1F1RCNoxI8L8opXPCW0BJT?=
 =?us-ascii?Q?LQ1+J8m1f+C1UrLWtdDEwiPl7ptCKo7ywvj8T//Ljt7hHaOXlJPiEv9bSEHx?=
 =?us-ascii?Q?yhTh7VZfkkWUN+DTVHwjGGtSELLiJhMGkYHIHmerxEzk397sctpoSGSas7hr?=
 =?us-ascii?Q?5Ycs5iAQz5b7R5DQKR3fc15sbWufi1c0bM81mjxdNGme/jIOQrnsEMo7hnzV?=
 =?us-ascii?Q?+g+meoeF+KvV1PpDVFjnaTjO2nhGDj5fHQj53A5jy5OwcHw6G9t+KYk+ZQ18?=
 =?us-ascii?Q?3bVyFNNgwMm2iTooHUBCGJeLOcrp0AGOVIt8nCI53K7t1WaB3m4uoabziw+2?=
 =?us-ascii?Q?q1FMtIBRSn2SSuQzhDm/lLUGRxfKYrU5gQByeaTtD0XqvTcxzt1OHxoJtFNh?=
 =?us-ascii?Q?h4tBXBGOclv0/sO2GVu/Y1iip8kIbDU9tnXwk/6C?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717abf2c-b8c0-492b-eb17-08dde8d3a95c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 21:16:33.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ok2fmVAS9yix241bPZ6SD2VcmmbZwTU1Du+kM4G0EjngEfpKG9mGeSxBBl2o+FEf78VCsYOP2qJDoS3o7SMXkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8250

Add a new pagepool_order member in the fec_enet_private struct
to allow dynamic configuration of page size for an instance. This
change clears the hardcoded page size assumptions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

---
 drivers/net/ethernet/freescale/fec.h      | 1 +
 drivers/net/ethernet/freescale/fec_main.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 2969088dda09..47317346b2f3 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -620,6 +620,7 @@ struct fec_enet_private {
 	unsigned int total_tx_ring_size;
 	unsigned int total_rx_ring_size;
 	unsigned int max_buf_size;
+	unsigned int pagepool_order;

 	struct	platform_device *pdev;

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 5a21000aca59..f046d32a62fb 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1780,7 +1780,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 	 * These get messed up if we get called due to a busy condition.
 	 */
 	bdp = rxq->bd.cur;
-	xdp_init_buff(&xdp, PAGE_SIZE, &rxq->xdp_rxq);
+	xdp_init_buff(&xdp, (PAGE_SIZE << fep->pagepool_order), &rxq->xdp_rxq);

 	while (!((status = fec16_to_cpu(bdp->cbd_sc)) & BD_ENET_RX_EMPTY)) {

@@ -1850,7 +1850,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 		 * include that when passing upstream as it messes up
 		 * bridging applications.
 		 */
-		skb = build_skb(page_address(page), PAGE_SIZE);
+		skb = build_skb(page_address(page), (PAGE_SIZE << fep->pagepool_order));
 		if (unlikely(!skb)) {
 			page_pool_recycle_direct(rxq->page_pool, page);
 			ndev->stats.rx_dropped++;
@@ -4559,6 +4559,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_clk_enable(ndev, false);
 	pinctrl_pm_select_sleep_state(&pdev->dev);

+	fep->pagepool_order = 0;
 	fep->max_buf_size = PKT_MAXBUF_SIZE;
 	ndev->max_mtu = fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;

--
2.43.0


