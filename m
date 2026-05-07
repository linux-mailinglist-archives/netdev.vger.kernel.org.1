Return-Path: <netdev+bounces-285291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO+uNQd8/GkwQgAAu9opvQ
	(envelope-from <netdev+bounces-285291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0BA4E7B62
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 449CB300D765
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9073B895B;
	Thu,  7 May 2026 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qz68A2ds"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7573ED131
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154498; cv=fail; b=a+FuBHGLwVVphp8qYZMSZA9kHyc5dPmkuW8Yf5dq2tPFdWdGocbC3SLw3Xvj8lbBpI+UmaFtcu1Y/zXemZrAt4n3X0fZVeEbMO2Sc9N0ArihzXJTeDk4wJpWl9iGX86tZUBwz/oqzzV+NxtQMiZxn15GmsHxySgrqBtUr3ShF3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154498; c=relaxed/simple;
	bh=iUy/upoybb0hXmGP+Te5JJaEQINE+kIZ8+kCvMWqXrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B+ZUm076C0aZBXD0hrJ/LQt3nKrl5ZOzK84a+oGp3smC5Nh4G8TDyrkWG9YelfWbcf3pm+Z8B2LvoAbtfKTRTkzYHMuP05hKyu1gCzSGCGdzYraBAiILhLUFKjvdDPx/L6hF57AYZeuqxCFefYPffMp15BXUfDblR+1eimIo4L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qz68A2ds; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzQM/Bod8j/GuaEU6iVxfxIR2jRVAuJP6DZNMazJAeuCWBN5uuo8lLdce9nG3NTV7jrrawcvBPvPbjihen6/0XQk/gspvEE9BWSs7+MUuR+qRGIBPtd+evGryKa7hlbTwkuY5VQlz1JFcCWG/F784EaK95qo8ynBkCsaxaZprSy6RZqhSCnVDCoKH85KVp4jc0+ZgB6EJhhUeyamIfVZR+JVSbVhjzBxQ/+/Ctu49UtRp8ADLZcbb89nw1xSaq1xWZdTn+qV7QgImGp2zTJkmQWq9kyDrJBGbK4oxWikpxfGsndTaDeAtk/lEZXOz1eEoGx+3XiVew2MyHGcsZX8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUGusu4qqwT4IUyRYp+0P5UiKxMrYtgbgtk11qlwu/k=;
 b=vVjGWwuEIN302sCblyfqH5u0Fuqe+BFop3p+lMiEjXXmClOBUkPylAEAUXyGcQeIU1wmR1z6NPHkQi4NnOXCR/GefXN8g8uBRXNgx07l4sddDR1BtRk+iqIf70gsJEQJqoOPAAExQHGxyirP/wBV48raxhw40jzPMO6/ti7HVOII40+7+Wrocr9sYvOVnSwiaqG8dhQDPIEmZ5Qclo7p6xs7rveO2x/+H7rs00FlbcJ103JAOHLAavzQ32eTzyavvLdcokGmiqwp/DeVpx1d8AY2o5/oxXOy1+UbDxOF6DXyhDkLHyM7j3Sq0xGcpzLXu1Tf+MCAaR6ZuO35nyNjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUGusu4qqwT4IUyRYp+0P5UiKxMrYtgbgtk11qlwu/k=;
 b=qz68A2dsQtLwQtSuliHolDwKeBssU1m47fzQXmcAQ/MypzxgW77hlp36j8ROOKgJRWywfoWk2espd0GescBBUCW6rv9fJS+PyQeOUBsqeFSXQFtZPT1S+mSNBTKBYs2F8+HXD++Rn0j3JXtsH/LQFncGjPnySzdZMaGYVymO27ibr3i3I+HEYxkDeCBQxg8q/S2OkFtLE5yjbbZxRS4O+S0qnwbSBokH0QQgPgw25nI9+dwzpE+SHs5fsf3lhpIoQsQJKuRaq+T2nhFQt7zNPtaQWjPtKzK4EUApCvzcwdCxkBfuvZH36FQTlmXQgxZYwNeHiE8mLaN4h5vYzWRpVQ==
Received: from BN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:408:e4::15)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 11:48:09 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::26) by BN0PR02CA0010.outlook.office365.com
 (2603:10b6:408:e4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.17 via Frontend Transport; Thu,
 7 May 2026 11:48:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 11:48:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 04:47:53 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 04:47:50 -0700
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <idosch@nvidia.com>, <petrm@nvidia.com>, "Danielle
 Ratson" <danieller@nvidia.com>
Subject: [PATCH ethtool-next 4/5] netlink: module-eeprom: Add 'hex on pages on' option for page-organized hex dump
Date: Thu, 7 May 2026 14:47:20 +0300
Message-ID: <20260507114721.3409128-5-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc03a4d-591d-4673-1720-08deac2e82d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|3023799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	15WvOBhfBLOpU0ZlnUYMbkIKH2LxgZQmCwI4D8OxRzDntPuBy6xkyytYKB7O3Fg/Q7kIkyhd0UqNJtnIsaEuaQX35lia4sl8qRw7aa1E3ZSZE1/2db00biqzX+aoRUDpL6lyfl70O4aF5Ojz7sYEB/F1BY7yBRR+hflh3iGafGCmOkQ4QK9gzgRR6G4b4g0qO2JkUvpfRI0hAQbBO8jquc/T7q1nLbAWPi41hnr56HRnMmYp0C+UuudBO/BXW44k8PNX50qhZjo2JiPXbboiD5h/cjPiiEja45OfsN9ritfD9dPJKij8D5Do65sD7HMaXtIRIa1XpMwMv8eB4gZ3TBlyQzXHZXN6Uf8U5sbSjJK13FmvyHbOxi1dNe6061jlCWETu2uKJHuosRC1is7FO7sW9JcjRXeO51w1vLdlDZX0OjI94cD+ct6YkK+gSp13fMEH+RnWlzTzoAYY3dHkBGTgEiy/kiNRSJNGtU2nnIShnfCI6hoNwCIF0heIyhqeDLL56KfPQNT6QW6jhkhDesFCu4w0xojb4PWhDZE/YaTt2xyp208uhIflfFb4BTwvZVaXGoMe5gixFybtz9rz+hnUpPdfZ9R3IETHGYjjzD8uZlPfUvjxbEBbDZjFFluO6iiltI7Dq/f6qXUXVQl3dxol9otyakY1gYmvU8ZiVsX2vxkqGNYhN8X7CQ1pzVRxr/Ybbyekf6T8y60EQwlgLATx7azSHs5/3cr2jT5DzWw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(3023799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k+m+CQf9UXcvD/0oT1BPARBBblAtrUcsG/pHlEW8xtx/JAcf1BJY8TVLG2urho39SXenjFQrN42U0u3T8ktH9x0bUzZojo1xC4BWrjesBTy/SFkSIBvLis1MXJ4NOVmk2TwZUmmJq2f5nveH6AzllXmMTEJMG/jNzOcGZq1L1LxcDaFU1CxWod8bZgrnK87F82J58j4KtjaAY9gfFVASt3wNyZ5wFjllKT7hmW9ff7pgyBilPon7TcR5S0jN08JV4cPeyBail4ktIBOovR8OGWKPixhRDD2ZuTBENTW3HKpxtiE0ykRX0oyPpgAMPN+jg2nHvCGZJI1HLU6im+cWs0zpxr/DcSBljFtWahsMxlZAS8JYMXJs5q3H3xvteHWJHdkUx8nO37a7gxqxpxms7kk9QDZ9So9yVRAKtshYnxaFK/pHaguSq68tgprFW4jn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 11:48:09.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc03a4d-591d-4673-1720-08deac2e82d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
X-Rspamd-Queue-Id: 7A0BA4E7B62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285291-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,request.page:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

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

Output example (values zeroed to omit vendor-specific identifiers):

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


