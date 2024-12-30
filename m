Return-Path: <netdev+bounces-154594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0511B9FEB2E
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4BC7A1891
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204D19E975;
	Mon, 30 Dec 2024 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y8gN7oDa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D2B19D88F;
	Mon, 30 Dec 2024 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595142; cv=fail; b=eGzQPjZf/TeBv4f92zAyQuJf0kj2WqrHh8znsArg17EcyRD5Way/hXHTr7L6gLAjRpA/k1xIXpnmnPQnSfYYbdPkX+HcrY2uIECLoQ3woR2Oo+oXRpbLnLbjU572LUfWZO334yjjrXnMKxIqMKyLZHMTTt5Huy5BLfW3iJABDIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595142; c=relaxed/simple;
	bh=tO0aLjmX80SzPwtXlEnccA43NXd/xNFedMtHULVWmGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2nBJ0OWvJpOKPEBOXma+Uo3jWyJ1XOBrKe8CdCadtPwC3VYlLcVzag1hhVeJwtrw6U51cOEhbHMHzVoMz5TuPcJbc1fNXq3u3hTlUuHCo1quc7l/G37RG6if9MX5qG7xSl3SSJ7sxpY73Fl+ztvbZzkFbhpXJ0+WEGpXUka1r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y8gN7oDa; arc=fail smtp.client-ip=40.107.100.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFQxmuYhfQIQTWvM7GPtnVv6qtZiSA+oY4mLZltMSQnNr2Q5cTvb9TMHeLQPTmF3MlILINiPjVOGr3gBzjf3/fR9tgcEgR/qb77N6oOf3UnUysEaddVCJeWUlitT88dB3QuwNrxNgfIDfKRggjSAeKszymtGJYObVAabBC6bbr2UtZBo6U2FG7hOQGtyM2Ox+HZVLCLZCWs9xaOy6g6TfdaXCdBgdKzZobkzeM7Ad7rjdgFXd7l3ThyYxTpHfn02WBd1+yUpyUvBEe08KzXnZEKEDL1wjFiwLYhza1vUuqkOpGsjTm2IjepWND81Jli29pRRBdsj8SQGZLcUxX54tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuSYBvr1QRffMMAdL+krb1NkyFND8uW7DLK3J0M2pMA=;
 b=pC8812m2LwADu2ppa+77Nh43zc8IdLKll0bDN+AiWqnWUxsHSks6vm0AWRei7WOc20wsQDIbsipQr91hwCFLn1tRSJWsvfoi+2dhwtAEXUXzSrymPisNPKfVd7o2erCnWBMD8TzHXX/Oq83wU0ftJ+moP3yjBKn29JYoCFXTnsnwXwAkmIS2aT0bMWPCkz86Y4IR+Vu0TZcR6Yib335LMTjEs7uUWDWGmw8vIn0ZZBjTmzYyAggwc7NHsi49eRowcX060i0HHqY0uu4+Ae45ssuibix3/gM9NG6dPpE7/u2mU7Tri8p8vyaRHgIORb26Pg4hjiLJbOB0PLZlYZSFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuSYBvr1QRffMMAdL+krb1NkyFND8uW7DLK3J0M2pMA=;
 b=y8gN7oDa2EVeoqjgOHV0THM1yCoT6wrm9tcgiCLhFPgK7zKP68G5CtcdCIKZ7tZMUuUhqee9OvAAT+lIOu2gjACukynLNBn+75ajr6aCmEY4+P6wppvBi2PjnLqtNSx2ezfEZEgz2r7z2rl0OtqERMgcCtwN2GdRSheLZKvsVn0=
Received: from MN2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:208:234::6)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:45:30 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::3f) by MN2PR16CA0037.outlook.office365.com
 (2603:10b6:208:234::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Mon,
 30 Dec 2024 21:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:45:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:29 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:45:29 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:45:28 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 25/27] cxl: add function for obtaining region range
