Return-Path: <netdev+bounces-16902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1311D74F601
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D9D280D0C
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AEC1DDCE;
	Tue, 11 Jul 2023 16:45:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD51E506
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 16:45:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA36D2D5E
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:45:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=conK6mFOkJewZ0i1QxzBxHkqKxT2WixchbXf/ccvR47i2qr4LjsHhsMpTy9vkv0z90PIPC4hcLRON/tzko7czwcrw5Sc97w0hxvVMLTktHRCGJqy0AEbPhvDYqJ64uI2jzcnPMic3izW6JTTe1u7JOyTviestdW/klkEckiJbDo2RjLPzigK7FMVjkSA8cyy8oLt1dvkxg0ZqBPd45dn0YhO+cgafMqyt8ZYublIC+pml/L25Zqh9EIdu2+twS2Aqvg0bkQ9IagbrHCD5Xb7qVMXGgipnhumNf2+oEh9LrUJaWC0mKrLaaXwPtgtyEvcQGV7V7rXiFz7gd1pJ7BZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uF4XZKUz2+rfafaLCR+CVgpQSBxmtEXzMoV7iY3LtY=;
 b=EDFTIvMo4Xwu5a8CCFzSNENvfC8oAEuPZxnKWOaVU3g4bbEgKBijWadxcvPel0fMmQEPLPdyAizpku6TG4K1WnwlTMM1OAs0oanjJp/M05MMniKg+KA22wLwBq2cqPvxOQ6UOCev1WG3zCj8avOIBg0GyxXlW98hDkFF1UvIlv2SZmhIiD4IxHN99Ghs0mvelIUqAOZif7IAb8vOQc+Zv2jrtzzip4GtuWvVxpwrHy2hrKX3iF2YQZ9Z42cn3RsidTBY4zfn7XWKyd64y+7sve9LPy9/57xqxYuwy3MJ4MqAPO7LqGpNZ5MLnhmNrlmr7Nvm4q55dLb9dBomDof/OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uF4XZKUz2+rfafaLCR+CVgpQSBxmtEXzMoV7iY3LtY=;
 b=FWFDBKDRWd5A8LWdbkwqe86pY50GEudzu9YWr1A+F07xMM/fZ3h8gG/eWhoZs6O8aPx3IZlyLMeHQevphsCWYs5z+F3MC+MwhtdVX3o3OVm33xrjhb5FZya1XTa+8VqL6TBzBCKwRQgdlvdtLhgUJTF25vKRbkrbdKn1I1ZlzWRN68/hTBM1gkT7tpCtfZrAp3XF/hnf78MeCnuYyS0WDygxATqhFDtOB0oi0Sth8cuNFOkO2lZ+LDpFqrdGA+tAXCzudI9TxCtk/8zO4XrJMwVSYZnt/3grEa0X38GhX9Ur8ztWh7YQkHC303D9mLyHDOXIjxTD0qG4GvxG1tPYVg==
Received: from DS7PR06CA0050.namprd06.prod.outlook.com (2603:10b6:8:54::32) by
 DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.26; Tue, 11 Jul 2023 16:44:53 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::d2) by DS7PR06CA0050.outlook.office365.com
 (2603:10b6:8:54::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Tue, 11 Jul 2023 16:44:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.20 via Frontend Transport; Tue, 11 Jul 2023 16:44:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Jul 2023
 09:44:40 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Jul
 2023 09:44:38 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 06/10] mlxsw: spectrum_acl: Pass main driver structure to mlxsw_sp_acl_rulei_destroy()
