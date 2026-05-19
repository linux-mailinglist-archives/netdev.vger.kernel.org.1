Return-Path: <netdev+bounces-289453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOAIHVtbDGrMgAUAu9opvQ
	(envelope-from <netdev+bounces-289453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C800657EF31
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 994B031159A7
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48A492525;
	Tue, 19 May 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E3/8Ey3Q"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52894DC542
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194283; cv=fail; b=Y670qXk0nc9PZTVw8RFl+PHpoQqQLA/IwojBJaRTr0A1Wz5htJf1IQCqvON634N2xKfKDpTBIxRIKsxGOheVQcFVu9IQAnDqm4WLDKgiemTswe8gfbKQXKXFDNNH1jHjVXVTh35KKt7SjaaOccRr8pTwb2MWf9xXxcoTgsDE1ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194283; c=relaxed/simple;
	bh=rOij4GmTwQrkEUZSp2NAvjpjJtXKNZ/ortRs3X4M8aQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEzyxLMPLLGWE7X7of7gRVOg+P5SMXfI2QMmODWt4zgozFmaX03RW6OCljUqNDd/H+jxISPJgR/6mJtOHDEns1Hi5sFB4Y8GCOFAlfSQ47BQIfufnTKOPq5ndKw9r7RxMz/2I8H3MeoBE04V+G84P5aqyCEfI6SFSpy0kUa1gpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E3/8Ey3Q; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePPCZffK0b01+nFy11TMpSyzZWUmBOYke2m6pUoZzglFdsazpHKhdsdxbIGzpdErWjOoI4uCdTTDB0ud3dUCI0KrCbKZ5Wy3CfSaCw1AJp1ETwrnXvUwiLlhFmFpGhppRoe407+gONt+BN4C15PYZMUIH8Db9Y2UsKhYdAmvg8ODmpPcIcgb42TKMelz53Wa68b2lYv1D+Gs+ixI6LdNkxMnZ1iBOkAA3olvw+hAGNWUYs5zimQv7KVpQVyq1/wNUHxSTcWMYeujj5vjBbLwiIBYsiSQmsNhUkF9sNUElRyPTtxK4TlX+wW09QN2BdN0u5p7jTRAPCksRKjoj98S2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ornsefxt2BnT8CSQNvfOSCAY/oglmyT62al63k7yKeY=;
 b=E/Xyhejs9kipq/r92WwtDe25VqTg8b3geunsIR1+yTJuhj9yAe8XyP/DPtWKT52Mx4nsWUtxbmYUXkS8KHFQVeilTT9iAkUL+MjS5+kJbK5XKDJgJke5dSEO5jJwzHnL8X64UNrMtd0VtDAizJsHTq0nI6Yr4wd/Icyn+0gP+cIEotYGcIWBCms9ipTT2TTNB+itzhs3sqOKxwyVDAzdMIHzZu7QQekpL94vyMSsnkzoWsgz5tIxCs2fBEdRF3xraerct2i4QAe6PfL/2M6wTajgrcu8Jn7OPoJ+IxTVq5bG1r9yvzsM7J99MQrOC24AQ014EsqBZUJdn1gxBd+7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ornsefxt2BnT8CSQNvfOSCAY/oglmyT62al63k7yKeY=;
 b=E3/8Ey3QEy9Kytru7qHp2awZfJAwlikClPJy4MxwpGChPmLnr5aQ+dlqnEJx26rCcBFVFjnvuRu3q/cqg+7AKr4D4yi5qSFEFCR3QnA1UrG2x9K7mxInhqUwe+g8jNE7idLLSITkIoK7XSnX6T4+/TLfF6bkPzhtxhDMo72QtdWZXTQ6+iNKrPTQtqMdLfBRF3WDSZRbKygbkmyG1Vgs8uWwfdT654acJSBvd/SlBYPQ+7ky9okLB0DPBBn8L/SPS60o4/d63cWBoN2MK6x90jqL1k4DAcQ5U1DNZlN74DzB3n4mo0IA9NxjYxPOhmx8D7zOVuRUZI7WiW5U8cH72Q==
Received: from MN2PR08CA0023.namprd08.prod.outlook.com (2603:10b6:208:239::28)
 by IA1PR12MB6233.namprd12.prod.outlook.com (2603:10b6:208:3e7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 12:37:49 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::e9) by MN2PR08CA0023.outlook.office365.com
 (2603:10b6:208:239::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 12:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 12:37:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 05:37:24 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 19 May 2026 05:37:21 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v2 3/5] module: Add per-type EEPROM page hex dump functions
Date: Tue, 19 May 2026 15:37:00 +0300
Message-ID: <b22335023a81b6209d65d1678874833f14dfc1af.1779190777.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779190777.git.danieller@nvidia.com>
References: <cover.1779190777.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|IA1PR12MB6233:EE_
X-MS-Office365-Filtering-Correlation-Id: 264ffb84-4991-4f27-4523-08deb5a36f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|11063799006|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	+3+HDJKUt+hVn/LR9yy/jEF0kGBL5I0AuihJrIjhqRZ2e2Su3ur4SRqV71TluZeui8PRZQHqTihTErZUI+lKhD9/vtxEi6rNCpY0bnrrpRz7TGV6s4bL6XoUv4CNJRYzVkPiEwfVpnbSenWZp96Wd8LeQq3WUpFot/hPMMGf2ZXxYo9e4zD+28I/H4gAyz8RM+LB2AsydA8ATpMyLluH2/K6c59VfUoFVC5+1H3Ar99f6t0EX5acgAYdA6CkDXb1fLzCgHiQy8x0XRq/O3hW8UrhFGuQXD3Cf2sgqsf+zS0+n6o6X/1CNHKu1yIpdyee6/ND3OqcxFbAqIDVR9WigDspr0YCX3TJJtkeh/naVQreVDNjcoe0ld66UzizD3gQJfztN7WtBqnx5AoKTsf54+mEPAP5lIZQCpVfPeI2xqVl/53MNnaqpXkq261a5z+8TXzuZhNtVf05oeoGfOIED715lup219dQfI+qj50jufVTml98DZtc0bqSEuBXoRuCbrR7KvpywPst615QcqYqvblB10QWdS+jzTeYlrXk1hi9/AT1x8OPvkP3FL4qH+25Y3mmeVL+EPZl5vdSyP1OYvwcKl0ZqMJCMHUiu7yQS7LUJ0XmWvw2BUVA/exzkVjWgi3YidzhvCJ3cYrC99Pzl0MZ/u/L0bnaQWqrJSEim9Uh5JdduVr48WUjBdcg5eCCYLO1WxtHlwSLvUKF0ii9nut5NBVlY9Cq/AepDHSp2qU=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(11063799006)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4ZoynQPtB2rcKVZ8nBpcHvlH0r2nwhYmu/LkND7SY4BpkOMpgodyhdo0lUNF1rjaye5cUU1jw+XGaTDZoeLaXG7yOZGKDdlAoksrDftQv9VcSflRR70f1qZ/qauoLDAk/PagYRbo7HxoYpYc1LCV2ABokKPb/eaUftmZIoK9BwxTqTZVFdilaHUL5fTUIE8tpsSoBnxy5yuP+v19oaeI1q2aQdr9cXYsHB4zGsG4DBXPaTEftI2pxbI3B0Me+t5ngrf6ZVx9OAF2zbijYd4IeTGtxSZKb8GSiHASFN5xBPxrY7aIwfwmoD0aUD8rFBLJI7kB/fuTcduCg/5+NqIo/RVY0hMn23zF9yEJBjwxD+KYWPLxEBrjGB7Zn/OmBnDZrp/IP1ff6y1CAWANbYfnEbvA00uyarPlNjkYQqkWf4FB30DkfnPh2YnabkmyeUpk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:37:48.8016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264ffb84-4991-4f27-4523-08deb5a36f9d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6233
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289453-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dump.data:url,nvidia.com:mid,nvidia.com:email,dump.page:url,dump.bank:url];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: C800657EF31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
  over the memory map. Each block is labeled with "Bank: 0xN" followed by
  "Page: 0xM".
