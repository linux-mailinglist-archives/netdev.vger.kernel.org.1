Return-Path: <netdev+bounces-285292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFQ5OyN8/Gl0QgAAu9opvQ
	(envelope-from <netdev+bounces-285292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA064E7B80
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B7AE301486B
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805093ECBC8;
	Thu,  7 May 2026 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QLfG91H/"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013065.outbound.protection.outlook.com [40.93.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8DC371893
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154499; cv=fail; b=GpFxPXDRH1YQjfbZtbpVh/8iZWic7/VBaSHT621DM8VwEz9CDjyF+XM8DHMfgmpdJXeTpPPBTJBmmDd0oUBLdjEcuR038bIawVJ/TnWQ/p7FHZXBM5SxknInzVa+EzfRXe+7gThy5sn8YAWMktyjedzsQNFfaD7eGRGg5UCu/m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154499; c=relaxed/simple;
	bh=BOkXFfJ8HabiahaNuTRHJu4EwuzRpR1HdTXsnnVlZ2M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L4I64w4jxRWzbM61NjcwbN2sRfF/ixCL4lnIPh6AREHLRPL28bumTMcLLw9/xYzY4d3yjWRXAmCubOE3j6OmHph0GnpC8VmWPdvm6Qi9hJ+iNet5VQc0XWHHWV5I4YwAiTjX5kcRht7BRbOdFcfq3YOaT13BW+keajp/23V5xGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QLfG91H/; arc=fail smtp.client-ip=40.93.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD00fXhWEUWEy3y6XyQXZCnmW8/lNlyZq5vQ9c7JrMkJVItpJvlOOd7zvyJWa1kGlk8Qgl5RwdN27liav8gb4ljXGrD8k6uWUHFdBqoRZVQk/vvohmTtYT/uUGdlLjbuFlEZCpxROgdtnxyvlGVr2tXa3lJsPnQSl/h0szwT9Cdiif3+/yrgpW5Z0BHS6AX1On3Tfx4hkafHCqRiY94xWt9ya5LKH/FSltgIG5eM/XNAmVciBNXvLF1IkLANl4JDWxAYwAQny9OWfyROzST9QJKreO6UsADiBdb9kKF/ekKQFOlBHc5iB2yTApY1PqPuXmE3YCTl77peDEMosfqN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWhS5YHGi086hHry0A77QadsavoltAJR1QRzKRa2MWM=;
 b=XMt6+QD7/8OO4lPuZQZfkVj88lj3ELvINM4qXh7/Lw8RwhVXp8Sr4ePWmFfF9mQFDwzw0sX1FmlzHhTLho6lvIRuF/9XOn7xijeToVse5b8mAK9Cu0W1cYz0SHViq/d8QPV/fCYKQDbQrQ6f+5QZmktsmydgebETu+Ptm7Wwn6ECIqNQULQhsLRZ+IcEykR2N2y/Un4uwIqZHUurZFrrzUHesje/vK8/3o8vNG+cU0e7N3asFY7paTwPo0VhjRj/XO1IgN00di5lZqaHZU8Erp6/vxVOI60wFjRxhqGg5Etj3NA/SwpJP0JibQYXCMo0pNK61FYLOMfEq9VpAfgmLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWhS5YHGi086hHry0A77QadsavoltAJR1QRzKRa2MWM=;
 b=QLfG91H/apJt9qr8b//N5hZcAt7RRSjUdlyJLr7NKmocb1kGFZ0SEFLNI33QJv5foE7Rw6VyqcPozdgE/l66r7COFlhzejOfPXWCb10FLDjx2fYLnQfVHCFUCRi8Sswg/DwlyvwGvTTJARxqxdcoNnR6DSKJAE/EZ+rtwGiVO99JEMGCm4mLt9O8UXltyXVYxBd8/HxOgKSfuUq1OHoaD0OJ7imF6RvJeByGw6wvx6/yyxGaILTgcYsCz/aNkcvBK2dUsDncA4Xu9qld6OWmAWapAyJzW6eGLQix1ti1EgfReIMJI9XKtEaOVmN4QuBT4KaCzWND6qzc3i9Ah2M0gQ==
Received: from SJ0PR13CA0232.namprd13.prod.outlook.com (2603:10b6:a03:2c1::27)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:48:12 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::3f) by SJ0PR13CA0232.outlook.office365.com
 (2603:10b6:a03:2c1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.11 via Frontend Transport; Thu, 7
 May 2026 11:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:48:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:50 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:48 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 3/5] module: Add per-type EEPROM page hex dump functions
