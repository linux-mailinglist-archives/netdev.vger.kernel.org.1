Return-Path: <netdev+bounces-291303-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJsjOqI5FGorLAcAu9opvQ
	(envelope-from <netdev+bounces-291303-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:59:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FE5CA36F
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 13:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82BE3012C72
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 11:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A837F754;
	Mon, 25 May 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iM5x5feT"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F213803F1
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779710302; cv=fail; b=SifxO+PojJYqzmZZa+628VOcXOoGUs9P6urSgaR5hN+lYTogWSS5FWvehwOtMXJDQjFzgUDQebyWZh6UZNQjiQD5jm0QTxzQNOgssumNLQlo1x81fUMyydf2ZME4WgG36oRBWsy9rT9pzMUbKxUzEmmJiaQ36p9XwEXFZWdlTsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779710302; c=relaxed/simple;
	bh=6YSgIdhweZgZegHKcVkvpA6/CEoYej4PJ6V5FUFtdH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXxJAMyoFbP7yZxurZRYb5/SWUgHvZMvpc4fLDQF972Yjf9JXh1+DObzbI1zFEPYWqUYM7fbA5PjZIWZ1wz9C8pKtKURVT35FpeY2FZMrVyeaXXBmUL43vAVtm7u6BeT0glIUgsIjKZZNtq4Wph55bXUTiX2vBCKkbol5EJU0eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iM5x5feT; arc=fail smtp.client-ip=52.101.48.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9stFgD13NVPqmxtBJ8auNqkB5JFHsefIq0GS+ho7xEEfYgNIq33uZId1mW56IoqjZwPf0QvBKc+3zsGRSLXgHy1odgXNIMBa5JMVjFZU+fJsYWbpCc8bcoRglNV4xZW+afEJzB0GTGATAE4HAkx+NueN2gOFkTIdTCBd+p/xGumZU0Y++4Q0NKuavP39VSwnz2k5t0xvyxRm8jykmhl3wT8hy6gpBsqV00/8mkEUwwMJzThDs8jgpF9Y+w1OkwtKzxZMOO7SwFpIoKMNhnywtII4zuFl4gIj+qOSKJaw5Pp8vT/M9DaOqAQrywpCuYogujFFv4E6mgY3wypSGbL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9crrpO0aoJ5iKvxZhN7tgA8AAqz2Ao26Xp/sYStcVu4=;
 b=NqRVUenVwAtco7o18Bve/BCR2r8tbKuY7OmdbBlgKmzbQHZXerKxoC8CowZtBFr0j8Px+ItPL5BGLZI/Cp9xAR0qUllom+OEANAsoq1zx7lLTIm7dkzWukfOrQ0kVmsIFOEWnRQbCgMEuiOAmvIjZibkkbL8UEvxaCMHPYd4Ybz84BIP8ildS+hlQUywOTc29XFbNt82VFYIgihyyyaUdq3WGdla5ElagfmNhIJIZ/VY1Vet/VLcYLbeZXeQ60fuw2leDtH7UleXHYR+9jCd1wp4QjfTfgkiK5csYEvOgxN/yblvYztGfLK6BTv+E07GIVhc0pj6xOMk7WkAq2fGQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9crrpO0aoJ5iKvxZhN7tgA8AAqz2Ao26Xp/sYStcVu4=;
 b=iM5x5feTVVU53Q8xB6s+xM+DyYZeMzQFrlvz8OuLVCayr+2Lm8n2zPzXlqJezC5XxLJDaOwQA5bOrnT2YznrAPj3HrrIDefTQqlL8u5f2v5sp31ifCA4zIUqY4ObYa2x74E0N9I0VU5fY6bcjKj0r6hgm86oBIHl5HcLW3+k47V6W8B6I32jGcuXWLLFOefCU95rZtWqlhnZ3j7OmUQzGyHUTBV60dfQJE9KSMtrz+5LS1dsez8UlzAfEbSmdDk1fLLaQfBKKC3vRXC2Vqt14JS5kRc/voPTfRVQ7fhomhtsLU4AFU7ZJN4BH2mk6Tqay+cXXNeuhL3b5yIU4ETUvQ==
Received: from BN0PR04CA0137.namprd04.prod.outlook.com (2603:10b6:408:ed::22)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 11:58:15 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:ed:cafe::63) by BN0PR04CA0137.outlook.office365.com
 (2603:10b6:408:ed::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.20 via Frontend Transport; Mon, 25
 May 2026 11:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 25 May 2026 11:58:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 25 May
 2026 04:57:59 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 25 May 2026 04:57:57 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next v3 4/5] netlink: module-eeprom: Add 'hex on pages on' option for page-organized hex dump
