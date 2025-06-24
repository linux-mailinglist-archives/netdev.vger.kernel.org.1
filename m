Return-Path: <netdev+bounces-200677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163A2AE683C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379351923F82
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA142D1F40;
	Tue, 24 Jun 2025 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gp/v9VtL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729962D3226;
	Tue, 24 Jun 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774481; cv=fail; b=jKn3kJIrrC9MHJusL3Q5WBHaRxWGdBDm2OwAo89HZkNVqgjfEK4Dxp60+k9yo9lznt+7zSwKQqTeWUh5rCP3B/fo5Lm7hcFVUkkYPRrVMsLYk8gEygseCgH82RuiSB1QdsMeELrMEyaMcw1zyAhUFCncPoIffOfs/rX7ER8Xdz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774481; c=relaxed/simple;
	bh=rFA7X+oZqTcoSsFijnUe42vQqs75G+284T6rp5pLFRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9oKztAk6Yx4Ydul+B4gaOJCWF/7MEDhpbWA4tWdAMnVRUUDg5IiZqLJiIyxRKmKBgjxh414SMy06VJT4jrebHDBON7zCX3xw31ZaPyJwrf+HCPRos919ztQaBNcsaPMNs1G+1HNuYOv0sfPY1OXH5w1/FaFVOH8J+F6AAda0Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gp/v9VtL; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LA609XHftr9QQe5KRiS/3pyHZxlJXJQ8ykjd/c3Lh8HJ35IqiMStcx4QyYmDlR+CNhjT4nIoWR2GytjjyxJcYQCXL/ZkhWe1VOIxWh/OOaD+Sux5sjwC2KwGCf4s2QR9u0P5jwFs8YtWvacxjFTzHfTyg8I3ygDEt+90Lm3wi9d1hTbAKEIqZkiZ5Flf1/4DEy8QGLp9Vk64ViP8fKyoDQlWYetxCimns3Ui12F9oO7r8eyA7OmS2Dg5+3e1cx1XkICyrT88geVzWtjIoBLBFTV0llzFi0szaxmFFeeb6wex3rk3Psm3NUR5g9LV/8CYu26WMEK1nF5CnFM/+5oCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbyClyq25lsByvMA8UI2Yg1wu5dLng7ao4VcfMbS7g4=;
 b=FL++g81cPgybwzGvZSo53OmjXQZBabMNRfrfeiukGdBRAjN4LFRWTa54SBUnEMfLHTAY3jxxm2DxpxMA6UPiD4a8/INiFDKRzcz2r5ZDqJcRFBNPaCl5sot7FmgIqXLVOFdzLAZRpZUzXLbLdLJ4FWK1VC2HSAij3Y4C67lk4gmLyhurnlLS/b38VHrLusMkhUjOS1ocwFk4Bc1kydvEdzQ3hX5bi7syupUwOLSvR3fl+CybNaWg9PYQ2HFKypQ2mC2HUqitmGTR5v0CvSYW+EgYBSuYKR4lHU4VZaK/XoUEB6R2c+4lk+4BBbIkf+HXTivJ4b6tLuy8nfNQyAu7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbyClyq25lsByvMA8UI2Yg1wu5dLng7ao4VcfMbS7g4=;
 b=Gp/v9VtLVdLRQAdjZkjxT5hGFZamn/cXZbWqBy3DgQ2mWv9IpnbBPAxta6bqpXmNpE/GODWmuFMARfzL6eh+fRkdsZp6t+sks7eUVUt4tOhnbAgMahab0TL/2tOxCsYvbIIuzb7r7pDM7jE2cSGRB7dVMtxgw4lZx4zlX+u2tGo=
Received: from SA1P222CA0157.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::24)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 14:14:35 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::66) by SA1P222CA0157.outlook.office365.com
 (2603:10b6:806:3c3::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:33 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:31 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v17 13/22] cxl: Define a driver interface for DPA allocation
