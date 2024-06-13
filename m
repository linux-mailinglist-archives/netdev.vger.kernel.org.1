Return-Path: <netdev+bounces-103393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50775907DC3
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 23:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B036BB22B2C
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9637E796;
	Thu, 13 Jun 2024 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jZ7Mb0rp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E5D5E093
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 21:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718312537; cv=fail; b=NrtuPA7+Fds/TOhG+L3ZTrdwFMbbLJwy2mKuGNmDjbLrfgM8ng8wKZLIPxoFPO764xImCQtBO8MWptd4/8WeLsTlySKj29fTudq5iC2gba+5srLkWrh6Rwcl1d0yQ6Gdo0EhS2pF5oCpTuZe3Z65AlLQ0ju7w0FQLk4omO6QZsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718312537; c=relaxed/simple;
	bh=cmU6BU8bdAUSHN03cOmfN7OG+h/0M1ClZ14BQjc45L8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=udjxTjosQnDpD5vzaCFgRLUbVSXb7uF9uUcGkdT9S4Gj/vUXY3FHSq2rGmRxpj1OQ0kk2ypitRv4/uLuaJ21X9ggF7FCI4kxznebFCv6zZEP9WtWUnh+nEQq4OgxgcV3qUBdt+UbOZuUs/hjMgWy9oMOBECgNYRIA5I4QZiw3Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jZ7Mb0rp; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8gK6K1u5xX1Gza4Pe5C0m2sU1yR/yfOwhw6IWgBv0fYImL+zKnzLZ1QhXGOsytqZiGXLk8dZYZsyF10+m162WtK3Gz+4EDV3vfw6NYXBXQNt4zFPAOnSsqqFwz2wbK7DGDvBpN51prkIlCUma4qCBZk7ZahPv/4h7d9T2ahx+/PVjsQ8RCOpuMDgGhccj8fAicJRYf1QIrPfemYjmEyU582LR5DEUcCJDyCT0fY2pDRE6j8VyMkV8r8lZANlAlPOK0XHS28ur2/u43aiCh5MQgNnS5XqwXYzd23THBGAHAZFCAB3zgbz8j7Uj+dAoBjBKsBJJ/fjYfy9jT5Kkbn7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b4nSivae1nzFOidwPPzdSWsxsle6uwUf1EEW1F3axY=;
 b=bO06oMmTpF8O75XDls9UBeq3W+ka9K7pGR+dCK700azYE0DR3/O13h9eJDZR6domZDHDmZUJErkXLdxkzdXA0ADelT4fV7TjHuKhl0/N7veY17RzCzRKLqTtpTrn3oKZkRnnqUxxsshmGpBE0KT2ydpPNuOLHyFO/FH1e+oXX0Ap1Qy93Ye4lbsaDGICFtq04vt69iDfDiNvwECBLVtHNRrAFdWV/cgFfah22uUVIeGSDbrd2FKwske5K48jNdp8A9hj6/EJydq4siRLE5OQq3BomKsxF+jWwLw+zGHZ3OYBNzmgtko6weS9sgCrN2AdAdRblbFOMnaO8AFAFZCX/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b4nSivae1nzFOidwPPzdSWsxsle6uwUf1EEW1F3axY=;
 b=jZ7Mb0rp3sYxgje6J8vJyenifCFTsv3HxhiOUl2wMTLazS5LNpIYVqWTUi8wpHzqBH+Ho+C4RnuXaJ/aQhpe5YqldGMLDH4KXp8qzMHJLc3yemP2fDH2r1noVe9nwnucrp5wdceh9z2UvymPwZUK4ZIyLnJOiL72eQFFzL4w0nmp1wKGzIMTDFOSqegZHxaZ6VuxvZi4IL0hoJhqeLSIolmX1yHMf5bTzb22ubqheOAQivFMtscuU07Ky3y1muuaQ8a4mZlTN5PNrf+VZFqt5mVYN0UmeOlOhtYnGBYt4YuNiwCZ77q/Ih8NE1CuXWWRpYz3U7GzBHS3G1ccnjGEnQ==
Received: from PH0PR07CA0043.namprd07.prod.outlook.com (2603:10b6:510:e::18)
 by IA0PR12MB8302.namprd12.prod.outlook.com (2603:10b6:208:40f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 21:02:12 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::32) by PH0PR07CA0043.outlook.office365.com
 (2603:10b6:510:e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Thu, 13 Jun 2024 21:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 21:02:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 13 Jun
 2024 14:01:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 13 Jun
 2024 14:01:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/6] mlx5 misc patches 2023-06-13
