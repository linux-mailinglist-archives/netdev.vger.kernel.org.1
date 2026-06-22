Return-Path: <netdev+bounces-301102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vvacA0ktOWrunwcAu9opvQ
	(envelope-from <netdev+bounces-301102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C31916AF7FC
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:40:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=tXq+D8SD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301102-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1BD73011054
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE62379989;
	Mon, 22 Jun 2026 12:40:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011011.outbound.protection.outlook.com [52.101.62.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9C3998B7;
	Mon, 22 Jun 2026 12:40:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132033; cv=fail; b=Ot3opQN6kXfRL69SM+XAoa5Bi/R7GQOZz8Gc1XbV///lPohswPqS2Fkszk6rQv3XNlcjT6K/NFGifzXSPA6km+8EVTcZS2QQoViavR1ALrww1F6UgN58AMKJ8Qoyxxc0Oh1KpreetZtODWtfDw0gD2r5x/pk3GKFeVBwbmsAivI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132033; c=relaxed/simple;
	bh=N+ca66rZ/KYXLyKJ3hL6IX8BAV1g4ETY4wr3SM0LyCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t059jsMXy4Qfgn3dQMmBf9aHlLGMESjI74TYkAX8KPdhEb23aSbi1zdakuP23cGD8OCZLkyijs6iRjMDQ/bAorrqgcZ7uW9dbYB0yWLN3QbNgr+s4p6skyvtM3aX8NJCS9VfRHv/GsX2BJfvHU3qjcRh8zLm7doc1gpgJkIVG3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tXq+D8SD; arc=fail smtp.client-ip=52.101.62.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u98OhD2/x/dDBtysngzmHLPDB4eDKaIbyfcamhPyer/pH/jGEf65Cdigc2LmpGKVQ9tpf8vEYkrDndqeYy79wAOb0HcT9rkGe6z+3g9ZktoGHGJ7czwxmJ21DLfRplOPC+IQ9msZQ5Dc+vPr/fQduRtSnU3jq5dBksNOeuoQgS/bsTTfmXFBWsFS/bLnMTyUxJjUDpsMqzClTPuZ2V/myRIQSeyEgLp9TEu9fGy80R4XSOL2SzOq/FhCX0Bm+CvWR/aKglEHuGtIjJWieBfrW1OzZhbAWP5rxvLzahNYBDJb6hbaavIVWDAuCnAFHmgkUpGpISNdGJqwAhUFLnU1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1ZLHU8m0h44grUKMgjFJwMkOpP+EMlxdl8q4iIExfY=;
 b=WGLmjECumj/ASKgVbKqrlt9lyZnPxBRwyc55AqZQotien790IUmY+w5CI34KlehhkUpBOQJf2PXOXr+5P7sWgAnuAMt1VTlqgfFTIbm4Hm6qqhpoDDB3ujslAF7N6+Y4nap0qOT9LrbfhnNoI5VNBtauD4+sj77Yi0YjW1NDKTSSG4EPpfzzDDg610d4Y0Sw//6qRhyh1GloFwARYTWrSVtx77K9nd7hjBJjKW5Fb89hEWqywF1JpcMJ2YeLRMHOa3Iy05bfvirEJW03H3NthSCfLJrfF8UxEUznAGchwrLegeGK33fOWV4eGX6ZOBn1ypu3rtQU/s3xmOMX3kBhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1ZLHU8m0h44grUKMgjFJwMkOpP+EMlxdl8q4iIExfY=;
 b=tXq+D8SDxw2O6d4UQu8N8a6OCfBIP1IEHp3WaBtzyAuXVkud2wU3h8wR5C7P6D0bW5n9sR4JwEzmDsQmnsYV/Lo9hTob+9HMhOjwRJZIjZswT+2rq7QyDwUd/u5CdGh/pMhdojGtw6/cQoBKo68xfeFkvBnzXshhfy6Gh+mJTnY=
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 12:40:26 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::91) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.19 via Frontend Transport; Mon,
 22 Jun 2026 12:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 22 Jun 2026 12:40:26 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 22 Jun
 2026 07:40:25 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Mon, 22 Jun 2026 07:40:23 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Edward Cree <ecree.xilinx@gmail.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: [PATCH v29 1/5] sfc: add cxl support
Date: Mon, 22 Jun 2026 13:40:06 +0100
Message-ID: <20260622124010.2192888-2-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
References: <20260622124010.2192888-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d96b37-a6e1-47bd-dc20-08ded05b6f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700016|1800799024|23010399003|6133799003|11063799006|3023799007|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	byHKzkVeBAukzFGZIqwdCoR02WGNb+gKM0Nv9bEMYNnFnci6m1EDHoGO9UXzJxzT4lV42AQOyZtr/302k+3R2l/CjwCMkCi83nUCZKAjIVKDdHLHxSDj6X4KNWAEpRcpho3vbztFiATaaIEKQfD5CeNcCk2p6BuBay9YaIT/SJxwxjifEigPMJYxBRfUblkjZu9PepXwPElhYqL2BMr+updxEJRCZSoKMYODpUYJOXRu3Ne4hXQIlP2XesBFF6Tue4HcBd0OCTR6wDF/TA9S5yMQRLICo6jBZd3txZHt0rzAQacPbCSSqANblFe28WL+Ftx8zVxi2DVFOEpGlWaRccE81mfbp8yC4lAVu6SwMW86mhsAjXEBY6mNngENjpBYGNAFLORa8zTPjqhzYzOquHQvbQXKPCm6KoBWo9cGA3xrK03aW+D/eHHFWB7ar6mMHcXiJ1SKBnkj2dM8qJQXT6KlkOxgEuBSHfyvc2kaVuXMdhu2Sxx02zaoOUynyWqNHLnKZxhotoZlCMFLS2NNcQYINLnHTTcqRyOIfvudbhFiFKJrc/eWKx302WN/w4BC7FnmxKA+4fwCk/GppUpjh6tAaW5/N1IgmUK3uonB9ZJnnpn7jk10KFXBRPFIosXwZUe0lMJIDbCENz1tor8e+p1RApZ6n+rwIufpsUFKj2Rbu/8FWk0i12zH7DDFZ45z1YwQ3ZHzLo/ba5O7ZhSxLA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700016)(1800799024)(23010399003)(6133799003)(11063799006)(3023799007)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ro8YUwyA4fqdh4GkSXO+DEML6zjrB7UKSfsxxgaS6Lk4oLbWi8zzwKcc1y6uEPW8inXfMyKWnYM3BbFt/h2HAAJJlKcXY+2MeFR/Me/lZezZtfQ/p1AQd1UDPc0hWVFiKB7NW569g/sxRx4WkTIjttrAryZVjvov/m2ene/A/Nu09Y3ckbVoLOGiKRehRH/6jNLRRZAdOSkWkqbXVZ22oRhvcz3LAHZt47g9S7Wtyv1VLvrPEYmZKyYNorBfYy17TDhN21ubPyPaludAA4HpFtPupfnecL/zUrIuORaWHzjryEHDqlzYpEmvFLaGtPSWODO9JoOjoewbtHjkRkwt/cq2CoLxYqQUWIOeH1gDCXwrLnKmD2Cojn7PRuYFz0qlCCjBWtEAIh5HXHezQZHAbv0l3guiQT85JyWbhKkmzpdOanb4YKP3qoCz8rIbeQoM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 12:40:26.1981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d96b37-a6e1-47bd-dc20-08ded05b6f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:dan.j.williams@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,m:Jonathan.Cameron@huawei.com,m:ecree.xilinx@gmail.com,m:alison.schofield@intel.com,m:dan.j.williams@intel.com,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,huawei.com,gmail.com,intel.com];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,huawei.com:email,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C31916AF7FC

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
 drivers/net/ethernet/sfc/efx.c        | 16 ++++++++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 50 +++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    | 29 ++++++++++++++++
 drivers/net/ethernet/sfc/net_driver.h |  8 +++++
 6 files changed, 112 insertions(+), 1 deletion(-)
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
index 8f136a11d396..61cbb6cfc360 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -34,6 +34,7 @@
 #include "selftest.h"
 #include "sriov.h"
 #include "efx_devlink.h"
