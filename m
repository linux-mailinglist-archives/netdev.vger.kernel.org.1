Return-Path: <netdev+bounces-186462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A219FA9F405
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E3543A472A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB4279793;
	Mon, 28 Apr 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bzmGaJ0u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D7B189BAC;
	Mon, 28 Apr 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852597; cv=fail; b=IBBtu66XJHEhkQSG4Yh1BwHNNTfNVXdIxXMDCszIk0H250olirY1NP1284XjG7X/3QJH0kcxS/gsrwR5jgYRSxkQCfGcnawueUjpoE+jYFrFiCbo61JTepd6mhGtA/rkVaNuNIZGw8m4WOO6Y5mTyubuJXitvVcGYMrxcnK5QjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852597; c=relaxed/simple;
	bh=xmsU0WJ8r//3oYueAvtH8SVq0xLmh2hMtK4nRgo5LWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCGgJNzol52AQFpY45GJjjNHa4l3w4x3AkZIjK4bDeo1F+u1otlQisTvwvRnF4EIOOqjFtCQNm95GPNaGob0dvpAIdAI7hNdYAVSH9EbGU6XKv5Q84YB0Nl8A1NmLZJzPRZHeJT93BGfZpLedMIu5ZSyFvTizaHvng1JaBfCU8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bzmGaJ0u; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfnoYwK5dabDyiRblnQTeOShnXHRbNXg8MGeZ8MDt/D7gkGTTlnbWbp/zRngGev1SLA8bgmLVaEtMNk1YoSAftAPNqylByAH0bAyIBSUG8Tvg9O1m+/EK+XY4TqLSGi8NkLUMXY1/NuJGbIOAjaVmBFXmiMp04y/UWheHhw+U2CX/dlv7u4nxBInL/uOX0c79uvpT43SKQmVVJatUIOrY7kRWopW0qbZYOvJAYuMbxrhACb2J0sPf5N8nnwVZm+uxR+cmrT33zJqL1sEho9Wm0V3E9RqTsetsbssSHFqwBxa0HKAz1I4fFdGRmZ9Zuse6bHmIk1CvU3F7XVOvclvKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN6NU7iT1fkI6IedpBe3Smm2IoVUyCWga8ZVS2gDE9g=;
 b=wc7rkvn8XDuRqkonemJu7eh4knMhmZYYBVGh3DzoHNDABthCcs45DbOzJ/cGk1vZ6zHnV6dlQvxtuBZ7P8KTjAHIA00CWoDl2Dtun5mXHz6dvAxLSwp3DIpc1IfQ3VHlAaUhWMVzkYMqjG0ZDmebWfcEM633n/c4ZVNsroyqPSfjy6Ujzz9zEqOOHPufwJul9ToJtAc5Fybe95+wWsMntG6Tui5ew/bCg0IvOj34/yY6uDUCTBVnTE8OEXelz+Xkcey2L01ExHErHyuCVb9a738euZyy0h7s2U5rTZpIDtRlo/SIZ09kAFexNRRYrNNc3V4bo3YcG0VbT1i5YOpRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN6NU7iT1fkI6IedpBe3Smm2IoVUyCWga8ZVS2gDE9g=;
 b=bzmGaJ0ueSCQ+L/6I4XUYApc6fjiAdQOkHPoPlpT/1gp5GUrEgFXCgoSWvEd0uCSgif5m9rD1xwILJUT69V0SIhMebarCtxFJr6MKVFNtJTwD3XAFav6w4cC2pseHHApvf97hZXkm5cfYN3n5Z1ot1X9IBoMBwJKYpX3+UOhGAQ=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 15:03:13 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::d) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 15:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:11 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:03:07 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 1/5] amd-xgbe: reorganize the code of XPCS access
