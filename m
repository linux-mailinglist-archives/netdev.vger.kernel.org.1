Return-Path: <netdev+bounces-126217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E99700D1
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB7B1F226D8
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282114D6E4;
	Sat,  7 Sep 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sKSTkFmZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE1814A605;
	Sat,  7 Sep 2024 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697184; cv=fail; b=qmB/tELY9dn6BUWQwO9yKTv6QTUiVy6xLjA838H3V4KO6Pt1xiuUkF1lXUQ1fPaJeBwVPVPe8knEUkGdpD6K8i2Wako2kk+tWUxk/JHFm0z2fk1HtUL9I/3sDvWm2EFlgnMYc34XYbUEd2N+YK1CTLKIW2STAWjkS2p5U2kp1ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697184; c=relaxed/simple;
	bh=fVN0fQTkBsu4Jovn/xn+BUwKJK5Hkdguvrz0FZno4NA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/K7WSG3bJy6/KW5Xrb7hvZvLygLmDPumIwu/uQlfJxqVpq5gxHrUuXkFU3uo3wH43VmuwIkODIkWlqNF/12dwaZy6WNlRocsA0XfNX4prc4+CcgRCJdGtIxA4nKx6Nme/h/3XIDyKtus6gWjM2u9uCPXYCX563JOXDCJ/pkkE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sKSTkFmZ; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh7CSzblKq+sI+dxAjktHkOoaNOB38wSaQ+hYARGOgiFOXW2OR32cYUWot7hyFTj3C1pkbz4aJLg0AhOtLxLp9Pmg2vFyp+3Whm+o/PJySUcfEgI/zbVkO1tB9l4QdFBkCvkoPB13kUr8bsjuYzdLgOzXc88wjQ4yOJFGx1yZMJpC1lYkSQPHLTuqgkM3NyxM/kmMwdPfdqJUKkemEbKNdGLzOjThajL+i1jlEV1wzFNA+BUQnQS3TFCMRfpMqrvmZhfh7qOs4SSwV+jwCHtnSUuLa3HvDKNlfLCTQUm+jZVdA2/zMv4TPMNGLaesmySjOUIA6NGiWkJuqTht74f6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2HXGPedV7Cu3m6/JEOlxvXT70qSaWc2eyE9bfvH+Jc=;
 b=YVhxNCDDE+25O7JppK6AOg37YfT9tfOL5SFe1+NfL/FR7zibTWiV2CmwQyqGJU06SJddEpRQ9b3QXrTAsQrKEGTofPavTT43aPbFqHlz5vpky3Q5fY+/CQMcEq0YfeyFT5aFNMwXOE5ucCjmZHO0L+wn1IHoTvFPUh4aEqdTz8QLVMDjf0MMurkmPkEDMsQejwWkFeKnfwyynzTX2IFNMOGn8SDQcrO3CaP6IGgSUKpgEOk+KbXoNBa713JBqlSqp5k9GDKUEhomVbE4SeqHWLEz3v47gK+rOwPARIdJrZ7odbtOyepiqd87OB3d2bRY3U+9MRWHZDAVRGWU5DhFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2HXGPedV7Cu3m6/JEOlxvXT70qSaWc2eyE9bfvH+Jc=;
 b=sKSTkFmZk8+f4OdcunLINiEWi4t+etPNBDO3YrnOWWchrjybmnNBXFjb+9QKXPzEmDAurusNGc9l88s2OjG2nqyft9QQ4ZRD3weDVfIEy2hIYRLSlon745VhjmXO++FOwYoebNYfZwZGoFscunDgew0bcXkEleWXhj6AF3IYNwo=
Received: from DS7PR03CA0122.namprd03.prod.outlook.com (2603:10b6:5:3b4::7) by
 PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.28; Sat, 7 Sep 2024 08:19:38 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::39) by DS7PR03CA0122.outlook.office365.com
 (2603:10b6:5:3b4::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.19 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:37 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:36 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 10/20] cxl: indicate probe deferral
