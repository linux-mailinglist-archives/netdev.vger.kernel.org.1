Return-Path: <netdev+bounces-291302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO/INV85FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 734465CA351
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 993113007899
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58837FF65;
	Mon, 25 May 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XVkeyf06"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C23137FF58
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710300; cv=fail; b=HPcN//KGd/ZNTkDvKmcCQL58sMaNIa5t9GzymUSr0Mw7+hHQRh2VejsJ4Yek2L77gP13gs8fdKl7IS2UJPYenuh2/zsUtR1utPwMoDYGqjqUuE9qRARoDxfIuypJ3U3Xl8p+EbBY6zwgMQjgJigKPltmUUmXBAXM8hfIJKiee2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710300; c=relaxed/simple;
	bh=Se3wvzw+BBy5VI/67m+DWkWLzusgqCMk6xzBkdqwpKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6B9InanElLK4+9YrXrb6rhwXF9s2rPtQS8BMzkMLWkxTbRrS7lfa0HLrm7wg7ePCvtn1HE873LvSYwj9gF/mqvLrnOet9NWTPGiZJ8RCo5lph/xpjHpAOJI5nmAdfQd8r1aOo3IA05BB622+Dpm5UavzB/1ts6BJt8svEtJkTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XVkeyf06; arc=fail smtp.client-ip=52.101.48.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gBAQ6l8uiPBaMwsZbXzVRVIIBOtb3Pb3eM4+5+yu5B9+o3jBqc/joXP1mOE4nltuY594mrFIB61EfCY3ix9Z2drxWMMmtVGBS4MccTyKO79EMbitDJPNlmwZlZANegvmNE+FCbloAjDpdq9YMugTdXGBVsm6JOrEobMvTHAo/yd7dXz58jjFNbEkQ9ReLj/YIj4YT6hTdlEt3nuSRaeRn1NXQ0mMnqQjO1xhHJE7B3xYAkReNW/EltJWO89CHPoGGSWiT9kkWmjbOY68xytbW10D7lZFTL59CI79E9WywEn2rAl4gSXbzecJhLZIYiPC7lRy+2Qqukerm7cGqC2HNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4tR2OqzjV82P+eAAwVE/GnGzrbs9GK5Dh7RODU2PLM=;
 b=jy0y2hcXIeHNTTe8m6Uq6lDLOLu20dxYfOnk9tsYFEwRS5eMX38obtjMDVSXDCWzEMgDkGI1ei8hPYZAJeVFDWckW42xrKfJeI3Iw/v/xSuF6WNAzL1DMKr6vKtRdJFGh70xUgxRdHbetAsoj9X4fCU/Joqu0nYKinxJVtK9XzQVDTTjAClGa1jMd8O5qR1w3jQonXXuzWm05pg2DEmt/Q/u0LROv0nRPibJPSDY3SpmXv88N+f8q7nc4Ozez2MjO6cMezd8CsUKjKFQoQRBAQqV1f3GfuI4kw6bVJJWF79eBwx7/1SUWCIsaJ38U8LY0KsdV7VbXDt0S5aGYDJ33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4tR2OqzjV82P+eAAwVE/GnGzrbs9GK5Dh7RODU2PLM=;
 b=XVkeyf06K2pswdI9eC5hWklxf4MJtK3eV3YQDLiXcQ9MBs5y29CSsuepIKh5dgjsdjOmGnTXBM5+M5f1i65NHG1tORvKCesPAHXokKVBxLka9RbHMqMBddtEZL9F1pzx2WIcU9aNhnRglKNYJj20h5kNvQ6bLelft9LGR0dkUS8AJcLjILyTa1V8hzfu8Ew9GgN7mULuPrZVge0y9SDH9G/OScTd9lkXSdTJ56GSIiuwv7p3DRhL+iEMCn+KAK7hDSL16ZRPTvfddLCemvBtijKxUZ1wmsoSAbpxxZFVC4ea4Bkq0Rq1SFOaTcJBVlwrWBoj8bVcnE1hp+Bw5Xhz1A==
