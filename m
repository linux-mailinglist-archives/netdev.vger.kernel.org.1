Return-Path: <netdev+bounces-268941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDH0OuluumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:22:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE8F2B8E88
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BE1330BE6B6
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA83A6B69;
	Wed, 18 Mar 2026 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HZTRXTgC"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA34939448F;
	Wed, 18 Mar 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825501; cv=fail; b=GyPxNsB7QGOp9Xy7utlsiZ8FUKo1Ct9iqnCmM5fP+nJN+9KRqW62y3o7L36WoUzeIVHdCwGsfhYrsYeE2/Xzd9yVPsEwAgpMJUaIvetGKpq6b9t3WMDfc2n1NURjvaPfcw86xY9MDGlwiM5wDQPGg8PQcf/i88ixPzSdfPh0Gvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825501; c=relaxed/simple;
	bh=DYaPsr8HSbJs0czy44B4yTTE/7k8IYZJ9M8Q3zBOj/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZOj27Qc2b8ehPRbk3TFstLR5BgG7zTUAKn8EPPC+zM0FqerepzHOJC5nHzPKjRcn2XxXFjYaTDuZfevwCxJ3InQxCfWbtXJ1MVyc2mx0oCOwWEG8EsTWAqNboGLVaphce06YcBZnuRzNId0yeFN0ieM9UgDYcIVOxRd4HMC5PY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HZTRXTgC; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oziGhekw5QjT6K34kP7kDC8435WMoLe5+p9Q7sYeAlmOt0UPbnazZyz7JXstuyQ4mq1OEgmZwkn/KLMsgZzTqBuIHWrY0k7rRGRdSF0zwQaxVwfaNwVd68fAU/WlL/oNHuuKrRYRI1LkttE6grhkXWJH8tvvTIbOhS9LZrqK8P3NWs/Co7B8LoeUXsdCxpStkqZpBrhIwU+W+4uPncL1UExGi0KStJ8ALuTuSCcN7ugjX8GVO3RtOqDs+rUU1cW+tfKej5B4dMwsJgIbrw/QWv+ZXilbNMt9yfeDLKV09dcNz7CclEdmb/lEzPke6Oyt7k362L7+C4wTMAM9dn+T8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnA4N9XZ3VGgnTvWt+AeLX2KrKSoowOpPyWyiVhwDvo=;
 b=s47Su2ah7j4guLeNfizhklTwVSlOSuLE8IDPOVLuJWuElOeIZGHj02KEwiIrntB1iLzFljGztp5yAzX3To3XmWaiAv4rAAQ1P42N+gBhVcxFKL10rfrANpM03bwVkjM1ZNuMbhP+8tsTsBMzWIEJowbtJzUMbFQiUAbas46mXMXME6axoqH5XbFUVppkmojhU5j8OX+hTb6rZPmb5cmoFfGuYsldQQh0+Vsslf863txFffrzmDDctsvtV8iNgEFtStCBGXpIOQvgTRX+qTT16pWjWTZHaXQyuhNbqxEedayuKTFhgF1hxM0RBJUVKedl9IAumtsBu9M0dmc9EUreQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnA4N9XZ3VGgnTvWt+AeLX2KrKSoowOpPyWyiVhwDvo=;
 b=HZTRXTgC+T/2oL93GUNUIUxMzFxpAcuPwO2ZGaU/5q+SS+kwVBNgYWx/hZgSSF13TT1rn0rr4KVCcF3j6BKynqqbYehuPm/Q3hf9zWKGQPa6/ia6gLb/3chwONDlpff7k62YWTFkBL+yGZoZVdFMDzQhsyjVfEm1aCGUl6OGOpU=
Received: from BL1P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::7)
 by DS0PR12MB7746.namprd12.prod.outlook.com (2603:10b6:8:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:16:51 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:2c4:cafe::68) by BL1P223CA0002.outlook.office365.com
 (2603:10b6:208:2c4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 09:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Wed, 18 Mar 2026 09:16:51 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 04:16:48 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, <maxime.chevallier@bootlin.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v2 net] amd-xgbe: synchronize KR training with device operations
