Return-Path: <netdev+bounces-179984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F77A7F07A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B3B189168D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBED22D4E2;
	Mon,  7 Apr 2025 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMRlWxcJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C522B5A1;
	Mon,  7 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066317; cv=fail; b=q259ZwO2NJ0jGBmzpes4q69/93WWXuPlsxzC1s+ulBSQC3Rb5gkrZcOJx6mRNKePTSlDaDPAYzWESrxQaLEQ2WLSDMEWfo6TGw3f1NX8sZ5Q0/RLyW+SFCUv8V2ivsN0YoxYuM3ECRA91T8GxdWTP05U2KXfjHWDfYHkNNGeWfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066317; c=relaxed/simple;
	bh=iFYXoUdF3W8taZedS1xk0FCTEBI6CgwrfHDv9Cl3jF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sibo47cZxh0tLbvVkLfVBg+Bhq1JH1yksoYgWsO8BKWRG45GWsEOcVvz4hkhBCOYn5oI5UGHOXt2FWL1emR0MVnO5g0l2AAlQj2v/DJGp4oNTStrmNsRnFEw2IHlapqnxf0pYpZkM/HBrWbHSaql7UIgNK/1uZXvbC4K9LtfA5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMRlWxcJ; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRo2LCj9KdLrpHrIue0zfu2nEvR9Q0exv+vjlxglTMqST+YQTd+itZYfKK+lxiW58MPPCsIZCX9NLjAhq4dzYBsjwmlkmR9a+kRwcs5FZidzxmI+VWwSLeMEwJhHf4Lg/4QJrvRwh8Exj12daoV9BoVqMGvJABi1qw5mxm22GVGQPK2nNDN5Y2pptSvOF/gQv86X2CnbC+KNBam6qZI/+0UHekz53wVKHVKm1RuRSVlVKYJ4hOMUJJ2JcVPAxqGTev0m7BqrJUrw37v37Zd5TyQHFrxMT4CGEslY7+zlMtuHSZCjtDG1RjyX3HVDBTEdXHogw9/YI0N0G4Ig4vz6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbRfsUR9h/xdmIkJ+voPFjdBSud2yuK2UaqSyKlCj4o=;
 b=ZtmGfYJIrDELDAi4q3P1m2IOonYLyhVAWeYj0IPPAPGTJPyLMEJwb67Y+V3qPxQip+SgZIGEIGyjWPTA4X88Bo3siyu5fIdbSQKFWW30L9UHdqpTmLq9IjxdJyDZpLmTCOQHBfAy0adod376wmbF1TFryC7h7jC13bCAC0Oww9IUS9ZBgOe7avp5lZCoBT/EHsSGETinH/AH45Ho+Kl/TpSe0r98nh7EhvifRf20poc6ZyCDgSmI3mHFmk2Nc9JU9X/5kHvjZ3TvpyqOmhTVcRs91538OerV1reOdJM5Ctx5yZWjgUxG7oKLCQUuRgyugP8x/rgzi7Htpy0QZAvnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbRfsUR9h/xdmIkJ+voPFjdBSud2yuK2UaqSyKlCj4o=;
 b=QMRlWxcJv11zryobZpH3TvPop/Sd2BSIhBgPFReOFqhZHdW+AdcaTESl9bsCEalK0jcVlBzN9gXaom262F7ynQJlK/f9IcgVpIcNK7XfiqzeEp81YxhlGZRsPDEm+eYU8VnwJXF6zZsRh8JbLSzOUml0mJjwY8tQVgmmPe9NUak=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 22:51:50 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::32) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 22:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:47 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 6/6] pds_core: make wait_context part of q_info
