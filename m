Return-Path: <netdev+bounces-183051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72D1A8AC1A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD27817F00E
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8642D8DD2;
	Tue, 15 Apr 2025 23:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G8iH0Q4O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE82D86BD;
	Tue, 15 Apr 2025 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759807; cv=fail; b=qJiD0r8Q8WZCxAo8WW+BYNJ+gfGZ30an+sLF+kqKFOGdau4Jgbf234ePJtk0R+jqb5uPnvMaThaWSskilMMANqZZpOjhG0/3msf1KM0m003Mabt/ldczcnyUR2DFF8hFmuPQ9Bmxyq0HgLHYRDN5igYQXBcveY+FeGsHMsJ1W/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759807; c=relaxed/simple;
	bh=HF8QcBNRxc22CaNKsHz6LG0wnnDqToVHiM1ltIlREbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=debxPS55fwmkR5Q0TS6+mEaJZEuSmyzgmdX96Fl6DTqHGcbv0x4XaxEj8Fi3ajmTkKMn1xNdbX73O27KIq3Zlr8kvblIrzGEi/JPXt1KBRwV0MeURHYztvr4GiEc3HDW4bNt9PLKX0aO3pWcp7NBNJOgrOHDSr61nH0eBponSg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G8iH0Q4O; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mmfh565nhTeEmbBw4CJ9MD/YoLwP9iJQARxaZmQd51hKmFc2afwf11E0kd2fzvLNxmXP6ynZR1HGn8vbue9LACIsRlXmBrE6swqfnQU+ZoWPZDg9+qogWSc4lQIb9fw0JuGO5qPwdHLyJaBZP1xuXg6BP+y8fFBl8yNlXlMx5CesWgnqVyTkRglInVtZVxIFYfEiwFsH7DSdcuHSIckD9lZaj/lr8WsGQpOS/rk+OoIYdorG+mMOwY0qnUOMri0ksserP4mKlz5CqdqjpTxz/kz4JI41gLJ9Zq22QXoOoZnVDusy0VgFKILgF5iKGB9+6aWp78UKGTbCttlAGJ3rag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWVWsskrMQPb1bDZokTXUYW3U5OGmbN6kXjhoCC1dTA=;
 b=FLXAyCphflN/0nnCVdA3rbSYS+hzXhLTsh4j8JH8CREHNXDTyS4eUvJcrxUhTUzm4XL34RUGQBIJpoF+SjH32wjuAZ53B0dZa6D1UwqJ6BVRXUqyaRTG8L5at6pw7Hy9dDnkoqk60O5QKXqrmvcDYCSfp7HLT+Emrk5CE1/sATwcoBvoxBcjgVRxU0OcGiXf5OE0DaWPlSQslsab7/VvpFLLSHSOe+ZF9EHTmVxJdw5elJDrrdqyj0u3YMHTOEiJoaO9jgu/eHxD1ph/fTlevV6JBI8/96Gjb9206889ccTCK26n6aQCOEUs1I5pfovAcIOljAlAy46wg58oCQrWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWVWsskrMQPb1bDZokTXUYW3U5OGmbN6kXjhoCC1dTA=;
 b=G8iH0Q4OIGyBgxWfoLwkSERVRyCb0w3jfGw42y7yOdir8HccBESw3ptUM9RpqiDVMZKnE9RgRprdUzpQteYUCC1zPqkI/RquqWixPsGreubNGTlOdKwhYAkzK1YbpuCqYHdPxKsrGCQZB4cbQSx5NxZv21SqnO2swIeVrYE9mgQ=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Tue, 15 Apr
 2025 23:30:00 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::60) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 23:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 23:29:59 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 18:29:57 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net 2/4] pds_core: handle unsupported PDS_CORE_CMD_FW_CONTROL result
