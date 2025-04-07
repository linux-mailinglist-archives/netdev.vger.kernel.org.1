Return-Path: <netdev+bounces-179979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0024A7F072
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FCAF7A65A7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8E227E98;
	Mon,  7 Apr 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lT+V9v4c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA634226170;
	Mon,  7 Apr 2025 22:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066310; cv=fail; b=PHr0Y4iWkPtYBvHLS+J1gF8QF02XREP7ZK3QtsXUMom/Eqc1kvimmZ0Dfqsm+dMO/Mw1UyAiU4OslwKxjMlLTL4zgf8F0NPUHwf/UFAZN0gsEoyqB+N5oLCy4CQKjUL4glHdGdJ80isUiFC7+ByNaLf2rGp4hhh/Gzyh26FEN5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066310; c=relaxed/simple;
	bh=51RbEd1KSLYvDRQ2uesQYXoWEvxv+XR9eAS7189qZ3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ingdB1ZRll/eJv+HXDqg5HiolficlaZxXDbLSglTS3uqxDH0DC6le7p7rSIUJPPqpPIZ0jb6RBHBtVVu/wrustXNCK9flf4+f2miFv09CiViNu9IEhCiwwErv40mjmvVXtxBuA7eysprs5eTmWKrtS30sGuK41SH5SZ2EvOMFcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lT+V9v4c; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWGxhW9HUSp+lIIV+/lxacSMegs6vhGkhZfmiNgfoZdcVi3jqT8XiEQyBsfQe7Ab9hU/qrRLDHkk4Q1lK7thO1kltX0YQ/yzmmlOtR70LCzZjSUir1dRjW7oIPCyzyeilVHaTmkq1F5Grsa36HMlQ63nYasaBA7CCqhpvrRddSN67oqEmdiH5AgbJ5CaW4YmCYz+8qfPuOTh3k6BsumEPeNYf9fRMPxz2ZqLm9E7Nm2qE3q2cU2gRCXXfTHDmtxCczDI4gbao3F2v9ZYH+TFqMyk2sXmgRCgtwmvl7ZQS5h6Qz6eNcdWw0RBGM3T+fCGOgMsPfEXu9KgetwvEZOsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iu1eLkZ6kf/kKGj3QCvA/GOH6E0U124GCZyYdua/Gr0=;
 b=yReIwZKAMBHM06Pgz+Vjml79nctRBSD0thGaZP887V3J6ucU6T+0k/X1RcdoOJdI4UMywHQhiDN7bQBhnG7zUu9fv8o1JujNQZ+5c9yNPSmunttIMlj3l8S9+wKAl5xk91gbiuDafs3XNZcc5oiQbPIt64nezebJVWGR6WlB43KoisR4fLlSx1k3DS7VkYje6g//ijdY+FA97yY9PIqTKN9cejUw5ue68XQwwi5TuJptqDXSW1+XQqxYpEdkFaBSMUMouMWgAUifCu6H9Ax3E4khOnXbZctQQLJvFmA4qdwhAocHq2AZL2gUmM3s3P5lHj0Fh3vQuQijZsOcmjiMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iu1eLkZ6kf/kKGj3QCvA/GOH6E0U124GCZyYdua/Gr0=;
 b=lT+V9v4crLTbFIxe2GxpehydUVN/Dchg+zCf+il/izUk+7JlzDQty/UjMUPxe5Ky93EQ1wX2KCQh10ZKxFwJGoba2qWvzshKXaZdkN5lidHeHpPp3BF3oppLULlmGdKUksLeT9TRRnrFPMuK0CABwEFSSTbHPCYGBj27O6UYxlw=