Date: Mon, 7 Apr 2025 15:51:13 -0700
Message-ID: <20250407225113.51850-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250407225113.51850-1-shannon.nelson@amd.com>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: c4abb84b-e0b6-4ed6-a801-08dd7626c882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IWURqKbR7cAZNhHybQH6YmpjVt5h+fMi2LgmQz49E/B8OKW45WZHP4Ih469a?=
 =?us-ascii?Q?Fh+StW3p65XTb4pqyjly1I/DUPyV5JPSoGNfjru2VAgBFo2XZ0reSsGFr+oh?=
 =?us-ascii?Q?ZALfCIY/Z71YkC+MiLDzRhWXwUIvHbL8B5u3axV9vesMENGQQRzusHc1gSgG?=
 =?us-ascii?Q?rDgIrN/DMabJChT4GQJI9f4kjeirgdyvT6nwU47RW7DIPfaI94AhdfKRVBps?=
 =?us-ascii?Q?/Pix7wNG7w/IhH90KL4aOBZM3Gr0M/MODw7KptraSACV+UFUlhxtFwo5RKe1?=
 =?us-ascii?Q?YA13vzfVBpoS7rdp/UGure40TbTpycfU5/+tHbZfTtB36wItFFfeaqihkLYN?=
 =?us-ascii?Q?tS2LAk6e4A28ccr3IZ2bkXVS75HBSXFHCiR7L0SBp3Wv71R0Mv3GGOBHWhjJ?=
 =?us-ascii?Q?gQrg/Y42upuUqvzTdGK3o3mHjn0IzbkcowWX3jFeTvppIlNozzx365NSkz1R?=
 =?us-ascii?Q?a6znBnkVk+b37pJdnrPgUNHvXB6dGY6SLKk54LZBVx4VpAdvs1MV+5e5hEnc?=
 =?us-ascii?Q?SDvtRsFWv9pdFCC1F0TqGlCzgrtwLk+FPLQwSXSXd5pTpBlBsKBvNYTgrT46?=
 =?us-ascii?Q?haljfmAI0fL+MULQKGZeibCo+/UEyL4pXxOtNrLv2g6YROQVyS8KjTbiqrO2?=
 =?us-ascii?Q?OE4ZlCtTyOPF7E1HaU8qS8ec8yTcBRywh7kGhydRBKeGe6SW5w27y6Q9W1EF?=
 =?us-ascii?Q?Dvh+s4AzGDcTFcbCLWN8nNBMP7aXY68P0hgx3xNzolKrsHz0DoxjfTE5PidV?=
 =?us-ascii?Q?gEEPTauSMSDDcptUTm0wXnFlK9RdXnX6a18bdPL/sREQqrmz0G4O5AQ7Qmpd?=
 =?us-ascii?Q?L2209sxF7y+jvMbVNqiahY9mfSnMjhxdjeb6lnx70LwYbssZKgdF9164TY3Y?=
 =?us-ascii?Q?VEWT5bMaFmcU2hP1o786724KAZPpRYRbVq6vlp1SVfwUtFor8Ofp0tJxL93t?=
 =?us-ascii?Q?dKCcUPmDCdsb3aiGp4icAtg7JSHJh05/JfGQ7uDoA41YdrNUDS5ss0dVOLzm?=
 =?us-ascii?Q?qRr4zcfsyIeAeuB/0UKktfX/q8rEA0GLdORdagQaNOdSkakrSK9lKuIG97Q6?=
 =?us-ascii?Q?BXLuP4rL+1ACHtrOUhnNfrY0LmhED7uLks8kqaQI34HtXs8eGxwwM4z5LGIt?=
 =?us-ascii?Q?FfsFUbD/qMkKE6xomKOVqFVRss7qq9c8QkcWjc97tXIoEyx10G+K4zWX4AZ6?=
 =?us-ascii?Q?8w9nAW6mQ+oJTBLCebjukcuGiW3hwoi+Can1ZH9iSG94SzfYRhlU1RR6jEI1?=
 =?us-ascii?Q?WaANhmmKXw2KI8HuwRPNjxLLeBYmCeeXIu9lDyelgAdN4nzXqVkzTvddNg5f?=
 =?us-ascii?Q?2vfX9wuJkUuTN8kcvODYuJCzpjmh0KW7LurZB0ulZF28kWseeoNy7NZSbyzX?=
 =?us-ascii?Q?V8Bo32Dv8yv9b611t7VlO8b7FQLf+bO+eDvBLkiApVJfB5jWebJ+dxRVWT4w?=
 =?us-ascii?Q?/2bKhiY4Ik+XosY5BdziDob2qGRZUsz7NiDAbRzSsoxm0bqneOkmURFKtvLU?=
 =?us-ascii?Q?YNd1bPARAxHt1qg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:50.0850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4abb84b-e0b6-4ed6-a801-08dd7626c882
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03

Make the wait_context a full part of the q_info struct rather
than a stack variable that goes away after pdsc_adminq_post()
is done so that the context is still available after the wait
loop has given up.

