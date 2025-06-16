Return-Path: <netdev+bounces-198058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FEAADB1DB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C2D3B7502
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37B2ECEA6;
	Mon, 16 Jun 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iMs7gvY0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162132DF3CF
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080377; cv=fail; b=bqVXAU4hQWVFyePQZVyoPoJcls5rgNC79xSM1WJmw1QiDvy41BWSovArdQA52nju3cL8+tRhU0K3jkJ84D+QVUxlr/pA4QuoQ3SewNUyUygGNbwQHWIMWoeOe+Vkb0PkVpSqvlE6F3ExnIWhJ/CIcZXrsmYEBcjRZon7qtdUBsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080377; c=relaxed/simple;
	bh=di9thphYRSBF0LUbP8dfeOpDZEs7LPo1O/A79bqw2vQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z5qk8EztdVAiJHlwejQq+a7zI6JxjfOvysB8p6Akc9ECXVM7ix1yZMDCOe2CsFwRv3eGfbm/B878+Eq+nksYBGkBMJW3rZsARKAqzgKtAb4XA4zJcOyF/Br6q8n6JnaH0kcDKaJ35pGAR4+iqK4SSwSUOrfyo4wumRvMhhWW9l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iMs7gvY0; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL9JOVlYiwD3QiLHOUIOt9GXMG3WaVTGM9mX8G3ykP94fe/DSULV3+Q9iQQ2+yT+TL2sL5Axu0tP7AFsmg1pK/RW1k+RkvfpwN1wqQQ+HGMZFFxGdOeGyzSB1DuYTCqxvMGn1io9e9bpXWcZ5JgLI/k+e9Bg/CA/R/QBI8z1eBS7XXm3HhALCmsSlwA59cYuoAWY7mSnxv4shRrgcWoz0EbAwc3M4ZAgp1lM3bVF5fcfTWSUGw/TckpH5vB9gsmnS676A5eQtNEe3pF1RQZ2LlDk+E0Nfc9IlgcbterYNmTPvvbaMcX4VtYyGRgysSOVPNcB9Qzgcoxr2mx4X4sz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlJi9jOrWp8hvFLXGtzvS9Qyh4W3GfytDsSQMXfZSpw=;
 b=N8gfwMuf/ygtw5s16xkZw6XbIIlWXif9hgBbYlaq4wrHmHs1erFBCrfHbanKv2Olh4FrJXs5cEr1KGne1VRITRCVVLQMd3Bjs3ulFn2X4c1Ca31gHRGo06L55Ah6Kpic+8/QxPISLVwpiGxzm1/KFMzBYK7jWRkewOqEDnjXMc9kbw25vo10EbWpZfjH2hE2hH98XrnRIGXuweu05G588MnSssY7K4K60EGEtwbdQJUrpIuDR82Tl7y3x4JwcviqyWULC7tMOgM1BXYaHQGjUB79hvtH2vSGs0tOPNIgVR9t95kR99C+r1SFnbelKYQVVBSVKWMptf5t6OXR/Uhcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlJi9jOrWp8hvFLXGtzvS9Qyh4W3GfytDsSQMXfZSpw=;
 b=iMs7gvY0cdcxTIaGF+WOO88m0hZ0kQsoE3nHCG1ASUhfJSwFQJOw/3QpVp/2u4oPoyOeRVMatsGQIcdiazHKUzIxeldReEkfj7TYIfM5revi83LOE0XONJn2VKjaALnMwe1yUcaxOrjKNvqXl/aul2uipXQIN4A0D8i+ZpdbYhvKBrVL93MPcSTBY7XK7aiCSi32ORlyTzJRj980zalV466fk97AnIvKq5pL+p5/dc3C4PL08FXwza1k/CM6fBheqnObbIg31DupLn7u9HVlieVCifiac73QVDZG55WWBmgYhImOydV60USykovpNsnnt3Q6NpXI10BTy5H87VeJJw==