Date: Tue, 24 Jun 2025 15:13:46 +0100
Message-ID: <20250624141355.269056-14-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae8c6cb-3abd-4a32-8df9-08ddb3297223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C287YNw0gqaUxr2jav5LFTFVXtpHy2qYkqMtnfwJRfBkjvAvzfUaEAH1NfrI?=
 =?us-ascii?Q?+kLMAwnLI/Pzr5vx42Ttm6ltJJailHS9sxbNJ2uGcP3YNr5c11/nl2sOsP40?=
 =?us-ascii?Q?TNas2Jp0dTqaLic30ZDspAxLNxcPXOV5k3QE8hjynvi+E7Lo9Tgm0ZNb02/h?=
 =?us-ascii?Q?YQ1w0b9e+ox1aYRPKYNsAjZwoSqh71EAN+dHDiWihJcMHyzLNDB2FCr30NPH?=
 =?us-ascii?Q?OhOD3sJBbvHwhl/7fNYotjKifdOFiusxhIihlYgagywMEOBtwaNJGCDb3GZJ?=
 =?us-ascii?Q?AX5SqbyJWh1JUjNoSq2O6Agj1Spf2ebyQkwBXCc+iDV/0QzAJ5Ungkm1ehTV?=
 =?us-ascii?Q?s7X9kr2PHWtFjPw+dCryn7WhjSjOrao7dr45wmkdPUqMOcmT+OtwOPqZ/udI?=
 =?us-ascii?Q?TAGL9I+b6aMyruvg1c30zJBFPKz4W1Bd/XZH4X/i2uc7tjiQNIMdm1onwmUL?=
 =?us-ascii?Q?oTeBILHWxV3iHFa/g2jr5S8NzYSniCkldNeUSdkKVQIk6KK1ob1LzFluofws?=
 =?us-ascii?Q?VV+CCSLI0w2xBIzACYup+sGRq1kfbZd+PVS7BtNkgAIm4mMzo3KfYptZx+l8?=
 =?us-ascii?Q?3mrTwJ/lGKIAIhxfiJN1ftwEpvV9581TGq0CiEaOI/gnn2sTrt4CnaXYXvcq?=
 =?us-ascii?Q?1SjWIS2dgFNUNU6vmNgQpIO9NVlOs5MhyubnXzWEEyUrpfr9mn55zikZDFGg?=
 =?us-ascii?Q?QYuNfsoWrm8Nhtp1hZIpVWGXMb/Kj+kKNfxb6xYfY3oiUnBJEPPRAj4t6d4n?=
 =?us-ascii?Q?2+Ie+UL+AhGW2HMIPfPqGidCIJrflGM2qoSVx6IOI6fzumDsh9ADqMq2M7h5?=
 =?us-ascii?Q?900/zk/EkWuaeDKDkkJ/gakZ834Tk8GRqU2TlUAl5zOTZ1nVLk9sfhavmb8M?=
 =?us-ascii?Q?4wPhOgGR4gMQB+cUV854omiSVWJUFVnJlcP8r8zzd6tVggPfFMNS1umnRwGK?=
 =?us-ascii?Q?QpPnHZSzyUILSROeCJlrpG1FJkgNglSkCVlSEZ4gYE18kT1iI6bo7sIMLKYH?=
 =?us-ascii?Q?Vi4HpiFzKcSu813Npz/0F4Z/5Xh3/etQJ771hzyA8M2vFCI2/VFbnndJ0J1J?=
 =?us-ascii?Q?f1kCJEoQvmw95wGs9trQS1iXhfKRjZAlfs0DYyuVD1dp2VmEpef5uGSfSN9X?=
 =?us-ascii?Q?AH4tOhHFPWRPjuqw4PBna0wT53XuWgbMu6UaQ2H9Er470DsPFcckswJtNN5/?=
 =?us-ascii?Q?SoZaDqvYjzWdjS9fPDvXJy1d+8/VnNjmeNa6msVyzNvO989prKacfSF1rWup?=
 =?us-ascii?Q?WKEC0iDFvCOb/v6HKDUhit9cAWja/xyJodW+HzVPOg7LDO4SnIgkcyxlR6M2?=
 =?us-ascii?Q?iJwf0Yd4DBTloFhXu6suCqtOqjiWUUV1+10hHLgikZohoNKThKoOJVExY4as?=
 =?us-ascii?Q?4HtzuB3OC4y0gqRUAKX/8LlCUeRvCzUn5gLP04e0uVS/Xa+Dz68F9uK/WSlH?=
 =?us-ascii?Q?JcL0MBgaRLXE+Uctvtn1HX4aPFF4GixqfEP2dsIm/v10tYRgEBBSljqailGA?=
 =?us-ascii?Q?BF3oi/RxmgJJpN8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:34.5680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae8c6cb-3abd-4a32-8df9-08ddb3297223
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 100 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..b17381e49836 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
 	return base;
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
@@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -686,6 +695,90 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
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
+	if (cxled->cxld.id != port->hdm_end + 1)
+		return 0;
+
+	return 1;
+}
+
+static struct cxl_endpoint_decoder *
+cxl_find_free_decoder(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *dev;
+
+	scoped_guard(rwsem_read, &cxl_dpa_rwsem) {
+		dev = device_find_child(&endpoint->dev, NULL,
+					find_free_decoder);
+	}
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
+				cxl_find_free_decoder(cxlmd);
+	struct device *cxled_dev;
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	if (!cxled) {
+		rc = -ENODEV;
+		goto err;
+	}
+
+	rc = cxl_dpa_set_part(cxled, mode);
+	if (rc)
+		goto err;
+
+	rc = cxl_dpa_alloc(cxled, alloc);
+	if (rc)
+		goto err;
+
+	return cxled;
+err:
+	put_device(cxled_dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3af8821f7c15..6e724a8440f5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -636,6 +636,8 @@ void put_cxl_root(struct cxl_root *cxl_root);
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_cxl_root(_T))
 
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&_T->cxld.dev))
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index dd37b1d88454..a2f3e683724a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -247,4 +248,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


