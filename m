Return-Path: <netdev+bounces-243799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D913CA7F20
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431673340F8B
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB39F330B3C;
	Fri,  5 Dec 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J6orrdf8"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B375232D433;
	Fri,  5 Dec 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935621; cv=fail; b=fjXPcw8MfRzE22A1AoYM+S72PZYRhWmv/RvdfW5Zj/0jC8GJlrdnCpUtYSrcewJKxQgdGU1PhnkYNZrOe5m/ndDnXt3MiiTjceq3vsNlgc5gmIwYVyyIwWkvZU+eB/cy0vo6TVHLz96TD/WK7IDHqGZNUCyUazwUkWqSnjYaOsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935621; c=relaxed/simple;
	bh=D073/s/FPAXsrdW3jk9Lxbu9TY+umbG/go4n2yFUpvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONAZ7N4veI3xhDrbco3kI20getfePu0Jnp5VLB9gN3yY+TVfa3v7Sx1ljrfSyYb2mOHGjPUj6BO4AkxTPiiZle8jX0YSVImmkLS7KqotvffZn4Zb9zTaxZZvZs/5o/cWLZvR8HOxn5T+FTBvk00mY7dTTcU7EeS2kPCyCSm46VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J6orrdf8; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jViQzWDUTcP345W6S4iw7Bs26X2vTtvWqvWcuNv0Gq7C2scpbmDffX7dDVRf3IK/SaCxipy+y6dpvRfNwic0EFCRc/a7iv95oqJD4vKrYNs9plXHZhjGRkeYK+PXFnO/Ez5JAHSRjbB9cGe+NruOGTKVsA2A772UB8gKeZ30/V27UE9VsZqmM4g0LqmkMOQdgO/3B5GvZmrjOFM47Qd3aDRQz5Yv0QQkIj2mfXjvzR6/Nmza2Cw9urvWZR45capHgnSJLiVYGX1s6U4JVgN99vVIp4Ufup3S1Zmt2yYzRZGpZ06PCmAQ2ETFgDFw6/e21Xosvzpk4EL05r12/4syzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sP1amu7XF9PRSEhA6i1mZjnW1dSVbQ4Hh9ECW6Tvx4=;
 b=PacDJZYrOkIO8h0bXWNg56pTjsWNx11keJlA7FcBNBsAMBaqhYg+NRnk7oNxgZogmXk/ERsO7por9BdcGj+WvrjgC5ka1jXjlzeBbQSkenlDdyLq/HP3CgDyL0hMdyjeStWzZPoK0kiIm8G81smDido3PI0tUen53GsxI5Fj5tNWLUgzaQcpWMgcTntd5V7Ct0O9bSgiTnPzZ9BONjT1JomhtmBh7+XRvqo9KE2L7XLPBS58NxP7aUKo++qnN9H66kkjwOMrOyxTBhimU/oK4UdbfG2BKjX8vGcoOSUd7ODSf9h/iz7f7HMZz39niw+cbyo3+i9J+UjibwYP6dHViQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sP1amu7XF9PRSEhA6i1mZjnW1dSVbQ4Hh9ECW6Tvx4=;
 b=J6orrdf88uy8VnD7NgZ9Ry0gKlrtXbSVG28zzGsZOPeBzK2piWgn6fPtdQCLOupdvOogcbhHB4Wgf17u9kupYEXCWKVHK6/bGbHSA4YuAXDWEdub/gFmOcAOZjaOU9FjC5YiEfB0y5uour1LTqQZfrhsjJZvXv4Ercj9kuaxJ0w=
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:53:30 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:806:125:cafe::f8) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:30 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:29 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:28 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v22 21/25] cxl/region: Factor out interleave granularity setup
Date: Fri, 5 Dec 2025 11:52:44 +0000
Message-ID: <20251205115248.772945-22-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 12fe8908-0d76-4a0e-82d3-08de33f4e8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/AQgpNBN5ee1wAD7E03VV2cCns1W6mY5TE+tlkNSHuLB56udbVzQBor9ieur?=
 =?us-ascii?Q?n5v4u9S0PJ9xBVjEB0NX03jEIze3tMKlSXXgGkoxFOoysVkImDBdn8RR/sOW?=
 =?us-ascii?Q?r0322bjiVlVXCe7vazK345mZ4bqHkpHWXHcbvXOdzi3ivW97BOWaKnTixMYz?=
 =?us-ascii?Q?Rd8d3buCnmW6V3BNdmhtj9UDtGOmoKTXPR6Ui1hK7iQ/9tFF75FlSS7mQ9dZ?=
 =?us-ascii?Q?UchZnRWHnOLxuwdnpV/cmp5Ll2qMzNA0eRF7egkDpLs8uXr/QeV/tc6VcGL+?=
 =?us-ascii?Q?NZXsMZ82+FB2c098dJ7E2ezQY4anxnHVNJBXsSqoYx5+b/n5tbhAy6jaViHc?=
 =?us-ascii?Q?UiCBnpjREmWiw5NQWcqJbElppeyoIOOzam/OjriFij+x/19uBZs6VkU9abwi?=
 =?us-ascii?Q?qqVfXZMiaiUO/1d/IahPlEskyyV//tz5S7T2ygtNsqUEhpvfxjySx8HcFSyq?=
 =?us-ascii?Q?MvbBNatbRVtQ9xVbd2sF9nR6BznOf0cwdYywFEcdNb0o/9jjrvbNLQtgwiG/?=
 =?us-ascii?Q?tmM9+ucuYUvcUbd2gMmRNycPvyayxdaV8Bvq8ho9p0/3jryCRwdQQ2pROY+F?=
 =?us-ascii?Q?Ecx9ZWaHkbkBonYBrqA1kz4mbwNGtJz1oiEjqXnMVucfFGJBi2Yx3Wucqs4A?=
 =?us-ascii?Q?HtA4zTtINoyNSGyha0xj3nXQXj3Q2aQNU7X8cZyqjH/TDU1BDkitSWyliQu6?=
 =?us-ascii?Q?cSneiOM5CEnRYAVSYtxLHyGVsWaxSPRpPflvZ25gjkN/sMgNrvMKuzl5mTRy?=
 =?us-ascii?Q?lLSSdqTiOYIKnTiKp5zMFcxRvS++q9pu/Wgabr8QYu3aWilTQX0oOLHX4pzw?=
 =?us-ascii?Q?LpoCgqqYXVNzVqIL2E9ULHPh7uYt0nLzOpdzkgJQaggYH3Kg3221WbpYzis6?=
 =?us-ascii?Q?H6dRoxYhx2+47AfnQfgtfsXqUdU/Vcr+CV5cyfU1kLJoYyw947+ht0MdsbTp?=
 =?us-ascii?Q?U2RR23Y8gO0mwozwV5kQUbH6QDcICXT/4Xxjmrre1h+3VnTpES+8MRll9dYk?=
 =?us-ascii?Q?bn7zjCu0LP3dqfXK0AL/HgcTkTUb+VyQL3LPdtOpPjsCQPC7eFWrjHDCrDrG?=
 =?us-ascii?Q?RLuPe+y8rN2PR5+/viERF24SBybD0Wa5OS1G1jXmc63k0+zlQTElGJdLc1IS?=
 =?us-ascii?Q?8fzB16pDV9fZcCTs5Atqiif+fhrX3ISIjeUOyHJIRnNSAzfxwzBU8/Fe4jis?=
 =?us-ascii?Q?VMBZDYzDf8WEueS4P+cVGlplNQxwbWsUouQ5WHV8bHoB2R1kf36Md1FfVB7w?=
 =?us-ascii?Q?DF3QFgRuun3fu2bWCF0ZQDG/d4VLTvn4yY9hLy0daQqtIQR2QmPGodgAcZ0z?=
 =?us-ascii?Q?uG78fX663ue9OP6/KN71cz7lTv7R3MFJW/IIh/FUg/UHD5yTSmM2lsbqYp74?=
 =?us-ascii?Q?Ajqcrbud6Lwir2wPGZHQe8wchSe4ZSTJK74WUGfHJILy0MBqn7xtLD3qfVj+?=
 =?us-ascii?Q?Kfh6tUBXy5MMS7JWEkqSe2wuQjsi2eqoGNIarYOTNRHPhNJDEspIQKwOs8hs?=
 =?us-ascii?Q?3d+Ip7sqcRxM+ssvsE4WMLhfF5kRPA21WzJWu6+y2JpNKiH8/0XCBMsxXEb1?=
 =?us-ascii?Q?T4XFVWA+UNToe0Y7QBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:30.2763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fe8908-0d76-4a0e-82d3-08de33f4e8c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209

