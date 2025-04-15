Return-Path: <netdev+bounces-183053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76373A8AC1D
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1098442195
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54402D92DC;
	Tue, 15 Apr 2025 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t1B33wOE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022D92957D5;
	Tue, 15 Apr 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759808; cv=fail; b=bF74vPVhcCZDdondeYROUiMzOurbLCAAxHk+koa2EBwgpej7/nqzG2uBNqLjqNpA5HljeYnUHXKS8kQSDqOI7TVXSqNQDP8EhbmLuE+8BPYupBgUYbDKcSz7jO2lgVNh+5om2i1FXUvTkSL2I5YCSTghnLQIeeKsSPshPfUobis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759808; c=relaxed/simple;
	bh=Xl5CxA2KahM9UQTmF87lPXPekYu6kKPOD9zR02bKDJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qO9rlp/MrU5tY96GVfZL8KSxM/GeyVolLdD5IXfqiHxMO9Bo5SzXnbYhASfdcD8uwyyuUM8uTfOdbfnlQkVVf0mUbKzFJJqfHVR63ojyrasppC4/8B2hu5hbuPD6OcXDVtsX1jJOKOItRvf2jsLuqylMWCddx+z35e+fX6Z9ZSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t1B33wOE; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvZ5d27DzgIYlMHsNUffxrinlhI25FB4xwwGHmO7jUPGxIOk70OMgyIFyXj5p6DnbFndJOxKdIEO5o4yv5sTUkw/5a3Pk5XjF8QXeKneuM1nsNaeHllaT0KFUub87LqwLGA2v3QfrUAX837wS6sZBW26qRU+jWdI34Ld3UaKPGbJZttDY61G3bENYFikH1tnUjWP44+OeDRiIIOSxroJAX9q5EvqTFTYtnYtpfxlY8W3nmFMdNMOMoPtf67IDN4qFL7kk4/IgHNzCncJQE9qhb0bX4z2jzEHBRDkakOMyTwwhbQySPwViPUJ0age/1Z8r+idJ6XwvANPjLOkn1Tn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j927mxE6lkJ6neG8DDki8hJvPmQwMaRuI/AfSDrrhr0=;
 b=iEptq1J7WcAMlIZaFU2ND/kYYD0hAJCFytABzV/nJH1EFHNO4aFUMlEuM1Gqm0CZUlOUaVGYFb/419rmdTDLEE4PE12SrBzGaaPJ3DQrzM0sNFHGED6WmyBmmVncKyKjyU7fM1XT39EuzEi0nX+v/Z0qz4vt9siNw1ifE/+9Re80uCq0cUK/CEg38OEAc0eCMIt7Mi/NgpxxRka6Ieb5GOlwe/TDPNmBgU/ioMsJVvgaMrx1TREIviu3oVrixHX+lU9r05aie+P+CDI6NUvpybabcFrxBgQ3VvGyK89h3h+o9+h3n73ec00bGaKwUMnE2bIrXrAXzXX0MfqT3dRBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j927mxE6lkJ6neG8DDki8hJvPmQwMaRuI/AfSDrrhr0=;
 b=t1B33wOEh8kJqXVXOJANKpjsROOG7hnuPIeDyFiA7DGT9arkLPUYLjYW1PZhVmAKpjOV8QmUAVd39Vdsj3wBdm+4Ty9C1uOnrfWzxrDxA1QNMH+32hRvEBEukSbHLkL3+vT+XgzgQ376lP3eShnmZcCh47pIRmD0BSXODF65peg=
Received: from SJ0PR05CA0065.namprd05.prod.outlook.com (2603:10b6:a03:332::10)
 by PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 23:30:01 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::36) by SJ0PR05CA0065.outlook.office365.com
 (2603:10b6:a03:332::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Tue,
 15 Apr 2025 23:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:30:01 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:29:59 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net 4/4] pds_core: make wait_context part of q_info