Date: Thu, 7 May 2026 14:47:19 +0300
Message-ID: <20260507114721.3409128-4-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb4d8bb-9229-4908-6e05-08deac2e8455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	PaAyNNRbrixe9r8kc9TAHv3qZK0LeqIJGMVi+TSRKr4bsoAHOFh3xs7uKeZCQTKmlXNgkwTBm450DNXi9RDrCX9h0Fpx0Xzz9dKlSKvJ4zkR86jjyjL+YeoSS9CTTAxGvbuTdU0rmoJTJ9gXGZ+COknhX9ZyyIvrZSIVpD/vOKOzDWY9h77cmLH38QE1XNjB8CmN5jTdroJiEzWszRo76Ps347MoZNiitSFpUWVfTYvIdIeo1p2TQwes40EtDQFHVZSmYcvnjtNCRdO88Cd3wsuHWUJAr4bjoUQQV23xXHxhzQ7ltfS0Wc9K82MudkguR1xfHUb1SLO2KiJ2ytqIDiZUwC17MJSxmnCeedauM/p0pm9mSCIlKIppy56nyjm/8GoMx0+tEaUSaKLM2SosJO6WKQoPofmHhgBuJ/XJGBUdBOcy/u6jtADIwnaGEpPa9nnS3ZzH9QlcWaaDQt3LR+FrRwmJRwnu91MoZ2qaoLjgY9yKg57G77T8/iopdvDUL6VMNBzDyM/JJ6jTNddU/oovi1fyYlfBfDzcLBQV32dKTaWeP0eXwqM8Po9CUYInq12Ce+PXk9MirbkwOQaSzJZmVFI7xW/haA+LTHC6h/p3Rs16BYwLvJW7Iv78rUTR3KjOaFXL9INHqsLLCgSSzjrmhst6mGPZ8FdrB6bhbE9zrCBNt5rF284VQ55UQrxKCLkDJRfyz5JnWtQzN8DUlwNouMdp3IXt3Qc7ia+zmKM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	am/VloTNl8/60YyCbWKA/jF33qA+bQOHP+MyruzPLAhZ+5fJBQTZdJq9YgvO2W2JBjXNYSlgpGA/ebTXMXlpk2odEbT+cVkO7YgvBQ1IxvvMYWdKEx1K6z5kX28iYdS2sdd75YbZQrkf9EQCvvchevJQ145wr9YxR7GcgmNIQOMkHvzt1fsz+w4dtTw38Up3e3xllFJjXDAwWrwaDNWKvJ4L8bb6+vUl74W3ALZXTLHcr+zdt+FDcYYfVl4N0YZBIVEAQfChBE3LkyJZYvVFy6WOt91CL88wRaohKH/ULDo+pghrO90BZNKxWCqGa8MDp0dUxvIyMG0suOOEAbGlRvmd1q7dF4NXuXrk0/2MEn468ImhKJm6/lkGW1W/yz+Emvq8dYCAqcTsGMklzVrSuoxdtCsTHjBcegGnqGxiGXuUI5Gwk4QTlXnwHzFLR4/w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:48:12.0452
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4d8bb-9229-4908-6e05-08deac2e8455
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
X-Rspamd-Queue-Id: 1CA064E7B80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285292-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Extend sff8079_show_all_nl(), cmis_show_all_nl() and
sff8636_show_all_nl() with a bool dump_pages parameter to support
hex dump output alongside their existing pretty-print output. Each
function first retrieves all the necessary pages and then either
pretty-prints them or performs a hex dump according to the argument.

The hex dump and pretty-print logic is extracted into dedicated static
functions for each parser type:
- cmis_hex_dump() / cmis_pretty_print()
- sff8636_hex_dump() / sff8636_pretty_print()
- sff8079_hex_dump() / sff8079_pretty_print()

Each function dumps the same pages as the corresponding pretty-printer:

- CMIS: uses cmis_memory_map_init_pages() to read the lower memory and
  relevant upper pages across all supported banks, using generic iteration
  over the memory map. Uses module_dump_eeprom_page_hex() for hex output.
- SFF-8636: uses sff8636_memory_map_init_pages() to read the lower memory
  and relevant upper pages, using generic iteration over the memory map.
  Uses module_dump_eeprom_page_hex() for hex output.
- SFF-8079: uses sff8079_get_eeprom_page() to read A0h lower and optional
  A2h lower and identifies each block by its I2C address. Uses dump_hex()
  directly with I2C address headers.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 cmis.c                  | 49 +++++++++++++++++++++++++++++++++++------
 cmis.h                  |  2 +-
 internal.h              |  4 ++--
 netlink/module-eeprom.c |  6 ++---
 qsfp.c                  | 48 ++++++++++++++++++++++++++++++++++------
 sfpid.c                 | 43 +++++++++++++++++++++++++++---------
 6 files changed, 122 insertions(+), 30 deletions(-)

