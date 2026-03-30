Return-Path: <netdev+bounces-273228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHXfEOuNymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5103B35D2E5
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 816B73108AD9
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E353009C7;
	Mon, 30 Mar 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BhKhtqGF"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012034.outbound.protection.outlook.com [52.101.48.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE2309DCF;
	Mon, 30 Mar 2026 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881538; cv=fail; b=Esk4Ju7XEP4tiSbhUKiRPIdzL2h/g+ggTxobQygHwO1SvimIXyTQvgvMMbVZToRs4KRORlIhGCvJLoHU4L2Ixd/CQtcXYzsg2jH/dVBNMNzT0AKUOeyk1x39xd6uunRswh9OVPfpfywsL77/5jDMUv3aeI9ZDL4eWLDzfWCb41A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881538; c=relaxed/simple;
	bh=CND8ZZhnCQZIMdPZR1R58RQqOSyd7yXFlPC+som5XWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9MmIn66wX5gRmp2HPYJew4o1KJfRvqlVtcQvqKaJoPdDsl2BzQvG++dMLvZcPSdhSAbbqtb0s1kAsekpmJfxBnllX9zQdqwDuJF0GPKkzUVeCvOFhasBhTd6naOvhtqtoEup3Rw0eSR59wX0aIJ6KnvMUEot7qxKFiheVPc3dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BhKhtqGF; arc=fail smtp.client-ip=52.101.48.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tx6JLQkEUKhEXpZ3N6/6OshR8KkTp7Qpr3r2yDVjjEX/LWNHWZXJDoAftshGnyK4MNi7lKTxB76zIn00jS2yRFPO5855XxjLkT3lVbCOZhfO8e1fG7ap/hsN/zYWMdQ/FKX7gygv029ktBW24ZjUKGSIWWADPKVu/n/f1pG4vqwXRejJpYKVmK8Hmo2DlM93ObjMvzRZDgzSV0SX3Zhm/Jgj+HhaEaVUYApD9nsSzUtiJPoDu/n08E58FF59X66FMYY4DLUzJRjr/velTNE5iKd10ZqjTvcD1zO62y4mgqlSj5XmLAN9yGGIjDyc2VtM0Cw/otPUnaH94bpqW4oK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIgSdGJVLkFiU3UxhrbyPxqNl5dsAbVUJ/mBu84a/Uo=;
 b=PPbyDHRMVGC123Jea6XpnZOiaHteiRLA1iD8YplWb/meqBF1yBGLQNfA/ZRxG0pqUMjNVdjXXVWK1yRMX4/46uAfvkOXpAJ0qGfDUmaOF32n/uA9G2le26nUm8gkfEozHDtjQtctSZf3eadZgohs4gDjSOCKJJr5IXtX8/Ok6XAb7PzAuNkeMJwYBVB0155+mMo5UEA+ZumxKd8yP15wXxtn08eaGY7qj8/wFrkwp0wYUHH+3btJKgWacNTn5sNncFuZw8I+p2BXUvzYz7ulHW9RNrLmYp6W4M5BIPiXtZPfGh0LqEP+2nUQWu9G8Mzvuf3S7+msG67adzU8iCUzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIgSdGJVLkFiU3UxhrbyPxqNl5dsAbVUJ/mBu84a/Uo=;
 b=BhKhtqGF1Zeh1sJ7G1NX96LgaXwtsnmMpA/j9WCOIb4E589xxbAappCtZ8ZDsJOTqqWMEFbbx9SCKbkwkv72JA9rSL+r2J2Ho3MNysNekc2hb+162jyhqoKQ+DTk3s95Au//uTEMZX1xsFwS5vpUYEOiXSh5qywAscAgIKsvelk=
