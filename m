Return-Path: <netdev+bounces-243796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE6CA7812
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 13:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7069A3090402
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 12:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3423B330329;
	Fri,  5 Dec 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W3kzsCa0"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAC302172;
	Fri,  5 Dec 2025 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935614; cv=fail; b=g279NA13aN//jfMTNU+CLpBMacDgjkAm+3+n17O7aaHI03cUOYJZwER3bGSpZ5fnlkj83gcTAUhOkS9hLEeW9MVRy1M6Jj3CYiWATMq0D7qdxOOUZKFhmtqj5s9GIjxXUpVYuUH7dWWpstl2AUsO4IZTgjXw2SOBB3IvaX/ekW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935614; c=relaxed/simple;
	bh=VzoUgVUvC2vSpY0QHJD/E4pfPE5lV7P/PzjxcdNq/uE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTIvm4aQ64ResTssAXfSh7J7tUQvyxHfcGUSgFnLXFXZIM6is2J8DA0Sm4vA6JRi9vcnMijxhLqK03U/NTowmIPqXZynKCYP3GYc/x4LB7dzCGagUWVaM48BSPGLtVL5AfFoifm/tLSQ/QzSYmgysJo0nnObywtyY6Y8bUd4nzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W3kzsCa0; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIUNNoyGOLYZ1oXqgx3WX0Pi7J9nCm4kMKF9tWR5J9pyj/OfEzCZxG49ab2p2V/GdTBh8eLp2yrVkFufkPzPPpftecDu4aKgSSIICW3rELaOr5O9J3Qrn0Bnyzw7vSTWLrbyfgkZ+jowxm7qJ5OE3LbrZmFQN1Pm12iCA5WsAzFNCATPQi+0WCVVaGUtgcsSx92qRn2d5ilZ6chVmQxVeCDUONhQ54CUw9jRqIe8kKvn6zTa89CT5gxCB8KsIPum4CwE38QBhwbyQzMWyuYUr3X+Ihw78BnzSIN5pUsfAj6xYAzxWaPD2G6BW+VWhPbv4B6z/RYAcQ9F9aX8MSDwMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kvu60eJbnFm+OCVITt2LxkL8o+sDswJVk8s+gILMNA=;
 b=CdtncTO4zIyFj5ujiUBoqWbV/WRI6hPrOl+Qzk2uDbcPDOkKhXM/f4+3ox9IELz4X3pa5ujHYGLYFFafW/dPs8vh6oTk4kccldwwxVX5LrwgjSFygMxndGit0F2poeiKIWjDgtcM5ajAph1abi5DJ4Ib4l0s1mgx6eXmsY7pVQs/xB0QtMyDfbCtSiV2GelK3gHqKVb/f5nkybGD1V4dlUszU4YZ50hUfK4Y9mf1WFDbj3UqZjeDez+XVnIna1aIDrewS8dMKgGY1bR3dvVL1J3chcVkatWtuRv2n5x5NGL4M+vjUxOpZhHjlBqTNCupSSdfpZzm+OdsEccZ+0zKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kvu60eJbnFm+OCVITt2LxkL8o+sDswJVk8s+gILMNA=;
 b=W3kzsCa06K2xxr9tHraKTY4yxb7fQn7gsRrKXj1SKL82md6KVlmp20Yft6ihmAtAEz8PpecPKVr6IcTEIHpRl9Rkg6XUHRtTi4PQLsZbUbWKxZE01o5yhW7FhIpIfRe84Xs1sQ2l7s2+3N0BmqbdrTkwTFt2WHjWjwiH6ohwDDs=
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by DS0PR12MB9423.namprd12.prod.outlook.com (2603:10b6:8:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:25 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com (2603:10b6:802:20::4)
 by SN1PR12CA0044.outlook.office365.com (2603:10b6:802:20::15) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11
 via Frontend Transport; Fri, 5 Dec 2025 11:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:24 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:24 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:23 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v22 18/25] sfc: get endpoint decoder
