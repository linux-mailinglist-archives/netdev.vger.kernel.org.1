Return-Path: <netdev+bounces-239800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D6EC6C758
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A60652C61B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E2E7178;
	Wed, 19 Nov 2025 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2cSHOi0"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270232E62D0;
	Wed, 19 Nov 2025 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520681; cv=fail; b=Mn2szB06RmnO3wduyD+/Un+n9DbU+B1cnE/8VTl++/veiQFHxdQ0QcKkHFExidlaB6Rc0yXS/7fgXzRT599TopwjuZvKXfjR+mbMsf3p+8g83eYjJQfA6KGIlez85uK3qphJ2ZAgTOG9YJOI7aFfgdnnv3vUN/E/4J29tHyMxBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520681; c=relaxed/simple;
	bh=uGvjL08Ane/Np0ICOzDD+9niig84XWlRbR5mZj4RRf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4g/TPN20gPUx9PtZViWfGTjGq0+zIBqP3qAhfM5/5pl8BoHd7DnEdjDklX4N5lhnrq3fk5XlIsDHP6o6VDOCVHX0QAcysDdQSrKbzDXhO11LvNG2MKSsFw7NzF4WLPI1VxDcz+gr2c7jESiUNWPg0Bv5Zn/HhdY+uiJWwzxA00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2cSHOi0; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBk49ZyrtzrAeLYiKr2wS58HzpiOSpkrnEiTuRC807m7JL4600jcjn2vvpeYJBRhJQ9Zd2JFM3rlyxa5B50qKiIyLziSdBlvPb2kunidi1nqNfn7TzN+YdM7UW4zhNT5gc1gbDV7ZYDDKK5LVgJyUoaBSMyAzR9KyKdYrWO/X4o1OJwwcaO335UZcYxGcjuFVd7dcRGA5lrWN5PzXOI0lVAhtQICLbVngdOIHE1/GMwON7hSf7oJykFghcC0NHdJeZM3ZuRKmtMLHnDKA4WnpORXbHKnL5HgF2vk3edyPKZlgF9coDqYSHqxb1g+y0ktvYea3oCeZtS6mj/oTSeEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7bBaNV6RlRbfGbdt7edhtGcfEE3i7EggOkjKZky4cA=;
 b=NE3PfCBLZVJYk+j4lEPhLbaJbDQ+VquSUR7QkLZhz6P9TIdnekwvbeDHbEalAMV3zCqaBDqUmviJX5s//INYh41N4iFUKB2YwAjSc23dAAqCXXdGQH0/8T3YdVByQEZ0XrE/yypiD5dHLskNU658AtumDqel2VaW8uPQfScBj6tS7GU/oTl5f30sZCzdnLPwxuS4ZRTVAjPWdN/dxNEVhiZ7BzPiIG9oa8YM9Q2DIBIEf3iprmQesgNRNuKfI3ihQCHsRnpUWd37iy6FBBjmSiyt4vLRv9tCJHdKtz+mIguz7w231g3IkD3zCpUqO5C3oNHiP1ambbRSOewiZBv0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7bBaNV6RlRbfGbdt7edhtGcfEE3i7EggOkjKZky4cA=;
 b=C2cSHOi0lYFQZWwi2uUj8Nb9YuzpfZ1sdprT/F9wk0d56awCVwk7wQLMCRpaelMlAfyuubQQNLvp2JN/MfsbzhtJQ001kR4h1AaBqzWou2K6IKSx7IfmLWUfCRG8TyJf3fgxreKZ441NfTDJhVhNqUEJ240TRiyJxscUpK5vC82b/orrJU7K598CdG53zVwlX2YKSMq4H8eBb4mJ8ZOXd8LmbHYIfezkk+/XkJQmCUAB3nZogjMGjuCj/BTjjCzhkyDTEzo1u1gST/7CmT96RJITmzRc91D3eqs4t/jPV/u8yJEr13QAKmPtPJA4eHaQbowuY8lh6cfMrBbLi6mnQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 19 Nov
 2025 02:51:17 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 02:51:17 +0000
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
Subject: [PATCH v3 net-next 3/5] net: fec: remove struct fec_enet_priv_txrx_info
Date: Wed, 19 Nov 2025 10:51:46 +0800
Message-Id: <20251119025148.2817602-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119025148.2817602-1-wei.fang@nxp.com>
References: <20251119025148.2817602-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: abebc83c-87ee-41b0-5aff-08de27168314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mg2L7Ghes8lyCFvf42XSaQZC3W9375s212dFTsBzxCWBonT5nWHSeo2iaumn?=
 =?us-ascii?Q?6GJQlEQ1hReDRnNdiueCTvJBg8sA5dL0jr0iOyQuh1cCD5NfhKdR98qLQvya?=
 =?us-ascii?Q?oVVy9nn/kBA95I3bRCwHGVztE1DT0si39uKOt7KAis6EM6URdpQ4QxmAti5v?=
 =?us-ascii?Q?rdeBPDy2sNhAAJeIfPQvQBxEuAuro3sHKeQDIKodfErgZ0A3Hha9MreqQGua?=
 =?us-ascii?Q?xjoKyiIMquODg0SwwkXEz7a1GqCP3h55wyPxG+RCGtypAD096WKQEOQaKX+W?=
 =?us-ascii?Q?N+MBGMuqcLqHg+ZkQOm41TAYddrQBHCz5lf4cdF4pBktkVti33n+ty61wmP0?=
 =?us-ascii?Q?nl2ICRVIPdgZHwbZCAEuR0l1bFx0lABrijLADkxO5DXpXSMZqRwEHL+aC8/j?=
 =?us-ascii?Q?hdlmecFDnTqHwYcEVGMKzM6TCppWjjXrFPK/HUVR6NwqfFNhzPUfGv67haRz?=
 =?us-ascii?Q?c9w9VcJJOQBipDnse5upyKKENPApZeXKfxjoPIOsxmfX/5zKR20c8h3X/iJF?=
 =?us-ascii?Q?a6pK06l62mR9KAAYvYeGn96RqQx+LidDP99oO0GyHD/EX8GJ0WmiiWvgUOWK?=
 =?us-ascii?Q?iExKXNjUHKhF2r7n/5kqpfOgrm5jb9aZeYd6vmVUisS1Sx6ZNStpho7HnT1B?=
 =?us-ascii?Q?Ly3WVS+7wqL6wYGrHLLKuCTKg3KEnY7vuPnnjQ5vpJpDWdr1mJoI7DnROIIn?=
 =?us-ascii?Q?Wv7w4AHzv7BVhVqs5RjH6YCiNxaOAuVgvn4gxbB7PN/+whlX4n2bWxW+3SC/?=
 =?us-ascii?Q?nyzjXvl7A3kw7zFiX5vE1T/5Hd6YMBI2HbBJZ+P1beEGyROqQz+YROce0lvj?=
 =?us-ascii?Q?iFFkFVSWODm1K4Mz8/RjWNWrQX/dDcpH7bNtXSXkFqew0NO5qCEG+Ef4aN4M?=
 =?us-ascii?Q?Mmotd8m23aJ2rcKlkNiVxmSR2BZE9m1hA4xj/rcWEm371O4h6Ju7aRwI2IlK?=
 =?us-ascii?Q?AVXu/cDMPhkBdF5tOYNMgOXE8OuM/WgTVYjXF0UoOEsHSpR5M4XLzuTNgMmc?=
 =?us-ascii?Q?B+nZ5l9VVl2SgVskVdyRQCA9Qw+vx7Ld15ZVeKAumEJ4AK4qRgs8QhC0Ppsv?=
 =?us-ascii?Q?+KGOIGxFsx0dIsJnHicmaC9vJKlVCEXOikw/gbo8BR+EOYN8mIkvu8Mncu0D?=
 =?us-ascii?Q?3dDAqE8iJvf9pCdR5lhq1Fqffna5f3ZS3+jsdFOCokcp4XLKcecbnoS/+Hti?=
 =?us-ascii?Q?CA4y1vxa2lHY/vgk/qsjhH4p7bcLDuKgjc+gGwksxy0hoAUFvcQOtQW6qi40?=
 =?us-ascii?Q?8+9F6L0Y+c7+WsPKC5XMyiOcv8lAkIhm8r7ZJRNRiqXzjFuV8wq62UgEKxyV?=
 =?us-ascii?Q?fTV8dcfCjofnCXmFGZzMDFqSmUm1vpNqArerE/S+B+iW7fmGPwSOZkjYm4Mm?=
 =?us-ascii?Q?D0oXLZiI7pa3Qh5ZEMjXrY0bzsr1PyYFMwEvBw9AABH3H1DWEFUxbrFgtq0B?=
 =?us-ascii?Q?n8iIxpTBB+Mtx262GRdOM04yPQN03UiVsA6X2KrGIqUqq6uryXCOGI2xJgGs?=
 =?us-ascii?Q?wQUcJ9q6ugMnQkhWl4yBa6kxaQPDwHnzMYGA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J0S+xNXN0jAtFVL8HXlTfek48HlNp//s5Xydu+3MJcpdbEe1zf4bmU1u9agU?=
 =?us-ascii?Q?ddUllghGanbiRr1EmLhRLdkV+QbQwu7vClOk3vVBwlorIcxCjpbw30oZ2IcG?=
 =?us-ascii?Q?0vTVB7CJsBtS/fC63DfltUTd3yOt6VTTwhtmCBAfmx0PvI3fJL10lkLd+8Jr?=
 =?us-ascii?Q?gMFIL4+0i7z4VO0x8tMeWDH5XIJewSfod9Q5I617Z35yM7Y/3zbxLfJ+il0F?=
 =?us-ascii?Q?eMb0W6fSBOSk8n/OlSNo+E93CqleqQckYW+R7vbQbrI/f/XbEonbigJShcyQ?=
 =?us-ascii?Q?1IckoQc0QvrEdj0u3han+gjsBtdbZkxO6txBOAw8wvUvfKSCUOulOIK299KX?=
 =?us-ascii?Q?GwIQX4LXGPfULFLR7YVnR/wjxnSU/QVvUcKoxDBevtJ/HWPCdjNsGhgjcFhv?=
 =?us-ascii?Q?qjCnLu/Q9lqJQssl5HwyChirGiq8daNJJ681Wl5ICLglG6hQzykmJpDQINFp?=
 =?us-ascii?Q?mbVQhY4phCKIB0rXUabKUmpUQgCvnqw9hhM2rBjfGa6RehE8zLDE0CG9erUo?=
 =?us-ascii?Q?aDCPbUpIdBIW/XLy18y4yjndDHf19yeGQHoxyX1S6b2n4DcBddSCsOIuS/Nc?=
 =?us-ascii?Q?++W2OTPj0NcHJYNcvNVhOVp4d3Jt0nV7fzRsmmxViLE/zu74tUf4LAPucUo7?=
 =?us-ascii?Q?aXrzIRD65ExfPZu3J68CK6fH038aWJlSd3Lo/aRmWft77o5rbdWkQVgtPVaN?=
 =?us-ascii?Q?u0QZEN84mJ6lpPhgRZGwbtiIp6Z1YGYsjd+LI1tgheiY3hJ39Y/ysGz3we0S?=
 =?us-ascii?Q?jG5yfZg3ClcvSWEVbocWEv64P1kZXdTrAapi5IUa1TUQfh3eqw81YAPtX8wP?=
 =?us-ascii?Q?QIm8jW8tnWYebVUrWo8oQ8P+2lKSsbSt8mk8BMv3MRNRyRvwHa9mO0vYEAmA?=
 =?us-ascii?Q?IP5j+Z/KpyGH6HzheC6uZJr2gCANUoWooU3pTruoaA+Jj5P80RC9Q0xaBT4W?=
 =?us-ascii?Q?V+rbE2/sBWYuBMT6/Gor1urn+6WoAk4yTCKM3MX4fqVQDBRvzgD2RE9JJjq3?=
 =?us-ascii?Q?Ls4E+ui+M8Fk34efsMDExTyMHclb19fQ26cngUUw2xR6KIVw3ta9clP/QsHh?=
 =?us-ascii?Q?y6lOSYMMlUmCv0IqrHPX5bZsar7fSXAeAqE5iwqGq/ZLtu0lnIoKklq5EWZP?=
 =?us-ascii?Q?UNRGvqb+dnRL3MRy/2hRqVEQ/yHgKi2nhThMeJiuE8S5ia756NE4hvrJmBHe?=
 =?us-ascii?Q?W7vPQZXKFxxopoyWnfE8cEZflQBcBcgTkB3rAOlHisQuve8jtHJXZXSZML4C?=
 =?us-ascii?Q?PWdubgmyoG0ECFlHb31SIlGD7l3lVeqbOB+WlIxgQpG4yCKlrpJo7Ym3mCyx?=
 =?us-ascii?Q?Ku38npzDIrA3QxC5HI60m1QaX5uQ0MYVJaeahEjBhjY+1IOzHkiHgJmTEe3Q?=
 =?us-ascii?Q?hRwmF0a0WunAVVSL+Pa2XXN/+StBbg9Z6Kr4nwEz0Volt1wNcen3xxuGaLIN?=
 =?us-ascii?Q?NkpYbkWfxjIwA20UQtGfEwWFQEbpxSY2zaEAi4d0iAH7BGKcRSkoc8XvU85x?=
 =?us-ascii?Q?X8aP2Rkv9LlvyA5RtBFR2rBkRbg+R82Fd3yDN0BPY5rznskm1LGvhFAE4Cmz?=
 =?us-ascii?Q?MuPmX3wVUvhM4eyhaVjirodblwsYyxpWIIoQBOrg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abebc83c-87ee-41b0-5aff-08de27168314
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 02:51:17.6713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOScUwsU7Fp8i2dmjQUwwmM2D76pIMTqlqMeAnIBAjEVBpQNWHmRVxBgiY+kn2bkRj7wrlQrRFJH5PljhYfwKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439

