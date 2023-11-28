Return-Path: <netdev+bounces-51744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251997FBE8B
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F49EB219C0
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7035287;
	Tue, 28 Nov 2023 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWX4MSfm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BD19A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:51:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiEbqtjrv7butUySRRxkd817hxCOQlfXRrU/lHjjrsSqBxcsMDUYPSJV8h+5zvJNAiVc8qYlOlQKWgNBA1Vk7O6ihBy7r7JqNtApZ9SqYR6YokKphoSGrjCIF2vuY8xshZHDCCuiWzYefhaTrfaENf38FJxU8c0lWGPedb8NWUu+pxM7VbemaU+jGeYRtOa13MYg4RBEZQEiYZJADTUrxnJN0Z5YPVvz6bW3aAyIe5QgRKF5PmVIv8dPyHAtpsJlcaP4C8ozUYK4CcohwnVW1QX2H8g08OyB04zjfkZ76VAH6wkIBezvLAg/uEhbWJg6udfdqkfeXgvlk03Grt/r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UsNa1AB/rbFMrTkHgq01AeqVklU2i54N1y3h/oI8wM=;
 b=GFe/mhRRbOgXGyMzq6Y/uGY3hzvphTdcU4fyCerIQ3Ni/M5mICbLJOTT/0JTamUKqdJ2kHcJkgYVRFXRa/2e9TkIVS1H1I/pS2eQDXiPVW9GO7UQIHqXX/t/SYvaDPwjp6laj/8T+cRubyL/N6tWJ037Q9CdNoHKLYBlT6RzGPH3krkqv10P9eQOpemVpNlLdMeaUPyiPRijFe9SyywPsRrTuKiYm9zHn0qZp2Ieoj21ADEYTZB6tnk3Y6HOL7p11ljjic3pQowyouMRDyjYgrgqJYXm/Kwlht4XaZLhC7hpSnjan/CBdN69mmwFE/DM4oPe/nf+DrxivHuK7bvP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UsNa1AB/rbFMrTkHgq01AeqVklU2i54N1y3h/oI8wM=;
 b=KWX4MSfmw4NMXu8ww23TORgKnwTgx5BL8glLgVtn038ecNkGsT1XCuaB83dygcZZMqmaZERZoqJM0h5tXFSGZ4IltFc2xnGgfEDVruohJAPpRaypYeKfvNzs1z1i1BSqk3O/nf6oCypjymw06+RejQQ3x+ViPPTqc0HqnDfRXim4HSk9Jb09BrIVMSzB0Id5v8RzuEyqwni9AOaEhjJ9Tlm/w41H9DO51yXJYVXvIYqV7mIL8kDonhoPP6olNCrUvuokKWQkE4qLOxhzBiUK7eyIwWiXC47/qgf0XktyylKKY2XRiTqw2Ho00VO8LJrkE5fZI0MDDtRkdtD8DoyX+A==
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by PH7PR12MB9076.namprd12.prod.outlook.com (2603:10b6:510:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 15:51:50 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::4d) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.3 via Frontend
 Transport; Tue, 28 Nov 2023 15:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Tue, 28 Nov 2023 15:51:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:33 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Nov
 2023 07:51:31 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 10/17] mlxsw: spectrum_fid: Add a not-UC packet type