From: Alejandro Lucero <alucerop@amd.com>

Region creation based on Type3 devices is triggered from user space
allowing memory combination through interleaving.

In preparation for kernel driven region creation, that is Type2 drivers
triggering region creation backed with its advertised CXL memory, factor
out a common helper from the user-sysfs region setup forinterleave
granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 157deee726a9..21063f7a9468 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -565,21 +565,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", p->interleave_granularity);
 }
 
-static ssize_t interleave_granularity_store(struct device *dev,
-					    struct device_attribute *attr,
-					    const char *buf, size_t len)
+static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 {
-	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct cxl_region *cxlr = to_cxl_region(dev);
 	struct cxl_region_params *p = &cxlr->params;
-	int rc, val;
+	int rc;
 	u16 ig;
 
-	rc = kstrtoint(buf, 0, &val);
-	if (rc)
-		return rc;
-
 	rc = granularity_to_eig(val, &ig);
 	if (rc)
 		return rc;
@@ -595,14 +588,32 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
-	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
-	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
-		return rc;
-
+	lockdep_assert_held_write(&cxl_rwsem.region);
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
 		return -EBUSY;
 
 	p->interleave_granularity = val;
+	return 0;
+}
+
+static ssize_t interleave_granularity_store(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	int rc, val;
+
+	rc = kstrtoint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
+	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
+		return rc;
+
+	rc = set_interleave_granularity(cxlr, val);
+	if (rc)
+		return rc;
 
 	return len;
 }
-- 
2.34.1


