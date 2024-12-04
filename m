Return-Path: <netdev+bounces-148813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C094F9E333D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 06:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A08CB23442
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D421B187FF4;
	Wed,  4 Dec 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lOxCTEA9"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4BB17DFEC;
	Wed,  4 Dec 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733291132; cv=fail; b=clR47lwo4VAFDfOBV9CD8BNdpAQwSVdUDz7zEYcgxbHA5RihIfheFQEY1RGFZ0KUbdgaqZ3NF48Pqo2WTdORUvS8Ug3lIWmMSdFXsLwSTCkQ/jEk1gVfkX/s8VP+U6b0CWU9ZyjrvW+MZRv5FBCKjMHowQUf1zeL4ZFK1DtN35Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733291132; c=relaxed/simple;
	bh=UU637Nz2LmuLNE4XgZHl96yb03Fc84V/j0GwBuGWOFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o06aB+LikF6XpKja64Q1+GUej67DIKMLH1k69OkV8OJuNyV9o6YiAxmGj26vnp8qy3E4ZCYmVoQuhJJm8lTBkWswRhO/SZYZKYugl3aMcXXw2QY1LECAnDHgQDqnEP08R5TpFo1C/0RT4X6B0iHGFks4jigAYthPODYPUL77z8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lOxCTEA9; arc=fail smtp.client-ip=40.107.247.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jp9GAk4wNybXLwERV4jD+aGCNR0bAZU2ACBqkqmVu9RIYNi/lpDseu80fNSKhbvmfYdAjI//rqFQEe7spNgWjBovoEr/X0W6qMyb7fYmBWRtD65dLfKaaRliIkZiQLBJ1PiiHWjBwU1MAQICmvNrxmsP8biFMpxOWJkvaV36f0RHq0GHn8It/ik63/pX370rtHuRX9nFqCLZBBqGAmW6buLhMisVmWl0OiGxZnfiyZYyvWDn4tRNlspqeclUpw7MTd0c9qz+MPuaNiLhlXZnpxo+5EqY4l/mojioZhfs0WPexMxfXPN7UaCjW4LALh+Kb2C2ykeYcsbGX0qx3oZ1NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80sbB6jq5JQjpdmh5JVuZ+XbeOHGVV9tbDeXnvJQfRg=;
 b=dzW8orawQFil661OmjmwAhYRZxnVXBUxPWoy9H3XQVQ/OtopBBXeCzgx/NuIzcYEwqi6Tgn61xyB4m5EGF9re/Eqthcg9XFQjqtvwGiqxpgTSC9A6ZU3udHBQ2ayYLP3kh2NyoUvCbX4mPwzRWBChzjly0+cFm7OvbKRHtYSVJY5GfxTVdYMjKD6VcdjgAjiViRCBIj8P5Coigbqn/9C6m+zHdnGVvTtzqpub1ol1vOniWBYbf8DeskKBpxFOVO+OZz0WylUVTPthLRenEI3FomVpWycSlan1UGwRG0Z1PXLtxw+GBNqs7IZhJ28OXjw4AdXVv6jtqoiB1n8Noqo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80sbB6jq5JQjpdmh5JVuZ+XbeOHGVV9tbDeXnvJQfRg=;
 b=lOxCTEA9jSHnmfSBMprb05jZ2C/UhSowz/VQDVRZGt0drcGa+fGCK3vi6MQQYOMqPbghH+dEXHSwXts40/3LVpXh1K7q+C9Axf2X4w+ApWHGXKHGB9gMEfZAnC+5s6TvXSgNdIVCCJKU4r1gTmtrnOyUTI1GY21+C1IFY56IAXL7sEajrhyLB81L0wDFS/2D0lDflk2R5Z3uwIrnMVUqGknp7nbuy9u0kX/0G9tm/HtN8STlRtMVOvN87oArkf7Z4DW72GPR2pYuAUUTpdOo8EXwLXd+HmUvW5nY3REIpGChjyl1Irfm4HOy00Yu0F8ZNk6YoGftbselE3Pk1F9Daw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9154.eurprd04.prod.outlook.com (2603:10a6:102:22d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 05:45:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 05:45:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 RESEND net-next 1/5] net: enetc: add Rx checksum offload for i.MX95 ENETC
