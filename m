Return-Path: <netdev+bounces-274918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HOXC8Nqz2lPwAYAu9opvQ
	(envelope-from <netdev+bounces-274918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:22:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C60A2391B40
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B90D3012BF3
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9434D35DA69;
	Fri,  3 Apr 2026 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="whScQZvq"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F2423C4F2;
	Fri,  3 Apr 2026 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200959; cv=fail; b=hm/1+oSXS1FECZxvlQvx8a2iJV7Nt3m8BBfOKqFXtqAgQun42Glblk7o+gb2eECcOaiE7WF2q+Un5MFGqMqWOpRdv8i3JKVvhPYNd030HSvEWAz90U3c7zu4vmbyrFLkLCsBP0BCvJVgB9ss3+3P+8Id4u8tdg9T8MKXH6i0b5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200959; c=relaxed/simple;
	bh=sdwBhFk1EdWDekdkz4DPN9JznXzc/KHloA38SZEyah8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AGQEZjq9dWiw3eG9D0adcH2fa7JQe/8UbW5w/w9nQGkSbBro/AnZQ0WrTzxF4lRSlZjYCCo5gsERRkrNCE1M9SKnql6LP2eT4PNf0A6NcVz2ak5qXHf2tvQp436hQclwml7ZfR8Wv2vqfkzOEqjSNV41LiiMw81h6IKhQBJu/D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=whScQZvq; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g7OORHPpfj19ACqHvWONQvGKPztKt+f72l0zmQaxj+2+NbLlUAyDgymIliuZ5p1YRXzvZwDfNSO35HsgeJada064HuGBv50w2N2lKHNk3TbSWefIG0hAE39bzvcUoxBmhxH3dAxe67jYjkzgOiyuVGISEQA8p8aJtUEjpg94X46UK6vceDhhCrNK4wysn3BgW5Bt+Vi0WmprK7smPgsdL/v0EpnenqTVD/CfjKam7S2wqxjtG2hPOGy6RvGeOrQBYzkT4HcG7YMe9uMW03rhOVcBvtcX+QBbPFzzXpU2nzdHjoB91k0XE8Po7NydYgJUQDHOR/5x/EHoY3nBjkOMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYtS6hTJBMm9dryCKWVSo9OXrAHJNBgdctI+DPq1r8Y=;
 b=PZE22qD9aOEpgTDoGyPpw/9EV2EgtpNGvh7C1A46KOgVxy0nxQGk5HnY3rkJOu4+3CO43KnzplXaDHEtOtWS/faCa1J+v5JD7EJRX9xegrhyJzNwW/dCnmkCcYPV1idYzl/f6QsmSaMFYJPT/bBaLD38uP97ZthCpQfu/gvkc2EDiufknhiH4Azr4effzzn64AK8lFEqMadtdL7Xv6kVMaPsF1dtQ1lzof6i9CQ8P5YLAhOotsW5OO56xFaDvEpd9qrZ013bjM8VbI3kwrEkA/fLf1Vmsyz4oWosASYxZa1XlM/05aNuArTJ/+eQrdWEEucgxG5jnj59VUx3zkc8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYtS6hTJBMm9dryCKWVSo9OXrAHJNBgdctI+DPq1r8Y=;
 b=whScQZvqeRbTFdJsEgPTNZ1zysTtXcNjJwTYFOw0RzGe2AuDFFEkW7ZHU0sx65PGz8o6ADIYv901mJk/vw5FqlcvyIVSKrTRgVl35hp38ScX4YfaTk8mw1yZxF8Hu2ypDfQs/jdPXnJU0RvgvLtqdiOhR6crTcnWSwsDDuy+vg8=
Received: from MN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:208:52d::7)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 07:22:31 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:52d:cafe::a1) by MN0PR04CA0011.outlook.office365.com
 (2603:10b6:208:52d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 07:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 07:22:31 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 02:22:28 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<Thomas.Lendacky@amd.com>, <maxime.chevallier@bootlin.com>, Raju Rangoju
	<Raju.Rangoju@amd.com>
Subject: [PATCH v3 net] amd-xgbe: synchronize KR training with device operations
Date: Fri, 3 Apr 2026 12:51:57 +0530
Message-ID: <20260403072157.1042806-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|BL3PR12MB6380:EE_
X-MS-Office365-Filtering-Correlation-Id: 4db7b0c4-37bc-43a6-4f8d-08de9151c507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I31ue+WNrGd9Za8w6CmoLqseL0wFjXfRq1INKwFF2eg7NA6E7JSmZM2mC1P2cb6eVnfPnt9qVGNzfcR3CkMnG1kal8LeRz3AKfy1tJ/4OUFgf8oB/qMEWCLPInOPYX4BKqEiBIiGWt4kBIrxR9sFWphoNAb9ielPBAQXklIQq7zsu8qjVRr388O+MJaxlOy4bMIXGKkh1YtYViWmPd+5sdSgtyOlNWTrYWv8KZ+p+lGSoRq8GCGsVuHTh5iBPM+N74YVJh5hwO82OdOK3jPZxapGZ7R95PhFdoK4FyDjHKWLNp8hGUaYYEHdy9eoVj175mNNO5EOWXaA2y+NspkXHubzs5XDee0bRInx/En0+WkLASzXZ6xpNXN6cz3/LDdM/MKJOh0z7otdSnePLVMkSqwH5+0gRi2ZW5FhzkhGj3CL7qErbipGS0e2vvfGJL/rX5G73hS9HXKGlqAoW3DqPUVM14UovFrXsb1B1R67hgeWnNAXKKNNOUpvbr0wGo8CXmMvpbRBNkqjSk6l2UJbuGEGk849+9FpNM+T9wnOR523lSJ1fpdqmdV11AQEWS8kGUSuoV/gtXiYsShYi7rxxjznM4hWP67U+BQkkkuFv2LUhGb5DprU+NC6l5yznVAw+IAKXvCi+GtwCY5aqGzFZejS/tza+aAFCtsucLbhAH/m+JTvwXwDX0vGVIUAnOZsWK+4XEcvGNy+zRX6uRXtIQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4TfWo8yPwEF+CRh4TWX6YFVLaxqYJMyIZSVMtYGS7cNVi3UvTQfvBlABP5VFURejvjBU7D8NH0Lp+xa10ETfo60QabjlehojEddjE1oNAbfjHUID7TR5z2uafK1ZxYtDJzDGd74WnjaFJlvpNpov0x/IPxVycSY09a4mfIXdaOtFAWspLrWS4kkI3L2DR/z3TI9E2AaXIr3PE/mdI4G3Fw477wfX9EjisC/1zAkAxT5JNGJcRxAN+mkmER/Mwd2u74k+c1cL7nQO/zY9xE/HD+PMhyHm77bI1PNVSuykijuCCPqmG25Q5RXMZqIG6C4CiOPIUs3ZxWan9bm05bEYW4lS4YOwAr+IjV/74TxHcSIDjUoMpzWv4HTDE6MAhcLXHqvKy3OdUkO92QqY1ziPKQ7FJRv34cyMo49zSv56d8HFQuZP6rr640mXrPWz9fEQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 07:22:31.6731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db7b0c4-37bc-43a6-4f8d-08de9151c507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
	TAGGED_FROM(0.00)[bounces-274918-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C60A2391B40
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
Changes since v2:
- address the changes requested by AI review:
  https://sashiko.dev/#/message/20260318091608.1266381-1-Raju.Rangoju%40amd.com
Changes since v1:
- use scoped_guard() instead of guard() for functions longer than 20
  lines

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    |  7 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c   |  1 +
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 85 ++++++++++++++++++++-
 drivers/net/ethernet/amd/xgbe/xgbe.h        | 13 ++++
 4 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 23beea48ae26..67dcb72ac776 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -1312,15 +1312,18 @@ static int xgbe_start(struct xgbe_prv_data *pdata)
 
 static void xgbe_stop(struct xgbe_prv_data *pdata)
 {
-	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	struct xgbe_phy_if *phy_if = &pdata->phy_if;
-	struct xgbe_channel *channel;
 	struct net_device *netdev = pdata->netdev;
+	struct xgbe_hw_if *hw_if = &pdata->hw_if;
+	struct xgbe_channel *channel;
 	struct netdev_queue *txq;
 	unsigned int i;
 
 	DBGPR("-->xgbe_stop\n");
 
+	/* Wait for any active KR training to complete */
+	xgbe_wait_for_kr_training(pdata);
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
index b8cf6ccfe641..ed524703dd8c 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
@@ -2095,8 +2095,75 @@ static void xgbe_phy_pll_ctrl(struct xgbe_prv_data *pdata, bool enable)
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
+static bool xgbe_kr_training_in_progress(struct xgbe_prv_data *pdata)
+{
+	struct xgbe_phy_data *phy_data = pdata->phy_data;
+	unsigned long kr_start, kr_end;
+
+	/* Only wait for KR training in specific conditions:
+	 *  - Inphi re-driver is present, OR
+	 *  - Currently in KR mode with autoneg enabled
+	 */
+	if (!xgbe_phy_port_is_inphi(pdata) &&
+	    !(phy_data->cur_mode == XGBE_MODE_KR &&
+	      pdata->phy.autoneg == AUTONEG_ENABLE))
+		return false;
+
+	/* If training hasn't completed, ensure it actually started */
+	kr_start = READ_ONCE(pdata->kr_start_time);
+	if (!kr_start)
+		return false;
+
+	/* Training is complete - no need to wait */
+	if (READ_ONCE(pdata->an_result) == XGBE_AN_COMPLETE)
+		return false;
+
+	kr_end = kr_start +
+		msecs_to_jiffies(XGBE_AN_MS_TIMEOUT + XGBE_KRTR_TIME);
+
+	/* If we're already past the training window, it's not "in progress" */
+	if (time_after(jiffies, kr_end))
+		return false;
+
+	return true;
+}
+
+static void xgbe_wait_for_kr_training_inprogress(struct xgbe_prv_data *pdata)
+{
+	unsigned long kr_end;
+
+	if (!xgbe_kr_training_in_progress(pdata))
+		return;
+
+	/* Don't block the auto-negotiation state machine work item */
+	if (current_work() == &pdata->an_work)
+		return;
+
+	kr_end = READ_ONCE(pdata->kr_start_time) +
+		msecs_to_jiffies(XGBE_AN_MS_TIMEOUT + XGBE_KRTR_TIME);
+
+	/* Poll until training completes or the training window expires */
+	while (time_before(jiffies, kr_end)) {
+		if (READ_ONCE(pdata->an_result) == XGBE_AN_COMPLETE)
+			break;
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
@@ -2104,6 +2171,13 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
 	/* Disable PLL re-initialization during FW command processing */
 	xgbe_phy_pll_ctrl(pdata, false);
 
+	/* Serialize firmware mailbox access.
+	 * Protects entire command sequence including busy check, PLL control,
+	 * and command execution. Uses explicit lock/unlock for compatibility
+	 * with goto-based cleanup (per cleanup.h guidelines).
+	 */
+	mutex_lock(&pdata->mailbox_lock);
+
 	/* Log if a previous command did not complete */
 	if (XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS)) {
 		netif_dbg(pdata, link, pdata->netdev,
@@ -2115,7 +2189,7 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, COMMAND, cmd);
 	XP_SET_BITS(s0, XP_DRIVER_SCRATCH_0, SUB_COMMAND, sub_cmd);
 
-	/* Issue the command */
+	/* Issue the firmware command */
 	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_0, s0);
 	XP_IOWRITE(pdata, XP_DRIVER_SCRATCH_1, 0);
 	XP_IOWRITE_BITS(pdata, XP_DRIVER_INT_REQ, REQUEST, 1);
@@ -2123,11 +2197,13 @@ static void xgbe_phy_perform_ratechange(struct xgbe_prv_data *pdata,
 	/* Wait for command to complete */
 	wait = XGBE_RATECHANGE_COUNT;
 	while (wait--) {
-		if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS))
+		if (!XP_IOREAD_BITS(pdata, XP_DRIVER_INT_RO, STATUS)) {
+			mutex_unlock(&pdata->mailbox_lock);
 			goto do_rx_adaptation;
-
+		}
 		usleep_range(1000, 2000);
 	}
+	mutex_unlock(&pdata->mailbox_lock);
 
 	netif_dbg(pdata, link, pdata->netdev,
 		  "firmware mailbox command did not complete\n");
@@ -3743,6 +3819,7 @@ void xgbe_init_function_ptrs_phy_v2(struct xgbe_phy_if *phy_if)
 
 	phy_impl->kr_training_pre	= xgbe_phy_kr_training_pre;
 	phy_impl->kr_training_post	= xgbe_phy_kr_training_post;
+	phy_impl->kr_training_inprogress = xgbe_wait_for_kr_training_inprogress;
 
 	phy_impl->module_info		= xgbe_phy_module_info;
 	phy_impl->module_eeprom		= xgbe_phy_module_eeprom;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 438033a71523..be92f0607d28 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -203,6 +203,9 @@
 #define XGBE_LINK_TIMEOUT		5
 #define XGBE_KR_TRAINING_WAIT_ITER	50
 
+/* Extra slack time beyond AN timeout to cover KR training completion */
+#define XGBE_KRTR_TIME			100
+
 #define XGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 #define XGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
 #define XGBE_SGMII_AN_LINK_SPEED_10	0x00
@@ -844,6 +847,7 @@ struct xgbe_phy_impl_if {
 	/* Pre/Post KR training enablement support */
 	void (*kr_training_pre)(struct xgbe_prv_data *);
 	void (*kr_training_post)(struct xgbe_prv_data *);
+	void (*kr_training_inprogress)(struct xgbe_prv_data *pdata);
 
 	/* SFP module related info */
 	int (*module_info)(struct xgbe_prv_data *pdata,
@@ -1015,6 +1019,9 @@ struct xgbe_prv_data {
 	/* RSS addressing mutex */
 	struct mutex rss_mutex;
 
+	/* Firmware mailbox mutex */
+	struct mutex mailbox_lock;
+
 	/* Flags representing xgbe_state */
 	unsigned long dev_state;
 
@@ -1252,6 +1259,12 @@ struct xgbe_prv_data {
 };
 
 /* Function prototypes*/
+static inline void xgbe_wait_for_kr_training(struct xgbe_prv_data *pdata)
+{
+	if (pdata->phy_if.phy_impl.kr_training_inprogress)
+		pdata->phy_if.phy_impl.kr_training_inprogress(pdata);
+}
+
 struct xgbe_prv_data *xgbe_alloc_pdata(struct device *);
 void xgbe_free_pdata(struct xgbe_prv_data *);
 void xgbe_set_counts(struct xgbe_prv_data *);
-- 
2.34.1


