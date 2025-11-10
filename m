Return-Path: <netdev+bounces-237243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34055C47AEB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F88420638
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3395F3161A5;
	Mon, 10 Nov 2025 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1yaOrLe6"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F28153BD9;
	Mon, 10 Nov 2025 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789066; cv=fail; b=RcSb3GmCYY6zpmFL/kM+rjREtNMGodNY+3Bjs5pTPgHKSb0bsmR68FSiBDdhpVCQ26vwAE5VXAdUAyp1epmTsbd9a2hhPebPpbgemuqQ2DLBpJwjKqXlFyNhKLnlfzi2vrAyPIFXBV8TOt/JL61HuswwtgaZWuBjd6VqtDKyU9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789066; c=relaxed/simple;
	bh=Eo1j12EaJYBCzG7wKVw4oSSTEILUmBjkS9F4Botj1Hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQAoK2s/g7nWMLgkMtx4HCAtYu2b4mv427bgkKuwjdq+nGfrYSIyMWmUBaLbz5Q2+ZWVzckjDt+80upLupVqpniB9Kbcvw3adFyJ6Hz651dyy0tjCd/KjZ3nH4+uFRJJ3ySIPeICWxlSlapRWNb31MGw/Gpx6xWmvkbDI4ngnC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1yaOrLe6; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMLO/qV6q0279wx2ToUDN00GHm1LHp0VmU3R7Is7ZqhdkUwXb0XzxveOcdiAxgU7gcv6V8CA8r4151iyVezgTMSHu8ROj/1DEuHeY/OkwD3s7bjEc74pmfnI1V/HPHVFZXNU74jvQx+3bN7dFlXT3pSuZ65yH/so6l4snLv1Y+puWV7Klcv5PzcKda1wcmvUj9jqvn4YAp8JgbXYucFa9eNibfnneGJsTcxY0ZJ9Hxrbm6NmFRd+cF/4Y+7IEJH0Flxg//HMd3JTmvfaqyblYrMU6sQTbPWQ+Q3Lo6eQFw5nfGWXFixGWw7bMiGiwlyCwImwzSVP6eGHW8py5qQ9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HS+iICWAyolL0zBJPwjdTDP0fN2T/rRpqjh71DYaizg=;
 b=QJj4fOMzdWxgg6/6YGcQnLy5k4ADF2EjptmnBi9Wik5kGiOzdoAvoRvM7MeHHdDjEod/MiK1Q3kBbsLucN/lUSOjUJr9wXe6FrQ0rFZAxRYL5zk4KO+CMAydDw2DTftrO/To+W1Fa6f6z5PIWPqqWIInstMnE6Vmtq6d0hXv7NwbDAH2SHHX4Fe9zRPJq2v6ktgRcLC20Ag9CMV7zylcSfTQs7l/p+F/IYDWCG1dZgFtZARaHlfuHk68tXG34B8/ScmJoXTKfZezYe8mI9rpQKxAroZemKEjTMNpUUQa5L3I2PKzWsMFqlM58Xj/3T+EywK0kwktYxf1xtbWkcdeyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HS+iICWAyolL0zBJPwjdTDP0fN2T/rRpqjh71DYaizg=;
 b=1yaOrLe6vPPnlQhX773aoPv3/omI9+Y3eGooPXhQRfb9Fw1DwZxdPiBLp4MJV4ahQzOrc0h36RYyTKjUFim2zhX9p/hB0HbbHnMQCfdmpxSVBjZaW2m+NTtcXFHxVIu7IVuD+Ol8cfy1hRK3b+LX+UGajvoIgJhSqSPPm25VjIA=
