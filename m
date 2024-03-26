Return-Path: <netdev+bounces-82276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F888D0AB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 23:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3739329C51D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6888C13DB88;
	Tue, 26 Mar 2024 22:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nIOUIlA5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA66713D8BA
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491676; cv=fail; b=nuXvyq4Ys6ST1MZgnv2evdDTvim9uuRPzzbHqT8FqaP5xJok36ABL6yJ3fcAZ5dwildXZYI8jEj7hNN7XD8uWCm80e60EZR+RHEDuZjMgHKCM4jWnjM1Vfk+Nz+Y+GuMqQVvO/BAZfDAP6DHoTZbJrVc5e5l99uIxkXTyMDHKmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491676; c=relaxed/simple;
	bh=+QMWUZyTXK8mm+No7ZKVK1wSzcT2E5UU3Vn4WXrFNtY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ru/VuR3M0MMs2mX3vcHBExnFHirQYK9jumbI2fOCwa+sNAh+U8+A/VI0QuNjqB8/x2nMqapqKooNJWoVWjV2HncwU3BsgF/nBgSP2h5ytJf59suwLk/Tm61c3T+pBpxHBp0YWKw6XRuWIikjR8N/C6HBI2xYa2JtnOmWSh/v6uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nIOUIlA5; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyaMHCGdJQ6HhBM74iinV53k2fKoiDeP4qWM+GshbGcLt60gf9iODduaMJPrsA0StEGlAIa37WcXJDRt/3gM0YdnL8s1IwW4cPsxMKYZgCWbl+KTH89pS3de38dUP72sHtcWn0yDvc9/P3gMQh+dQqORpHqersnLKqTyIYB4oyzC462Ov8mI3usI+dZT92kdPt7USKqbUjoBCxw5n19BSODHh0RAnfXfIwelgUg3DDyZeAQ4vJx85tn7gjoL3V9ze5do1+i0/np0i/PndLKLSS4TwQw85tSTM04mbSAxJcT0Y3pXaDkXp4fZ0wHcA2WPvsjkVeUFhes1Z7PblEDb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpZZ0q3aDVnt5pMNlRFpT7TrM1XvslkBODH6dcQi8Gk=;
 b=AkE6XNdKt+rDzUzKBmGskSpgHILSXg2hSELBXeEEhrFbQYDryqdhgaoEulRhDhHRd3Gs5sBCv4DjYuajt9ANE7tvZvXl+D2E7gPdlPx1ARcnMD6Yrs6NYqXZsqDb8gSFJTRWJFPm5XRkA8VDuI1HCM7rR8igdcNt2qcxuuDlWPAjGMeFLgGbx4avZsEAoUogd7/tE6RD4ATDBARks5I4ogn6oHuDrvNgOloaRffO2EHBiA35iT027vWldr7AmN+YRCdbNUb2rdPUUYjO3HdipZ4HlysOHm6LMtTen4WKl0zWNQ1aogakN3D6Bkhocmz/KmlGKLrmF9Rey+nPixwaiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpZZ0q3aDVnt5pMNlRFpT7TrM1XvslkBODH6dcQi8Gk=;
 b=nIOUIlA5fZKa/y1na30YE3/glS0ADzP+RznuEFGK5LYuxnernginGPW3zgfejRneNgGS9MWTEjUbIqQ2aaanVrmDy8a0pXtAt745TowW80BCfQEDZZwXK/qfMUrrEBLlK8l7HciWxUEaSwQRQ5iJ+RIiyeN22VkFE2thL2alDps8lQQU0Dw1jM+LmAUzuxnYso75Buz46a0JcgTgHTQ1I05f2sNAbLi2PdMWupk5VjrV0WHFWXWTNg3FZkJm1ykwYjY7wZ/ypaS92ca5Nlk8KlcxdQABHByjSesxpLqM5W0DrSnwPUr58oDvjVZt5Rhxe32ZICqKnGnlxk3A+EvHhA==
Received: from CH2PR16CA0013.namprd16.prod.outlook.com (2603:10b6:610:50::23)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 22:21:11 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:50:cafe::32) by CH2PR16CA0013.outlook.office365.com
 (2603:10b6:610:50::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 22:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Tue, 26 Mar 2024 22:21:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 15:20:59 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 26 Mar 2024 15:20:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 26 Mar 2024 15:20:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 0/8] mlx5e misc patches
