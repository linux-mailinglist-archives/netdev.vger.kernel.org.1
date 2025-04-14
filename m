Return-Path: <netdev+bounces-182297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BF9A886B4
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FAF17B0B3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E38F2798FD;
	Mon, 14 Apr 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A+afkwww"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE95927466F;
	Mon, 14 Apr 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643655; cv=fail; b=rsErgvuvYMqT/a6+UDHNGHwSboWt8oO2Fkt2ZX9zgz160DbKDiC7REARCWV7tYvFXMRPjXdYjdzqtnvoRLkKihm4QIzr8/2F5QlcODU+xjs2lNI+t2f/VjM6SxeA26S6XdoF/MVkW/nat/cJ3JJL/VULiJxwrOTQ9XsSEN7DyBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643655; c=relaxed/simple;
	bh=88UyN/sBkJKuI9Jrp478XbCCwJeVKD2v764U8YIu/5Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PP1sVW65T1KHfOPqmjvGguCPVqFuMRojZaQa9dfXigB2w/sy9rjb1//BO24Er0ZTpsFuPaB5HF+niWq9Gsx+0TDzdEijRACLYtk+X5W98vjKerhS4z+GD99y7J0WL/TkMYZwnw8w0+1SaeCPPZYdFXKoTqYddtGbAZBfNVmMkjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A+afkwww; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJPILqXwFlCHxtL88tXndxdN04r4y+DElhBP7UsbhKAscP9JaPi67FX3/VV6CeGzkPEFxXYprqzTxNGebizRSCN3ZieqxNOmECzw1wWQiqZy0O62DGbOM0xtpABF2hSl7Nb+4eQj0L9rAyCkWHVgzM9hUeMvWt5L/y1yz6BCwYglyQayKcEijxVmj3TSMB+frdTByoZwdF0NOukIVGCxU67fFmw6v1gR/mNDHPe2UZauV8aqtnlJQ/yOgGnQif7ljHUVwWRvbmWRFMKDPjXQ6nN2KLKn4pNXGk5IVgGymHPThZcNvcHSgwWOuZH2kcZhaiXb+pK2t+Fs+uj095iXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YB+JE99mNj3wdCDWUItQJHEzrwwP2ZC4+tIhu8cr0B0=;
 b=vqXqjyVfXaryOHCBNhjZMIbDmkm2vCV7w4hTDbeRDxjgfSwOpeGpZPSPP+K2v2r560hlLpsCJG47MIq58Bt/iCoVUXhAICB2WEnm7XnIZL/BbsY71NitnopOD5lpZf0vfeTKGiTBmddcXUp+XwWZVQ5Dh548vzg4zCpQsMF4+YJHRm6OVU8DC9V/XoVxaKrGVzdzzSxrwFq7WkEuc6DsBdB/rRzIxUv5VK1Pd8HTnB0CyYR4Ydg1EFw+kaGH1eG38cH9jbRI7Yoy0iVzYNHJvHwtM0br7S4Qp7EvQQvHonfxfVnim9FI7EQWPGzrXRF6xrfNP/qQDYwL1LnEmc7qfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YB+JE99mNj3wdCDWUItQJHEzrwwP2ZC4+tIhu8cr0B0=;
 b=A+afkwwwCU8tVrOwt6GC8HzCkZM5WiqPyK8tqw1yQ6eXNu6mzVOed78KR6jLJsBQSRafxUMfdebAmcRHKUUXvJXJiOfv5uqhvYnmKNXUE2d01+ZETSE9DEW/0UoyaunYELqoqVxUnzwZYYqijypBecgNoDAqVDijO0XkdU11ONI=
Received: from BL0PR05CA0011.namprd05.prod.outlook.com (2603:10b6:208:91::21)
 by CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 15:14:10 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::3) by BL0PR05CA0011.outlook.office365.com
 (2603:10b6:208:91::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Mon,
 14 Apr 2025 15:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:08 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:07 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v13 15/22] cxl: make region type based on endpoint type
