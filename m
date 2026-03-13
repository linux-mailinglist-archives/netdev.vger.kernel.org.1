Return-Path: <netdev+bounces-267461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB1gM2cXtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:55:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B745284531
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AB19310705A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320D02DB787;
	Fri, 13 Mar 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h4a0wpuw"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD85258CD9;
	Fri, 13 Mar 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409370; cv=fail; b=JJTY3Oan9hOdgV20PtoeFKFGuUmzJbOpTHa5kI/R+Npi0+7DB6bdOiOhRJvRKk7mFHL6dfsTmrRbFFIdxO1Qj5ztlxhv20bUO0GbOFYHszIKmVnlAQAbBRjLaOxFS9QHDHFoU6zFZ3DZ98V8cZJtwgsQS1bKXaPuIKwP99di3vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409370; c=relaxed/simple;
	bh=TdAI98N3pQtFNV23Z/P9tkwuDc2aASCxqfHRrFOP08w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a46a2AGchZHfuDOZ/aXbPTTicLL4ACago3sUxDZIx0BqUKvUwHVTOai1Z/6LQBvJg+5gGdD1pauLVRrVTR9wQBn4FJ4RVBKiXne0FmE4RQsz0mNXIR03mDX4hHbwnF6LSspeg1Ut80bUoytw1hU1pvDJNFH4BUfsKGCJfW6Evlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h4a0wpuw; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suakzPiFZ57+mPZHoG9G23eD5bVdqZsNohips8a7r3y7X4uPhPirNj6Z1y4sE1josKaZSEgMtMKGT4jVqEEe1bovQCGXeIZ50R6VUdvZ+HH7aR+WnC8GkvKWa7E7d6lV6IIMOdXJ20vLAlyya534m3urW/7K8ty6aXWgi//bnPoqlNjyh6FmlTNkEUDcNf6aPA+DqSuRXwOQt+MedrzsP47v/6f9Z7gu3MkXKRpc2GbIjrc00plLNKr4JCaLeFe46w0ddgD6hOaQILeNPkdz8EKL0mGoRvAcTCecdkTQmfqtYBYBiDTSJcw3yRWRsufrnHS/kzGlYN4LMlb5XfbdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tiDUcnR7HoFVFcnqP1aqWbRSC8sPchh5VFDoxe4Hq0=;
 b=woSd+GhfBspGPfPjITRdAXuRT7eSNsFlHJptrrHdoJPMZlKCJ6A1TVeYYZ7I8W1Xa8MGGyGwLMnDgs7EREE+zwpxx50d41tHjKwk9X0hCKJBJh7baIL00b17ru1mxf4Ubn0Kp/wQ1PBway3yHoX7ybPGjlqgvVtjg97ILj7C6QSEVt+kv+SU7LypukLdSpYcuvzX5IN47sQW72qvh5LlGoNAPqcrktc589lHZrz4QuyStow0aQLUiabYVFPxXp+0Nt/9pozpCUFsEc8BThRJpN3f9/4TV0iehBiZIM9Qxzo7nCX671uWYBKpPOkghbNtG5Sz4/x2l24NbTI+j1S1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tiDUcnR7HoFVFcnqP1aqWbRSC8sPchh5VFDoxe4Hq0=;
 b=h4a0wpuwgWzmKAfzeuB5PC5Tz6CzSAl30hHIuWxuEtBCjeO34UMerSOFUOX7LVt8B92g2sTrrDb3rQLX2UIYOh1HVIhL7q4x22+0X+zJin8WH5tYoq4TEk6XR4+vTPUzO8OcEKrdy8HxfhQfBQKi+0/nTuA641BKPVmN4c9/MPo=
Received: from BN9PR03CA0744.namprd03.prod.outlook.com (2603:10b6:408:110::29)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 13:42:44 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::4) by BN9PR03CA0744.outlook.office365.com
 (2603:10b6:408:110::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 13:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:42:43 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 13 Mar
 2026 08:42:40 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, <maxime.chevallier@bootlin.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH net] amd-xgbe: synchronize KR training with device operations
