Return-Path: <netdev+bounces-126225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5996A9700D9
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBB9B23C11
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49115A878;
	Sat,  7 Sep 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4xJNb4do"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0423014D2A3;
	Sat,  7 Sep 2024 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697198; cv=fail; b=eJ/G4Kxo+8dt0+1th77vtecFS6q65VAQSf9k6GLOx1L299uO1o7r1oR1Q52OidoIxfPaVew4Gn7Ub9WdHq0oTwsFnnZ8fUZ/SkveMI0oP2hSVaHjuBgpf9Lwf6jmqNQ6tEa1IR22NbO5SotPuyzbT4HaEH8JP94P8twk+WGnJmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697198; c=relaxed/simple;
	bh=dFWMe7f96kDlwKg0LLGVutB1UnT/HbGHRzgVDxQ/v8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HDpUZs2OJfKTe9hgKtBN/0UCdxlvYenhhGPGfLX/61OJiXBVt0Q35eAZjopMiQjTollSYjajspKAK1ZH1pjR17vJkZhfIa6XAzhv2VoZXlt+yrbBsa+J+piQIDk47GRuMVhMHaSJVVYOx6nRJGwJ0hiQEFn+1c2UWiM7NLlHUg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4xJNb4do; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/sEbPiCJxmF4+KYdTSdMETBcrZ1Ks9i67WFwhD2cGWyENYfg1F6P5YB81TprbSdtUnmgGMhhWLyRv9pikphVgGWh2rS+1hiBXPB2a/bao86EFY/KSV1ExGkT4TT/1DhP1iE13/Y79TfRFaAhgM6mtraclWR9xhcy/MIOZJZ/H9X8R91NLeM1WenTEQQUEV6lq6jeKy01r8r05V1hzlGpGEppTMNAOYsgLYtp1zHPvcbSjaQWVFusKxCxfzlDdb4dvMuJuEq0mIO0DXMU3FzO2Q//rgHF2ilGU7jVLmosq0FTBC9pDzGhwcOFKR5EfMtWPn45J+UXZxzFsXmZdZc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQk0ZgAXSdGK3C1LxxcmS0/dy45KiHhb7h8ulZ32pi0=;
 b=ZmAVCwq6zkDqi0VHLEvcB1UmUN99XCE9QO9tD2yQp6SDVRe9oZWOelsmUydltiPH9AExVBIorTjPMLjg/rozMIH5rsCO8ael+wMCbM3X3ZRZQemD7cDkiLQij1AjeRAv4IgneNzRhWlVtms4q6mExGwNitzmVGwSvY0LvgRrGDr9du14KUbwhUweZRamgsk3PcVlk2R2lFmRMGDfOJ7DbHHv7oO1VfpeHqb8IlNw9WmTrAEB6tsVsn9f97RSq+M0bCR4hXXJFFvVzxahNyVod+a067+QjN/tXKpoV1AJC0BZUQHriSo5EzVp5TfsLQACPBD3+ggao3+IMn0zJpukDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQk0ZgAXSdGK3C1LxxcmS0/dy45KiHhb7h8ulZ32pi0=;
 b=4xJNb4doJ+QqLulyrPdH3t8w/nPcvSOUzDHZUkMeWmhka4RPdc6qY6XRAo9IvGOAE39t87ZqxjGaTXrkfPlFJRawPmKydbVDZ3gkUjIM70nHI6lYUhxBLG7dyLamfd2Jegozf2ui/SQQ0kIsU29+GqnvPclDxuiBtXM7pgSXbog=
Received: from DS7PR03CA0127.namprd03.prod.outlook.com (2603:10b6:5:3b4::12)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.20; Sat, 7 Sep
 2024 08:19:52 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::9e) by DS7PR03CA0127.outlook.office365.com
 (2603:10b6:5:3b4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:51 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:50 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 17/20] cxl: allow region creation by type2 drivers