Date: Wed,  4 Dec 2024 13:29:28 +0800
Message-Id: <20241204052932.112446-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204052932.112446-1-wei.fang@nxp.com>
References: <20241204052932.112446-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 7371782f-c515-4b28-1a5f-08dd1426db72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vfLcg7m3fCkHuxrXTAgojjcompd46lMnsLHOJf4cV6WHYpY9SL+yWqt9VCcB?=
 =?us-ascii?Q?t1gzFZDYDHKdXJ8gpCRXzWdJCL0/YXVvuqE/1KBQZ5nvu6JLMRSvHpHwGqLd?=
 =?us-ascii?Q?7wGyRsKVg+VX0mXr0V8jqTirTs90lRuDzC8I1dBxPFMfNS6Ly3knKi3hPLN+?=
 =?us-ascii?Q?4MaASOpt2Rq49pMcjdcnniZ8iW9vUcQSepbw5y/fc+fINXHz1dqhgRiqMftm?=
 =?us-ascii?Q?4gWCdhl27yrVPIggAwDf5gYJ6EOrO4/KMOlKNO5PRjcxvN9lqH62UgoOvt6u?=
 =?us-ascii?Q?1STU8zVO8HNbNL0yL002h+98syYWUMALPemcGjwF0DhxGnk0tjQYhLdT7oXk?=
 =?us-ascii?Q?4gNrPdVI74VLL3SO12rNGDhTFPW9IWxWnA4yG3XnHwIS70VnHH7Jfc74ZBmj?=
 =?us-ascii?Q?xp8AVQTdGVYqgTTxYBZ9WHB5zzq+QTCvZOwUbqF9S8tIm0x2q3MlmHsOZ+ex?=
 =?us-ascii?Q?riLTnBKIiBgOXseGVxRUdO2FF0EjPjMoTHScfqezXO4T0YJSGgxOyB11YK4M?=
 =?us-ascii?Q?mQb/VbQvIReJwbymanwtAWW3VGevMK2TRGLFS8p9nCxS0aePI13zvTGapUfS?=
 =?us-ascii?Q?uLxXRk991sCUGIKLBc8dxXfmXM9XIABAtgi5a3FDZTfH3ebY67mhKfeByivk?=
 =?us-ascii?Q?jQIW2FPsXCMFJwbSg/Hnoyzgahx3Qui9dpnO1yr+nN9vNI5BCOJ8/xV0cTpl?=
 =?us-ascii?Q?xngt6DATY3npjHsEDUeri56DdmmSoo6Cgx0SFp0ZU4umNNVR2BiDYLPbkvPz?=
 =?us-ascii?Q?9QV4R2kFlIVnw4Ph299RSm4YOqnqupj0nRMsSuR20OMcWRRFaJj14/pcoDlW?=
 =?us-ascii?Q?kHI828YtM8uIWKqA7G7ucp8OfgX1S9GB2Z1NxJ/eO5xS21XORq2GPsIyhzEB?=
 =?us-ascii?Q?6S1hGhGjOASIHwyEWsW72IxOs+Ut4JMLo/YAT+IX5fuCYQgX29fomtogyNZ2?=
 =?us-ascii?Q?dEW3z2A2g54dCmcM4O6swYPATZJW62J66qJ3XIACinGY4Xszs1mRZDclDQpI?=
 =?us-ascii?Q?GSYzwR34jG0mz2NY9iVHFHGbFqB+dOqTBIVbECuKTnnQxyYGV5yN3rBniDaz?=
 =?us-ascii?Q?QfahGL8st+G3dnYcKNZZFAWA+GjIrNodqR5CyC91s6+WviFtrEQZ8P/4okSN?=
 =?us-ascii?Q?5bQcFmt6K9YfhhyY++OyyKsZsxbU/2qj8fXZIW/L5yPhqE+qnSJ3ls86GMQS?=
 =?us-ascii?Q?zjQqsN22D8P5W4iBOlq8KY0RoHTX9RcrkRtq5WEnEY/Ly8eoXNyW4OUOCFmq?=
 =?us-ascii?Q?bgJC/km/W5sjPOJzyPmN/B1kRP10TJhl24DY93bDxGbfTL+JGOY/nFdge339?=
 =?us-ascii?Q?YsppxGwny8qP6N9UuDWro8/eKQYWhFiNNzEJ42mJv8ixpnuA8PxSj5LjUSZG?=
 =?us-ascii?Q?N+hhp6Z8DvrKgJ3VioTNpLH2DpVK+t2pn5pn3ZfBRHPBb6ToKw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S9atHXaSGU1qYvRVZGAch7iREzgqc1HSv2Lf7wSpdb0BS2/4hUUN5YzGjqIL?=
 =?us-ascii?Q?XU5vtp+cEzQHc94TtbRB9Jt4Y5QFhpqxE+G6uEJIn2dcLYD0iEAwO2nTTbAq?=
 =?us-ascii?Q?aNs5x09luzQwy9ithzAMV7lvQ6CjCnfaksitEUtkQSYsHrSICWYA55kfgC5P?=
 =?us-ascii?Q?377/1PAZI0tSNAO8NGvQmVcwBj7bM+FjdPi9hNmItp2osS/QZFkBmjc6jDgQ?=
 =?us-ascii?Q?+BfIDc8vDPXH4F60KFxZg/yN86qKmOFfuQXlMvV8BbcCfwR/7RU0uQQhl+cw?=
 =?us-ascii?Q?020kka90mkOzfo1BfXLZNuq5WY6znO69le53dGfgROReftadb33DVTZRygzZ?=
 =?us-ascii?Q?9fDj+0yC1bHi+y+niqayVY6RQrvfHBkvz7S2nnkCVUmRbESi3wIxdGUXCKQu?=
 =?us-ascii?Q?7YH+3nZzpxgRu0L4fq67oKzqOBKknpt0uX+AiZ6sIjlneKvM7/Ixblqabyfp?=
 =?us-ascii?Q?gRMzDQTUbFayhOXcsFwfTRPEZlPqghk7WoTR+MdSe6TXvNh0Gs6phjZLpTfi?=
 =?us-ascii?Q?jKozQA4cLXv0rlWWxfhJuIJqbb0lFuiSGA93hi2UrZ+NPBAvrO5VtwviqDqg?=
 =?us-ascii?Q?tx/p1q26lk/5p0RclClS70tn8ANicVTxSHf6a5gZjFK5U5haYN6DkD4uryi9?=
 =?us-ascii?Q?O6ZD/hrfwR4yyHWzx26r2YMM6w2Vqgx7BuuJHmE8eyLFNaGVIAxSV4tISvFL?=
 =?us-ascii?Q?7LNs4Rsx/Oj2pxXSc05BqgvdYdJ7LsEOkDN+Ir36OKxXKBONSuOWdozDD9cA?=
 =?us-ascii?Q?pZo9JRcYMwkXxzhu9s37HJpPoiYhkyFR1OjrJThfABL9ncw3WQRUj4wtqccx?=
 =?us-ascii?Q?QQWD5L4U6SbbQlDf7VSdqbi15sb/nPJXa4kR+6xX7gQ4Jugy+qaWk2ugyrFK?=
 =?us-ascii?Q?gWs74Sp5K6UJYZsK1H/Fu7nBVp5WfGhuJWghoCNh6vrwIjruvyKj0X1VYcW8?=
 =?us-ascii?Q?pO+clnnKRCN5f7XmkbfRyaVHE26kgWGYCS9OiYY9gP8IH4oj3qny4zSyU+BE?=
 =?us-ascii?Q?/uGmKviKpcWtcDSNJ+hu0H0dZzwes9GPAtQ1EUleZ2b/aPQ8heetJc9ZAhsp?=
 =?us-ascii?Q?KtgPVUIWejUVvlnhxB1WdHvH/suWCGJk1eOnQG0XTIaD2dkzDpEyeP9hMl4I?=
 =?us-ascii?Q?Gs4NfmFdNfGmvVltfHiFDecQd+lccbJGI48mhVteCouzKWcIOsKGTt7RVmz+?=
 =?us-ascii?Q?LsuHxHwDlaZcF3mUV4N2QNiSSuhpxP7WpyJM5KXRlVA3ke5v0MvFeQPHfJuJ?=
 =?us-ascii?Q?+tNuUf/DEE5DUP6fruiwPkfmQBrL0E7nvr6yIuu3GNQJJfpEEvGQn9oNlkMc?=
 =?us-ascii?Q?Txq4eq/u75m2ORkH7FcJlBenSgvTmGN+5hgC8gyTrFFLljGTqGGr1Vgj54gR?=
 =?us-ascii?Q?hIWy6z9rMEFtO3XzqX0wIe4jWCsU/QnlpjcaipGj/6xz/BRtRkAJJ48aXJQw?=
 =?us-ascii?Q?+hq8a2FnC04PgWkay9CES4e1Riw2szvpgTpjRKRIc8+nKarf8bVu1wlqB3jP?=
 =?us-ascii?Q?SCSks22t9SxanqgPfRGlca0yMPeJZTduOhZe++EslAdnUT5eLrWiA892QIIX?=
 =?us-ascii?Q?J3s3K0lyyVUCvlC4pSloZX+Hb1JmVzoAi59tTuEQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7371782f-c515-4b28-1a5f-08dd1426db72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 05:45:28.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MY+b6AZwK0o2bfcELCE46cxYHOZNDFgOFvgErXB/59w77M/GuCZz/PNQ0u8KCA3FmFso2OJEOQTKLXo/YS+dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9154