Date: Sat, 7 Sep 2024 09:18:26 +0100
Message-ID: <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 352ee910-a6ed-4a7e-1d39-08dccf15d0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y/TSLmHNHkWvc5qyM60GoZMK5KLA+QeqqeuC9rpo3gRn7NWvfG48EKYB9jjd?=
 =?us-ascii?Q?VqS+KHsOJkfX9ITgQ6T6gMoFjvJSicV29lQkIouFuu8+cGyHCTNFmF9YONwQ?=
 =?us-ascii?Q?Wzk07/XT4yHw8SzWDZaW7OdBlZxtO69PXlIHyt6/1gZ26/NnUtEqGj+djTT4?=
 =?us-ascii?Q?Bh6VuN9W6ze8WLFCkFEzxoEx60psnUogFidhbNS20NpvWFdOS9M7vadPQVjG?=
 =?us-ascii?Q?Z2MWfXTuns7yHd9IhDnQZwkL3f6XrD0tfclqYv7QVyEuT2SxdS1P0d/n1Y8M?=
 =?us-ascii?Q?bLTlyzWsPvRCGXXPjcdlqhcGTISl4l41BHkWuSV5bxbDq6ZLrmeDiSdo/cVo?=
 =?us-ascii?Q?aESf6j4lZstNbvfOFE+jzPfX0E85m6p6+Dow3LHqrhTWQM/eeszEZ72K5RDD?=
 =?us-ascii?Q?716G3WANqK5iSKrWxqq0FqTMakgJHTr09BN+So1erHrDFG3evwwC5avJxwKp?=
 =?us-ascii?Q?Ht/HtW+1pqaXGLexGYVTmij63U84EecuPA4YYhw4lvripVAVgGzfwBWqHa8/?=
 =?us-ascii?Q?ff7l+TmCR+OoIKSuWlS9hDTt9p2sK2CPd+2korks1Y89OLrgrOYI4UNnjfcY?=
 =?us-ascii?Q?RgGWHTCCb0lMVkNrluDb6wDVlZ4vNn2STVZQTZGwmfS4ZNd7Ml7aJlL2Fa4K?=
 =?us-ascii?Q?760JQLcNC0pipin1WEGcpRimytkqGPJLUOg3B6k4QFE5S4dOOMlNDN85V+/2?=
 =?us-ascii?Q?xU2N9qInpLS5K82egnjaRgvh6xbcBxTaMF7RgUMrvOmWPG0BUgrEjisf2Rqi?=
 =?us-ascii?Q?CVjGFmmbz+fRdDYCZ+zqqDCktrm2e90AU1vhxkkbtbB9N8mRXfG1/aQsSanF?=
 =?us-ascii?Q?0CxDzg5XaYRLEuWNSV6u2PGz6VRVDe0nc1TjkBxm/0QZ8pamDzkSWnBtOGee?=
 =?us-ascii?Q?btTKxCCyXc/bwPqNh3yiSuu+TryUpkoUjavSLj4VIH0kj4QX0QU+01O8Okri?=
 =?us-ascii?Q?QhJ1G8dnB53GoT5WwxnfxiT9LkgwJsgs4tkJC0QBdonT6j0rRixY79LXTkO4?=
 =?us-ascii?Q?DcFxGyUdTHiEh5ugkATfnM7bgZM7/c7Xv0X/LQiveahZbZIZs4Q97Fw+/Gp5?=
 =?us-ascii?Q?QwLwA3xHggR0J2cMxNxAU6MB1SPgPX/ZB62lnCQnfFDgPI1pUCgD0mZ1VGZo?=
 =?us-ascii?Q?G76oSQt5TIiPrHPup8McjTsXvmCg+bMeI9ag3qMCwB2mSpjJOhpS59QL6gmi?=
 =?us-ascii?Q?xkXr3E2DJ5PpFAsZdy2lwxZ44xThYJBab1iNxJTPLUc+1mp5gyEsqRM6FIFC?=
 =?us-ascii?Q?N9/LSnvS2Qey2X5GHkHzcm3uhpKfGaNDUCm07nndA7p2Qm6yPyCa46oAg17d?=
 =?us-ascii?Q?zw2sIvVeG91/puqqycZTefYGDiQ6SlnckEHppGrTxAAvJAPysgvFphtwKjm1?=
 =?us-ascii?Q?UXPM/C2nhKnpauplN63vNqU1BRuaQy2t5aMJdXlOmKz1MzN6/euWkENkjE67?=
 =?us-ascii?Q?8nATZXSSGiPCGa5fIHHjPnKTInIerjg0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:38.3761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352ee910-a6ed-4a7e-1d39-08dccf15d0d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