Received: from CH2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:610::35) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Mon, 16 Jun
 2025 13:26:12 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::11) by CH2PR05CA0022.outlook.office365.com
 (2603:10b6:610::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Mon,
 16 Jun 2025 13:26:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 13:26:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 06:25:58 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 06:25:58 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 16
 Jun 2025 06:25:56 -0700
From: Gal Pressman <gal@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next v2 0/3] Misc vlan cleanups
Date: Mon, 16 Jun 2025 16:26:23 +0300
Message-ID: <20250616132626.1749331-1-gal@nvidia.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d0407bb-e3f1-40fd-0ebe-08ddacd95cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVFQMHl0MytIV0VNRHdkME5qTG02YWhWNnNNcWFEK1g5TlFLNHZJSU1GYjNX?=
 =?utf-8?B?VU9BVGN1TTBvOTFxTWkyRFlZVE5TMlpUbkZ6NFFxYUE2d3E0TU5uUDJUeXNP?=
 =?utf-8?B?SGtlakUvMTFTak8yVW9iYjF5cTJTSVFPcFU1L2NhR05QektpQzRBMW9pV3JV?=
 =?utf-8?B?dHRXT3ZxQi9mSHNoVnE4NjhDb1dZL2xUc3ZKZ2dQQUF5RlB4TGJkZnlOZVhP?=
 =?utf-8?B?cEVsc2lCWVdvZ055Z3VRZlhpMi90UWhYM2F5Zlk1d04xZmRua05GL1c3ZGlJ?=
 =?utf-8?B?U0ZRRXlXbUFEMjNnNWl4RDFRaTZGTGJWUENNc0R0UWxKVVloMFBGRzN3Ymhv?=
 =?utf-8?B?UmI5K2ZOZVVjeHBDd1UwR1BLTFBqQk5VMmtPWjBWSzdmT3ZrUy8wM3ByVkxE?=
 =?utf-8?B?akNibFoyK0srekU2Q2ZkYVNtUTN4YWxGL21qK01oZE5ZQUx2YmNXaG50ZGx3?=
 =?utf-8?B?cTloUXB6OWJTNU93NSs2cDdreXFJU21XdUdweC9RL3oweVZ0QTV0WGxnNW11?=
 =?utf-8?B?OGVwOXlWMjZQbC8wY1NTQ3U5V0d3anBSaFBOcWFoMkp3R2NpUEtNQTJwazFw?=
 =?utf-8?B?Qld0OURuVkM1V2hDOWtqWStnTERHYUNvN09KbHhQQjdUWThLY3hoS0pyMkEv?=
 =?utf-8?B?a3JUYVhQMDRMRVdTSjE3MUJ0aHQveTJUY29Oa2FKc1JKZ2xqWVZEUmJRWERv?=
 =?utf-8?B?SGp1UEsyamNIZXBNWGd1cXhmeExMOTVxamFyNnZaVzlEM0dBcUdQUCtLU1A5?=
 =?utf-8?B?WXU5Sm5FZUdtYXpVS1pWdjlLazg2cnIvSHJpcG9Nbjg4UkUxd2xTTVA3RUVu?=
 =?utf-8?B?WmJWUzlGRG1LVGF3ZS9FNWZLZnRYL1V0LzJJVmdKOG5CWnBKWlhCakR4YUR0?=
 =?utf-8?B?cDhxZ1JyZUtmcWgwRlJYNDNPbll0THg0ejhqK25tYjgxUmsxTitKS2RLdzFu?=
 =?utf-8?B?RFBvN3JQQ0MyTDZXTUdjRnNyMGVVRHczRk9hc0JGdTlKK3hRWlhMNEROZ0ln?=
 =?utf-8?B?aXhmM1NabUN4NVljdkZZWjYrUURYbTVaTU1CWEJ2cnd0R2ZQMWpzckFTdHZT?=
 =?utf-8?B?dUZ0NkUxUUVRTkRjeUxqUGxOUXZCbS9Yek1HMVJ0YnZ2N2F5cWI3RXpyNGcr?=
 =?utf-8?B?TytTVmE2UmluSmo1R0psY2xEK0JRclZ5S1hyVDgyMEx1TWFlT0V1Nkltb1J0?=
 =?utf-8?B?NDJ1ZVg5UFRKUThRSDU3U3g5c21GWFRDTjNPb2ZlNlNiUkhWSncyUUlzOElw?=
 =?utf-8?B?R2V6a1ZIbVZqUzVMYUE4R0ZVZVJMS1FnQVdoV3haL3VhdG92OGxieDdscXow?=
 =?utf-8?B?RDFIK0VjeVFDMmxybGhPQXkvRjNYNHRQYmkzaWFsOW5PYytvTmp3R0ZFK3BY?=
 =?utf-8?B?UUl4ZHNDbFpKcUVkL2ZmOHk2QkFDZzhQT3VjdGVTWnFMczV1UlVXVFQ4Sita?=
 =?utf-8?B?QWJDenhWaGJ3SzhiN25jaExGb0EyZy80U3NuZEExRS9vNmdEWFliV0lzZWhk?=
 =?utf-8?B?amdsVHJhRWM4d09tM0xRaWtaKzgxMHJzcmNoMjdKSzg1TWZmcitQZDYwVytx?=
 =?utf-8?B?cHF5OUthS3dlVXZuVzJDS3NrcnE2ZnZyeW1VMmN0dnkwVExPZFM3UUV1VUxw?=
 =?utf-8?B?RjRmTFJLNnBXMFpjakFzUE1LUklMa252cFJ3QVI0bTg0cUxHeVBVa01Vc0RP?=
 =?utf-8?B?OHVRNWdHdUk1YjV1QjRaQW1xT1p6S1U4NDZsSEZLeHI5QzdjaUZ3YlBJeEcv?=
 =?utf-8?B?RWlHdUwxYldCZ3dmeHZwVEZDQVlsN2R0bEcvWmRSR1dkVHNIZXlZaEZndUwx?=
 =?utf-8?B?aXBwUUI0MDJzdGJ5bVJOckFtMkcrdHVUdDk4RENhMkEyeDZoR2svSlB6SmRx?=
 =?utf-8?B?N2M5UWdvNTU0Z2g0dVcySy9vQjZUV3BjMnVnRDhFaVUzSTBiR3NZK0MreDYw?=
 =?utf-8?B?Zk9iZStEcGYzUzBqU2Jwc3JHbmhkN0hzTHZsY3ZSZUdaMEJKdlJZU002N2R4?=
 =?utf-8?B?ampCRWErTHhKQ21zY1pGNUxlT2xleUdIVVNtUkNNYno4N09aaStxWXpFU0tT?=
 =?utf-8?B?UkxGVEJlQ290NkdmRzdCeWI0VkpSRG5PYUJpUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 13:26:11.8322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d0407bb-e3f1-40fd-0ebe-08ddacd95cbd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

