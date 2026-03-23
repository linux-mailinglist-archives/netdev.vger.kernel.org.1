Return-Path: <netdev+bounces-270485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBWjJoQnwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 211692F160B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E12BC30649CB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79D39657A;
	Mon, 23 Mar 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1OpUyin6"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011026.outbound.protection.outlook.com [52.101.62.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46333286D5C;
	Mon, 23 Mar 2026 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265532; cv=fail; b=pbuPd3CmCiVfOWIjc8/Xf6lfAe1S2wM0XhJCJ+f84OFbawiKLv1QIOlYKG1X7ID8r/byjHkJkApg80dlQuacvGT2T85BnAIhQpqboN8UM1oHpvEEeSjTBT/+8lUGC+L8UzZA6/An6v2eR7UTAQkjyzZGQdyOa8rDHZeHB68wsjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265532; c=relaxed/simple;
	bh=mfMSQ3W86xZq0/tGvWGnEafxQJnsV4v6ODHk8YvzEtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GxbOqgncSRjJ1POk4rL6Wz8j8PtKP+418ZEUt3ynUtrVm0/QpmZf5EjnAnpDVVkAYdtat2usABKz9P3XEh2wkL797atVCp9a2E6Rtg1XqDHi4/rYHTr8FkWGgyRKjIQTB50oTKejJ2rs5Ih4x2KHmMAvPiUTUAKXqcjFSUm39XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1OpUyin6; arc=fail smtp.client-ip=52.101.62.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJCB0HV6iwt1ER1VYJwp+maQeVqoga3fw+DM4gIDOA5pX58s8J2AnEhBxQzgXEfjQPIyGFhYzRZIwXCkHFxEASXmkqwgZfgv/7coMDTaxJozVsfGQy4xbgvgGXWAW6/y0oUfKqoNjfC55/r5fvNnKcPKE+IE2xugMcwcqOSP+p9bWQ0QIb/e8w66CvRz6ZPH5vMtBR0RsWRmnNzp9VYAs/g19t+g0p09LfjyxG0u1S9y+6OAiCbXB3Ta4HYykw3zQsHemcsznoVw2NtW4DdEvL3nfewqnjv9Iy7ARx1ND5/3lLI++3ebORgqVKzTFydPecrblE7AgjP9XSI1J2C+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KSR7qgyjCNmO7Js4Iwp+X9q404OH1AlO6T9NbNWuuCg=;
 b=cNk0JnwjqHyqi/G2haZtqhphiDA+5MoslQ1+mg42ktd1+vWzWScCAm2v1zWRIyBPQlSUYZ0fDuvpe/lkcDatHra8gUt3vi8gF+1JYDhnflpq2ezJ+KEiP4iGwFh+6/hpp6LbZiu5MrRGCZTyHJFole63Yr9X4bGC7A7k3la0u7CwcuTvdUcyjEw/jg0gQh535oD0QK920Kvxl+VBMZmghp8HmaSaD14/paGnigpPm/EsAOzVfVf+RaU4qXprjJPjRleSbbtQSher4dpLIi5o5cG1YI3chRyTktvB7ulOx+/aqCrmMV8YPE2hvyUIG3i9HKjTxZFcor2Kbd60qAIeRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSR7qgyjCNmO7Js4Iwp+X9q404OH1AlO6T9NbNWuuCg=;
 b=1OpUyin6x4709EUfIIBV3fzG/dS49DHsIHenW07inTT49+Ejbs95vTFysGUBkgGKyQo/M0Zr3mYUdaz+zSN5sIMSUwb9FXFko6Y++2jSoH4ACKY97GdT2tr8QMMQo241SVy2CsGdJM34xvfn64QZvP27LTrbp8Sz7mdlhIequyE=