Received: from BN9PR03CA0090.namprd03.prod.outlook.com (2603:10b6:408:fc::35)
 by DS2PR12MB9616.namprd12.prod.outlook.com (2603:10b6:8:275::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 22:51:45 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::fe) by BN9PR03CA0090.outlook.office365.com
 (2603:10b6:408:fc::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.33 via Frontend Transport; Mon,
 7 Apr 2025 22:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 22:51:44 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 17:51:42 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <andrew+netdev@lunn.ch>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.swiatkowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net 1/6] pds_core: Prevent possible adminq overflow/stuck condition
Date: Mon, 7 Apr 2025 15:51:08 -0700
Message-ID: <20250407225113.51850-2-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS2PR12MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 614a009c-e2e7-4cff-47b7-08dd7626c4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KijyyilNMJYy+ap7hsqnWuXeow/YDCwcpQNLqs4kxIIhkvjigYAbhdR2Zz+w?=
 =?us-ascii?Q?PA65u9W7/KDTNTUVzGK2HdFL+7J61L/9g+UAAYNiUrJrGyvZwS4p/EuGaIi8?=
 =?us-ascii?Q?bBSWVZRSBVjn6yWxmsdcPHheUdTdC+wenMi7Uwq0Oc+cv7zN8hmdXNl8M3M5?=
 =?us-ascii?Q?Xla5lZgmWLW6hILzVFRxy7ztdI5jmiS2m3DAY8jfTZaMJdxXeqXwYVHjbJB2?=
 =?us-ascii?Q?HTPZFElAP8nBdUEfSC2C3dMin3GQf97JbudRyT7qwh3QXrr2GC5U/vKqAhZq?=
 =?us-ascii?Q?kp2kAlS6nm0gmoN2vf2wCGf8GX/PNHtgpgPzEaLL9f7SPHYiNfdpIP0Fppb2?=
 =?us-ascii?Q?2GJwXjX+fEDfH6ykSfF5aKN0S5o1S0E+bTROWouHVTlfi2hShtMYQrB36izJ?=
 =?us-ascii?Q?2/RvR4Y7eUZaXo88KyAAYZ30vBuJ8HO7kmmn7cwbJ9dAx0m29mV8901Tp2RS?=
 =?us-ascii?Q?/wtZSeSRhAFzvOJbL3KUvLtCPawpXdkeoedTwzIXXok4rkmZzPUSV9wnqJJ4?=
 =?us-ascii?Q?JMypkp4rHrdqXqTPhpZQDQB9sOzW7/eRnOM4bIwhIfRgaNcwT8zQ5KGykN7P?=
 =?us-ascii?Q?sXpeTz89pr/lJIUBGyKTCw+n47subqEqnw3a/FNdMkGnVfjBxooksq89rbFi?=
 =?us-ascii?Q?B9azkeqsEmoR7Lm5NPGkC8a7xoR8qMGwa+VVDAhM3+qatRp5w8izPDTVD3VO?=
 =?us-ascii?Q?/dTNZOInkikVFs83msyhA3IknkcuyI1l9DCYnJMiq+xHyA1uFs+sjrBaObiD?=
 =?us-ascii?Q?p3fM3l8v6SVRJ7bcvUFeWb2m+Ww5VJFdgPeIO79/6PwRi2DXipVOO69FPkDC?=
 =?us-ascii?Q?EhXhsHoWF0g+ZQoGIKXCAWIGXkbSgvfhFuE7QI307oIHEVwc3NBlB9mt3lvf?=
 =?us-ascii?Q?A2m7CtFvqlVZpoDTksPOb8lVb2fN0Gmfxb8r1UTBW+GGJC7dQzh4JQAc4YH7?=
 =?us-ascii?Q?nWhRT36mTakULcsNdGH2E63V38E7EojRtvbjVFq+F07ybeuRTo0etjKryedi?=
 =?us-ascii?Q?IQrsfbfklbaLH4FJABm//GRzxWK06tqbSGMA0jeWLzZ/F680V02LSnZvhuT3?=
 =?us-ascii?Q?EmmFa04aA5O1+wRqjHglNuLJp+LrvEK17fqmzPijXt7WvyQVKlvsO9NRbT3X?=
 =?us-ascii?Q?DAHyLTckS1+WsjdXL1e8H4AJzekpAMqANtM0e1IKj6eCuMluoVxhbBDJPEDU?=
 =?us-ascii?Q?wWA8SfU22u4aLFugQeZ7P9RPtXU8rnpsZ+ZoftvmOUb52r61E4RHHZXkNy6R?=
 =?us-ascii?Q?5PWiI+rW7uHC3LtZWjQcJTrOPKb7ZEfFJ1faho3vWbponhsu6A3E26Vpd6A9?=
 =?us-ascii?Q?19TZuFqv/9VtN/ZTZxX543c+8ZzCw727eNF8vMeVbd6yVt4/pzF0RMRVptWE?=
 =?us-ascii?Q?aN8/uBcItFpDedt6QwgCkuOgP7LoicB9X47hkwVAgTRcbUZIfdPWFbNg8ASe?=
 =?us-ascii?Q?9AIlan0Bm2RTOX1iS4u02hMkP1fqXmNz9fN3nV6Jp3ujrxjaCYMUrCErhW2O?=
 =?us-ascii?Q?GbiynUObWTfCl9s=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 22:51:44.1319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614a009c-e2e7-4cff-47b7-08dd7626c4f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9616

