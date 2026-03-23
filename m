Return-Path: <netdev+bounces-270481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZ+DBYnwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:42:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC42F159B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48818304E31F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF429D267;
	Mon, 23 Mar 2026 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Em9ZDBmw"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8A3264EF;
	Mon, 23 Mar 2026 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265495; cv=fail; b=AZlXyA48ByatgtFz1Kxe1yoq9Zng4tnA2M4Ww88rh8vr3ls2i51neQKQPjDn7GrV89XBIEtJPoFunOd9b1EuiUWbGPpq0uAKFlOIxPncCQX+/5TtQEIcK1j2KVzkpWagaxfX5zqVLmeVgR7I9x7QNXUW931Je4FGHSpIsws6C2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265495; c=relaxed/simple;
	bh=8zlaaxleZ9lN1jqlxU7BMpdcvv2/ZfwJ9Ei+FfmvLDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGQ+nw9jcylsCffxmNmLaN1lQ/vzqIm4XvouDbX2HQ/3kb1EE9O7cPGKmQDkkS2aaUeV1RnMdJ6yOp0sXodaJ5+wVWbAH5LYx/Q4CvGdRMgYAYqvBPoLu6GFvBuC7tGhkO5aOJ8hBKdqjNQNJsjtz4+rU+zUQl420afq/P7JJUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Em9ZDBmw; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y702oGW86pqFA3eZOltZ3EzRJl612m2i9klz1qyYmVTHi0l9m6lr+UJgugfxLBJtnFV29tDHqkzDxeuDn+4Ov6YkgyD4v4Mtkvo+qJwoFRvpVvfNmlKyHwJuG7Lb5TfcPZXxpHeZjM9DrrB6qegJZEzWFuh4lnbYCexjA64sN4MfDTPLRldtMkGTOOb3l3jf7giT69BxIBbVxNmCoU5j/DhehDQtbYDJClbHcvWZsOSJcDten4g7ms7/N0DDJRE0hK4bkOTHpkmeFaWWs+PF8erbi/x59iuth3TV9lJkUvvWGh1QE6bO/zJNr4ij8I3JaS1HKOzfx8Kx35+7aAtyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS6vtPKo2bcQylNBkiw3OedpmMyujlqBvLVAAmpz6WU=;
 b=QYdfywDrJH2rjyYu5shb7kUPU7Eg6RC4rd0KKQDC4NKpN83+zuXJg9+2N7N9wv7VI5eh+KnIEiOdK3fZ31MU4eOqcjVsH5p91ylgChaB+HcNt9fDIqitpx7U9eZ5klkMf4Z4rWqZuZKecwzWphp4BDEdwWJYB/no6/D8LSNjg7s6gCxbpyBaZORbjg+ZE47DLbImLIuWwEafEpQ8kg62W51M1fcHzy2DHVUlS3KSFy7S0rUOqgoz4oklhg59fAmoc/1mIkNXjho3fqtphCa00sIkRqMt39NWwDbx/e+BzJBG+HLwAK/03TcfrTTxJsmJzhIA6mCCbuuRo3XsuNlkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS6vtPKo2bcQylNBkiw3OedpmMyujlqBvLVAAmpz6WU=;
 b=Em9ZDBmwnetSMS/KzBGCRbtkikrul0+E9eUfN2wFFbHWpO/wBu9nUvfJGjO4en8M4HYdSdEebLJc2gVgNEfow1guqcsA2B+LdzlmssNp/3vLk73V2Ezj02X337OXO/Hck0CpXRMPDPImu4kfkhO6HKknrecjE0PXa49JKY8ZxW0=