This patch series addresses compilation issues with objtool when VLAN
support is disabled (CONFIG_VLAN_8021Q=n) and makes related improvements
to the VLAN infrastructure.

When CONFIG_VLAN_8021Q=n, CONFIG_OBJTOOL=y, and CONFIG_OBJTOOL_WERROR=y,
the following compilation error occurs:

drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.o: error: objtool: parse_mirred.isra.0+0x370: mlx5e_tc_act_vlan_add_push_action() missing __noreturn in .c/.h or NORETURN() in noreturns.h

The error occurs because objtool cannot determine that unreachable BUG()
calls in VLAN code paths are actually dead code when VLAN support is
disabled.

First patch makes is_vlan_dev() a stub when VLAN is not configured,
allows compile-out of VLAN-dependent dead code paths and resolves the
objtool compilation error.

Second patch replaces BUG() calls with WARN_ON_ONCE(), as the usage of
BUG() should be avoided.

Third patch uses the "kernel" way of testing whether an option is
configured as builtin/module, instead of open-coding it.

Changelog -
v1->v2: https://lore.kernel.org/netdev/20250610072611.1647593-1-gal@nvidia.com/
* Add the first patch, alternative approach suggested by Jakub

Gal Pressman (3):
  net: vlan: Make is_vlan_dev() a stub when VLAN is not configured
  net: vlan: Replace BUG() with WARN_ON_ONCE() in vlan_dev_* stubs
  net: vlan: Use IS_ENABLED() helper for CONFIG_VLAN_8021Q guard

 include/linux/if_vlan.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

-- 
2.40.1


