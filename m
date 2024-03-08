Return-Path: <netdev+bounces-78739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5368764A9
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A8211C21C70
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B47E2421D;
	Fri,  8 Mar 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R0cBXZMn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2731BF37
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902996; cv=fail; b=Ss8je4I5GQ4cSJ+jCRkVDnERbiGHFL8tUIYaYHe+6nWZLIiUwNiA63/HEGMoE4yzNrUD7q8Y4j2eZRmP6XB73b4+hWPAtKtnvB9RoGM4TjzK0tY71L24w6mo/XgOKaW635TJTYW4whjRL59hbsFzW58pegHp5Ya+0LL9ufUDd2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902996; c=relaxed/simple;
	bh=nnzWd1nyDoYsE+9tfNGu5MTrUjNefN0+vzwqwuJ9Bxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyUISkFp56vkBhZZu+yxAeL1GaJWtw1xwkbD9rX72SU+B9gnnlxUPIpeZPAWvbun1snuso3I15QqOwJZSF+pvAMDEHm1kiG2hjX5WBAduTGSwT7gq1PEQ5un3tTF7yEBzNlkgjt4MMQHK3xWne1Eeowbo5B7hr7mmFwTbGGS7XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R0cBXZMn; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hjBJckG6r6doTJd4JuMGrF9zSfzwZDqaBIFZMRqwksq2nKmjKgLryWDgaZm9XSev9ZyWuk4dixPnfpQasPIDOjaXO+Uze5lgAJfPNhKUp7fcWYUV9xQY0/qAjEh9L3ARJE3st80+Rf84c57L3NwuStC+ZaQpNY/gPuRFKA8ZoscbIZ1vXP2Z6ATrEGNxl8y/aZHYaJDZxOj4X5QJSg0sWvBy5V4c5DJTRZSJMGZPLqIhRTo4y8xwTlUm2LdoZvjFlJ188wkrppqF9tzVYoYW6Wkzy+F6+ouGh41ZUtSY83JJHmelNA6h3rQfUKj7RDDSh+ieBD4LqOuWIREtf/tMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmmRghU9CwUyMOZTwZ4B8G9VGKz/luvm3EJLEgSZbRk=;
 b=AyCWeCP86XJY8XjupkiBWVEolOZtdMm5dADNXmuRef/aVfCSNP1WdfPYjYi1eWXbIHS/Xrn45pvp4oksDXdUaru885Vvka1qhVsk+VjvwBcnh2UixHXsW0RrFhPgYzsOUTudlxp6ScuxcUsr+fayF5wIOXujLvAUR01CgurXZzSvVKvWn2LMxnep551tgxfg5DmIrki8kq+NA8d9RAtlEFGuS6KZFt0NWil7G1Ph9nwTE81nxq1M27MzCiCyD0WRiwKWpI2I5+feEzzFAS1XCchfoCoMQwFBFYXobeZbDj0Nz/0fT7rENB7+OE1M7wkWw1CGddjAJe1P+HiWjyExFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmmRghU9CwUyMOZTwZ4B8G9VGKz/luvm3EJLEgSZbRk=;
 b=R0cBXZMng6iS80YP17a2C8EGC5pQ4W61Wdw+nK1kjXCWJaBcBYOU+d1P3gUTROpYdR1RPL0bDHUkuOOkV4FF5ixMz81rT7pzE48B4jfS6RT4ihIECjWFHz+uw+hkZ+xED6XCu+mMVD9DlW0YOqaHBq2VIclXD1PFnayw7OR76orhkqud0zoxT2oEBDHcC5LB5qnDXitpN/Nzluqb6TmUFYJKhnMPEzHGr21mAahIkX2wWojToUDlUXCRLnCJ36qpp82TakL3Naeg2EjKca1lOhf6+Au3lBF1AZncWjy5+W1WBceiaRJLmqvLGko+LJZ0USK9CWUeYouJVwug+Z2xjA==
Received: from BN9PR03CA0341.namprd03.prod.outlook.com (2603:10b6:408:f6::16)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 13:03:07 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::56) by BN9PR03CA0341.outlook.office365.com
 (2603:10b6:408:f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 13:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 13:03:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Mar 2024
 05:02:41 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 8 Mar
 2024 05:02:36 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/11] mlxsw: spectrum: Allow fetch-and-clear of flow counters
Date: Fri, 8 Mar 2024 13:59:49 +0100
Message-ID: <6a096ede8ee92d5041e3832242c3bbc137198aba.1709901020.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709901020.git.petrm@nvidia.com>
References: <cover.1709901020.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc6796e-f98f-4ead-6bea-08dc3f70193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+7B2jbja9cBOzkRoPO0ljPMiVWJ/JPMbrTHYo9Rcslq91E6c5N4qoyOezCfn2stVQyqbaHdV7dyE5NWtVpVDtOh46KLBlmk7FUQNNm7ObiR0FnmsFJqD7bdEQ4gmJDk2noqYmirh3O0z2H7Y2yOBQAHv4aTa9ioQh31uA/wxKw3bjYgD7VVovrGe4ljPApu3GY5hO0MP67Tod2gPQhFUfXdN8rgtoopF3tK/PpkArNHXwX5XfY3dokXFYBz6EiS1fCQAdLsFHZdlMR9N34QQPgKLx9XFH7dXUP/c+yGMd/ph33WGBn6xnHN19EhA1QMwgMQhuKM7FsJfS3mjoFGko9/0sdseRpbtIfZhYrocybJIT/rf3ZiVbchv3g1op2J+YM4YNcsnhC029RDXiElp0+Ve0j+p0lQBoavgYJMk6x5Wx7s10GltaxS+uomos5oarf4k5v84QbXyCigCy/OChzbR2Df7S72CyNG7EPGnM8tyiv4jpAgveEnnMwLPXMvN3rptZ1NvWDXjznhTBUXgd1Z80qIT9bfmcquTJ78IY3mrZdVhCmjSDJIRkiLZKK2XVvYehtBBJUIm2KfA1i2lrWC+et409Dzqb5tGtwV6i/PaI7maIVXFmmUZB9ORyDS/nti6oBTIAFG+sA3lolV3BiZTGz+RGESdaVNirw8RlqbF1XkVY6i9thSIckukHT4oA3YY9jtyVm7IziL8jtnDPhtD2QKJK1vCFsWfXB13NJFP29mnJIUlbo1FAoZ9rlRu
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:03:07.0013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc6796e-f98f-4ead-6bea-08dc3f70193c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097

