Return-Path: <netdev+bounces-273224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCjEDKiNymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:50:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EC35D296
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E78C3139E5B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2172E7BB6;
	Mon, 30 Mar 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="37VB3aHD"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012027.outbound.protection.outlook.com [40.107.200.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA882F25F0;
	Mon, 30 Mar 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881532; cv=fail; b=qgXn1f30LdCPQ8plMTK4Qe4MRJkk0dsnOj4asiPKSBSYHsw3QLguuXNjhvn6ix1AajmXT83ZsZ43hGDPDB/MbbDNBAOLZvDE5Zh84ebEwMdlm7fLzQILMFYN8qn6LzQS5cMSJC3RqTzQ/JVdZl3XL8acbcq79BwLcPemGk1vSE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881532; c=relaxed/simple;
	bh=tn7pV7i+SEIs251G2fWrejS1ycLxZBq4inVOt2PGngc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t5DvB/bs9uJkNM8Bwt6lGsEjYOQnKUalDPeCjcDRJyI4TD629U7jD7oRtVN8R5zqEj8jiGcPCd/H8ciJj1sH4SvOjiBBFUAk4yded6sY1+O95T+Cb82PWxqF5Fdqctbc80LT1c6rhdj26f1PBijPavNsyeMM6YCwY3/FS8LuHSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=37VB3aHD; arc=fail smtp.client-ip=40.107.200.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1pVEjqsIb0dcyDVyllVRfibjAp2OjlNRfFnSJkV/oVJ2KjDPtklxbMdEeTcsI/ylISP8pmqxc+z+loYouCzsOyLhvwTxnQEinyXbW6eLkjv1U8wIs+Vkh7ePxV03nhe74Fs9P/lGD4oBqTgMPv1bhKLOPV43FP1bXT9oWlopwRDuKnqdZAxKTm84SSNDdux+3G7VBMx/oHWv8PqjEBgP+prfJyB0Yq9UWp/vGExDn8VNLJ2LTuLAZ67Cc67JjtbMfuu8U+LU/X3RnpidkeNB7l1hciUJFnObdQIG7aV6bMvLBDWAV5QL70EyBk/ViX1ntA+mEFV2Fw1JeAPDnbqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQOqzqscnLNdr6l8wsk2Cv0rcLf+SZ9fKwQ8akxZFRY=;
 b=M572ssLxFpR7T6Dz8WBM4yabWheZeGN1oXSbVOZRut2LJEO4nHpcFgVREddz0qsTrqdKqGLMGvxDNoGsA0vEYEuNNH34f2ku7HD1CbVMQ87oJP8HVNEOPV80IZAli69fi4lLrdNq9WwucERe5Y2K+2wvGxP/A0ZTY7iuD3h4AlbU15PnipG7PR28opxfFbbwDUWRaLthRmVCLO/fOQb8xLSYLfNiItAzQsEtIJhuzc3LVtkqa+bLz/ui9kgFP8yHeL98jFBkUieXnpwwfpDMOTBMOoBlNyrLXdT1HcvlExZEDmdGtnV/VUMltVZWLfcOoaAqsCRtYbxI8ikH0F3K4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQOqzqscnLNdr6l8wsk2Cv0rcLf+SZ9fKwQ8akxZFRY=;
 b=37VB3aHDFTH7cR0mG6wr5NRq2sIm8ocxYqQUCYuAFH+CKKk5FYjlSy+5GNZkh6j0uR7bhDJNICpdZus6wZZwMgLM9PwdUwLuZiEFKHcTGy5Wk+7W4oubTJF85SfKzUkmaac8AONAkVnEzpjWRoKEFhH4Vs2sdrzS8YArf07qOhU=
Received: from CH5PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:1f1::25)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 14:38:46 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::25) by CH5PR03CA0007.outlook.office365.com
 (2603:10b6:610:1f1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 09:38:44 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:43 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v25 06/11] cxl/hdm: Add support for getting region from committed decoder
