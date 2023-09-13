Return-Path: <netdev+bounces-33622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104D79EEEA
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D111C2110B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F0C1A701;
	Wed, 13 Sep 2023 16:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517A1E508
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 16:41:29 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A65244
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrOzW1ebOhIlJiVvLf5+xFR6f2hTIlA7hsfIDu2ib4RZuhWS353AaL0JrlWvWRmC0P13akkSgmtsTfhHBONfSwhB67Uqgsx82AeWFQH1BoEFmREaMJDl/PXkfhcw7o6zOBJdxZNQo1C6GqI/rcI2HAlxi3gmXdChbzgi1OcM5QkO5jE5X6yPymuCRF0rYci/SV/Ts76SIwlpCnzJ4ViZLUYoMUrt6kM2ZMozyv6dqjYz3AJaKEYHpr3fjDpSM8/QlN6grFh1kNtZUzXto6h58uVgPSFxDfI97t4565MpJN0AxLXJd24BFPwl/xrCtO3Z5RnvbXdcsr6648D2DQKAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGMLIim/p0v5+uWBxZNG7Zz8sY5G+NIBGwGArDUvrMM=;
 b=nwKeOJyYMdtuoBP80r3LArZfDRXG+6RPAQRzwXRmp264ZRnDmYt4yV6YbnUJxl38Lqc/2y7jXgo60O1HzXFmllGlqI7N+HHUk4oaEhYZIwxQJzaisdoKbeMOg9pWhbI79rm7qYXMkgY2vT7JAhBxBrG57Cpq79Mljcw5vfpwqWxi7iJCgu5T8bLmNnGRZCN2IZR3CgmtpP2ksWGtAMNMtWaaIeLmCobU5OdwgqaOsSwLRwH5k5YD6UnGdujVJ1L81F430U5t8KocR1RIyifi7ZK79DCDCl4Un6Jn1NAXxh8Ym3W4V1SCvwUvN5MMsfonTekZIS7lSRv5xu1Hoey/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGMLIim/p0v5+uWBxZNG7Zz8sY5G+NIBGwGArDUvrMM=;
 b=q2xqEYE9VqCmAd1pkcsD/GZ4wHI9QWl8pLUpbqCwhZthJF7Kr04CTfp5Xldt00xGUDoq5LBUjeCW0F2/Z9FLeG9BNuClPu96EhxwcYc7wyaEk706TUH6gUSZ8+lS2waW/xEf6FWH+2WZ3GbbwWDvP58BqBGJuqRaZv3xfxC7sSL6F8WWP09FfKIicz83RC7u9Jf3a3DP8GbdKco2mqbZ5Ifr0yWo4WjQUEUIE+gQIOP2vkTfjQSx/BsfTOri2N15IwjB9cktRnpRKrTeYhZXvTtzmO0getUknEuPQNQ4TRODSdKKhplAD4Dm6c5HkCExjsj0WHTLqP7cT6pIAOJlHQ==
Received: from BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Wed, 13 Sep
 2023 16:41:25 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::9f) by BLAPR03CA0033.outlook.office365.com
 (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Wed, 13 Sep 2023 16:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 13 Sep 2023 16:41:25 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Sep
 2023 09:41:12 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.231.35) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Sep 2023 09:41:09 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/3] mlxsw: spectrum_acl_flex_keys: Add 'ipv4_5b' flex key
