Return-Path: <netdev+bounces-42556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F467CF528
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF861C20EF5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B8C182CC;
	Thu, 19 Oct 2023 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KO9QcRz2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A518AFB
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0865123
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:28:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jaWgHNdOvR+wCGAUR35hbJln/OPj946eGuIr8j/R5CvoMymjgPFtJsZO81/jtxubhC7DcRQxi/0lN41LSswkqr3WxLOcDsEFainTShxy4rsWAT5BO8Q3VMX9DmOwvxlvDrq2yKHoOypYQ/9LnHq9FN5NSBp0zVM+v5PvHMUvYrchGUAJYW3L4cvVXU+rlz8pZ9cyFPFJDrMHeN3+YMXDKR7Yuk/EgiXvxMDL5EBJAf2ctGnin8y9rmJUh6GuLXilKy2FuT4PItJLsuvUryaPBswIYMya40Nfiv4yQx3+zFDLTA28ar05sENlQ65NKVh12G8RZcF5HhxAv91Auib9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SK3o3VLpGkNfaRKHsy5L5ZvSN3+uO2I5v3kpLGexGr0=;
 b=MF1XmYuGW3GdN0OtufWnIYaFn5u6ngblTYkAV63XRbkX5LwCJ2wkbQw6RPuHBTWQB61WQSqvrEjUw6DWqwx550QLHK3TNcYveVCIWLL21pH1k14kUGSFTIo6qReV6/nUz66YbYxGT2Rc5S1l6BV822emDhZFkb02hSqleCWZG/nWXIXyMW/KvtHQhDDTEGW6qPpYfs7H3xgSGuV2uQtW9N0JbknCqe3/mVr8hYXdAFJrEk9rZB072+m4fu1cDTVVcjfo/wWgSkdmDbnlhweGkaRb90ApOjEwXrHOVsr4CaITOcXwlK1wr6gNeRwHvaatmlnkksLuvMhYZuevN0UXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SK3o3VLpGkNfaRKHsy5L5ZvSN3+uO2I5v3kpLGexGr0=;
 b=KO9QcRz2+vx5G3+jw8GfP/3qn7Hd8J7dUY3dZxR/ZbB85kcTj2WRo7Y0dtEXVOIKWvl1T06o5hxrCWmT0sBx+TvgOmoz4JqzQ8UJeOidJV5sm33+Z8pOAwcORn/YWeTg5jQJnpzmyYeiJoWIfWRXQW/0FypbjRb1qw0R3qYbCwgr19BGCsdgcAdEkE6qUAA0H8QwDkM0I0/++DBNmWK+zdrlJJOa+91+Jsvm6MwkkS8lpb2OJLF853rk7VPhBSy3wyW+WHTtFQezxzMDAZ21jZ7MnandY6HkidLVB+0PeCL+wA3/PpR5v8ra+GwvbCVwgRE0XBklv1J0dEV8IIzTIw==
Received: from MN2PR12CA0022.namprd12.prod.outlook.com (2603:10b6:208:a8::35)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 10:27:58 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::47) by MN2PR12CA0022.outlook.office365.com
 (2603:10b6:208:a8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 10:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:27:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:44 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 03/11] mlxsw: cmd: Fix omissions in CONFIG_PROFILE field names in comments
