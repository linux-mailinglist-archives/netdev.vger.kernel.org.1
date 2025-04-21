Return-Path: <netdev+bounces-184419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DA2A95573
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4B8188F340
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 17:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3610E1E32DD;
	Mon, 21 Apr 2025 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TE7N7yfV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758CC3F9D2;
	Mon, 21 Apr 2025 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257605; cv=fail; b=p/eWOgTDiwlo5WO53wtmxANWjvCN7W5Y1CECbD1zAlUZTyM6gg47+zldQOhb6rdX4vM79u9FbH193QzziJEuFnN68uYb9cwpl83nN5ulFHTAiw1d/68DSdWAREdrrdsUknYv5r2+dAadXzw4zVI8nktjWrsZIWApsJ1E55I+Cbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257605; c=relaxed/simple;
	bh=B+t+nKue6QzYd3ocWOIp4L3UENEW/+nwloAVyVok1XQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7JBWXOeuADksmmRAyMmsbQdTFTEe4fZkN45nrznPuYrW2c+fMgGFfQt3ek4DlW7fHqCHOr8SqSxTaOxYkzitqjzRmz6PeK3ZV4X16afCGyF6E7Zm+Q6o5cKPjScryMDBNO0mogaGRPKElDjONqVfQW90iwO2AJIngBG18BsZv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TE7N7yfV; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQ08OT7i+mv6Xzs6XaT3Ulsq02L482s41n0dggN6LOYmXpYO0GXMhL2HZxpJyJnaEfwWfzv9kXcqiuuqHKOgCrJR2gxA7ocJFmTtnBMiHRYjQVu34BI7hDy9Th6qtzsESeYrB4hMk8JEiaXSW+cUUHILRdFxQHTxyHo4W9xB63xETPPNyxJwNX4Ygr93mYCeQuqbS0CcbU2kVGL67NQBOELkWgrn2LGgR5I5Xeksla9B2h3YHb37q3uCMlmXjP3ee14leiWaf4GiM/EQgCM0N6MIx2MVsVKQAqkpinEItcuPP0JhIrtEWunP2ksuM0sTmVa1mjZ70IlczpL9xeSFew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TH/Rcu6MtEeME3rww92hOwcN5XZgEzDhNBnNapKKXD8=;
 b=TptM0f377IjFf4BQX8c07CnAt4MJyihR6nj+a1HaT8AHIvWxPk5l09bxi9fHoZh271KAeF0+VgjCSRr6IDP5aiikg7IgB5FDIzBAOIAykoScc7stIKhrIjTfydpWre5Ggt4TxaUui6MKeeFp8p+0ZDyeIBFrb10xyu3pWGA8SLVi/k2H7WP4hPFlem3eOEqBLtICnIEOEkvRFxx2o9dgMUy+r9uZnxPQX/ussRpu2rxLuNXnVu7d+5xZJDYHQza43UfF5TlRFsl+OmjO3WCuy283xcNNhBsPWWicFtZcYoMmGb1Oa+ztXcaiS7Jr9NcQEK/2cO1Qki5bkBXmvbmvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TH/Rcu6MtEeME3rww92hOwcN5XZgEzDhNBnNapKKXD8=;
 b=TE7N7yfVx7r5alOA1ERR6TTG0Pa5Zq++/MoDHDmfudkv2UXpbgpJZyJgdZKHDtnSspVArxODAuSn5XU6tw2IlP8HagRVbcGRcZkwr7Dz9YuLj3OgYdHzVK1KVkFpmCHernpdaqhcLJVAJmvNsQMkvw18DZRU5pdp0wgUoBzj92I=
Received: from BYAPR08CA0058.namprd08.prod.outlook.com (2603:10b6:a03:117::35)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.26; Mon, 21 Apr
 2025 17:46:41 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::d1) by BYAPR08CA0058.outlook.office365.com
 (2603:10b6:a03:117::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Mon,
 21 Apr 2025 17:46:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 21 Apr 2025 17:46:41 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Apr
 2025 12:46:38 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<jacob.e.keller@intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v4 net 2/4] pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