Date: Wed, 13 Sep 2023 18:40:46 +0200
Message-ID: <f6e4b710f1645be677fa6d792af390a09a8fdfb6.1694621836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694621836.git.petrm@nvidia.com>
References: <cover.1694621836.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dbd9d6c-979b-4399-b3d0-08dbb478458a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eF3oQzYxRCM+12NkPoEGFXA8ORvFebEegca0wP6nkb+k4yQaNq5hZTm+HunYRmjboAcsaASBxTwUUuWKkUUXFNVBGcKsRMI/e574TUbL1vNztc1kKHiAi/xpOq1QgBSG6yo2vvlTtQcjbY3hq8wuyYUJvu6kbtbJOL3+Bf6rWVlPknJ//1sseW89FMKvNGZuuY4fngL6RgoLHBPSeX9Mh78rLJPNKY5metcptBbcmOCVpZ1Isdqpd2R73eScohX8Sf5AEE9oR5tEh9LS9PPQAHDSe+4fkLOrzRRRMCHZdv2Av1u4/wabiRLDohjMJmJDmYf2+FsJ+AvI9ko1NHJjB+Dp4SrLf+dPWGJy7VMuAZODvCnR6Ba79P445pvcibtE7XeHNJEO9wzD6G8LvlcZ9qVJEulgGYN2qjoMIMCXJ97LlhLJGvs308Nm6tJNNsnVcPdEnacVs8YvSXZg/KNQ3ARQcp78yYv/GnozEofCzZyCvx3LjSpOE5QdlkerbM5gXov1GmbjeHhi5w4XN2q5a7EJN4G6m7rPCihG0P62wV0x9qX3hN2OsmJ3t1KrSnKlP4RdZAcvqsQeevFoEAkA/dF4Vv/Sy/qzcAXgLoD7SfhgsKOYzgWx+8mCn7d5wQZJtdiehx3glqXWtKl1EvLyNktloXlRg8kitq+44cFVrFX4uxcJVbh5zroVslc9qPtOJfkgWhyIoOsHe99d3RgbTOE6uuORec6J4arPOPEEnMs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(186009)(82310400011)(451199024)(1800799009)(36840700001)(46966006)(40470700004)(110136005)(426003)(316002)(54906003)(70586007)(70206006)(16526019)(26005)(2616005)(107886003)(66574015)(83380400001)(36756003)(7696005)(82740400003)(6666004)(356005)(86362001)(36860700001)(47076005)(40480700001)(7636003)(40460700003)(336012)(478600001)(2906002)(8676002)(8936002)(41300700001)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 16:41:25.6662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbd9d6c-979b-4399-b3d0-08dbb478458a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028

From: Amit Cohen <amcohen@nvidia.com>

The previous patch replaced the key block 'ipv4_4' with 'ipv4_5'. The
corresponding block for Spectrum-4 is 'ipv4_4b'. To be consistent, replace
key block 'ipv4_4b' with 'ipv4_5b'.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
index cc00c8d69eb7..7d66c4f2deea 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.c
@@ -321,8 +321,8 @@ static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_mac_5b[] = {
 	MLXSW_AFK_ELEMENT_INST_EXT_U32(SRC_SYS_PORT, 0x04, 0, 9, -1, true), /* RX_ACL_SYSTEM_PORT */
 };
 
-static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_4b[] = {
-	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 13, 12),
+static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv4_5b[] = {
+	MLXSW_AFK_ELEMENT_INST_U32(VIRT_ROUTER, 0x04, 20, 12),
 };
 
 static struct mlxsw_afk_element_inst mlxsw_sp_afk_element_info_ipv6_2b[] = {
@@ -339,7 +339,7 @@ static const struct mlxsw_afk_block mlxsw_sp4_afk_blocks[] = {
 	MLXSW_AFK_BLOCK(0x38, mlxsw_sp_afk_element_info_ipv4_0),
 	MLXSW_AFK_BLOCK(0x39, mlxsw_sp_afk_element_info_ipv4_1),
 	MLXSW_AFK_BLOCK(0x3A, mlxsw_sp_afk_element_info_ipv4_2),
-	MLXSW_AFK_BLOCK(0x35, mlxsw_sp_afk_element_info_ipv4_4b),
+	MLXSW_AFK_BLOCK(0x36, mlxsw_sp_afk_element_info_ipv4_5b),
 	MLXSW_AFK_BLOCK(0x40, mlxsw_sp_afk_element_info_ipv6_0),
 	MLXSW_AFK_BLOCK(0x41, mlxsw_sp_afk_element_info_ipv6_1),
 	MLXSW_AFK_BLOCK(0x47, mlxsw_sp_afk_element_info_ipv6_2b),
-- 
2.41.0