Date: Thu, 19 Oct 2023 12:27:12 +0200
Message-ID: <6611b1d9c57087c80383f309c4c0e5f1ee663e6f.1697710282.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697710282.git.petrm@nvidia.com>
References: <cover.1697710282.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ea87c3-baf6-422d-b9d1-08dbd08e1086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bg7YCuZvcODm1QpWlo43Oo9Vrdp35vOxZ3AUOtbdwLfq5IF8wVhmIzuMblaEOJFlwHWLbqmApvMwfWbFK+yC7Fl/N1284y7SUHSuqvJ22w+mWxgYrs0JgyofJmJaq6jz4MXRHCTIxBgHJNoWl81Z/MxTiMZgUJeMOznW6ybi95mJzdweq+o6tU3bP1oYDX8Dyf176uzLUnmJpRn6+IhrRkKP6laS129ZzvFcPvbm6HD4Gh+d01rNbQhqoTraDbtXv+xxRza51ptWAa6JAcHMIVOJow29N4//VPfw+2qdq4CsZQA09k1aGk/qyPwrX4lHemYUbL8jwl+24F3qmbSOPkpeklMAzS5tjjTTKmYyX+dXkuVRxz5CJjYHLPaE44D7La3CDWpBv5A7UFRYFxsDnP3ipL9D/NiwqqbwIMqYIuSdbtthdgrotE88L+wsiiNY1nf2HJaQdI3WPgVDcgOC5I0w3IFdyveYBzzwuUv6PdBQUoT6fq3fkLhuhHfIedwWLMGG23xaO/1M7FsHoKbJQy19RsIAwHtTUzU8Jy/m7f4XtqFQF5wmah1SiJeoE2NG0PPvEFLQ0eHjv+0Olq8HbNbNPShADeJYy0PvZsb2nnaCVI6fdRys8zoC8dwQAYILA3gYHKs0RZW2jeZ9IivqbSruyTQSAzoTXl5YB02UUdVaXI3LuktNOLi+VX8nkU4oqUQlf+DU+1pQ12100aR7L+K/tC00NKMJpHCo0ARyMH3Bu4iiseR09l5Ui6uyneLi
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(47076005)(70206006)(40460700003)(36860700001)(70586007)(6666004)(83380400001)(16526019)(478600001)(7696005)(26005)(356005)(41300700001)(316002)(7636003)(54906003)(110136005)(2616005)(4326008)(8676002)(8936002)(107886003)(5660300002)(40480700001)(86362001)(2906002)(82740400003)(336012)(36756003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:27:58.2224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ea87c3-baf6-422d-b9d1-08dbd08e1086
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121

A number of CONFIG_PROFILE fields' comments refer to a field named like
cmd_mbox_config_* instead of cmd_mbox_config_profile_*. Correct these
omissions.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/cmd.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/cmd.h b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
index 09bef04b11d1..a181ca4b764e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/cmd.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/cmd.h
@@ -659,37 +659,37 @@ MLXSW_ITEM32(cmd_mbox, config_profile,
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_ar_sec, 0x0C, 15, 1);
 
-/* cmd_mbox_config_set_ubridge
+/* cmd_mbox_config_profile_set_ubridge
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_ubridge, 0x0C, 22, 1);
 
-/* cmd_mbox_config_set_kvd_linear_size
+/* cmd_mbox_config_profile_set_kvd_linear_size
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_kvd_linear_size, 0x0C, 24, 1);
 
-/* cmd_mbox_config_set_kvd_hash_single_size
+/* cmd_mbox_config_profile_set_kvd_hash_single_size
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_kvd_hash_single_size, 0x0C, 25, 1);
 
-/* cmd_mbox_config_set_kvd_hash_double_size
+/* cmd_mbox_config_profile_set_kvd_hash_double_size
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_kvd_hash_double_size, 0x0C, 26, 1);
 
-/* cmd_mbox_config_set_cqe_version
+/* cmd_mbox_config_profile_set_cqe_version
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, set_cqe_version, 0x08, 0, 1);
 
-/* cmd_mbox_config_set_cqe_time_stamp_type
+/* cmd_mbox_config_profile_set_cqe_time_stamp_type
  * Capability bit. Setting a bit to 1 configures the profile
  * according to the mailbox contents.
  */
@@ -847,7 +847,7 @@ MLXSW_ITEM32(cmd_mbox, config_profile, ubridge, 0x50, 4, 1);
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, kvd_linear_size, 0x54, 0, 24);
 
-/* cmd_mbox_config_kvd_hash_single_size
+/* cmd_mbox_config_profile_kvd_hash_single_size
  * KVD Hash single-entries size
  * Valid for Spectrum only
  * Allowed values are 128*N where N=0 or higher
@@ -856,7 +856,7 @@ MLXSW_ITEM32(cmd_mbox, config_profile, kvd_linear_size, 0x54, 0, 24);
  */
 MLXSW_ITEM32(cmd_mbox, config_profile, kvd_hash_single_size, 0x58, 0, 24);
 
-/* cmd_mbox_config_kvd_hash_double_size
+/* cmd_mbox_config_profile_kvd_hash_double_size
  * KVD Hash double-entries size (units of single-size entries)
  * Valid for Spectrum only
  * Allowed values are 128*N where N=0 or higher
-- 
2.41.0


