Return-Path: <netdev+bounces-224704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D9DB88839
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23E45A0BBE
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2357306B1E;
	Fri, 19 Sep 2025 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lFTRDnoE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7452F1FE3;
	Fri, 19 Sep 2025 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272829; cv=fail; b=nOlC5f8mUiC1mx8WtE2D2FtIY6hz+C/3HzmektwHznYyRmS0ISkaQwxm2amRDDDA5C+AbvWlqYbonXfihbcDNHhALa9R0RyLJM664xB7JMaRbqp7iHnPlUQXa6hdFSmSNBXmabEcmGHfrSEb2lrpGwIDeXb0CE833abyA+387Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272829; c=relaxed/simple;
	bh=7rMngVrKtorlCuw8EWviuClWhCcyUeLQ1O1Q5y83/G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qlDBB6kXdBDdPwg9ksn+LAK3PSMp+Zd5o8yt1cpRdjPMvrhSuWq13N11+JYZQlfVwB+3CnAJBNNVQ6rDDWObIvOpNSUT0QZZteFSFQmwIAr6cq+R1FwNUW3cNPLU1CTHPa5Xi3eUZeBv8lFJn0J0ZHpWKhZguyDa73czrmrmVMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lFTRDnoE; arc=fail smtp.client-ip=52.101.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+g7B1eaU/+oiqvir0H7ycJARYiSkxZ3GU9VVCkMmLXGWpc9DaYzfcGCiy+jwIbxbdF9gE3BAuicO3pKMlvSbtkHtQbNI6Pj+VEEdZauuFRWll8tLsEkhSujbEjGnhoHQRkcWr/zltqCDzPUC5EW8+3sTFXvkiJ+AHcWYzvin1/Q4a93tkZenAe4SetaBDtXJs+Z5mwAMKc/LECQL7ugVE0EGFue1HtK2bkav/SmN/7rnTg8VN7lu8wvtUy3LywXoZjsWeuXizzGJb9XfnNFbChFteyn4YQstjbLgUwSA552wwF8yHl85esCZ4AIWYgzRYwTwSSsbsepdwk8vVpVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVAgphrL6HcvhXG0pWEb1CySBVY7GlHdlM3bLp5YxPM=;
 b=qRD4D4ZaeeDvTfhlBOrzmICKdVu5ucDlttdbbjbSCiTKC7Aj42XHD+MhhxUXZ8PXquq5t5xSdxL1LP70rPJD2ATAl/pQkF73rUGkCqcY0URfO9oc8WMTIHFO6V9JcisIMs3j9M23cZb3FMvMeDLU/aFTd+M9Ruk6AL9arywmqxY2d2fLb4xhs18Vb6EBbKtQCth/iDtE0tigbtk6t/NZo/cvxThwXCmRQSuyhWbcA06OLQnN1uviCh8kwaHSr0Xwlp4sOvHjDQ0O8AXgP79RaKGaUx2EeFZG7K4v1DAz5XkieTogeKM6LvmL5b+6D5Sd56LcFfYkLjt5gBPNoF2UFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVAgphrL6HcvhXG0pWEb1CySBVY7GlHdlM3bLp5YxPM=;
 b=lFTRDnoEsWl94biadYOSs6pUF884Bfq9UwAnk5O4GtcONOGt0IvjJwsm7RywDqZ1Zg4ci7OXqS5VCcLn+86Be29yKAM3pwzLBZVG1+PnGyeqYlWN92hH5YfeEFFLJu4B3WpEP3LJ/yOXWWqY2nnAMpmgs6x9LkiAyIJY3n4KXemD1GBXOzKm5PPgDurpAbpZ7sDVmwM2yLUy6gGVo/Z2/wC22dE5OQNX8FuoGKwSDCECE7AWAdSlAShUvasRwpTkUV/F1Cqbxtv32LMEboKCe2E3KILmTpXrJVa23Im3ZhT4GdFtu86HmdAJ9+x81e14lf+t9PBP26VrJgTn/S5gDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS4PR04MB9713.eurprd04.prod.outlook.com (2603:10a6:20b:4f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 09:07:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 09:07:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	yangbo.lu@nxp.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Frank.Li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 2/2] net: enetc: use generic interfaces to get phc_index for ENETC v1
