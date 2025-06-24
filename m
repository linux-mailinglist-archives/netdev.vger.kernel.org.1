Return-Path: <netdev+bounces-200678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F16AE6818
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14FF7A81CB
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709692D1F72;
	Tue, 24 Jun 2025 14:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzQG1hsk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27012D2381;
	Tue, 24 Jun 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774486; cv=fail; b=ibCr5pS2wDX2Xom3xIlzTaNWzwupIpLfV9dtS1KdV0hXXpVdSuR/KGzDwIqIha2e+t0/50rxWh5KkUOHtoFt/AzA2HGSpmkA3hfJXNr/sVs4dzZwZA3rJRn/DkdwD8GZiWcrJ/22HVdeEtYl1TzRqatJJGhECN+eTC1FtnV/3/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774486; c=relaxed/simple;
	bh=KpvT7VF+xT0QXcIcBqk+cblCXLzRA6BITxSbAh3rkE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arI0x0acYS5HdUKz4pXN0A5OZDLu+Iy6zKokEXvy7OaQMjy6/QlBw9hhcKjzE58UDfHoePySjXdA43GMNygJpgSWEAsUBr1olBMRc7YcoLbwXvg3XOlCb6ayzmcKW03gJxiqk9Ng5ktI7TR81mlouCTeApE9VIXJzQU7euB0z8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzQG1hsk; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QB5YbLJaQmiDJTDQKUjHgfXEcUqqHL4zfwgttdkCJaC6efEkV9DaAu9QWCfUJkimAmhJsNcg1YAuxbGnGpdWEPCdebr0gCFdx2juBxMiBITtPQstdNWy5QzigQ60oxhR3GrbYj4NfUi4tP4c/+EYDxzB8rTX7lqf24qA73/AmuwK62FvXWjb4b/YJcFthNiaDeInvqTHZ46pda2gUO3nFZOc5jBVjkVLmDoT57mOWDzPeOmGvbFAcPFXm86Z+vTrKjm9aQPk6k85pg0pgf2TDfdfE721wzVfaxTngAsoC+eitPWbl6mdBUdHSRNWE98X7FSPIQ37pnXj/13xqQEn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4JVwMoJ38s3s/Mx/WgUvJbFVwYrV6A1tJA6y++lMys=;
 b=B0Nmm/YRWaFXg1Tqva7m6zPnEEli9SIzVT5BmfaqYMz21iv/oQocYasfp3KpkUdrmYdiVgO6/c7pCPYkn8iDKCgy9PH+KylD5Z/m6gIjbdNjEupt5mUerp5A4kmHCnLje171SZzKzslVbJ4q+iIjU1/qEJNJa9FkQP/cC2qxtPUjANt0Ny1aYYyu68NAPGu4Y56l4BtzYyPNWylmcVjfdEl+8U/PXB0XfhxOqkP+Lhj4JI5w6X5DMS6Mw2e2ujnU6fF30OxE9CCK/ee63ciB9U1PmRykaiSDR4w4CkUeKF9eTl0T5NZo4iQa9cDByDwbN9Kp1QBzd5c7cLnsRzaDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4JVwMoJ38s3s/Mx/WgUvJbFVwYrV6A1tJA6y++lMys=;
 b=vzQG1hsk//U+KImu00TPSgu1+FdfX4EmTBH00ZdcTpZEx6dNbp5KZWiAyfHp07mjLZwsEt8We5lviGSI0Kt5ZwpkL25NG2IwyvufFmnGKjIyIVbr2NbDOtMDnfOb4eb9TP3B+xRU8jFbLDhenkDL7jTSnrQtSBft+l47PetjHjo=
Received: from SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::24)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 14:14:42 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::19) by SA1P222CA0157.outlook.office365.com
 (2603:10b6:806:3c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:36 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:35 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v17 15/22] cxl: Make region type based on endpoint type