Date: Mon, 21 Apr 2025 10:46:04 -0700
Message-ID: <20250421174606.3892-3-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250421174606.3892-1-shannon.nelson@amd.com>
References: <20250421174606.3892-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: d25d1b14-d60f-48a8-23bc-08dd80fc794d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TegwBldWwO5KhV9gkKu53wUMP+6XeQ46byB8mejjURRtw0B9Z5RcjkGBv580?=
 =?us-ascii?Q?oEJSKDAGZwuV7+5gccT4rDkYbXaYfr+xWYCUK/y9LNpijnDyoQKb8SIutT/9?=
 =?us-ascii?Q?0JdSCE/grrf0SfkmMWu0teE1eWzsGnUiw6p6qeUdOLQvoXhcQW/supWul7HN?=
 =?us-ascii?Q?sGpYlYa316wdzeCxVJe6HFuc87ZiB5mlDkYh4NRkfdb3Xqt1OjHLtEA1Dbs7?=
 =?us-ascii?Q?2sAFHiNNeG1QFAQOqINPDpPAeIVVYJoN3uzfRItkm4j/JaTEQk6ROHKX21c5?=
 =?us-ascii?Q?N8hnv33X6Fqxc9r2UyBZg2VZsXoiVz/eabF2PpWl3SfUcNXY5aW7AdZHEyUn?=
 =?us-ascii?Q?Gm63z5Tn8KD60lCGPeohSK+j8FZy2/N42yLh/qmdhJRbuTXTvE4ZEu1+eEp0?=
 =?us-ascii?Q?SJ+ys4qo8TkDVnuRSwgJe0oph5IgFoLOh9Ckbo9Wbv6zL6i8v3pERuS66BhC?=
 =?us-ascii?Q?NQbBDRfuhb2AQ7n8jpOsvWamlrbhfKSoo2IokSCOvO4zqPfoYsxct7Ppq/f3?=
 =?us-ascii?Q?lLKBBse+OAcA5ZANwuLC9n3DUkl6/yJmAW1Z2KYRZ5Gl1Zn/CXUNGAC8DUJY?=
 =?us-ascii?Q?XMYxy0cHlYQq5+4iwM2tFT6lR289PMOrq+K1TK3hEjj5lymKdvGQoNDBMi19?=
 =?us-ascii?Q?vnRr7XIg0TYej9JMJnHfRJFytyyPtxocQ1SW4UzbvnIKl1xsgyjnD4d2rWbw?=
 =?us-ascii?Q?owNwFArwxYRlEwGRDwsIW8gC3qxLtNwUXDGRybvyVQcsVSyLpT26vK8Y1+OC?=
 =?us-ascii?Q?rL7b3xek47FBroI9jG4A3n6k/oyctH+7hQIdxmU4UprO8hq1am862e4i70c4?=
 =?us-ascii?Q?pr+D4a+0GTwxsxyRCZ+RHEDhpu6v0UCvXeODYo4kj0O4ihOnSrZfcJmkNNpe?=
 =?us-ascii?Q?mXd025LuhJORRLn49J12oORQaJdRL00nYQkmBcIE0ht11VQIUPPgwaICg8uR?=
 =?us-ascii?Q?LYAW492a3k95A5Y2+x5wJr/lh7Cmbl/szoUJ0/Q3cqHUunlh+kTxZli99tp/?=
 =?us-ascii?Q?dNiZVqUO3bqbC/sRmJyDj8UeklvfuJwFeMtFNJvpNpHZFImOdvjjuFpvhg4Z?=
 =?us-ascii?Q?cqncmwxvspDDY2fHtnk0xxmUfkmNBpUfU88eOwfk3Z7inqhfZBOvWjQWIWWV?=
 =?us-ascii?Q?2MigIIVZb/kPIc3P9VHSZdNggrVPp9HQwc2dJ0qtyZh9lBJbwKR9r1FgOqYG?=
 =?us-ascii?Q?79fVkZxwS8ulZSojB3fHUc0C3i/yBr4O4SZhtWRcUZy2Tsjp3SQJadoCh2Gj?=
 =?us-ascii?Q?xUc74IvF/yNBkt51TxWu4rxTr/GHq/HIlUKmUlBfWSSmZKQ2hu6CI2FYbDDw?=
 =?us-ascii?Q?VswV8CNxeGYjletV7lE2UGG6yGL2xTdc1B1sYzKCB4dw1ehpsdo/eFPGCeSK?=
 =?us-ascii?Q?TbWOuwLLNXVNQCTynVybNPS500fXOcPcY/FjQ+yGDgdItO08iQ1r+ZutuyYp?=
 =?us-ascii?Q?z4JUUd9FYhJvTPoG4mIJXZ4xnUnY2z6iJmxldiIfbMcJJo5Ez5va8VQS0RiR?=
 =?us-ascii?Q?Pag4jfb9YGi+SHANaalvkLSbXEGJjvKgCberEBX55wZrxVFJCfZH5I9xiQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 17:46:41.0284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25d1b14-d60f-48a8-23bc-08dd80fc794d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

From: Brett Creeley <brett.creeley@amd.com>

If the FW doesn't support the PDS_CORE_CMD_FW_CONTROL command
the driver might at the least print garbage and at the worst
crash when the user runs the "devlink dev info" devlink command.

This happens because the stack variable fw_list is not 0
initialized which results in fw_list.num_fw_slots being a
garbage value from the stack.  Then the driver tries to access
fw_list.fw_names[i] with i >= ARRAY_SIZE and runs off the end
of the array.

Fix this by initializing the fw_list and by not failing
completely if the devcmd fails because other useful information
is printed via devlink dev info even if the devcmd fails.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index c5c787df61a4..d8dc39da4161 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -105,7 +105,7 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 		.fw_control.opcode = PDS_CORE_CMD_FW_CONTROL,
 		.fw_control.oper = PDS_CORE_FW_GET_LIST,
 	};
-	struct pds_core_fw_list_info fw_list;
+	struct pds_core_fw_list_info fw_list = {};
 	struct pdsc *pdsc = devlink_priv(dl);
 	union pds_core_dev_comp comp;
 	char buf[32];
@@ -118,8 +118,6 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 	if (!err)
 		memcpy_fromio(&fw_list, pdsc->cmd_regs->data, sizeof(fw_list));
 	mutex_unlock(&pdsc->devcmd_lock);
-	if (err && err != -EIO)
-		return err;
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
-- 
2.17.1


