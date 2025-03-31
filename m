Return-Path: <netdev+bounces-178327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBAA768FC
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94A01882DB1
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDD221576;
	Mon, 31 Mar 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kuk29wq7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08687221564;
	Mon, 31 Mar 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432401; cv=fail; b=LsBavR2C9MSIDXJ//vrECBe82DRo5uukfIWCeYpbB2qqzRQ2iOxvNszB43atr/Oq1iNPrhvIpthZR4sxwF4iHdo8geOJ7gcpBQsk2Oh/JG+QCqH37zb/VbWjoPFM9WRpLOgOYzV8dDFCz+65owJ3Q1BzR//QoJGJk3xAFiZDXoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432401; c=relaxed/simple;
	bh=U/Xs62DG2XMYyqpnDd4mQ8M3V6z7kof4frnnHJUbU7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sY6E15Bxzl/SXr28DOmgWhdi4m8UBBhqbee283nQrRGtbf/EfA/DxZ33Yf4fmki+CLlrFqCj+4OnotKRjkxhTlKj19k1DE0hKT+IPEXwJKnbGvioA1XxGU21cTVGNIv6cf5dTBqVNSaVAyynZI0qOM9/amTHdpjV2+m4UlWquW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kuk29wq7; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rulIgDnxJFSFnCkBzAtwLSeV5AgVBpBuvSE1YhNLax+te4OxhLHfEvUCJ22AvLmWOmSlM3nC6MZ6HgvEhJQG8CovRPvXT5Yfqf/w4vRMmDYddrxgyqCcbjGvmh4N+5inCjXmbCkz8VoOy5x1YZR841PWjYHNrep4eZqvl+0EkcLbCAh1FQt7MMQ2ZxZr+NPIkhp6nGrf5nK/TBaYGkkMQljA1EyhU1FIRP9GG80nPuDNx3zDLr8jE6caw+xRoce+T+OTdS54AAL4JAzYlfA/isTR1rOxkySyjmv/fs2d0Y7Q/vPqZSYkHXG88YYyrOvJxQ1j6ICLXdNKtCzVdVBvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7fWiOpRzAkHdZpmCdjvyy9RMYU2NG5/BM2NwNDWvuI=;
 b=PKqvb5glpA6/rH97X54Wmam9miB+vI/QM9J067NNHdaVCWuV3i4xK55xV6WtsYbCImvqmlMGawsm1V9YY0j2Iw676ImsZOhfVbDyknK3qJmk2Q0dP7mv2JTOzyWskmvldmH+O9eQhVj5otsPnzJqjmv8e61WQKXq7nG+wqMTRYLlUWJzDOIOg0Gej2+0MIZS0JTmmeUv21YscGLD+ZSRwK2F3vYjKkL4nIllt1P41D5lotlgzv0Age900SKTCfqyY/YuwFIz0mJ0DFNzShQ8Jqus8nyQ8UwGENOfo1Z3UmMzxg4y9gA63qedi48w2hK01XlqIVuBNkNlhu6nagqxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i7fWiOpRzAkHdZpmCdjvyy9RMYU2NG5/BM2NwNDWvuI=;
 b=kuk29wq7kgEzYAZeIswutV1J3JrQJufKz6OW+g6W/SCXe/6DtgK0Ta2U+yhpn9TKSCqNMxiH5oHG/N8PbEgVhL7zGPWr8oEd9TADsVF5DzNk2+6u3ayGkjZkGo22/D3s7a5NENz8hEBSYVUkf1a8wNvE14B0iMG5kWIhqXTm5tw=
Received: from PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::20)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:37 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::75) by PH7P221CA0057.outlook.office365.com
 (2603:10b6:510:33c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.38 via Frontend Transport; Mon,
 31 Mar 2025 14:46:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:35 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v12 17/23] cxl/region: factor out interleave granularity setup
