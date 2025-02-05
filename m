Return-Path: <netdev+bounces-163058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 879B1A29487
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B38169E9C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9FE188736;
	Wed,  5 Feb 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BVTggVe2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4D1DC998;
	Wed,  5 Feb 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768837; cv=fail; b=EoyPGb4mW2PjkzI6U+ZRU5zpkrBoYiNzAVnRLQyDjN4BI2QHkD90ZT65/Ixb3DBEuxm3HgjOJcTofq8jpcLWwbPzCGfNlHltk5mSn383KMk8VRxET83zxXsQuXoGRaAQk9vnn9H/Gg/W8RMKhBl5b3cC83X5lTU+7V47lmUV+e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768837; c=relaxed/simple;
	bh=zwAqTkgKORRqeJ1gpLYukH4bOWIzooNWfLsA67JPPbo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7Si5+rxu/IK/8BRjZ4fO3PmpfDURMm/0KXbkeQR1CYHI1FAgQuWV4yhiyjHDu5OIXXsQWR6zob5mkd3ZZDcIYMcwSuY4VYMzAbcZ+hZGCpdbCvPLp+kbWoh+5E5jd3RkvEr3/vSpIEF4sWkcb5nAPlPA7qExj5dIm4/ZJYZQD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BVTggVe2; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c05GVOnDuTV5it7p10sZqOCVTpGvIzi0JKlpiLG50hHhaWHmNQf2kuus5BqAJ5PimLvlEy9uf/WHS0EttMgcOjXPq56afGcHzWDnVXdOGiLgAMq29t2IWTGLB29l+CJb+X/51mxLnDGVYQhuVberLS5IwPXfQhxDHyN1HVLomPuyjkw7rT91KgdVTKIKPvd74f/IWRzKjMyTbrWdYcKDWFj342tsnYydjFo7rbT3L+mjxjNXACn7ooo0yuKBal+rySxD+ft6OXqXI57sUYkTJrEwJZhaV2qXeTW923vH4AahhUmdQvvIRvvoqh+BkyBOXD0bJWVDgLnHT4hzzm0B0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7z+OxPNAJxOf4Xi+6UDEmTjGAmltmwjm4JzVijho5Fw=;
 b=ouMas56KosXXnoHMIwnIsBpPCYsOY9lW3EWHqvu+fjpUCLycohZiUjz0+JZmJ7txOjahRFoeh80OTJwRiLLSWNxt0Gr8Fqhlv7cryKp2b9XfG7JhmKjQ2Kon+IR8LuVrMLeWhipeNYau+u9W1+4KXIMPLq7KJIMUzbbP6RaH1fR9hRkMhDSl+VY32OqOQSrjmXC6be5cG6Um0EQvkP+rCYbQ7+SRRbfmsp7D3adO35yBS71yCplg8JJiJKOO5WIFMKO7airhwfrkpWGYLwyfsu6ScLgXjkyJf2rymlY+bsQ32JN/SSkcQ+DiZDnBYW6KZe9lIQ6QtPJTZ9y7ZL5vkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7z+OxPNAJxOf4Xi+6UDEmTjGAmltmwjm4JzVijho5Fw=;
 b=BVTggVe2LGE6fP1sczS9SOtKV2lydlgGxf88Ry2te4qceIYp29Gp2TW6mPcDW02WBHnpADxaBjWWWoBE/TrwXM9wdgxrg6JvC6WLEoFysAHNdPTm04GdqZ5CzUf2LL0XqKzZXYTaIToLJtNOiCJH7Npg9qONs2LxKiR4Tgd8esU=
Received: from SJ0PR13CA0054.namprd13.prod.outlook.com (2603:10b6:a03:2c2::29)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 15:20:32 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::4e) by SJ0PR13CA0054.outlook.office365.com
 (2603:10b6:a03:2c2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.6 via Frontend Transport; Wed, 5
 Feb 2025 15:20:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:20:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:20:27 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:20:26 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 21/26] cxl: allow region creation by type2 drivers