Date: Mon, 25 May 2026 14:57:33 +0300
Message-ID: <4f7d3cd5d22b8909017cc4b96479eaaf90e41c3b.1779694603.git.danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 362c760e-8534-4703-8968-08deba54e6f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003|3023799007|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	GsUygdhJR6jhsPiE9nkqlc7r/5BE1/NB30oeCHlECKPRDqixn1q1CD8pi0fe6JHde/hze186HT8JlvYexlUy+bD+6tnRBLtRUS79AbOMCBobH7cHS8L1Z6cRoKu+otg6IN/LPN/y5zckRu8cBVVMxUBfQbrRXiOx7GBCZ1WndQNsDP0c962QGqZuoXxytnchctcL99ocaGDyV6B3zKCdHK/qE+YXFaKz17MavduoP+FJt0CfYTAGxRF+8jRIj5GnlchPNLqrs9YukOJ9yICXGraxuyXajO5L3KNJUDkkPPKMG+i+d108Y1YX68NAOsiAXqbdkFIXQzdvya0f6lrlBFiQfFneJBvnZIUmLk1hXwJA7VPvq+BG0tqVArTi7M2PA5gRWCIl6csXWZkf2WX5ZEyrZNr1ijnoxOcUo/HLj8QXPiF+feF8qMO2rEWG6eawkYZFJ+E1UaETI4Pdj9laNVvwDne0HCuwY1ZBwol4lPEROmzjIYXVTdSlF2QwMgWo+dDYp0jx6z8s7Lzjg/yB5vR7V0TUMG46W0a7dVyYoF3i3yteGWs/Kx4hSy2mm46rbNSbY3ttavulnCRGiWjKCVDrjc8pzFzZrXmZV65sKwukO4S3DuX63Fiwt0/trmF+arvqZ6d65E6XzHhalS1mYsqeKb8OXqqSoYcY00v83Rp4gqW9J3g/WHInCJIGISPEFUC+C9lRrHqu88Hzlf7z5gB3mWFUExtIJoyRvZywiz4=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3023799007)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U48g3ZAILYimbeko3lwBp19Qx038GGfVSiw+MZ4KlGYFBGSz9V57Zy/YO7dNzz2/jxjQTYuT+yHX9ZQEUTIiVs84TmIRak7ESUVOBJNjL972mpz19ZMkRa9lpjDCHC8JuMhV7GtBn+h+uSq3DFlVkDeB+f72qVS09zXZm1z7CGU2/roV+yawtSRjDoSvoU8gVlkMTHWpnNVIyboxCQcSA3ip43b6CzzDR+3O0xz79MCO6TnekzVYH11KKu0BpFvfSoCDW1ut6/9mCIQ4Fo4ofQqQ3WK6oJbqpinAn0fIMHgruUKv1l7lj7iuyJA7dt1aBpBQlwiBLrE++9iUQO//bJVWichScyLb7MfZsGjbB88P7UFlN7G7xDCVohOBwSVieVxLc/1p6hdDpyw5+Gr95Spmx1KjivxmbPuEuvifWKTth/f4pPnSAT75kKU6XLud
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:58:14.6086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 362c760e-8534-4703-8968-08deba54e6f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291303-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 384FE5CA36F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add 'pages on|off' sub-option to 'hex on|off' for 'ethtool -m'.
When 'hex on pages on' is specified, eeprom_parse() dispatches to the
appropriate per-type function with dump_pages=true, producing a hex dump
of all relevant EEPROM pages with a per-page header showing the page
number and optional bank number.

eeprom_parse() is extended with a bool dump_pages parameter to select
between pretty-print and hex dump output, avoiding duplication of the
module-type dispatch logic.

Unlike plain 'hex on', 'hex on pages on' does not fall back to the ioctl
path, as page selection is handled internally by the per-type functions.

Unknown module types fall back to dumping the lower 128 bytes.

'pages' and 'hex' are both parsed as independent flat options, since the
parameter parser does not support context-dependent argument recognition.
The requirement for 'hex on' when using 'pages on' is enforced by an
explicit validation check.

SFF-8636 Output example (values zeroed to omit vendor-specific
identifiers):

$ ethtool -m swp61 hex on pages on
Page: 0x0

Offset          Values
------          ------
0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Page: 0x0

Offset          Values
------          ------
0x0080:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x0090:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Note: 'Page: 0x0' appears twice in the output. The first block is the
lower memory (bytes 0x00-0x7f), which is always accessible. The second
block is upper memory page 00h (bytes 0x80-0xff). Both carry the same
page label but are distinguished by their offset range in the hex dump.

