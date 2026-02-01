Return-Path: <netdev+bounces-255626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFjLDJZ3f2mUrgIAu9opvQ
	(envelope-from <netdev+bounces-255626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3701C65A3
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 16:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B3D63013A50
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866EF241690;
	Sun,  1 Feb 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RFGuXCe8"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013069.outbound.protection.outlook.com [40.107.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AE23D2B1;
	Sun,  1 Feb 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769961302; cv=fail; b=aueRfFPRKpUwHQ6fOBv4+QLpjT1b3eO43CjUKhrHlBoUxmvEO1/ARLZohM00Sr5uO2d7ddMTl2f2BFFMMU1m/q0C3zugISxmx0F5ciOc0BBZiRWE8XqmjgNhbZG8y23s1Xq63aX3VnUwkpr4pWzSkSgUcOh/tPPIITXhYvYFJ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769961302; c=relaxed/simple;
	bh=BnQ9XLNzNJL07J96IgVNNfuiJwP6+75wQzkXP+X0d7I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiLeUUmvGhhqoCiPXh7qrs6di3dU9tTCm11lcr6li0BvXgsLJWbQbFWkbbiqbt4SBgJ/VTk+9pDjK/r1wyYfpJtbSnp0GIxzOV8F/apVo/OIzn/A1/KotwuIAXcpshiB5mtyhtf+bANLcaTXeeSn4bEE/lwOOSDJrIaCbWXsIr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RFGuXCe8; arc=fail smtp.client-ip=40.107.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYmfN0swaNVlAwdNJcSpoAWDJ89RBmQcfrA76aKIUb/ePB+K/V5v8FnLvDs2FiBnzvibiI/ynp/kxyTPd2+1tmEy1PmoxXyVNqNjUWVBNlYoqjpEDLuxCMpS/Vc4aMBQ6m/NFCQLsjugwy4AsxIcPyTi46gl5qC+QBYaLFtGPAQ+syyALHCun6woB5l1uFrmKfwtqA0tLHc+WfzbTnlAIv0JP8YMctDyKf7H8Chx1rS+O1ljCjGuoT5uX/h4B46T2CB3h+1LQodZ366mPDDwVkqvhoJWmFJ42h/0PQrePmVHlX7myX9hTNdJTmE6SJX0xU6lyCq0FiO0XPmEKSOE3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol/kJZzRQch/wereJu/I+agQXgY9aIDFsslxcXzvRug=;
 b=myipm4NCHKhmVaHH9jMckFUdqilwB5ddJNebjotwV4urh1mDDxEXNHjZuQj4UaPCeknxmSEf38dj5TxNExTHbbvbW8n8OT/sH4wuwjm2REIfuoWnbnyuyG9c0UHMNDAAgIQ0PrvZAjuQMiIKiFmuVhZYI1zPl+6YO1JHEhsH57aebTBNWuZakmF07ES8oW5FYAv5KVSwBVeVqmJdSSxgMlEAztbbVkBvpkIDi8Byc2VOGn6Vwn1Qm2CCZw31CjZRJc0SYdObwTHox0XhAGDymNQGvH3FRfEjhdD2lykM0c4ZWOwZR5D8MmUdklTV42B6uoebbkTzEB4Dqcm9khlsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol/kJZzRQch/wereJu/I+agQXgY9aIDFsslxcXzvRug=;
 b=RFGuXCe8DWzDRm5FoqhwY3lW0VwW3GtyAXhKJ4MoXVIeCkK2qH+QmSdEru0ahAogJcq/KXuGj72pATuFGzk0iiYPN99nDMCZ82Za6uaAl4BhkKI+NaWaObPKCo/MGwoly1yrAXNTWMg7ZrF+5sH15WWdFjiQY2alL11UWHcO19c=
Received: from SJ0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:a03:333::20)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Sun, 1 Feb
 2026 15:54:53 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a2) by SJ0PR03CA0105.outlook.office365.com
 (2603:10b6:a03:333::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.15 via Frontend Transport; Sun,
 1 Feb 2026 15:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 1 Feb 2026 15:54:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Feb
 2026 09:54:52 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 1 Feb 2026 09:54:50 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v23 03/22] cxl: Move pci generic code
