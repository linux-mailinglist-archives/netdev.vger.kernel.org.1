Return-Path: <netdev+bounces-86987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 787648A13A9
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86346B23E91
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBEA14A60C;
	Thu, 11 Apr 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZoTwsAE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38514A4E7
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836560; cv=fail; b=Unn6N7WCozzVEIIKXi4roSaa/RpLT3JTpQNYwspYyKRycUJN9S7t7BWjIyxxwCXYtpw30iWPvmMi/xRb4ZKkHMo2lXPps6+VsHphtBraVCxTUWybY5LcfjekfT9iaaeJBA8+a7KcQ8W4bfMKuYpX7bZFqiYYj0gemIInhGxgEcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836560; c=relaxed/simple;
	bh=dvUshxcPiCOlCkF/mFHTCA4YgAiVBXiPjMpKfJnuf/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9lSWxuqkYuzUAJLM1UBZyN/ABvPSggCjKmu9314BoeTVjGzVmZPEmC+Wb3ovdNiv9BbPLLy/a49UtcWaa1Fkgr+uDBAxhCLWPelymV2/h2iDcevaXoN6c35g1zpeesGAwX0mswEHUXq9+ltjgrQBben83C/varfdGHHrYwJdLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PZoTwsAE; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2Ov5fnPKPjUn11wL0OMic+ZboqOzpcIcf662fLcWkmMuBzZeJ49WtXqtnTZa0UL2r0RREQ4N5DYZV9eLsgZBTpc52Lb8b7AY6qPSxD8CGaf0xds8GSKuHEjQJaTtKfCzYXlSWqgabaSZwF42inFUmrFLzpXPaxpZNNUYn1SQYXQFy+CLujuI3jKLxuc+27M27LFEDxN5n3Idc5biXVsXbgz2lNAX+9B4LgFsMUqI3PGPUtr0dLIuta+UqFfCaKjuUwsyUimTfb0qwlSQowMQ0lnRXM43fT4rRpVURhk09XcsL2Je2Gd8zd/YCC/Ffqrg3d/Fm3yizPVRblIcZMzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ5T9zp1d/uzlq8JbhMFFHlwls+VaftHTpV8rrZehtM=;
 b=mdIdz3wihhSk9SmA36qETKyWe07cHSqehcchK+ptz+lMIORKmp6cq+y8auDmbwcEQFnjyY8TnbIq5TJOtiEclvZeyQn02HahSxfmIsRvql+u9irwuW0hJkxHAz59tBMR8sQ6+/CtCKBcyO6XpF192XX8ULYwRTgd50cK5DFkwN+HHfJXPyQ9A2ljaJqJM26maNpFmlIqWkTTxk1Li+axh5MQ7qjHg5HkBcdeEOq9+YbfRNDfrlwfOQpaqWhbzkIxBKVmfTHnu0akFQTQBryplnI5+XAIeO7y4wEME8+AMqrnH23htVa2siAgxSE9BXhk9R0qIRWGxY6ebTKv9OzMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ5T9zp1d/uzlq8JbhMFFHlwls+VaftHTpV8rrZehtM=;
 b=PZoTwsAETzCEAx28zKC87fzIAZla/lbheh2EAb9Z0ZCUJp6GGVEb4jSePa+6fe60HyRHrDSlmKZSQBrkI95FCeN08a4YOplbm6QL7l6ew+oyUFDrl5v+9QTgVkCIS23qfJLpu03RJLbIbVASzjm9sbC+tFJmzwMqoov9sXcoIooLzOAbvcRbyljhiUZ2EEUv1bDbJqc/rGlRAM3+5B/+2G3+8nqJn9yPwpqFBguiAGL6tpwJr/CU+HN+iq1WnDNgnIoD8qEK8LeiQs7la5PvN0JDmg1Hoea1ipLIso996Vn+EfMn/C8OxBIGGld+o+ICddArQRQbfMhVmRlzRftIdA==
Received: from BYAPR08CA0022.namprd08.prod.outlook.com (2603:10b6:a03:100::35)
 by SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:55:52 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::99) by BYAPR08CA0022.outlook.office365.com
 (2603:10b6:a03:100::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 11:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 11:55:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 11 Apr
 2024 04:55:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 11 Apr 2024 04:55:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 11 Apr 2024 04:55:24 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 0/6] mlx5 fixes
Date: Thu, 11 Apr 2024 14:54:38 +0300
Message-ID: <20240411115444.374475-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eeff365-a119-4fbe-891c-08dc5a1e5616
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	US5TKgczJ5o2YKfO/368TI6W6UOQHCXvFGbkP5m88Y1kjWkI0g8u4qnmG4SXj3JHuEQB428yIKpkj27nLpiofQdzu2ddq9vI78n9b2HyxvCEwClOucbwFNeqI+yFOe1Y297fX0KaZvT90tMxwGn/+Zv7A2hXoctwqbYyeOzG711oOnQUvBlZSGxyXh08XWSXfhFyVFSWreneh7Fzy2gCIS6T4R/FG74Jev9D8IvUkzXzD3FzYlDvYk7qEfr+V6l+duRsaW1w0VJVO09kcEzmXb5XB0BrA/P/8ugHWrLUwhy6jd+cUs1qs2eVzyukRfOkwPPc/2CMeribUsuHLbfwFaF36KgPyE/wfuVvQ67j+aLQr2+6Ti8dEGn75s+5MpxEZSMgR7eSP5BmU53uDj1XdJKZpgQ8WTE7GOg8JkEubhVZyaUxBPJZSy+U0Fxzma4Pm1Yw9MgFarwOvnyOFMqqIQipWH9MbYU9h8K2tv41fLqUD1cyjBIEImNQ/GGQ7R1UfUfYAFWquGK2eNjuX+jKH+xzN45QnX5l6xK04U3/YoFn4nG6wUmvsVSsmRuHEbipdJ+zTeO/Wm3L4HCFBTQdylTzRkSLhk+Xc6Kgf9bY6CNIDjZj4BMDPmI9ULoVkJjxLm1BfHmYIe4+2fQgUQDKHKg94xNMkdtdK2NB3NYHT/oFt1OMju33W5pb2fNloA9MUrnHa1haJ+TDllVg0uTK1KQNlneC3I1IS5Ft+Fav2ZNZ4m3YemPg5Q5KZGRnqohD
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 11:55:51.8197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeff365-a119-4fbe-891c-08dc5a1e5616
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064

Hi,

This patchset provides bug fixes to mlx5 core and Eth drivers.

Series generated against:
commit fe87922cee61 ("net/mlx5: fix possible stack overflows")

Thanks,
Tariq.

Carolina Jubran (2):
  net/mlx5e: Acquire RTNL lock before RQs/SQs activation/deactivation
  net/mlx5e: Prevent deadlock while disabling aRFS

Rahul Rameshbabu (1):
  net/mlx5e: Use channel mdev reference instead of global mdev instance
    for coalescing

Shay Drory (2):
  net/mlx5: Lag, restore buckets number to default after hash LAG
    deactivation
  net/mlx5: Restore mistakenly dropped parts in register devlink flow

Tariq Toukan (1):
  net/mlx5: SD, Handle possible devcom ERR_PTR

 .../mellanox/mlx5/core/en/reporter_tx.c       |  7 +++++
 .../net/ethernet/mellanox/mlx5/core/en_arfs.c | 27 +++++++++++--------
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  4 ++-
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++--
 .../mellanox/mlx5/core/sf/dev/driver.c        |  1 -
 10 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.44.0


