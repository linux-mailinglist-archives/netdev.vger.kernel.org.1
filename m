Return-Path: <netdev+bounces-254143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BqQIN/BeWl0zAEAu9opvQ
	(envelope-from <netdev+bounces-254143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:59:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D82BB9DF12
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 08:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08006300D954
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 07:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C742D5957;
	Wed, 28 Jan 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t6rMeTFD"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011051.outbound.protection.outlook.com [40.93.194.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00FA331202
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769587150; cv=fail; b=MdqBiR6ZG6CjYz68O2JDuBBMhV0ERn2KSs+nztJhkLPX8POIJVkMAaMVfnemQl0ZosXpGBAEeC/L+aPIPdYScUu6YcOCX4n9/6ORXxJJ9dMt+V5oL+hVtKeU/5BFB3eZ3u1k09bmGaBAeiO4yztEBGpVepkQCZ9kn7bRQjxw/H0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769587150; c=relaxed/simple;
	bh=IUz7qhaWu/TCBx2SrPT8jIuYoRQbKKYI5YILXH01hrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y+PakOFM/BUVDAmijwXuKxPPL4kqSXdn5bnEb99FS4ViROHcH1K9DcdfuCT7GuXeiY8J24kk8NZg7/Er2jcCGVztTEN7rN31826OKFObqGmtCAk5GG9OL1l9AsqLcvcglok+I7w+zDW64YsdosfGBAVbFoDIrWJeE4x0Hu7mGGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t6rMeTFD; arc=fail smtp.client-ip=40.93.194.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLZ+3M9JMQRYW+9X397p185s+2yTh3sA4/w1SG3kgc6JNEIzYhZSg3XRimLcdl7FzGwS5pQEuPbTHUAwR8xAzc1Syf1Hs6NGvscXNAUOxBmuLfv5ZjFmCvdpM6xcHYjNfCOX/X0no9v1JgoAsMn8FMnqPnsrmjV550xJJ7Fpj1+BhwZ3no85fKZHr3/XizTbTZdC6mTgDvFXKHq0xupGHk3iDGT95lDh9GYQom0ZA3mQ1HG9VxXvMuvBTr6MMtMKUSG/R9EX6vuP3r3WFnQsZd9pROufQXPhLycjKK92SlwgvXGSijLPEEKuMdP6zI18SIvpYVxrR09z18AQ38u6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkjFstrR7Z55cIoH2h0i7ypdOQn0z3T7KfGIuN+TtwM=;
 b=pVhrttdgp9g/nGs8yS5AU2lQmFr4TnHpcxWmdAjYlM6GsADDh5LJ5l93kin4cvgpJe+x2GQ7qO+9DmMhJP+IhRMRuaDukJC7tHk7T95eff3/5LLjHQOT2WxzkZ4apE8UEWHTxDKadN+ZQKyACSL1GYdoNrgjKVC5W+wjw/R9sT/GfoPrAWoLU5mrOMzBKWO5AVlDbJZn4CY5FrunjJYvXYjW1QHzDiqoiGeUkODXFoMpSju9wMQG/QLOlbeEUQgWH4F0RON1ynbNfKU3VP6hqG3cPz/dGxp2OygmtJVjwvMEsjfaEgmjTxfYSnF3oxHcspyvhQBNKH7sXAS0xn8+TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkjFstrR7Z55cIoH2h0i7ypdOQn0z3T7KfGIuN+TtwM=;
 b=t6rMeTFDIfpwZyFbDpXg2h+Y3qb/1DfpTRUFS5zfO7gYCE1d7F95ath07W/feHHqbDpsipg1dOaYpKTAybB7PZtV6iBWlwBnhqO4yfRqBVBJbxmKwmyaPNl/PE+NnkRxzpnjzRH/5s+692FvztOTuhyrb1ysklxNOo8wseSWgYY=
Received: from BN9PR03CA0311.namprd03.prod.outlook.com (2603:10b6:408:112::16)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 07:59:04 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::1c) by BN9PR03CA0311.outlook.office365.com
 (2603:10b6:408:112::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 07:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 07:59:04 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 01:59:01 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [net-next PATCH] amd-xgbe: add support rx alignment and length errors
Date: Wed, 28 Jan 2026 13:28:43 +0530
Message-ID: <20260128075843.696961-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a767d-1b14-463d-8494-08de5e431b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cEzJM3ASTeecwAOl6dSOtCXzviOU33N+jf/Ei/BXuCRcMmT73gUq6thZUjwP?=
 =?us-ascii?Q?PPZk8eh2GGseos+AkMNAPP6MlPUg/VjusilEc7INDDJKX4YQqZdtHuc3bPuT?=
 =?us-ascii?Q?8o9wDfmDDGqMWJ4heRNiMUpsbV/8TifLHXS3eHTx/xdk1C10Gc7pKi2fWAyx?=
 =?us-ascii?Q?qawXNIm99ps3Jq25LQTFE8X3lx6ubqiMdhGWQAHQAOZfzNnnpqL6/P4YNtBk?=
 =?us-ascii?Q?kJT6FaSWbZMbxAcdckvuBCfZAxt00Q9rf/Kugk1or3zjuz/d4pwyvOjWSPPv?=
 =?us-ascii?Q?2DNlZ409H8QA20zVMKeAZ1CZqF9aWaht6OPqoyYKYcSwd+j47AKH9YVKXnZS?=
 =?us-ascii?Q?Xn4c5tqbrbMYR64xaSUMsMLAaZcbyS5WAU8BQwY5getFilbMtaiHkS71h6D3?=
 =?us-ascii?Q?DrILuJiAFxZkWMP8NvvgNUy3PsSHxThSoGVZh/6Lv9i//OtY50hSO7fqw96X?=
 =?us-ascii?Q?3bxVqMwaNmaHSX5Te+wjCXPb1hvH6kKyn4wVzudivFYvFfmErA6tRZv3UJpZ?=
 =?us-ascii?Q?3K8/J4sLh0nrutSaNmgHrNdEBl1a9bOMrdfZ0SQdvSaGkSHFgDO6I8gd1Nz/?=
 =?us-ascii?Q?mPLSJxjZcbEHz7eB2uQs8z889sxpsKPkmttftHl25d+TdcdvdmxyM/WosFc2?=
 =?us-ascii?Q?XomL9bz6D/+YVhF5evGOLldkQqRi2hkyV3H4IDHfq0m4xbA30/0buo1HkT2S?=
 =?us-ascii?Q?TuXEcsayLJmobkDrqEWXIBJg5OiWt3ek+3MN72nhBgtkZRhW+vMN0kbysWpZ?=
 =?us-ascii?Q?4J+XlLBvQaPQMX0ZtXAI9d+cZ7q2tZ67xy/fT3Mp9D2ZKRJXlaxkAq9eChzV?=
 =?us-ascii?Q?6grOPMuuq+ADK198QLOdzdHLni5/31S2dOJ0nTd5KMiKIOzBWmTTBH2cKxDL?=
 =?us-ascii?Q?ZWGY5ScVx7niOJj0L0UG4tSG8swm4TmdQnC48UGOaMsoqJCrCgyA/2xHAbPQ?=
 =?us-ascii?Q?sJ6V8Qrs1PS0l9MDZKNlzFz1VTmjM5TV2lHKr5rl71FNCJZtgLSEhC4dxw5D?=
 =?us-ascii?Q?/lRHDss7D2q7Xk9ZR0JIPutgh+pyL4sCmfZygUfP4G+nWG2kzUslM7X7sORr?=
 =?us-ascii?Q?T7VGWmPKOZvhJBl7v4CkQ5NGXcK4jfUlD1Qzbb25SIdqHyhcg6mLWpvEuvpD?=
 =?us-ascii?Q?HMLkN3ehEoVEFCsaPSVb4UOgGhYN4a9P4DqDK0A5x/QHpTopw9h/zapIBOIZ?=
 =?us-ascii?Q?K3CcHrs2VjmuQ8xN3qU99rhZg2p3I4DsbtcklvPBb/5jWzG/9vVCOBW0QcSi?=
 =?us-ascii?Q?sJ+Y0HpYeMUXRrOUZTEP9StlftW//o9to4Zh7m7TLII7/+tl/URGZI1y3cqW?=
 =?us-ascii?Q?1zxGVLvfRjn4QoFGxDEY5yAf67ICCAFsnWrngp1Oa9hKqFbDnlWUfpbdYlli?=
 =?us-ascii?Q?pQgyGk9x/NrigZWQLHnbab/0Gxyoop0bgQMIC/s086b8v0WsSSfv6YNfL8TA?=
 =?us-ascii?Q?CZvDAR2qiaYWi/diZca4u8ugShBK1tqsGjypEOBe3FBZGjmIvnTWy51A2Wb8?=
 =?us-ascii?Q?fHmj9adRVADicpT+nFqiqzbaNvwrJWWGO3U+6vlF+Ploa7RcgDqhrj/rU4Yo?=
 =?us-ascii?Q?ws0Hyt+HqqAcAa8etMDLOjY0yDthrjPKDHFEWjlrB2pBOiZm3yw4Ef5J+OSX?=
 =?us-ascii?Q?7sOUPdNqWEUg+YA1oFFkDL8LcBA5QMt7gxbmdX3V4z03?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 07:59:04.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a767d-1b14-463d-8494-08de5e431b51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254143-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D82BB9DF12
X-Rspamd-Action: no action

Add the support to read the rx alignment and length errors and update
them in the standard rtnl_link_stats64 structure.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-common.h | 3 +++
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 8 ++++++++
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 2 ++
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 1 +
 4 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
index 62b01de93db4..711f295eb777 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
@@ -598,6 +598,7 @@
 #define MMC_RXVLANFRAMES_GB_LO		0x0998
 #define MMC_RXVLANFRAMES_GB_HI		0x099c
 #define MMC_RXWATCHDOGERROR		0x09a0
+#define MMC_RXALIGNMENTERROR		0x09bc
 
 /* MMC register entry bit positions and sizes */
 #define MMC_CR_CR_INDEX				0
@@ -658,6 +659,8 @@
 #define MMC_RISR_RXVLANFRAMES_GB_WIDTH		1
 #define MMC_RISR_RXWATCHDOGERROR_INDEX		22
 #define MMC_RISR_RXWATCHDOGERROR_WIDTH		1
+#define MMC_RISR_RXALIGNMENTERROR_INDEX		27
+#define MMC_RISR_RXALIGNMENTERROR_WIDTH		1
 #define MMC_TIER_ALL_INTERRUPTS_INDEX		0
 #define MMC_TIER_ALL_INTERRUPTS_WIDTH		18
 #define MMC_TISR_TXOCTETCOUNT_GB_INDEX		0
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b646ae575e6a..c04a9c76bd40 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -2794,6 +2794,7 @@ static u64 xgbe_mmc_read(struct xgbe_prv_data *pdata, unsigned int reg_lo)
 		case MMC_RXUNDERSIZE_G:
 		case MMC_RXOVERSIZE_G:
 		case MMC_RXWATCHDOGERROR:
+		case MMC_RXALIGNMENTERROR:
 			read_hi = false;
 			break;
 
@@ -2997,6 +2998,10 @@ static void xgbe_rx_mmc_int(struct xgbe_prv_data *pdata)
 	if (XGMAC_GET_BITS(mmc_isr, MMC_RISR, RXWATCHDOGERROR))
 		stats->rxwatchdogerror +=
 			xgbe_mmc_read(pdata, MMC_RXWATCHDOGERROR);
+
+	if (XGMAC_GET_BITS(mmc_isr, MMC_RISR, RXALIGNMENTERROR))
+		stats->rxalignmenterror +=
+			xgbe_mmc_read(pdata, MMC_RXALIGNMENTERROR);
 }
 
 static void xgbe_read_mmc_stats(struct xgbe_prv_data *pdata)
