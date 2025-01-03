Return-Path: <netdev+bounces-155069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C0A00EA2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8419318849DF
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0855588E;
	Fri,  3 Jan 2025 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u4NjhArB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D081C36
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735933943; cv=fail; b=QV5oD/pPCH8ooP1q2zufuWfTLRLu8BINNjfNMsy5GyYrsEH8xsGs9O/XbiKoKfFuhGxkiSxvTTyincweMzIoEnQvv5sMy0PhVfWicacGSpHF2R/AI+4QR0RlMhdf/a1n2cCLOX0N7BSWNc1kDS2FVGCCgBupK9SGNI1mhYRx0v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735933943; c=relaxed/simple;
	bh=bVnLmwkQ6DF2ij9CAEVFmoKww5wdpj29TY7rk7vaYfM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X8E+D0HHI9Is9BNOqSTF/4QswdApgKpcwvVTUcaQeKsfEAMsLw8YFtCZDfZfBeV/XyefTLsdeJzUvxP2A7VuuPlhiyiTHYugfeJdefnKz4lxW1pR2bleT4jFciADcMlqmVOo8HguFlrQwS827/hZsvo6ek3EC7sm3VgQ+wySDNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u4NjhArB; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBgyUmNHdTvm3cOn59NDtJlUx+5loIi6DJ3UqjIOY8kdXEXJ6D0FtccfzEiViOwEh2U6mWga1+xmodQAjUHEhIsgFPFqczs/b321tdQGEGlDi7E+tX7GUQUnwduTYE9d+x6NibYS3vQQ9e7EFf/73cxM6VeGZhUiZlBbBz/MHRinEub9jGtlpQTdxY28cm7RMJ20HwTUyK2kCj6g+Z9eKDzxGYu5FK+FoM3FToTQuM7vEfSZt2J+BUpCHUma/YeAxvobTaovfbKfP/pkUufLPcmTKQC4mdYHLEXRfQxLA97Jh+Gv0tRlp46+IlN2LbMD4Mn9IKWlAKmyOTXzirVbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3xYR9BB5wD/0qhLGhG9t/ua6avKF1xpG2LushLYRRk=;
 b=S+xjIk0lb6baGVyv/A1iZA6SfMft3QN2ekT5N+KYZLtNCi5ef9fIwqD9k4fbxuqJIO2O9F0pcGZIL2ZCCEk69yrxvr+Gw3Xc+To+7AHL27JGY/NsKyQ0mKv3tx/N7SSHjMiP7aRDET3ryXkDac3P8wJDzrTuoHOEoRQIrvvqiqpQzof8AFgWrfHFlogjZKMPA2abg/1UA4cqCRVm/sjHZmX/cWmc6NCjVIa2q4FsT7A0DBYGq4AvBipo5d4uWgAsFwAgU8t1yjgN0v0tBQhiMAHlccE/nNM2NrLx8fcNcgzDb/h14yjpKA6vdUR6ufPxUkQ2A+ELxiMdZTvXO8Z6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3xYR9BB5wD/0qhLGhG9t/ua6avKF1xpG2LushLYRRk=;
 b=u4NjhArBH2xHhA6KM2y7DK1SW0m8l4y2VkfQHZ8pMXAqJbwSKGLk40YyKoiV9XLITk3iv3205xrT/W5AseaAH32JTWMHN1fCNPf3YGXxZKujN2G8VJJkCSWi+IRalwGFtsek4Yl+4TkcAjcUcVEiOuxqEM9OwkxBeuc+7Po3das=
Received: from MW4P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::26)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.14; Fri, 3 Jan 2025 19:52:14 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::e9) by MW4P221CA0021.outlook.office365.com
 (2603:10b6:303:8b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Fri,
 3 Jan 2025 19:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 3 Jan 2025 19:52:13 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 3 Jan
 2025 13:52:12 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net] pds_core: limit loop over fw name list