Date: Mon, 28 Apr 2025 20:32:31 +0530
Message-ID: <20250428150235.2938110-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
References: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d31efc-36a2-40ff-a999-08dd8665cb11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0457MgFz9qkHF7plxsSP56DvaPUVD4DpMM7+t7UEIDrXgh6dgPUV6ulK0oU?=
 =?us-ascii?Q?ZKCOKbY/8XrA7Gy5dX6S/hWF/t+A4SbLjx25qDZtyt/LDfwtgWHChtChRNEi?=
 =?us-ascii?Q?+ww7bV4HglTrk9u4Ywhj3PocrbrnERKa+b+elqhiUfCK0cJB1187B8T3RJJl?=
 =?us-ascii?Q?YrzJtAzj4Sq9FoGhckaY6V9xraXRMFDNghkZqATRK7uLMF+zdA4mTkKbSVBv?=
 =?us-ascii?Q?SU+6RhxHtLaGW9qsFvHr+k7GOGaBk9IycrBpXEF4NXxOfUMA6hnz9HTaz5vc?=
 =?us-ascii?Q?buMTEeU2EZIOjykFuruCfr8sipOJsJTxduxnSoxbtSf0oVwWsLfdY4ukQtvm?=
 =?us-ascii?Q?3gQ4bAd7J8BbKdLuhyc653pkodAAXikaYco/RDZvfwea368SKAKaIC2/AmrD?=
 =?us-ascii?Q?iDw++eM9u1SsDvQV5K3rfUgdMlwYdmhmqsbHwuA9Isk1+KdEN9Jy4rlmEN9i?=
 =?us-ascii?Q?XnWce55MAKCByqKDlWkV7sbt7uJKm1eXsNOvQp1ogcjSLIu0ndATM8qhZUzu?=
 =?us-ascii?Q?F2t1TtMQkPYepFU9DRSXXIjDehupR6jolTYlMqo1JL2ur5Z1b1zuWdqq3pn9?=
 =?us-ascii?Q?+RVhY9hAkbZHSd8YH3xeZeoLu26ccru+gVnmcpxvYycGpYgF4cIIu2P1Y8rU?=
 =?us-ascii?Q?cuqAgm/8ViM/U6ZR/TxsmDFAy7jLYOxxwektTsUyVOWJq8b1q6gfjDT4jTvq?=
 =?us-ascii?Q?C5HuYA0euhylsYWU6hkw22T51a3hqtIfekVB6s0g6YbKf7Z8Qf9VcGDxWHdp?=
 =?us-ascii?Q?jHOQDxCrfrfWDCQBMLrzXpUKYX6eKxFjB3ga+xDshsvNb1GjTMi0k9ghI2ew?=
 =?us-ascii?Q?LckuFdzATa4IscxaGvgyaYj9dOdvMVYkrKD0eFfqzoKZ6peFUte2eifOp7dF?=
 =?us-ascii?Q?/w3J+bDxeUBuPPrhS+YAvYTZShYrN6EfLvPjMkk3m402EU5UeMp4+VZALL5U?=
 =?us-ascii?Q?n4Mjrn3yexLErld6su+o9Twey4IRGcHg7D724FqUcxwT1F6JYHC6HFUKFjjX?=
 =?us-ascii?Q?Zzpb3edxZSjctJyXEVXwaXn3OGhBi1MHs+QqmIwevjl99KUIIo1lZ1yc+9l2?=
 =?us-ascii?Q?qv75nZmOvUwlsrly6eELNQhE9UkCrrqZH2GeaQxT7HlI27pbw+53g7SDe8f2?=
 =?us-ascii?Q?0auMV+ckkovQvXeutKnmKsQjnOb0v+1vku6yqmtNODY3sFKtuq5GzcsOwaAh?=
 =?us-ascii?Q?Rh9ztv60K4tQthhiUgUMzlgUIyh5WeYrIfKeaMtWOXFhWu0Zmbh2oOmt6fQY?=
 =?us-ascii?Q?pEZ1s2UWsAGFLg7qqKfzAlaSQzmjzvkT9qoq2koKeNSNDKUUPUjbLGcdWnCe?=
 =?us-ascii?Q?UT2LMJKWpiGjtzfRFv+lrZngCrfpCVQ7siqgWvGLFYJtsoC4BSeg2acyXRh0?=
 =?us-ascii?Q?aeZnMXH70hr6T5lxqT6WegBqnUhI8aonDR2NwXwf/9EA7+tWUQqSHsIhyL2T?=
 =?us-ascii?Q?QS5eGKORQLIu8kUHCt7QKb5vFUW5E5yfEodj/0kYrEQArDLU7PgY384BXaXu?=
 =?us-ascii?Q?WXnl6W3pNdVI4wZLCYLoDKpGsw9M4XaChZan?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:11.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d31efc-36a2-40ff-a999-08dd8665cb11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84