Date: Wed, 5 Feb 2025 15:19:45 +0000
Message-ID: <20250205151950.25268-22-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250205151950.25268-1-alucerop@amd.com>
References: <20250205151950.25268-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c20cfe-b3dd-4cae-28af-08dd45f8a184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8XoF611xX3aW4mqElyvD6efhtBYU+HPC3OldbFKY+SJ+03QpHGcDlu0S8pWe?=
 =?us-ascii?Q?hpAL+UNImVRaeVBWV7I/HQ5KfhUgZtfxTausyKVBUw1pyQIqbmvyPv+dju6e?=
 =?us-ascii?Q?fWW7Ef13+nXeJvYEpzswvTtnlrE6Yc84WnpX+1vYwi5rtuy2Lv7d+1rRtGAW?=
 =?us-ascii?Q?5cnmEK5xOvgfaABh6SoZZ6XnokCVlLeHMKuZvI6AegHTrirvSGH+FzHXq9lM?=
 =?us-ascii?Q?KqAfryH6yaR4LiNCz0+hMFuMVWuaSfk27IzjyNBz5LOCB3/d4EBzHAFSm1xI?=
 =?us-ascii?Q?gCN+kxb61QHDarPG8KwHGzmwjeTmS1JLAjdSpKvFKRUQdQIbhWx7noqV79ct?=
 =?us-ascii?Q?gU1YClbuqpefiG3Sy5SUot0qcoW+T6q1auFurpI+Et+wdfA/JGkA5YIlUyLy?=
 =?us-ascii?Q?UzrgqTVKoxJ8LGLWtQmc+srKYdFKnn/RrakeL3aFwES3VLVE5QD/GePBEUHz?=
 =?us-ascii?Q?ZApZ7SCCAAlD3gUU4ZbELoMG4fbaRZaQy0RRpofbo2FaA1p86wSRz8Vu4LCH?=
 =?us-ascii?Q?rvoamqfR4Fv9zI4IrSVTIesos+wxwHZNu1sR4AkE881JUTAIPJAXM8SrD35h?=
 =?us-ascii?Q?a2xH/+cieSUFSyzjgUYLdfO6uA2p+kn1ZQT/fZ2UlrxCXSO/r/xRREDmn4TT?=
 =?us-ascii?Q?ZLN9SBArYTNJD4D8AfAAkEYPhEmnIk4shlr7fNSenbU8AXWvs+OMKouIoA1d?=
 =?us-ascii?Q?t7GoxhGX8bLrma7hglJhZtCQfYIBbGiN6i1Ybr5ZesFJOa5q/VMkwqV/kNgs?=
 =?us-ascii?Q?Pg5XSvmoEDxvB+plVwGA0jjijyeJcgtZwv9jX92KgViwsLut5NQPYX8F+pr9?=
 =?us-ascii?Q?U/JTjF34RFz1PGs2yF/gRjQ58fVCU/+fEmBDfTFMpCJIWVk+Y2dbDMAExDEw?=
 =?us-ascii?Q?8xxYaxllxGKz1S1hlfZyXpFdx30NTqtigutlXmhD0THtT6iEDvbGcKHy3KNN?=
 =?us-ascii?Q?hL4kLlZq0h+0mP/q2QgQUb3XQ4aoWF9UQsJj7bSqT1/zRXrnAJGEWYE+jb57?=
 =?us-ascii?Q?9H5SLxUJZQeDmL1aUiJkhe7mfa5vA6fR7HQWwrUJSfpAUGEFK9k8xE7ohamP?=
 =?us-ascii?Q?EfvCBynaHJpat5vAHVGl4EH9ELc+8Y7M1q7ElK0g1/mNbpEqUtRyhIYs6UJ9?=
 =?us-ascii?Q?kyg/zc6vsAfnOfrwzdL6w2SnX+jO/58NZ4SuUpVwmE+br3tXDOtzg6VugoFa?=
 =?us-ascii?Q?QGnjpPGoPXHuPbPLmb4ODb1CAghTXqenijfENkUV2JxMBR8Fn4XtNqZhunuO?=
 =?us-ascii?Q?tuTz8qtli6E4FiyTdjkSGgVWSUCk0nj1tHggdu7h4fl3OP87VSkyBNdzsbU8?=
 =?us-ascii?Q?dyNLWs6g+yymV7bYon2Jbg74AoA6GXbyi4ocGQXq5qTwAHB3DoVfGmO8h9yI?=
 =?us-ascii?Q?+VqxDkxOKm3Y03UqqTXhblX7Q88U5YAqi0yfQPB/ndZ4HgUJwVq9Ih9HxN/G?=
 =?us-ascii?Q?bw4DS3A3NEBNTAB98leJoR9YQBH2IVGNbFkS9oTcKQMIoDqjFQPjVYBdntnf?=
 =?us-ascii?Q?UD+us2UvU03oEqE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:20:31.9696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c20cfe-b3dd-4cae-28af-08dd45f8a184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxlmem.h      |   2 +
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 4 files changed, 141 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 60db823a5ebc..55a4b230b5e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2296,6 +2296,17 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	rc = cxl_region_detach(cxled);
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2802,6 +2813,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
 	return to_cxl_region(region_dev);
 }
 
+static void drop_region(struct cxl_region *cxlr)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+
+	devm_release_action(port->uport_dev, unregister_region, cxlr);
+}
+
 static ssize_t delete_region_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t len)
@@ -3399,18 +3418,20 @@ static int match_region_by_range(struct device *dev, const void *data)
 	return rc;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static void construct_region_end(void)
+{
+	up_write(&cxl_region_rwsem);
+}
+
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct range *hpa = &cxled->cxld.hpa_range;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
+	int err;
 
 	if (part < 0)
 		return ERR_PTR(-EBUSY);
@@ -3433,13 +3454,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	p = &cxlr->params;
 	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
 		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s autodiscovery interrupted\n",
+			"%s:%s: %s region setup interrupted\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__);
-		rc = -EBUSY;
-		goto err;
+		err = -EBUSY;
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
 	}
 
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct range *hpa = &cxled->cxld.hpa_range;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	struct resource *res;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
 	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
 
 	res = kmalloc(sizeof(*res), GFP_KERNEL);
@@ -3462,6 +3503,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3478,16 +3520,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
-	up_write(&cxl_region_rwsem);
-
+	construct_region_end();
 	return cxlr;
 
 err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
+	construct_region_end();
+	drop_region(cxlr);
 	return ERR_PTR(rc);
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, ways);
+	if (rc)
+		goto err;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto err;
+
+	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
+	if (rc)
+		goto err;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+
+	construct_region_end();
+	return cxlr;
+err:
+	construct_region_end();
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled, ways);
+	mutex_unlock(&cxlrd->range_lock);
+
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 760f7e16a6a4..2b260cf93d7e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -882,4 +882,6 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d2bfd1ff5492..f352f2b1c481 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -33,6 +33,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
 	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
 	int rc;
 
 	if (!is_endpoint_decoder(dev))
@@ -42,7 +43,9 @@ static int discover_region(struct device *dev, void *root)
 	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
-	if (cxled->state != CXL_DECODER_STATE_AUTO)
+	cxlmd = cxled_to_memdev(cxled);
+	if (cxled->state != CXL_DECODER_STATE_AUTO ||
+	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
 		return 0;
 
 	/*
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 3fa390b10089..4f93af062815 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -94,4 +94,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     bool is_ram,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