For the report_delta-like interface like a previous patch has added for
collection of NH group statistics, it's easiest to read the counter and
have the HW clear it right away. Thus, change mlxsw_sp_flow_counter_get()
to take a bool indicating whether this should be done.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c         | 8 +++++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h         | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c     | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c | 2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c  | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index ecde2086c703..bb642e9bb6cf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -176,13 +176,15 @@ MLXSW_ITEM32(tx, hdr, fid, 0x08, 16, 16);
 MLXSW_ITEM32(tx, hdr, type, 0x0C, 0, 4);
 
 int mlxsw_sp_flow_counter_get(struct mlxsw_sp *mlxsw_sp,
-			      unsigned int counter_index, u64 *packets,
-			      u64 *bytes)
+			      unsigned int counter_index, bool clear,
+			      u64 *packets, u64 *bytes)
 {
+	enum mlxsw_reg_mgpc_opcode op = clear ? MLXSW_REG_MGPC_OPCODE_CLEAR :
+						MLXSW_REG_MGPC_OPCODE_NOP;
 	char mgpc_pl[MLXSW_REG_MGPC_LEN];
 	int err;
 
-	mlxsw_reg_mgpc_pack(mgpc_pl, counter_index, MLXSW_REG_MGPC_OPCODE_NOP,
+	mlxsw_reg_mgpc_pack(mgpc_pl, counter_index, op,
 			    MLXSW_REG_FLOW_COUNTER_SET_TYPE_PACKETS_BYTES);
 	err = mlxsw_reg_query(mlxsw_sp->core, MLXSW_REG(mgpc), mgpc_pl);
 	if (err)
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 898d24232935..3beb5d0847ab 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -706,8 +706,8 @@ int mlxsw_sp_port_kill_vid(struct net_device *dev,
 int mlxsw_sp_port_vlan_set(struct mlxsw_sp_port *mlxsw_sp_port, u16 vid_begin,
 			   u16 vid_end, bool is_member, bool untagged);
 int mlxsw_sp_flow_counter_get(struct mlxsw_sp *mlxsw_sp,
-			      unsigned int counter_index, u64 *packets,
-			      u64 *bytes);
+			      unsigned int counter_index, bool clear,
+			      u64 *packets, u64 *bytes);
 int mlxsw_sp_flow_counter_alloc(struct mlxsw_sp *mlxsw_sp,
 				unsigned int *p_counter_index);
 void mlxsw_sp_flow_counter_free(struct mlxsw_sp *mlxsw_sp,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index b01b000bc71c..3e70cee4d2f3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -1024,7 +1024,7 @@ int mlxsw_sp_acl_rule_get_stats(struct mlxsw_sp *mlxsw_sp,
 	rulei = mlxsw_sp_acl_rule_rulei(rule);
 	if (rulei->counter_valid) {
 		err = mlxsw_sp_flow_counter_get(mlxsw_sp, rulei->counter_index,
-						&current_packets,
+						false, &current_packets,
 						&current_bytes);
 		if (err)
 			return err;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c
index 221aa6a474eb..01d81ae3662a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr_tcam.c
@@ -361,7 +361,7 @@ static int mlxsw_sp_mr_tcam_route_stats(struct mlxsw_sp *mlxsw_sp,
 	struct mlxsw_sp_mr_tcam_route *route = route_priv;
 
 	return mlxsw_sp_flow_counter_get(mlxsw_sp, route->counter_index,
-					 packets, bytes);
+					 false, packets, bytes);
 }
 
 static int
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 23b54a4040af..2df95b5a444f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2251,7 +2251,7 @@ int mlxsw_sp_neigh_counter_get(struct mlxsw_sp *mlxsw_sp,
 		return -EINVAL;
 
 	return mlxsw_sp_flow_counter_get(mlxsw_sp, neigh_entry->counter_index,
-					 p_counter, NULL);
+					 false, p_counter, NULL);
 }
 
 static struct mlxsw_sp_neigh_entry *
@@ -3186,7 +3186,7 @@ int mlxsw_sp_nexthop_counter_get(struct mlxsw_sp *mlxsw_sp,
 		return -EINVAL;
 
 	return mlxsw_sp_flow_counter_get(mlxsw_sp, nh->counter_index,
-					 p_counter, NULL);
+					 false, p_counter, NULL);
 }
 
 struct mlxsw_sp_nexthop *mlxsw_sp_nexthop_next(struct mlxsw_sp_router *router,
-- 
2.43.0