Date: Sat, 7 Sep 2024 09:18:33 +0100
Message-ID: <20240907081836.5801-18-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: ec543275-0ff5-4de4-7060-08dccf15d8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YO6ktH4zlrNuMYghiQS1Ub7PSfHM1l0V9kdFvyklFmz7NIPQfdv3izYrttf7?=
 =?us-ascii?Q?LqGKCcBYjA3yDYMC314S2X7UhuWYUsUfn3IaairM2kmc6GPq9XLHa+0NfzYE?=
 =?us-ascii?Q?ueQdEH1wM5LmrKFnc+9sTYQOJ9zey+ElAY/xNA5mlzamjGORhi/OxwhOn5zK?=
 =?us-ascii?Q?KZ4o3F9vOS6eHk90KpPoVQBrNuoedB5kybdn+O36YYdlZgiHYP+KWMq0Yq/j?=
 =?us-ascii?Q?sz7iVsKSoQB0UOqVkwVPdswLRrhpOsQxh5h7sfED94iy8MoOYILiUIysn34o?=
 =?us-ascii?Q?YU7TkBRIwDH3igfXpPrCCYEB0mBVlaLodZxCDZ8+GngCc1umZUarkPCLzEBf?=
 =?us-ascii?Q?AWf8eSBXlClMnu4z1XjpfCeK++sCq16Fk46vo40n8lq1cMSuYqwDqPp+Nr83?=
 =?us-ascii?Q?TuVhFOR9nlWga8AtMRBaRZ03p1OOQ70B3fmz8QrgqvMYkvy5t+NJ4YqTRY/L?=
 =?us-ascii?Q?5M83cGw7MDNCTRpmw8aGOh8sW2AVvFbWXN3vg4lfiTFtHSVmmVovwXUQI5Zb?=
 =?us-ascii?Q?KVvCpW2hls+VAM/5nFnM0yO9r6LX3lsAgX8Ozl/xuxcHLI91jgZ3BXOA5T+y?=
 =?us-ascii?Q?IYCDPE5J1RB42kbsaSr2NeoMWQQ0O0Dzz+gwg6NY6TLWSOHwqhBjggqixpO4?=
 =?us-ascii?Q?8YKxvFcyWKHZRmuYWpwkoCq9IXGkl4ZESz7DwF2Co/LXK6KeLCjWckUfpQ9W?=
 =?us-ascii?Q?bAPkgqbOhUN9lpa8aPHdKEYOWpf75Rc+nL6s4zpFK80OubBsf2nIEZqlfWC0?=
 =?us-ascii?Q?kJDrXIGtz2B5d/+Dac2WLkawBkv2lIZpm23m4L8dY4E+AnmJ3BoGpn6oJGg3?=
 =?us-ascii?Q?zld7QnmJkibochuA/BTrN72mJ+UbbJsVtjgS6zjP41rGPOmz0Z7dwq0qQHKh?=
 =?us-ascii?Q?0SACjS2qMkbpNqGz/Fda+656kTH20mxftmQXaITM9YrmPzhqm5rnA93rY1Lm?=
 =?us-ascii?Q?nAstiqS2WzfY5jNJkhBM2XWcZVe1ZdNlBJe9ZC5nW9G2nRHhnAe+0OK96/V+?=
 =?us-ascii?Q?xIA9PwjfXFsUMIxaFVcQas9ugcJmfO7PP6sLJBWxp3Y0oV4JS3b3n3SRr45H?=
 =?us-ascii?Q?E9NZp6qvE9E8Gq17EmENGQTZVN2PfCjyPG45cSbebAPPzOQeIVkXU/OgITcp?=
 =?us-ascii?Q?0nBzPhzxOPF+UJvxZQt/Dcm1wBeEWWiVzzUmdJm+AYPZqTQ0/QhnHQgR76E5?=
 =?us-ascii?Q?Zs8qdKUwKPe9D97vxk3ILOL+tptutAeVJYDMvnn0AqyAcxxEvZtGrTaqhaMB?=
 =?us-ascii?Q?tsd/EBpck1quendFCiUf5lx7SyiCjvJlmYcvwm34czmRRhZeZgBf34msI8MJ?=
 =?us-ascii?Q?GeFi3+/7E6nWD8JikMi7K5/QkK3SqhrnlOqXogbJlM91J8Zs8Ks4FQ27/1O7?=
 =?us-ascii?Q?kNt+FDcEqUkSCR/7p6pElaV65tix1VZM3kRxcfX+9RRd3c8IEANTZVHG31yb?=
 =?us-ascii?Q?TU6kfHDlEtzkfqHX+OmTY04zpVapXSZR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:51.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec543275-0ff5-4de4-7060-08dccf15d8e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c          | 158 +++++++++++++++++++++++++----
 drivers/cxl/cxl.h                  |   1 +
 drivers/cxl/cxlmem.h               |   2 +
 drivers/net/ethernet/sfc/efx_cxl.c |  10 ++
 include/linux/cxl/cxl.h            |   4 +
 5 files changed, 153 insertions(+), 22 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index c6fa9e7e4909..d8c29e28e60c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2192,7 +2192,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
 	struct cxl_region *cxlr = cxled->cxld.region;