diff --git a/cmis.c b/cmis.c
index 996e9eb..29592b2 100644
--- a/cmis.c
+++ b/cmis.c
@@ -1022,6 +1022,43 @@ void cmis_show_all_ioctl(const __u8 *id)
 	cmis_show_all_common(&map);
 }
 
+static void cmis_hex_dump(const struct cmis_memory_map *map)
+{
+	u8 bank, page;
+
+	module_dump_eeprom_page_hex(map->lower_memory, 0, 0x0, 0,
+				    CMIS_PAGE_SIZE);
+	for (bank = 0; bank < CMIS_MAX_BANKS; bank++) {
+		for (page = 0; page < CMIS_MAX_PAGES; page++) {
+			const __u8 *buf = map->upper_memory[bank][page];
+
+			if (!buf)
+				continue;
+
+			/* Upper memory starts at one page size into
+			 * the buffer, since pages are accessed at
+			 * offset between page size and twice the
+			 * page size.
+			 */
+			module_dump_eeprom_page_hex(buf + CMIS_PAGE_SIZE, bank,
+						    page, CMIS_PAGE_SIZE,
+						    CMIS_PAGE_SIZE);
+		}
+	}
+}
+
+static void cmis_pretty_print(struct cmd_context *ctx,
+			      const struct cmis_memory_map *map)
+{
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
+
+	cmis_show_all_common(map);
+
+	close_json_object();
+	delete_json_obj();
+}
+
 static void cmis_request_init(struct ethtool_module_eeprom *request, u8 bank,
 			      u8 page, u32 offset)
 {
@@ -1117,21 +1154,19 @@ cmis_memory_map_init_pages(struct cmd_context *ctx,
 	return 0;
 }
 
-int cmis_show_all_nl(struct cmd_context *ctx)
+int cmis_show_all_nl(struct cmd_context *ctx, bool dump_pages)
 {
 	struct cmis_memory_map map = {};
 	int ret;
 
-	new_json_obj(ctx->json);
-	open_json_object(NULL);
-
 	ret = cmis_memory_map_init_pages(ctx, &map);
 	if (ret < 0)
 		return ret;
-	cmis_show_all_common(&map);
 
-	close_json_object();
-	delete_json_obj();
+	if (dump_pages)
+		cmis_hex_dump(&map);
+	else
+		cmis_pretty_print(ctx, &map);
 
 	return 0;
 }
diff --git a/cmis.h b/cmis.h
index 007632a..82fd245 100644
--- a/cmis.h
+++ b/cmis.h
@@ -201,6 +201,6 @@
 
 void cmis_show_all_ioctl(const __u8 *id);
 
-int cmis_show_all_nl(struct cmd_context *ctx);
+int cmis_show_all_nl(struct cmd_context *ctx, bool dump_pages);
 
 #endif /* CMIS_H__ */
diff --git a/internal.h b/internal.h
index cbf3c09..19fff41 100644
--- a/internal.h
+++ b/internal.h
@@ -381,14 +381,14 @@ int rxclass_rule_del(struct cmd_context *ctx, __u32 loc);
 
 /* Module EEPROM parsing code */
 void sff8079_show_all_ioctl(const __u8 *id);
-int sff8079_show_all_nl(struct cmd_context *ctx);
+int sff8079_show_all_nl(struct cmd_context *ctx, bool dump_pages);
 
 /* Optics diagnostics */
 void sff8472_show_all(const __u8 *id);
 
 /* QSFP Optics diagnostics */
 void sff8636_show_all_ioctl(const __u8 *id, __u32 eeprom_len);
-int sff8636_show_all_nl(struct cmd_context *ctx);
+int sff8636_show_all_nl(struct cmd_context *ctx, bool dump_pages);
 
 /* FUJITSU Extended Socket network device */
 int fjes_dump_regs(struct ethtool_drvinfo *info, struct ethtool_regs *regs);
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index ce6a7d9..7e4e6ac 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -228,18 +228,18 @@ static int eeprom_parse(struct cmd_context *ctx)
 	case MODULE_ID_GBIC:
 	case MODULE_ID_SOLDERED_MODULE:
 	case MODULE_ID_SFP:
-		return sff8079_show_all_nl(ctx);
+		return sff8079_show_all_nl(ctx, false);
 	case MODULE_ID_QSFP:
 	case MODULE_ID_QSFP28:
 	case MODULE_ID_QSFP_PLUS:
-		return sff8636_show_all_nl(ctx);
+		return sff8636_show_all_nl(ctx, false);
 	case MODULE_ID_QSFP_DD:
 	case MODULE_ID_OSFP:
 	case MODULE_ID_DSFP:
 	case MODULE_ID_QSFP_PLUS_CMIS:
 	case MODULE_ID_SFP_DD_CMIS:
 	case MODULE_ID_SFP_PLUS_CMIS:
-		return cmis_show_all_nl(ctx);
+		return cmis_show_all_nl(ctx, false);
 #endif
 	default:
 		/* If we cannot recognize the memory map, default to dumping
diff --git a/qsfp.c b/qsfp.c
index 09d9ace..6e1b9ff 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -62,9 +62,11 @@
 #include "cmis.h"
 #include "netlink/extapi.h"
 
+#define SFF8636_MAX_PAGES	4
+
 struct sff8636_memory_map {
 	const __u8 *lower_memory;
-	const __u8 *upper_memory[4];
+	const __u8 *upper_memory[SFF8636_MAX_PAGES];
 #define page_00h upper_memory[0x0]
 #define page_03h upper_memory[0x3]
 };
@@ -1078,21 +1080,53 @@ sff8636_memory_map_init_pages(struct cmd_context *ctx,
 	return 0;
 }
 
-int sff8636_show_all_nl(struct cmd_context *ctx)
+static void sff8636_hex_dump(const struct sff8636_memory_map *map)
 {
-	struct sff8636_memory_map map = {};
-	int ret;
+	u8 page;
+
+	module_dump_eeprom_page_hex(map->lower_memory, 0, 0x0, 0,
+				    SFF8636_PAGE_SIZE);
+	for (page = 0; page < SFF8636_MAX_PAGES; page++) {
+		const __u8 *buf = map->upper_memory[page];
+
+		if (!buf)
+			continue;
 
+		/* Upper memory starts at one page size into the
+		 * buffer, since pages are accessed at offset between
+		 * page size and twice the page size.
+		 */
+		module_dump_eeprom_page_hex(buf + SFF8636_PAGE_SIZE, 0,
+					    page, SFF8636_PAGE_SIZE,
+					    SFF8636_PAGE_SIZE);
+	}
+}
+
+static void sff8636_pretty_print(struct cmd_context *ctx,
+				 const struct sff8636_memory_map *map)
+{
 	new_json_obj(ctx->json);
 	open_json_object(NULL);
 
+	sff8636_show_all_common(map);
+
+	close_json_object();
+	delete_json_obj();
+}
+
+int sff8636_show_all_nl(struct cmd_context *ctx, bool dump_pages)
+{
+	struct sff8636_memory_map map = {};
+	int ret;
+
 	ret = sff8636_memory_map_init_pages(ctx, &map);
 	if (ret < 0)
 		return ret;
-	sff8636_show_all_common(&map);
 
-	close_json_object();
-	delete_json_obj();
+	if (dump_pages)
+		sff8636_hex_dump(&map);
+	else
+		sff8636_pretty_print(ctx, &map);
 
 	return 0;
 }
