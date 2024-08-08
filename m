Return-Path: <netdev+bounces-116711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08F94B675
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37331C20897
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0237213CFB8;
	Thu,  8 Aug 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TP6CmevD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF87139D07
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096914; cv=fail; b=KegAjnLQ0yxHeJ6+o/6qP28ZwawxIfyjKN8gv2lIgi09KtguyGjYC3NWFloEPbcrSUoBa1hLob9YjnkIR2sWKOhV5ZHobFMgqNs9TklYe+1fUCInDm6Jqp4TCQu/Orxxp+1+lJj86Vpy/sq6q0NaJjy0VAL0xXESetB/gcE84ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096914; c=relaxed/simple;
	bh=wGr5qERaHR0SQ8Hz6FrTgZTQ63kINg9A5rPW0EFDprE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPbGXCaXZJLczewq8vVMXTwLi/iAAKz8QIaP2y1wHCgDt6pkyCyahIX8a6D9TGXPpOhVO1tpxCsOrUOzXwWgbabB5kaiV3haCAPX4IfIPErfu0hyTIzciTNqj/epulhByESg2TmpdgMDPOmRk03dZizn3/7SUGF3p3QKTBgTTs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TP6CmevD; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5pwaeCrT454GwSzpA/hdxoHJ4zFwDioonUBtaYOi+8+PEJaT1imweNmrqNVW/4ZX4+5y+jArPdWcdyuc9AsTwmjMTgUnT5ZWm2S9G67ROb+uTCg4NK661SV8UfakU9lJ7LNR7Hq1WrWh5fbjn9RcOOOdJ+XRmGx1mRG7npRQrKjNbp3C3XqNpiOVDZ3+QesEEdzPIRW4HP7pfODg15k8TyZCw0dcfNEzd4UW4exsCoKd8MhA3x9p7E6o4F+hDGzUH4IwCfRyLc4cdaqRVU+nxsEJ8zJkMPj5QrgaT7KyHTprj0/d4CQuJrUUbWwZtoJ09MXDbbPjD76zaTTeJwKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHiiWWl99fZI0fSm8Jbh8oTKzIM48DKXCCIkvG/gFUY=;
 b=HDxyW9IViDXcC7tlu9PCCBJ+x/eNGdvRD4yvUqSNazwp04V8/Tq4IGAA12fOLmgTDFVW+Zf2CqyWVKyLcsHK+pzxQTqkjEAIVEM/x608t9103b3vmBt7cGSSzXfMvCRB8+yaYjX+wkhwtN8pFcRPQ04ghvMptAqdlY4xYWVmQXeZDAdnOdwWzvcE5kdL+rH22UZwOb+EzbFaH1h54OO6FCF89h71rGpd0JaZliCLhRof1nxPjceogCElPKtWskYPrHf4zZFBpTsIrcbqhtSRBbRJ+ZB1375XF8aPqGCsddzOggdgipbJXp1DiKLNKW+lpWbfh0Jm+PyiyCndByNepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHiiWWl99fZI0fSm8Jbh8oTKzIM48DKXCCIkvG/gFUY=;
 b=TP6CmevDt9K9N57Xhw0QcSWFxg+J6gmvipEeABGVbb43q/P3AUhUwd0dkvv3iT1hRALREhz+NvlU2SvdPwGA1m0HHh3sEz0+VF9dAQsGaW6nL6sQ7jIYl2AO15eFdPIdgGf9P0he5Q8XY+78qr/mZDLdgewmbhittljh0/CHUTszaPg9ibE9m6J3EJ87dKEZ3seJ6XYxwGkxvXRyRKRzSFweIA+GBCmO9y5j/pmSzF025ThuK31UUKNCt1az1v386svaM9Ya6eQhG8+buqMTASw3UIxwxq0ZCYCTNu/lOYsLFMY34Nj2D4kj/a5T2+144bB1PVMsX8x5IDYYYP6oHw==
Received: from BYAPR05CA0105.namprd05.prod.outlook.com (2603:10b6:a03:e0::46)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 8 Aug
 2024 06:01:48 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::a5) by BYAPR05CA0105.outlook.office365.com
 (2603:10b6:a03:e0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Thu, 8 Aug 2024 06:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 06:01:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 7 Aug 2024
 23:01:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 7 Aug 2024 23:01:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 7 Aug 2024 23:01:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/11] net/mlx5e: CT: 'update' rules instead of 'replace'