@@ -2251,6 +2251,7 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	put_device(&cxlr->dev);
 	return rc;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_region_detach, CXL);
 
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
@@ -2780,6 +2781,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3385,17 +3394,18 @@ static int match_region_by_range(struct device *dev, void *data)
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
-	struct range *hpa = &cxled->cxld.hpa_range;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
-	struct resource *res;
-	int rc;
+	int err = 0;
 
 	do {
 		cxlr = __create_region(cxlrd, cxled->mode,
@@ -3404,8 +3414,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
-		dev_err(cxlmd->dev.parent,
-			"%s:%s: %s failed assign region: %ld\n",
+		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
 		return cxlr;
@@ -3415,19 +3424,41 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
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
 	}
 
+	if (err) {
+		construct_region_end();
+		drop_region(cxlr);
+		return ERR_PTR(err);
+	}
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
 	if (!res) {
 		rc = -ENOMEM;
-		goto err;
+		goto out;
 	}
 
 	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
@@ -3444,6 +3475,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 			 __func__, dev_name(&cxlr->dev));
 	}
 
+	p = &cxlr->params;
 	p->res = res;
 	p->interleave_ways = cxled->cxld.interleave_ways;
 	p->interleave_granularity = cxled->cxld.interleave_granularity;
@@ -3451,24 +3483,106 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 
 	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
 	if (rc)
-		goto err;
+		goto out;
 
 	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
-		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
-		dev_name(&cxlr->dev), p->res, p->interleave_ways,
-		p->interleave_granularity);
+				   dev_name(&cxlmd->dev),
+				   dev_name(&cxled->cxld.dev), __func__,
+				   dev_name(&cxlr->dev), p->res,
+				   p->interleave_ways,
+				   p->interleave_granularity);
 
 	/* ...to match put_device() in cxl_add_to_region() */
 	get_device(&cxlr->dev);
 	up_write(&cxl_region_rwsem);
 
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
 	return cxlr;
+}
 
-err:
-	up_write(&cxl_region_rwsem);
-	devm_release_action(port->uport_dev, unregister_region, cxlr);
-	return ERR_PTR(rc);
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	resource_size_t size = 0;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	rc = set_interleave_ways(cxlr, 1);
+	if (rc)
+		goto out;
+
+	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
+	if (rc)
+		goto out;
+
+	size = resource_size(cxled->dpa_res);
+
+	rc = alloc_hpa(cxlr, size);
+	if (rc)
+		goto out;
+
+	down_read(&cxl_dpa_rwsem);
+	rc = cxl_region_attach(cxlr, cxled, 0);
+	up_read(&cxl_dpa_rwsem);
+
+	if (rc)
+		goto out;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto out;
+
+	p = &cxlr->params;
+	p->state = CXL_CONFIG_COMMIT;
+out:
+	construct_region_end();
+	if (rc) {
+		drop_region(cxlr);
+		return ERR_PTR(rc);
+	}
+	return cxlr;
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
+				     struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region *cxlr;
+
+	mutex_lock(&cxlrd->range_lock);
+	cxlr = __construct_new_region(cxlrd, cxled);
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
 }
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
 
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5d83e4a960ef..120e961f2e31 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -903,6 +903,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 07259840da8f..b0a66b064c73 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -878,4 +878,6 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
 					       unsigned long flags,
 					       resource_size_t *max);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 57667d753550..dd2dbfb8ba15 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -125,10 +125,19 @@ int efx_cxl_init(struct efx_nic *efx)
 		goto err_release;
 	}
 
+	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled);
+	if (!cxl->efx_region) {
+		pci_err(pci_dev, "CXL accel create region failed");
+		rc = PTR_ERR(cxl->efx_region);
+		goto err_region;
+	}
+
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 
 	return 0;
 
+err_region:
+	cxl_dpa_free(efx->cxl->cxled);
 err_release:
 	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
 err:
@@ -142,6 +151,7 @@ int efx_cxl_init(struct efx_nic *efx)
 void efx_cxl_exit(struct efx_nic *efx)
 {
 	if (efx->cxl) {
+		cxl_region_detach(efx->cxl->cxled);
 		cxl_dpa_free(efx->cxl->cxled);
 		cxl_release_resource(efx->cxl->cxlds, CXL_ACCEL_RES_RAM);
 		kfree(efx->cxl->cxlds);
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index 3250342843e4..169683d75030 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
 					     resource_size_t min,
 					     resource_size_t max);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled);
+
+int cxl_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif
-- 
2.17.1