Received: from CYXPR03CA0061.namprd03.prod.outlook.com (2603:10b6:930:d1::26)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 11:32:03 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:d1:cafe::6e) by CYXPR03CA0061.outlook.office365.com
 (2603:10b6:930:d1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 11:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:32:03 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 04:31:36 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:35 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>, Zhi Wang <zhiw@nvidia.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH v24 07/11] cxl: Add function for obtaining region range
Date: Mon, 23 Mar 2026 11:31:13 +0000
Message-ID: <20260323113117.2352709-8-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 150c5006-7900-472b-3e7f-08de88cfce90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	RkDmOFJn081NxctqI4s9cKksxzsyGvTbrYISG8xbzIVPkwtT0U//+U12x4p4YVnztzAnyjY+TfTfam5dU9WDjA3gMopqPi8mqEOzi3jptULjpVc7/WBV2oYSegEzbtRjtI6FFPVPAz4APhgs/97vYr/U1Y5e+48ndiFfM0gakdQBr4RJ23aTRaZvbo9LvjeuE+BHmf4GbM1gDT9sEc/3lke1siZ9+UbKOt5oNjwguC1VSlOMMUzFE/3aR1EdevNKcrhIVfbikbR6sv9f5xy2OFYjyKDj5jYmJLDkqnW9alC3J6uaWH5xT53M6PIJ/qNonEQf4Q9dI2UNQ/YBQUD5q6GlnxqMNLsEWmnKQBRf7zYK4uxCN8TAqhIVFJqykGQ+YucDWMrXQw0CwppM4FGeedI1fZR7hLR2NQpbSYvKJBobJx1aBPXoCxZ0Xpn2pmhpDe8Em8KJwg5ww/brEybZjVFFpJRetyxEnYRHLa7v4N6kPQ/pTzJTwbJKSSMIaKvmZ5pAPtY5XrUm7V28254d+ylOAptW7Hl9XdHjva2nJ9Nn00y9SLYD6jAwsJ4dzrOakannF6TbI4BS0VUi10Qlqg7VYGKVuQQo266IK1HadDhyLc57fqZPrSYUDprxkLThzCqXVVZN53N9BQfcQPNFLF65qMQSyC913UeNkiarCjzBHS63WnEzrTJ9FTwsTwZrQhjX8LTEKOxqfT/vrJ6evbNrcF3mcNWedb2+r9Fr8KpAvcR4Pq577fjJAJRoDFlNE5Cc0f9qyQmiUVL5OK2/Iw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QioiTG8KbnWwupq+SlEUPFSTc/9OI5w984DFOuqO6DnSRnaXldWsbEHcJYjwl5s8afCiVbEoED7OE1k1sLGKzWSDswZhT9pj2ncFyvYW9ooJprR3VLLaPhak6TXR25LBqTnKUZ+t74hGgYzB1Weva9NEr39nc1DZTMViqtqvP6ESzqEslTybsx0cQCszDohfYm15WpZitYWhuv1gsfKGFPZ65LvcsrKEfCScGw8CoACPxwWp3mUCKf64sPYP8jAAj/uu2MUdhhRWmFBQuxnqRPub6AE5tFvJ06AXWJmjWLLWAEN772IqXtaTGM4Tpri9Bqvi35ITl+r6OHoTi/dJHTSoDRKW+/H9msNwWcdG4wraLvt2nS4FSjirnJ0Xt0+OzX1vgfvLF4TKNBJ+oKLKtlwP/ERZqXGGNrvgIlGiqk/ekdGgPiGUwFAfNJI/D0bK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:32:03.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150c5006-7900-472b-3e7f-08de88cfce90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-270485-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid,intel.com:email,huawei.com:email,nvidia.com:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 211692F160B
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
index 2a61138e2a73..122b3331469d 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -234,4 +234,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
 struct cxl_region;
 struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
 						       struct cxl_region **cxlr);
+struct range;
+int cxl_get_region_range(struct cxl_region *region, struct range *range);
 #endif /* __CXL_CXL_H__ */
-- 
2.34.1


