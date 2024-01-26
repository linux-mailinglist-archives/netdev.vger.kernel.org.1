Return-Path: <netdev+bounces-66251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B3283E217
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAF81C22917
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC15F21A02;
	Fri, 26 Jan 2024 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sgbcd1aJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F621A19
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295555; cv=fail; b=dqGU2OfPEhsVcuOfGZgUe9COwmz4B4a3dDR/hTOqx27J31e92VNNseEqZ86qLoUpPaInvoAGn4A0Mx2kb6/n9vyxL+lPl5K7TX9XdPCef3xkqfQ5DNo6dN+LbXArd45glyxR8hpHOmzO/R5+RpzqcExkvA+5xLYHXne8nGUqsdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295555; c=relaxed/simple;
	bh=yYj81KJfFxv44QXziC0KNu1ZPI/x8sYwZIrO47m7Qfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBUpt7Wplwdw/C+uPZWhpgFASQT86gwpD6cBeKltgQaVH3EZcSxwem787g90487xBVrlWTmCM/TSPbd4F7JaeLonz1RdCfGZPx+lt7Q/PMzzim2m+EXwx+8RChJQbxzgcutEuRVlqvXMV6VuMzfQNlMs5SIzqPM9g3DPQDksBBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sgbcd1aJ; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnZI5Sv8UR7KA2FUUoZ/jjdJ+SJi9G4tao+I6Fm0KaMUU+I6b8tN91FZr6ijZUkVF4TemBJMWshLjvFF39xyUG6RQx2uXAP9uRlvd04WMU9F/i2b7w3ghWjBupBGlHFqGInTvMKph0eNlY3k6+0lLb8xYyYd+Cg8uPHzFUwo2DR0HvUlB4gvPR2cGF9/PQWmOn55c3cDuJqkddU9nghvERtHXzKpKmwMHPzK27fWZ6yLud9iMHqORjOnRKqHr56/37lxxeBNVAVjJ9w8zl8WlwpB+yZXuDk/DH6MCa2EHrM7lRqFbRmzRiHjBNTrxxH6pLT+TYWAqvaKzNkH7hzahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZjDNkcE0U5z7LP4YVoaYEIn6ym6nkpKzfpMYYzMNiE=;
 b=b9VVpyXVh7dp66TRnJK06O7Xg5tPBYPCe1us3gjhiojT9pnV6ta1CRdR/QFnfqXBDZIZEH7Pg9fc5BS4uU8osvsNPJ+CjjBYtlr5CdDYho5LFMVA8f6vHkSWeOSgYgz4Fj1jg6bdZ/xO1MD1Us6EMZ7iGNRso/e7OvaRBvb0p4AJHGi3GxFkjBo4YEnj0oYARuCQsg85X8crDl9gx8B3a7n32zPcbXEuu9LwSPfp6h/0QNkGegVUGny4b+z5NZhrVhJb7PaQlpHjxpXhhvI/c0xbALkJFaxlW2EeQOi1e8j+R/rfsXiyb9KYf5SXRD6KoHhtR7QXlxw1QhLJk2y5iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZjDNkcE0U5z7LP4YVoaYEIn6ym6nkpKzfpMYYzMNiE=;
 b=sgbcd1aJPO/mgqZeHURJSkwe88joWwY/i4kL9rGzqI9oAZ66bIQU55E+v7tzOklGcFv808YnvOW5u8lK647mTW60gmy4PJfHgajplabAHU5Cj2jIaUndm2O2lHm36IE6UsGU6brYBdz6AbwynICltY1/YYxd+GgsHaS+FCzV8f/3YeWqI38aETN7PRdCS3xFh2v9JkiadBj+yNckYImb0Yw8pDL8wo/OJ9GJNlyeh9Z4h6+dUozPp/UAAgh2Dqh44xe+J0cuHHNMdt/C27jYPA0KMCDws6RBaSWOClS08rvU1B63s2f3k90cfxC4WrdUKv/mivid9yHJGinNPcBZfg==
Received: from DS7PR05CA0107.namprd05.prod.outlook.com (2603:10b6:8:56::25) by
 DS7PR12MB6215.namprd12.prod.outlook.com (2603:10b6:8:95::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Fri, 26 Jan 2024 18:59:11 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::b6) by DS7PR05CA0107.outlook.office365.com
 (2603:10b6:8:56::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.15 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:59 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:57 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/6] mlxsw: spectrum: Refactor LAG create and destroy code
