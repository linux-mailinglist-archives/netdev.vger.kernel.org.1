Return-Path: <netdev+bounces-163117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9AA2957C
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE6E168700
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C6194AC7;
	Wed,  5 Feb 2025 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jjhdIsBI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69119067C
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770962; cv=fail; b=fRexgc+l7saJ8P8FR9/1ikOHNYfxoHOnIsao5Ckril0cVvgaBMxHTIRD9GuKfSQSA+/IvqmpmYjFFEDP3hT9Jzlz6fzQzcZ6olmaMWjCxlmTzbBtsYmnOKOn66RbJj7M3iXedzZgXiyDG1eG4YonKqnDgSETUH8nupzihriJawI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770962; c=relaxed/simple;
	bh=IZRJjXwChqAxsN/2T9NZ7RHg5Tmt2b+uXO4M+HYE8kQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgh5NND4TWc9IbIp0dfMBP91HFyjwuBSG+unbSGBhKJLHGkGp3GXSKMginEtuX95ND5wPPXXS5/WrImmtA/BrrO5EWp1zSRj1Ug9/1yGiW+f24Duqo7cxK9q/3eW5E4ID2OWwIFL4SieWt9MHOx3q1dRndMgrPmq3M5J+5MuiuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jjhdIsBI; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ftJy7A+tY8Cj1vr6/CUwpvGU/jCK06K27IVxWqQfV+dF8e6t+7AS5ushOLTUm7heFbArGEQNrJITAY6KXHJYLSi8i//yVEsux5wa9NXymGgTd7laMXHX+7Fde3L5nm8C9weAZieBJiPmNWqyvtMdjUVhOIBnmwIjwFxBSLC2fPDRAg/5dCi/tT4fgM6UQItlIJRc1qXS5NF2OhmnLE1Yg1jraZNfHO2dQARPblB4r12kCfe2S54cWAXkJbmjeBZkdQpeczZ7l06+mijXoomtEatqo92PywGGisp5L9SnoEfN4rLmijO+SeTrY0DJJhycuO5+nUkHO/pVaIO5IKbm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=xuuGaW+ZZWofgkbQmkohf5LV9BznTfUUCPyrTYJ3IBZaul6nUvcUfz6RIpA8waNXgv+1CTAC92CHTaiE4ImQK70rtKpRYH212zgtfGDJds/NM7Ir78poeLAPnTxOaMf80+zIDstffsbKDSeQc1GXpmaSI+S3fGpZQiH1I/RA8bSSX/nsGwjsnHYwOQ0HCNjb+UHW2/ltNmPE0givyibDD6rGwbbhXikz+juW6h94PXlZVnHoJS27zc62H5Cn6zsTDkg8u6fh/9Ks59Wk/8MKLX5U5V0pgybmBRyYrTcBavZBWHMEsZ+TnrgSN9maBAtm3C6qEicXbdD14dtUwmd5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYwfgEaRU1NHuMgOq9ZNUXj1FwMbCqLYI9PU7w4nKaI=;
 b=jjhdIsBIyesI7060ryggzPqfcYCA87ZYumDmXzHhCqrS648lOGiezVStYAB9t9OmLaYJOCYUD5Z4IzVCCjpYw8tpNirC7uOgWIOPpDHVgLtznoAMpz6UBfWMchiDH31XHfbhklcIVDDnNQ+8rDPS1DDOObk6OJsJeruUKSwnlWUmkarkRB8w8It3j9/4G4Uz2FPUKQSuUXJi9W2N4UOmA+GVp1k/iflfk5RrRnijmP4yTpNEIH5gc9qWvU5kgulFfwQ02uUzNkjbYwwBxNvADcjfExSobt5mr8bb4uVGOB5c+dtvc61aUyJKSjCM1KdfQ0Z+EET09RgmjbaiHepHmw==
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:55:55 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::d8) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.25 via Frontend Transport; Wed,
 5 Feb 2025 15:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:55:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Feb 2025
 07:55:33 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Feb 2025 07:55:31 -0800
From: Danielle Ratson <danieller@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <mkubecek@suse.cz>, <matt@traverse.com.au>, <daniel.zahka@gmail.com>,
	<amcohen@nvidia.com>, <nbu-mlxsw@exchange.nvidia.com>, Danielle Ratson
	<danieller@nvidia.com>