The xgbe_{read/write}_mmd_regs_v* functions have common code which can
be moved to helper functions. Add new helper functions to calculate the
mmd_address for v1/v2 of xpcs access.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
Changes since v1:
- add the xgbe_ prefix to new functions

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 63 ++++++++++--------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index b51a3666dddb..765f20b24722 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -1041,18 +1041,17 @@ static int xgbe_set_gpio(struct xgbe_prv_data *pdata, unsigned int gpio)
 	return 0;
 }
 
-static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
-				 int mmd_reg)
+static unsigned int xgbe_get_mmd_address(struct xgbe_prv_data *pdata, int mmd_reg)
 {
-	unsigned long flags;
-	unsigned int mmd_address, index, offset;
-	int mmd_data;
-
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	return (mmd_reg & XGBE_ADDR_C45) ?
+		mmd_reg & ~XGBE_ADDR_C45 :
+		(pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+}
 
+static void xgbe_get_pcs_index_and_offset(struct xgbe_prv_data *pdata,
+					  unsigned int mmd_address,
+					  unsigned int *index, unsigned int *offset)
+{
 	/* The PCS registers are accessed using mmio. The underlying
 	 * management interface uses indirect addressing to access the MMD
 	 * register sets. This requires accessing of the PCS register in two
@@ -1063,8 +1062,20 @@ static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	 * offset 1 bit and reading 16 bits of data.
 	 */
 	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	*index = mmd_address & ~pdata->xpcs_window_mask;
+	*offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+}
+
+static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
+				 int mmd_reg)
+{
+	unsigned long flags;
+	unsigned int mmd_address, index, offset;
+	int mmd_data;
+
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
+
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1080,23 +1091,9 @@ static void xgbe_write_mmd_regs_v2(struct xgbe_prv_data *pdata, int prtad,
 	unsigned long flags;
 	unsigned int mmd_address, index, offset;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
-	/* The PCS registers are accessed using mmio. The underlying
-	 * management interface uses indirect addressing to access the MMD
-	 * register sets. This requires accessing of the PCS register in two
-	 * phases, an address phase and a data phase.
-	 *
-	 * The mmio interface is based on 16-bit offsets and values. All
-	 * register offsets must therefore be adjusted by left shifting the
-	 * offset 1 bit and writing 16 bits of data.
-	 */
-	mmd_address <<= 1;
-	index = mmd_address & ~pdata->xpcs_window_mask;
-	offset = pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
+	xgbe_get_pcs_index_and_offset(pdata, mmd_address, &index, &offset);
 
 	spin_lock_irqsave(&pdata->xpcs_lock, flags);
 	XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
@@ -1111,10 +1108,7 @@ static int xgbe_read_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	int mmd_data;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
@@ -1139,10 +1133,7 @@ static void xgbe_write_mmd_regs_v1(struct xgbe_prv_data *pdata, int prtad,
 	unsigned int mmd_address;
 	unsigned long flags;
 
-	if (mmd_reg & XGBE_ADDR_C45)
-		mmd_address = mmd_reg & ~XGBE_ADDR_C45;
-	else
-		mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
+	mmd_address = xgbe_get_mmd_address(pdata, mmd_reg);
 
 	/* The PCS registers are accessed using mmio. The underlying APB3
 	 * management interface uses indirect addressing to access the MMD
-- 
2.34.1