Date: Tue, 24 Jun 2025 15:13:48 +0100
Message-ID: <20250624141355.269056-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da447f1-4aec-40a5-eb8e-08ddb32976f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKkvXf5Z2vvWJXbT3Iw5DmLPtvWNYZ7sN+zy3na/K0su4BTO/bMPXtetl/zJ?=
 =?us-ascii?Q?FrX8xhEhFLj192v8QHiZIws8MLKMAi83W5jlEKV++6I0KHlAVNKj40V0g+zg?=
 =?us-ascii?Q?Sv73vfVN3fsuL53G8TPThBElBsGrtFwa7d/I9vKYIlz1j73SSQIWmhdzIE7y?=
 =?us-ascii?Q?PL7vMFANxueLFlSPBtDpcj2H0oefIOQF26XuUuZwYpVHXmNYYwsr5lEq4VC0?=
 =?us-ascii?Q?3INSWyd/P9PFpddN/lfgd24GQr9n2bMgW2dBqtASpy5/s/wcBJdMJRwMGsud?=
 =?us-ascii?Q?EqN/PPgguZLhuFyP7nWjiz3V56WDAbU/oZMG0VdPZUeiDw0B5nkCwx9s5HdM?=
 =?us-ascii?Q?14ZfjHuGytqB6uzYKebmg8BK0QP+6u+Cs17XKbcHqxcD7foNiDAndQmNCmvd?=
 =?us-ascii?Q?l3NZFy4Cems7+WUY2hYVUMqSXgRrJEKXty5knh65EtXlYurqudC5UVTXooFs?=
 =?us-ascii?Q?z8GHEsCnhZHHq6TzqHgLmZu0iJM13EjvCTjDXDTfBrhAl55gwMmEB1XoZu+X?=
 =?us-ascii?Q?25tRjc24dH+7ce15qVzrE3bFRpFSuxe+z0qQoelEeaqXimgOcrAaiFPTj8LX?=
 =?us-ascii?Q?qI2UBXsFJq7qFlZUeWVDkjctGJmZMnQxS87/6C71Ke0TYDromV7XqOrVWXPY?=
 =?us-ascii?Q?knX/k7rg46jAhkGYzpgWHskiKLavSB8fg2egiGusRiz5ZCMbXDS9XION0ItB?=
 =?us-ascii?Q?CQpgw4rWT1E6Gvt/xD33k/obM2NjhbMyAFg2fq1MqiZ1Cd8IypV9423dI2Gm?=
 =?us-ascii?Q?gFHO9hAZPbrj01KHXn8F9qiLjrkDzaaLFvT3iPzaK42ZZKZv+bCwyLD18DPQ?=
 =?us-ascii?Q?c5muEaHLrDO0rdTmZyvlFEsl8LGoJ6E/pDq/1q8STz3GLtHEBIuGkWV2mKqN?=
 =?us-ascii?Q?nlKS4h/wu69QPOamVP/GT88jTg3n+wWvO5kN77Bd/Pe+xjbYXPLPQJYeMqLm?=
 =?us-ascii?Q?mfZMCx5L+pcP6MpfdmXDHiADyMAZTTCWkm/a2IcEtRjpH6n6RigYKoan3vUE?=
 =?us-ascii?Q?Yk5+skFz6e5DEDF6vB7Az2rgLUx1grlyj6ahLzgC7EBtJioq3Z/Yi949EvjN?=
 =?us-ascii?Q?tltoBTdpn883AyFpeIZPsN8wyJAhAMGzbdEC6BQqLjKYlrk577dITVDPBtvh?=
 =?us-ascii?Q?f2A6NjTrAhRBeGwro4Dl8oLyTz6d1+QdNoE9BQL16VG8GaMLr8SrnOdZxq0t?=
 =?us-ascii?Q?vXzS7C/fX82L4AIHgBqIebeBg+HVjIulflMG2wohsVSZdikSXS2u6A5IXH7m?=
 =?us-ascii?Q?zciZ4kNlfq1hvEAJ0uaeGB//hOxLPljVOcdHItoQ/PoEOVSIVk7AkolUPvBG?=
 =?us-ascii?Q?lEAv08Rza9l7C69L6FWbaTSZDXjrsj+Bl95gztEOsmLp8vRRkXKpD7RSqFYW?=
 =?us-ascii?Q?kEgG9qv1HJyVWhGg5KgnIzjIaQTmE3zcwXJ9DuMR2myFdkArWKUnH3rF7nis?=
 =?us-ascii?Q?Kuhbc+NO7BbTePtn2Wmf2F7HIukaAvKd51J2dCDrFmbaAN7osYO3a2/RHm1/?=
 =?us-ascii?Q?H1KHqgAE1WafEyG0IcndRxaSmFEawnmdq02M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:42.6554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da447f1-4aec-40a5-eb8e-08ddb32976f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

From: Alejandro Lucero <alucerop@amd.com>

Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
Support for Type2 implies region type needs to be based on the endpoint
type instead.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 03e058ab697e..c8ef30db2157 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2717,7 +2717,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2739,7 +2740,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2753,7 +2754,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3525,7 +3526,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


