Return-Path: <netdev+bounces-126227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9196D9700DB
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035951F22BA0
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A415B132;
	Sat,  7 Sep 2024 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sof5BFbx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B81494B2;
	Sat,  7 Sep 2024 08:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697201; cv=fail; b=dNF5Rbfd7ZGH3laKZ+ELZGlz6DkbViBUID0MIstx4Y567lDZ0hl9Rzp1ffXQon1NWYpve7wNHMdt6mgc6f4HThwAhE8DrwBe2sNHUwKQbC0FyPT5R8ZlJWF8XzNJUt5cUVJtihGM96k9HdruOlJ+EuhLkGzZdwypSSWh3rXYghM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697201; c=relaxed/simple;
	bh=obX9n7MXadAuIBrAyhN0m00OyWhUJIurTpIupkT+Cx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkF/s/OfJ95hvrbqXWATlEbLVIwSZjs2oPUwHdmcfETm0TjNp/GM0kOUyfQ0JFs59xSrp5xhtvw1TF4NtfjieFBZs3RcLxlhsx8lTAR2MTmTbqE1skSChakGSRMEWmXgQMt2lAEYAdi1aZaf+eq78LVqc0dgg0tjkXnKX1MFLus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sof5BFbx; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tbx5o1WV8i2iiTOFP+9iuJoHE+hi+lsi9igtquneuTcyv9u+mqOkLOt2GwfAslGFkVVfCYlHqUcgE5JlVbsukJdiDUTUbD283PCdZS7KDt8KeRAVNcok+wNbVik88wOdzY1Nu5QvAJcRjoikvWUdHBryWY6WM6jpSe6bBBAcxri7Og0UU0gnbbE9XPsIj+d+braHh1Q4JG7dVeKFRscd/k1NY1mObghcwKfbgy5PBnGsqF6/yqm3SARi24fv1tAZ8AXZdF/pTWSTpAnsXUIorG4HatHzq7pTmZQN/bS2wjFIcoJ+IB2JcSAPwcFg0tYWcTcSWZniV5W/jav7uuMQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GXAhfFDm73LSN7qZZ3zWKNkdBkAdsnph9VjuS0ulpo=;
 b=XPbVw0htKNM1lfdmexVQHnbsnQHcLVTE2IfNKG8n++Kt1Xk/rXHutU8GePeNWPyVjgMAMeZ3iZuGAwb48mwlvPW/82exYi1zclxbUPxvJtQ+PFLjnKXC7+49avjZJOpdiQmCHyEess02zCc9MtMV0cxPOSXBd0r/TrqoNC802lICV3n94syGbPbTs0sWMhwYfIsXmu8zzQRn2osHUgitdlooJNBGo1vQY9TJSq0fX8hi08d0/C94+ftWzfsGsnG7TjABBPYINfXOU0F6PnvVEAsxoBC1+Jie8hMHDeqACjEiMJTiLXnG2lKzJogWctKsygn56g5LLzDnUKkrBDxbOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GXAhfFDm73LSN7qZZ3zWKNkdBkAdsnph9VjuS0ulpo=;
 b=Sof5BFbx0p1tW/W7+kkIm03dyo6CeSQGVev/X0/q5/Z0SitZA/HTCRYhIax5jq+9i7Suw+/3jq3YpPHG8gC7blW/xiHkv3vetn216Uhll3q4T+UKRYHIHEXytdduVNTpk869gzGrrqXIk3gi3YMC07DD1pL22BMOu+rnt3UonXo=
Received: from DM6PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:100::46)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Sat, 7 Sep
 2024 08:19:56 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:100:cafe::81) by DM6PR03CA0069.outlook.office365.com
 (2603:10b6:5:100::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:55 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:54 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 19/20] cxl: add function for obtaining params from a region
