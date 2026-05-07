Return-Path: <netdev+bounces-285290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD8dJlF8/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D0F4E7BBC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE214303E224
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB6B3E92BF;
	Thu,  7 May 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ne+UUNo5"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1ED13ECBFB
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154494; cv=fail; b=PVls+4u3NEzFrsNKsZd5CjNUwa56pqKZWQKC5zkQDPBXvSxisqwFuFYIPKq0xT/ihUxEoqFiBk2E9/oZst3DftljMfbrn41Gyi87Qqxhy1Y2ooXoZcT4NQnmHsRdt4Nemazc+/9oaGU0pW3Iis6f33LE+5AZd4TzyD9EgE56wFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154494; c=relaxed/simple;
	bh=R4/JM0CQWu+sbYRpd5uWepW0489wk8n8slBeT8KEBIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijM85CeahTtWo8gugIt7J5zhA+FAHtZBbFxMtKTGPDsbi6rxBSTEXPhUeGTn/95NUAt6Vivo3V8OXiy+KkXBryM0dvplLtXn9tHWIAZs+4NgJgd86nqVnzbc7YNScP5vNlMCX+WL1tQ/z6Nb+Gct7SFQ6bdmbM9jomjT1Ly2GAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ne+UUNo5; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqRqDw7/tts5kbSzkzRRVzertl0npAynSkvC0zovjcTbj9PTWNTIiNWKVDNEs/86SEjXmK4px+ZUDMA/ILqVcwX+ipjzo2dwtbpZ1Xq4ZYMGAZ06N6CYmS3MRZdMHlmwuKi50AibLzcYceCAUrW5r3CpJZwJbsNvqcsxAHNNB5PAvTYL34fGAgDkxNBSiLLlTYWqdGhIAlIDUGY3uhuApjc4h6Ogg5e7lZ3ns4moiE1QOCndLxqNtwNRNPrDIYbUCkUNfEN0P8FINtgPlNQpVyX7gDxjp9shExlT7oo7vJvUxka2K3sGoEu9mDMXN+s3ywi35br+0KBlmyy3Lz8R9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjosfC2F2D/82CDHBZ2IAdNnFPBN1iKOTalDrVaqClI=;
 b=BnYseiczE1JmQPb0d/vvTW7l1JiT0mEMPD9JpK9wCXF7R725ncXnDluxegTqmqLEBI795ywikQ3C7f5m4XmxRRAlFxPpofVIKL73JqNKvwKlr0GJywxo4i2vjuWI/03zhvCrRGstj1DKVyXg5wLECwdYWpdsXXhg4ZEclFSfjvPT2GWTr7ws8uaxF0tzuC5dTLtSBdKMakSGRI0MaHfkgXvIfkxUMVcMlVMj4lRb4W0Nw9mO1gnC06ASCAnEnE26nv20xTxEUt73OGRIAHz2Glp1DKQgBLYp9jno/hHYVMxu+H2eEYsCcIooeAFAxbNoO3iD5VVPFj1IP1PzrWCNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjosfC2F2D/82CDHBZ2IAdNnFPBN1iKOTalDrVaqClI=;
 b=ne+UUNo55pA/OzryfePpkuF451rImGr8bm8cEbqd/Hon+ZuhGJ58DFE5GFJ3YgU4tvooDrmw0fpEl6/8atq0IkFsujfTQvloF0/eE9Ao7Uo7+jpgR+dGUWPzHB/Vt6vlP3u1yE0LL0540cbiVfMUDodCAKZuTZou0naTJ8wwxVqgRuyd1+oPjWo9lidN9mhYUWcQQ53VlWNq7j/BW1WGq1gNU8Gvo2QYzpG++QlgEmDSHcTG4cBfnDz10N79wZzuri+n9ojwKORn4OqmT/xgiPKGx0nwIuiBAkwy6Xo0Q96c0HMosVomu+46X6UCK4XVLnvn8dc6iKhsHHoDuabbow==
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by SN7PR12MB7154.namprd12.prod.outlook.com (2603:10b6:806:2a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 7 May
 2026 11:48:08 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::fe) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.6 via Frontend Transport; Thu, 7
 May 2026 11:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:48:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:45 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:43 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 1/5] module-common: Add module_dump_eeprom_page_hex() helper