Date: Tue, 11 Jul 2023 18:43:59 +0200
Message-ID: <24d96a4e21310e5de2951ace58263db35e44a0df.1689092769.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689092769.git.petrm@nvidia.com>
References: <cover.1689092769.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cc2f69-7781-44ad-e267-08db822e26cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dDhH+T7IAwheU2Zi4nNs0ljx/QP1KdgGyu3ZpYrjAS8iJm4U6b0RnqBkzyUj7RtkFV0qYs0UX+xzRltxhCKAVoSV1mPsbLZ+lG+HrKiua9DFpv66Wa8PH02ABO/1xq3T/KcdLE5iFoigzLUV5lIaGp6HeCfIR47nnkzaqNJjxUPe4WeBsIHsw/a6AlyCdoKTilR9L0STbcyHo5CbIeq/HwB7MGfBQzDQ9a1OX1dKilyOYAxOxV/x0YFZeX5+Zzq6aoSLND0d78cijQbtCcqlORAZ7wHiUQNQkWqipwmkF+EbxshCoNpv0V9x8AQbgKUc1ogqrCv2j5vssN7p5z275Ou4MSanUQJHmiTUjl4teJT57NT2HVd0tpQhDUhlgSg79eghrbvEdR1INpEfx993VixVpiwkoT1IXtlPvccwJpuy05+vSOlvqu/j0aN5lvau3zAcXJjoLkDKlhswAiY+dcgSAzihwH/jGHZ08T2/2i0AUJL0/jXVq67ZSQkWRHAjtozaMJHQr4T0wDNSnq/aTYtt/SuDOIvTszSjHPZ7feQlB5f+JEZzbI77N3mgBFGPmKC0TGqaxpO7M7Np10ZbKId9P5JIa4DgZu6z5/a1i71iLL7MULf+kYyYpuBInbBg///OPewG8Sdwd/Oe8Vmc1qILz4GkFHJPI1Ia2ol9mLgFR3NE7IZ5/RF58lPJH8GbP+7E5HFEeX4E1a6aauo/fjfqGndv61i7xAh/+2Kt87LrL0tfZiI83l1ijxZf3Kee
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(4326008)(70586007)(70206006)(316002)(41300700001)(2906002)(478600001)(8936002)(8676002)(5660300002)(110136005)(54906003)(36860700001)(40460700003)(6666004)(107886003)(40480700001)(26005)(336012)(186003)(36756003)(83380400001)(426003)(47076005)(16526019)(7636003)(356005)(82740400003)(2616005)(82310400005)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:44:53.2784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cc2f69-7781-44ad-e267-08db822e26cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ido Schimmel <idosch@nvidia.com>

The main driver structure will be needed in this function by a
subsequent patch, so pass it. No functional changes intended.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           | 3 ++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c | 4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c       | 5 +++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index a74652ea4d7c..4a1bf2d39fa0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -994,7 +994,8 @@ void mlxsw_sp_acl_ruleset_prio_get(struct mlxsw_sp_acl_ruleset *ruleset,
 struct mlxsw_sp_acl_rule_info *
 mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 			  struct mlxsw_afa_block *afa_block);
-void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp_acl_rule_info *rulei);
+void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_acl_rule_info *rulei);
 int mlxsw_sp_acl_rulei_commit(struct mlxsw_sp_acl_rule_info *rulei);
 void mlxsw_sp_acl_rulei_priority(struct mlxsw_sp_acl_rule_info *rulei,
 				 unsigned int priority);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c
index 3a636f753607..dfcdd37e797b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum1_acl_tcam.c
@@ -90,7 +90,7 @@ mlxsw_sp1_acl_ctcam_region_catchall_add(struct mlxsw_sp *mlxsw_sp,
 err_entry_add:
 err_rulei_commit:
 err_rulei_act_continue:
-	mlxsw_sp_acl_rulei_destroy(rulei);
+	mlxsw_sp_acl_rulei_destroy(mlxsw_sp, rulei);
 err_rulei_create:
 	mlxsw_sp_acl_ctcam_chunk_fini(&region->catchall.cchunk);
 	return err;
@@ -105,7 +105,7 @@ mlxsw_sp1_acl_ctcam_region_catchall_del(struct mlxsw_sp *mlxsw_sp,
 	mlxsw_sp_acl_ctcam_entry_del(mlxsw_sp, &region->cregion,
 				     &region->catchall.cchunk,
 				     &region->catchall.centry);
-	mlxsw_sp_acl_rulei_destroy(rulei);
+	mlxsw_sp_acl_rulei_destroy(mlxsw_sp, rulei);
 	mlxsw_sp_acl_ctcam_chunk_fini(&region->catchall.cchunk);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 0423ac262d89..7240b74b4883 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -339,7 +339,8 @@ mlxsw_sp_acl_rulei_create(struct mlxsw_sp_acl *acl,
 	return ERR_PTR(err);
 }
 
-void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp_acl_rule_info *rulei)
+void mlxsw_sp_acl_rulei_destroy(struct mlxsw_sp *mlxsw_sp,
+				struct mlxsw_sp_acl_rule_info *rulei)
 {
 	if (rulei->action_created)
 		mlxsw_afa_block_destroy(rulei->act_block);
@@ -834,7 +835,7 @@ void mlxsw_sp_acl_rule_destroy(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_acl_ruleset *ruleset = rule->ruleset;
 
-	mlxsw_sp_acl_rulei_destroy(rule->rulei);
+	mlxsw_sp_acl_rulei_destroy(mlxsw_sp, rule->rulei);
 	kfree(rule);
 	mlxsw_sp_acl_ruleset_ref_dec(mlxsw_sp, ruleset);
 }
-- 
2.40.1