Date: Tue, 15 Apr 2025 16:29:29 -0700
Message-ID: <20250415232931.59693-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8280e3-d4ac-43b3-0617-08dd7c757059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZxX0i6LsmdYHP4t8vaNW+WDgI/tIKXHnHvI5q+JHnLTCwlXZaeCgNP1HPo8t?=
 =?us-ascii?Q?b6zpoYef3XeHe62AGCoLjNlbtCKMC4akikRTOnaBthZq7Y/MR0PRc1WcNYOL?=
 =?us-ascii?Q?yzFJddL2n6Pn9g6r2U4nSWxgsEcepF3gS5NNBpCfs5NIZunB06DOoYQGAJtK?=
 =?us-ascii?Q?MPyiKWGMBo07v9ISesmXa+tF9BecXXOpM8CLkAtqnzUse2uNHmH81FPa65wk?=
 =?us-ascii?Q?yx3UgPo5EKAhvGegXi3EHB1AUQs83DvhH+49VJqnQQmFUwmXJAOSoatLdpoa?=
 =?us-ascii?Q?mMjiMsL7bj5Qxvz3yV71KrNTnz7pOMr+UPBtUYLooCwic3K8Lwg3XYdtQBWu?=
 =?us-ascii?Q?Zhe6GAOb7ZAG5DhpW7UcS1JGGeZti5sQ4NHnm8pT/UgQFacw9cLBVi1fQxlA?=
 =?us-ascii?Q?vfIz+53xG+MsxFq8q9RsNIqEuTJwuufHM1TY9Ua8Tzu7ftK1SFTwWsNwL7Ul?=
 =?us-ascii?Q?oUX5OJLXE5QDv4sB0i2pEpMo4LXoBT0zssk6jt0Vu/PW7QX+dgLMZozS9HTm?=
 =?us-ascii?Q?bRUB3tir1lArWBm1t1EIsx3NFUJ4M/uklUbG0zaoM8q84c838jzGWi5v37xa?=
 =?us-ascii?Q?ikqQXDyk44eVCnb8T2d+o25Ig84wJWtPkbM803qnyKrPUl5ufazOt+GKSZPu?=
 =?us-ascii?Q?Uu7IGiMQcn2W3VXzh6JQI3JEzymM4VEmT9D77WBGHmcMmCBhXcg75UOlW8wf?=
 =?us-ascii?Q?JzTHPi8dBDp556m/LGRtMvQya2eRz0c2pOcKgFqTg3s16vbm/LXajyPWlsdF?=
 =?us-ascii?Q?EAiw64jbbLApyWcjhGnB97Zz9aqeC55wDb1i7PNClm7CexUXuzFRBiz794gk?=
 =?us-ascii?Q?1VPBwXCpXgntdDoYtcjJ40UxhQXJQ99UF1pRMfCNa9mzN61is3Yx12J2wins?=
 =?us-ascii?Q?F3+NUgAkTt3Fz2ewMv0tg15Gg3PK+eEpcOa43KxDc5jEEZ8+3Q3Pw+gD+NL0?=
 =?us-ascii?Q?n+lVQH26sBqDjuh/aNzeKqTd2OeygEd3MjbkDBuXx56VAbcNBcYsFhgQMox9?=
 =?us-ascii?Q?Q5TyJtBgbwRIcyQSeHUjHniz3kuylKapw8thgHWWnJpyNQEAeZRy7wW4HE4M?=
 =?us-ascii?Q?etFttMA7svDvIj464Rmnp8B0qp0vQjhF6mDHaAqwI+zNeCAZ8rP3T4c4m/aM?=
 =?us-ascii?Q?v1wu3sO3H6kI1dbfAKN2IxG0F1/652vgChem10srysRCqoakDhff+2xgOB9X?=
 =?us-ascii?Q?G35ptTMcjDnu76YfhDhPwzX8L8MHYTMcPy60+WJRJtK4zsk3jbZzd61qD/oE?=
 =?us-ascii?Q?01XXJIUBtzghS2wDwoiIwWrZFZIA1f3ZneIrrDiktLmg32oq5nrE0J5CaEKz?=
 =?us-ascii?Q?TNTgvdTVCN8zoNBaNwTG64h03G13QK3X1uS9LrTGzM0GFSV87YRFh5slzQes?=
 =?us-ascii?Q?7ua+pPGmrF2ZF3UzDtmnzD3eujdzLtJ5gr4c3g7MajSym3utaEJ5JSJKO6Ri?=
 =?us-ascii?Q?gfSZyjNKCCMWZIiNqH1kya9wxv7mvhSVC6qSRL9UVTTk/aNnS/GxYcK+69Nk?=
 =?us-ascii?Q?zOyVMNiq4qTR3QFc/Gt0cM0+8jj9aBo4MAx/x0C+bDA6rGg1fDHciDt27A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:29:59.3753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8280e3-d4ac-43b3-0617-08dd7c757059
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

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