- SFF-8636: uses sff8636_memory_map_init_pages() to read the lower memory
  and relevant upper pages, using generic iteration over the memory map.
  Each block is labeled "Page: 0xN".
- SFF-8079: uses sff8079_get_eeprom_page() to read A0h lower and optional
  A2h lower. Each block is labeled with "I2C Address: 0xN" followed by
  "Page: 0xM".

In JSON context (--json), each function emits a "pages" array with one
object per page containing bank, page, offset, length, i2c_address and
data. Consumers that need a stable, machine-parseable form of the hex
dump can use this output instead of the text format.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 cmis.c                  | 70 ++++++++++++++++++++++++++++++++++++-----
 cmis.h                  |  2 +-
 internal.h              |  4 +--
 netlink/module-eeprom.c |  6 ++--
 qsfp.c                  | 67 ++++++++++++++++++++++++++++++++++-----
 sfpid.c                 | 60 +++++++++++++++++++++++++++++------
 6 files changed, 179 insertions(+), 30 deletions(-)

diff --git a/cmis.c b/cmis.c
index 996e9eb..f494268 100644
--- a/cmis.c
+++ b/cmis.c
@@ -1022,6 +1022,64 @@ void cmis_show_all_ioctl(const __u8 *id)
 	cmis_show_all_common(&map);
 }
 
