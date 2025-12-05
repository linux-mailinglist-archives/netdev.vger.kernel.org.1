Return-Path: <netdev+bounces-243792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79216CA7F0B
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 15:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B72325637B
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 11:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCAB33030F;
	Fri,  5 Dec 2025 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SbRWv0Ha"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010009.outbound.protection.outlook.com [52.101.85.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792D2C08CC;
	Fri,  5 Dec 2025 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764935606; cv=fail; b=lfkBTQeIjExbCO9QyTJCkvUKBm1jD6dAEq4unKcqxNqU38v4cmlNOiQ0y4tOgXJcnLdB2EhtwN+nSUbAOItyG1Ime425StGXwHv8k8Xv63142I/cgXXOnZZJjbnpU0cJqirPMVd7Oo7pyyGnBplEJaomPhjDOn8eQxoi2bpuWtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764935606; c=relaxed/simple;
	bh=QZ7OAxk7P4tNa6Dg/4v0fJsE4bpNS6r+1wg5rspswvg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOPu9DhJSaf3E0WgavB8gaopBL4/nH/eOC067xSlhplFS+oZJ5jwmEybfaWlI1X81q1Bt6DA9kyn3yKxXfbP5zGaKU8Ft/qtigM7lyfMtbJWyZFvrVf2SXTYMacTTxZxTAlVgtHdxl40JIm+SZpxwCwegV2f4Z0ar/lHjs6a8l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SbRWv0Ha; arc=fail smtp.client-ip=52.101.85.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlGdhxU6IT62ER3OFIHRk+VMSkU11FfD8zI3IJbwQUjFbsK51SnwCcm7k6vZh/tLe1zbwSoc3lO6yrUVdgaNP/1+ocdBlqkhQmhXr3wJf7ItbKETRwDI52BcASR01NDakvGTE8YMQwn6PahPbeXLtR4/Ik9iCnaVFGe44lzngMn1vsNegmN0dm2ZmOSluRB8owTiBCzwQ3SYSgkJjbsFLfe7p3aPV9fSLC4VdKAKc83ootqtbT55BOBwcUkSJci32ZnsHXwWq/gksA0xef+gKwPZDBLhy3+ZCTNxv/PLJ0tw2sIy6w/fm0Y8hKVnty2/ps7CPJdpn0kPH7Sw6TsFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53ir4bEVSTMkJgJrabne/4fBuYe/aB+gIGck8WeLY9c=;
 b=H+AZSkp65zVqLWrFcuuW8aHPooARJuuBn1xdWDmTmHydv57BW3OOBqs2VjDxDXIPqAXQgQ6x4HDOOLDXcZHBEXjyzyhh2zCGesbpeyAcE1HOLSPEyNSA5MWQwWnk7BTm6tQ4TtpKLkNgFcjW4sDW9+4R9jtNU45kgoH8FQYCCufDyYNC4l4cDqgqN5R+fA3VuYgz/HrfGFPkjtgeMuTNeCtkxToCYJOYNWZcklF2R8On61dy2hrIyf4hlTKiS0dnHyUOQ0ENYtSa9Ro7qpa7NObI5YphJQ5+exc0bFUjoZcs78nv+NYPzhNe27KmS99duXesNAlgdmxr2Yw6WvingQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53ir4bEVSTMkJgJrabne/4fBuYe/aB+gIGck8WeLY9c=;
 b=SbRWv0HaB0hEOp7Fk1BWSJ8kko1An/WtTnd3ah1PVXEiVgCd7KTQzn1UdzvQcWRvAVozjGUifUuvGzW3/tUIKdblRgQBtM6ZZA7aVNtKzBtmzQEjX2Hcw1Mp+MZAuNRYhA+CnCZmIijDc2QFfvA814LrVo90dpI67tK5NHX/2hs=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by SN7PR12MB8770.namprd12.prod.outlook.com (2603:10b6:806:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 11:53:15 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::9f) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 11:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 11:53:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 5 Dec
 2025 05:53:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 5 Dec
 2025 05:53:13 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 5 Dec 2025 03:53:13 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v22 11/25]  cxl/hdm: Add support for getting region from committed decoder