Date: Mon, 30 Mar 2026 15:38:22 +0100
Message-ID: <20260330143827.1278677-7-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
References: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: fae12c36-90a1-4989-5f7f-08de8e6a0c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	ET+NDsssrcgwd4oIRWRDil0ND9a4K5vMmazkU4M+jCcrsFrjGoJV5P98M5d9tfIWtBnqVKeJLNubcNc0+/+2cQr6n2sJ7K7Uar/X4zhuJHFPyQ86oWxcM30IhwbqlpsNiWNXs0SU6yHlUpyS5fGlUKMhzKaKZuT+Qz9VCNz/nM+CzWIi16Mu+LNTuNNe0dbyg1L6LX6EDeQawX8OO4/GLcG0g7EGM6NatHxRwy5MByce85ni7Z83WoyUw0YlyYE0A25badR8vSB0YvAFi+H9QX828cgDcEl8nfS6GhZeHLbd4fsy++MJD5vKfLDa94VTZilZq5KYijNw+oqIv9Yg9UfT20kl41XtW14OYwd9zbzJWHbjAcIJH8x3WasuEHsfY9LfIkIvs443Do2ArDfN3K8SS72+zAP8AB/X/Tbf0ttdytVCPhNGmtj4O4uifDeVuU1l5lPw5YoDYICe9P6cnT7ny0iwJUrunuzmrThX4OxaoOAldazX7VQf/pbU7QbfyhVX9bntbN/L6ZPdoeJ1xJQBKMFEh5pMb9GgAlCoqk/UUwIkHHMDypgNXjsWm+xLPhxvyS9X35EGKeVs538iNL6UL9YBP34a0QeQd8xOtPcFL7WHXbUxD93FbKv9oM8nMV7ayo2AUG1HdwRxmfk/QWA3yPNBG1s96OJb3oWAeEnFtsRXyVXOx49rnmWUycroDa5ymzhmdOUDwnJRmb/fHFpP0NBdY6fUI2KJww7Li8luem8YHYDp/+zk+LiVib3g2lTWib9o8O9Uzita24GYPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x5u8uRTg4D/jqoaWnjJzN/x8ZoxjgWVxXfcdle67wGilWRVHcS9lNEoWmMlfmijbUQ8os9gx5lwIHMs9Obm6iqUF+cE/VnT+rxLWt7qnvlFnoo/EPwKwjUDapyq0ffzV65Dxnld9KPewFIya+2UTa/UQ3kl8tIn/TgfTnEq+RmDfxQ+ubmEgpFROvBp/lXnBeNBDBvhHmxLP3xKKTbhBTTVsa61Lt1Oqaoh7PkDxtsvZUuCrunJfC5SpEhBROb4xJJ1Q5a2l63BMHnyEJSdClsdiC8u59ubOvaKxS4l0D1GqIAfFlxCJV6YCAuOhA497WCEt1EtCFkrObcFHjGSpsoLKNFUiXiiCYBHoejcOIwZvUV2nm+utae2p7AKGMmabMQhZKrAHSPSN4U9MQ3uaFheUiYUpzdtSOkS6uzqhTVV0zWBeGZ/JgXoJWB3qtUwB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:45.9062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fae12c36-90a1-4989-5f7f-08de8e6a0c71
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273224-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 809EC35D296
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

A Type2 device configured by the BIOS can have its HDM committed and
a cxl region linked by auto discovery when the device memdev is created.

Add a function for a Type2 driver to obtain such a region.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
---
 drivers/cxl/core/hdm.c | 48 ++++++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h      |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c222e98ae736..ce5feb4b26ae 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -686,6 +686,54 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static int find_committed_endpoint_decoder(struct device *dev, const void *data)
+{
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_decoder *cxld;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+
+	cxled = to_cxl_endpoint_decoder(dev);
+	cxld = &cxled->cxld;
+
+	return (cxld->flags & CXL_DECODER_F_ENABLE);
+}
+
+/**
+ * cxl_get_region_from_committed_decoder - obtain a pointer to a region
+ * @cxlmd: CXL memdev from an endpoint device
+ *
+ * An accelerator decoder can be set up by the firmware/BIOS and the auto
+ * discovery region creation triggered by the memdev object initialization.
+ * Using this function the related driver can obtain such a region.
+ *
+ * Only one committed HDM is expected, returning the first one found.
+ *
+ * Return pointer to a region or NULL
+ */
+struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd)
+{
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!endpoint)
+		return NULL;
+
+	guard(rwsem_read)(&cxl_rwsem.dpa);
+	struct device *cxled_dev __free(put_device) =
+		device_find_child(&endpoint->dev, NULL,
+				  find_committed_endpoint_decoder);
+
+	if (!cxled_dev)
+		return NULL;
+
+	cxled = to_cxl_endpoint_decoder(cxled_dev);
+
+	return cxled->cxld.region;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_from_committed_decoder, "CXL");
+
 static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u16 eig;
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 10a9b8fa2f6b..05c6ff2404b0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -231,4 +231,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
 int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach);
+struct cxl_region;
+struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