Date: Fri, 26 Jan 2024 19:58:30 +0100
Message-ID: <30eb498438bf114bfcd8c02bc6117007aa0e9600.1706293430.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706293430.git.petrm@nvidia.com>
References: <cover.1706293430.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS7PR12MB6215:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f7b821-e107-47bc-84b7-08dc1ea0e1ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AfXlGRnyLdavWExULOFekEmNgrSpMeWnd9va6Q6kLQGkKxPeh5DzHJZA06PnpTgl98XCtGO1D7U4vcfgfDVwZ213MclEhmGJVrIYGiJQlo7OIyctZhFEe09PtXiBHpkytlwbdzif7zHTj57Pp6fB53deOIgYaaCU7ylLFkoZkHTdV2V2kaIqbg+3AgletvkxmqN5//F1L+U4mCbhgNG7IHHLfnfuB148fFoe8Q72cKe1mmNk0Rj3YWDqsTIWTEk2PtAJxHgl6Jbnx1MYDeeEjIJlTVmf2QmQ79RQJ1COq6lnhSdZtB6d8DIaxAaQYES43VUlQshfO35i+ldhq3f5AGA+N9CbqN+15r1Qae1U3KeG+oVPHDjiVclsptDVoMczCmxIJ+Ob+N/PHVqyvbsz7kHeh31Z/7fDPJk+9ua7wmKDsCDiIngUZb40dZK8WoVdPlJnmWTwtIgl+IYs6UWlUAsHW0l0BRKdPwDM4KJbdox5bjd7KXc73GxI5MiMKlCyGtGKdU63K5YRusEdpBwaZamjnAZtRKDppw3JuMuc3+rPz55XSeiynDHTAizdPFII1NUWblhfXY098VRcel4cVRprZWDNE5mVZCYdTR1FBXBGbokC9Cy4izngO0ttaHNp32Hp/Lysd4a2NLKrNz6H6T5tMKYqNFw7ntYu1fPVPL63flpY1Aa3mbxIggZlZ1OtBUKKYN6UEhQ/olP0hTVHyoiFWsJ2eK3udVxioVKIZJWDkgCqd/Zac7ggOU0PzQwZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(5660300002)(6666004)(478600001)(4326008)(316002)(54906003)(86362001)(8936002)(8676002)(70586007)(70206006)(110136005)(36860700001)(356005)(82740400003)(41300700001)(47076005)(7636003)(36756003)(426003)(2616005)(66574015)(336012)(26005)(40480700001)(2906002)(40460700003)(107886003)(16526019)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:10.8116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f7b821-e107-47bc-84b7-08dc1ea0e1ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6215

From: Amit Cohen <amcohen@nvidia.com>

mlxsw_sp stores an array of LAGs. When a port joins a LAG, in case that
this LAG is already in use, we only have to increase the reference counter.
Otherwise, we have to search for an unused LAG ID and configure it in
hardware. When a port leaves a LAG, we have to destroy it only for the last
user. This code can be simplified, for such requirements we usually add
get() and put() functions which create and destroy the object.

Add mlxsw_sp_lag_{get,put}() and use them. These functions take care of
the reference counter and hardware configuration if needed. Change the
reference counter to refcount_t type which catches overflow and underflow
issues.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 116 +++++++++++-------
 1 file changed, 73 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 556dfddff005..ecde2086c703 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2741,7 +2741,8 @@ static void mlxsw_sp_lag_pgt_fini(struct mlxsw_sp *mlxsw_sp)
 
 struct mlxsw_sp_lag {
 	struct net_device *dev;
-	unsigned int ref_count;
+	refcount_t ref_count;
+	u16 lag_id;
 };
 
 static int mlxsw_sp_lag_init(struct mlxsw_sp *mlxsw_sp)
@@ -4261,19 +4262,48 @@ mlxsw_sp_port_lag_uppers_cleanup(struct mlxsw_sp_port *mlxsw_sp_port,
 	}
 }
 
-static int mlxsw_sp_lag_create(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
+static struct mlxsw_sp_lag *
+mlxsw_sp_lag_create(struct mlxsw_sp *mlxsw_sp, struct net_device *lag_dev,
+		    struct netlink_ext_ack *extack)
 {
 	char sldr_pl[MLXSW_REG_SLDR_LEN];
+	struct mlxsw_sp_lag *lag;
+	u16 lag_id;
+	int i, err;
 
+	for (i = 0; i < mlxsw_sp->max_lag; i++) {
+		if (!mlxsw_sp->lags[i].dev)
+			break;
+	}
+
+	if (i == mlxsw_sp->max_lag) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Exceeded number of supported LAG devices");
+		return ERR_PTR(-EBUSY);
+	}
+
+	lag_id = i;
 	mlxsw_reg_sldr_lag_create_pack(sldr_pl, lag_id);
-	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sldr), sldr_pl);
+	err = mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sldr), sldr_pl);
+	if (err)
+		return ERR_PTR(err);
+
+	lag = &mlxsw_sp->lags[lag_id];
+	lag->lag_id = lag_id;
+	lag->dev = lag_dev;
+	refcount_set(&lag->ref_count, 1);
+
+	return lag;
 }
 
-static int mlxsw_sp_lag_destroy(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
+static int
+mlxsw_sp_lag_destroy(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_lag *lag)
 {
 	char sldr_pl[MLXSW_REG_SLDR_LEN];
 
-	mlxsw_reg_sldr_lag_destroy_pack(sldr_pl, lag_id);
+	lag->dev = NULL;
+
+	mlxsw_reg_sldr_lag_destroy_pack(sldr_pl, lag->lag_id);
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(sldr), sldr_pl);
 }
 