Date: Fri, 19 Sep 2025 16:45:09 +0800
Message-Id: <20250919084509.1846513-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919084509.1846513-1-wei.fang@nxp.com>
References: <20250919084509.1846513-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS4PR04MB9713:EE_
X-MS-Office365-Filtering-Correlation-Id: d12a9993-f0bd-490d-a84d-08ddf75be6d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ic6IWWYdB2HEbOnTtmAxH3JzizbwMR2k+sZyXeBaETuHUGpZthk5WTmAuZU1?=
 =?us-ascii?Q?b6gFZWskoTVYnSrnUZrVbGZdPSbrQWyE2osWHwL/eZXOZfYfignahymOYVEY?=
 =?us-ascii?Q?RB2F665nO/b6bB8Il8AWGgzJg5p+fcx8Z33NdDEDrUs14IZUunWLdyGKRfjf?=
 =?us-ascii?Q?5tyQNGZzNhz2P3IYGSok0QYt//T3Hujzkkw7bL9hPjAA/SwONw5g612qGxvX?=
 =?us-ascii?Q?mqyMzD2ppd4ufPQHRW8Bvkw1fRkl+2Z1ye4BuXdWuYqc8pbF3TI/3A6WubeX?=
 =?us-ascii?Q?qpNbXJXu7GSAYbLktwT//l44yG/P0LjcFckpknFz1jhNW8LIGv1L1q20/MX8?=
 =?us-ascii?Q?RxU2fApsTVbCYWYAt/g8s8ezubq7J1TvsPBHufUV1MTmT55aPQnk853bw1HE?=
 =?us-ascii?Q?qI9KafFDuAb6U5CFkoOAp4ZdwK5imYGzD6Ce7GJwqeGSPEmiVXEIh9dHSYdC?=
 =?us-ascii?Q?nBfuPwH5xIVY8/ezBW/JeZvsHG7ctypkhIJ22+C99NMmNqa+Ud60vmqQlpkA?=
 =?us-ascii?Q?ETuY15Eznh+wc6VQOv1p4aoLcXZTJ5+rXacTy2YiSCazrk7wxKSFCDUq2vBr?=
 =?us-ascii?Q?3sMXGlc8I1T1KylSRrJEYzjVebvDG6698UFdlq2hH33AYvgH40BLV2j6Ppi3?=
 =?us-ascii?Q?D++dEy16jUFhQcAI1aLBOX5QgIRLTpIU4HMS2w+tl7u7/aP2DQLIikBksbK3?=
 =?us-ascii?Q?jMdl1n+5/KoeFVq0WfrgOXkGWLs6xPpV9XAgSfLXjYty8zv9K8Hg4PnvKQrY?=
 =?us-ascii?Q?LtV2IKtLypD66HtbnEUzU0Jlu7HRmUjU2I/9LEvmF49Qrr1VgVw4QiOIMLgu?=
 =?us-ascii?Q?PIN1TnLlk9Flsa+qB7IWXfGGuWCmN0dVdoNF5ySRf1uK8AlqHbkLg0c1hcLS?=
 =?us-ascii?Q?Y5Z+NYrdN7gVerXOfAEewbKaHe2RO0CQePaIbEKNDV02wy0NK8i8bzRxtXtM?=
 =?us-ascii?Q?stOJkeYBTi9JlzNT4EyJmIYwifeRg527R0tAG2UIUeZoVfO9iD8o0Gr2g/zV?=
 =?us-ascii?Q?I5luXaccE17+jPN4iuWRPbNgYub5iGpQWLwZQKkrGLn8qNADzgg92AlZti7T?=
 =?us-ascii?Q?sTQX6jAC1jLnuTx4kgzi7WBkDRyCcPBiknjw6il+D5ClMf9F3G6PTk9FznKo?=
 =?us-ascii?Q?IhbcZaq7J75otoFvkBjIqqjLazg6FXyILR8JCeM3N0gpqMTIO+xiV0OIcRqX?=
 =?us-ascii?Q?ee2SiLESr1tZRWoy88byv0Bcv0+Qc0de8Z5Q1bFV4kiZJGaZWmSlDeFnj6BA?=
 =?us-ascii?Q?0KkhPFo2lZogo7fV9hRPuvExXQa2TbkANDaTmrj0tiuMuxkrjnwHE/O8Q37e?=
 =?us-ascii?Q?r7CrDW+TJGefZ1f51XoC0iqjpIGHt8W49+AEgbUY1ijdxJQZFfna4xfUbDad?=
 =?us-ascii?Q?AtdbXA+uqpyju33LOj0uxSFKO6I6PpvgaIxKrPfVNbqapu2OZ6uIophkmsqm?=
 =?us-ascii?Q?ATKVu+ftEbSHyLMqdsov2kIPN8An6t2BAFnPUl12Fu7wYIXD2UXpEOwK8esg?=
 =?us-ascii?Q?dcuCIO8PTjaOxTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FsXzbalbzmCSAz+D1uAYVZk/+7mEIDT8/UA7McPewL/c5jU92aICcFE7HdkX?=
 =?us-ascii?Q?q/syn7H+3hRXR9pTf9DJfSW6zUuTcNR8oJ1xToaUdKGPLsTW5b2fAKkaTYk2?=
 =?us-ascii?Q?21tV/fl2Zz9xXf5jvWikqyOgd8Y9W/FYnYH1pV0toRFaYNZ5n6UsVYxDJwaU?=
 =?us-ascii?Q?qySStK5ZgHAqYFJgx+oQmK/ymf2gCeo8Kv8G4V8AuANDhg44JH6+I9EdZUib?=
 =?us-ascii?Q?DdPUs2IhtbAfvCe6w4z9mKm7TvtXaTl1Z8Ia/Ah08slPgt2n1zZwsbIeaG1Q?=
 =?us-ascii?Q?DoVd/LGPPR8XS3/Q5TJcm9JwbsT1oYNtxy8wsjACeRCQkc5Im+TEWMNq3Cn2?=
 =?us-ascii?Q?iV+uULhGy+Q8eErKvh0xC9nBvn9ofxA63gzDGyGyRabkXWhfYyyvTX1Oquu8?=
 =?us-ascii?Q?bw/QfClr1WcXJNicGJ+MVr38q2AfiniV66D26v3V6JndVLmQsd2izAomFWvH?=
 =?us-ascii?Q?OHkF0VlxLIYgW4pXPoiUIWdIxfage/0p3pLt7VccdCxIz3UtOqzq8TraFJ/d?=
 =?us-ascii?Q?IWS3uG8WY4VkiifEd0TwcOqb7IHNZv6oIUSVxmuBCaEWa0GfBRe5qDIjhzI3?=
 =?us-ascii?Q?O3jsHNb3vBCLMTJnzeyS9zKgF6/LBY436g6fgpijtcn5MGPv/g8pzDYnaI65?=
 =?us-ascii?Q?8l2W/b5ZOUUyeebELNvoebjeIIsFmfp5qehx5p9JlzLu0uAF27SjGD1x3jSf?=
 =?us-ascii?Q?L3Uxie79nSEHTW6p6+0xvMJAaH4IOe9jdTFLHIRO2ApNKphIS+WlIoip1IDn?=
 =?us-ascii?Q?KGywnCl45I7Sk/iGSGS1UhmIRAtCaXkVntuwkZUPFVEbgi9Kr5V7fWW5Qs5t?=
 =?us-ascii?Q?2by2x6WIhrO/hOlMfdpdiB7CXgC8hdaaVShzjTthAN6UJ6oyE7ajMRF1jz+2?=
 =?us-ascii?Q?x8MOXarR+VEJBc5Qf9WU65Q32wJT5+oPaQrR18s4jK0HEJHfLVWa0SlsGH2v?=
 =?us-ascii?Q?X6v/KBGA/d/muMX5w8tnTTgOZgbcuRD4XPjLpmiJ5IiEFIVjVQcdXiXKM8QY?=
 =?us-ascii?Q?L8teWVAjd72i1tf2WNCrofTAjytct72mREv4JfuQ+1lm5wU8+/qsIUeq0l3a?=
 =?us-ascii?Q?Uqawwr3p8Jtl/nL8sz6msxju36cEli9r/Uzf1rzEXSliU7vXio5L8KsiL+X8?=
 =?us-ascii?Q?nmLT5uEWapW0FoUfjN/EETl+/dLnuaDD9fCt9CHYdWgNa8M1KdTYx9OK43CV?=
 =?us-ascii?Q?48HA8W1XDHBa5TVx82yUmSPPg5n/9wzW0OqGRY/TifuxGOMuMZFE12Dw9fXU?=
 =?us-ascii?Q?gtPUllrK4LAhqDvrVB10sMj/Bo4qSNKmE+x+hjJUb+XqndOVIQR0G3/AC/65?=
 =?us-ascii?Q?BlXw5wISMIz5XLZ0ogT7jz1mpkz2zUAIHkI6OaLoIVrEijdIfTnkBpOXdqcf?=
 =?us-ascii?Q?DNiTnfDCYN0pZ42M981oOXUcOj8hh2a8Ct8ReuimOB9Gt1xSh68KxbGi1+Qe?=
 =?us-ascii?Q?B1UFkRptSfjAlDGC/3GlI1tKp6126yaUCR1lhIz9N/qwdVmfByNLcnSItIPX?=
 =?us-ascii?Q?dRg8rT7biHlJlaaIvlMnvKYjJyWHoclN0xlkOQ/u8e8vLiHM0U2ug2aAAN/6?=
 =?us-ascii?Q?KDgOQtzVGeqMeoxIjMWc+AzhyQJImqPEKuL8Udo6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12a9993-f0bd-490d-a84d-08ddf75be6d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:07:04.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDcU+9BTa1I/nzA2uePoFNs5TYciLbVC520nkwlLipmzTQG/Anl2s5zvx/nDIgYUxdaH5ao8xgvgPM1IYG0z5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9713