From: Brett Creeley <brett.creeley@amd.com>

The pds_core's adminq is protected by the adminq_lock, which prevents
more than 1 command to be posted onto it at any one time. This makes it
so the client drivers cannot simultaneously post adminq commands.
However, the completions happen in a different context, which means
multiple adminq commands can be posted sequentially and all waiting
on completion.

On the FW side, the backing adminq request queue is only 16 entries
long and the retry mechanism and/or overflow/stuck prevention is
lacking. This can cause the adminq to get stuck, so commands are no
longer processed and completions are no longer sent by the FW.

As an initial fix, prevent more than 16 outstanding adminq commands so
there's no way to cause the adminq from getting stuck. This works
because the backing adminq request queue will never have more than 16
pending adminq commands, so it will never overflow. This is done by
reducing the adminq depth to 16.

Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/amd/pds_core/core.c | 5 +----
 drivers/net/ethernet/amd/pds_core/core.h | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
index 1eb0d92786f7..55163457f12b 100644
--- a/drivers/net/ethernet/amd/pds_core/core.c
+++ b/drivers/net/ethernet/amd/pds_core/core.c
@@ -325,10 +325,7 @@ static int pdsc_core_init(struct pdsc *pdsc)
 	size_t sz;
 	int err;
 
-	/* Scale the descriptor ring length based on number of CPUs and VFs */
-	numdescs = max_t(int, PDSC_ADMINQ_MIN_LENGTH, num_online_cpus());
-	numdescs += 2 * pci_sriov_get_totalvfs(pdsc->pdev);
-	numdescs = roundup_pow_of_two(numdescs);
+	numdescs = PDSC_ADMINQ_MAX_LENGTH;
 	err = pdsc_qcq_alloc(pdsc, PDS_CORE_QTYPE_ADMINQ, 0, "adminq",
 			     PDS_CORE_QCQ_F_CORE | PDS_CORE_QCQ_F_INTR,
 			     numdescs,
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 0bf320c43083..199473112c29 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -16,7 +16,7 @@
 
 #define PDSC_WATCHDOG_SECS	5
 #define PDSC_QUEUE_NAME_MAX_SZ  16
-#define PDSC_ADMINQ_MIN_LENGTH	16	/* must be a power of two */
+#define PDSC_ADMINQ_MAX_LENGTH	16	/* must be a power of two */
 #define PDSC_NOTIFYQ_LENGTH	64	/* must be a power of two */
 #define PDSC_TEARDOWN_RECOVERY	false
 #define PDSC_TEARDOWN_REMOVING	true
-- 
2.17.1