Received: from PH8P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::13)
 by CH1PPF93AB4E694.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:41 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::4) by PH8P220CA0021.outlook.office365.com
 (2603:10b6:510:345::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:26 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Nov
 2025 09:37:26 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:24 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: [PATCH v20 13/22] cxl: Define a driver interface for DPA allocation
Date: Mon, 10 Nov 2025 15:36:48 +0000
Message-ID: <20251110153657.2706192-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|CH1PPF93AB4E694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4cec6c-be24-41e9-0062-08de206f15a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uD2t9b5JACA18kuz2cQegncoElIS42+LpcmVUuM8fT0YLPZW1FoEtE56LbcG?=
 =?us-ascii?Q?/HzzIj802IroiISe9tZEpgtrUo1TmUF0dGBwfDypkfn+bomSOT5wUY60zUew?=
 =?us-ascii?Q?HUMkUG0HYzHD+N5HV3nEtO1zENgT/BXlcnOfRZ67MVca2xPEat8nvwIS8yNd?=
 =?us-ascii?Q?RjBTY7olN5YE7PMYPo6D2Io83jSOMSPyNaNZ5kEhSSL3rYWahzGhRSF1ZhDv?=
 =?us-ascii?Q?Yx93htQR6BXsVSG7gesh59ukZH+YANUb2TI2K0nnyUoCr+iTZOjF1b1A3Tt5?=
 =?us-ascii?Q?OvzW+dQJ9yjAa95Yds5qJhvqjdM/Cq6CcfJby+/G2+2LtH7Bdrdtd8hXYElP?=
 =?us-ascii?Q?F8tZWg3ubMMoN+0In2X19iDix0eEa+kgAcbM+Ku4g8s8R0fn+ydrAsFlpNrd?=
 =?us-ascii?Q?Pahi4BApRy3km8Oavd357cnHKhpYbj46hX1fzBEhA3y96mOAA+8CBnBhUGE1?=
 =?us-ascii?Q?fcNWOBNyTHg7ToCO5XBgd5apivaJEuwTVOVeD90EwnxxemTHLenQh1D/B2ao?=
 =?us-ascii?Q?5rLbaHcqq4OmVkM3rrpQWhwu6KA2DuQonIgxFMeCMhYaRr2PcsehDX2tFRnx?=
 =?us-ascii?Q?RKO3LBdfnPTC4q/mewK02JRz9vj4R2n69Q1m8T9cAaDxaoPFYv99CmwhFq+u?=
 =?us-ascii?Q?CjteV9iJN6dncUoXZntdx3XDZj6h7D7hrCDOOejpVdSX6nY41VBOUQGL9KnG?=
 =?us-ascii?Q?vljxOdqMcESq6v0QRfCkCGnwZzNye5PGTnqth4VJjjI+PkWLqXJr0XhJGawT?=
 =?us-ascii?Q?75qfmmawdZZ4Z894Nx3UUfeR89WNtxpyuxQ2pEQ+c0IAFhi4dDrIMwvrPvN5?=
 =?us-ascii?Q?GFt+WMs5QyNL/tkA8xASRS6AEWvCInKWhZy6bf5AspF2ZgWps4xVcGk4fYpC?=
 =?us-ascii?Q?JBCOwnLneTMOEyYLkRxzp2NAGhtO5PDEGpWA458lQHpxPNofojpWlQD2/kVW?=
 =?us-ascii?Q?inNHIAX9fUTZakiUKQxluOQn090boyKE0zJ+2zfYee6slPndfl7jFMzH6WTl?=
 =?us-ascii?Q?4/Zg8vYMXgMGaCdz82qrlgH6CCh7KJi/3iHSqnfIHUxmYc6KWCv5d/4Ap9js?=
 =?us-ascii?Q?y3fLUqMZ/mQumIqGcr1g8tdn0JHH9tS8f39Rwbco447VSwX5c4iBwWFqyPTO?=
 =?us-ascii?Q?wW64oO1SElkY68WDqJuIiRUWJc+7+m7Ti57jxTW3ufg3xgJLTPEvJJRjLu9k?=
 =?us-ascii?Q?6J1vKAAs9bteONcEHLnh8nwZMUP5+kzP+wv7IETHYHhpk1Ue90mwByhecBgY?=
 =?us-ascii?Q?bgoGidABO44MwnyF5Nr1ckzh8J5syF9cLtvWbk1acz+uguPBGbD/BuNCo7ML?=
 =?us-ascii?Q?n3tU6E+Zb7cxcvJAmR1Vbv0kroDZtbIO1p9P+w5/8NHjP+66HPcyfFXmVybV?=
 =?us-ascii?Q?3Dd97GLfxgxF93WbTshO0GSb8AIrzzy21KZuBzZLWqMdylAIdahxNg8Q2nEV?=
 =?us-ascii?Q?5dPqZ3mokX1C55bLrSNi70DZuDYQpGn1BLz2d7z2n2y7fMkKSWSCNX1b63fK?=
 =?us-ascii?Q?Uk8GkDRdYl/A+VjJAkVxHoCcsgprSNH70P2bYCh8ehVwAmnm7UfmLZ9jQyeF?=
 =?us-ascii?Q?J7xLnj6C2Sw06pRSfT4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:40.9141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4cec6c-be24-41e9-0062-08de206f15a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF93AB4E694

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space.

In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
that tries to allocate the DPA memory the driver requires to operate.The
memory requested should not be bigger than the max available HPA obtained
previously with cxl_get_hpa_freespace().

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c | 84 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  1 +
 include/cxl/cxl.h      |  5 +++
 3 files changed, 90 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad..88c8d14b8a63 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -546,6 +547,12 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
 	return resource_contains(res, &_addr);
 }
 
+/**
+ * cxl_dpa_free - release DPA (Device Physical Address)
+ * @cxled: endpoint decoder linked to the DPA
+ *
+ * Returns 0 or error.
+ */
 int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *port = cxled_to_port(cxled);
@@ -572,6 +579,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -603,6 +611,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
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
+	if (!dev)
+		return NULL;
+
+	return to_cxl_endpoint_decoder(dev);
+}
+
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @mode: CXL partition mode (ram vs pmem)
+ * @alloc: dpa size required
+ *
+ * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
+ * an errno encoded pointer on failure.
+ *
+ * Given that a region needs to allocate from limited HPA capacity it
+ * may be the case that a device has more mappable DPA capacity than
+ * available HPA. The expectation is that @alloc is a driver known
+ * value based on the device capacity but which could not be fully
+ * available due to HPA constraints.
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
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
+		cxl_find_free_decoder(cxlmd);
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
index 5441a296c351..06a111392c3b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -640,6 +640,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
 DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
+DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
 DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
 DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
 
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 2966b95e80a6..1cbe53ad0416 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -7,6 +7,7 @@
 
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -270,4 +271,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


