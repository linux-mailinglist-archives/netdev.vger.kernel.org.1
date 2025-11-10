Return-Path: <netdev+bounces-237230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130A2C47A1F
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268703B971D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5AE2236E5;
	Mon, 10 Nov 2025 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXHzP7DV"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CF153BD9;
	Mon, 10 Nov 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789047; cv=fail; b=FL0+novX73PcELTS/RxcvFYVr/00zZ6Q7xATW0mP+BhDCQlEEXggIL6kd4jIc9asiFHAkF9dKnKEwqV2Djd00Tpc9JY6lgz9ABZv6RtVH5sfApVthb6MMXq7zccg5A61ZsKhSpibLzrv+L0/CvayaFxx36/OabhU9EWIj3GvrgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789047; c=relaxed/simple;
	bh=nWBqt/HIjumqkhyGOcVLvk9yGpJpnrJluJTJJK9Kd74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPUDzictbAdZt5dd9OzYreBaN9hepm4miecoOke5BzlLht+a3Wq/B36ENu8tFdomcQ8qVGncvdbaCbV6J0RacIKCR0G1RpTQUNJ2lFWwg0i1jkNBQOEixYByItquDuXLWEFv3DD0Yq69yLVvjhjvctJU0tGvnPeJlXbQGHoxyR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXHzP7DV; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHjHrV6B8TmVheMCgulwU63q9ssdqbYmS++rSbVvIlSWRocufdaxpwnC6J/4ssAo5Knnv5TpA0vaQq0UIPoa6EYlksj9Zcg83U8rzXVBYhNWeoOqxWB1RP7xK6Syt0eyhp0paJIOcGGDhalWJk52wovqA6T+pVw4YtUk8P2NkqKLd2gbQqBOZbwcrUjNQVlmdKPeA0hgIlBS0vsT0ZEzq4DAFge6rBRfjVrjPCQDzuT/zHHmrES4byhambG2+kdkG92o5UZJ/nufPmCiYC9uUmLYfZPXlcg0Xl3FXyJtmdmH0hd73y3rKOigW6075Ms0Ftywo9vDQyFdV2LjFHZvLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OFjmKSUUW/dMKzGpf0PH/Ksz/f+oUAWbqMkq461xT8=;
 b=BjOyMe73baEt9C3QpDs38we72AXUwHVX/uG/cNTZj5xsCv1xLhRtl+s45NWi2G7177Srx9rU7Oiu+PFjvgecNQD9GznZNbE5RlDQ0EtUR2u+L0Tk93z9WFdVIulCS1jSBUt7VyiYtOKrHsEJOVMnbt7YGLQarKKEy5BH+R0QJsoAcU0ZaWqG9QuiXCVfpkfq4QQ8OuLQ5DJiIEnRlClXMaQu7b4diNfoWSaJLUA3Gfm8da+UvhAQlXYj74DgXQC9CLktTYtV+e/ULP0Jz5xUY8PfeZMEZgKA+Wj5S1ZVXifEh0LNysoaO/Vt1A/n3zQENFC7mRIivcJgrTob2a3ktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OFjmKSUUW/dMKzGpf0PH/Ksz/f+oUAWbqMkq461xT8=;
 b=oXHzP7DV9aFunYd6/5GY4bm5blFekWrqdpyoDxBYD1kEK+D7Cq4zxAPOuERya9tw+IAxw6gBnT5bEk1PVtiWk1STB48YWwenS6d0cw1HKnMNcym6QQw6VzrTg/9xhrqA2zPYYxZ+ikh0uMIgr8BAV05FeDqnl1yRygqAFHpYgRY=
