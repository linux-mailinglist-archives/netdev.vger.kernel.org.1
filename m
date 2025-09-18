Return-Path: <netdev+bounces-224334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFC8B83C04
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4F17BB77D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D8C30504D;
	Thu, 18 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKXPyjlI"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7630277A;
	Thu, 18 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187117; cv=fail; b=hEKQI/2vRQ6A8+42H0bEBsto1ZVvmK+CkiCK1NzpqeCbHIc5/LrGOynl/y+9tKFm7LaO9kJi1q7vL/aAYA3RbSLFlgSLD6EICHYUQEI4pZfkJDVRdbBVYFK7360mQbARfi7mbJSm/8bJtwqCbQdN8VRBDHGEi2Hzq23kT1RWiDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187117; c=relaxed/simple;
	bh=kLiEt3GmWwvCrl04NJ+C8sClYesaSip+vWgVDm9tdcw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jJDbncrNjyFZS7lbkKBQxnPUu0LfNA4eOiWpFeIsZxD3onfajhgjc5Ccwp7soLI4fcEutGSvWi88p95DrqsTWXNFejFIJLpAEeqH0UkiM2jg6URl1m4/7u6YEnUIsxhpqig0EMdRcX9TRZNDulNI/nWEFMYhy3h9MpUTYYWsx0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKXPyjlI; arc=fail smtp.client-ip=52.101.57.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paHkhN4mRU3JsMrEaks64yyj8vBV51boC6Z0zKaWNp/ZV0g5QpOAzn3J4am01/bvIwXLCBi+07wOmP82w2rVb406UWytADz7CiBV4fLvqvprw8aa3+OmaJ8i0A/qBcfN0rtHarCE9aKiVFkgBbokTwIuuty7g9Nspa13QsyID8n+uNIid71+S4ME3SnlZ7uzbJEYgdEggnGATbEgq7cr4eFoXZvvU4uAqwyiA/VZvEbmDSxsViSm8iicTzKpNqoprPki+1ZM+IpMBTjjoJr/lgq5qr7OVd8cOnH3LVlm6t5nMQCGQpwih/QDIIFQ5D1ps+wv4CNbY25TVi92tKHNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BTZqkQnKSSoU++ofXzy3yt0ljEZdXMK+5dzgKCNhFQ=;
 b=N//d0toa5Ey0Yz/Gvv2VCxWsgEZZQFE65Q9TNikbc4NRiFTSx0ugMM7AJv85BIKcEgNXAHtfH6Ho8XyQRb8Y6a6PLmRyhPqa8+rVlgKhxgnbUfpMH9LkGzuHBCm2VEZ0ygYSBOdHqDeaPCc3qIHjX2j12T1G6nO+FIv0JWH+CMAbUSQVYf667sZaimvq1w3FODQ5jf9uqRAtvObj17pPuwm1BFsxRTnCNXEFRboolrmDk0ExCNxUyy7XxJHOYfPwHncYG+alRD8hdD6WKszflDF/RcCstiUQTNvIXiHvNyiiMaRfuHVOYsdFqAqrZtkJrA8QUhCyZpgI8qjshwF6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BTZqkQnKSSoU++ofXzy3yt0ljEZdXMK+5dzgKCNhFQ=;
 b=cKXPyjlIe2Y4ZIdUzilgbPk9WGP6U5G0bbkMptV0AuXx//91yX7K4WATJNuiBKWma9gs134mqFRWbDs6ZfHAtRZ6du8qyZbA31kfR8wMyJJ0S6o2sbQTbLHkoBT/0V/7ZC3A05gBQz2/BDTg2JMpscut+24UDsa1Z44bvxcvc0Y=
Received: from SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::12)
 by PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 09:18:30 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::e8) by SN7P222CA0008.outlook.office365.com
 (2603:10b6:806:124::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:18 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Sep
 2025 04:18:18 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:18:17 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 11/20] cxl: Define a driver interface for DPA allocation
