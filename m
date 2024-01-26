Return-Path: <netdev+bounces-66252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325483E218
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0C48B21ACC
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C7622313;
	Fri, 26 Jan 2024 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kT4nhKPx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54E6224DB
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295558; cv=fail; b=EajQKabYQ3HQwB1NJyD5jUN68RiEjlaTkCGrHGFrsUqTW9k0GbkeZevOT00399w4Jjyh/bUv/MJl+ARb/yNnO4Du3dKe66Dq0DdfsYjvMfZ9t1tnq9yJhjK1vCtOH5MeEL7jeFD7vi7uzpw599rL6j5H//wPGsqgBiGFzWHwf/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295558; c=relaxed/simple;
	bh=8ePw04mKAp6x+WPnjt9fIgtvVh76IQKcph4eW2jACM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLfEmbsntvn/5Ago+MWvRPEYLTuWO6ylblXZVn736a/irgX1ITS7Fst25Sw2UvzOA6EErhkhaHoSFYPfmSmvMFM5Yish3GSfzCS5CDMiDBwUuuV+1HfOZaQaBSXqZeXIlK2yFQ/OGaJK9Y/98FfCpgpTqinJdXqZRWDHbTafJpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kT4nhKPx; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHBlv2Oor5NozULk+J6g74LXZ8TAhGve8BNuO2pXcpkChGdfozdK062kBGjAADYdNidnDvmnYWPuNxTVWznDY3HvG0rh59jS/8AJ8lHZ2zTEJ0Jd9dghtlv/R+AtgQn9UELx2GIneFszAfufxx1vPutzTMnj7My6MbCj04XuFdHo6sDalK0pJo09oZto+OW+SGUqkm/KGa3tKk0twGsXridMONJBiN/rbLsvdBE1wRCmRDfX6/B6sKkzfekorsGYA7LGCwjR3xr3ZtOfO+627JrXJHbP4hkXxB6TKIVOo40vJF7B755GtLUBBfshanA5IUDYUN8bEssIB8MD3zS6Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07sUYA0+Bnjxlpg4L/nrtkoFiqnL2PRuw7mMv+RyY5w=;
 b=n48POJ67AFnyzM88t7Ac51NhO8Fi2sU/pgPITrMPJ6MJDWWE58c+lCf5vyNIU8DsY3vvHXIGv51LHVTdNUGkVZsa4RRBoHm/agbaEvIcHkG44jSXJ7NAe3p50aMU1lkmVi8eT+kJCjUkRWTVkds75bN72DWKHE/Sl5vty3265RDOuZz8Rmt/8VXTjUcm4CcgbrhqtafCqECN39NhJSS7vRTZP1/p6yQRfIi8jEy57nnWL3IW+5arVv75bG5fSIO3mzlTntDYTfZxYODdNjcMgY7rmCHA1t36Y3b835IFz/0lCjtihmJ5Cv5CfbTYdb1dAWTPnRPfra1kfj0VGxJ/dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07sUYA0+Bnjxlpg4L/nrtkoFiqnL2PRuw7mMv+RyY5w=;
 b=kT4nhKPxhUsEg9RmC+a5alzxpNal670ZGxNU5XPR6dvvJvF0HvbcwQWBcDdaJ64pldcPb4tVgsXg50Z/lsTySaa1iZ6YHQB9AoShDpj/yGes6ZA7ORrLH53IyzBS6cxKPvFA09OvO6CN5+t0JxvTC5NEvZ9amcw40TVsneiqD+4Ox4qqqXHCtOAhaqdVQqOOvI8a8WnJ5/fn1FBn3bTclpv8rRlITGKrfPjrLANTngF3rB/73PPhrYJAj7PO9g8ggmQIk8mwxAYZbzNpTaTs4W/XNDhuV4XcT+os+f0r+Hy4ixRy0davJQrFOVgANYGIUgyDoWBnzmjouKcjnxa4Kg==
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 18:59:14 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::fd) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:57 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:54 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/6] mlxsw: spectrum: Search for free LAD ID once
Date: Fri, 26 Jan 2024 19:58:29 +0100
Message-ID: <903f25dbfc84fe1f384d92ea7f8902a2051bb7bc.1706293430.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6831d3c9-7c9c-48ab-1687-08dc1ea0e3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kUzRHYExMYbcv04VT81uwtFj33SEs4zN3TxTXw785l5qWrO4GhQN8t5JyZkRmhZkIl9O9GB5GHcXUyFytbaAdx2KM8B2uQqnbKT9+0J71pnIQkE0dHzlK5kQ4brawkq8ED+6CAhaWdiNZI4ZWIzOJxwHRGWkDqny0+OAHra5tPxgUmB+rXfRLuoskN87bOGu1evRtGyb8pA1iwDGRGwYjnS65s7WTN//zgThM+qbCkkEw/w4tiUhXxjRjJGHUUmg61vj/DtgSQXLeG7oJ6JspoDsUgYS9o66VBX/Z3vnHpFahaZvKjW/2GSvORSU40ZDGJhCFb2vLeW6ynP3mNZcvyllDGUaLuSDx62j4C4rfsR0KNXHSTzr+0Vk4ILkugJFgULdBv1gVHAdIDVTmlnPDWAd/gLTKrFu7j6Crcj5tIfqn7Y3pmg96rFA6A6XWzyFA8TxTEqVoFVEH0kdHIOPj5vi822ZgxIIsBM1s+xIIlX/LWNsaZd6MnZuj9K7uWwA0Jv1qHgAxMMaSYPnzSNtUhLLlC+NWqXfbqLxhNH3Wf39dI1LqCwfeUuWI3pR3MZJq3+QTP7EZW+GH3jHoVOt39wfZddoaC4d7xdvOQJx9lwCoaoGwUrrXvDXLRDuVn6VVL+3NYpeGF0ERvcX0AQpu3bb/HHT05FbGsjC9RcMIwVBR9Mo4BuCez1LeoH4LMVBvO00OAU0rPKbUMIwf/a4ubY9m3EefYPUyu637Jwr2D3S7A8WvPw3teEnQXd0XWBZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(7636003)(36860700001)(336012)(16526019)(426003)(47076005)(41300700001)(83380400001)(26005)(8936002)(4326008)(8676002)(54906003)(86362001)(70206006)(478600001)(110136005)(70586007)(36756003)(5660300002)(107886003)(316002)(2616005)(2906002)(6666004)(356005)(82740400003)(40460700003)(40480700001)(4533004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:14.2616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6831d3c9-7c9c-48ab-1687-08dc1ea0e3c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835