Date: Fri, 3 Jan 2025 11:51:47 -0800
Message-ID: <20250103195147.7408-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: ce34b205-78e3-42c5-7b2e-08dd2c301e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pc7ptM2R0WJmyBoMZ56CzednfqrqYToAnm9hpXWSFCkXEUF1K7c73KgwcOMl?=
 =?us-ascii?Q?K6p13ZwWXvEYTxqnYchwpoALZb6J0Yj2ALifBZ5O1xdLXAPAwfbRTpAAGcqV?=
 =?us-ascii?Q?NTTVgPrxcMYFPKZwfwRtMKHo0StjCFd/ttL4F+IkgkJiAW1Bji1t4V6vBBm6?=
 =?us-ascii?Q?lg/0IZ2slfrSWyO9zTAR1lnZjLzxLQD9to5jjyn2NF/7dUPrxv2Jpo1PVZmh?=
 =?us-ascii?Q?e9qsJiuMvM8uhK1/pJN6kk1zwviBQp8Ye4B4HB5lsVouWl59P894n8AYZwAI?=
 =?us-ascii?Q?BGxIPVxo1+kdJNSDI0C0GTR64mX/w1TmmxyriuLIzkKSRP5Jn63CLwr8+Ud+?=
 =?us-ascii?Q?GjXxWPqDXQUQSZpHG0jnQIQDQN0tmcuB5Q3JLHiGOTrrCRFSpNrdVSP5f6wz?=
 =?us-ascii?Q?BLUV678Y/dImiwY7AT8kRgmrnwK3TRvWYrFA+55AQdkRZZBc4fLtO3ENJqEz?=
 =?us-ascii?Q?O51j25gCTW2yYWn9zXOIMvOqg/5GQOK+AZSDZMC4cNZaqOF977ZcHSD4XWys?=
 =?us-ascii?Q?1JVOwv/9OOa/UYK/Lk40QFInAQ1v8ejJWbyJQ9NxMTGeYG6zH3/9hSf7Pznt?=
 =?us-ascii?Q?G348osxv64Kr+Xqyli6Vv6xo3wPnhcmA/4XTw/8y6mpJqnTHw2CKY/dbJmVm?=
 =?us-ascii?Q?AGTWMRlTV193SWvnMPt8K23NGMkmTDosT6z+Gl5MOubYIwB/myTFg0xc9qMM?=
 =?us-ascii?Q?uMlUYC83Va+HGAPrqGm1nSCiwVowG9JXHXbTL9MSMx/BJ543NojVrw1K3PTu?=
 =?us-ascii?Q?yG2OPJ9gsdWpKuzrx8u91jfjquJzjL9J9TojJ8BJyiOSZq2qHBUISeM4RqDl?=
 =?us-ascii?Q?8FzDct1AjlhPI5Cm0jjUcYzIkBIiHZjjkqEnwKcpUovcB5G6SKQBkb11gLra?=
 =?us-ascii?Q?fLg0M2C4Fc+zQ1XPClVVh89mtRApwYYVrkX3WlYu0vmyl7c/ipmR48bG5m1t?=
 =?us-ascii?Q?DhTEPS7tEDeJRVU8miXq3eu/AuRFM8cHm2Ikd8tesg68KHgZXeOni90mh0SP?=
 =?us-ascii?Q?LxsHh6jHypIEms4H/WLWcrZ9uZfuscI7AETAcJZIwU7PzNe0vvc0H5yFTQqe?=
 =?us-ascii?Q?uKgJXZuoosyfAkTDXrUkYORsWq394nKNpDg3599e35zSDWiLEGacu9cZlNw4?=
 =?us-ascii?Q?/XDnhwu2QFqiyybcIXN5fctvhc9mU2BbuSU5VaDo2ttiYVd+hmbYFDg4CGCA?=
 =?us-ascii?Q?QoEauSxkflbnFNYayK6W+AZWxuii5AQqi7MYzxHMsQFC7W2kke0dHBAh3w77?=
 =?us-ascii?Q?qsCvlSSfC+eBRtUkrzPmgzYYN1oIfO8jFIjIcNnA1WN6DiJna3HFbato6oL9?=
 =?us-ascii?Q?WE3OxraRK4ha5npOQ3qFaf4gD6zc/zzKxrm7R9s/07AOkcGntr+63VJSfK0T?=
 =?us-ascii?Q?XONTLwaYC8trx3AztzD4HsPo40cIuwebMm8wnTEu8WqXgEFVGSmFlU7xB5US?=
 =?us-ascii?Q?g2IrEDbf6dvfKNSQSJAAyO+VMO4p3qIlF5Xmrn8SDZBGxfYZvIqV26s7gLA2?=
 =?us-ascii?Q?a4ct61KXVitLODM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 19:52:13.5984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce34b205-78e3-42c5-7b2e-08dd2c301e75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

Add an array size limit to the for-loop to be sure we don't try
to reference a fw_version string off the end of the fw info names
array.  We know that our firmware only has a limited number
of firmware slot names, but we shouldn't leave this unchecked.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 2681889162a2..44971e71991f 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -118,7 +118,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (err && err != -EIO)
 		return err;
 
-	listlen = fw_list.num_fw_slots;
+	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
 		if (i < ARRAY_SIZE(fw_slotnames))
 			strscpy(buf, fw_slotnames[i], sizeof(buf));
-- 
2.17.1