Date: Thu, 7 May 2026 14:47:17 +0300
Message-ID: <20260507114721.3409128-2-danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>
References: <20260507114721.3409128-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SN7PR12MB7154:EE_
X-MS-Office365-Filtering-Correlation-Id: c87d64cc-bfe8-4b5f-9371-08deac2e81ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iR9SxDgVqtJdVQhHSKRWueUal/vHYKuh52KEN/40atGYWb9Rpa8YRDnY9vqIhYSq5uzPQR2QI9IGnBasNGG+SQdU5HgSAhPaHVLRO9KBJjaUTN99hUmLe/hkSONCycZS2qR2YpuA2LEs8kSm0PGFVbVPXE/5C3Vt2fhauLxrqovCWEJmoaAxu1Y30peTWwv+vKaUzVNe7/02gJptxc5LM8vaGG8uGKPaIi6JQLjK6Dgm7yX2BZlpZcwcz1Qkvo7FW7+3sWw9zbfcZp83i3vHVv/94bhh506t4unxiV26Htd2zLgfE20ESjws4Jj8biDww79gSJAPSVscRRB7M10PhsTXH8i8nQwpiSjxbSlAI8SLyO4YgqbMYp7hWqM5KTyi4KOu1jtkzBF5qJXF8fIfHT0rm9WzFvB0xjQ4QfGFkJLrMcYNodBV4OmzK0AXCI0SqJO4Pue0f2qzI6XxKB6tv9+z0BpzwjnoQO8dsCWKg6a8EZgRwdsXQWFXMCqhYl7heWu5AyrExVeL3HBfVNzTUh+7GlgrmCJqtoXhPZGWPd5QlDznxY16lqC0GQqx1l2A8y0hEVNN2Icv9D+EIBE3HWi2jARndPNIE9Wo2qa0io0Hc2HGK5h98KVh+/Jjggil8hrDEkbp1grF0CGw9JtjfI8TfRqxOP1DPWupnrkVK8586TMsUCRynTrBkj25lV1L1vUBnviDycikOPotNeb7I9DkTYOwoytJgKyYUJT35Ok=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fgqsP/HdGNw212/QUiz8cZgTNkB/lAJ9DWvmTzmuAclRBYGjBxZPVQ7DUfwRwz2TUQun44fYfo9KGtwcP/KCBgZfOlscZ+dfm9clXhsy6bDQEzJnQUNH64+kGpItgc9eq9tZxO2hkxxcbUTITh8StMaL1M6SbTGzzdYAuuvBHgSNaXFPGEOjfbLByZWGzjEFUKCx1iuyxqKMvCKRfQiCgjYw0r8qMXB2F/sG9M/N8qRP7NQDe6bkgKX1mXZj4aFpumlVrxiOZjFzBtpaVG3gv/NMSgyR+AUjk/17K814CUU6z+ljtgwqLRjsL532iIHhjxbaV1VktxgzxPkoeO7RxUqkgo31dHmR0NY1rVtZUmhLxwSyYv/Rg3q0HIaTnAIjLNnWOpsgr+FwLwo9r10uiTDhVAr4if1S2BMcSCAHHxaDcuiNmc2fAOsCCz70ZrGV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:48:07.7724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87d64cc-bfe8-4b5f-9371-08deac2e81ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7154
X-Rspamd-Queue-Id: 34D0F4E7BBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add module_dump_eeprom_page_hex() to module-common.c as the shared
building block for per-type EEPROM page hex dump functions.

It prints a per-page header (page number and optional bank) followed by
a hex dump in the established ethtool format, using dump_hex().

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 module-common.c | 16 ++++++++++++++++
 module-common.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/module-common.c b/module-common.c
index 4e9a0a7..17e4845 100644
--- a/module-common.c
+++ b/module-common.c
@@ -7,6 +7,7 @@
 #include <math.h>
 #include <ctype.h>
 #include "module-common.h"
+#include "internal.h"
 
 const struct module_aw_mod module_aw_mod_flags[] = {
 	{ MODULE_TYPE_CMIS, "Module temperature high alarm",
@@ -656,3 +657,18 @@ void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd)
 	PRINT_VCC_ALL("Module voltage", "module_voltage_measurement",
 		      sd->sfp_voltage[MCURR]);
 }
+
+/* Print one EEPROM page with a descriptive header followed by hex dump.
+ * When bank is non-zero it is included in the header.
+ */
+void module_dump_eeprom_page_hex(const u8 *data, u8 bank, u8 page,
+				 u32 offset, u32 length)
+{
+	if (bank)
+		printf("Bank: 0x%x, Page: 0x%x\n\n", bank, page);
+	else
+		printf("Page: 0x%x\n\n", page);
+
+	dump_hex(stdout, data, length, offset);
+	printf("\n");
+}
diff --git a/module-common.h b/module-common.h
index 985b518..94a3a8e 100644
--- a/module-common.h
+++ b/module-common.h
@@ -284,4 +284,7 @@ void module_show_connector(const __u8 *id, int ctor_offset);
 void module_show_mit_compliance(u16 value);
 void module_show_dom_mod_lvl_monitors(const struct sff_diags *sd);
 
+void module_dump_eeprom_page_hex(const u8 *data, u8 bank, u8 page,
+				 u32 offset, u32 length);
+
 #endif /* MODULE_COMMON_H__ */
-- 
2.51.0