Date: Fri, 14 Jun 2024 00:00:30 +0300
Message-ID: <20240613210036.1125203-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|IA0PR12MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: af3b2d0a-009b-4621-f879-08dc8bec1836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|376009|82310400021|1800799019|36860700008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grDF7NiOfH5kU70GAGusHOgwLe/fEab0k8ZCJ40k5XSalG5j5uyP3aaCW/dE?=
 =?us-ascii?Q?m9ZQE9x5jrNc676+G/0nVWzUITScj2UZIvLwFRi5wteTusdCoZ+AxGEYuumU?=
 =?us-ascii?Q?a2YcgHFxcVwBntCqm7OrnzOqthrmk9rdSimCLJWpG5gycoNZDu5XqJQlQBjk?=
 =?us-ascii?Q?/StHMnNnVALR1TKM7aYVlWKctr2dv3jq1S4iOM7bReDDGUPUcLVon7D/IjHX?=
 =?us-ascii?Q?v3azivl0vSE/1HsZFlsiK0g9B1Y/u24Q8BQ/Ne6If6iFaAIILwYmZs3UA2RP?=
 =?us-ascii?Q?gJEqKLJQCTG7JpdK+n9KT/78820UBIOeoQdpzeFZAn4ZA9R6T/FTegYuaoLD?=
 =?us-ascii?Q?GWgXWrpJQhY2u3cZT70cLPi5qH2PbUB2MeM/XNUBXyc0mozzcTv/JyKkDgch?=
 =?us-ascii?Q?/tuFtn4C4x8EA3wCu8LC80esMn40zBfeXXK3dGqiMnUobkTs4u0acSnjMMBm?=
 =?us-ascii?Q?Kjhz7B1srd+DkrtSyI9xgWYlG6e47XGeBSwIiDX+2Gx1196FFFcSxWkskuXO?=
 =?us-ascii?Q?6rCSuFR/Tx6RvKLbjs9JGruBEzDucYGqFuS1+ihvv63wih+jCjh+ttdZnyoh?=
 =?us-ascii?Q?KS+vJV5PtNV0f+XhAz7IMWozx+eZiChEnQvrQFNJOrolXe8bC1PFabdJFbP5?=
 =?us-ascii?Q?UKHf0ulxZJxzqk+pzxxXEig3sOmNIzoDbBDIUSlWr1nAahQ6/z69v0e4+3pg?=
 =?us-ascii?Q?dBaHnS96oZ2xWht+0FSUIZ4mDesCjOkkaxrvkXag4fg99wi3MXpIcDc4uGTQ?=
 =?us-ascii?Q?3+XGOJ9O0b1HILHLqAHZ8VSD0IS0vu5YT3uCOaq6CeyMQ2s51e1GktEn6h2H?=
 =?us-ascii?Q?AIEnXzIfcTQ90W0M1+bgz0iZDO6HQF1wv9OTmsWBF5vCjW1hfYghZ6QChycA?=
 =?us-ascii?Q?9mxY4zY8Ar1GJL9NmLgRkTC37UhZJunNctaPuTxE63dBY+lxypql9WF9Ddmk?=
 =?us-ascii?Q?uxR8jbCv9Hc/lMwe17ByjifROHEKuA5J1/pHkEZho6Fk7TefI1zBqHx5fLkP?=
 =?us-ascii?Q?WY9NveZn4pp86FVbKAx9FM6McHv0kHUQczIxJTemZjJZegSOexic3hUpw1/r?=
 =?us-ascii?Q?zb0I5minRcXl/IBVZCOdlZFM3Ip7dOF7qANxnjVP63IbeZZ+vobbrVjJL4wA?=
 =?us-ascii?Q?SnY9DwtNuuEzDbPRVDr4YHN3r9adcgnDOVJdEcXCceGVX97n6UdsfVuSy8z4?=
 =?us-ascii?Q?IwGUHpKfOvZPyUzaROO7c2BT0QFPImGEFHrhcp33QxeUMav6w2Z5ss/ZlX1F?=
 =?us-ascii?Q?YdMdp9JVbqeRZSyZRIaDO5MwIjDKeij6kSGtx5kJiXnugkqjCQWxF/eHA4ip?=
 =?us-ascii?Q?uppkKSOI+qG9ZQQukSdHFQY0eB5zd3Vqsg9b2TsOnFEihX6waa18A+CIR1dx?=
 =?us-ascii?Q?z0s+hp7SE5mGBDaavXW8mMggQK5u8fm3rEyzoAB81f34XDtkIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230035)(376009)(82310400021)(1800799019)(36860700008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 21:02:11.3472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3b2d0a-009b-4621-f879-08dc8bec1836
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8302

Hi,

This patchset contains small code cleanups and enhancements from the
team to the mlx5 core and Eth drivers.

Series generated against:
commit 3ec8d7572a69 ("CDC-NCM: add support for Apple's private interface")

Regards,
Tariq

Chris Mi (1):
  net/mlx5: CT: Separate CT and CT-NAT tuple entries

Cosmin Ratiu (1):
  net/mlx5: Correct TASR typo into TSAR

Gal Pressman (2):
  net/mlx5e: Fix outdated comment in features check
  net/mlx5e: Use tcp_v[46]_check checksum helpers

Moshe Shemesh (1):
  net/mlx5: Replace strcpy with strscpy

Rahul Rameshbabu (1):
  net/mlx5e: Support SWP-mode offload L4 csum calculation

 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 187 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  37 ++++
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   9 +-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   4 +-
 include/linux/mlx5/mlx5_ifc.h                 |   5 +-
 8 files changed, 196 insertions(+), 56 deletions(-)

-- 
2.44.0


