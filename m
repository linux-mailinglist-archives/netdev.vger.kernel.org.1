Return-Path: <netdev+bounces-98831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980188D293C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7AE61C22070
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146F4A28;
	Wed, 29 May 2024 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0MYg0YG6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB1366
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941021; cv=fail; b=MIpDLMYNYjR2QxiWIc8YL5UQhC9Z018JCAikJDKqxoZTMUZ9rRjThMWMwDmfloc8ckLZLFRPtjn3aYN1jt27HNWuPCW8K9po/d+jvCCtPvHLZYuxEQkE0BZh5WB+14Ly7gj4FtF9JaNvQTsQ99VKOVLna2LNIkxyUhixBl8dIvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941021; c=relaxed/simple;
	bh=7rljTOg8s/ZdZACSRcOKzkMmSH31sckryK16uGqoQ7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVubF6qXZbaoL17vGAfl0itytTWS/fOyB1NexTVkvcTnW6/gxd9hvGOfFW5YPjXuKWhlRTR0OXXbQruN4hahWgT0FDqKDfseHCdy78E5CfI6I8jquWQX1xU29BglrPbCX0SXMyrUs5xYO8QshX+cxWaGGsJdQgJRXnnVvaCbdk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0MYg0YG6; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SI4atIT67ZAEWpye3H/9sq5MiNk6aYFUvUXFnNiyUBMjY8i2g6yt0BAtzo0eJQYLiEB06kCK4+R8CCt5+r3Qvh44/Vl5a/6I4ook1rLHPKmy3A4Dv9vfdRid75Ah4kE4purMw5pJLKt/lhjL2N6TbPPAGgYN+FWqT4ln7hiAl8JscJGxsWcDdr1ZcC01ICHX6mFT8Z4SGOnETKTkC7v2UpgfObUnrLqqHEpv/pampseCjwUfIc8s53biOCtYeo9M5jSTtWeKM21lRlDzZwK0YAy8hyxm7P7h1Xd4E66+yPSkMzjRW1XpEjSykkFwE1ffEK9JAnCRrVtazMkPIi4l4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgBik6BrExTsuQgErCaC4jzj+uDBZFFmvtTtRFeEt7I=;
 b=DFT4EF90IMSCS/g9ZSh8WHrHttR303/9OsH+RCF7shavCbuIxF40L3OaCyJwj18qX5MoyZCF+r+iW8rtn7n208zvNKEntGwvia7UL2aRS13YM4zP2wsDYDrdd9etdAjmW8XHCqckVHDKYK1agvhiSlU364w73Mf37QiMtxy1X/F89d5e0tWgO1HZqqQf0c0wcFfPHSHheQbV7CtB9/2I1gEYu2N5PTMcgJHJv8EF7hJIBZ92UNUgC3ajg9j6P3xdeye6jAzMoBhBM5lil4+T+WhucRA1L/Dsqmy/wnJKp9RFPP6Z69yaxoPGZRMVAA4BeR2PdYU6i9X3QtNPtI/bxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgBik6BrExTsuQgErCaC4jzj+uDBZFFmvtTtRFeEt7I=;
 b=0MYg0YG66+ngLpO5SN3O5l8gtAf4IRP/UwQXxNV1F+Sieei7xwIzdiUIp663LWTOoApQvW+iJD+rb+Mowvgu+TeS4FwL1LKZqlooweb49OragoX7XzfS5IwxV3Tr8iW3XzKe5QQs9nhJDkoFkdbD9owIl572Ie0I+m98edxI1+w=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.31; Wed, 29 May
 2024 00:03:37 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::d2) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Wed, 29 May 2024 00:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 00:03:36 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 19:03:31 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next v2 6/7] ionic: only sync frag_len in first buffer of xdp