Date: Wed, 27 Mar 2024 00:20:14 +0200
Message-ID: <20240326222022.27926-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a80755-c4bf-415f-ec50-08dc4de30adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EN7rNbnXQdwcZF8a/eiory8jFaN73Z/gf1OS9b0OLB9ejlAJptEfk2T2edvYwXAY39jsysNYVe3gkOg3hALk2JAl6mREjp/U/WCATEbMyirgtGrKsQkkYjRE4w5ug3rQDZGJ2zUfhtaVFI2u4m7/8n0ml0rsLhTRgV6MSrhvLOq8ofn3QZUTQ4yl4BlhwxMM5inHOkebPcAVm3nApdH0jCcd/gL4dyla+ZYBkVUsYpmZ8OLvKrUcuUQcWlRKgCihIdW9PoHv6+zoPPkPk6KwZXMNVN9Oy81lqKhB0lfqK2sBh/3mFLjT24UkRjvNg05UmQTdbkY6SGcKp+dCauVeUV1sru0Te8gLALYTHIBP9zuiz14Dz+f2YyB3UPnKoZnZfxaHgcGpphwJQvu4g/78yG2rcblSUn/KDwGm9wZcIs9CSptqwa60f0lc9t7YMCuhCPyeE70TH51nljmyOFFU7N/73YXq4DlDlBDjZPBZb+GhZNbOjjOT8HYIruiz5rTnS2LU1hS4sPVefZnuLEoAbRiwkoGMxs3YdEO6kRYIqpvwDD0i8t0IPuSq9dza0lmILWqLXxl2k8hkri77O6ECjhbYaRCMOH6Tv9dVR9pjqq0teXwIVI9jGsfXKKJiaRwEr2blviApFClhA9Wkm2+nW3vViwL4i22I0fW6tMTiiAv4qAZINnLjt+bhjEohdT0iKfoRtCUiSqp3jlehW+YMU5agSZph6116TWQQR1/IpImOcuShdn/0cUTrpMT+xGQF
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 22:21:11.3527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a80755-c4bf-415f-ec50-08dc4de30adc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

Hi,

This patchset includes small features and misc code enhancements for the
mlx5e driver.

Patches 1-4 by Gal improves the mlx5e ethtool stats implementation, for
example by using standard helpers ethtool_sprintf/puts.

Patch 5 by Carolina adds exposure of RX packet drop counters of VFs/SFs
on their representor.

Patch 6 by me adds a reset option for the FW command interface debugfs
stats entries. This allows explicit FW command interface stats reset
between different runs of a test case.

Patches 7 and 8 are simple cleanups.

Series generated against:
commit 537c2e91d354 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")

Thanks,
Tariq.

Carolina Jubran (2):
  net/mlx5e: Expose the VF/SF RX drop counter on the representor
  net/mlx5e: XDP, Fix an inconsistent comment

Gal Pressman (5):
  net/mlx5e: Use ethtool_sprintf/puts() to fill priv flags strings
  net/mlx5e: Use ethtool_sprintf/puts() to fill selftests strings
  net/mlx5e: Use ethtool_sprintf/puts() to fill stats strings
  net/mlx5e: Make stats group fill_stats callbacks consistent with the
    API
  net/mlx5: Convert uintX_t to uX

Tariq Toukan (1):
  net/mlx5e: debugfs, Add reset option for command interface stats

 .../ethernet/mellanox/mlx5/counters.rst       |   5 +
 .../net/ethernet/mellanox/mlx5/core/debugfs.c |  22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   2 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   2 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |   4 +-
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c |  28 +-
 .../mellanox/mlx5/core/en_accel/ktls.h        |  14 +-
 .../mellanox/mlx5/core/en_accel/ktls_stats.c  |  26 +-
 .../mlx5/core/en_accel/macsec_stats.c         |  22 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  98 +++-
 .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 491 +++++++++---------
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |   2 +-
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |   2 +-
 .../mellanox/mlx5/core/steering/dr_ste_v0.c   |   2 +-
 .../mellanox/mlx5/core/steering/dr_ste_v1.c   |   4 +-
 include/linux/mlx5/device.h                   |   2 +-
 20 files changed, 405 insertions(+), 339 deletions(-)

-- 
2.31.1


