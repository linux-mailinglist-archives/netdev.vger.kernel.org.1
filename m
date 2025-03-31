Return-Path: <netdev+bounces-178331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651D2A76906
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663BB18861F2
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB368221DAE;
	Mon, 31 Mar 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y77eZZBB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68335221D90;
	Mon, 31 Mar 2025 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432410; cv=fail; b=LwTxR2gz8d5YHfMzAWYq4WUpb+RMrEEcR8tH6/+22Nzp1opKgbD67r1zrTLEpg6ftQFyZKoGx8BNa1fFCx+6ldACo0d1EfZLXjyWv3lpDLsIs0OMW4fZPGoje7ncHwkmIjb4UdTZu9IBXnULXiN9kaYYe4XGvm+TEZ7iFiFGv50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432410; c=relaxed/simple;
	bh=Fwq3KcvSlAlMk+GYOjN7mO8VfbHMPH9kiG/kDRvVk0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atB+zh69jrBrxIlY+l8A/koV/nXgPpyO7nyBIGCBMlGKOBShW1DB1IDpO6HhBGIp2sgcOsE328ECCIMjdlwy0Y6uwyXQ/Zp2Cn7k/7dSuakkhFUd+33CbMnkmhaVLjIgfRROQvMzWWN5EKjwwFgdJRLOyF1IMFeB3OagiZwUdys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y77eZZBB; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fi1h46vRG1LsHLTuXJqYhM9qcZXh40puqz9QMg6ACXyJVNlJf315TtgtG1WZlQnoV56IWoGdE0AxYBnUrTGd/+q5ag5YBV866Ld8lE8YzX3cV9RjC55O4CEfy3CjYQ81g2JprGdm88L0cfaH2CSyKZWkJB16j5er0QGRkBlAayscP+siyAv9PmOud/CwBZU+YWPrI9DydiZcRDbU7jw42vgpbznoQlBP4IArIXXs8jeRCHSzXU0s8L2uxq5IdZjjBdePAAEcZTv1GbEc+ngqLTRol57OIoBO8195j/2iTYzbDBA5x3DNNO+6Z4OnY/kw7OXwwZJOYZNYo6O/kEBUaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orXXxGgKafIKmrXW+Gv3GNwnQ9g90m6yt3oKpwrdnDs=;
 b=GCbiH0eNixGKJ65ScEtKAZGFUyfX6pNXekQfvtvZWwuxIHHC+2MF3IrO4LVE+NaAcZ/2oF4Vs5MH0IIiWzegfVC25MaSZ5NzK8v2kzE+IgvymEd2iz2vl7g8yQt1Qunse/I52Quz4E2fgYkIOp0NnhrV5y1k/kY2coyMk7vbUxBkuSCZlCK6GpnWrwX8fz7a8SSy8iwO4z4Br2N+r9hcjXYJvaVDURi+ugRGBffQ9ixG0HY6emtHCvxRKy2cSGU78CLFh864x4+GrhC9LPcX6yEpVGTnNw9a0+COpAcZqHO2hc2bP+buOw62m0fgjrKb0gIgZR4GlpMAR22+XZt0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orXXxGgKafIKmrXW+Gv3GNwnQ9g90m6yt3oKpwrdnDs=;
 b=y77eZZBBJiltG6HDgvF415ePMq2lVBwRxrjUb7+I+lqxSwIKP2D8aEfbBerNbWZR+Slvcbi9egro1su+JGxEKKlRXNnVKsDWrjXOrghtbFtg+GP7hnZ4G8XnuzDPZ9ban5WIKkrd5g/83+110AIwbhfTiGblT4h0x2u7X8BVhwQ=
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:43 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::7) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.49 via Frontend Transport; Mon,
 31 Mar 2025 14:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:42 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:40 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v12 21/23] cxl: add function for obtaining region range