Date: Tue, 28 May 2024 17:02:58 -0700
Message-ID: <20240529000259.25775-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240529000259.25775-1-shannon.nelson@amd.com>
References: <20240529000259.25775-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 56aad48a-df9c-48d0-87db-08dc7f72c9ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGU6nZv2juHf1FsUyyk1zyP0NtJw5/XvgsGvdWycsze1qS+s3jg1nnSP8Oj0?=
 =?us-ascii?Q?cnSpiR1cpkYdIa9OW9ARIbIzYX7Z+Ao044jalw64OpbsrDfo8R7K1czhxrIf?=
 =?us-ascii?Q?nBTUasCTM/KF0xgrO8NurgFf/KYp82eIrNMPK2unOTiSmvF/cR+U2zosFbUq?=
 =?us-ascii?Q?4vdPP5hF0GYQ54Z/JlaiV/G+zZAn5Z4/GbKtckJOHHNSMUIrJOplSok0nMSG?=
 =?us-ascii?Q?9E87AXfAUd43xSwOD8WrJUknUy81NFCnq/4/r1m4gpVj42MJiKnhqRR0Gsif?=
 =?us-ascii?Q?W2ljgvOhiPPuQyDIQRLEm4Fnh5juEjtWrswJ/PkT0SknZoyq0rdnmwrwZPNz?=
 =?us-ascii?Q?Wce0V6aXtMOWQElb/aXMrdk0yj3B3wcrPNw0dlJAfLAjYyKulXzTBXfit8eD?=
 =?us-ascii?Q?bzZk2uXM8eg5VDmJuTx1+ur2mHmcypMhqH3bOMD9D4a+z1NFoTkJ1P0uxyl7?=
 =?us-ascii?Q?Ehl74VA7eQvQcrGn7MKjlNJ5KZ9AI3f0dF1yOdU9/xCTuFrSMakHFO4JFM+Z?=
 =?us-ascii?Q?dvnF4eWPt4gIwhHdPshs99VAi3XpHhtk5MfhkqhysoWT/9oOkO6xbvAp2W+V?=
 =?us-ascii?Q?v/3e2JYOkUYdX/OclECOsKSPCvnG3sTMopUAaDj3V8/RltASxlp6F9tAJq6f?=
 =?us-ascii?Q?1HF9mCKNWEAJklwssoIsAQHD7HRUfi0S4HhyFpFjips3i3eoEUdW6wLP0AEd?=
 =?us-ascii?Q?cAlpvULupCHKduzco/Xf7RABunNpZ9JlsurVbOkXbfZCYwZYQgfqUoIcbhbP?=
 =?us-ascii?Q?2tMSYjk8PNk6SwYBQLxJjqsU9pbmzUmbxJrk+6x9++93jk3LvCzhAcrE6+IK?=
 =?us-ascii?Q?es0zPR+VnSEQmudt2gT1c7RKw49ZCAgCl6yIY5yGlzYlY8HpLBFBCCwjao2p?=
 =?us-ascii?Q?pnzVDsGInRhBpU0N7/RUdJoDabuy1xYcGJ5g/AXI9YtYKM2nz2cEsy1DpT3Q?=
 =?us-ascii?Q?In9BDykHaTDyv3dYwTUcipCMDclLAZ6Df432yeSPXx1jZFvFT0cMeAJqCSC5?=
 =?us-ascii?Q?StK/8+mmM99bRdFpAwA+TVJlyCFLj1G2/zlGxKaXk3TSvO6tOoeyxZbQUlS/?=
 =?us-ascii?Q?Tpm8CNfztu1nUXbqZiUvBscRGcnCeGBVZoTKwSdC5nGdn7MW87/kOnamzFaD?=
 =?us-ascii?Q?90n8ZrpX2oq6AeQ3MpywGoFvxcxSl78JqwjqPvrC4+arAKmKCLUKYTkEfGy4?=
 =?us-ascii?Q?jwtB/buvnTGCBMjxuB5GiQQtF/zRk43oddsSTqj2Mymag3VmX+JXCLUDL3dN?=
 =?us-ascii?Q?trKLRnBLdRbabx6NpJK7OSUywMt9kwU0v4JEOCvl5InZOpWlx4WDXPn9Q2E+?=
 =?us-ascii?Q?S0flEPd6oaeqIAHqZSO2eW9SwfyJlRW6Rc+xb0aJe4Git0bt4gWUYCJcLcf3?=
 =?us-ascii?Q?k6kUgx4sAZCxJVci4sl/dwLxXcIP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 00:03:36.9369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aad48a-df9c-48d0-87db-08dc7f72c9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

We don't want to try to sync more length than might be
in the first frag of an Rx skb, so make sure to use
the frag_len rather than the full len.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 14aa3844b699..c3a6c4af52f1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -502,7 +502,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			 XDP_PACKET_HEADROOM, frag_len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
-				      XDP_PACKET_HEADROOM, len,
+				      XDP_PACKET_HEADROOM, frag_len,
 				      DMA_FROM_DEVICE);
 
 	prefetchw(&xdp_buf.data_hard_start);
-- 
2.17.1


