Return-Path: <netdev+bounces-182300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C5FA88716
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7053E564B0B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2627A11A;
	Mon, 14 Apr 2025 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="thfIuHZw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4527A104;
	Mon, 14 Apr 2025 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643661; cv=fail; b=HGhlFc20p8aNsBBHmaFkacevKMUo/H+RcnMFLQ0WY47Vt07oVpxxd/VqT9DjM/WDbkC6+udHCseDMVhkIxrEINZmuFxkasCNbb6l0tWAqSPJhpVqn13fNodvvWRXmVoXYHlSxNk4qfGonLzZyJ+ZUUajFgj0w1HyRpNhiZnyOLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643661; c=relaxed/simple;
	bh=B7so6KRmJZoxGXJ1uQy4wZwEhr3fEqeLcSoeTrUydac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG+ivZ9nR1E2m3G7ANzAYfpcVHG69dA6JmQMIjsWm2S23LxUYYEaLjhTHhUvmdQ9/p22N6m4S0wOsRihyAxLo2GpXTgzdS9QTHMqsFCQbw3TG1FiIj2VrV6Bnc8Gu4uI9fdAYtCQ0AIwugh8Gx67gW2urHe65uxmpOf3qCDYAbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=thfIuHZw; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1TnhOWOh3PLedokWPG3vxLfpb7mWn3+Pz2HMN8Uyt95ygaCn3Ztqqa08/DwC6i8/BE74KJscsHF5Z/+AJAE8MCXJAmrBDv4FQ7PZLRgkg06rzjOzsOtOjaPDz/vp+ogbfuYug2JrjHh6uIynvfOeiu4y9TIWUS5svNYtrlBmxQR2XuDn6AhC5Tm9z6JKfErdA3baJNiR8BH0KsdzumrO/KslhncbrGkxWrSaisTe5ZxCa16GWwTz5bSkrICxszMquga+US5qwvqE7JrfyIutGvZ4QS1KEqKzwxcdrohsdrrFsPq8sFZWR0v3oLFgvj/Rrt+5Shz3y4xGk4GrL4Ocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju5sTkf54n236I+qqO49UPXsZOCeUz5w84teaZRYqCI=;
 b=st+8L4SEXzbtZ7Z85n9rZ/DLfXeXpOpUwzZGarbrcs8tC3cwdRCKeRyBm7G+2ZD4ZmX5dLBvZKOSAzDCHkuerR8zNie8G9B/PW6QlITOgf7YFHuuoDm3Xx5qcA9WcOBxSYHgiNRNm+ngLVQkJRG/1CjOc3j4b5vJhswKG2pWk7GeSCNZnazgRTiHG8yUdJy725IRonwP0AfCxee4T6QfJLaxpYIbxdC0w7hyrzyUIohPbSxvuvz3BKNH9u2Q/m4zr4dDxmYs+YHhgvG0i6W5POPgp0ACczZPPPQXt3OUZzPEuRftxMbuQx8dxeIBCt4zb34zLMQQwyguX5WQuo/xRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju5sTkf54n236I+qqO49UPXsZOCeUz5w84teaZRYqCI=;
 b=thfIuHZw3HStnlbD7XUnqNkry5BFZoqSE1rdrZpGLAPaXM55yafFWRKeB4Ggq1xCHCQ/3m2WeXL8ww27ErZnpGtNZUhKrQguCOUcOAEK5iAMhRNSmBqJcbiX+Y69UF7M2EIuPWgfa38WvZBI/snDDeOTbHNAQjgroq0hPu+9n4M=
Received: from BN0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:e8::30)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 15:14:14 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::7d) by BN0PR04CA0055.outlook.office365.com
 (2603:10b6:408:e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Mon,
 14 Apr 2025 15:14:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:14:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:14:13 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:14:12 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v13 18/22] cxl: allow region creation by type2 drivers