Date: Mon, 31 Mar 2025 15:45:53 +0100
Message-ID: <20250331144555.1947819-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: e152b702-28ab-40de-53a1-08dd7062da3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eqUhxJEoUlb0LHtFkdsluIKu0D1GyR42anOKIJKl3Yl3XEM0CuRU2yDJLwnl?=
 =?us-ascii?Q?lc6SPB5uy8I3H5iWpBhCFXT7WOSpfyd0TcKhzXl/S8vyZdTv0Qbr/knH/95O?=
 =?us-ascii?Q?Ij8d9CtaDBpxAmnk/itFrgnW4zfETNp0pcw47/p8nCZopeLUEvHP0mTMZ/sx?=
 =?us-ascii?Q?5l1010WyLfefz8smH7cWT7pKOT1vncXbP/rtC3lxhZDvxYJucQ7F8BHRxtj9?=
 =?us-ascii?Q?Ni+MlS6lEzUD7q+PvSJx3IRVttphRPBaq+KSyy07awS9VirvJ92Vf3KHOP6u?=
 =?us-ascii?Q?JU/tG5UdCaTyyEiAa/SV21JPhrN7R1qd2BYj0mT0gFS6M9qVGVkaPfZVA48i?=
 =?us-ascii?Q?55o8IRvnTsoh4K5v6jTKNTdnLQpz3Zk9wuBYzSMuMQHGxzKA3AfxsbIInb+h?=
 =?us-ascii?Q?UBaDY95QX4la9a9rrhEc8kFwa02LAo3tZ67oPtdIYYcscNepDJXW+08NXc1Z?=
 =?us-ascii?Q?1QaCRdw/c7bDhZLQtxp6zZshGgY0g5UmWZePhs0ZEJ2FfTREVdz4nx1pWkGB?=
 =?us-ascii?Q?GQ/REFaYrLPvCJKYYzZHnlUWkc+TuQBOOLszvh1Xo7GAH/4uQZmUAJs/ghR2?=
 =?us-ascii?Q?MVBpK/do6gpJe9PZQ4XiGuOORmR5S3sNBCmLhhl2asHLDMJnu4dw+gMAKWx6?=
 =?us-ascii?Q?LYlsSkCbDUf6wRanBZ1oXrzjebe8oNgs3ic9ZO2+pSEVAK0ftGd525X4KxXw?=
 =?us-ascii?Q?3FVsVbKX5SgrYH/oZXkxJL4cibgu1aL89Lzg2RWoeIm3nX8Voll4IY+69dy2?=
 =?us-ascii?Q?US/ByQ8z7K9fHMMlyEQL4tOiArLnjU1v418iqgMuB8Dzb7GvnZCxNHo/Ed8d?=
 =?us-ascii?Q?vZ9kS8AD680iVkdSKh5FZRGFeT5cOdy4c4ZiEXfkSf4VF3tMmsnxPc7b7sAs?=
 =?us-ascii?Q?uSsObcOdNc2vbNTdJ7UiLJcnvj5m+zcq0Pp6zPzg/VzNGGxy5FwZgTCYZpvK?=
 =?us-ascii?Q?1aEIPwsdDKiMClaTb4OCvj2sltF3C7oTsfmZrz7QpCw+PdiO/PKQ9cGwzvKV?=
 =?us-ascii?Q?mcON9iKkKr5ED5q5CE1PpKhJqw1GLDYNcHRFdccfc50uS6VUu92Mc5dg4NeT?=
 =?us-ascii?Q?dAzvKOOAiaQ23TC7xwo4QZu2n6E9rfrdbbcf2zGT04y6jpkKGk2PkB0slXol?=
 =?us-ascii?Q?la18kNhe9e78a1WF0YUDazSBkYbK8Pkio1zqfLiG65tOwS8/yq3DmGHl1XjG?=
 =?us-ascii?Q?SJV9aopvD86WwFoCVBZ5PVg7grzqYcUqoNKqMfifcS+LAGmk2WyhKj35sXQD?=
 =?us-ascii?Q?CqeT9GqY4z5MVLSazv4u3+lO06GMjbEtDY67RBofRCJsPMXy9KEkT9B6ii7Z?=
 =?us-ascii?Q?iYpQj414+TtkM0KAIcMfD5q4cKsUfwAPoNtGyjWxRWpYgQEBcw3FcJ79IaSf?=
 =?us-ascii?Q?5TuOk/7mPGhNeXdkEuMspJbWqZCIBKw9HGSljsoaybdanm5dSyIVr4KLKFtM?=
 =?us-ascii?Q?I1FpHYFwPF1jeoCd+a2Orgw5IrfYhWozU0HOtzrlM2l3xT9L/34G68vzPMKZ?=
 =?us-ascii?Q?LxCzBfc1FmqsSJZYU869N9wEvKyKw1jHgIp9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:42.6345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e152b702-28ab-40de-53a1-08dd7062da3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 58b68baf2bf3..12aa5bd346ca 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2716,6 +2716,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2bb495f78239..23f467ed2f2e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -266,4 +266,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.34.1


