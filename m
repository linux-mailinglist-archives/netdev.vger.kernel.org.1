Return-Path: <netdev+bounces-111569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC5931948
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD1F1C21C13
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD6149658;
	Mon, 15 Jul 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aZRtPhyG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DD54279;
	Mon, 15 Jul 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064539; cv=fail; b=uBXnLdvuuyvwTP1j9z+yOjH7w8BVxmO/IfjHt82jUVUNWvhrvJUfK9q0Gox30J4zbWJzIwHC8ylisJm1T+C7I3Xv+YvU0aDID/sdQ3fA5Bmd/5Z8ZrYX3fQGjpBvKJMFa44pgSOdp3vVnYVWma93OylG94ZgU7tXKMb+Ba+Mhfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064539; c=relaxed/simple;
	bh=vYBOFI2bT0XfO6WSIeRGLJWYCmAdV4Ge1NDI7L/Dj+4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P183NFcj9I9jo9+EgSkM55aFxackrnvq60vC7alfbUVp2INBZjZCkWpMOSMobKt9e2eEUmlXnIepXVLxKRFqn4B7Pwmpyd5rJQ20/YtCCJhnEIPrR/JoCXNBLMVN7QH+t2FRFSMD9PHBQTDkcz39Nw3V2Rqnf9t5ZkyPKAKy3lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aZRtPhyG; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBSjLcUFFLumIRlsFaI9RRixHVByweFgrOd08KIK8187hJHt7K3kUTdaNrYMcwvU3c1UL5/43O365LQP1CPdO2k+xwXs5pVoJQpMcoiZTl7FelxrXL5qcohDe0vVOOexc3+ktWzBIwLRZKjkzO3RRqFIbMJihUPg8t7O/yDbnU8HjRTZQWdKXG4RL+ZoynOFbfZC2Q6BLq74KizoQ1ZP3TW+SJ51F/d0F99Q6TaGQhF+9RwiDmdD39LBJuVWoilkbyJlCgVSHUTrVqAVo0mTj/38BPPjPHR3vgKeCZ3RjHgmZ5hUyV6QcoxbYn3I3HahIHui78uuoSRqXTCYmo3Pbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wp5zQNnwdNVAo/zrWt6sVtKewFcNn61WN4rfGbpfDIQ=;
 b=uKDlvhk/lL8ehVK5cYND8zCkhC5GVRzlBEow7FVOM1uU2Y+iu+rL5QfaSD1YIK7SVLyz1LToI0YdY2qIy/ytZthRl0ZwCee5UWWAf30kIpWtZhHEF6V/MJruzRuW90Q1trZAnUyiRu3ySnPAWZJqOgKT5Fh28FJpZdppw7qlk1qTmqZJuPQNawsrFHsDK3tyXr7zLsUlCZjXscp6YSojYuNSIOVwb7v6J52gN7Wogx5WQfGhAiY635K1tq7JxT3K2t+SbfJX8QCqvVwWXlYGy8bbzTkPzPTOKV+d6kqlaFbh77c6sLyz7MK6XAVcpoxMzytY8DRmM3BdNw5rJNJpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wp5zQNnwdNVAo/zrWt6sVtKewFcNn61WN4rfGbpfDIQ=;
 b=aZRtPhyG7JYCZeuhMDl5+qPQeAxnDzrfp3H9PNOQwy4YvT5tnDf1EhNQ4pGutmmGq9c2fl0/W2fnE8Wd0idESPVOUIM5nu0PnjH9ABMSM2oXaMwByB8yrLhQmdRAlAzs0SrSTtXuncF/IRzmN+uLmuPXh7S9xXO9D+aHd1Fz6Tc=
Received: from CY8PR12CA0046.namprd12.prod.outlook.com (2603:10b6:930:49::24)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:28:54 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::4d) by CY8PR12CA0046.outlook.office365.com
 (2603:10b6:930:49::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 17:28:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:53 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:52 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 07/15] cxl: support type2 memdev creation