diff --git a/sfpid.c b/sfpid.c
index f753917..73e714e 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -498,7 +498,35 @@ static int sff8079_get_eeprom_page(struct cmd_context *ctx, u8 i2c_address,
 	return ret;
 }
 
-int sff8079_show_all_nl(struct cmd_context *ctx)
+static void sff8079_hex_dump(const u8 *buf, bool a2h_present)
+{
+	printf("I2C Address: 0x%02x\n\n", SFF8079_I2C_ADDRESS_LOW);
+	dump_hex(stdout, buf, SFF8079_PAGE_SIZE, 0);
+	printf("\n");
+
+	if (a2h_present) {
+		printf("I2C Address: 0x%02x\n\n", SFF8079_I2C_ADDRESS_HIGH);
+		dump_hex(stdout, buf + ETH_MODULE_SFF_8079_LEN,
+			 SFF8079_PAGE_SIZE, 0);
+		printf("\n");
+	}
+}
+
+static void sff8079_pretty_print(struct cmd_context *ctx, const u8 *buf,
+				 bool a2h_present)
+{
+	new_json_obj(ctx->json);
+	open_json_object(NULL);
+	sff8079_show_all_common(buf);
+
+	if (a2h_present)
+		sff8472_show_all(buf);
+
+	close_json_object();
+	delete_json_obj();
+}
+
+int sff8079_show_all_nl(struct cmd_context *ctx, bool dump_pages)
 {
 	bool a2h_present;
 	u8 *buf;
@@ -530,15 +558,10 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 		}
 	}
 
-	new_json_obj(ctx->json);
-	open_json_object(NULL);
-	sff8079_show_all_common(buf);
-
-	if (a2h_present)
-		sff8472_show_all(buf);
-
-	close_json_object();
-	delete_json_obj();
+	if (dump_pages)
+		sff8079_hex_dump(buf, a2h_present);
+	else
+		sff8079_pretty_print(ctx, buf, a2h_present);
 out:
 	free(buf);
 
-- 
2.51.0