Date: Thu, 18 Sep 2025 10:17:37 +0100
Message-ID: <20250918091746.2034285-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH7PR12MB6955:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9727e5-907c-45ca-3399-08ddf694557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5sMxfASUqn7kC/Zy5Pt+jEe6bt4P9yWtRQjltU5sXWx8ugkdkx5IdnDpT9qd?=
 =?us-ascii?Q?0DM1tBOE8Botjk6LKneT/G1n1inoCyuv9dw/DjPhQf+BjThyG2d2W4d70rWD?=
 =?us-ascii?Q?D6ltsmiVeLZwLvrIkwH+1RvTTU7Qrqx7g7TImwp1CSMSUat7FrnW81Yt1ljs?=
 =?us-ascii?Q?5nEmdvD9YVu4CTRybjDjji0bFugeXTSrJZnMLeJcpvZoxGGtI3A9f2cvi+t9?=
 =?us-ascii?Q?9u0T09K88P652iWMjvU8pP6AfiUm0jagI/BxvRsqB8x3//JTAWbN7XvknnEG?=
 =?us-ascii?Q?kujATQX/e6ftXcUgAixbStyrzD3UO+v13MA4D7DhjJCzomOPiVBcIS2nAOdG?=
 =?us-ascii?Q?lp2VMJM+b4bNPPL9Fjyw8Rg3stCmvni9Xq2VoYuFlNjfj4ndgOJhFXkSNolY?=
 =?us-ascii?Q?zwsRLfRIF8K4A7mAbOtFik+S9i9iLqtqIR/YBB0enoOZvN01iKsPWob1XAZG?=
 =?us-ascii?Q?77/8bxFXCxsysPE6QM0wr8wZ7MplXQlJ4gIYZPM10K/GumstisuSD0vWSWQv?=
 =?us-ascii?Q?oxqO4xBhaRnMzk1FH5b3LWSgAFYtzdgyYthnR3h+0d5tE9PX6EoGNqokooNo?=
 =?us-ascii?Q?vUEWNrgyX57mm6d6c0lCVv8DsTVmh/rly8u/T/Yk/3CjDmVLiksyvYwEV6oM?=
 =?us-ascii?Q?swIAmqWI1gGCbh5/LwGw2xhC+c8O/ZS+QDnddw9TRe/VGUJshGyDTPyAgHMS?=
 =?us-ascii?Q?lZ+l3EW5x1xirS34vyn2Y7PmBRVK+sbF9hkkCQs7HQs3/GuH6pNIN6pyQiEi?=
 =?us-ascii?Q?HLXA+RyaJEZMqilUDxGFHpk5w16+ef2uDPQ9N8uYhFpX2VftgFb+70jKqzLg?=
 =?us-ascii?Q?VmxHVBnPtt7aNGGL+0tyy8Qe7RE/M+9uGPnE8guKsQQpq6xuF3lkDStWQ/Oq?=
 =?us-ascii?Q?S2cQtOKyTReOG+LnmKSK5374Eucvr0viydf4VErCx0CeWe4b+l02UUgKBEWp?=
 =?us-ascii?Q?DJRWzf4DlvY7HH2MYWMlrmNLsBU7Ot2cKW8roVcDQJtbhnF6QeIE0nCPKakY?=
 =?us-ascii?Q?yPZIrsTDftE4zPSkoPIT5zkdLYe9P1jhBrxfniQkvdb0nk0EqVoJi8htEN3N?=
 =?us-ascii?Q?HM4ku5jnyske85hApEjE9rbeV3RfxPgE4RUYFhBjrbIpY+WqNScvwvv6NjeR?=
 =?us-ascii?Q?f02Nl8Q2LAv9WN727rgLLzd8tE1QXZyKHQhjtr3mqaZTM8YwwNszOdXKIQLn?=
 =?us-ascii?Q?V55x5XltUmQVmxSSESyF1f2aCnxuQ3n61Z7pTFRqx8d33WKfO2JoGzUeTCJ8?=
 =?us-ascii?Q?lgPB+HghaRLCnqvgP5cC7kYiVOI5EoKLwhc/RAJSN2MHCmazhoyJQVZPzfVD?=
 =?us-ascii?Q?TaI7HQ9FJmLNM0oSuR9os3auizxubzG9/mIJwPIsAoYLU7sxBlH+OTuz0BdV?=
 =?us-ascii?Q?rYAxuXT1RRygAZBMedvH9M9y4X8WgQjH8AF/zhuRmyK2ijXYf4jt8UzV8TOr?=
 =?us-ascii?Q?YveMBAyciY+Mjtn388q7XkYPUco7bUggxSWSvFUaBTHKhVrFM3nFVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:30.5661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9727e5-907c-45ca-3399-08ddf694557c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace().

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 89 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index e9e1d555cec6..d1b1d8ab348a 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
 	return resource_contains(res, &_addr);
 }
 
+/**
+ * cxl_dpa_free - release DPA (Device Physical Address)
+ *
+ * @cxled: endpoint decoder linked to the DPA
+ *
+ * Returns 0 or error.
+ */
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
@@ -582,6 +590,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -613,6 +622,80 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int find_free_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_port *port;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	port = cxled_to_port(cxled);
+
+	return cxled->cxld.id == (port->hdm_end + 1);
+}
+
+static struct cxl_endpoint_decoder *
+cxl_find_free_decoder(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *dev;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	dev = device_find_child(&endpoint->dev, NULL,
+				find_free_decoder);
+	if (dev)
+		return to_cxl_endpoint_decoder(dev);
+
+	return NULL;
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @mode: DPA operation mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Returns a pointer to a cxl_endpoint_decoder struct or an error
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but it could not be available
+ * due to HPA constraints.
+ *
+ * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
+ * reserved, or an error pointer. The caller is also expected to own the
+ * lifetime of the memdev registration associated with the endpoint to
+ * pin the decoder registered as well.
+ */
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc)
+{
+	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
+					cxl_find_free_decoder(cxlmd);
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	if (!cxled)
+		return ERR_PTR(-ENODEV);
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return no_free_ptr(cxled);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ab490b5a9457..0020d8e474a6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 788700fb1eb2..0a607710340d 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -273,4 +274,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
 					       unsigned long flags,
 					       resource_size_t *max);
 void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
+struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
+					     enum cxl_partition_mode mode,
+					     resource_size_t alloc);
+int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


