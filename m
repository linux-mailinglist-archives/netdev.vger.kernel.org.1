Return-Path: <netdev+bounces-239076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C994C63800
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802DC3B1E19
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D22329E54;
	Mon, 17 Nov 2025 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CEYcsOZI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013055.outbound.protection.outlook.com [52.101.72.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B8329C75;
	Mon, 17 Nov 2025 10:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374742; cv=fail; b=jX75fhpZh6zw4Wb+p6r6BG8dkNiX1n9cZajcsvYg4NCIDM5Kfyg+x5pk0+f80JVT06xP2ycp+aaRMpVtJhI/f7RPDWLEYEY1m8EL3mFDzFTu9p/Kzzypm+Ngx/iQu5GNhKlNhRpWKiYNjNnXH/rzmOsqvN31fK8Hb/PJUWFM45g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374742; c=relaxed/simple;
	bh=Bfs5YyyQ07QuOb5YIGyR9vYSO9rinWnqbt4EQ9I09pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQIi0qseKcFTuRZBjdv4E67XCrw5KICq9JIEsJK9UGzfOQ352JR2EK6BcyH56p5uNyBj3MiDqAAntaXFQcOuQr9ysMjVlbNtfUKIQyQ1QhFpVh5oU9Z3zS4cq1kaXaiuW5fNH3iCg1JBojnCFJwtqH5p0GtQG1BlIca8lhzMUdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CEYcsOZI; arc=fail smtp.client-ip=52.101.72.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+YzJsdcveZ/Sj5vfl+Tj0FfrIg/86hLzsDvtFPa0uHemdbamnftI/KhX4Vq5tspOSQSfbLXBTQfQvOWZbZGl4enyDE5omBN+aimbg+XGX+VzBZAN33Bz4IDT9vuLA6q9nF6ESfnr5MRWrjQD+hr2rQhR/+3RkQ768kWBZzcVjY4WPRp3QyqEhKe6DNIb9XtUH0ZN4mzfFIH4fUmU+1GOMIG7v1YugfMeZGbBIEKRp4TFWdN/eC1UM0pMirXwRaB4TcApDSzyyjy2PPu/Jss6RfEz25P8JMyTnc7USQEXbF6jozZ6r7kGKJYiDy6tLFVAqD5SqJEuZtwp0a2agSBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpAAxXYCAD7Bg//zxc3rukZJ3sWwswCFgw2lVEP+gIQ=;
 b=i2kHToLWWvVX5qwTgXS7hL6Gqn+o7nvxWDildlRWGkQ3/vl29M/X8EDp+injQrLXLNEQNjjjRnhcIFVgBkEPohVaX9QbumWDJOjdTOQ+1lh6dgQGrJtABsTUQisMJ6ztwOZnnN5Li7oiHjijfuJNSN/ylK+bV3QfDU4kM8o37RCOYmkaAnYd8xF18GrklfAWIJd+2aBDhKVpUFAs6tADEF3QL1CDxkD0SvYp1PhVC62tIbdh7IkjcQ7YVDMQWcYW9E6i0Ks1uv2GCFnoku094c0IqnSPLllVjM4etvN5/Whe+d7SNEdDXfAqigMPZhUqea5bas0IC6bSdvES4Dp6bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpAAxXYCAD7Bg//zxc3rukZJ3sWwswCFgw2lVEP+gIQ=;
 b=CEYcsOZIaGqbJnCxVbQ+ny/UN0DR/JUVlTXl+/KyFbpUzQ4JSsS4Fdg1+eYUXGruHa+/Ut+7hipvLE7fF9zol4znlhhPQdC+eBvrqtlgxJPpg3YpViBJfOubiqeFEyEuTSVVM8NaiW1FFNQQz2N4YCi2mlYZ1P6RI6wqD9wzRjRzteVrxKhYQJvlaQ1E3aq7t9+LEeWBf/7U0NvCaKihlhxzHOYd5PPRiEbq57A5QIf50MHvmmWiYytlCp+VigU4BBpRxNxJVWrf7WOfG7jsnzKsdydD+F1c3P3qXBiZtu5rRoeUXO45geziBDWFCdkshCk/suFzQeoP1XOac5uFGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB7011.eurprd04.prod.outlook.com (2603:10a6:208:193::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 10:18:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 10:18:57 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	eric@nelint.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 4/5] net: fec: remove rx_align from fec_enet_private
Date: Mon, 17 Nov 2025 18:19:20 +0800
Message-Id: <20251117101921.1862427-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251117101921.1862427-1-wei.fang@nxp.com>
References: <20251117101921.1862427-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM0PR04MB7011:EE_
X-MS-Office365-Filtering-Correlation-Id: 885ac2ca-6752-45ba-1754-08de25c2b813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0p6j/Sgl78I2a1LilvtCWmeHLNAjEUf5Zwi2cs7JwvBuQRS8XpQIuF+iRz7?=
 =?us-ascii?Q?agjmBt/CrzfTGmeYeyje/m4Sn+oOH6WOCVaLXVDf+yT8RsnacjflaBnaLAxV?=
 =?us-ascii?Q?1DVSvRmL8eKESh4+x0HhOncEDrIcCFpVDPYFUtzXQfjdnI15VI8azuDyzPvW?=
 =?us-ascii?Q?ga2nsq6wWKXz+ftRdEmwxBjREYMg8O+B8mK+3A0jeHTdRzT5WtpIVjlpU1XX?=
 =?us-ascii?Q?2cFgXPTxIhVFeoAqgu3/iZdVz2OH7dP9gjfGUiC5t8pqGKVXubcum1JD4GRy?=
 =?us-ascii?Q?HagOhzuFxGjhnRsmu/pgZoaXHxD9x4PQkN8QDeMSbZAXlsRIyrNOUOu+OY1t?=
 =?us-ascii?Q?HAKe1MBNTnjQmRohuVUN4UBqsm2RaPClo+gHIG4z60NNgr/Xe6rRSW82hXP/?=
 =?us-ascii?Q?tc7mLQZPSSZvb9tJQlfInOA4QYiGSjDXNXDxpWaTuyQB+BXprUnbQPKIPCfp?=
 =?us-ascii?Q?OsKxWggBj0KDrvSqxEW9qLRBt9anmTvrnrsonexYFL32bOY7HXDHpVxmazY+?=
 =?us-ascii?Q?jo90P7kGHbBF6RD5aJYg0Rcj2Lc5Q0iClWs9Q594da34/DYxOCuVWx2zm2dW?=
 =?us-ascii?Q?zam5znDUJIG4Fg1Z81DLRStopJn1KsqPQSDj84z+EvYbT2ggQP7pHsQe6uML?=
 =?us-ascii?Q?Tm4IiMFmZLHUqqKPNPM1kFcqN1Lx2m2JdH7YD78tnskf60nlrdyfkDr63tte?=
 =?us-ascii?Q?b2b748H7Mfs8V4QNxouAgXYokI6hM92ACRMjk9/f5nuLe4GCiyfwHWwNMtaz?=
 =?us-ascii?Q?ZL1mJwhT7Uc9WF/2ob3MGsTovnU0bPBEWQOoda8NuYZoUahQ8oT407oSn8uO?=
 =?us-ascii?Q?yl+H9RnKWz9Cib5KKPUQ5HBPhqmJNMv2B0VKdv5xIvWzxXqEwKiF00RQNdta?=
 =?us-ascii?Q?3stbSArqi9/XvZeE7mHVvtkwAB6gNmFuor+p3fiMTnr0sw/Z2AfpBBMc3I71?=
 =?us-ascii?Q?BlHATYsnOL4UQfTWD1fcDKIjXg2BVYnkc8x5FMf2rSNbD4NqWzD8L1yutrrw?=
 =?us-ascii?Q?HTF1EnsspF3PNBzupHgNOGWFOpJT8q4+x6hmVKynsHGqxTOhRrHtlt8RLFbp?=
 =?us-ascii?Q?6i96IqkAmjwRhfeTL1UZTJ0kndjVSkjPDaCt49UtSDFBzgNVzwcfwi+Akl4C?=
 =?us-ascii?Q?VAOdPq4eu0xFcCTEmpr98c8IbmeGLO28ZfIfYLsdBK4iYyl0fJsNNL/fweBS?=
 =?us-ascii?Q?BD9V2Z6vYrmX7vQk+LKbRyAAF5nnfbELcdVpigqDYKhvgk/PnneP1XiRKwbt?=
 =?us-ascii?Q?AERrR27OgwhaNfkCLEnpsgnpsmx6/JyfLaczVRxy+4ILGjkLBcdHExST6iAo?=
 =?us-ascii?Q?Vcwr231P5o7lKnlmkRXw7qVLAuHusB9wIV2MpLmp80exKClUker7NaDFLyQR?=
 =?us-ascii?Q?KZ2U6stcD99F1NGv+msn4eJtrjpW4bi2EBrtq2oCXoB+I8uN16dII0X+Ew/u?=
 =?us-ascii?Q?eQg/r3/BXSzqj/w4cIbU/twsltkdC8RYC+aLosQ2TAUO1tUteq820Oak1izR?=
 =?us-ascii?Q?uY6U6AF960MXNQFlenOElo8WSp2kjL8mdDh7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ATGHvMJFBn1tI8mfLYDzR/tYQ3yY+BjaCBZU2X0cWKPhs5Us3jJkEIoUyhiX?=
 =?us-ascii?Q?sPDyMYEvmIZgk1x9qYCfC0JvY0Oc5/pnTGX++bA9g7Z3siSTo7qLHbeq4pnI?=
 =?us-ascii?Q?aOqUYWJ4LuWyVeJoaj1xtXuUkyqB7+9cMPONfxljiybVC0OrKN/dGiKdcDt6?=
 =?us-ascii?Q?L7ZN8QBfMYNLlfzftkqzXmXQgIaNKcKjnV04XAvsH/LDnToSCoWkzmdfkJs9?=
 =?us-ascii?Q?TOAQJFpKdm93VMEQqREMQyIpQ+KyaomnF/WcyAbhsaisDZFKBzfsfaMf6ni1?=
 =?us-ascii?Q?U5y6OgLGbAES1cUgpdMbnB/nfjtoclP+yhTp/9ZBmJx/Z9/32pLm3TB5DUed?=
 =?us-ascii?Q?aktyCVdLkvpg7qDAnZVjc0/zl5LCQVEPh/4uUjSk2yVeu/dMonMkAyhR1+Lw?=
 =?us-ascii?Q?+V7GVqZCH9FWKKhxghvxOcfgm4v5zXHV370V7A+FEVPc63+5wyGjCgtgBVrv?=
 =?us-ascii?Q?Hl+tXlKRz8qKg6SA3t59gdBwtCMcJHP9rUyrzwHTrqAwzBzQjMvuc2lQrJzZ?=
 =?us-ascii?Q?nrsnk2ZoD3oVGuMRTBYpbfqK3tN1FaNTNzmpIZt8r6ZNWI6QTwF2gC2wzVr+?=
 =?us-ascii?Q?I72KSw/cdmrI/2ocXE9zk3R0TLgVMOkXXx998Pfy2LYwqZhZCoP3/knDkxWz?=
 =?us-ascii?Q?trHXSj1d9UNuUpES0zHqwXp3VoZx1PTGzq6dC06iS2fH6nvFmDXgjBZHVNZX?=
 =?us-ascii?Q?rU4lIslsY9haep/tmPi3uLXXxhcfscVcJPobP2SzqW5JG4WSYIVZ/jKq9m1P?=
 =?us-ascii?Q?ZialNBGT1KGlLvSPTi2YUDDsmnPeGZ9NpZ8COFn6mPekoKK/EFZvDK1OGIl9?=
 =?us-ascii?Q?BLPQhJi6RFiLsVQ51MZdUAivYXvJvIadZ0dt+G0RLRid0ROi0y+ACKP5md5K?=
 =?us-ascii?Q?l5Sp1LUtfOkdChPwxKJ6diiNj0hZd0S5cpOPImcQoUmZL0coNFPb9MN6OEh5?=
 =?us-ascii?Q?ZbFT95ABxHIYgJ1TRCPb31mRUNuUJZrRdJoQujSg6GRg5wNvKWUfRaIfSOHU?=
 =?us-ascii?Q?/KTh71QJUXOXQLpA6a5EgsW/U5vSpMCMPtluOPMYRKVb41DimnXYIg9lVtDr?=
 =?us-ascii?Q?Gp38/jwcqxxCZ7pqSn5h3bGQXAqZ2E9xWO+IrD2nxFkEDkbWBF6ab1xhY8WK?=
 =?us-ascii?Q?7uI1VVGFptWT336fyuP3UP8I6gYD1N+FAnmfPc7ZVZ9PVUh6zRK2PGqK+5sw?=
 =?us-ascii?Q?cgPtkYXpDQz1afKjA2m2+q93e/JBitaYfWVGQoYzQF/KSUV/LrlwlX549zPE?=
 =?us-ascii?Q?jSJhMBiXDOSUmSJRqdFYNjDJMbX3IvCfJYh+Q39Gdmd21yZnJeZl/t6mOEEo?=
 =?us-ascii?Q?Vbz7qkE8GdzQofWQyRVUnFZ831rhlhm7pPaT03fUw0rmoy6ghGN+4P6Drgxb?=
 =?us-ascii?Q?ZdyvEUNJ4W1UBrBowE2lw+nyXByxL2gGByp3fw5vDWhVe8yGzGUIF0czSUJ1?=
 =?us-ascii?Q?bPzgnKYmpbGM8+vp38R9H1q4YfKRU9m/oVzlGDJ9D/kChEKu5H8SOQ03H6ZD?=
 =?us-ascii?Q?NRXFK3PZGfpGPQ9R5+axrLeFGH1Pjd3vSFPm8Xp6IqlK84W9P/RcrDMJfeRS?=
 =?us-ascii?Q?Y7Zr4arrNgJldUi7mC9PJvvjnUX2oqhCqfZwtnVl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885ac2ca-6752-45ba-1754-08de25c2b813
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 10:18:57.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENJsOwD4GimSVBiSRSCiPDY1ZnuDzNFrpb3ium4RES/NGJTCQUF4S5ezTDcigmTTKtq4ostcEcgJEAXi7A/NQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7011

The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: change
FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
requires RX buffer must be 64 bytes alignment.

Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
buffers"), the address of the RX buffer is always the page address plus
FEC_ENET_XDP_HEADROOM which is 256 bytes, so the RX buffer is always
64-byte aligned. Therefore, rx_align has no effect since that commit,
and we can safely remove it.

In addition, to prevent future modifications to FEC_ENET_XDP_HEADROOM,
a BUILD_BUG_ON() test has been added to the driver, which ensures that
FEC_ENET_XDP_HEADROOM provides the required alignment.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index c5bbc2c16a4f..a25dca9c7d71 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -660,7 +660,6 @@ struct fec_enet_private {
 	struct pm_qos_request pm_qos_req;
 
 	unsigned int tx_align;
-	unsigned int rx_align;
 
 	/* hw interrupt coalesce */
 	unsigned int rx_pkts_itr;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1408e3e6650a..785bae8e1699 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3435,6 +3435,19 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		return err;
 	}
 
+	/* Some platforms require the RX buffer must be 64 bytes alignment.
+	 * Some platforms require 16 bytes alignment. And some platforms
+	 * require 4 bytes alignment. But since the page pool have been
+	 * introduced into the driver, the address of RX buffer is always
+	 * the page address plus FEC_ENET_XDP_HEADROOM, and
+	 * FEC_ENET_XDP_HEADROOM is 256 bytes. Therefore, this address can
+	 * satisfy all platforms. To prevent future modifications to
+	 * FEC_ENET_XDP_HEADROOM from ignoring this hardware limitation, a
+	 * BUILD_BUG_ON() test has been added, which ensures that
+	 * FEC_ENET_XDP_HEADROOM provides the required alignment.
+	 */
+	BUILD_BUG_ON(FEC_ENET_XDP_HEADROOM & 0x3f);
+
 	for (i = 0; i < rxq->bd.ring_size; i++) {
 		page = page_pool_dev_alloc_pages(rxq->page_pool);
 		if (!page)
@@ -4069,10 +4082,8 @@ static int fec_enet_init(struct net_device *ndev)
 
 	WARN_ON(dsize != (1 << dsize_log2));
 #if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
-	fep->rx_align = 0xf;
 	fep->tx_align = 0xf;
 #else
-	fep->rx_align = 0x3;
 	fep->tx_align = 0x3;
 #endif
 	fep->rx_pkts_itr = FEC_ITR_ICFT_DEFAULT;
@@ -4161,10 +4172,8 @@ static int fec_enet_init(struct net_device *ndev)
 		fep->csum_flags |= FLAG_RX_CSUM_ENABLED;
 	}
 
-	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
+	if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES)
 		fep->tx_align = 0;
-		fep->rx_align = 0x3f;
-	}
 
 	ndev->hw_features = ndev->features;
 
-- 
2.34.1