Date: Wed, 18 Mar 2026 14:46:08 +0530
Message-ID: <20260318091608.1266381-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e80e544-d859-41bf-e89e-08de84cf174c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w6qTfp4A9iEnrS1cYzYdg41sOfoqwsVI6fIANPqoL5O5osPaHU4p0sNlXR1uB/GC5lWT3ONEL7YNtxex45CshuDpXcjCeuVokmvG4OsSGRIjPY3fL5sdI/eVg9jHrCOkV7uOEyjAHGJadL9TUjTxnfhy99AuG0t6AZbd8wTcsQtdSD3QH4twuNjoD6Bs7KCdHBIsxNNI6urT3L3gcymn78oZr//+cuBXEPibz1U1AJaGm77AJgR9BZROcfhvm4hQR2bMhCxg0r+87ewgueiPnCrF9hsqEnsGS4qYa60Z8VtunnN1DpA4DzE5JvsSL9/CAxiklDPkTXLZPJFP+I5aneUFHKSe6nhFip+6PnqS+Bu0Q/d+s2ATJfxJV30bTcamGudOcBeS7P+FQjB6Xw35NUB6tLxdIqVryt5ilmpUNp9Jq9eEJZ5FZAqqoUa6hv177E/X4TgrFav+8MOdgnc2K9RZw3lEU0gXEfZKrTbL3gaGn9AMrA900+LkoAeA1pBQ9JP3PXrlwWVPHmR37SBGlu4nSIXbY6tK7P1tVS7yHQDbX4dvE+JRH5xsbw06Xh3RWTWAXNhNnMrahyt240u3rlUnDTtO2vrPMI2BaVgwkxc2MUl1FiwhZ8MQNdJScrF+KnvtJ73YYhfdhAo/wnFozjEkTVuFjGJh6o7CQ4RZ+5HYicNJqbrpvMwbNd47BHAGRrUDSRKvSqrwA98sLWq4WlOdV+XA8Yw9EvZv153fYpZ1GsPKUduYpAIeWLBYQ5ndiefk09NLse8PDwtDXBnq0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W4xwOOqgAGO0MV4n8rP3CGm76h2BgM46go1yO7AKoUIPHuo6ngwPdPb2MuhdqUmmhjV22e5XPMCitBV2RraYHX2aKAifiIioEAatMjkuzUFrDGXzaqJkstgJAlanjNJffhf0rC3HfnZKRlAreCDhFS6XXGWW9GaazfCbkw2z2o4TUlOM6AUz+KauWsZWBS5AARWpuH8wXi2pFv2BtHKtnuOBhcCRoI/fX+ydVUo9zdFWkOnvVpILqSPJ6pwBCKcNCln84iG5Hxc2EKTEn2ka+hoDQoqzvuAS+hKdSgF2RXqb//JXk0iYk+HNtZck9CNrXCa/2PC46PYmWlJ7RUJTam2+K1QbfB7Lk5Gst8bh6MJ2oZdGgPKmujSDSxJyNVpgx+uVGiFN40rmvbNAFvfAlQz/qjmPkCUkgSc25MdsF+9OrOV3y4itOWKTZjmtOjZK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:16:51.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e80e544-d859-41bf-e89e-08de84cf174c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7746
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268941-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EE8F2B8E88
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
Changes since v1:
- use scoped_guard() instead of guard() for functions longer than 20
  lines

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  2 +
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 77 ++++++++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  5 ++
 4 files changed, 74 insertions(+), 11 deletions(-)

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
index b8cf6ccfe641..4c1ecbdfcabc 100644
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
 
@@ -2115,20 +2160,30 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
 
-	/* Issue the command */
-	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
-	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
-	XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);
+	/* Acquire mailbox lock for firmware command.
+	 * Lock is released on break, preventing recursive deadlock when
+	 * rx_adaptation calls back into this function.
+	 */
+	scoped_guard(mutex, &pdata->mailbox_lock) {
+		/* Issue the firmware command */
 
-	/* Wait for command to complete */
-	wait = XGBE_RATECHANGE_COUNT;
-	while (wait--) {
-		if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS))
-			goto do_rx_adaptation;
+		XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
+		XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
+		XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);
 
-		usleep_range(1000, 2000);
+		/* Wait for command to complete */
+		wait = XGBE_RATECHANGE_COUNT;
+		while (wait--) {
+			if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS))
+				break;
+
+			usleep_range(1000, 2000);
+		}
 	}
 
+	if (wait != (unsigned int)-1)
+		goto do_rx_adaptation;
+
 	netif_dbg(pdata, link, pdata->netdev,
 		  "firmware mailbox command did not complete\n");
 
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


