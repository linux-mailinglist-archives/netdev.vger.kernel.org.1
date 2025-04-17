Return-Path: <netdev+bounces-183927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A6A92CAE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CBF92475E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B216621D5AC;
	Thu, 17 Apr 2025 21:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mMqroXmv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20371CEADB;
	Thu, 17 Apr 2025 21:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925401; cv=fail; b=ToGfPEP2r+tP0YiVIcyclLEW7pEa6O3qP7PA7TLvjMl8m0xtvRfIDxtSN3KU6P5wltzAkdd7psOAjYOEotZKSTj57/BV5VyYB6OWD9psqRX49PeoR+VNvqjP43X3ZHyLubG0Utn395CrNTLzqEvfqNlQCwu02a3rF9lWvV7mqF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925401; c=relaxed/simple;
	bh=kgdbe/EQIIWA7RL1Tc5nplVLJwEzH7ADMhwye6Fq0aU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeSYwKgNxQYpck/TH/7P7bh4OZm3O/f9oYepbyioeWe29RFeXtvA7CrgSmNYruhB/aO6KCKkVxMBRLILNAk2TVHpDhWXgnTBuO4VF/fglMvCGTgbCBO/iGGnBT9NGa85vLL/KJmUcL5nJ/H9vXq3nbwaXlPz+bxiSWwT5F+bJNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mMqroXmv; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njwY6q2JGl23T2hAqk2f9P+DGduby1qyiiLHhw7FYZnl2n/5em9615cDsSEeK4Sx2wr976ocSMiucKVGNtryMzWZPC4TKL5CBq13cClny9UGYC22M2s+wsSuibQ3AmMybPL3tZklhF0ZdnH+z8XRZ8byvCrtTONOly5K//ZCIWCYAXEWcQQtYqPCodVnKqRGLxu0XCYcueMsZQnp0yLxdYCzr9vPH0dstnitRQCpVKUXIzM4Aw+jCxdWb8o/2Ij+EEtoVSh3laK6SSJH6NQxeKV15vJYM3G2KksHwtihLn3I1Yvf6fwhJgT4Xu9/Y5sL+Da7wnPR0qfUEAs/usptSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQDlW9ZSiI8oVsMFCXENhMvoJbH/+lM7dXWPJrR/TvU=;
 b=KmR+GQ8rBi0btohYmNO9zqOo1S8psCZegRKE7b/zqCFPxL+55ZaoOQVcmslUG2lTfHBXGwbk8xNnSQX3TINc4PetpM7MbYu4CLbbtDBNJ0WAGTRVvQ5hYv4z768w4WaWKC7J+//PBrTdghSkzOMhinXBajL9cMk5cLIlVTwg7g3EpwrZgLffS1kqbIWwZc5clhYS1dlb3eulkvy7rEdB8lQVpCiSHK1+PaOspsNaghsTrKTMm0MDeppWcfPa393/G0BiWSUABMgJsZjuzktg+EV435R2l/sNM3eyUV1AadLK2HwcDi3lEzYymCE84jIpw9qBYEBxoKinW7Y3a9MVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQDlW9ZSiI8oVsMFCXENhMvoJbH/+lM7dXWPJrR/TvU=;
 b=mMqroXmvZyCDeNSWegs5h6BlXpaSjooYr9m05Hfy1u3laPtwkp1lybUWx3ZJXFUVXgn989gxpMM+AZ++iloI50dCi+9dGa/YOY9kQZnZl0fbUHcFRNJ4PZy95ovJRGCOSFzp0pnh2DY8QeZtLL9Hw306GJ9bGCExY2/NLc8hzVc=
Received: from PH0PR07CA0055.namprd07.prod.outlook.com (2603:10b6:510:e::30)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 21:29:56 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::d) by PH0PR07CA0055.outlook.office365.com
 (2603:10b6:510:e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Thu,
 17 Apr 2025 21:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:55 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:53 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v14 13/22] cxl: define a driver interface for DPA allocation