Received: from BY5PR17CA0005.namprd17.prod.outlook.com (2603:10b6:a03:1b8::18)
 by CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:50 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::41) by BY5PR17CA0005.outlook.office365.com
 (2603:10b6:a03:1b8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Mar
 2026 09:38:46 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:45 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>
Subject: [PATCH v25 07/11] cxl: Add function for obtaining region range
Date: Mon, 30 Mar 2026 15:38:23 +0100
Message-ID: <20260330143827.1278677-8-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b25b061-e127-443a-b07e-08de8e6a0ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5Uzm0/9qI+QxV64uYqnzCVLENFqmm17LfwOh0umAaecfohTrtyGhfSyrM0cBjWkmBdu2cSSRl+UbHBXcQTzenl2JVLVDXtoXghaqMRtDXYL8sSXwKounQ2ixGoyQ1bZt9vUIEXbip1YWh3qdqFJup95HQodL/ahxOPsXTxqNPdGATLd3rxamyauwfNptn3h/OiuLKBbJTBF6p7FDK4JVPg7+dG0NdVstIhsP1jCBBEZg5zFVqboG8kpjXCR2Zr7WpKdahOplog3lu7g1Fk7C6VMHp6IDnBtPe3pzaVt+w5AXvsHylW4kFN8iWXr9nti1nvdLBDU3Wws1ty/cqrrYXFb6I7VxZ55FWuWZHMOLPoPAeF9n7h27+K1BPANdrSS5axIXZ8ZX7uBtYaN2/0w0XTdPlzY7D3teI/qMtFVBv6igxaMk+OtebW2+3chRcrIIFwajHWC+TGk4BBIzRlyH25xvspw8VATrKNT/5XHLF7YVf5Spnr4/yCv6RShot8/X88BqiJGhqIDPsRzRRsKA00nS0f/JA3ctcQrJ6ItRNGl6Skz2vkmXca0rolL1TcOLDca2tGZ6hRa31yTmQOAqsf5ZMs3PACaMA2lJr5QTbxh1Jo2qwAxOZ6UMtp+LnOkIBIq9DwC+OPeHNnlbdvJ5r+rmTPvyDb3UcnsG8IYMg7I9E5RbPGA3Yybr7l61WH9EknmF2Yvo+hBNr38dBagjANvb51SoleZUu3f0iPpLF2UQqS8IPzZQlf/DayVuZHbXEAkYmYWNme3aDHfEczFyzQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8Jw4c8fESCtrZYfLfLOLFtoYc4ad7nPCd88ufcM8K+MBCsg4yUsRlL/X/t9QehQaHWmev8OYmVhy13wu/P0kbI1weBazkbwiBDR26ylBZA/R2NYHPSsJth0xQfkuvRgyhbgvAPdoyVxTvJ6idI5HvYWjrxXhbiglvngdxAfulIrFSbLEssHBOTo2KQE+Xl7BobAeFQYnEim3wmH7vUuBXaAWA/yX6iPrA2XltHGTO2nbMH17EkWxakiWJ/JuRBRCawBFJ2gAzyPlqXc0ZqJP3AjCjtBChIAYr2lR5fgM9ekW3vb0u5uMqaSwfoGB+AezDpa9DH/jnOs1PIon5t/ORiNYGjIAMMbV27VCmrssowXtBqeu4spw+E7x6XQClD9Py+5LXF+/2c84n6J3mw9EjcOTMsoIX4DpjXuSPwJqSDfFUmmqyRVr8Hpxv2KzTpKe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:49.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b25b061-e127-443a-b07e-08de8e6a0ec0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-273228-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,amd.com:dkim,amd.com:email,amd.com:mid];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5103B35D2E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

A CXL region struct contains the physical address to work with.

Type2 drivers can create a CXL region but have not access to the
related struct as it is defined as private by the kernel CXL core.
Add a function for getting the cxl region range to be used for mapping
such memory range by a Type2 driver.

Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Zhi Wang <zhiw@nvidia.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
---
 drivers/cxl/core/region.c | 23 +++++++++++++++++++++++
 include/cxl/cxl.h         |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3edb5703d6de..9c3ba911d865 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2655,6 +2655,29 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	return ERR_PTR(rc);
 }
 
+/**
+ * cxl_get_region_range - obtain range linked to a CXL region
+ *
+ * @region: a pointer to struct cxl_region
+ * @range: a pointer to a struct range to be set
+ *
+ * Returns 0 or error.
+ */
+int cxl_get_region_range(struct cxl_region *region, struct range *range)
+{
+	if (WARN_ON_ONCE(!region))
+		return -ENODEV;
+
+	if (!region->params.res)
+		return -ENOSPC;
+
+	range->start = region->params.res->start;
+	range->end = region->params.res->end;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
+
 static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
 {
 	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 05c6ff2404b0..aa3cf8509b41 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -233,4 +233,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 				       const struct cxl_memdev_attach *attach);
 struct cxl_region;
 struct cxl_region *cxl_get_region_from_committed_decoder(struct cxl_memdev *cxlmd);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