Received: from BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:31:28 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::7d) by BYAPR07CA0083.outlook.office365.com
 (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:31:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:31:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:27 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:25 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>
Subject: [PATCH v24 01/11] sfc: add cxl support
Date: Mon, 23 Mar 2026 11:31:07 +0000
Message-ID: <20260323113117.2352709-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 36aff8f2-e497-4b5f-6c1b-08de88cfb90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NoJ8iqdXsYIgYefkty1k5j/r35GKYigE+UQ6DLkNBudzJu8NbmimFebvZCJf9z1ndCIiKFxpOhdIz1qnbTekSuRud/P5AVQTrRqLH4I2NNC7U0kYo7gIxfZ/xIkySeaK55SQHUhRJLnzazlzsnczk0f49lDbCh5pJg8al+Dm+nDbQcHvEnVqaeXBmCmJQw5L5bV5C24w7P6/kXl98NabweytRtl+wEvUFXYN9iK7MrANSHhE3UprnYoVAlawAcuxQeCmJ0jRKYFrbddtrI8UO2n7xQqWApBjH6ZKY/vdEbPwJjPbko3gsqj+j6pyzbj2XIrR8vu/2XZjjTtT/YKyjzRgtME5weaw3hmplfLmIIZLHNf4q7LWvL+9POOMWsje9W6Cngceoo0bT1YnS+9UqO4wsmKO/WGLqagp3WOJkDEfpGN/2aGrX+M0xEWRPI2uV2nu+goFT8/PdxcdGcrhuXFs3li8lfDe9v3rRImC60oG1XQKuLciLgoK6O8rXgCSZS7iEIp10a9QrhvT1loqLDoj6SqCAg3k/DNCDDqUO7eex07aBkKfUCzGSJHu0QBLiqsh6pz9A1Z5/lOVO3XepizlkMmJY0lwDSU+Z+Mf8MRZHCQTbMZ7iA3YoxnbnA7MSXGt+HRD810nRulWeMEu9GkN62AsjntcS2rtgHijQQBFnrhGtpRNCe//kS4rZ/w/UlZ0wublu07g0N83Gw5lzlGDO8Omvdc0wEs2D15QTJpyyQknup65Ki7PGq9GTWah3ulMTJBTf1YN+uOfh+8cKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c61LbyYeuMnrmPxc8nOvDzU9t+AeUby/kbClVVGkNFJiU0xG/jbXMUjUrTyhmTaWH21U3/YReI2/I/k6QjdCgOWFdIpsSBH3o6saRMGmAJrmkEy6nmHOVNGjRwSJ4lQ6e0CSUd84xUmQCOks/yljjcmICQfZIWZk3M+vJ+SyXlCpyPiJvHPj9e8NP2Pl+SmLoYq406gWW5ItKiE1klYdKxYGh0fIwgakavxZhM6iDMvk4XVdn+9xP0Kq+vwLNI5VGXMLfvQSgYgmu+KoDkNU8E3Xdnn3ywJ22FXG9+dmQ+xBFmBMrz25AjR3KBXbRWnG73i58NZq30mRgRkdCKLwdlyMwsrRtHSawCA0qxLVla4DQIyN8q3rWeEf8jA/HJMEK7PdSrUa6WsUzt0HZiwnBoqWTWon4HhRflUIFemrmF9V5ov/ymc3bDnm2zczDOcH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:31:27.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36aff8f2-e497-4b5f-6c1b-08de88cfb90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270481-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8ACC42F159B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

Add CXL initialization based on new CXL API for accel drivers and make
it dependent on kernel CXL configuration.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Edward Cree <ecree.xilinx@gmail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/net/ethernet/sfc/Kconfig      |  9 +++++
 drivers/net/ethernet/sfc/Makefile     |  1 +
 drivers/net/ethernet/sfc/efx.c        | 15 ++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 56 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h | 10 +++++
 6 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h

diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
index c4c43434f314..979f2801e2a8 100644
--- a/drivers/net/ethernet/sfc/Kconfig
+++ b/drivers/net/ethernet/sfc/Kconfig
@@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
 	  Driver-Interface) commands and responses, allowing debugging of
 	  driver/firmware interaction.  The tracing is actually enabled by
 	  a sysfs file 'mcdi_logging' under the PCI device.
+config SFC_CXL
+	bool "Solarflare SFC9100-family CXL support"
+	depends on SFC && CXL_BUS >= SFC
+	default SFC
+	help
+	  This enables SFC CXL support if the kernel is configuring CXL for
+	  using CTPIO with CXL.mem. The SFC device with CXL support and
+	  with a CXL-aware firmware can be used for minimizing latencies
+	  when sending through CTPIO.
 
 source "drivers/net/ethernet/sfc/falcon/Kconfig"
 source "drivers/net/ethernet/sfc/siena/Kconfig"
diff --git a/drivers/net/ethernet/sfc/Makefile b/drivers/net/ethernet/sfc/Makefile
index d99039ec468d..bb0f1891cde6 100644
--- a/drivers/net/ethernet/sfc/Makefile
+++ b/drivers/net/ethernet/sfc/Makefile
@@ -13,6 +13,7 @@ sfc-$(CONFIG_SFC_SRIOV)	+= sriov.o ef10_sriov.o ef100_sriov.o ef100_rep.o \
                            mae.o tc.o tc_bindings.o tc_counters.o \
                            tc_encap_actions.o tc_conntrack.o
 
+sfc-$(CONFIG_SFC_CXL)	+= efx_cxl.o
 obj-$(CONFIG_SFC)	+= sfc.o
 
 obj-$(CONFIG_SFC_FALCON) += falcon/
diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index 8f136a11d396..c1e6e31f07cf 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -981,12 +982,15 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1190,6 +1194,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support, or initialization
+	 * fails, efx_cxl_pio_initialised will be false and legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc)
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..8e0481d8dced
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/****************************************************************************
+ *
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/pci.h>
+
+#include "net_driver.h"
+#include "efx_cxl.h"
+
+#define EFX_CTPIO_BUFFER_SIZE	SZ_256M
+
+int efx_cxl_init(struct efx_probe_data *probe_data)
+{
+	struct efx_nic *efx = &probe_data->efx;
+	struct pci_dev *pci_dev = efx->pci_dev;
+	struct efx_cxl *cxl;
+	u16 dvsec;
+
+	probe_data->cxl_pio_initialised = false;
+
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_err(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_dev->dev.id, dvsec, struct efx_cxl,
+					cxlds, false);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..961639cef692
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/****************************************************************************
+ * Driver for AMD network controllers and boards
+ * Copyright (C) 2025, Advanced Micro Devices, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation, incorporated herein by reference.
+ */
+
+#ifndef EFX_CXL_H
+#define EFX_CXL_H
+
+#ifdef CONFIG_SFC_CXL
+
+#include <cxl/cxl.h>
+
+struct cxl_root_decoder;
+struct cxl_port;
+struct cxl_endpoint_decoder;
+struct cxl_region;
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct cxl_root_decoder *cxlrd;
+	struct cxl_port *endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_region *efx_region;
+	void __iomem *ctpio_cxl;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
+#else
+static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..3964b2c56609 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,24 @@ struct efx_nic {
 	atomic_t n_rx_noskb_drops;
 };
 
+#ifdef CONFIG_SFC_CXL
+struct efx_cxl;
+#endif
+
 /**
  * struct efx_probe_data - State after hardware probe
  * @pci_dev: The PCI device
  * @efx: Efx NIC details
+ * @cxl: details of related cxl objects
+ * @cxl_pio_initialised: cxl initialization outcome.
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+	bool cxl_pio_initialised;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1