Date: Mon, 31 Mar 2025 15:45:49 +0100
Message-ID: <20250331144555.1947819-18-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: c6d34871-0038-4053-0f99-08dd7062d6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fhApdWLWm14eaxtcUvOxLZSnEsBZDGaSckodhireIa9YmvzAkcjTwm9s902V?=
 =?us-ascii?Q?j4gtvzKeuZculOABYx7gI3UZtsV6NcYmzzHr5v6jlXaeTizyN95mbENgBH+T?=
 =?us-ascii?Q?1xL450BaY+/HPjfC7Cx7xC+tomNNPsf6028fuv9DBWtzcNUMQXl36h+1k4y/?=
 =?us-ascii?Q?Y9H7VL4mb4fcy63UZpqWOljoDLohTimNtnbqZaVjgUTdZXlDH/r5n6jzu0Sv?=
 =?us-ascii?Q?JbxyeysPHeye7xAF2RKxLAXHAXu5HHd3hhxvvx+JNhJGnaz+9vXfv1g+C7Iq?=
 =?us-ascii?Q?9oysem7EAsF4LIev4lDsFHfwjIV6ux9tE5+0NtGlKZBblxJi7Q1QZKnAXgpN?=
 =?us-ascii?Q?FUk6LcQE7x3V+JZhATa2qThCem4DTGz0/wV+32joMk4/TZ87DjMw/vmgLbuR?=
 =?us-ascii?Q?dMD8XKbUSFJpZopC7rw8fM8+lRrJjfba85xrucyM7YWCuMQ2mEbYf5GvVf/8?=
 =?us-ascii?Q?kp9Jh5z3BCCgSYjmwMfTSyOjtJZP+vGS8zDOKYsIa+1F6p9z+9oITJ1RiU+N?=
 =?us-ascii?Q?AiUvqGHfEm0L706G0a5KLNsA9E2gQXx70OhZCb4LF9W43rKU87+jLH6m5ppD?=
 =?us-ascii?Q?8rdUpWkwf5WLHpBnGOyHTsG48/ga6/NHggb/1Cw47j9dN4QvQR90jIt8kSSd?=
 =?us-ascii?Q?OGjdzba9fkZJInMScPFSCcZTN8wj3Nq+j03RJkYmSHdkpWPhfWJ4JKkdyR6r?=
 =?us-ascii?Q?VcVGaJHfIDg7oPuPQeg4fMjJLI83rr5a3SBcce4PLh42KLyU41jC7mLFEyj5?=
 =?us-ascii?Q?jRgs5W9CQZe9+KA9mmM3c6GLeg6wRizg0d1flGgrWw3+Da17JlDs6Gi+ZnT/?=
 =?us-ascii?Q?yLWY1oHM/Hx+k3gwLlCiH/RZj2wVYWJJbOIAoRIpHyU18kwksc+VjEZWmFCI?=
 =?us-ascii?Q?XzJs4UpmdPsDbtVnQUXNhP1jg3YTPnwN3bGzY8iQlee3U2jyFosmBKsohszp?=
 =?us-ascii?Q?IYMHcnZNz4aJdnII3hC3C9gHkgQf8VtyXDQN6VXjAqcbgkJh6sIcGNQO0F51?=
 =?us-ascii?Q?SX4EmYCk8KKdHWs4WE26zTYkxNzOuVoUD1IN/E3LFqgDQoo9yxu+54dtAMFm?=
 =?us-ascii?Q?EPbxjy4bvYx3qHmHqcNjqtwEHCEoRfpVgg3FCFKvPqpU4eDWZwxReF6zsQUK?=
 =?us-ascii?Q?6O3tR8SkJe8PNPVJlMDpQTXrfbc9Z0EW3tBc38RJn2jE47yH622uo8RqG7q+?=
 =?us-ascii?Q?As8YNM2JaxidgrFMP7stxgfmXxThbqd50DLi0yg70fq1qK0Na/sDrODSoV2B?=
 =?us-ascii?Q?wdEG8w+R5N1NkJfw93WvA5k6NJfSo56BGCXZZSvx9U9okCVGkWFaOba6vlL2?=
 =?us-ascii?Q?foY6nHYWbFpGjUfLK0kx4ZIwYgygeJYnLEvcaeiNolAkjb63/QiT1p1o4Lme?=
 =?us-ascii?Q?1iznYcQQUhVUR2En7gNrkeD+gGcss471/kXQFiic+AcMSLuMR1+ET1xvvdET?=
 =?us-ascii?Q?VnDyzFQjbMqauLM6GqDdb6FWUfQ7lNF/nUqUnbt1RTr1+TUfJr722TAGam7H?=
 =?us-ascii?Q?i6SrNzet4wDqvY4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:36.6887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d34871-0038-4053-0f99-08dd7062d6b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

From: Alejandro Lucero <alucerop@amd.com>

In preparation for kernel driven region creation, factor out a common
helper from the user-sysfs region setup for interleave granularity.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 816f974a4379..892fb799bf46 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -540,21 +540,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
 	return rc;
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
@@ -570,16 +563,30 @@ static ssize_t interleave_granularity_store(struct device *dev,
 	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
 		return -EINVAL;
 
+	lockdep_assert_held_write(&cxl_region_rwsem);
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
+		return -EBUSY;
+
+	p->interleave_granularity = val;
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
 	rc = down_write_killable(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
-		rc = -EBUSY;
-		goto out;
-	}
 
-	p->interleave_granularity = val;
-out:
+	rc = set_interleave_granularity(cxlr, val);
 	up_write(&cxl_region_rwsem);
 	if (rc)
 		return rc;
-- 
2.34.1