Date: Mon, 14 Apr 2025 16:13:32 +0100
Message-ID: <20250414151336.3852990-19-alejandro.lucero-palau@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 0294c76f-aa98-4c43-19be-08dd7b670489
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q2tp61WO48FmwQvF63DG25oSFVkb6ft35syHNuqTsQU573kstrNhDkEYO3Dt?=
 =?us-ascii?Q?YLeo9X5M0G5lG0202Z7EF5dvv0PZfELL/zesS6sN7igqeLKfiPh7DvyjiHL7?=
 =?us-ascii?Q?1yJMxJgsitTdz0qzFPmSnMWVTTcu9rZPcCx9TXtzN5bA66TmLLx4Wv9hL6h3?=
 =?us-ascii?Q?yDrlcue6V0k9jsCyDDMqi+NTzwCbgdMjQj3zG7ZPin+T6HzeO7lS2iopGPJr?=
 =?us-ascii?Q?R5YLeZm5LTkQWCl0iyTUZrmwO2xYOTEpkWw+7qcPyz4yM2hJNdqOPiUR1XBP?=
 =?us-ascii?Q?2Ni+cobZn4zlPvSO8vpBVJwolfHkKi+SQQRqrVKYUfMrzF5xR4K0ZV123jA7?=
 =?us-ascii?Q?e9+PkWAfOC0JaKMkh6IY1kkEL1WNsEF4/RwaqxrT0YhD+0uUdSwTLF5frg4G?=
 =?us-ascii?Q?dldakiwkHJ8dGZ4txhgXkyDeG1h5UoeTaL3wFe1PBqGJ69c51QF8BLSuGmQw?=
 =?us-ascii?Q?yhq6vdlmS3rlZvcJ+u4dlVwrOk1vGwYQ+e7zhMrhNAWkfSnXLBBK2vJErF5B?=
 =?us-ascii?Q?vbdrB8gKYpBlUq9XYqxXlexiqPfw2uD4JG+yYQvlRe4BKS/ZtJCAsccKmT9N?=
 =?us-ascii?Q?XX8bW7TeZA36vrVLYXHu48ZQqnxRXeM9zgprM4NepMJk6z7SI7PJrlVSaVrQ?=
 =?us-ascii?Q?kCcVoO+TUQgPdawmI41EbhVX0UVsmmniqYP1EBo5ebnCSVVGdR962YUIUIHy?=
 =?us-ascii?Q?1mXdpJpEMrXkiltkdsL7bfJAJY3xJoutF+ZUTCeT95vWIDXRLDwPa+gkvAfZ?=
 =?us-ascii?Q?/Ga0/tly4utaeU4o4GSSIQT2fpjlcwbybEPeNreOplt/fVQyTGatmUNg+r/s?=
 =?us-ascii?Q?A6CRTd6rtaQzaZ+nEDnVnvjyNFmuqHy0Ouaq8BL9coR3bIPxbBwcEzbCX2Vi?=
 =?us-ascii?Q?coNOqooDRFqzI1ijcWqWSBy68QOXt5tlMf8NgFOw9z9J2cgfrRivJvcTCkGm?=
 =?us-ascii?Q?+spvDOC5+cp5o0RlCrL9+IsI777l6MxkuDmYWwcdxxs0CEugBmYGPE1Z09pg?=
 =?us-ascii?Q?enw1xxaHW2OeWLUp6FfaAcmbuJalL/gXMH/HfiGsOM3x41YD3SF3c/tU2vf9?=
 =?us-ascii?Q?mO4cCeE0oeSjUQbBuExpmH4pwDLgw9DFbIbgc9tlVEJM+IFw6ngI8PS3KfsH?=
 =?us-ascii?Q?uVi4qRJ+dCOls8BFnC3+Bv4J7/nOorpsFzexeHZsxUwVMlt5akVn8FeY5mRe?=
 =?us-ascii?Q?vfgCMsL0jBdLPlRjTe9y8q3RzxYNRc4benAoRg7QwbyEWYqTgdcbzFeV3Vhs?=
 =?us-ascii?Q?sL9Mrkq/J5OGyctUO2+ulwXfjwC+u7HfExoRV2D1jV+5+/IKlyQGXnGPkKGF?=
 =?us-ascii?Q?tgirpwk+5G+2TJLFPury43dESe95BesAgfUTeqHaN2QO78M4Lg/4zD54lyS/?=
 =?us-ascii?Q?xl40JvyplGNMKpvCoBwAmQeNoHUfkvRMVyCzrp4p8iQmgRbNFkkwc9IhhWzx?=
 =?us-ascii?Q?Ins2+TnVuGrPU8E2SzxsP0ywtbTZnqB2haPfSj1jcFgvsV9m3Wnpa61W5oAh?=
 =?us-ascii?Q?26lvetGwsK4b7SqQSYzz6ZpVBr0cDq+NmazR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:14:14.4107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0294c76f-aa98-4c43-19be-08dd7b670489
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465