Date: Sat, 7 Sep 2024 09:18:35 +0100
Message-ID: <20240907081836.5801-20-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: ade8758e-d675-4bdf-3bd6-08dccf15db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ETefO9GTTu9NIpL/7dlnihtRMIRNRV5guPTfVPSyVPFfm7czLnb98MHx7q6n?=
 =?us-ascii?Q?5l9HXxX5lv5ikSjRDEsr92Dpk2JQ4XOZR4FcTA5C6nqZUni4JcNLRyLptijs?=
 =?us-ascii?Q?WO1p7p8IK6zKELB5RhxWcLZwEmENw9BiJ6C1ZYib/F1vzbvBil8F4yVP76gq?=
 =?us-ascii?Q?6iiByX5nlCoevXbboZwqyoGIiVhPQf4/PwiDctoAij8OZAfqA1d7Wvvc064m?=
 =?us-ascii?Q?Vgxr+MKWUyd18x8WC9+jK7Rs0bgjijlKb3GHhF9H6ZAq9UIcoeW/05PPPjyk?=
 =?us-ascii?Q?uavVpYITYvm5jYpGhXUHSSalrxMioccBnidT/+g7rY3fzUbtjhreRf8lNaFY?=
 =?us-ascii?Q?r/iY+MLhnjv/sP6LO61gvT3XIJZ1Dt0TYRShie2nt2cXNhbxsYjR/U8iwmjS?=
 =?us-ascii?Q?iwh/mrB7+vr/vAw+Ge71ljYekxZFHvAh+Jhh9PTFsji/AshliKWS/ZqJTz+n?=
 =?us-ascii?Q?oYfqI4B5xNHBVq7G/freh0fxaZB9C3txc+W0zIMQx5NeMiiMRNXFvyIP8bZF?=
 =?us-ascii?Q?QxVx4Egbn91E7LBRySQ4WRvvBOEkurwyFVbjCajVR7lb3Bt2iW51sqc3M4no?=
 =?us-ascii?Q?NjU9URdJl+UvM42TUm4nxL0EVtXs6VmbYRGtLK9MmpIj0BeJgzpY9nRlDk0x?=
 =?us-ascii?Q?HG8E4TBMjKUAcTg1rqeaj7h39w3oM9NW/Iqq0eqc/htccMp2dttCjbJs3oMo?=
 =?us-ascii?Q?HD8mJ39Vh/yZYnVB+wKAkRhzkDw0lQuUp47BXkNI0OLjpDpaRESUaH67c5Dx?=
 =?us-ascii?Q?D2HrZRR7PzhL16ogdeg6VjPzvW5ZIx7JjX476/GOvhZIfGpZIAB5WgeihuGt?=
 =?us-ascii?Q?Qc/r3GR3cudUb7LNhsTs64xx16rgM1lEnURSu4OrYazvWClgu0DO8bt6w4Qk?=
 =?us-ascii?Q?RAN5MVgQQsNWsV4bfXYGwJJPk2NnuhQI7E7v8NJ/pyS6h/fnA27rmhONQCkW?=
 =?us-ascii?Q?M3cNoIfT5SMjW4V0sbki/0QYxb7F+jhOYEmoEvSBi/VZJzxNakV7RyYzuten?=
 =?us-ascii?Q?1YG8wnR/FGnV//NlVIrmxJm0yZ+mklq6OVn3b9Zn2l8bpG7oQ9xLYi19b1B3?=
 =?us-ascii?Q?Z1MfB5hnZJOxiDQ0MSlNj0p9vYiUFqDOxbYDxo68MOKyJYDUespgjqFfTNPx?=
 =?us-ascii?Q?5XCAFX2Aum1XuZBubPhTrMIfauJKqTvXazMhtXDs/AfS1NaFSg860psLpITt?=
 =?us-ascii?Q?MfiyTdj4DZLr0y8jfCclfqNFPfXKXjXScEe6rdeqWw2PIJoe4fH21yxes9aC?=
 =?us-ascii?Q?vPjx5P+U3/EL5cJiXov86ERNoP2bRV9iUzQJauDv7E9M9ORMR9EjjjlzS9tc?=
 =?us-ascii?Q?TRNxA8V+EhXjHJI/he/M93vOIGoPgtcCG/MfsgqCc3p6aCMmGdP/kgdxGEIi?=
 =?us-ascii?Q?yZJ0REvErCVYZaa/o3H4pQzaMZtN2Qnmqz50aWi3I5MTeZ2jMjg2ZS64T5Gt?=
 =?us-ascii?Q?Oma75VbtZAKjUHtSSBwhDBgW7lVK7EeA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:56.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ade8758e-d675-4bdf-3bd6-08dccf15db9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Add a function for given a opaque cxl region struct returns the params
to be used for mapping such memory range.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 16 ++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 include/linux/cxl/cxl.h   |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 45b4891035a6..e0e2342bb1ed 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2662,6 +2662,22 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end)
+{
+	if (!region)
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	*start = region->params.res->start;
+	*end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_params, CXL);
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 120e961f2e31..b26833ff52c0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -904,6 +904,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
 int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 169683d75030..ef3bd8329bd8 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -76,4 +76,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
 				     struct cxl_endpoint_decoder *cxled);
 
 int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
+int cxl_get_region_params(struct cxl_region *region, resource_size_t *start,
+			  resource_size_t *end);
 #endif
-- 
2.17.1