+#include "efx_cxl.h"
 
 #include "mcdi_port_common.h"
 #include "mcdi_pcol.h"
@@ -981,12 +982,14 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_pci_remove_main(efx);
 
 	efx_fini_io(efx);
+
+	probe_data = container_of(efx, struct efx_probe_data, efx);
+
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
 	efx_fini_devlink_and_unlock(efx);
 	efx_fini_struct(efx);
 	free_netdev(efx->net_dev);
-	probe_data = container_of(efx, struct efx_probe_data, efx);
 	kfree(probe_data);
 };
 
@@ -1190,6 +1193,17 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto fail2;
 
+	/* A successful cxl initialization implies a CXL region created to be
+	 * used for PIO buffers. If there is no CXL support legacy PIO buffers
+	 * defined at specific PCI BAR regions will be used. If there is CXL
+	 * support and the cxl initialization fails, the driver probe fails.
+	 */
+	rc = efx_cxl_init(probe_data);
+	if (rc) {
+		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
+		goto fail3;
+	}
+
 	rc = efx_pci_probe_post_io(efx);
 	if (rc) {
 		/* On failure, retry once immediately.
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
new file mode 100644
index 000000000000..be252af972ab
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -0,0 +1,50 @@
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
+	/* Is the device configured with and using CXL? */
+	if (!pcie_is_cxl(pci_dev))
+		return 0;
+
+	dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec) {
+		pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
+		return 0;
+	}
+
+	pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
+
+	/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
+	 * specifying no mbox available.
+	 */
+	cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
+					pci_get_dsn(pci_dev), dvsec,
+					struct efx_cxl, cxlds, false);
+
+	if (!cxl)
+		return -ENOMEM;
+
+	probe_data->cxl = cxl;
+
+	return 0;
+}
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
new file mode 100644
index 000000000000..04e46278464d
--- /dev/null
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -0,0 +1,29 @@
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
+struct efx_probe_data;
+
+struct efx_cxl {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+};
+
+int efx_cxl_init(struct efx_probe_data *probe_data);
+#else
+static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+#endif
+#endif
diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
index b98c259f672d..563e6a6e85f1 100644
--- a/drivers/net/ethernet/sfc/net_driver.h
+++ b/drivers/net/ethernet/sfc/net_driver.h
@@ -1197,14 +1197,22 @@ struct efx_nic {
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
  */
 struct efx_probe_data {
 	struct pci_dev *pci_dev;
 	struct efx_nic efx;
+#ifdef CONFIG_SFC_CXL
+	struct efx_cxl *cxl;
+#endif
 };
 
 static inline struct efx_nic *efx_netdev_priv(struct net_device *dev)
-- 
2.34.1