From: Alejandro Lucero <alucerop@amd.com>

Creating a CXL region requires userspace intervention through the cxl
sysfs files. Type2 support should allow accelerator drivers to create
such cxl region from kernel code.

Adding that functionality and integrating it with current support for
memory expanders.

Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/region.c | 133 +++++++++++++++++++++++++++++++++++---
 drivers/cxl/port.c        |   5 +-
 include/cxl/cxl.h         |   4 ++
 3 files changed, 133 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index af99d925fdd0..f55fb253ecde 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2314,6 +2314,14 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	return rc;
 }
 
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
+{
+	guard(rwsem_write)(&cxl_region_rwsem);
+	cxled->part = -1;
+	return cxl_region_detach(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");
+
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 	down_write(&cxl_region_rwsem);
@@ -2820,6 +2828,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
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
@@ -3524,14 +3540,12 @@ static int __construct_region(struct cxl_region *cxlr,
 	return 0;
 }
 
-/* Establish an empty region covering the given HPA range */
-static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
-					   struct cxl_endpoint_decoder *cxled)
+static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
+						 struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_port *port = cxlrd_to_port(cxlrd);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	int rc, part = READ_ONCE(cxled->part);
+	int part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
 	do {
@@ -3540,13 +3554,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 				       cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
-	if (IS_ERR(cxlr)) {
+	if (IS_ERR(cxlr))
 		dev_err(cxlmd->dev.parent,
 			"%s:%s: %s failed assign region: %ld\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
 			__func__, PTR_ERR(cxlr));
-		return cxlr;
-	}
+	return cxlr;
+}
+
+/* Establish an empty region covering the given HPA range */
+static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
+					   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = cxlrd_to_port(cxlrd);
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
 
 	rc = __construct_region(cxlr, cxlrd, cxled);
 	if (rc) {
@@ -3557,6 +3581,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	return cxlr;
 }
 
+static struct cxl_region *
+__construct_new_region(struct cxl_root_decoder *cxlrd,
+		       struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
+	struct cxl_region_params *p;
+	struct cxl_region *cxlr;
+	int rc;
+
+	cxlr = construct_region_begin(cxlrd, cxled);
+	if (IS_ERR(cxlr))
+		return cxlr;
+
+	guard(rwsem_write)(&cxl_region_rwsem);
+
+	/*
+	 * Sanity check. This should not happen with an accel driver handling
+	 * the region creation.
+	 */
+	p = &cxlr->params;
+	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_err(cxlmd->dev.parent,
+			"%s:%s: %s  unexpected region state\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			__func__);
+		rc = -EBUSY;
+		goto err;
+	}
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
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		rc = cxl_region_attach(cxlr, cxled, 0);
+		if (rc)
+			goto err;
+	}
+
+	if (rc)
+		goto err;
+
+	rc = cxl_region_decode_commit(cxlr);
+	if (rc)
+		goto err;
+
+	p->state = CXL_CONFIG_COMMIT;
+
+	return cxlr;
+err:
+	drop_region(cxlr);
+	return ERR_PTR(rc);
+}
+
+/**
+ * cxl_create_region - Establish a region given an endpoint decoder
+ * @cxlrd: root decoder to allocate HPA
+ * @cxled: endpoint decoder with reserved DPA capacity
+ * @ways: interleave ways required
+ *
+ * Returns a fully formed region in the commit state and attached to the
+ * cxl_region driver.
+ */
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways)
+{
+	struct cxl_region *cxlr;
+
+	scoped_guard(mutex, &cxlrd->range_lock) {
+		cxlr = __construct_new_region(cxlrd, cxled, ways);
+		if (IS_ERR(cxlr))
+			return cxlr;
+	}
+
+	if (device_attach(&cxlr->dev) <= 0) {
+		dev_err(&cxlr->dev, "failed to create region\n");
+		drop_region(cxlr);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return cxlr;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
+
 int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index a35fc5552845..69b8d8344029 100644
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
index 5d07a75aaab5..21cb39dcee9e 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -266,4 +266,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
 					     enum cxl_partition_mode mode,
 					     resource_size_t alloc);
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
+struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
+				     struct cxl_endpoint_decoder *cxled, int ways);
+
+int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