Date: Fri, 13 Mar 2026 19:12:10 +0530
Message-ID: <20260313134210.3824872-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 015e9a56-21e2-427f-0d49-08de81066789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	80tIov/O///3OuqWVNi6SzHQAIcPA/EDqvI6lSHcq7/ERDRGDIwoKjnpyoEiIef/Zp9j+WasV42vjyVhBBh+vRxWEy9qS3VLHssLtkuwNw4BNj8nbc4AN44I2i6jIC8bz2NNEIElYpQL9dN6tCjwl4tvmiiWaSbV+mI3eeEjefoP9NImbu2BFr1rQC9vP7VDsWEijT2zX2Gcai8GjUDQ0zlzamdDsd13i8U6gjkr9/SoPwfx2ZDB56/0twOiFCXZhVE9o1dzi9fiAACIAPXuB6HalNZWC/0Et97TYoOG3xdQMraB+CN1DiswiqtgglOmulRF+JqBDcLkR4Rnj8mkm6h76BA2YnhXQyzwHmefey2ynJU66rux+p8zslzGk5jMrVnVBK3Tcw2rrP3j/kuKDiukiUJYcqj8IIZErkpubE0wvTaeRv3oyh6wDqLEH61tP3clj1E3CzKj5PBMhOPhDBtgBkGAoXa4yHwQYhGli50Ib9tx0xkcoT6l8Qm2h7bPgWcyvOR6GLvJsbZQQZOSECAX29ls0aduydCAQZRTi9eb2ttilps06R+40npLVzreo1rL/B55DW9pWgkykMnzfkU60z76p0WCG/kQkPRfpMe41jwlJeE6h7RgQtDaTatZzD+jWsYudhmo43PXlic49PUMVm9WZ5AYvGW4muoENZfDy4y8WvuIYVzNrZHdcavt5COgPocJUhWx30jFW70l6yWMAF+uxirvA8fQQHlKl6VRBOi9lb/2S1zJIYVbSv9MboO3dXixI+WemUVkYcbfBA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PbBOsY1wd8DsavJRJRNGxMl/EqLkq54WO0VlMP8QmhLzZUgpMTl6CW1EikPbD6eiUKnu/DU64RCRjuYaAgC7gMcGrGe+HOT/9zOziv+o35d20UfQXmZ7Ua36U8I4+qrJ5KxSsDCEA956uMQ/Ux6/qGZkFbtUHCcnIO5khbWuUq/5dmOC0Hq7vTElcUf1au2MKg4VwRKj5lGJjCgOYr+NI7dl00JZgSAy8wL3mgcEdRSE8wXsDBKVO6wPjDrqYhp3cPZocUdVc7b6RiR8OjdirjPfk5Vob3wFT4zHjUfv8hOFT25gU8d24Gyn3riquWstg5XRtL0M2soU74N2gT/ulKEVBrsJBe4cjeu7cDLfsusCasK0tSMIcBmXBgiI1KQiYYGpk7smUbs295E8Xic+4ffpZi333eh9h5I4NA4OLtumDJ09PM2pOSk4upXf5FRH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:42:43.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e9a56-21e2-427f-0d49-08de81066789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267461-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: 8B745284531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During 10GBASE-KR link training, the PHY state machine can be corrupted
if device stop or rate change operations are initiated while training is
in progress. This manifests as:

  - Link stability issues after interface down/up cycles
  - PHY state machine lockups requiring a full driver reset
  - Intermittent link failures on Inphi re-driver configurations

The root cause is that the firmware mailbox operations for device stop
and rate changes can interfere with ongoing KR training sequences,
leaving the PHY in an inconsistent state.

Add synchronization to prevent device operations from interrupting
active KR training:

  - Introduce a mailbox mutex to serialize firmware command access
  - Wait for KR training completion (or timeout) before proceeding
    with stop/rate change operations
  - Only wait when KR training is actually active (KR mode with
    autoneg enabled or Inphi re-driver present)
  - Use a 500ms timeout to handle hung training sequences

The mailbox mutex protects the critical section of firmware command
submission and completion checking, preventing concurrent mailbox
access from multiple code paths.

Testing on AMD platforms with both direct-attach and Inphi re-driver
configurations shows this eliminates PHY state corruption during
interface operations and link changes.

Fixes: 549b32af9f7c ("amd-xgbe: Simplify mailbox interface rate change code")
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  2 +
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 51 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 ++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 23beea48ae26..3913eb7e1da3 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1321,6 +1321,8 @@ static void xgbe_stop(struct xgbe_prv_data *pdata)
 
 	DBGPR("-->xgbe_stop\n");
 
