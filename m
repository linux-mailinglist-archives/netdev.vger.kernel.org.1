Return-Path: <netdev+bounces-300512-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7vZLiYqNGqFQQYAu9opvQ
	(envelope-from <netdev+bounces-300512-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:25:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 354A46A1ED9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:25:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=per2JDEA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300512-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300512-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BC0307C968
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4713469FC;
	Thu, 18 Jun 2026 17:24:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010003.outbound.protection.outlook.com [40.93.198.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98942773DE;
	Thu, 18 Jun 2026 17:24:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803481; cv=fail; b=Dpeb6MK+8zIXEJoBuG0saSR7bbPKjEFGO/V4sM9tuP4QN+MmNGeuM2Gp+PuJyA8f9VI7o0mAI+quxhh8g7SRgV6NVfh/Nvfu+ZS0fheZjxGZxnETq6QtR++pe32JuDAEE92tqQqsz/sa9MxYNLcVmiN+DUV5gKn0saaxivki0nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803481; c=relaxed/simple;
	bh=EhQkg+2I7MAiQaPPIqr37F9M031cjiighDgM9UC59a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFop8B4XmLdpeav1BBts8sezV7jPJoNEnoGuR54myLtQGOs1UL9cJ5f/2FPbFR0Dc2YDT4x7QNO2d3vNztjuHVf/pe+teMCHRz9KinRVwcEtFmfyy3wGvR95WMwMXAOt0J+Y5yOUzsAh6YQ3/OGW/5HR0wkB4U0yCVjLppfHruk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=per2JDEA; arc=fail smtp.client-ip=40.93.198.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I3eVokceQIHxHVrWEeCry9noReUcZ2R4YtNhTV1YA6z/gsO3GCTw5WT/2Vf6YJ+SJQ4ghWZzZGAwi/W37P22MNOIH5Iv45VdFDvd+ywBS1Snx89UafdO8C2BhklwW97MEvmvVuLNASQ/vVX9h+9uSOrHfzqvUApr4zfL4WlKbLlYvTVKHWKYtj6b7fJrWQWuyNCRApcauSDufSqKQLPPMYRMtNVGoEWHCA7GewyZSOk5mYX9ujuwrsEnhl09CFJW4OjkbuuXN0KZ+BeV1x2+ByIrS0X+oVQZv0QF3hJooAZSYZxoqCkBziLUmi+HojMi1BNj7ds0pRra4SWVqUwI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qq0UIs6Jc0ukdtioM95v/dyeaQTFqR28tFRx1pFJDI=;
 b=PVyqALs1wkPJMVMTbizSwh3xPP9WLnB5TsUan3+u9Y/W7M07tjvHDZCblrK+xasVhGL7tA77sTdEDxFgI8PR/UcociyF4ryAM8bSOGG8Zv0jHiCmGo+u4KklivxktXbSuvdoA5ekPD02V1YzcdH0bUO3a5+BKYKrfjgz0UatGY5ipZgB12tg6ajUv11shjCpYAVSa4EVfiCjx51ln/+UtrpMhZz7S+OVvHzczWs+55egh6WJzMKARUKlmiP6YfIv4g1ruLAJDs8btKFTv+7ZbdJ0PpY2YNS/qFtJZsVxHQCqq5AxghJ8SaX7gGYyr8SbOaZ5+RoRFvdUfj6xEXPIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qq0UIs6Jc0ukdtioM95v/dyeaQTFqR28tFRx1pFJDI=;
 b=per2JDEAl+cps6cCOByM3ZqmXkm9hAorIGzvqt03U6CdfZd/kGNv1rb8u5bY9uWXA4dsQ8qHmnvxJay6n6mkAyMgRKdPLqnJR4/WtY1FG0C+DwWt1+5MhxYjma+ZXkgioRjvsj78dxYR55tgxjBC1HkxwsjUSIXibL/KGrAQLp4=
Received: from SJ0PR05CA0079.namprd05.prod.outlook.com (2603:10b6:a03:332::24)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 17:24:37 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::3) by SJ0PR05CA0079.outlook.office365.com
 (2603:10b6:a03:332::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 17:24:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 17:24:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 12:24:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 10:24:29 -0700
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Thu, 18 Jun 2026 12:24:28 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <djbw@kernel.org>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v28 4/5] sfc: obtain and map cxl range using devm_cxl_probe_mem
Date: Thu, 18 Jun 2026 19:18:05 +0100
Message-ID: <20260618181806.118745-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 597e4659-522f-4938-0978-08decd5e7902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	aximANro0vIB+vSOhM5oXcd7GF37dCqh9DT/m0bYEMWlIceSaJiMmlhXiWDBLSQKmkqujq0S0YGm6HNPbx5pWiWD5Hk2RhOOqCedkjnOD/JoBQukg0C4djbQjFHy5AxVNlsFJdnKkdPhsRDEzuTxGNFNMs/5YYhI+kar4qpkBwqIFTPQJ/421dBVBDWEyE/gqNaeDwr7s64+PPk5cMbzf0BVdyWkKX7ZbLuj7hihZdwg20XLJg3Ok6NSSfHZOrWGFjKTC5aLAefbZOuMWPfv+HLss4bwFSHsLGRODtXn61cNmEgZ5AmMGxvNV3+3i8f42xlQg+F9yfaLekIw9HcDzqCJU4df2oLjF/OdXL+Ds2QEOqoLvjtUXDsflVD5l5uf2bqbBKxa/nzwu3tQZ3I5IcWkvHwg7YPiaWgSEkrsaCduFWSvZcwTl/Fjt1f9Dr6n+j+79s/mCRqyzl0hdxpLqdu3HaViSHU2zibSanxFqK9q1MkLTN2EqYU63yYstagT1zJp7dwbVEUn45ClpLJFK5jssErqmo1yRfqLjND6nYlD0UkU6iQWNeASehNiRzcuEsxPvn96TwkN5loHBr+i/JmiGy6V4scEie7XNHUztofL/izUB2ev5JPNuM1EMgpf4XMed8WLDd8fr5w3lCVPXQ0xNjdX1iNCEQnQP6aVsAYEBL3o/JssKfkO9QjFetaEMwhQFBlWOLbKypFU4iupTHT4dEMHSGQUJtq+1Z2Fzxo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0daHRyZ3WIkIqJQk9iNagCD7gFG5IsC9gnCVySik38pjEfMg3w9RfZZFwNEHwjHXPKUnA5+Rfw5Or6gRYb2XR78GbfDUWOZntqU6FDg35mZO5TPo6GlEN3NtJfnTLux5r71E0IsLqi9uFPYKrqC8pdmNrCYS4sKbWxugxNkIM6z16ksQThtw23qJNHScwZcwAdXDtgZchflz4J/BN3CWHe5A0+PtUjIdwotVryNw7oAZeNZlHiTYukQns2RrgTBTB/UEzEH1NjS31QMUlMJQU/u5oFLXAg8Xqu7kEDPFcsNN1rA7RRuuCKRxkbbty1z+fbFmjpXB+deaHsL+2+D3LpyYwe0hNELeRz341ZthIQnU9I2lYuTOzm6N/kPMHujaTpe51XqCumImC3Aw2wE4hgeM0L9V2MXhktK7AFpvMJEGe8Xd3RUEwanZCEOYfdpE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 17:24:37.3211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597e4659-522f-4938-0978-08decd5e7902
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:dave.jiang@intel.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300512-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 354A46A1ED9

From: Alejandro Lucero <alucerop@amd.com>

Use core API for safely obtain the CXL range linked to an HDM committed
by the BIOS. Map such a range for being used as the ctpio buffer.

A potential user space action through sysfs unbinding or core cxl
modules remove will trigger sfc driver device detachment, with that case
not racing with this mapping as this is done during driver probe and
therefore protected with device lock against those user space actions.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/net/ethernet/sfc/efx.c     |  2 ++
 drivers/net/ethernet/sfc/efx_cxl.c | 23 +++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
index da008462096d..abfa0ce2b4d1 100644
--- a/drivers/net/ethernet/sfc/efx.c
+++ b/drivers/net/ethernet/sfc/efx.c
@@ -984,6 +984,7 @@ static void efx_pci_remove(struct pci_dev *pci_dev)
 	efx_fini_io(efx);
 
 	probe_data = container_of(efx, struct efx_probe_data, efx);
+	efx_cxl_exit(probe_data);
 
 	pci_dbg(efx->pci_dev, "shutdown successful\n");
 
@@ -1244,6 +1245,7 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
  fail3:
 	efx_fini_io(efx);
  fail2:
+	efx_cxl_exit(probe_data);
 	efx_fini_struct(efx);
  fail1:
 	WARN_ON(rc > 0);
diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
index 18b535b3ea40..3e7c950f83e9 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.c
+++ b/drivers/net/ethernet/sfc/efx_cxl.c
@@ -18,6 +18,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 {
 	struct efx_nic *efx = &probe_data->efx;
 	struct pci_dev *pci_dev = efx->pci_dev;
+	struct range cxl_pio_range;
 	struct efx_cxl *cxl;
 	u16 dvsec;
 	int rc;
@@ -73,9 +74,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
 		return -ENODEV;
 	}
 
+	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
+	if (IS_ERR(cxl->cxlmd)) {
+		pci_err(pci_dev, "CXL accel memdev creation failed\n");
+		return PTR_ERR(cxl->cxlmd);
+	}
+
+	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
+				    range_len(&cxl_pio_range));
+	if (!cxl->ctpio_cxl) {
+		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
+			&cxl_pio_range);
+		return -ENOMEM;
+	}
+
 	probe_data->cxl = cxl;
 
 	return 0;
 }
 
+void efx_cxl_exit(struct efx_probe_data *probe_data)
+{
+	if (!probe_data->cxl)
+		return;
+
+	iounmap(probe_data->cxl->ctpio_cxl);
+}
+
 MODULE_IMPORT_NS("CXL");
diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
index 04e46278464d..3e2705cb063f 100644
--- a/drivers/net/ethernet/sfc/efx_cxl.h
+++ b/drivers/net/ethernet/sfc/efx_cxl.h
@@ -20,10 +20,13 @@ struct efx_probe_data;
 struct efx_cxl {
 	struct cxl_dev_state cxlds;
 	struct cxl_memdev *cxlmd;
+	void __iomem *ctpio_cxl;
 };
 
 int efx_cxl_init(struct efx_probe_data *probe_data);
+void efx_cxl_exit(struct efx_probe_data *probe_data);
 #else
 static inline int efx_cxl_init(struct efx_probe_data *probe_data) { return 0; }
+static inline void efx_cxl_exit(struct efx_probe_data *probe_data) {}
 #endif
 #endif
-- 
2.34.1