Date: Tue, 15 Apr 2025 16:29:31 -0700
Message-ID: <20250415232931.59693-5-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415232931.59693-1-shannon.nelson@amd.com>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|PH7PR12MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 291dbca8-0e5f-4ccb-94a6-08dd7c7571ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jc4XoEg7Ak2FrPexUw7Q4S0FsmtLefdgfAQQqLvZZ0bGeBXpw8Gg7eqWZL+n?=
 =?us-ascii?Q?1fg/wFtN3eoMpN/Sf0SjDSl3sack+QckHu1wMySzaxCKgOT4QtmWIO43z6is?=
 =?us-ascii?Q?809c4+TvqUTAHf5Xs6dAouBhMGkmUCl/wThc2kKzobhzEOo84T2x2lgB7eDN?=
 =?us-ascii?Q?dUFs1fnChoySxDAkGRqTxJqecsE5dDtLCyAJnjoY06eKRhUbgepDPs5SoQD2?=
 =?us-ascii?Q?DzRwSxn0ju8XswOoppz5qK8X5TfIMJ1NwZh1XWibJI2GvJpbWBiqaZJUIebG?=
 =?us-ascii?Q?nzNe/XpqMC1T5fRu026qNxIdnzX/eo5+/9cFYHkVuzGl9GLRY8g8Suntitzu?=
 =?us-ascii?Q?oGC6Y08gh6fhNm9w7+XT6rQjywzSQC/tDUb1es8HpT8J423YgZlVgqj2OKn2?=
 =?us-ascii?Q?Sq8aVbdbKfIS/2nwWdoEgTh6H2aFC16CmfkLJz+GoXzB5QR1TJmjxoy/qtDC?=
 =?us-ascii?Q?QmYNDvwgAqJ4co+65pyCbVBqaWGIy0vjgLpgwPaLoF69z5WiaMcGl7KSSmXw?=
 =?us-ascii?Q?A3aNKtKo0s50rCDzOLDiIJDfcwvulfE5spyQRophYbS2aivEy9YBeI9h8u8Q?=
 =?us-ascii?Q?H6HSuJ2sMEVmLoCIEkkQQSxH6VAP817ckIEWZXVucnPbrWDclOaVmLDN5zrg?=
 =?us-ascii?Q?zC5FobHLvrnp46OJIiYtLG/qT0hYFQuTVusly2nUSgcedRldDMLnd1etZ2NW?=
 =?us-ascii?Q?gflq86xzFbLvxIa9yelSRNklBweqlbE0+OEWV1h/y2UcFrwtXeFjp3S39SK2?=
 =?us-ascii?Q?tZwntkFuPS74gYqVhWCAOr4EUGx31UAgER9uyLyBwZ3vyWpygzZkPQLeVRJD?=
 =?us-ascii?Q?ckMVxsMTQl5jiL+mydQ2uMo36N2SJuQ7HOsVsHJBxmmRmtbQ6U04hj4hKihA?=
 =?us-ascii?Q?5IHQoLrHaqMEmpW/TxYH593tsmLKwp52KTLP9ve9uWtFk4iaiE9vaZy8ZBvs?=
 =?us-ascii?Q?VV4f8r5vWiJjbgt3cLBm3qE+X6TrxAKkF/ek/m9UXAYhgy14CGsXz3RzjNLR?=
 =?us-ascii?Q?0lxcUIiu9oIG3oLi+wc4Mx+wJpe9U/pV44BrzadIh2z1XDoaTyaTIxN3KDdW?=
 =?us-ascii?Q?KBYCBrCnuUt2jd0AmzAdP9Kh9p3hjcVOzBiHpcbwSJctLDOlgq9zUFlCQYBu?=
 =?us-ascii?Q?lD38kznoX038UgNVvoaphnOagNRFOrxE5B2tB18nRD7mFWbjzpKuQa3PVVxe?=
 =?us-ascii?Q?X2jZXbVyfTP6hPTQJZPh9I36YNsEcuqsrwYM01/aftyCbKypgz1yOXiwo4F/?=
 =?us-ascii?Q?6wIr2FH9WWV+QbUYQZVPvyLdqxI4KKaZDTplYyDZUMULpb22IqBLKQpx9W6O?=
 =?us-ascii?Q?RT2nEALxTYnJzuXPcXWwvExFqkLKZX2w+fK5au+BeuWtacOqjvyUoKHd+q1d?=
 =?us-ascii?Q?czkEi40zAU2dI3UoU0l6wVADjlazueBbz/HsiPI4L1RhQu23aM/muDTcdqoI?=
 =?us-ascii?Q?KZeDl1RNxV53rHJd0WdU2xzeZVB4w/wmXC6E4+rHvhSv8td/c92FsXx4VR3Y?=
 =?us-ascii?Q?AMY/7jTNtT1sRIGxkZchTpFPnQiqYdix39AnbWOG/uBgwHS1MyihdcrJkA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:30:01.5941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 291dbca8-0e5f-4ccb-94a6-08dd7c7571ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/adminq.c | 23 +++++++---------------
 drivers/net/ethernet/amd/pds_core/core.h   |  7 ++++++-
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/ethernet/amd/pds_core/adminq.c
index c83a0a80d533..9bc246a4a9d8 100644
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
 	unsigned long poll_interval = 1;
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
 		poll_jiffies = msecs_to_jiffies(poll_interval);
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