Date: Thu, 8 Aug 2024 08:59:26 +0300
Message-ID: <20240808055927.2059700-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808055927.2059700-1-tariqt@nvidia.com>
References: <20240808055927.2059700-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c251c58-3c26-4023-f55c-08dcb76f96aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWEsx6UukOYFBAYKcdFy7h6g4Vy0O/lab/D4TIbLgJNqklluqttDVXa1mrQk?=
 =?us-ascii?Q?qk184boRXmdVgV/SNWoJUCxWTG0IXgvtPcQNfAqmX0Nti2WrWKdg1/Mo2s0Y?=
 =?us-ascii?Q?SPPM9CwXT3BXbwe0l+ZNJWVd+P+/MhGOyn/BwRy4r6UzzRx0ix2xzVqt03SV?=
 =?us-ascii?Q?61rTtjjq0q5V/Wc9b/N30Nm5RcB6nwpWC8987GFi1gzHOEdmVic2CeXYaxi0?=
 =?us-ascii?Q?R1AchdoN7ek4SJzAsuBQnYWiJSjw9iS1xmAyMCW/EzdjgMXz0sl/EDbM7uz1?=
 =?us-ascii?Q?hz34ipBGnm8YrbFuJazF4AjtLBCqzN2kA73/56b4gc9CsIYeWK+K2JusaZDJ?=
 =?us-ascii?Q?aztTEKgagogaBrte9so+V9d4YXGemEz/CJcJZHtifw/VALMYISNpHVdY4Rkk?=
 =?us-ascii?Q?T2Rgs9CipRFkYwXupg4BePPZHHtOgqLcM5g9+TsAkiuRKkGlIjvkt9nPkfko?=
 =?us-ascii?Q?dCxwIwovsM95L8m8LMttbbzVW/Mc14edfUEQcOAEkPi7jX28yA00G3p/pw81?=
 =?us-ascii?Q?B5T2KJH7dZGNMQWsdX9GcFSlQiLywb2luPEyDJDPnSNgTYwpCwgtpY8ry0Br?=
 =?us-ascii?Q?YwoewNog2ZiRGXEoTZAqSn1uiljV5MF/RODUjT4jakRie/Jb8v+0xkp7u+SJ?=
 =?us-ascii?Q?geDMf6D2d1sHUercXfGqUC7vm/gX//gcn2wNwN6as+Od4iW/rzxX4fqdm0jJ?=
 =?us-ascii?Q?sxkzyAKDpUc3KknsrgqxhfMAt3rw9tqKhKzDbEybNg5KDGfVh99887AdZfa7?=
 =?us-ascii?Q?PUdMYABCZk5YLuoR4stbxFba3LFLNKR7ZPoZlKknWecGDqPQsHxAvsYSn8dY?=
 =?us-ascii?Q?T3gy+TRtGImPyB/VUOhbyjCCg3ufJ5NwUlgxNA5gH5kLg4mPL/hcS6UQEy+L?=
 =?us-ascii?Q?rfblDlXY22WBQn8PhDKkSr1sdn/gl84o26rkhpJYGMnBloJd0rulW6HawsCA?=
 =?us-ascii?Q?CohapU1mJg6QyPzrRwHcFcXCEDxVxpF5qboBoQpviaKBTBkJtOpu+OI1vNsk?=
 =?us-ascii?Q?Dlm+OOGk/D5LEFt7iiIdoysp0J+3wthlhthHZkIi76Qjp6OTF77T2G8qTILV?=
 =?us-ascii?Q?F1g/UDQaieyezvE83/Jv3lm/WRhUDAQHywR4EE9p4HQUxR3xS61ebbGLe7B1?=
 =?us-ascii?Q?6P0Ov429A42T5VwGG6uK1CQ8znRKZbY6ZYU69yJZoG/eGeeCZFHqJjRDhWQI?=
 =?us-ascii?Q?HPHxaTUsiHrp8nrrn2d/TaXJiHasz9FaTHmRFcj4Cw1A4tkx0vEDy+rVFHIE?=
 =?us-ascii?Q?qhuXFaGXQnqC4CmRYS/c9MAlhHpacmCmMF9tOSSCKbT5BRj51eydNtFR4tqR?=
 =?us-ascii?Q?uZq7vrHuk2kbBacmBKxCnoJX6fI7dIVNG7MBHQHQdv2zqdo78LQD4Va9hlEY?=
 =?us-ascii?Q?CR248aMF+RE+0Uli6xMxcEt0Y6meLSPYjq7Nf0N1qCpkVqBc4dn2VTp4w43M?=
 =?us-ascii?Q?WxV7CiS4g5+DscPp3WqplKRqdykVCkby?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 06:01:47.5869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c251c58-3c26-4023-f55c-08dcb76f96aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979