Date: Mon, 14 Apr 2025 16:13:29 +0100
Message-ID: <20250414151336.3852990-16-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY3PR12MB9555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f680b81-79b4-423c-ce6d-08dd7b6701bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYwN0/vqecNfWKlcVrVPHolSlOcAWwYVcGAFV2A/Mq5rYKhKt6juMGb+qRJy?=
 =?us-ascii?Q?iyOucxrxKsFRWWKleHnMXhPq2BoGhaVIFHBhBzUVjZvJJn3o8dNtmUwZZQtL?=
 =?us-ascii?Q?EeZEmYC4Fdi+rurTn/1g5T6ehmb1V+GTxZW6N3PEQ746DzqDRReR6eQsATfb?=
 =?us-ascii?Q?cLnmjkNpqRG6JFFdpYLcjsrelkFqWv6zb4cjzFR6UHOl8D1pYQqpIQMTRu3M?=
 =?us-ascii?Q?hB5nY0lTyuX4TdDnW9p3FJRwnMJE/lpAhmhmA9faulR+3w48Or4EFes0vEE1?=
 =?us-ascii?Q?nEmTWmWpvN7ttU+q0g3HDwMh6dSM++kzYJlnlzDaEpVl8zd3k/ci5d34vVhY?=
 =?us-ascii?Q?vijOy8PokL5QsOthQwtehDWGNEo4EbUq2CbtUrT/DjX1mAwsrYh3lGONdli7?=
 =?us-ascii?Q?Hpqh25LsfmTzMkNWRfvTX9WMZaz3QOlq0sUjCaOYXy6oaLWFVtytJCgsFOAc?=
 =?us-ascii?Q?HXgr1LUBsM7xlR2YCIO/1ueFUTt5mUjBVdO4kdzWmtihi76EPmqvfsEflQ1k?=
 =?us-ascii?Q?aYV2Wg/w9TvrU4WKMHVK6NOWkCUUI36RJHKY/h4yygabqzC6owtX/F7SxjKe?=
 =?us-ascii?Q?AQUAT2UnYsspKa4XSHv9gmcLQSe77dEMPU0f+TDCBjKoDVoZBjaxNYMrUYKv?=
 =?us-ascii?Q?9sfhcNtcAhVLIfxBVGk4f1QOJ+j7d8sdRt98s9pvGWTRbgMoWQnS4q91cdzA?=
 =?us-ascii?Q?zw8jdNwkUt2NYwZDYl141w/mire3iT2gjNwWQgBU1AsXOOzdMejLK9hUwf+K?=
 =?us-ascii?Q?NnJvqw6aRKxGeycfBF6CoOeStixLZISzYN92nWco0FpfOIOENq00iCKKNgFM?=
 =?us-ascii?Q?Ha6083ePNIne5EMxy2V1Yek3TbqH1/EhpWoRU9rfz/NHKTs5jBorEBYN8L4p?=
 =?us-ascii?Q?LNAdeDhAtAvEUrPpEQyRnuuV7wVbbaTyK8+RA05v2V+bpW+3Z/cgZBfWmMlZ?=
 =?us-ascii?Q?B5lYXZOGcpI0CrPD4YArFrX8KjC/yUaB6tN/qH7ml4Fv+y8BlcVE4MNG7/R8?=
 =?us-ascii?Q?O0/4xlIgOpwSrhgdJWLB8E9vLWv34YSlg48GKwfiW662c259sh1alpOUwGIg?=
 =?us-ascii?Q?Io1vgvjB27yEpfUkZSAswnu3XQrxnF2SLcgEPTnx5DBAh+zeMaLKUXVVio/1?=
 =?us-ascii?Q?GS7ZP13Kj4vjmUchY+WdMbkUDuj3BWgaJG3Pbow/4A/6ZoIGu723PpJ/i18h?=
 =?us-ascii?Q?NsyLu8ODM7BOS7zzExgw4dBeCk0CTk3g3IQTT+gCeTZ1hWYck/WBSHkk0Bvp?=
 =?us-ascii?Q?dNiyNj7PncLAyP85hk7EZaEkzBs/cjmBgXPI+yu6kBRAI/6qnAhOosGDsLxk?=
 =?us-ascii?Q?FVZ0Sdej2VyaFJjwZeHDDXnItZrINdSxqKyUpKzx/HjOWVyyEfEkmwCRh7UB?=
 =?us-ascii?Q?Pd7iM0wjiLPsByWKhVvYCsz83LmktjrV7X04OiVChaaCM/WdcJXbsQ4HzdcE?=
 =?us-ascii?Q?igfQTKFW7SLhYOuJu2G6rhKADaGE7ceI+lpgmEYeibevVxTnF/anwcB1/+J5?=
 =?us-ascii?Q?hvPwpmPKKV7mKdAjtan7bZNMkx79H+twoQ2L?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:09.6474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f680b81-79b4-423c-ce6d-08dd7b6701bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9555

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
index 0a9eab4f8e2e..6371284283b0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2712,7 +2712,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_partition_mode mode, int id)
+					  enum cxl_partition_mode mode, int id,
+					  enum cxl_decoder_type target_type)
 {
 	int rc;
 
@@ -2734,7 +2735,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, target_type);
 }
 
 static ssize_t create_region_store(struct device *dev, const char *buf,
@@ -2748,7 +2749,7 @@ static ssize_t create_region_store(struct device *dev, const char *buf,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, mode, id);
+	cxlr = __create_region(cxlrd, mode, id, CXL_DECODER_HOSTONLYMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -3520,7 +3521,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
-				       atomic_read(&cxlrd->region_id));
+				       atomic_read(&cxlrd->region_id),
+				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-- 
2.34.1


