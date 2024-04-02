Return-Path: <netdev+bounces-84032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9026895573
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4EE1F2115F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 13:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1134F84A52;
	Tue,  2 Apr 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YiHDMSeV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F4657AD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064756; cv=fail; b=Iu5Z5bzsKw5X6UJ95+Nutvvi289LpVrMsP0m1E1q3sOiU4CYtWqdefCOl5NtXVMsu0i30Xc0olOUawRweZhlV7gEHHzZSV70g3VON/xHmxgDRNqMDRckaKdfv+S98MRnnq5GCuWmDXUrd5/3c9o8E17OZkFojInPqbZoTh8scms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064756; c=relaxed/simple;
	bh=QVUT6GHPXQVeFlxJd8Bd5+naQiS/mOZIymaXrLqI4eQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QjLQkEAv4LHbLJeXHI/W6xAfxLEEFMWWvNf1p2mZi/xgo+8vV5EoZDmGl6wo2JPAPcFvSF9EJ4F/S8n9zN+yBDXCLy5AFmooPoYF7/4HL63vQ29E3pFDbAwjROwLH/84EN4fAWC3tgs7VCOitppY4q1oqOXG3656CXEJH3Ed5xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YiHDMSeV; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3/3halAmI7bnTb9NzB85puxlS+ck2zL/dzUGl06K8GMlOaLOdpahXxoB+jj/kKoKWMckpCA6bADWV+m8TbjVcmQWGYS51Tne0rwGnMeg0g7yNJk/kXmMa1ZCseekiK2oAAxTecfFRoxktUkj+0/ECIvNBJ+IOtD+7qaEk+o14AsKJvcOgBEqpHN7u96zbAznkGGa8umwG+RZjyRSuZoB01tDC/0t/tzoSngQr62UFAP0hb66ikPtXpI9z41i5rTV5zfuKwz+ncd1/O6B0bwo2YA9nzEF6LZvpoPgjzqqh5M/dfRkhPTuSutqDD6FxzWNb81Z3IeuOw0iHK1S6CN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17z7UTp3bqvJ2FdySMo8CwLQxLnzjtH/rqV1zozgpog=;
 b=H1NfO9HeNx3k5kYTumNJ7bvZhhYPZxhU++KNzZg0GThjCDTetW2QhsEapJptMPV2UGm4ycBA96gm/d4aKMMzAcijOW8pvS7O3vTH05OM4hFF4JLq6fe0PF9ic8MDRI3JLVPZD0UW9x9juyr8qd24A6pKT8cFAS1bN+2o0urvdy7sMwLk9mbPFxmfNZ1P+oWC5T8/yrzB9ZRy8iHZ80sgJ0LBWhGyDZ2RqMWLei5W+UN31XjqV4mwBjn7Lv0A+h3zoEs0CciyglcMjGRR4Uyt8qnmxfX3fF/Fexu5N+AatRSI1O+qfVZASgCGMj5Tub2vQLf76Y+yqudzVjPrxqFTAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17z7UTp3bqvJ2FdySMo8CwLQxLnzjtH/rqV1zozgpog=;
 b=YiHDMSeVtJgPVZV/AOIDVFWfCII9nFY7sp5UYfZ+AGBclImdFmsyRwIEYsF/2TDBRr0CSSH17vsG0E17qpZESX++qhjigRCecyBwt7PYMKsdMUXFyLiAlh/r/5hPIydBMH3DysSa71Ue2Wif5ZmwvkLd03ThiPM7dT7zz0VEPrPDx5jxjlWcwCYNqgUADfYNRuF+x4BFMaAEnKj2jDLixkjOjkc6jLPFytTuPWSi0jvYEHF8F8By0IlYmwlmGnppRVK3cOBNiEf+wzkPfsY3dtKnhdBJGVw7Xl55Nh70XLxRSEe3H4Dj0/butI4kUTlNMVmmU5bZ8P3+lI2Giuf+Ww==
Received: from CH2PR15CA0012.namprd15.prod.outlook.com (2603:10b6:610:51::22)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:32:25 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::7b) by CH2PR15CA0012.outlook.office365.com
 (2603:10b6:610:51::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 13:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 13:32:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 06:32:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 06:32:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 2 Apr
 2024 06:31:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/11] net/mlx5e: Add support for 800Gbps link modes
Date: Tue, 2 Apr 2024 16:30:40 +0300
Message-ID: <20240402133043.56322-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402133043.56322-1-tariqt@nvidia.com>
References: <20240402133043.56322-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff015aa-53ce-4d95-d27d-08dc5319557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s3a6A7Jrg82z6LFZRZBQz3Iwqb59B535zXeP1E4VQPJ17Nn7pFRdMLCzhyS9T3hJBASd0AiE4cIIrNM9rxOMrTwSV0f3RWRa8+ms/6UnTJI/BnpYBPVsxU0yN4lzWubr1Vm09f/McVELkLfhKj4mn9/m8I28LmpLFCOMeqGH5DYIMLcv+MQ9t4Y1ReEYd9MwLdv7AHgB7uhUC073wgqVIoybjd8C4+t7wxvyBqnMFgY+dthymEpj2MAzXHOG414Mf/oPtG5dIYQlO47XxHWdDXa/jx6W1FLxVL7ne8CfFGh48atgCV1FOCOzcl5Ty+sAh2qAUqJsqNSPQ2q/2HQptlJp7f9LRIb8pCAWrGAZaHBl2e2+FMDeUyjFedhQkLMq5LxVgEJi+FDTWJ1HS9vqdkAT0Nnqw4pEVzsDIv0SEd1+ud0ELf9HXGXuksOLRbBYzEVQKN1yowhJMClPGc+Dm34gdcTWWV3VTCs1v9F06mTPqgbFDa8anusjvjj8tKOPfDodCsBjCtYK647QFXhBdP1ZYS65RE/jdvOiyHBkzTAeKWa9PyaEaOBLt3ZrP3oVlZmSSjm0e1TP/I+TnAfjOlNYDXWyTiQtFhcWOPOh0NkADi0W9FGgtxSxRteMrsxSSIAktqSU5sLM0n0nr31z0GW5fMhHZixiOGWuUYjxfPGmAWL6QstBFpnVTFb3DsUYlRqu/u6aygCHqbqyP21XFC6a05HmxCIV56nZBJgY/QsKJPm/w7Ecr0ZQdipCd55R
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:32:25.1736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff015aa-53ce-4d95-d27d-08dc5319557c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

From: Gal Pressman <gal@nvidia.com>

Add support for 800Gbps speed, link modes of 100Gbps per lane.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index b58367909e2c..69f6a6aa7c55 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -219,6 +219,13 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_800GAUI_8_800GBASE_CR8_KR8, ext,
+				       ETHTOOL_LINK_MODE_800000baseCR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseKR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseDR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseDR8_2_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseSR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_800000baseVR8_Full_BIT);
 }
 
 static void mlx5e_ethtool_get_speed_arr(struct mlx5_core_dev *mdev,
-- 
2.31.1