+static void cmis_hex_dump(struct cmd_context *ctx,
+			  const struct cmis_memory_map *map)
+{
+	struct module_eeprom_dump dump = {
+		.length = CMIS_PAGE_SIZE,
+		.i2c_address = CMIS_I2C_ADDRESS,
+		.print_bank = true,
+	};
+	u8 bank, page;
+
+	new_json_obj(ctx->json);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_array("pages", "");
+	}
+
+	dump.data = map->lower_memory;
+	module_dump_eeprom_hex(&dump);
+
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
+			dump.offset = CMIS_PAGE_SIZE;
+			dump.page = page;
+			dump.bank = bank;
+			dump.data = buf + CMIS_PAGE_SIZE;
+			module_dump_eeprom_hex(&dump);
+		}
+	}
+
+	if (is_json_context()) {
+		close_json_array("");
+		close_json_object();
+	}
+	delete_json_obj();
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
@@ -1117,21 +1175,19 @@ cmis_memory_map_init_pages(struct cmd_context *ctx,
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
+		cmis_hex_dump(ctx, &map);
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
index 09d9ace..383d234 100644
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
@@ -1078,21 +1080,72 @@ sff8636_memory_map_init_pages(struct cmd_context *ctx,
 	return 0;
 }
 
-int sff8636_show_all_nl(struct cmd_context *ctx)
+static void sff8636_hex_dump(struct cmd_context *ctx,
+			     const struct sff8636_memory_map *map)
 {
-	struct sff8636_memory_map map = {};
-	int ret;
+	struct module_eeprom_dump dump = {
+		.length = SFF8636_PAGE_SIZE,
+		.i2c_address = SFF8636_I2C_ADDRESS,
+	};
+	u8 page;
 
+	new_json_obj(ctx->json);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_array("pages", "");
+	}
+
+	dump.data = map->lower_memory;
+	module_dump_eeprom_hex(&dump);
+
+	for (page = 0; page < SFF8636_MAX_PAGES; page++) {
+		const __u8 *buf = map->upper_memory[page];
+
+		if (!buf)
+			continue;
+
+		/* Upper memory starts at one page size into the
+		 * buffer, since pages are accessed at offset between
+		 * page size and twice the page size.
+		 */
+		dump.offset = SFF8636_PAGE_SIZE;
+		dump.page = page;
+		dump.data = buf + SFF8636_PAGE_SIZE;
+		module_dump_eeprom_hex(&dump);
+	}
+
+	if (is_json_context()) {
+		close_json_array("");
+		close_json_object();
+	}
+	delete_json_obj();
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
+		sff8636_hex_dump(ctx, &map);
+	else
+		sff8636_pretty_print(ctx, &map);
 
 	return 0;
 }
diff --git a/sfpid.c b/sfpid.c
index f753917..9a7f927 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -498,7 +498,52 @@ static int sff8079_get_eeprom_page(struct cmd_context *ctx, u8 i2c_address,
 	return ret;
 }
 
-int sff8079_show_all_nl(struct cmd_context *ctx)
+static void sff8079_hex_dump(struct cmd_context *ctx, const u8 *buf,
+			     bool a2h_present)
+{
+	struct module_eeprom_dump dump = {
+		.length = SFF8079_PAGE_SIZE,
+		.print_i2c = true,
+	};
+
+	new_json_obj(ctx->json);
+	if (is_json_context()) {
+		open_json_object(NULL);
+		open_json_array("pages", "");
+	}
+
+	dump.i2c_address = SFF8079_I2C_ADDRESS_LOW;
+	dump.data = buf;
+	module_dump_eeprom_hex(&dump);
+
+	if (a2h_present) {
+		dump.i2c_address = SFF8079_I2C_ADDRESS_HIGH;
+		dump.data = buf + ETH_MODULE_SFF_8079_LEN;
+		module_dump_eeprom_hex(&dump);
+	}
+
+	if (is_json_context()) {
+		close_json_array("");
+		close_json_object();
+	}
+	delete_json_obj();
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
@@ -530,15 +575,10 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
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
+		sff8079_hex_dump(ctx, buf, a2h_present);
+	else
+		sff8079_pretty_print(ctx, buf, a2h_present);
 out:
 	free(buf);
 
-- 
2.51.0


