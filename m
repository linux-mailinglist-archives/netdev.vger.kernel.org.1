Return-Path: <netdev+bounces-160979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB40A1C7A1
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 12:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B94E165509
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994A71531DB;
	Sun, 26 Jan 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W8bfLn0O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100F188736
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 11:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737892662; cv=fail; b=W0av7NCpuctKJESTIoXVPH8Ou5J+hK/3rp7YKVgBH1qx9o0vlFVFYVJKkRFwO6GLu8p794OvjYzQNJDwrLvkv8ATR9EtT1h1X/uDzmeyHQ7489OIHdxT10m+5oyKkeJy72uY+Zq8K7uVBGK1vrI1D08ffWjwyKFjkY8FHGgv0Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737892662; c=relaxed/simple;
	bh=20pu5d8OSE8JWlZfO3PUBTZhCfRUuqlX+pPQGlkUGbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fE/m0MQNrZz1l11y4J+7+Q/E0JDF5iwuBftAhmGoF7ITDjeGLaDPs9AubBVlOxTGgh7sMRBNSRJxbDXC53GzrI5ce4ZNj84cKu+BeFaHY2LseI50A2C4P9NC5CXD10DvG7q1qLiVu+g/Li40JZXh74AMkgr7PQxQCI4taM4WMJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W8bfLn0O; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owFCD6iMhfp/A7G760ARSsRpx6jhN+/ah83bf88ukOkvcu0iqcRaRh6FtzG2LjlZmtYRDfeM3WNLY82bq0Qt/6IXwDVW1yVd4Gtrmx9iR21N8Jqua5mcu70J3YM4fw63lpIHzjWKHnEnSV1zrEDueSy+yHA1ORGyEAKDA3keJXWfTaTF0xcDW/OuoFLOU+sAUma+5UFMafzGrHRG5gMYvCtbZOOs3fTNKV2f6qtitQqXFLju6E3UJXUcjaReF8gkFZMr7CnB7iYVcUTwztnL7psacMUUj59NtxJrVrT0zaXaEGSJoTZdtI10vfmMtCKkJI3OKX4vYni3K707lQapaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOFVb/jAkvIaJAf8N74yON0yoTiDjZ4XTFEgK1fWFLE=;
 b=zKsoISfowPiDH/ejVIbDgT7MyriPdCIOZ1mXt27R25veGW/p4I1SRJ/JyOC8xtGQqCThenqLLX7vjnOH0AP2qi3KmtR0q4TkWvskiMAAM7XFVETRTuMePVQzMpYYAl/eDrtt5NI3znK9F2Kkd79nWdqWVyRL82559z32pPsutmeQHSAqJPk2RgrXuo4M8FewRl5hgTDHwNttIVsRquJAWgbHP1r62sH2CuirVAMBW/mtdUs4iVmZywiY37zeI43iqkAzaDFpAPo40xa5Wo4vV1SjMdi8EWXECmTjv/nuagjsUVzV8dupJI37P8LVfr6r45LPMoa/I7j5qkxROQqvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOFVb/jAkvIaJAf8N74yON0yoTiDjZ4XTFEgK1fWFLE=;
 b=W8bfLn0OfkEStLVpUGNoSbbHb7TUi98GPvoS9C6UEA109qCcr6s+7qhADIwGsAcOIaw6Q9dnM/uE/HzoYFHjCNtocXCYKkvlDg0f17g1ilU9iaC9qkIdNxw071PUaB8Z7lEcuRowYJWMwHDUSsvSaIufQaGa2QgugB/OhVQAPKgPSAUFhvUluqrx81RcWw/YvcNQbpO2afY10DgBEoEYy/pE+tyINmx+KpHzq7+AQSvhSdyN/2dZ2jJC3Tf6S2JmKF/CYpT/UDcdWMGTW8t2vnniLuX6UPy6sKEzQk0/s55YombcGtd+Ysk81nQMdMLQbp6TpEqukfG6jv8iJ61Mqg==
Received: from PH8PR07CA0016.namprd07.prod.outlook.com (2603:10b6:510:2cd::24)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 11:57:35 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::50) by PH8PR07CA0016.outlook.office365.com
 (2603:10b6:510:2cd::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.22 via Frontend Transport; Sun,
 26 Jan 2025 11:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8377.8 via Frontend Transport; Sun, 26 Jan 2025 11:57:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 26 Jan
 2025 03:57:24 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 26 Jan 2025 03:57:21 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next 14/14] ethtool: Add '-j' support to ethtool