+	xgbe_check_kr_training_in_progress(pdata);
+
 	if (test_bit(XGBE_STOPPED, &pdata->dev_state))
 		return;
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 7d45ea22a02e..5f3ab29707b7 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -78,6 +78,7 @@ struct xgbe_prv_data *xgbe_alloc_pdata(struct device *dev)
 
 	spin_lock_init(&pdata->xpcs_lock);
 	mutex_init(&pdata->rss_mutex);
+	mutex_init(&pdata->mailbox_lock);
 	spin_lock_init(&pdata->tstamp_lock);
 	mutex_init(&pdata->i2c_mutex);
 	init_completion(&pdata->i2c_complete);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
index b8cf6ccfe641..142eb952a29c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2095,12 +2095,57 @@ static void xgbe_phy_pll_ctrl(struct xgbe_prv_data *pdata, bool enable)
 	usleep_range(100, 200);
 }
 
+static bool xgbe_phy_port_is_inphi(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_phy_data *phy_data = pdata->phy_data;
+
+	/* Re-driver models 4223 && 4227 are supported Inphi models */
+	return phy_data->redrv &&
+	       (phy_data->redrv_model == XGBE_PHY_REDRV_MODEL_4223 ||
+		phy_data->redrv_model == XGBE_PHY_REDRV_MODEL_4227);
+}
+
+void xgbe_check_kr_training_in_progress(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned long kr_timeout;
+	int wait;
+
+	/* Only wait for KR training in specific conditions:
+	 *  - Inphi re-driver is present, OR
+	 *  - Currently in KR mode with autoneg enabled
+	 */
+	if (!xgbe_phy_port_is_inphi(pdata) &&
+	    !(phy_data->cur_mode == XGBE_MODE_KR &&
+	      pdata->phy.autoneg == AUTONEG_ENABLE))
+		return;
+
+	wait = XGBE_KR_TRAINING_WAIT_ITER;
+	while (wait--) {
+		/* Check if we've exceeded the AN timeout window */
+		kr_timeout = pdata->kr_start_time +
+			msecs_to_jiffies(XGBE_AN_MS_TIMEOUT +
+					XGBE_KR_TRAINING_WAIT_MS);
+		if (time_after(jiffies, kr_timeout))
+			break;
+
+		/* Training is complete - no need to wait */
+		if (pdata->an_result == XGBE_AN_COMPLETE)
+			return;
+
+		usleep_range(10000, 11000);
+	}
+}
+
 static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
-					enum xgbe_mb_cmd cmd, enum xgbe_mb_subcmd sub_cmd)
+					enum xgbe_mb_cmd cmd,
+					enum xgbe_mb_subcmd sub_cmd)
 {
 	unsigned int s0 = 0;
 	unsigned int wait;
 
+	xgbe_check_kr_training_in_progress(pdata);
+
 	/* Disable PLL re-initialization during FW command processing */
 	xgbe_phy_pll_ctrl(pdata, false);
 
@@ -2115,7 +2160,9 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
 
-	/* Issue the command */
+	/* Acquire mailbox lock for firmware command */
+	guard(mutex)(&pdata->mailbox_lock);
+
 	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
 	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
 	XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 438033a71523..238eeee0d422 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -202,6 +202,7 @@
 #define XGBE_AN_MS_TIMEOUT		500
 #define XGBE_LINK_TIMEOUT		5
 #define XGBE_KR_TRAINING_WAIT_ITER	50
+#define XGBE_KR_TRAINING_WAIT_MS	100
 
 #define XGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 #define XGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
@@ -1015,6 +1016,9 @@ struct xgbe_prv_data {
 	/* RSS addressing mutex */
 	struct mutex rss_mutex;
 
+	/* Firmware mailbox mutex */
+	struct mutex mailbox_lock;
+
 	/* Flags representing xgbe_state */
 	unsigned long dev_state;
 
@@ -1252,6 +1256,7 @@ struct xgbe_prv_data {
 };
 
 /* Function prototypes*/
+void xgbe_check_kr_training_in_progress(struct xgbe_prv_data *pdata);
 struct xgbe_prv_data *xgbe_alloc_pdata(struct device *);
 void xgbe_free_pdata(struct xgbe_prv_data *);
 void xgbe_set_counts(struct xgbe_prv_data *);
-- 
2.34.1