Assisted-by: Claude:claude-sonnet-4.6
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c               |  1 +
 netlink/module-eeprom.c | 43 ++++++++++++++++++++++++++++++++++-------
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 2444d85..8869c06 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6165,6 +6165,7 @@ static const struct option args[] = {
 		.help	= "Query/Decode Module EEPROM information and optical diagnostics if available",
 		.xhelp	= "		[ raw on|off ]\n"
 			  "		[ hex on|off ]\n"
+			  "		[ pages on|off ]\n"
 			  "		[ offset N ]\n"
 			  "		[ length N ]\n"
 			  "		[ page N ]\n"
diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 7e4e6ac..ce88475 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -25,6 +25,7 @@ struct cmd_params {
 	unsigned long present;
 	u8 dump_hex;
 	u8 dump_raw;
+	u8 dump_pages;
 	u32 offset;
 	u32 length;
 	u32 page;
@@ -83,6 +84,12 @@ static const struct param_parser getmodule_params[] = {
 		.dest_offset	= offsetof(struct cmd_params, i2c_address),
 		.min_argc	= 1,
 	},
+	{
+		.arg		= "pages",
+		.handler	= nl_parse_u8bool,
+		.dest_offset	= offsetof(struct cmd_params, dump_pages),
+		.min_argc	= 1,
+	},
 	{}
 };
 
@@ -207,7 +214,7 @@ static int eeprom_dump_hex(struct cmd_context *ctx)
 	return 0;
 }
 
-static int eeprom_parse(struct cmd_context *ctx)
+static int eeprom_parse(struct cmd_context *ctx, bool dump_pages)
 {
 	struct ethtool_module_eeprom request = {
 		.length = 1,
@@ -228,18 +235,18 @@ static int eeprom_parse(struct cmd_context *ctx)
 	case MODULE_ID_GBIC:
 	case MODULE_ID_SOLDERED_MODULE:
 	case MODULE_ID_SFP:
-		return sff8079_show_all_nl(ctx, false);
+		return sff8079_show_all_nl(ctx, dump_pages);
 	case MODULE_ID_QSFP:
 	case MODULE_ID_QSFP28:
 	case MODULE_ID_QSFP_PLUS:
-		return sff8636_show_all_nl(ctx, false);
+		return sff8636_show_all_nl(ctx, dump_pages);
 	case MODULE_ID_QSFP_DD:
 	case MODULE_ID_OSFP:
 	case MODULE_ID_DSFP:
 	case MODULE_ID_QSFP_PLUS_CMIS:
 	case MODULE_ID_SFP_DD_CMIS:
 	case MODULE_ID_SFP_PLUS_CMIS:
-		return cmis_show_all_nl(ctx, false);
+		return cmis_show_all_nl(ctx, dump_pages);
 #endif
 	default:
 		/* If we cannot recognize the memory map, default to dumping
@@ -272,10 +279,28 @@ int nl_getmodule(struct cmd_context *ctx)
 		return -EINVAL;
 	}
 
+	if (getmodule_cmd_params.dump_pages && !getmodule_cmd_params.dump_hex) {
+		fprintf(stderr, "Pages dump requires hex on\n");
+		return -EINVAL;
+	}
+
+	if (getmodule_cmd_params.dump_pages &&
+	    (getmodule_cmd_params.present & (1 << PARAM_PAGE |
+					     1 << PARAM_BANK |
+					     1 << PARAM_OFFSET |
+					     1 << PARAM_LENGTH |
+					     1 << PARAM_I2C))) {
+		fprintf(stderr,
+			"Pages dump cannot be combined with offset, length, page, bank or i2c\n");
+		return -EINVAL;
+	}
+
 	/* When complete hex/raw dump of the EEPROM is requested, fallback to
-	 * ioctl. Netlink can only request specific pages.
+	 * ioctl. Netlink can only request specific pages. Skip fallback when
+	 * pages dump is requested, as it handles page selection internally.
 	 */
 	if ((getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) &&
+	    !getmodule_cmd_params.dump_pages &&
 	    !(getmodule_cmd_params.present & (1 << PARAM_PAGE |
 					      1 << PARAM_BANK |
 					      1 << PARAM_I2C))) {
@@ -300,7 +325,11 @@ int nl_getmodule(struct cmd_context *ctx)
 	if (request.page && !request.offset)
 		request.offset = 128;
 
-	if (getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) {
+	if (getmodule_cmd_params.dump_pages) {
+		ret = eeprom_parse(ctx, true);
+		if (ret < 0)
+			goto cleanup;
+	} else if (getmodule_cmd_params.dump_hex || getmodule_cmd_params.dump_raw) {
 		ret = nl_get_eeprom_page(ctx, &request);
 		if (ret < 0)
 			goto cleanup;
@@ -311,7 +340,7 @@ int nl_getmodule(struct cmd_context *ctx)
 			dump_hex(stdout, request.data, request.length,
 				 request.offset);
 	} else {
-		ret = eeprom_parse(ctx);
+		ret = eeprom_parse(ctx, false);
 		if (ret < 0)
 			goto cleanup;
 	}
-- 
2.51.0