Received: from PH8P220CA0031.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::14)
 by CH8PR12MB9837.namprd12.prod.outlook.com (2603:10b6:610:2b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:37:23 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:348:cafe::fb) by PH8P220CA0031.outlook.office365.com
 (2603:10b6:510:348::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:37:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:37:08 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 10 Nov 2025 07:37:07 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: [PATCH v20 02/22] cxl/port: Arrange for always synchronous endpoint attach
Date: Mon, 10 Nov 2025 15:36:37 +0000
Message-ID: <20251110153657.2706192-3-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CH8PR12MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: d806e97d-6b78-45dc-a8b1-08de206f0b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ub3yItoIJrqUNQO+KttFLqoD3/g2hBulSpqX3w+aXua9EXptAvi4dHRJgueY?=
 =?us-ascii?Q?y23sjb5LLWdZQhADZdg808TftNaNiRB8SeQxsM6BlTMewPO4sM9Yf3j576ZX?=
 =?us-ascii?Q?vL3KUTkYpb0iP58c8hnBo87j6nBAYzT1g7ADb3gBCIE8B1igEMq/NeRgberU?=
 =?us-ascii?Q?O4S0s6FRIcYaACQiUJLS2GB5Zv4ajdMakiz9o+gmOh644l7JphPdtJFya9Yn?=
 =?us-ascii?Q?gA6+mdiiI9dEJb43W6b6SqfSveZHgpddYmVtubwm0yhYnZ+w6IhWw4YwPasp?=
 =?us-ascii?Q?LzEVPApfe2kXpHGG9Qj+9XQukL08/IhegrZaEq/jIyx2cDGUujJzxBiJH0iH?=
 =?us-ascii?Q?jrB7Cr668on0NknwRotmUEFmTWiSJ/G8WRrFYTz5wJ399Z2pZPKK0kWls9nA?=
 =?us-ascii?Q?prhqKAeoL7NFty11wzamBxRrTMGcKY3kd4Q2rhBbqxRmR0bZgrDnQwK5H0ME?=
 =?us-ascii?Q?93QgrYzXxjf3GaCAhZ0LWMjdLMNFQHFbZkXqKYbIZDXS44vu84Ug3Fe+NcQx?=
 =?us-ascii?Q?YOE8xz8LsvT4LcpdUydSupHUwInU1LLqkbBBf8I8oljZ2KSDy+xPbtQuiUWs?=
 =?us-ascii?Q?sSgWOdxAbRsAGO5ERPU4qk1lpJ+QFlqFkFWbxe24ovdPpKukQIrpPzUQ82Cm?=
 =?us-ascii?Q?76UTuJcTZn07gT7FRjRW7lhX4vmhTMln4cu6YuotcqY8GATMfRV128fzN/b0?=
 =?us-ascii?Q?SaP+sjcj17OQB4x5KlZwobH7YTRRWyeK5Dz7LsOJd3aZbqTTntGYjomLqaSH?=
 =?us-ascii?Q?qXFiFBQNFeZxPHMVVffGeCKp5kQyMHjHLC+deiD6FvqJR0EoAGMmdRVE3Ehb?=
 =?us-ascii?Q?wwbj4vQrnmBeJ3ToU3DmY6dF3+KKPh+oaEMrLT/2f46/Z13jDqVg23kwGNYI?=
 =?us-ascii?Q?2+icqvkdnPgNqKg8jfpd9ttdhr21yDnoVVxIHze9xcJjMWWccmx6o4eOSsU/?=
 =?us-ascii?Q?a4Wr7SXWpAtglkToWNJPRBnBtXzjlQJMrXYLqaW36RpDazke+2AVrVMYAMZN?=
 =?us-ascii?Q?l9kRui5fu3pWTocWNjtsubJmYWbLFYS4yU5vIwzOEijXms1i2BUOE87cX7Ev?=
 =?us-ascii?Q?d4GQmOGvR7x4YtDHAHjOHTnDibnPNNfwKPSa/tdQVOYHdYJf2dzMnBb3Esj+?=
 =?us-ascii?Q?JTJk06bC+O9PchLPpBfdHi/x7jOz8pOxTKQIO/bY6nsEEZvn3l3AnBFjVEPg?=
 =?us-ascii?Q?BMOUV/GSmHHGRoOeCIFKQOvNoznIIvvFpv6qfitWM92ekVNgWsmh7Ecfh32c?=
 =?us-ascii?Q?jC0+iYcWslh+M9nMFX/li0j9n5lm7Yc2hSISneyPoyEO6euW41H5V3YhWcrq?=
 =?us-ascii?Q?QWp2rlwZsXHOcE3ftHySRsJycdHbc8DMzlbyegwRr/q+xtOZ/G8MnGoEzz/v?=
 =?us-ascii?Q?ctUifLFCTIskXuEq8K0x37lorQqs+xlkE6h8N1JJ/xoVhPJWpesvcjTWcft7?=
 =?us-ascii?Q?p6vPyc+dUNgq6ee1nVFw6IlHfHfroAVriLZCNXuEeJ9q2+qJ6chP9RseUYBI?=
 =?us-ascii?Q?JWEtHQyWtV915pYt4nWMPb7BFxGZqoRXAgefQOWzONeFzSokhLmGoDzjigQc?=
 =?us-ascii?Q?iK7UkO4ferHh+pWndWk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:37:23.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d806e97d-6b78-45dc-a8b1-08de206f0b56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9837

From: Dan Williams <dan.j.williams@intel.com>

Make it so that upon return from devm_cxl_add_endpoint() that
cxl_mem_probe() can assume that the endpoint has had a chance to complete
cxl_port_probe().

I.e. cxl_port module loading has completed prior to device registration.

MODULE_SOFTDEP() is not sufficient for this purpose, but a hard link-time
dependency is reliable.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c     | 38 --------------------------------------
 drivers/cxl/port.c    | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/private.h |  7 ++++++-
 3 files changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index fa5d901ee817..01a8e808196e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -46,44 +46,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-				 struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..ef65d983e1c8 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -6,6 +6,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "private.h"
 
 /**
  * DOC: cxl port
@@ -156,10 +157,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+				 struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+				     parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_endpoint, "CXL");
+
 static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
diff --git a/drivers/cxl/private.h b/drivers/cxl/private.h
index 50c2ac57afb5..f8d1ff64f534 100644
--- a/drivers/cxl/private.h
+++ b/drivers/cxl/private.h
@@ -1,10 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright(c) 2025 Intel Corporation. */
 
-/* Private interfaces betwen common drivers ("cxl_mem") and the cxl_core */
+/*
+ * Private interfaces betwen common drivers ("cxl_mem", "cxl_port") and
+ * the cxl_core.
+ */
 
 #ifndef __CXL_PRIVATE_H__
 #define __CXL_PRIVATE_H__
 struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds);
 int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd);
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
 #endif /* __CXL_PRIVATE_H__ */
-- 
2.34.1