ENETC rev 4.1 supports TCP and UDP checksum offload for receive, the bit
108 of the Rx BD will be set if the TCP/UDP checksum is correct. Since
this capability is not defined in register, the rx_csum bit is added to
struct enetc_drvdata to indicate whether the device supports Rx checksum
offload.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: no changes
v4: no changes
v5: no changes
v6: no changes
---
 drivers/net/ethernet/freescale/enetc/enetc.c       | 14 ++++++++++----
 drivers/net/ethernet/freescale/enetc/enetc.h       |  2 ++
 drivers/net/ethernet/freescale/enetc/enetc_hw.h    |  2 ++
 .../net/ethernet/freescale/enetc/enetc_pf_common.c |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 35634c516e26..3137b6ee62d3 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1011,10 +1011,15 @@ static void enetc_get_offloads(struct enetc_bdr *rx_ring,
 
 	/* TODO: hashing */
 	if (rx_ring->ndev->features & NETIF_F_RXCSUM) {
-		u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
-
-		skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
-		skb->ip_summed = CHECKSUM_COMPLETE;
+		if (priv->active_offloads & ENETC_F_RXCSUM &&
+		    le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_L4_CSUM_OK) {
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		} else {
+			u16 inet_csum = le16_to_cpu(rxbd->r.inet_csum);
+
+			skb->csum = csum_unfold((__force __sum16)~htons(inet_csum));
+			skb->ip_summed = CHECKSUM_COMPLETE;
+		}
 	}
 
 	if (le16_to_cpu(rxbd->r.flags) & ENETC_RXBD_FLAG_VLAN) {
@@ -3281,6 +3286,7 @@ static const struct enetc_drvdata enetc_pf_data = {
 static const struct enetc_drvdata enetc4_pf_data = {
 	.sysclk_freq = ENETC_CLK_333M,
 	.pmac_offset = ENETC4_PMAC_OFFSET,
+	.rx_csum = 1,
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 72fa03dbc2dd..5b65f79e05be 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -234,6 +234,7 @@ enum enetc_errata {
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
+	u8 rx_csum:1;
 	u64 sysclk_freq;
 	const struct ethtool_ops *eth_ops;
 };
@@ -341,6 +342,7 @@ enum enetc_active_offloads {
 	ENETC_F_QBV			= BIT(9),
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
+	ENETC_F_RXCSUM			= BIT(12),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 7c3285584f8a..4b8fd1879005 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -645,6 +645,8 @@ union enetc_rx_bd {
 #define ENETC_RXBD_LSTATUS(flags)	((flags) << 16)
 #define ENETC_RXBD_FLAG_VLAN	BIT(9)
 #define ENETC_RXBD_FLAG_TSTMP	BIT(10)
+/* UDP and TCP checksum offload, for ENETC 4.1 and later */
+#define ENETC_RXBD_FLAG_L4_CSUM_OK	BIT(12)
 #define ENETC_RXBD_FLAG_TPID	GENMASK(1, 0)
 
 #define ENETC_MAC_ADDR_FILT_CNT	8 /* # of supported entries per port */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 0eecfc833164..91e79582a541 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -119,6 +119,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->priv_flags |= IFF_UNICAST_FLT;
 
+	if (si->drvdata->rx_csum)
+		priv->active_offloads |= ENETC_F_RXCSUM;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