From: Cosmin Ratiu <cratiu@nvidia.com>

Offloaded rules can be updated with a new modify header action
containing a changed restore cookie. This was done using the verb
'replace', while in some configurations 'update' is a better fit.

This commit renames the functions used to reflect that.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 71a168746ebe..ccee07d6ba1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -876,10 +876,10 @@ mlx5_tc_ct_entry_add_rule(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
-			      struct flow_rule *flow_rule,
-			      struct mlx5_ct_entry *entry,
-			      bool nat, u8 zone_restore_id)
+mlx5_tc_ct_entry_update_rule(struct mlx5_tc_ct_priv *ct_priv,
+			     struct flow_rule *flow_rule,
+			     struct mlx5_ct_entry *entry,
+			     bool nat, u8 zone_restore_id)
 {
 	struct mlx5_ct_zone_rule *zone_rule = &entry->zone_rules[nat];
 	struct mlx5_flow_attr *attr = zone_rule->attr, *old_attr;
@@ -924,7 +924,7 @@ mlx5_tc_ct_entry_replace_rule(struct mlx5_tc_ct_priv *ct_priv,
 
 	kfree(old_attr);
 	kvfree(spec);
-	ct_dbg("Replaced ct entry rule in zone %d", entry->tuple.zone);
+	ct_dbg("Updated ct entry rule in zone %d", entry->tuple.zone);
 
 	return 0;
 
@@ -1141,23 +1141,23 @@ mlx5_tc_ct_entry_add_rules(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
-			       struct flow_rule *flow_rule,
-			       struct mlx5_ct_entry *entry,
-			       u8 zone_restore_id)
+mlx5_tc_ct_entry_update_rules(struct mlx5_tc_ct_priv *ct_priv,
+			      struct flow_rule *flow_rule,
+			      struct mlx5_ct_entry *entry,
+			      u8 zone_restore_id)
 {
 	int err = 0;
 
 	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
-		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
-						    zone_restore_id);
+		err = mlx5_tc_ct_entry_update_rule(ct_priv, flow_rule, entry, false,
+						   zone_restore_id);
 		if (err)
 			return err;
 	}
 
 	if (mlx5_tc_ct_entry_in_ct_nat_table(entry)) {
-		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, true,
-						    zone_restore_id);
+		err = mlx5_tc_ct_entry_update_rule(ct_priv, flow_rule, entry, true,
+						   zone_restore_id);
 		if (err && mlx5_tc_ct_entry_in_ct_table(entry))
 			mlx5_tc_ct_entry_del_rule(ct_priv, entry, false);
 	}
@@ -1165,13 +1165,13 @@ mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
 }
 
 static int
-mlx5_tc_ct_block_flow_offload_replace(struct mlx5_ct_ft *ft, struct flow_rule *flow_rule,
-				      struct mlx5_ct_entry *entry, unsigned long cookie)
+mlx5_tc_ct_block_flow_offload_update(struct mlx5_ct_ft *ft, struct flow_rule *flow_rule,
+				     struct mlx5_ct_entry *entry, unsigned long cookie)
 {
 	struct mlx5_tc_ct_priv *ct_priv = ft->ct_priv;
 	int err;
 
-	err = mlx5_tc_ct_entry_replace_rules(ct_priv, flow_rule, entry, ft->zone_restore_id);
+	err = mlx5_tc_ct_entry_update_rules(ct_priv, flow_rule, entry, ft->zone_restore_id);
 	if (!err)
 		return 0;
 
@@ -1216,7 +1216,7 @@ mlx5_tc_ct_block_flow_offload_add(struct mlx5_ct_ft *ft,
 		entry->restore_cookie = meta_action->ct_metadata.cookie;
 		spin_unlock_bh(&ct_priv->ht_lock);
 
-		err = mlx5_tc_ct_block_flow_offload_replace(ft, flow_rule, entry, cookie);
+		err = mlx5_tc_ct_block_flow_offload_update(ft, flow_rule, entry, cookie);
 		mlx5_tc_ct_entry_put(entry);
 		return err;
 	}
-- 
2.44.0