Date: Sun, 26 Jan 2025 13:56:35 +0200
Message-ID: <20250126115635.801935-15-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250126115635.801935-1-danieller@nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 79eb00c6-eee8-4747-c35f-08dd3e009f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8k5fCIKzjNAFO2WJtzSwvy3/6KeFlQDg4ItmqyHS3dzsmSEr8uMZzef/yuFZ?=
 =?us-ascii?Q?8uPx/xaXpadY1KQ3j+ww1V+6sSSWnKsgfbqoGhC/FntBqFMTz55JmWYBQjtz?=
 =?us-ascii?Q?q+lszmou9Lb7Us0C3rhgz2sF+HFleQQaye5S16O7io1fKuRLm68qMpal+GT/?=
 =?us-ascii?Q?MwhomoILvtaYUaDm/S2d+ejdGOu1Nr4Ce8TWuv3DygTxSuriVFY7QgAIzhUo?=
 =?us-ascii?Q?9WYeGxH/0BiyA6uFGIG8BPKaP4fn66Y5yvVtcaQZd1Pbn1w4XwkkuObsppXx?=
 =?us-ascii?Q?ffBYBpgQji3bmMbCwOrh3CeBYeDFO3bsEGR27/XhO3JOE24M0qPt+5bZp6HV?=
 =?us-ascii?Q?3/Tw0ebFIjSaLKs52nCoQs/Cw4Giy9cnc97SDKCJ89eYdLO8IceGZNelrJqz?=
 =?us-ascii?Q?Eb16jcLIek6SLpRwc5070ZVNajQ02z3LuKsLOCyA2DlrvD1cUrRkZfVTfefY?=
 =?us-ascii?Q?+F5FJWp8yfQkcFu2f3R3PBtkq46n8Ez2pvLa8smtfbmVj0T7SJVA3YKyJscX?=
 =?us-ascii?Q?sOak6Jkkb3YCxM5BIx0ghpdAEe06m98K2v+IGbcBkVHEkZmIKQgCP/3I8wRV?=
 =?us-ascii?Q?eXVjNj/YeUBeSIGbYyRjJYAdWiAc3Ed02lLcE//jiIvCqynXjb+R+iNECKyf?=
 =?us-ascii?Q?W3iwECZea5ow6c8+rIh4vzUELWNin26cLR0+OVjOKeefRkE2WGC27YhXumCw?=
 =?us-ascii?Q?FXwR5ZtY9cLSMswhQ+IttUOYm+hMm2VZq7MM+Mytnvc2FNyL/sDtFTZSP/xp?=
 =?us-ascii?Q?+7GnO3FtOLe9Aqr0kwCxcSM9Z3KnBH6N4gLDu6PiCjsKgerCnHeqeBEq0WD7?=
 =?us-ascii?Q?AaRGelQMrCAd9JkHtwe6Ipn84PTeVJjwhMoEoWkuSczUA5dt6bK/LElmdJLR?=
 =?us-ascii?Q?EHlXlaAm7689dNt+mXOeYhq4vrjDXjdmKwviyc2s/RnuXsyfSQPVwHCCcK7T?=
 =?us-ascii?Q?9uEe7bOUih3pUAUV24ESEG4UcsvSpLPDLBsb7/xN8fnQl612Uakntsn+O0qA?=
 =?us-ascii?Q?hqqdHrvsECaoTn7KXuf51+n+AnT59OmBGm9yOZQ5JAJel5FKdX1BPGR3x4Ym?=
 =?us-ascii?Q?aF2BqXE64VWdF7pZWzrLOkMLW6nJmf6Lii4EsyfkncggzqvPQwZ354YK6Ed8?=
 =?us-ascii?Q?eBaBDNeVTGwrJjyfVxOTFbNhXIXLlfbrtWaG0ZtWTxOzRcu4wTmNuoDjhBpN?=
 =?us-ascii?Q?LKCVoB7YyQV4KkK/6gLyHCiRNGOyBdZOCUWxZkDJRDHJjTo92WIwiRu9nysz?=
 =?us-ascii?Q?gNXG9ucI8XVWS5kRfxjBVeo6rKlfbQLpNJbby/GgffbseRFH0rz9YLqMwIeR?=
 =?us-ascii?Q?y9QQ5wmqPJWd4JhARRDn854hKhMDz+C9eQGU1gUa3Y9FXRnWL8LdXXTBmYYt?=
 =?us-ascii?Q?F2hog+2nQdpeBAnVr7Ir7Adc/7D0uAYr5tWmTBDYX+YBVlBjXG7IvPlnsMrd?=
 =?us-ascii?Q?HQnEWm7/1bN4NpPF/3p7O/+408zNG0AbOtKvLIiB/tGQncLlBZeWe+jUEsEU?=
 =?us-ascii?Q?OB1rdygdwv6Hou4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 11:57:34.8511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eb00c6-eee8-4747-c35f-08dd3e009f4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

Currently, only '--json' flag is supported for JSON output in the
ethtool commands.

Add support for the shorter '-j' flag also.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 51c9a46..ae17d49 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6283,7 +6283,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
-	fprintf(stdout, "	--json		enable JSON output format (not supported by all commands)\n");
+	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
 	return 0;
@@ -6539,7 +6539,8 @@ int main(int argc, char **argp)
 			argc -= 2;
 			continue;
 		}
-		if (*argp && !strcmp(*argp, "--json")) {
+		if (*argp && (!strcmp(*argp, "--json") ||
+			      !strcmp(*argp, "-j"))) {
 			ctx.json = true;
 			argp += 1;
 			argc -= 1;
-- 
2.47.0