@@ -4321,32 +4351,44 @@ static int mlxsw_sp_lag_col_port_disable(struct mlxsw_sp_port *mlxsw_sp_port,
 	return mlxsw_reg_write(mlxsw_sp->core, MLXSW_REG(slcor), slcor_pl);
 }
 
-static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
-				  struct net_device *lag_dev,
-				  u16 *p_lag_id, struct netlink_ext_ack *extack)
+static struct mlxsw_sp_lag *
+mlxsw_sp_lag_find(struct mlxsw_sp *mlxsw_sp, struct net_device *lag_dev)
 {
-	struct mlxsw_sp_lag *lag;
-	int free_lag_id = -1;
 	int i;
 
 	for (i = 0; i < mlxsw_sp->max_lag; i++) {
-		lag = &mlxsw_sp->lags[i];
-		if (lag->ref_count) {
-			if (lag->dev == lag_dev) {
-				*p_lag_id = i;
-				return 0;
-			}
-		} else if (free_lag_id < 0) {
-			free_lag_id = i;
-		}
+		if (!mlxsw_sp->lags[i].dev)
+			continue;
+
+		if (mlxsw_sp->lags[i].dev == lag_dev)
+			return &mlxsw_sp->lags[i];
 	}
-	if (free_lag_id < 0) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Exceeded number of supported LAG devices");
-		return -EBUSY;
+
+	return NULL;
+}
+
+static struct mlxsw_sp_lag *
+mlxsw_sp_lag_get(struct mlxsw_sp *mlxsw_sp, struct net_device *lag_dev,
+		 struct netlink_ext_ack *extack)
+{
+	struct mlxsw_sp_lag *lag;
+
+	lag = mlxsw_sp_lag_find(mlxsw_sp, lag_dev);
+	if (lag) {
+		refcount_inc(&lag->ref_count);
+		return lag;
 	}
-	*p_lag_id = free_lag_id;
-	return 0;
+
+	return mlxsw_sp_lag_create(mlxsw_sp, lag_dev, extack);
+}
+
+static void
+mlxsw_sp_lag_put(struct mlxsw_sp *mlxsw_sp, struct mlxsw_sp_lag *lag)
+{
+	if (!refcount_dec_and_test(&lag->ref_count))
+		return;
+
+	mlxsw_sp_lag_destroy(mlxsw_sp, lag);
 }
 
 static bool
@@ -4471,17 +4513,11 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	u8 port_index;
 	int err;
 
-	err = mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id, extack);
-	if (err)
-		return err;
-	lag = &mlxsw_sp->lags[lag_id];
-	if (!lag->ref_count) {
-		err = mlxsw_sp_lag_create(mlxsw_sp, lag_id);
-		if (err)
-			return err;
-		lag->dev = lag_dev;
-	}
+	lag = mlxsw_sp_lag_get(mlxsw_sp, lag_dev, extack);
+	if (IS_ERR(lag))
+		return PTR_ERR(lag);
 
+	lag_id = lag->lag_id;
 	err = mlxsw_sp_port_lag_index_get(mlxsw_sp, lag_id, &port_index);
 	if (err)
 		return err;
@@ -4499,7 +4535,6 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 				   mlxsw_sp_port->local_port);
 	mlxsw_sp_port->lag_id = lag_id;
 	mlxsw_sp_port->lagged = 1;
-	lag->ref_count++;
 
 	err = mlxsw_sp_fid_port_join_lag(mlxsw_sp_port);
 	if (err)
@@ -4526,7 +4561,6 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 err_router_join:
 	mlxsw_sp_fid_port_leave_lag(mlxsw_sp_port);
 err_fid_port_join_lag:
-	lag->ref_count--;
 	mlxsw_sp_port->lagged = 0;
 	mlxsw_core_lag_mapping_clear(mlxsw_sp->core, lag_id,
 				     mlxsw_sp_port->local_port);
@@ -4534,8 +4568,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 err_col_port_add:
 	mlxsw_sp_lag_uppers_bridge_leave(mlxsw_sp_port, lag_dev);
 err_lag_uppers_bridge_join:
-	if (!lag->ref_count)
-		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
+	mlxsw_sp_lag_put(mlxsw_sp, lag);
 	return err;
 }
 
@@ -4549,7 +4582,6 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 	if (!mlxsw_sp_port->lagged)
 		return;
 	lag = &mlxsw_sp->lags[lag_id];
-	WARN_ON(lag->ref_count == 0);
 
 	mlxsw_sp_lag_col_port_remove(mlxsw_sp_port, lag_id);
 
@@ -4563,13 +4595,11 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	mlxsw_sp_fid_port_leave_lag(mlxsw_sp_port);
 
-	if (lag->ref_count == 1)
-		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
+	mlxsw_sp_lag_put(mlxsw_sp, lag);
 
 	mlxsw_core_lag_mapping_clear(mlxsw_sp->core, lag_id,
 				     mlxsw_sp_port->local_port);
 	mlxsw_sp_port->lagged = 0;
-	lag->ref_count--;
 
 	/* Make sure untagged frames are allowed to ingress */
 	mlxsw_sp_port_pvid_set(mlxsw_sp_port, MLXSW_SP_DEFAULT_VID,
-- 
2.43.0


