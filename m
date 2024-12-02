Return-Path: <netdev+bounces-148166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA29E098C
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53A328256E
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0031DDC1B;
	Mon,  2 Dec 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xGd0SVXq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C106C1DDC19;
	Mon,  2 Dec 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159575; cv=fail; b=XPyRSKpumUDe2GFtOgatGf5IoFQfaX7v5MmJvGMnfn0Uo2G7yFIbrMywX/gJO/tGwS7Go0v4oMJitPGxoYSbZYr5VAapKWjMH8A+YKX86mmnnZ734nSZqT3LdMHP+J9xj7ZTzLWA91zOZa3qDtC+Kkbll8IK7K46zvXiWtlUHEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159575; c=relaxed/simple;
	bh=lLARFwF6g53mOBq/njvSOXb3Yet3RfnUxhgLhZX5PLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PekGvXm9eI+LHQw56oGtlJ2VPgJ5EYjo9FoZAD4CjrsniRMiN84+58gUMID0vCNEPvxqeYiHUkYEtK6ywmVEgZOz0PdV86phWCCtItt9KcQimJC7kkFeIHUBhPVWRdVvR887N86W70FFHtZiaqrRzR1C5uqKS3Jn9LOpsJRuUjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xGd0SVXq; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVyOc9rKipJZFHTsAZkNVl1NoVpp1dbqx6Jyl+yDuAcIjbIcC8gcFXCGNLV4QY/saCSGRMZLTQnSZ2bA/6cEmScNzzpTnJQ9hfCb/aCOdK0aoKvzfmCEnA/WgwpMfk1icHne3ApSyGAJK68NNOI4FgunpEY3Q+av6kNsAtE3S6iAT7bfvpFM26DchkXmeEOujZEQIz1BHHFx/0MgUZDPKoBLHbgDSd/mEcvhWe+jQNlRmcUph3pRvdlO7MX5sDWUnpVhPcc0anr6BzYDvHUvnnLbi6frrOqlEqV3mrLVb/h6w6HONgrvXfhMkYNwXlFjWTdASHa61Qh/58e7mx1JUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZttrYWVu34GVj5UmrqSMqPhtaYomgmIeq1dO9EjlFM=;
 b=xb8W9O2zUhhC5VtomnpEZxdKkmKZAong4YTQK0Voy1HpZ6KHQK5VtJq97d+0I3JJ0lgELmjOe+KAD6FS5DZTfU/sI+kbTrbmTv8wBvYHkQEhnFW4za1oG/bsZrFAKd8cL1fRkPwEsopwlMJXdebmwFyAHzexJGVOXyzTrnmW6mhyHSRdgaQBfHIYyNCYmErMaSxHf0rrO8sMakF4Wp+irXbH8VVoNs2ErM2MAkI70nxF+f9ARgl0FqFQmZCyde1nRPq4mdD3F3D4Ynr137Tb9WHVMk8ifp6wI0RLLvZbK+Kd+4tORtE1qR996iqEeed0i5K/Lpito16hMlYsD/NmJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZttrYWVu34GVj5UmrqSMqPhtaYomgmIeq1dO9EjlFM=;
 b=xGd0SVXqURn+h+K1oCfLc5jUXvOBStOZ4YvwpIXMz4YqlWIO20GoG6PuQi6pnDPJ8v+EfooRNNBMDGghiDpUxwxKpvd/xUREeK1vu8Pds9b+gT2G1K7lemXMMw9rG4Mn7d2tfqH3AXZmz6uiGamrSXCwzXYTI6MDKGZu+i2KSJY=
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:12:49 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::18) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:49 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:49 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:47 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 11/28] cxl: add function for setting media ready by a driver
Date: Mon, 2 Dec 2024 17:12:05 +0000
Message-ID: <20241202171222.62595-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a129a9-cce5-40ec-30e6-08dd12f48ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqpKdZa3xxszAwnMvU79L66Wsr2R8ko8NagA/mY13khXb/+57iDXtveltkwy?=
 =?us-ascii?Q?DCN5X5BWQvL10+eIy9JGfEkdwz6nGoljM9ynlf2hCUlwBdNT1dGu1VHwALqy?=
 =?us-ascii?Q?zYq/jMOD/gV7OBjntdnagYS5MTk01QxMKSJda42+Qk5MYR6olFxDVcu62el+?=
 =?us-ascii?Q?wLIqv3oyvbCuFPpOzgaHhqm193dvcosDfpJHBgitOqwR+WWC8elJqOA5vpbB?=
 =?us-ascii?Q?RKPawJjs9qA/MPoyHXisz3B5tgTfsYU7A8nT8nXSF6TfdTfs+UYjhA0751Ng?=
 =?us-ascii?Q?Rx6mslDzLM2DPMPUeAEUzooh0VcTeZ1SjqCWj8gcDgEdJsDK4oWaFTot4MTj?=
 =?us-ascii?Q?eSVJKNAx7SVyCntE9UeDKxiNMO7NyoC8pTVzBS42+Pm1XFhjcy2yLrNcxFhW?=
 =?us-ascii?Q?ZA45ExnwvEtjb0XktfcR9txT1XdIxeAN3pRtZCKUgk7S05M3FTxZmQ9ZYCky?=
 =?us-ascii?Q?Ns8IYdlHPSYY4HkImjb4o5c1ddbjDUDcu55X+X5V+t/6rvSoUuG8K0P6v2bQ?=
 =?us-ascii?Q?/hQcJ4vwdpbBvnWmJCFcGWc5L5Ue7k1utsPreOGfDW6cHfUhD1DTvYufO8oA?=
 =?us-ascii?Q?ghVXjWPAt1ok0FZZjoThpWSBpo8oQVOlMubpPSmp5SbPe6XJyoe0iyymNrXU?=
 =?us-ascii?Q?FGgN7mqkVrYgxLb0lC7QBfD5YKGf6SSC57ADJsggmzvnS1OydmwEDUUir1pX?=
 =?us-ascii?Q?uPQ0+hVhnzxi3B7WshyfVkA/wIo754giS3Hs5XAaFM2p3xe7FBOY8Dk3LvCd?=
 =?us-ascii?Q?dOL64258ISdZKL7nDZLam3G0mm6Yu1vlLB6yv/w4EMfyfZTpl0E+KCDaShUi?=
 =?us-ascii?Q?4JGMxWiX7U62mI4bV7mn7WaVgQzUqxwQSnJPs2t0R6tlgSUBSYy9i+Nhb+ym?=
 =?us-ascii?Q?hUq59sag8qJv4Zp4cQvtTaVz8y4Arr4tPrP9I8Jjjs6BwM0Trs29Dmrmxcja?=
 =?us-ascii?Q?0tFAoklCmNIdmDyFXQPhP3g4F7nw5/FY/PgnpWsdmrgRWP1PsEHDix8UsFBH?=
 =?us-ascii?Q?TTFCLZSn+eqBG6Tf2RpA5TqbjirYlHot0wt3tjHegFnnZSuOOF8VO8J5MmYT?=
 =?us-ascii?Q?PVhbbwLY6tUSOwZ4Z7/bo1uZT7NIdhfem3pz9ksWzgdQVMoQQ8NUGlwfGswj?=
 =?us-ascii?Q?45bMK2saBgqODQurghIHLBd/XDoBWAel4ZuV4sOpucvVSOmP7hxeL0mwJP5c?=
 =?us-ascii?Q?1CxU6xf5r8QroLHBd8VKfnQM1pHEw4rkFueOwSo+aMPwijudG56+RDbZCoJv?=
 =?us-ascii?Q?WD/+azsCXidVuWMUWV05oFJU8Zv3v5LNAEYsV3Wqvssz9qZGNUUE5a8Z0tgS?=
 =?us-ascii?Q?wLZ4R6CcxRizglf46ffgMqs6HSUKIZ7kQLKvhzPEywyI+lqrjxSA2Jdp1ia1?=
 =?us-ascii?Q?Pwd35RaXeNcowAT+BOphX4tF8L+/BttTmy8jgXjujeLPwp3mzx+PcAxnagGp?=
 =?us-ascii?Q?FZw5LMF3+VrqdEu+qDKY4nUn0bYysfu3tZ11i2TZO5LUxrZKRelD2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:49.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a129a9-cce5-40ec-30e6-08dd12f48ca4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

From: Alejandro Lucero <alucerop@amd.com>

A Type-2 driver may be required to set the memory availability explicitly,
for example because there is not a mailbox for doing so through a specific
command.

Add a function to the exported CXL API for accelerator drivers having this
possibility.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/memdev.c | 6 ++++++
 include/cxl/cxl.h         | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1d43fa60525b..b14193eae5fb 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -795,6 +795,12 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
 
+void cxl_set_media_ready(struct cxl_dev_state *cxlds)
+{
+	cxlds->media_ready = true;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_media_ready, CXL);
+
 static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 {
 	struct cxl_memdev *cxlmd =
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 44664c9928a4..473128fdfb22 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -44,4 +44,5 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
 int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
+void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