From: Amit Cohen <amcohen@nvidia.com>

Currently, the function mlxsw_sp_lag_index_get() is called twice - first
as part of NETDEV_PRECHANGEUPPER event and later as part of
NETDEV_CHANGEUPPER. This function will be changed in the next patch. To
simplify the code, call it only once as part of NETDEV_CHANGEUPPER
event and set an error message using 'extack' in case of failure.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 75fea062a984..556dfddff005 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4323,7 +4323,7 @@ static int mlxsw_sp_lag_col_port_disable(struct mlxsw_sp_port *mlxsw_sp_port,
 
 static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 				  struct net_device *lag_dev,
-				  u16 *p_lag_id)
+				  u16 *p_lag_id, struct netlink_ext_ack *extack)
 {
 	struct mlxsw_sp_lag *lag;
 	int free_lag_id = -1;
@@ -4340,8 +4340,11 @@ static int mlxsw_sp_lag_index_get(struct mlxsw_sp *mlxsw_sp,
 			free_lag_id = i;
 		}
 	}
-	if (free_lag_id < 0)
+	if (free_lag_id < 0) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Exceeded number of supported LAG devices");
 		return -EBUSY;
+	}
 	*p_lag_id = free_lag_id;
 	return 0;
 }
@@ -4352,12 +4355,6 @@ mlxsw_sp_master_lag_check(struct mlxsw_sp *mlxsw_sp,
 			  struct netdev_lag_upper_info *lag_upper_info,
 			  struct netlink_ext_ack *extack)
 {
-	u16 lag_id;
-
-	if (mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id) != 0) {
-		NL_SET_ERR_MSG_MOD(extack, "Exceeded number of supported LAG devices");
-		return false;
-	}
 	if (lag_upper_info->tx_type != NETDEV_LAG_TX_TYPE_HASH) {
 		NL_SET_ERR_MSG_MOD(extack, "LAG device using unsupported Tx type");
 		return false;
@@ -4474,7 +4471,7 @@ static int mlxsw_sp_port_lag_join(struct mlxsw_sp_port *mlxsw_sp_port,
 	u8 port_index;
 	int err;
 
-	err = mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id);
+	err = mlxsw_sp_lag_index_get(mlxsw_sp, lag_dev, &lag_id, extack);
 	if (err)
 		return err;
 	lag = &mlxsw_sp->lags[lag_id];
-- 
2.43.0