From: Alejandro Lucero <alucerop@amd.com>

The first stop for a CXL accelerator driver that wants to establish new
CXL.mem regions is to register a 'struct cxl_memdev. That kicks off
cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
topology up to the root.

If the root driver has not attached yet the expectation is that the
driver waits until that link is established. The common cxl_pci_driver
has reason to keep the 'struct cxl_memdev' device attached to the bus
until the root driver attaches. An accelerator may want to instead defer
probing until CXL resources can be acquired.

Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
accelerator driver probing should be deferred vs failed. Provide that
indication via a new cxl_acquire_endpoint() API that can retrieve the
probe status of the memdev.

Based on https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c | 67 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c   |  2 +-
 drivers/cxl/mem.c         |  4 ++-
 include/linux/cxl/cxl.h   |  2 ++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 5f8418620b70..d4406cf3ed32 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -5,6 +5,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
 #include <linux/pci.h>
@@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 
+static unsigned short endpoint_ready_timeout = HZ;
+
 static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+/*
+ * Try to get a locked reference on a memdev's CXL port topology
+ * connection. Be careful to observe when cxl_mem_probe() has deposited
+ * a probe deferral awaiting the arrival of the CXL root driver.
+ */
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint;
+	unsigned long timeout;
+	int rc = -ENXIO;
+
+	/*
+	 * A memdev creation triggers ports creation through the kernel
+	 * device object model. An endpoint port could not be created yet
+	 * but coming. Wait here for a gentle space of time for ensuring
+	 * and endpoint port not there is due to some error and not because
+	 * the race described.
+	 *
+	 * Note this is a similar case this function is implemented for, but
+	 * instead of the race with the root port, this is against its own
+	 * endpoint port.
+	 */
+	timeout = jiffies + endpoint_ready_timeout;
+	do {
+		device_lock(&cxlmd->dev);
+		endpoint = cxlmd->endpoint;
+		if (endpoint)
+			break;
+		device_unlock(&cxlmd->dev);
+		if (msleep_interruptible(100)) {
+			device_lock(&cxlmd->dev);
+			break;
+		}
+	} while (!time_after(jiffies, timeout));
+
+	if (!endpoint)
+		goto err;
+
+	if (IS_ERR(endpoint)) {
+		rc = PTR_ERR(endpoint);
+		goto err;
+	}
+
+	device_lock(&endpoint->dev);
+	if (!endpoint->dev.driver)
+		goto err_endpoint;
+
+	return endpoint;
+
+err_endpoint:
+	device_unlock(&endpoint->dev);
+err:
+	device_unlock(&cxlmd->dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
+
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	device_unlock(&endpoint->dev);
+	device_unlock(&cxlmd->dev);
+}
+EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
+
 static void sanitize_teardown_notifier(void *data)
 {
 	struct cxl_memdev_state *mds = data;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 39b20ddd0296..ca2c993faa9c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 5c7ad230bccb..56fd7a100c2f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	rc = devm_cxl_enumerate_ports(cxlmd);
-	if (rc)
+	if (rc) {
+		cxlmd->endpoint = ERR_PTR(rc);
 		return rc;
+	}
 
 	parent_port = cxl_mem_find_port(cxlmd, &dport);
 	if (!parent_port) {
diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
index fc0859f841dc..7e4580fb8659 100644
--- a/include/linux/cxl/cxl.h
+++ b/include/linux/cxl/cxl.h
@@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
 void cxl_set_media_ready(struct cxl_dev_state *cxlds);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
+void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
 #endif
-- 
2.17.1


