Return-Path: <netdev+bounces-42555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6047CF527
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E9C1C20DDC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F84182C2;
	Thu, 19 Oct 2023 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s5Hj/gga"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA618AF9
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:28:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF64F119
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPvyRo65Zk9OT690WHCgdefrdzQyYj7Laa7BiXMsmy08mEqLECOvvB762mI6/i6s5qH+XcBNQI9cSu/ixiKX9YoxyyHWzhA9hLAuv5DxsfVIa+WP2+XcRvYoBDwrCXAiuGNPEnM6GDhqxZoV16aKRU7fRnyaP/f00rP9GOkoOnccNNVH+9rXnAYqft6AJXtnzXOqRmDnJz1aI1L7Byw1a6vnS5yTK7cuuV5J/DZKefzUicQinuVCfnaYtP/ExnsCmud+pjgSzEGEPqk18j7/fpcRm9HH0P4A+e0tfnYABHkX6XokTE4YmTAEUmqjk9kwdrVP1z/LqR1RT2BejexGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo3ygu8AkhNtXCX1h5EizJkEK2ERZUDIZLnwXiX0RUA=;
 b=cyEATjO1ryLzqqyEpKTOcoafBnqS+SM6IR0TcfyaovOnwUCyR7eF7BtVw3dteQTna37o6z144PNiGZ1licSRfydz80JBxFgILbULW3qbLSDR74Qj6bbyIeTqgesquPmJXpEcmPgwPBxVFlMxc3pf9thpS+rsAr2gA+d0Yrm0cvQfTRtB6iIYRX0aL9Uivi2t9SpeqIMULAM110DyCXzsKypmtwGdQeVI9iJR59uDPuHQbQqTgpWdSM6fi/134nxzQ4Y2jLnGM8zpXfoH3yu5ySPg8u71USiuCPbB8VNqbzngicx2w7bjRptGYAPDiQgaBR6ZiqJ2d6xg9Ag86Irxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo3ygu8AkhNtXCX1h5EizJkEK2ERZUDIZLnwXiX0RUA=;
 b=s5Hj/ggaHro7c9jtbw4q4NCLWotug3yrhXUYwT+zoSe0vUOlyr+dHhM4fZ05G0Zlmx/1deajENibUATGJVXBJivVZ+8vwLtH1uCfHRZVivZqXFz2tu8eKX6W0vLIlApt5ClzaGAaWTbllIXtAbgb+zLBgOI99ZyxLQAEvDpe3tSH/1wB513A8HhIDA4aN8CRmb5NdqX+AMyd9vlSQS3jaPeKDjvBjVxQpcZ8VvAxUnfdSCbuvjd+W8h/Fk+rpL4ZrmMkSOrQirVz63IlDikca0afzN2A2hP+vBhlWdPmw182Bh5XIuDj7/3zQVT201tY9kKscd95py0lBkx9qL/U3A==
Received: from MN2PR20CA0032.namprd20.prod.outlook.com (2603:10b6:208:e8::45)
 by DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 10:27:56 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::7b) by MN2PR20CA0032.outlook.office365.com
 (2603:10b6:208:e8::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Thu, 19 Oct 2023 10:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 10:27:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 19 Oct
 2023 03:27:42 -0700
Received: from yaviefel.vdiclient.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 19 Oct 2023 03:27:39 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 02/11] mlxsw: reg: Add SGCR.lag_lookup_pgt_base
Date: Thu, 19 Oct 2023 12:27:11 +0200
Message-ID: <a84620266050e75fe617a011f433b94a4140b405.1697710282.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS7PR12MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0522c61c-f55a-4497-bb5e-08dbd08e0ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AtGWRzIhdMqLN7QOpx4g3ScymBLsg5+fb0ISu8/z3f9CQABTwew1P7iKpyxVom68y8Xpm4icWX+8OjIwKdmpXdr0/olr2QxlRiFocEr7tjwOFWEVsOqNCaFGMhJbdKJW8kqg1ps+QK6r5BBV2gc9/Tc5cc0w9KDa/Xs2EovE6AvirdmOWGZ6bOIG8zddGUYcq7mrNNYQtPu1LyCr5G7ANuXY/osH2wFjqixPoL4Bfb/7jQHeFMx1s2MdFSjydkS0ZHe+46G9cfek3aW0CsZkzbXS/z8bj2GxUYFoc2w22NGIQVZ+uADYpWy/58PJ2VUIKnxYEbJ4VSUYYw4vdsfxLBZ6T0sYrTNNmiXyOvhKy5u0c8otMypvAXkuhE2KQk8XpdopDce5L4RlMDHhiM5qDATqJYHxFc51XVk7EtMpHmzCSTxTQ4T8gZlmEmJqxmBm8+MXxAcrrupDw8saI1lw6HXVNqVR4jID5quR39OYTbaiNaTyeeDmK+iBzwxywDL19k/jvNc5jHmi4VwKU5c28KdfoKvnx8pcxqUWC3/zWepRfjKkrfiMFTVWWRpGr0ftoguso6fqkTF5Kzdftatt4LWKj6CGJUrjtFC5kV75GxwuO4aSH+OK3zHd+wsEgLA3tMD6jgIDpoikGODk91m101NzyUhD4RPB6YyH70itI9N/uNUCSlmRNQzFKNC2NqQGd0Kajf3rmCXPEkG2BL89lE19DQpmTigaXdfdDZfRH84=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(316002)(82740400003)(107886003)(2616005)(70206006)(70586007)(478600001)(110136005)(426003)(2906002)(54906003)(7696005)(16526019)(8676002)(5660300002)(4326008)(41300700001)(26005)(8936002)(86362001)(47076005)(36756003)(83380400001)(7636003)(36860700001)(6666004)(356005)(336012)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:27:55.4674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0522c61c-f55a-4497-bb5e-08dbd08e0ee4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6263

Add SGCR.lag_lookup_pgt_base, which is used for configuring the base
address of the LAG table within the PGT table for cases when the driver
is responsible for the table placement.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index ba00c68211c4..e26e9d06bd72 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -38,9 +38,18 @@ static const struct mlxsw_reg_info mlxsw_reg_##_name = {		\
 
 MLXSW_REG_DEFINE(sgcr, MLXSW_REG_SGCR_ID, MLXSW_REG_SGCR_LEN);
 
-static inline void mlxsw_reg_sgcr_pack(char *payload)
+/* reg_sgcr_lag_lookup_pgt_base
+ * Base address used for lookup in PGT table
+ * Supported when CONFIG_PROFILE.lag_mode = 1
+ * Note: when IGCR.ddd_lag_mode=0, the address shall be aligned to 8 entries.
+ * Access: RW
+ */
+MLXSW_ITEM32(reg, sgcr, lag_lookup_pgt_base, 0x0C, 0, 16);
+
+static inline void mlxsw_reg_sgcr_pack(char *payload, u16 lag_lookup_pgt_base)
 {
 	MLXSW_REG_ZERO(sgcr, payload);
+	mlxsw_reg_sgcr_lag_lookup_pgt_base_set(payload, lag_lookup_pgt_base);
 }
 
 /* SPAD - Switch Physical Address Register
-- 
2.41.0