Date: Sun, 1 Feb 2026 15:54:19 +0000
Message-ID: <20260201155438.2664640-4-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: e285257d-9ffd-44a8-89eb-08de61aa3d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BhhdZ+tXvfv19r6rK4DG4fe9GZgOZRqVEVQUlnp9aED0aFIjhHwsaZcLg09A?=
 =?us-ascii?Q?EwIr7wO3V1nDV3hhPah/bvsNwGJHc/dU4l5XZoz8a+nywATt+c5H5cWQE9PI?=
 =?us-ascii?Q?axkGmZbDEmW/AwpI/lpyHNiFODnPNTAwW8dLGKqUpbEaD82wXiYqiLJWw/p2?=
 =?us-ascii?Q?sgAhocp6j0qzlEg8cnAj1nu9pJjapcRTDUtr4F65R6teZ+duxQ+Bi4ZwftFy?=
 =?us-ascii?Q?KAsV8hBrTZ4Q6qe8i8LgLMofVTGIjDmwwzI63fglKBxAUy0+boDPsTpFGdDT?=
 =?us-ascii?Q?30nzajoEQ1luzqDhO07LZeA+IuPnCYmIWk0BQajflEcImSX8CgLIBO5zZnNZ?=
 =?us-ascii?Q?TabrMQWthL/GGhJN5q9/7SzSSovwyJzaY3LXcEbWXrCPocMzlD56jufH/K9p?=
 =?us-ascii?Q?VTfhv8prkXEV0azX1JDP5oxPMndWgIP/CUNoVNdMEISinWJ+DyCE8jK4hV2x?=
 =?us-ascii?Q?u3bzc+Sn/9C6Yw+QmwCDnt+IH38Sa81RpyViV85F13wwGfwXc4MP/GytqnG/?=
 =?us-ascii?Q?kIykbOxqieWuUBdkwrioYvHoqiAkTpWOfKW52adKv4wVghJZ/wfUZR9XrslY?=
 =?us-ascii?Q?SXeEAJwVmXpR2a8/1MPg1XJpaETJYy8Q1kGbTKUPAUouLJ+06CtMi0wAJ+7r?=
 =?us-ascii?Q?5F2PyINM4SWFOTJM94Tb996s7cbInW2mwqT3+vkpheyT/P+UWv4BnGjsyFYV?=
 =?us-ascii?Q?vF1QKKb8ZBS95+ijhwqgVXGtB7XGMJeOaap7X1B3mqMb14M8cveRptBul3y7?=
 =?us-ascii?Q?23at7omAwPTK+vVmbILurmZyG+WAvYgwu7vEY0VhOWZ7t0IiDu4bpcs6oAcY?=
 =?us-ascii?Q?uULWkpNkoiKzipuu3wANVaRN6TasFB3ME8weWbBDWWhwl3ctZGN+MlIxZoAQ?=
 =?us-ascii?Q?7PurPWsHtrIKYzvVIsC1i5LdbHomrUAEA4uytZFuI4JvD1y/qdyaYnuPoweZ?=
 =?us-ascii?Q?VW3AN9tcj0jL6n4g9hGyE8SfFn0doIS9WGYSCf7CGBgS5V9RMaiVgwumgD1F?=
 =?us-ascii?Q?ykYMNz074Yvq4pJxOqXkNAaB177WbyRcsZjSMAkVnn0sEN4LhftuyeOocRbK?=
 =?us-ascii?Q?MsMqTMLST0WNxgGhK72zdLfy9e8NeksxS+jRmXZnc7qZqSuNe8WExVy3t4oZ?=
 =?us-ascii?Q?W8qMSeh3RZPzWnUmwBBcp4dojT9iWCqMP6NUgj6Au2TEih1oEVNGaCDqJEgF?=
 =?us-ascii?Q?YcKyF4zMcXeBV2eRfaZjEgzfgbWdDE+0j3nL1jEG9te2pcR2wqA3p0cP69Jl?=
 =?us-ascii?Q?rteKnjrXe/5fu2rpwPZd0LWNs3Y9ECkZx1V77LAUq7a7K4O/ja+puQp0kxYk?=
 =?us-ascii?Q?TUQdUM7xk14IJqmWQsBt5wSbpAx3Z56KT1/ln7afHzf8qdPpukraWpRVKZxH?=
 =?us-ascii?Q?7fUdVVa97u9fpwqSwzdNFrPdxLIQ3e9jwUTBKz36c0sqeKxCJqBNLTUT4Kyz?=
 =?us-ascii?Q?cFkLx/L2I205Ebb45rju+Y0RdJuebfEvHOD65y6mr4oqEEJnO8ag57ENS+Vg?=
 =?us-ascii?Q?73vFJ3lODSiu6v5bicM71HOsZDXb8pgTN4xXIqIn6gDEVeHXpgWif1LM8UoP?=
 =?us-ascii?Q?7R1Owj/nIlJQmsSyd9F5K6yspMk0dnHGCzLbioj5Mpq7rZFa6h5pTq36l9mR?=
 =?us-ascii?Q?hFGl8nxGOH5zj623I3kKssgY5qtWt/yqmhfoGRpa6wbIp2X575cvsQf/K70D?=
 =?us-ascii?Q?ejugCw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ByR+OQLVoCXK4uLOOog285ewjtILRONW26oJ8GOScd2DIWT6jBPqxljvKZm+Hibo6SjFXDVQ1/vsrGPpaH+YSBAfvE0JEN0ppju1rPFH5hUGY65PBdZ0OMRK+4m26Fg59kcoJEh8HHew1n6GZLXAcC8FCri3d+IOcOgFg0QsrhkIN7XfLBwekPFnbNK0TVCt+DDtAiIr8ZZqvdHBjGlkksguDewFtV3JPadAW/KixDQZ1TGBjrV07PUFkMZh6fHfRPFUdtwBpOg1pFV3SlPJUpYSI5lp3xHoQBofm6ESTwRpxv24P/5EGYUEhAGx2zRJ2P4UzRggljvWV0MGZHORE0V3ypyJE5t/N8WcO7M0vVra/mVUVMBSSVBO3UXZWwIz0OevpVwwl7aV8sN9ogp0deewFoxox0Pq+oTOisOa1zSUtleqwGKqChhr7FJ1KJTH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 15:54:52.8674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e285257d-9ffd-44a8-89eb-08de61aa3d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-255626-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,samsung.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A3701C65A3