Date: Fri, 5 Dec 2025 11:52:34 +0000
Message-ID: <20251205115248.772945-12-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SN7PR12MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a1927c-6402-4c3b-61b2-08de33f4dfad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FWFurab6VKYRJxmgwaZcGUOwaQIccUvRcxLu9IDkDPUw2bU8ycSX3oEZvW5n?=
 =?us-ascii?Q?JFssdjPFQT2aKuxSfhEc+s1pXd+pedTs3hODuA9ckqdaiWzCidvojkkB0z3+?=
 =?us-ascii?Q?KS89f3Oa2jX7Y3ZiU+COTGNIwsKmKrZ00Xcr+gZob+wLI1Ew2k9eEq8OHY82?=
 =?us-ascii?Q?1wy5KplhEhoT/0Pd7LJI6r/Jdgxpcm5Vi6Iqzhg44C+AZx0Ahq9OouJ9s9Q9?=
 =?us-ascii?Q?mJdiSZEuAfyMP3lczZ1dVpS+MVZlWxUOjNiaKFUEasVSHTxao/o8tQGsKvD4?=
 =?us-ascii?Q?eL1cmjQmQ8+zd6M9Fuj2hUO74a2s4WkRYcTTV8aiGl8fI7+7NV6QEB5kuCaV?=
 =?us-ascii?Q?FvCV/J7TBioALQhYpOQpth8A24AWWJRdWVlAEaX3Nn2Wd65KYTdKnfbs8ion?=
 =?us-ascii?Q?SkFXBH5m0d3HETliA8x7iLtL52wbuqZ/+PWPOn74rXPuYq6wIo97hgwDtfxj?=
 =?us-ascii?Q?qGZqrZnPE2lY0SYow5SdyzM7H/YYgEivu3v3UnLHBLVzX9zbDC3MujBlokT2?=
 =?us-ascii?Q?4u7G6ip66Cgj41LA4cUaWqxBUqqL3CO5JuI4P106Y+KtXL/+uU91RFyUooZC?=
 =?us-ascii?Q?nn/NGQ4+w/YluhYpKFeLQ/xn19OwG+skU5eDDKkNY7I8jzsqeLAg5Emx3Chc?=
 =?us-ascii?Q?Vb/VUrJeLmca6IcOgG30yEcNPQCKxpW+Oi/zjGjm5sYeTgYLQjzf87YO3aAI?=
 =?us-ascii?Q?ti3+QBUueAHAdV5DVrsxBlNW5oGOP4LBE2MUfmQTkQ4yhnegRmoOjdAmV6eA?=
 =?us-ascii?Q?lSDujY/4BxdsL4EXMXP3CMyOKTJakFOHNJ9oq5nywx6wqtF4WQnXupt4TBow?=
 =?us-ascii?Q?X5/rZA/aSXnKrQSCJF5ev4Iu6+IdY8fgpdKpI8w26hGPTo1qicuVNLbgGijU?=
 =?us-ascii?Q?0+c5/eT7fJ6rPNRViXdyS5zl0JImYo/c7xnQOvgbM8z4+qBBtKF1iaLd/v0O?=
 =?us-ascii?Q?zrHmfmG0lJUSk8hz1I0HSH3A9DAr0OL2BrVtk6QO4hwkp1qbbZCr0/KCw4oa?=
 =?us-ascii?Q?YbG83mfeM6XBgmDe55Fa+JIYKsccj4ENXtphqAV8P1ZLA0nUThtP531hI8Wj?=
 =?us-ascii?Q?JtUxR2oSOPx9EOrzm4VxpaGezYqzqd9i3n+XRyK2GSBlKtEG9U1Cr/EjOUBd?=
 =?us-ascii?Q?kXOPg288MAmcMX9iIk5amO7YfP0611ZZzG6WP9CSZkDw1jcxwwdB0uhhTDyk?=
 =?us-ascii?Q?2wSC/wZ/0lWi3vpqtryTA5I0P1+KWuIlUecD72kCYXoIdki4sxssBiwBA6aE?=
 =?us-ascii?Q?i7OO1zScPw66lSuwiyNhVxklAo1vPqbnsvvnDuoDKZ4j157FZ5dz2nqEKpUG?=
 =?us-ascii?Q?JLTqm9r9VJ4etJiZAzMTNexdh3jhFDOXKvq4fOoqf86+WD9WvoqGLiqR8w7t?=
 =?us-ascii?Q?KbTjgYyGb/iYGLThTOdhOxydRcQfdMTOLtJbWtnoeQPr3qZrVCKlG9AS5HBv?=
 =?us-ascii?Q?EOgctG3Cr2nOKG4rLhGw/AfFmpL8MYyNuGeq586Zl1eHV2OLR6T2qX8AkRw2?=
 =?us-ascii?Q?FvTSS5MONEEYHr1enhlWx+7BNisRNRbCsvOLju333IgUFK/HcBcXAQkTBSUI?=
 =?us-ascii?Q?g7H3Zu/RQAKa3zBbZS4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 11:53:14.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a1927c-6402-4c3b-61b2-08de33f4dfad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8770

From: Alejandro Lucero <alucerop@amd.com>

A Type2 device configured by the BIOS can already have its HDM
committed. Add a cxl_get_committed_decoder() function for cheking
so after memdev creation. A CXL region should have been created
during memdev initialization, therefore a Type2 driver can ask for
such a region for working with the HPA. If the HDM is not committed,
a Type2 driver will create the region after obtaining proper HPA
and DPA space.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad..fa99657440d1 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -92,6 +92,7 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
+	struct cxl_port *port;
 	void __iomem *hdm;
 	u32 ctrl;
 	int i;
@@ -105,6 +106,10 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	if (!hdm)
 		return true;
 
+	port = cxlhdm->port;
+	if (is_cxl_endpoint(port))
+		return false;
+
 	/*
 	 * If HDM decoders are present and the driver is in control of
 	 * Mem_Enable skip DVSEC based emulation
@@ -686,6 +691,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_committed_decoder(struct device *dev, const void *data)
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
+	return cxled->cxld.id == (port->hdm_end);
+}
+
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+	struct device *cxled_dev;
+
+	if (!endpoint)
+		return NULL;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	cxled_dev = device_find_child(&endpoint->dev, NULL,
+				      find_committed_decoder);
+
+	if (!cxled_dev)
+		return NULL;
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+	*cxlr = cxled->cxld.region;
+
+	put_device(cxled_dev);
+	return cxled;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 043fc31c764e..2ff3c19c684c 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -250,4 +250,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_ops *ops);
+struct cxl_region;
+struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
+						       struct cxl_region **cxlr);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