Date: Thu, 17 Apr 2025 22:29:16 +0100
Message-ID: <20250417212926.1343268-14-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7152ff-bc3a-4604-c2ff-08dd7df6ff86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69KEiVBg7rMG3VcSHbtSdFA4go6yQi2Rxqet1BXl8NpHUwVlvF6dpcClo9Eg?=
 =?us-ascii?Q?pUj2pkJp78Rey8JGvDUcaaoRHAhw4tpqBzkY4Eo3GJy0H9xd9wr3uj8YD4Cr?=
 =?us-ascii?Q?nDGSq403adzIj+41WQAeBRVKgEMVVtK+5DKFLREGPhCZge7SAiS136glfIT2?=
 =?us-ascii?Q?1EftnABSkfgrnra6RN5ke1kvshs1E22IEFqPRtMKstfK46kirysfhOHCm8s+?=
 =?us-ascii?Q?zGgc6b3PafiExbeQ43j5ZEv7h0EhHi+uOEeAhyFwZZ7OJiJ1ac/qkwrFU7Zp?=
 =?us-ascii?Q?DSF/1zdm/UEyAeLRdbxxoAA0vmW4yRZzLk/ARMHrLjhj+LxLsQMQf1Pnf3uM?=
 =?us-ascii?Q?yXcBmxx5lQupwwYUXAsZjgAr/86N/4SuO2zYTq9lAYxN9Vb+TkQax4icZoL3?=
 =?us-ascii?Q?8zpAXw/QXU6Q2383IXTUrJthGUGRcnT7NeFl3Q6rTMmH8XA/PWf3+MY2yvXc?=
 =?us-ascii?Q?SlNJX3ndpcEHZNDB9JFYFM63qWOKD6tan+MRX+F+j9wmqs2LX6yjxwHMIcXs?=
 =?us-ascii?Q?kNhg9w2oQ2JTtCkpaiZ2wkAQaS7YMJfsylNOqHy8unDXgaj/t1g6sRNFUcOn?=
 =?us-ascii?Q?ydMlazeYO5JwkJdMNzRh01qnp7e91UOtVQO1/91sgieWnF8yqaEPl+jwNTQN?=
 =?us-ascii?Q?bStTqnEPsfgQmki06sq1w68yY0o1tSXNgDbLqgrvZnQdaD9YSFcbCxlwbzAA?=
 =?us-ascii?Q?bz8451BUNyqISezIjGnZ//reEcyJhw6cykTcd17E1YaqSjvXrDil4MX6c7J/?=
 =?us-ascii?Q?7ml4oIrP2GoclkLoSsn1+OHUUBoMW1OsYRx43pIYQAeKZqv/W58VYMkdZ4hx?=
 =?us-ascii?Q?5pURWSyqlxRVYbX1zIa+lE6Uv1q+kK4ohp7FrMrK8kUwYiLWOJ78YqAjPJVo?=
 =?us-ascii?Q?uSuUhUJRxdicQIT+Nksx/qqfvjRrFzLSqm28uzGv5NU6StPyQQdXjgSsvwKd?=
 =?us-ascii?Q?Y5gUpcJ179sXn2Ec66l9eeHjeJtiebyudr7PW6bg2RebgYTuNKrcmWF6I0ZA?=
 =?us-ascii?Q?+mrsyTL/z4nX8lTAyRWlIaFy+otuuUU0UuozaDY0Jhp9Ic6zepFsB2mULfuM?=
 =?us-ascii?Q?jve2d/t9NsRXVwLAz0NDC2fBXSp2nOMBaRk1FJ96r65spHPKNQ8hYQSNj7EV?=
 =?us-ascii?Q?GH4FSOoK6lt4vLshT7goqshKL0+XUHfOav0kYWfO1F9duFz162bAvqOOc+IV?=
 =?us-ascii?Q?jn61o0ZCEST9rBLydE0wMlniWqhl41S7cRXwM+ZOzu1gSrVs9BWoUYVt/WFe?=
 =?us-ascii?Q?82QUfX8nNZVa5oKLBMlSpFgg1Zq36kC21tR9FUf6EEhArH/sw8A3+ACMHl7b?=
 =?us-ascii?Q?NI3Ynh4cwogIHn/folWhHRXe8dAY1g5ii2N96p+CO0t6E+x9WxoTrAJKV5QG?=
 =?us-ascii?Q?6BVMJj6EocJJOwQuXeuY6IMIwhZGxcVIQbxvVuphHBEUV4KhQugRfVcl+396?=
 =?us-ascii?Q?YfnNRunqY3qBoXTDc+FWRPajTaH5b8Uc4KZxf+UovQvqFfTyXX0RiLgjrg5g?=
 =?us-ascii?Q?9qqeETKrO5ynKa6PbnOxDJkr4U0t2z6cgWefGeI5dkqHqfrT6TLc+YCrVQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:55.7364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7152ff-bc3a-4604-c2ff-08dd7df6ff86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

From: Alejandro Lucero <alucerop@amd.com>

Region creation involves finding available DPA (device-physical-address)
capacity to map into HPA (host-physical-address) space. Define an API,
cxl_request_dpa(), that tries to allocate the DPA memory the driver
requires to operate. The memory requested should not be bigger than the
max available HPA obtained previously with cxl_get_hpa_freespace.

Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c | 77 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  5 +++
 2 files changed, 82 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..fc193a98ec61 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,6 +3,7 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <cxl/cxl.h>
 
 #include "cxlmem.h"
 #include "core.h"
@@ -572,6 +573,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 	devm_cxl_dpa_release(cxled);
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
 
 int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 		     enum cxl_partition_mode mode)
@@ -686,6 +688,81 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
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
+/**
+ * cxl_request_dpa - search and reserve DPA given input constraints
+ * @cxlmd: memdev with an endpoint port with available decoders
+ * @mode: DPA operation mode (ram vs pmem)
+ * @alloc: dpa size required
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
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+	int rc;
+
+	if (!IS_ALIGNED(alloc, SZ_256M))
+		return ERR_PTR(-EINVAL);
+
+	down_read(&cxl_dpa_rwsem);
+	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
+	up_read(&cxl_dpa_rwsem);
+
+	if (!cxled_dev)
+		return ERR_PTR(-ENXIO);
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
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
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index e9ae7eff2393..c75456dd7404 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -8,6 +8,7 @@
 #include <linux/cdev.h>
 #include <linux/node.h>
 #include <linux/ioport.h>
+#include <linux/range.h>
 #include <cxl/mailbox.h>
 
 /**
@@ -261,4 +262,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
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