The struct fec_enet_priv_txrx_info has three members: offset, page and
skb. The offset is only initialized in the driver and is not used, the
skb is never initialized and used in the driver. The both will not be
used in the future. Therefore, replace struct fec_enet_priv_txrx_info
directly with struct page.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h      |  8 +-------
 drivers/net/ethernet/freescale/fec_main.c | 11 +++++------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 8e438f6e7ec4..c5bbc2c16a4f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -528,12 +528,6 @@ struct bufdesc_prop {
 	unsigned char dsize_log2;
 };
 
-struct fec_enet_priv_txrx_info {
-	int	offset;
-	struct	page *page;
-	struct  sk_buff *skb;
-};
-
 enum {
 	RX_XDP_REDIRECT = 0,
 	RX_XDP_PASS,
@@ -573,7 +567,7 @@ struct fec_enet_priv_tx_q {
 
 struct fec_enet_priv_rx_q {
 	struct bufdesc_prop bd;
-	struct  fec_enet_priv_txrx_info rx_skb_info[RX_RING_SIZE];
+	struct page *rx_buf[RX_RING_SIZE];
 
 	/* page_pool */
 	struct page_pool *page_pool;
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 4193559c6b9c..6c19be0618ae 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1655,8 +1655,7 @@ static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
 	if (unlikely(!new_page))
 		return -ENOMEM;
 
-	rxq->rx_skb_info[index].page = new_page;
-	rxq->rx_skb_info[index].offset = FEC_ENET_XDP_HEADROOM;
+	rxq->rx_buf[index] = new_page;
 	phys_addr = page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADROOM;
 	bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
@@ -1836,7 +1835,7 @@ fec_enet_rx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			ndev->stats.rx_bytes -= 2;
 
 		index = fec_enet_get_bd_index(bdp, &rxq->bd);
-		page = rxq->rx_skb_info[index].page;
+		page = rxq->rx_buf[index];
 		cbd_bufaddr = bdp->cbd_bufaddr;
 		if (fec_enet_update_cbd(rxq, bdp, index)) {
 			ndev->stats.rx_dropped++;
@@ -3312,7 +3311,8 @@ static void fec_enet_free_buffers(struct net_device *ndev)
 	for (q = 0; q < fep->num_rx_queues; q++) {
 		rxq = fep->rx_queue[q];
 		for (i = 0; i < rxq->bd.ring_size; i++)
-			page_pool_put_full_page(rxq->page_pool, rxq->rx_skb_info[i].page, false);
+			page_pool_put_full_page(rxq->page_pool, rxq->rx_buf[i],
+						false);
 
 		for (i = 0; i < XDP_STATS_TOTAL; i++)
 			rxq->stats[i] = 0;
@@ -3446,8 +3446,7 @@ fec_enet_alloc_rxq_buffers(struct net_device *ndev, unsigned int queue)
 		phys_addr = page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
 		bdp->cbd_bufaddr = cpu_to_fec32(phys_addr);
 
-		rxq->rx_skb_info[i].page = page;
-		rxq->rx_skb_info[i].offset = FEC_ENET_XDP_HEADROOM;
+		rxq->rx_buf[i] = page;
 		bdp->cbd_sc = cpu_to_fec16(BD_ENET_RX_EMPTY);
 
 		if (fep->bufdesc_ex) {
-- 
2.34.1


