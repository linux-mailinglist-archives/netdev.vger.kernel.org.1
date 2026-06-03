Return-Path: <netdev+bounces-294542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id meASOTOlH2qkoQAAu9opvQ
	(envelope-from <netdev+bounces-294542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:53:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2096340C4
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:53:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=guY0CLUf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294542-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DCFC3078E49
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765D3F0AB6;
	Wed,  3 Jun 2026 03:53:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011001.outbound.protection.outlook.com [52.101.52.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BC3E4C75
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 03:53:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458799; cv=fail; b=mH9yfVDOoLhnCtE7kNr8eYnpde67QfxpP35Wqhz3um2p9DBMGZHEDYOa/jKnzUlnlH7QmBnhtBfM4OpQvZjTtHGyuRe2UUsV8nm3WKr1NI8eFTZV+Y/lHEHq9zPPGxPn3kysas97fr/kF/td1xJuRZlqjn4kQMo5RmleRtvW9H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458799; c=relaxed/simple;
	bh=/oxaFGkh1jBG8BCPhw9pxZUsYhsftLaFuR3csz0F+Z8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cMMelky62SbcH4OXaAUNKvkVxM6+tQMoEtxiZ4yqXir5P00GUavP8PaxHVdkJzKbUZ6F1UCj8/+zOruh6vtGYXc1dBToI4tnGYHucQa2GZbn4tv6ax5FqoE25y3bA9WOuVetATRfrj7n5IbROCnmxnvhkSvzeuLVWYgmWThbCFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=guY0CLUf; arc=fail smtp.client-ip=52.101.52.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLEBFGnRXu1qV9GkO+M3CKtHG/wvNV1uCqwLmkrAEdMUDhk/V4wMsYfQWe/YeCn8ZAxGyWJBcJQ4E+XsuqvajT57qYcCNSEbXpVQg+wS7iXJYGOIR8bLHEf8FMzSiYWVEposSnShsxEYuOPISOjn/RYx0EOnv7N1YK0GcxkuBjD8TK8LbUyo6hdrMz2hsz38yfOZn4bT1Fd2YA/Bms4UCfvNdYCx9cxlUQ73hqzpai87KxUKTmMzDf5jOoqkYzScqvlsIEjMaJXukv8DvW2WeulMh2X03tlrJVaOK99aaGGO5fCSov3Clm1ef2yo35Dh03wJkKNndaKKvNg+YGv/sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPphc42rFLvtr/hX+8TOI2iziEhxNtgEViTVkM839/I=;
 b=nc4Jtsbn2J2jj6+t3Uin7Ym/Yu0BRT1XodnVcfeocn/IRV1hwdKA7mPVE/+2ohKltQ9bsPlUc4uzKHnsSOsPJwXAO2ixbF48WBPVELvtfHXJMxoknJHhB0TcT0Gea+ceYK8ncQwNPQzuGwXiRowBpob4pR3VmiU8OC2FQk8RfmCt9wE39oJMdeLgJV1/iv+rHrO2q2hs+HCUN9TVKnW6KcHYfPjpMddhug0M/zKpDs4t299G+7/nzUSykYQs2CO/d/3VaKkDScPaZk0vPoK33WJo2faI7zVMg5UPntTq2n5juO8pHrwwR7KvEs3IJIq1WviNducj1cXbTMaNzoQNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPphc42rFLvtr/hX+8TOI2iziEhxNtgEViTVkM839/I=;
 b=guY0CLUfV4xcChxVzITJNAjKB++cMB2P5SmuPELNq6TmzDY6Aj2Dii+jWPZObhQFvjRckIZxo3q9dpj35vdpXcGXYjVcl5j+7NtZL7JP7EdbBiDNPsgkr9WRFWQEg7JQNPr5sajs+TfFPmtoSs/5CFSAia5ZcLz2rQLy+wWJSvg=
Received: from IA1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::12)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Wed, 3 Jun 2026 03:53:13 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:464:cafe::12) by IA1P220CA0024.outlook.office365.com
 (2603:10b6:208:464::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 03:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 03:53:13 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 22:53:12 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <brett.creeley@amd.com>, <eric.joyner@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>
Subject: [PATCH net] pds_core: disable bus mastering in pdsc_stop() to quiesce DMA
Date: Wed, 3 Jun 2026 03:52:45 +0000
Message-ID: <20260603035245.32972-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: 683b3702-d9b8-4649-5b95-08dec123a2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|3023799007|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fEXHqmFZkiZ/Awsfn6gTYJAOp1pAQTxw2bpr2041ICUEKp0nQk3jmL6PWOgXElg0dKO25ROh5pS3eOde4pnmiZxTYD4P7BChIUngN4+R6NHmXDdgUhj01qvgq2jCrW3uR/W/Jb8qs3tblUOI0Jci5UW+iX3nOWGwAGtRenqgwrpsYv8gOA85y4lTYMiSCTW2QT6U4zAlPK55EN9YGf6k7c9wPIhyu1Y7cgr4MgxSv4vPFCX/czzNQdPBcOy3wQbOe0StHx1T0BacSu1IREfMLBS0MQ3SWhQVFqZaLpiKiQmr18xWs7wSze+CbevwBruZ64jjT18IwRCohmv1CPqZN/qTOB/tVRNgX2YFPUKSDMao0Bdk/EMp1GlkFPzpKL+hNmyajQp2jECLHj5j/u3Vll9zLuU8W9RLwYLEKS8flPXJ4C0cv6ms4wVgx8WZCKczNkkEjJp/XBpPJmFLnYaLzZyfCgsyNL1qCooWE8UUoIwX9h86bwv7kpzSo065AUwagGCJebnZyHhwBB5FmshNcTH5lYGcl3AVkT8cGR9TDl6yoZSDRhxu8qEOiNujrz5El3gOwxma+N2UMX+xdPppd3rW8ph2oEEbnXlC6d/mCiMYS/LktCGUbULgO2+EGVIROWuVmiQVGwsvLq5nog4gCDDEEx69czdn7Ap4dTfZjTa6HtoOgDiGnuJ1CFgSzh13TqJY63v8d3Eiic9S9Zq0KBwmWAZ6K16qS/Q7r6lByg0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OC6RfzdP48PdVZRto7Ssrcw2UE6X81SYIX8oTEyfYKFQG31PhCK9R21l+EASZaccRfdJIRpIKAdMh4TREUKDpLTF7Qo1zSEDxWCl39L+tIts0n86mAVvTohJ0EmBFzm6Ype4XI8LHT79rXi/Nl4yaQskiK4DZXsy0Hh6SDx7OOZx1+xXO811GD61BmgtnTYM63rWCH/uhiCIQ1bqFa28VK2nVcXU981HQydGHzj0NTP6SEoMtYSurqH+QKvm1Do4p0Y4F38+NH1P100l842Zm+m4K8sAo0UmhYPNy/b/Gydec1JtMXlcrlebLW32XEd51xiqkR2vRGSmeN6IztIwFUqtvBnmvJAvDUBN0Ut4+uVG/WjcW4uDUrRD8VX/5pWPMuf8ufFnh7Ht8HRREb3V0Mop3WnH1Mi6OjPjUuThJNS65lhGm2cRb/j7FX6oaH4a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 03:53:13.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683b3702-d9b8-4649-5b95-08dec123a2b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294542-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:nikhil.rao@amd.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D2096340C4

pdsc_stop() masks interrupts but does not disable bus mastering,
leaving the device able to perform DMA after the function returns.
This can lead to use-after-free if DMA buffers are freed while the
device is still accessing them.

Add pci_clear_master() to pdsc_stop() to disable bus mastering after
masking interrupts, ensuring all DMA is quiesced before teardown
proceeds.

Add the corresponding pci_set_master() to pdsc_start() to re-enable
bus mastering when the device is brought back up, such as during
recovery.

Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 705cab7b0727..27369b3297b2 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -494,6 +494,7 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
 
 int pdsc_start(struct pdsc *pdsc)
 {
+	pci_set_master(pdsc->pdev);
 	pds_core_intr_mask(&pdsc->intr_ctrl[pdsc->adminqcq.intx],
 			   PDS_CORE_INTR_MASK_CLEAR);
 
@@ -504,14 +505,15 @@ void pdsc_stop(struct pdsc *pdsc)
 {
 	int i;
 
-	if (!pdsc->intr_info)
-		return;
-
 	/* Mask interrupts that are in use */
-	for (i = 0; i < pdsc->nintrs; i++)
-		if (pdsc->intr_info[i].vector)
-			pds_core_intr_mask(&pdsc->intr_ctrl[i],
-					   PDS_CORE_INTR_MASK_SET);
+	if (pdsc->intr_info) {
+		for (i = 0; i < pdsc->nintrs; i++)
+			if (pdsc->intr_info[i].vector)
+				pds_core_intr_mask(&pdsc->intr_ctrl[i],
+						   PDS_CORE_INTR_MASK_SET);
+	}
+
+	pci_clear_master(pdsc->pdev);
 }
 
 static void pdsc_adminq_wait_and_dec_once_unused(struct pdsc *pdsc)
-- 
2.43.0