Date: Fri, 5 Dec 2025 11:52:41 +0000
Message-ID: <20251205115248.772945-19-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR12MB9423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d3f127e-f3c7-4a21-a038-08de33f4e5bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uARjX79Wvwe87lb77Hu6L0BfYKkgTsq5BUQyOGfrRJRUmIdshSAhjviMdVQn?=
 =?us-ascii?Q?jGWWUgJf2DNujQvz/aT9nZ56t8DqrTbCxIjQ5+tAX3QCLU89CGPlF3QkxJ7y?=
 =?us-ascii?Q?M0lQ/UHhqY9e47hSxbA3T3OOpmn8dP9Zh8oI3+CwTYfXIy+bET0Up59n/+nA?=
 =?us-ascii?Q?c/v+vqMXUzIa53qgrTr5yEkg6FIUqpe5axi9lnIbhGKTqNmwE6sqRvN2UZmI?=
 =?us-ascii?Q?M009cOJN/mjk98Y3vnu1RzdCi7d347U2g25scTfydK04W5smrnnFIEBaZiZw?=
 =?us-ascii?Q?MjIfbb4n8R6zD0ihLOl18h/EdkrQ+/fD6J8qfnkcCMsPzKO7HzBMkp6VA6+c?=
 =?us-ascii?Q?jtvOzAZuty6JylIDml9cw2KHWsH238c1URxGGScPSMDj3ykhmVKoqPrVWb++?=
 =?us-ascii?Q?znKzsEDz/9dOsBs76G07eLRzpQl3+BofYhM2A4k3/bF7nT25Z6/n0edSerdN?=
 =?us-ascii?Q?NWzqiOqnsY6Ur93W4ynSiczlgkKm8iQMl3LBqIE+V0QFxviCP3aQVWFcOuD0?=
 =?us-ascii?Q?EnYZ1VRjPVetdLJX39vc7cJwd2Tdcgbl3h48nzLIAA5bMQ//7q3YW0rVVJ/p?=
 =?us-ascii?Q?cT2hYhPqyf9VKYHZSEQ7ewBSK7pjbl4melXaN6WgVzL8cmZkdbWvDbS4wvfs?=
 =?us-ascii?Q?E//5EGrV1mPm7ytVbrKrMmNif1d00z6h9A2zHdss6d0lDJz1gZL705ZWfZ0m?=
 =?us-ascii?Q?Yk8t8k7s2C0vCeu6GNoq3j0RcnxLv+/evccSvo+avdDOSFT/A+NvIvjd0wsE?=
 =?us-ascii?Q?xsIjP+xUM7Cz42u9P45Kfkk+M7pI48OSXWqC3vVIaY+7G0iVRk0T9xdkDu4J?=
 =?us-ascii?Q?X9KCCK5D358g67CShRJA2PPAuoOxUqBLalutOlb8e/jUYtr1bammh58JV1FX?=
 =?us-ascii?Q?p2jbZXW+pjzY7DVyn8a8sJq++SIa3aavxQxhEsCbg2OePSQDiwLODZAqQF8f?=
 =?us-ascii?Q?/ZLyBclGePb3xZIbDYRyYNOzwN7N5Ff9cQGIm0DiJP4dkIPJvWqFQIp/NQN0?=
 =?us-ascii?Q?1WsT1R8Sh682GFYAEqHt1n0gsk8Ei4VKcqAjWg8VPE/0MbGd+MtP6KN3funr?=
 =?us-ascii?Q?YN/VdYLkNIjXgmM4FJ6aSbv6/vHtRwGu/5gXsEfx17aZ1yxjseoQFy61c3mF?=
 =?us-ascii?Q?v8I0p87WLAG+hPFwA8v8qP8xRYVTei5u0orqj8bO766sKgRUu/2yBT0u1zR6?=
 =?us-ascii?Q?BYOIo5Gz52CbuFJlbTSWBErOrDkLAgvGrNp/80hP87Alr1StymrQqYsqSbEb?=
 =?us-ascii?Q?YaKbAac42QfkLiAp0hb1FqMk3LwMTk6almrbaLsEDwYNntExJm3WOIDhg8Xr?=
 =?us-ascii?Q?Ad0NB8wd7PMJxWYfEH9tOPOQnGzciaj4kkjpiOYbu2lf/GjFkhm7cEklD09z?=
 =?us-ascii?Q?JiX5OOxYx6pMmmfL/ZdVSkVGvLnzKO7KAG/hZyn10v6ThfAdnrtD7Nns9SmI?=
 =?us-ascii?Q?6/zxno6NTTyRL4gcV1xA/IubJFY/OPnCDJAKCjngAey/eml3tMGp+LQaK5/7?=
 =?us-ascii?Q?au4hB1/npwF4gHpxEgCOOtOpYWdamwhJlIZwO4ezphusL14EKbu8SoXgXs9g?=
 =?us-ascii?Q?aBzoIMlNQoEh9RLW6r4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:25.1991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d3f127e-f3c7-4a21-a038-08de33f4e5bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9423

From: Alejandro Lucero <alucerop@amd.com>

Use cxl api for getting DPA (Device Physical Address) to use through an
endpoint decoder.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index d0e907034960..56e7104483a5 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -128,6 +128,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 			cxl_put_root_decoder(cxl->cxlrd);
 			return -ENOSPC;
 		}
+
+		cxl->cxled = cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
+					     EFX_CTPIO_BUFFER_SIZE);
+		if (IS_ERR(cxl->cxled)) {
+			pci_err(pci_dev, "CXL accel request DPA failed");
+			cxl_put_root_decoder(cxl->cxlrd);
+			return PTR_ERR(cxl->cxled);
+		}
 	}
 
 	probe_data->cxl = cxl;
@@ -146,6 +154,7 @@ void efx_cxl_exit(struct efx_probe_data *probe_data)
 				   DETACH_INVALIDATE);
 		unregister_region(probe_data->cxl->efx_region);
 	} else {
+		cxl_dpa_free(probe_data->cxl->cxled);
 		cxl_put_root_decoder(probe_data->cxl->cxlrd);
 	}
 }
-- 
2.34.1