Subject: [PATCH ethtool-next v4 16/16] ethtool: Add '-j' support to ethtool
Date: Wed, 5 Feb 2025 17:54:36 +0200
Message-ID: <20250205155436.1276904-17-danieller@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250205155436.1276904-1-danieller@nvidia.com>
References: <20250205155436.1276904-1-danieller@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: be034b87-9203-4989-5ad8-08dd45fd92fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EavZcWJYxz3QcE7P/PW2av5bfRmf4XaESs31rxlVx7dfVpHmR2Z68RwoNff7?=
 =?us-ascii?Q?wKSluRNhqjEEl8hGeAhDeaL3OkeMcUXIS6mU4no/H/jyBZg4wrNzs4c6rzI+?=
 =?us-ascii?Q?HWYRsHhCkBtBx5d1ZNbdiY/F62npwV9qMfxTx3G3oNQ/IbFOulAK0VTlZ8Zn?=
 =?us-ascii?Q?7ab80kVqfRIA74LcOfu9sbU8e4F83pcJxiMZgeCik6dcyskb47uenBCM71Sw?=
 =?us-ascii?Q?Gxw94l82F7bXd438oXUrpy/hF4DntTglPHQNR0kjGWPh1daHwxGdgiHb1f07?=
 =?us-ascii?Q?262c0xlU0GDPh/LPfnwhCiny7HN9sIAL8Zz2YaWpDjp2f/Jr09vXq0Ri9cw7?=
 =?us-ascii?Q?+E6efYK4vEi6Z3cWxRsh7cyYiMjuYhzNs9fY9W4mS58UU6G4Pi4M3Yih5qD4?=
 =?us-ascii?Q?tML5wCEgBDymHTGcewjsRBw6RRu+6ElYFvmZtc5I8QbkxiFsBmheF4aAoJu7?=
 =?us-ascii?Q?U++ykhgN6jy/6kPwz8NQrAChUQV+J2ITm8rI0kkyML3QN4E0ePUtj09dTYLz?=
 =?us-ascii?Q?ApFItmk2RucwgQUhM6C66v8wdj7LKVjfWkgntgxSew2ALxUJgrJoLevl/bOj?=
 =?us-ascii?Q?G51167HIV0j9KvWZ9aMna65jsR+/W7X1wFXSN1mkheG+Ul+0KTaREAyEMnZA?=
 =?us-ascii?Q?BOLFBZJNC3X+zrDrwfZOH+bkiO68WRyl7l5i4Q2QXvksHnJhpPcYJgm6Z+Ov?=
 =?us-ascii?Q?hTKBcOhkmtaDHzxM3mlhjiD5z97DD6QHn1eTdltk7gbssb9Aqo4lD6SIYAKc?=
 =?us-ascii?Q?7DN7teWRQQCOga+6bEfmXUyuNlAmdqgf3AlBEAoYT1Lh4MRy6vGOdPs33kGV?=
 =?us-ascii?Q?DXmpfliVWif0juGDmgcqAZgHv1VOH4QTPGkMrL6tt1B2udev+TBia2MaCslf?=
 =?us-ascii?Q?Gp1lgN7YrjGstUDKp8vUaY2Y5SqoniwJuADgBu7MqiGOXdTugfVSPskokjSm?=
 =?us-ascii?Q?jero861lOuF9pyKT+lb218ZBLNFiIE13ifUiN+jDiYU70iUh5iMaU10mP6DK?=
 =?us-ascii?Q?kPp9+nvZcfWh8xh7MukWKLFHUpZmUTFK0E3t7VuqeRyfh35gAxqAhz5FBE2v?=
 =?us-ascii?Q?YPfSw+cAkW2N62Gj1+zDDh+P55FE9fheYC7UqPIWFJVY0BmDFoUmvCXjAOut?=
 =?us-ascii?Q?KjWzt69Nu+NRdKWVANZWJZJrAy1SueYKEg0rfypC/PVq1a7GFobJZDDhWGn0?=
 =?us-ascii?Q?KJFT2+ShKZbVx/q+f5tkDX4fnd+a5GgwdaXPWjJVrmkVJOX1KKGNh4dSqRg9?=
 =?us-ascii?Q?5fnZrnP1mfQlF4Jv4V42ihjBEU7iYPZfgOMbylZiRGA2MzBD7BgsQrq9lmEY?=
 =?us-ascii?Q?iIuJo4TARTGGT1sf3SPVIcUNWw2nLFL5k/pY1yb9VQ8s9WdpzsAGnnLj5NY7?=
 =?us-ascii?Q?qZaGbjn82ohGSXEPxRgb7PBpzPA9EI06pRUg1UC3uX0f3sbuPyrguRsCHU/X?=
 =?us-ascii?Q?xJ/wMakGrAGQcdZcQ1N+LbvtB8Fa2Xs81Qyq9tdx6jCD8LDOlsN1EUC5jqbL?=
 =?us-ascii?Q?weBoTdvWHrvhYpI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:55:54.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be034b87-9203-4989-5ad8-08dd45fd92fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960

Currently, only '--json' flag is supported for JSON output in the
ethtool commands.

Add support for the shorter '-j' flag also.

Signed-off-by: Danielle Ratson <danieller@nvidia.com>
---
 ethtool.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/ethtool.c b/ethtool.c
index 8a81001..453058d 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6303,7 +6303,7 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 	fprintf(stdout, "\n");
 	fprintf(stdout, "FLAGS:\n");
 	fprintf(stdout, "	--debug MASK	turn on debugging messages\n");
-	fprintf(stdout, "	--json		enable JSON output format (not supported by all commands)\n");
+	fprintf(stdout, "	-j|--json	enable JSON output format (not supported by all commands)\n");
 	fprintf(stdout, "	-I|--include-statistics		request device statistics related to the command (not supported by all commands)\n");
 
 	return 0;
@@ -6565,7 +6565,8 @@ int main(int argc, char **argp)
 			argc -= 1;
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