@@ -3129,6 +3134,9 @@ static void xgbe_read_mmc_stats(struct xgbe_prv_data *pdata)
 	stats->rxwatchdogerror +=
 		xgbe_mmc_read(pdata, MMC_RXWATCHDOGERROR);
 
+	stats->rxalignmenterror +=
+		xgbe_mmc_read(pdata, MMC_RXALIGNMENTERROR);
+
 	/* Un-freeze counters */
 	XGMAC_IOWRITE_BITS(pdata, MMC_CR, MCF, 0);
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index b5a60a048896..ebc5fe8324ea 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1838,6 +1838,8 @@ static void xgbe_get_stats64(struct net_device *netdev,
 	s->rx_length_errors = pstats->rxlengtherror;
 	s->rx_crc_errors = pstats->rxcrcerror;
 	s->rx_over_errors = pstats->rxfifooverflow;
+	s->rx_frame_errors = pstats->rxalignmenterror;
+	s->rx_length_errors = pstats->rxlengtherror;
 
 	s->tx_packets = pstats->txframecount_gb;
 	s->tx_bytes = pstats->txoctetcount_gb;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 03ef0f548483..1269b8ce9249 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -659,6 +659,7 @@ struct xgbe_mmc_stats {
 	u64 rxfifooverflow;
 	u64 rxvlanframes_gb;
 	u64 rxwatchdogerror;
+	u64 rxalignmenterror;
 };
 
 struct xgbe_ext_stats {
-- 
2.34.1