Date: Mon, 15 Jul 2024 18:28:27 +0100
Message-ID: <20240715172835.24757-8-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 49257c5c-dd99-4194-1d12-08dca4f399e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BQQ8IvjF7W81b734u3uEyUBDHwhEu4vwLCsTgelebOtd4hlnpGOjLfvt/3I2?=
 =?us-ascii?Q?hJOiI0G7mx8QU7NlfUWnLOYX6WI4kS4TH2oQaVEhueHvMlJyG1FY2di6rbb2?=
 =?us-ascii?Q?Vr6jCiZ6PGM3pDJO5hA7H2XBnhCAXkrKwCxUjdS30pSb9NYe5PBq2o3JglLV?=
 =?us-ascii?Q?K9hon6hv3eCQYzs0JACaT1u94d/nxwEuaYSFfXrAeg6k8pJTx6wpUyweLGVT?=
 =?us-ascii?Q?IS5RKRw3WCOvIuIc/b+pvYs3Q0ZA2cFl4/7dZ4OKAGDv5V7Oi9ESma0Y6K0Q?=
 =?us-ascii?Q?/8nOApt04RFm8/8iMGcAzRaApCf0iDazR8/xKUqNxW0bqHXAeSmr7h8pOcEw?=
 =?us-ascii?Q?oiZxD/XndGTlWT94WzIf9WkJ9Ql46ONUNy9q9XQ9KYNC3IWRp0JXQATwCd1j?=
 =?us-ascii?Q?5GHr9GKIm4Zg01qebdymDKeThmUmHODBMQrOcDemkYtbEjQBB1L3kJnT1flW?=
 =?us-ascii?Q?zDJ1z7PiCQtkmOthZ9LPz/IH6D2dLl2QBxQLA0e+jZ6LHoO7SCr/eSVo5Uug?=
 =?us-ascii?Q?y+TWPgf8axHuzobM7cwLhkr/L+9DIYyJUCjz+NqIP8M42XU949Zf65rPnee2?=
 =?us-ascii?Q?ZBhmAGUnskEzSzMWFLvGNKz/wLTi8W8VJft98It0t72IgbtyI4yB6EgG+nPo?=
 =?us-ascii?Q?h+ijfrmS12nlUz7CTevUVaUgveA1/11WE3xd0YkqFCydsLJNSm7O3Fe5wGfV?=
 =?us-ascii?Q?xMIEUI8GeXZXVseK9t/cOrO4i/H5ev5NdfHHq5gw+EIN1Nn7no7ksPQ5jivG?=
 =?us-ascii?Q?PJblYjxx4uEJEEwdoZyoBAnprbhZGfqRbwTWsDBYQ1UIS6UHyPZpeDED/WAd?=
 =?us-ascii?Q?1PVkzm/WeQJnKlwzUS7eA0TsMttBhYT34AOcbp/P3lHuo/s/jn7yAAvVLIKd?=
 =?us-ascii?Q?pOEeAUJnp7xFCTHJtuzF/6Kd7oeVTlSMl4JRKqbAAMEFGLN9T6skhUgUk6Y3?=
 =?us-ascii?Q?UODxuZuUkElx8CLRgL/PJqzFXpHTBgS7D1DlNH3DAF1gtuMcgDTvEfwn+wFJ?=
 =?us-ascii?Q?CjgYhrJU7aGfiqqu3+ZuYEftscdoxxcJTZGkv0FQ/vtrpRXAKVDAMPHPdLwi?=
 =?us-ascii?Q?Dd9VnKzLf0HyCRiO6QG3MfsIBqmt1cDfEl/c6Y0Gp2/6F1QM1VOKzJobbOfL?=
 =?us-ascii?Q?OaIx1m/lTwIFMI4DHMXvKFKxiCEF44MQwxkQF1PASeSJYiK1P/bWu9rRZD4d?=
 =?us-ascii?Q?uj+PKJmPs2Uxti6Xxp+2BIGNxGON92enxZYAyMqU43yPOEQYwBQLW31ki7PI?=
 =?us-ascii?Q?xUkhxsTPa8st1T5weJhNrWTfMd69+oZ11lE+6SCmvf2VVst+Vr9O28aThHPR?=
 =?us-ascii?Q?qJmzlDwQBYzvRGeydMIokbIG02Egc84PHxCM1YY06B//J+E0qiyxKVTljain?=
 =?us-ascii?Q?1OyRX9r4BkTz0ybXay2MDovIkm9riUKfR6OaD1NFLKv0VIpnkBp1g/qsxPFE?=
 =?us-ascii?Q?V+mL1ouOhLXRcBaOvjgWnMNwyKpVN2ttECpXzBi6X7DHHFOVPSTjwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:54.4651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49257c5c-dd99-4194-1d12-08dca4f399e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

From: Alejandro Lucero <alucerop@amd.com>

Add memdev creation from sfc driver.

Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
creating a memdev leading to problems when obtaining cxl_memdev_state
references from a CXL_DEVTYPE_DEVMEM type. This last device type is
managed by a specific vendor driver and does not need same sysfs files
since not userspace intervention is expected. This patch checks for the
right device type in those functions using cxl_memdev_state.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/cdat.c            |  3 +++
 drivers/cxl/core/memdev.c          |  9 +++++++++
 drivers/cxl/mem.c                  | 17 +++++++++++------
 drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++--
 include/linux/cxl_accel_mem.h      |  3 +++
 5 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index bb83867d9fec..0d4679c137d4 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 	};
 	struct cxl_dpa_perf *perf;
 
+	if (!mds)
+		return;
+
 	switch (cxlr->mode) {
 	case CXL_DECODER_RAM:
 		perf = &mds->ram_perf;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 58a51e7fd37f..b902948b121f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_ram_qos_class.attr)
 		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_pmem_qos_class.attr)
 		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
@@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_security_sanitize.attr &&
 	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
 		return 0;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2f1b49bfe162..f76af75a87b7 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
 	dentry = cxl_debugfs_create_dir(dev_name(dev));
 	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
 
-	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
-		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_inject_fops);
-	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
-		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
-				    &cxl_poison_clear_fops);
+	if (mds) {
+		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
+			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_inject_fops);
+		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
+			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
+					    &cxl_poison_clear_fops);
+	}
 
 	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
 	if (rc)
@@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (!mds)
+		return 0;
+
 	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index a84fe7992c53..0abe66490ef5 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -57,10 +57,16 @@ void efx_cxl_init(struct efx_nic *efx)
 	if (cxl_accel_request_resource(cxl->cxlds, true))
 		pci_info(pci_dev, "CXL accel resource request failed");
 
-	if (!cxl_await_media_ready(cxl->cxlds))
+	if (!cxl_await_media_ready(cxl->cxlds)) {
 		cxl_accel_set_media_ready(cxl->cxlds);
-	else
+	} else {
 		pci_info(pci_dev, "CXL accel media not active");
+		return;
+	}
+
+	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
+	if (IS_ERR(cxl->cxlmd))
+		pci_info(pci_dev, "CXL accel memdev creation failed");
 }
 
 
diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
index b883c438a132..442ed9862292 100644
--- a/include/linux/cxl_accel_mem.h
+++ b/include/linux/cxl_accel_mem.h
@@ -26,4 +26,7 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
 int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
 void cxl_accel_set_media_ready(struct cxl_dev_state *cxlds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
+
+struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
+				       struct cxl_dev_state *cxlds);
 #endif
-- 
2.17.1