Date: Mon, 30 Dec 2024 21:44:43 +0000
Message-ID: <20241230214445.27602-26-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: a33c45da-8367-4832-9ad1-08dd291b47b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F0jN0mqAxOTk2FcXBIry15ZJaXveI3fiXIY5/Bv5bdYmTRnNyEklGHDIoAVM?=
 =?us-ascii?Q?UVV1h2P8MDAzKQNJHTUD4ABXc6wyI5NQKV7kni7256ybaMLWEvXEO29orlnT?=
 =?us-ascii?Q?OauTKXA19NbRJ7bwrppO5EhF1JumFe0zJeJ+jkVIGJ8MGyBDgHv/rhRboY0E?=
 =?us-ascii?Q?wAFoJVEZwPuPbaMoLCDHaPUZ43kXT3G1OFBZ6VLWokBcGpCnsO0oZ/wiPwf7?=
 =?us-ascii?Q?q2HYSRPHVmQ1KEXozKXyzUxCQ36fNkVmYxfdYHPZbe9L39m33uvPvupSsyIx?=
 =?us-ascii?Q?Mrzh3Lhqtt8qc3EIhujMqexfr7fmt1EcWCW4EKjFysVC2zaUYfx38xKpsB6V?=
 =?us-ascii?Q?AHnqsB0It56pEOTlRgVosYvsOD8Rl/kp+ft1sTtN0znGpKm8LAQinVhCJ5tb?=
 =?us-ascii?Q?LgWTeehYN/1jmtPCCzv3cy4DdLfJOSPjNsEDNy2vZei9GGBHywjKCBgQ32gn?=
 =?us-ascii?Q?fAe3Tvb8JhgmWagk9cRNhIPBwzKP8UJd5gmOPkvPrQuwJUzT7lwuRPmhBO+M?=
 =?us-ascii?Q?xvtGj+e1ozSPyHzgvtvfAxsKKtxUF2dgWEoD149BQxHzZr3Uti7TxMyj1d6y?=
 =?us-ascii?Q?PXZd5g3YmSmX8xz+9WpwM/Jq6NhXhq6H00XVFf3FKy7DFVUWxqortfWQ5LaN?=
 =?us-ascii?Q?aVWv8xERVRiLgxwLZrIWp/KDUdZpC8lkBrSOlE9EN7WxsV0OLgCI8+tC/nm4?=
 =?us-ascii?Q?w1RWtJAcISsxPbrkgknC/lWAFim6+xkP7bwhhBPuRj9PCVqMsUn0F69kIyA/?=
 =?us-ascii?Q?49TrqjOeESDSWZOCjL6swv+fS4IdKOHXKx7yfKZyggbYjEgQ2++GjLPbHspr?=
 =?us-ascii?Q?NSxj/rlICOgZuK6q5IZdHmSjB4ocBLn7FUT5unyT/i+4bifKHxxA8nCryYBb?=
 =?us-ascii?Q?B0CAduytgt5FfRybpB2oIyBDPfOQKXeXYSg/G03JFPyhE+ziIeyiYcV4OIv/?=
 =?us-ascii?Q?GA7nTW0Q1hkKA443WgFHGNh+KdfIcD2HbDgx0gk9vTatMSgjwUGGb9O9SPGS?=
 =?us-ascii?Q?meoW2uSwO9ZdS337NECuI+LvzyTC1d1WmbjefEfO+yR2s+lPAw8RwiC+7x0D?=
 =?us-ascii?Q?RZnG5pTrvEE6+WbXk+K0y3Aj7thMMAF7l5TJWqaM5U0jV4jPfg6lxGf6SAnu?=
 =?us-ascii?Q?kfG3gDPzmyIZae87odruKUura+oncMF55Da0fz/PcMyCYaUkLNQwf2vAPxvV?=
 =?us-ascii?Q?SuR53RFS5fsko1+bb2RmJ/DP94Q1BI7QSdUG2bpOb5NL7GoYh8vOtgR+pvfq?=
 =?us-ascii?Q?Zf01d2lZA16IwYNG5d1dLzfMMmU3PBoxYAvwUjBNscjRHrxz87ct4qQ1Y4Cq?=
 =?us-ascii?Q?Rxxela5L9tZQebktYRc6cMoB3RrrSM4SHO/2EDslqCUDra3kTSQ5vdLpBjCa?=
 =?us-ascii?Q?R5UGyZY8/HHdgJU+dhkQrY3tgQBIg/A8b5QzsbL4gp6zXqMzVFGYqMrl4irJ?=
 =?us-ascii?Q?ZTEB5YK+q9UftAkk5c2IHPAjt6gMCd3t7I9a6g9hpRq2jMJ8m0weCi8LlHj3?=
 =?us-ascii?Q?Z7tedIBgxY7Nh98=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:45:29.9727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c45da-8367-4832-9ad1-08dd291b47b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for getting the cxl region range to be used for mapping
such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 15 +++++++++++++++
 drivers/cxl/cxl.h         |  1 +
 include/cxl/cxl.h         |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b3a68c1d0652..26a84f6f9fb5 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2677,6 +2677,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f28873a17443..0fd65d941bd8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -921,6 +921,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 19f3eef44535..053722ea3e6c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -68,4 +68,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     bool no_dax);
 
 int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif
-- 
2.17.1