Date: Tue, 28 Nov 2023 16:50:43 +0100
Message-ID: <8fb968b2d1cc37137cd0110c98cdeb625b03ca99.1701183892.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701183891.git.petrm@nvidia.com>
References: <cover.1701183891.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR12MB9076:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f05569-2a7c-4742-bb4e-08dbf029ef2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NFRdcAR4UKd07upD1jAr2/ecKdNkCEXXWFNp/cE3ducj1lJ2a9bLFWxBEvxHea+/6RWKFWQ4zXQG5j1fRa4lJSSlDSRjjPJIeDNUgDdWiK6XGSV8hJXuTpqn+09fnnaU2Fu2cBE+3x+D2sNua1HtFwpNhBKr0ltQjqTbp81VFuWN3R3tt7yLyPLHIeYLVO1oo7e0NuN8jRqCPzIV7tFGvIQ8QT3ubYaR/tng9FPWPZwYE6eEhUGHc9ZPPXtkdc8GZArCXv3VfoELArvlPj0/Bptai53ypgEtwtpY6tTeZ+hP4wwXU9VKWN6u/BM2kTmDhFTDN7nSjq++M1ufsU2HVpOI5jqfauOmvOpIldAtqLuGM7NEZHahpYuyNA1v9vEOWM8024wUTaTKoeJ2ETbiNhkc3fzqg37pBnS2zR58TRJkEuE39Ii0IkQzRyBKASJotsEc2wvyy8U1g16jyMC8X3QgDYgWwub2ci44rs8qwb9tkPPkHNi33PYuoHEqH3dsW3RrmPppgGoW4/V26LMT/8m7iKXLmDf2KdVEnW+RCjmOjzbIoor3zkofQPY6PImmMpAAj9URJ3+NgQtGP4yIWEqeN3JPB/Og/sTepn2gqubtcoy4QnYOAkPNTvTGAX1FBOP6SKXgp4cRtodhNhkT0jE3yB7FqzUEXC67FK7yt0PuVnjXIoi2zFVFWv8PZBpy2Hetr8bN6aZ74LtL5MZPo2tq7W2uw9u1isDYKtIKfrwyP6mHQY/PmYjknOyX7heu
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(316002)(110136005)(54906003)(70586007)(70206006)(36860700001)(36756003)(6666004)(426003)(336012)(16526019)(26005)(107886003)(2616005)(478600001)(82740400003)(356005)(7636003)(86362001)(47076005)(2906002)(5660300002)(40480700001)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 15:51:49.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f05569-2a7c-4742-bb4e-08dbf029ef2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9076

In CFF flood mode, the rFID family will allocate two tables. One for
unknown UC traffic, one for everything else. Add a traffic type for the
everything else traffic.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h     |  2 ++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index e50f22870602..8bd1083cfd9e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -513,6 +513,8 @@ enum mlxsw_sp_flood_type {
 	MLXSW_SP_FLOOD_TYPE_UC,
 	MLXSW_SP_FLOOD_TYPE_BC,
 	MLXSW_SP_FLOOD_TYPE_MC,
+	/* For RSP FIDs in CFF mode. */
+	MLXSW_SP_FLOOD_TYPE_NOT_UC,
 };
 
 int mlxsw_sp_port_get_stats_raw(struct net_device *dev, int grp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 223716c51401..a718bdfa4c3b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -139,10 +139,20 @@ static const int mlxsw_sp_sfgc_mc_packet_types[MLXSW_REG_SFGC_TYPE_MAX] = {
 	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV4]	= 1,
 };
 
+static const int mlxsw_sp_sfgc_not_uc_packet_types[MLXSW_REG_SFGC_TYPE_MAX] = {
+	[MLXSW_REG_SFGC_TYPE_BROADCAST]				= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_NON_IP]	= 1,
+	[MLXSW_REG_SFGC_TYPE_IPV4_LINK_LOCAL]			= 1,
+	[MLXSW_REG_SFGC_TYPE_IPV6_ALL_HOST]			= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV6]	= 1,
+	[MLXSW_REG_SFGC_TYPE_UNREGISTERED_MULTICAST_IPV4]	= 1,
+};
+
 static const int *mlxsw_sp_packet_type_sfgc_types[] = {
 	[MLXSW_SP_FLOOD_TYPE_UC]	= mlxsw_sp_sfgc_uc_packet_types,
 	[MLXSW_SP_FLOOD_TYPE_BC]	= mlxsw_sp_sfgc_bc_packet_types,
 	[MLXSW_SP_FLOOD_TYPE_MC]	= mlxsw_sp_sfgc_mc_packet_types,
+	[MLXSW_SP_FLOOD_TYPE_NOT_UC]	= mlxsw_sp_sfgc_not_uc_packet_types,
 };
 
 struct mlxsw_sp_fid *mlxsw_sp_fid_lookup_by_index(struct mlxsw_sp *mlxsw_sp,
-- 
2.41.0