X-Rspamd-Action: no action

From: Alejandro Lucero <alucerop@amd.com>

Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
initialization.

Move helper functions from cxl/core/pci_drv.c to cxl/core/pci.c in order
to be exported and shared with CXL Type2 device initialization.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h |  3 +-
 drivers/cxl/core/pci.c  | 62 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/regs.c |  1 -
 drivers/cxl/cxl.h       |  2 --
 drivers/cxl/cxlpci.h    | 13 ++++++++
 drivers/cxl/pci.c       | 70 -----------------------------------------
 6 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 422531799af2..256799d39361 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -187,5 +187,6 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    size_t feat_data_size, u32 feat_flag, u16 offset,
 		    u16 *return_code);
 #endif
-
+resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
+					   struct cxl_dport *dport);
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index b838c59d7a3c..6b7e50858d56 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -696,6 +696,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
 
+static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
+				  struct cxl_register_map *map,
+				  struct cxl_dport *dport)
+{
+	resource_size_t component_reg_phys;
+
+	*map = (struct cxl_register_map) {
+		.host = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
+	struct cxl_port *port __free(put_cxl_port) =
+		cxl_pci_find_port(pdev, &dport);
+	if (!port)
+		return -EPROBE_DEFER;
+
+	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
+	if (component_reg_phys == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	map->resource = component_reg_phys;
+	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
+	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
+
+	return 0;
+}
+
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+			struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_find_regblock(pdev, type, map);
+
+	/*
+	 * If the Register Locator DVSEC does not exist, check if it
+	 * is an RCH and try to extract the Component Registers from
+	 * an RCRB.
+	 */
+	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
+		struct cxl_dport *dport;
+		struct cxl_port *port __free(put_cxl_port) =
+			cxl_pci_find_port(pdev, &dport);
+		if (!port)
+			return -EPROBE_DEFER;
+
+		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
+		if (rc)
+			return rc;
+
+		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
+		if (rc)
+			return rc;
+
+	} else if (rc) {
+		return rc;
+	}
+
+	return cxl_setup_regs(map);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
+
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
 {
 	int speed, bw;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index a010b3214342..93710cf4f0a6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 		return CXL_RESOURCE_NONE;
 	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3eaa353e430b..5d111980d879 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
 int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
-resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
-					   struct cxl_dport *dport);
 int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 6f9c78886fd9..d879120b2780 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
 	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
 }
 
+/*
+ * Assume that the caller has already validated that @pdev has CXL
+ * capabilities, any RCiEP with CXL capabilities is treated as a
+ * Restricted CXL Device (RCD) and finds upstream port and endpoint
+ * registers in a Root Complex Register Block (RCRB).
+ */
+static inline bool is_cxl_restricted(struct pci_dev *pdev)
+{
+	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
+}
+
 struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
@@ -95,4 +106,6 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
 						struct device *host) { }
 #endif
 
+int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+		       struct cxl_register_map *map);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 24179cc702bf..668d44eb1bf5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -465,76 +465,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 	return 0;
 }
 
-/*
- * Assume that any RCIEP that emits the CXL memory expander class code
- * is an RCD
- */
-static bool is_cxl_restricted(struct pci_dev *pdev)
-{
-	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
-}
-
-static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
-				  struct cxl_register_map *map,
-				  struct cxl_dport *dport)
-{
-	resource_size_t component_reg_phys;
-
-	*map = (struct cxl_register_map) {
-		.host = &pdev->dev,
-		.resource = CXL_RESOURCE_NONE,
-	};
-
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
-	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
-	if (component_reg_phys == CXL_RESOURCE_NONE)
-		return -ENXIO;
-
-	map->resource = component_reg_phys;
-	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
-	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
-
-	return 0;
-}
-
-static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			      struct cxl_register_map *map)
-{
-	int rc;
-
-	rc = cxl_find_regblock(pdev, type, map);
-
-	/*
-	 * If the Register Locator DVSEC does not exist, check if it
-	 * is an RCH and try to extract the Component Registers from
-	 * an RCRB.
-	 */
-	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
-		struct cxl_dport *dport;
-		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
-		if (!port)
-			return -EPROBE_DEFER;
-
-		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
-		if (rc)
-			return rc;
-
-		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
-		if (rc)
-			return rc;
-
-	} else if (rc) {
-		return rc;
-	}
-
-	return cxl_setup_regs(map);
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-- 
2.34.1