The commit 61f132ca8c46 ("ptp: add helpers to get the phc_index by
of_node or dev") has added two generic interfaces to get the phc_index
of the PTP clock. This eliminates the need for PTP device drivers to
provide custom APIs for consumers to retrieve the phc_index. This has
already been implemented for ENETC v4 and is also applicable to ENETC
v1. Therefore, the global variable enetc_phc_index is removed from the
driver. ENETC v1 now uses the same interface as v4 to get phc_index.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |  3 ---
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 26 +++++++------------
 .../net/ethernet/freescale/enetc/enetc_ptp.c  |  5 ----
 3 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 815afdc2ec23..0ec010a7d640 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -493,9 +493,6 @@ struct enetc_msg_cmd_set_primary_mac {
 
 #define ENETC_CBDR_TIMEOUT	1000 /* usecs */
 
-/* PTP driver exports */
-extern int enetc_phc_index;
-
 /* SI common */
 u32 enetc_port_mac_rd(struct enetc_si *si, u32 reg);
 void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 445bfd032e0f..71d052de669a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -880,7 +880,7 @@ static int enetc_set_coalesce(struct net_device *ndev,
 	return 0;
 }
 
-static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
+static int enetc_get_phc_index_by_pdev(struct enetc_si *si)
 {
 	struct pci_bus *bus = si->pdev->bus;
 	struct pci_dev *timer_pdev;
@@ -888,6 +888,9 @@ static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 	int phc_index;
 
 	switch (si->revision) {
+	case ENETC_REV_1_0:
+		devfn = PCI_DEVFN(0, 4);
+		break;
 	case ENETC_REV_4_1:
 		devfn = PCI_DEVFN(24, 0);
 		break;
@@ -906,18 +909,18 @@ static int enetc4_get_phc_index_by_pdev(struct enetc_si *si)
 	return phc_index;
 }
 
-static int enetc4_get_phc_index(struct enetc_si *si)
+static int enetc_get_phc_index(struct enetc_si *si)
 {
 	struct device_node *np = si->pdev->dev.of_node;
 	struct device_node *timer_np;
 	int phc_index;
 
 	if (!np)
-		return enetc4_get_phc_index_by_pdev(si);
+		return enetc_get_phc_index_by_pdev(si);
 
 	timer_np = of_parse_phandle(np, "ptp-timer", 0);
 	if (!timer_np)
-		return enetc4_get_phc_index_by_pdev(si);
+		return enetc_get_phc_index_by_pdev(si);
 
 	phc_index = ptp_clock_index_by_of_node(timer_np);
 	of_node_put(timer_np);
@@ -950,22 +953,13 @@ static int enetc_get_ts_info(struct net_device *ndev,
 {
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_si *si = priv->si;
-	int *phc_idx;
 
 	if (!enetc_ptp_clock_is_enabled(si))
 		goto timestamp_tx_sw;
 
-	if (is_enetc_rev1(si)) {
-		phc_idx = symbol_get(enetc_phc_index);
-		if (phc_idx) {
-			info->phc_index = *phc_idx;
-			symbol_put(enetc_phc_index);
-		}
-	} else {
-		info->phc_index = enetc4_get_phc_index(si);
-		if (info->phc_index < 0)
-			goto timestamp_tx_sw;
-	}
+	info->phc_index = enetc_get_phc_index(si);
+	if (info->phc_index < 0)
+		goto timestamp_tx_sw;
 
 	enetc_get_ts_generic_info(ndev, info);
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
index 5243fc031058..b8413d3b4f16 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ptp.c
@@ -7,9 +7,6 @@
 
 #include "enetc.h"
 
-int enetc_phc_index = -1;
-EXPORT_SYMBOL_GPL(enetc_phc_index);
-
 static struct ptp_clock_info enetc_ptp_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "ENETC PTP clock",
@@ -92,7 +89,6 @@ static int enetc_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_no_clock;
 
-	enetc_phc_index = ptp_qoriq->phc_index;
 	pci_set_drvdata(pdev, ptp_qoriq);
 
 	return 0;
@@ -118,7 +114,6 @@ static void enetc_ptp_remove(struct pci_dev *pdev)
 {
 	struct ptp_qoriq *ptp_qoriq = pci_get_drvdata(pdev);
 
-	enetc_phc_index = -1;
 	ptp_qoriq_free(ptp_qoriq);
 	pci_free_irq_vectors(pdev);
 	kfree(ptp_qoriq);
-- 
2.34.1