There was a case where a slow development firmware caused
the adminq request to time out, but then later the FW finally
finished the request and sent the interrupt.  The handler tried
to complete_all() the completion context that had been created
on the stack in pdsc_adminq_post() but no longer existed.
This caused bad pointer usage, kernel crashes, and much wailing
and gnashing of teeth.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 23 +++++++---------------
 drivers/net/ethernet/amd/pds_core/core.h   |  7 ++++++-
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index 2e840112efea..86a6371e5821 100644
--- a/drivers/net/ethernet/amd/pds_core/adminq.c
+++ b/drivers/net/ethernet/amd/pds_core/adminq.c
@@ -5,11 +5,6 @@
 
 #include "core.h"
 
-struct pdsc_wait_context {
-	struct pdsc_qcq *qcq;
-	struct completion wait_completion;
-};
-
 static int pdsc_process_notifyq(struct pdsc_qcq *qcq)
 {
 	union pds_core_notifyq_comp *comp;
@@ -112,7 +107,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
 		/* Copy out the completion data */
 		memcpy(q_info->dest, comp, sizeof(*comp));
 
-		complete_all(&q_info->wc->wait_completion);
+		complete_all(&q_info->wc.wait_completion);
 
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
@@ -162,8 +157,7 @@ irqreturn_t pdsc_adminq_isr(int irq, void *data)
 static int __pdsc_adminq_post(struct pdsc *pdsc,
 			      struct pdsc_qcq *qcq,
 			      union pds_core_adminq_cmd *cmd,
-			      union pds_core_adminq_comp *comp,
-			      struct pdsc_wait_context *wc)
+			      union pds_core_adminq_comp *comp)
 {
 	struct pdsc_queue *q = &qcq->q;
 	struct pdsc_q_info *q_info;
@@ -205,7 +199,6 @@ static int __pdsc_adminq_post(struct pdsc *pdsc,
 	/* Post the request */
 	index = q->head_idx;
 	q_info = &q->info[index];
-	q_info->wc = wc;
 	q_info->dest = comp;
 	memcpy(q_info->desc, cmd, sizeof(*cmd));
 
@@ -231,11 +224,8 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		     union pds_core_adminq_comp *comp,
 		     bool fast_poll)
 {
-	struct pdsc_wait_context wc = {
-		.wait_completion =
-			COMPLETION_INITIALIZER_ONSTACK(wc.wait_completion),
-	};
 	unsigned long poll_interval = 200;
+	struct pdsc_wait_context *wc;
 	unsigned long poll_jiffies;
 	unsigned long time_limit;
 	unsigned long time_start;
@@ -250,19 +240,20 @@ int pdsc_adminq_post(struct pdsc *pdsc,
 		return -ENXIO;
 	}
 
-	wc.qcq = &pdsc->adminqcq;
-	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp, &wc);
+	index = __pdsc_adminq_post(pdsc, &pdsc->adminqcq, cmd, comp);
 	if (index < 0) {
 		err = index;
 		goto err_out;
 	}
 
+	wc = &pdsc->adminqcq.q.info[index].wc;
+	wc->wait_completion = COMPLETION_INITIALIZER_ONSTACK(wc->wait_completion);
 	time_start = jiffies;
 	time_limit = time_start + HZ * pdsc->devcmd_timeout;
 	do {
 		/* Timeslice the actual wait to catch IO errors etc early */
 		poll_jiffies = usecs_to_jiffies(poll_interval);
-		remaining = wait_for_completion_timeout(&wc.wait_completion,
+		remaining = wait_for_completion_timeout(&wc->wait_completion,
 							poll_jiffies);
 		if (remaining)
 			break;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 199473112c29..84fd814d7904 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -88,6 +88,11 @@ struct pdsc_buf_info {
 	u32 len;
 };
 
+struct pdsc_wait_context {
+	struct pdsc_qcq *qcq;
+	struct completion wait_completion;
+};
+
 struct pdsc_q_info {
 	union {
 		void *desc;
@@ -96,7 +101,7 @@ struct pdsc_q_info {
 	unsigned int bytes;
 	unsigned int nbufs;
 	struct pdsc_buf_info bufs[PDS_CORE_MAX_FRAGS];
-	struct pdsc_wait_context *wc;
+	struct pdsc_wait_context wc;
 	void *dest;
 };
 
-- 
2.17.1