Received: from BN0PR04CA0133.namprd04.prod.outlook.com (2603:10b6:408:ed::18)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:58:13 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::4e) by BN0PR04CA0133.outlook.office365.com
 (2603:10b6:408:ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 11:58:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:57:58 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:57:55 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 3/5] module: Add per-type EEPROM page hex dump functions
Date: Mon, 25 May 2026 14:57:32 +0300
Message-ID: <b173b76dcd4cc2b71ddcce4aae125be1e6490bde.1779694603.git.danieller@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1779694603.git.danieller@nvidia.com>
References: <cover.1779694603.git.danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 92986956-e195-49ce-bf43-08deba54e62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|56012099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	KYpZsxz6+4MfoirnhH69vCSp8zTHGG6/YOXLRXXmNhV98Ip4uaMUR91qpmTNAOII30cAxyXK2uIR76ADsG3SBuiI2IxkZA9Mg3oX9Mu7rtuKruAfa70TBlPfaTGxuEmzGT9aC39/ycWMeBftVguVJGVzeRuGvf7AMnFVUome0PwnkK0jHzdp1pIQBbvOylTxXRenxfRI7gJiOZmZ3uaZ5lA/+eC3H8D8apVzXyFYLQ5OjL90RxgqX98fPpaxG5Toa4fvFgZd7lk88yKv4+RAmWAsNCMfzX/Q2IEWXcwd8VBH0WAPBL1h0M83SYb359/m/70js0/Pjtv9pDolFw1ZO5CdjHlQMOcqKvpTiTaPPRHP7WczL2tdltMMr8QlVtIUhggjiBO3ogKr9eBqdXoO1bMZj9aIzo6FYtuWc9Qz86sQtsPvWf0K9CXNJBTwPhCeVZZywFslt4o9P1QT7cPPK6v3I6+Px1A1R/ZfIUV3o3okEREQgycuk7TaZV8YDiW5FvHWowqy31vgAlEjDsfb+K+fUVoky1Zgl+onoOolU7fwTlEJfGYo0o5l+VbyvVFTbPQB2psG/9ZXRs7Ox0v3ESRWXIk70iSgeW7nqroVdCpA3i5dne07iUO9ROoiQAVrKQrHa0TPj3+erhvhSxgHBfyypshe4JLjflN8rN5eSomyV/gvRUPEZUKGhHMAQtijEyL7437d6dfbnoiU+NBYuvu1vNmqUahXEcbdFKBgbAM=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oV7ES3PsCmhBtq+6vsvgrVIqG3JtLyRfWdvYZ8gF6FZe0SwIaAH65AY9k/eqedeIag3s8p6p8/SwCqBV3t5Wesl9uxGtL56UwYFWYsYVwjiPzM6OXCJ/CI80/hU2W/c8MM/xUqUBZwPmnqFq99s3QrDyjvkffImwcgIHRAAo1TtiHYiD7qe20/oCBnPxIqOdlvvXLRWoLqO1r2R9EH4TvDrirFNWu8Bmp/v7w4dYv6HNCTNsbkUDuHmSevz/4XnBmxLHqO68Kw1Evpy2j/6kMUr7Dz780w4oAkos7eyqaKoyCsG081H5TalMsTHvbc8ExCm5EW05uIXute2bVvjeFtf/DZQ//cgwsWLSLotUE4QZNYJeHUsVG6/CEv02jAP8nrK1wefKwQfdK1QQsij3FyJxo8PBy5xk6LoRK+My5br+ljGRVq+IYQIuwD6M8Qq1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:13.2889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92986956-e195-49ce-bf43-08deba54e62a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 734465CA351
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
object per page containing bank, page, offset, i2c_address and
data. Consumers that need a stable, machine-parseable form of the hex
dump can use this output instead of the text format.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---

Notes:
    v3:
    	* Drop "length" from the documented JSON field list.
    
    v2:
    	* Add JSON output support: each per-type function emits a "pages"
    	  array with one object per page containing bank, page, offset,
    	  i2c_address and data.

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


