Return-Path: <netdev+bounces-66254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB0F83E21A
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 19:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FCD1F2411B
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA7C22333;
	Fri, 26 Jan 2024 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AkdI/9Xn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F868210ED
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295566; cv=fail; b=qSR9V6vcP2+8fYLR+DtzP0UUNYrywUPglCPXjXeeZasolF5N0Buo/9QLA3xOR8rR4jrqzn50ntYGgh3TP88nzKlAkZ3CBx6RIkFbf/uZHDT1wxBiZH+8KUhM9bvaw/X/6hiMhjXA24DU6geq7b0x9Y0MxSIMxOJDQgKWWBiJ5+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295566; c=relaxed/simple;
	bh=FERHuUg7a05rGcjtKusL/7DEMA9LkpsltrrbrjW1bAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIZfj46UMUe+q33UydEmexsc2I+kGhbw41esvamktQ6vvPQyDHE7o1kXVJkLLbZxGE9C4ZoOxucwNjjUQ7bj9uxrmmp83TNYBjwKg3z6kRnWszEPe6Ulzldl1kJEAgMHbiDzJmeMkxHsz7xrnhCjzcNCr/4iYVM0WzlXWOjmeWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AkdI/9Xn; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VljqBYpLN/CnP+HAC1nM2lk39AgjyyBPEHq6ZhZzJkwC0GcmHGmOaj2o4zbgNGLrAfItH5f4N3/qt62Rec9Q3/aahV6qTf0APHfXrxhJGovUJl6qvWK2eKWLHqdOyxFK/WbKNUaszLpsXi95laAnqwYpGt70lqwz7iU7d+tafGUQgIDqtj59D/orIAMPeI6+p0Ukl02JifAeOTkf2m5qr0ByZShFtqe/M4RsviNDTBuCpk/m1STDNp7P4P27YNvWyxKRB+dao65ehF1vxH3ZuEh+90jPnZRVMlhXOZ43gYX9ON6LOU4SsOuxu53S36EcgaEND0ktqGesOvXgdpYYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xj5Q7kuL829aQHX8uO0t5JH4W2yn9zi8WgzD4h8uGw=;
 b=Mh3WB2Zywu8n6qSFC4uxzWjNqJwBG7eZBS1/YFd9VO/I2pkuIrb3w6KzHanemQ28XihQCQX7mLSmvnnhRIlPMs+0QAzn08d40O36ZAzqQnXU5qXjWbYQpKeg5ySvMpmM4M65n7Fqnp4NUgtt5DXP33Rc+jbAcH5V8nt2kWK3g0eIKY4pQht/MOen9iam3DYKNp91B2gh82eyosdmHfn0GA3UsromnGOXg45GbZ3c9drziHKjy4RgF2dM/cnM93Cj/4TVmh/LdXwfNtyo7CfwOvJ6Gy9pAiSF7Bc8Ldd3ieE0/9c3w2PQSDtAIviHEy3avpz2SpAq+nXeS2pBMIbUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xj5Q7kuL829aQHX8uO0t5JH4W2yn9zi8WgzD4h8uGw=;
 b=AkdI/9Xn7hdSR/tSNRm4dkRiZYJQfNkdyA4PDgO1Ag7jFnBgLQW+dVLRqtPDQpFFL4G0QTc76/Be49Oh9yH9V6v1y8G0d8Qv5iE0h1t1hiCT0AgOirVveTV/gB2xw0wngcvQSd97o58MbyZD2FqjhLYSPbqBc2xp4XWE6bsurpNOr6GIoBTjtrmypOAabw6EVsoQdfbrnf6VtZUrHipeQv6Bgt9nG1504MDTuP36XBCEmTRIYfvtMG+LDfJ0QxtPFDwq4U0f6/7iXsb9yXbDqvHPq0rlyNNisNWTj4XXufPC9nsz3/O56ifkA2bLhlncb40CmeTGbivSgdns+RRK8Q==
Received: from DS7PR06CA0037.namprd06.prod.outlook.com (2603:10b6:8:54::12) by
 DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Fri, 26 Jan 2024 18:59:14 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::e0) by DS7PR06CA0037.outlook.office365.com
 (2603:10b6:8:54::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 18:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 18:59:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:59:02 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 26 Jan
 2024 10:58:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 6/6] mlxsw: Use refcount_t for reference counting
Date: Fri, 26 Jan 2024 19:58:31 +0100
Message-ID: <4ffc173920a7b0780dee4f5af91e0d44d0b898f3.1706293430.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS7PR12MB8202:EE_
X-MS-Office365-Filtering-Correlation-Id: 246d0298-139d-4357-f4fb-08dc1ea0e385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ln7tlKngaH9HDzluGRXq14fchTeyLMer1Vt6m0PcOaYrKDHn71AlUApqiSQIMt2wr84icO2aDliaOW4REEsvkQhIHB50R6z2R7etSN4XY6Xqd0NMP7f7A2meS0RhpYqp7jKfZWBc+aPv6aLx28N1faMWtsl/+44/Q1ADCS8DdRQjzLsk4Fc/mTzt064yWDBsceVpyEeDXVNlW7T9HwvfY7bjg93NnrMElDwljC7nuIvhQMLRg8Bb5mhXLpGMPOUvfr4lNJ2o1xq0q0Kb0bp/QdUyRqRe5OePjSuWM0yX6ylPO3yp21CGJokvWgBxYNnFyykuGpbglqS2c1mhjcPYJvzTS3SzGnLW2dx6q/ONZHZaIHaN3lsVF2+SY4HuJjoTceDOqRKx6yC3lhiQAIIiXMH6kqec4YWfqkD6g9U2+tzsB5gLbwkYMvUpvFhQDMLVdiMsQOlNVYZptdwN7C0CPINEOe1oPmZT2O2zQShSXruK25Iee5DCZQfFHoCVIr4F17YqtPI9vxn9K3G2qXBzlPnThpo9DC/nwhT2yIcvtU5ZhbQBcrbz9h4wMDlUPylbD8Qho9bRx6Bgc8nO9PhhayWT87pl94Yi1RA8XzFiKel+U8OO1kvXkLSYp95EJ5nULEE9QhulU6Z1i4fMQQe46fkWHs6rcPJ86gO/C6nHqs4BACOH+kyX02avzFfrZx9m0OtJDlNoRonyLf1R2yuP8ilN0EJG6Uupl4Qs5C7EUbQPQr+IpR+h7xdKB+bhaB4j
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(2906002)(30864003)(5660300002)(41300700001)(426003)(16526019)(66574015)(82740400003)(478600001)(36860700001)(40460700003)(26005)(6666004)(47076005)(83380400001)(86362001)(107886003)(4326008)(2616005)(356005)(40480700001)(110136005)(7636003)(8936002)(54906003)(316002)(336012)(70206006)(8676002)(70586007)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 18:59:13.9012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246d0298-139d-4357-f4fb-08dc1ea0e385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8202

From: Amit Cohen <amcohen@nvidia.com>

mlxsw driver uses 'unsigned int' for reference counters in several
structures. Instead, use refcount_t type which allows us to catch overflow
and underflow issues. Change the type of the counters and use the
appropriate API.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/core_acl_flex_actions.c      | 16 ++++++++--------
 .../mellanox/mlxsw/core_acl_flex_keys.c         |  9 +++++----
 .../net/ethernet/mellanox/mlxsw/spectrum_acl.c  | 11 ++++++-----
 .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 17 +++++++++--------
 .../ethernet/mellanox/mlxsw/spectrum_router.c   | 15 ++++++++-------
 .../mellanox/mlxsw/spectrum_switchdev.c         |  8 ++++----
 6 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
index faa63ea9b83e..1915fa41c622 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -95,7 +95,7 @@ struct mlxsw_afa_set {
 		      */
 	   has_trap:1,
 	   has_police:1;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	struct mlxsw_afa_set *next; /* Pointer to the next set. */
 	struct mlxsw_afa_set *prev; /* Pointer to the previous set,
 				     * note that set may have multiple
@@ -120,7 +120,7 @@ struct mlxsw_afa_fwd_entry {
 	struct rhash_head ht_node;
 	struct mlxsw_afa_fwd_entry_ht_key ht_key;
 	u32 kvdl_index;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 static const struct rhashtable_params mlxsw_afa_fwd_entry_ht_params = {
@@ -282,7 +282,7 @@ static struct mlxsw_afa_set *mlxsw_afa_set_create(bool is_first)
 	/* Need to initialize the set to pass by default */
 	mlxsw_afa_set_goto_set(set, MLXSW_AFA_SET_GOTO_BINDING_CMD_TERM, 0);
 	set->ht_key.is_first = is_first;
-	set->ref_count = 1;
+	refcount_set(&set->ref_count, 1);
 	return set;
 }
 
@@ -330,7 +330,7 @@ static void mlxsw_afa_set_unshare(struct mlxsw_afa *mlxsw_afa,
 static void mlxsw_afa_set_put(struct mlxsw_afa *mlxsw_afa,
 			      struct mlxsw_afa_set *set)
 {
-	if (--set->ref_count)
+	if (!refcount_dec_and_test(&set->ref_count))
 		return;
 	if (set->shared)
 		mlxsw_afa_set_unshare(mlxsw_afa, set);
@@ -350,7 +350,7 @@ static struct mlxsw_afa_set *mlxsw_afa_set_get(struct mlxsw_afa *mlxsw_afa,
 	set = rhashtable_lookup_fast(&mlxsw_afa->set_ht, &orig_set->ht_key,
 				     mlxsw_afa_set_ht_params);
 	if (set) {
-		set->ref_count++;
+		refcount_inc(&set->ref_count);
 		mlxsw_afa_set_put(mlxsw_afa, orig_set);
 	} else {
 		set = orig_set;
@@ -564,7 +564,7 @@ mlxsw_afa_fwd_entry_create(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 	if (!fwd_entry)
 		return ERR_PTR(-ENOMEM);
 	fwd_entry->ht_key.local_port = local_port;
-	fwd_entry->ref_count = 1;
+	refcount_set(&fwd_entry->ref_count, 1);
 
 	err = rhashtable_insert_fast(&mlxsw_afa->fwd_entry_ht,
 				     &fwd_entry->ht_node,
@@ -607,7 +607,7 @@ mlxsw_afa_fwd_entry_get(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 	fwd_entry = rhashtable_lookup_fast(&mlxsw_afa->fwd_entry_ht, &ht_key,
 					   mlxsw_afa_fwd_entry_ht_params);
 	if (fwd_entry) {
-		fwd_entry->ref_count++;
+		refcount_inc(&fwd_entry->ref_count);
 		return fwd_entry;
 	}
 	return mlxsw_afa_fwd_entry_create(mlxsw_afa, local_port);
@@ -616,7 +616,7 @@ mlxsw_afa_fwd_entry_get(struct mlxsw_afa *mlxsw_afa, u16 local_port)
 static void mlxsw_afa_fwd_entry_put(struct mlxsw_afa *mlxsw_afa,
 				    struct mlxsw_afa_fwd_entry *fwd_entry)
 {
-	if (--fwd_entry->ref_count)
+	if (!refcount_dec_and_test(&fwd_entry->ref_count))
 		return;
 	mlxsw_afa_fwd_entry_destroy(mlxsw_afa, fwd_entry);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
index 0d5e6f9b466e..947500f8ed71 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_keys.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 
 #include "item.h"
 #include "core_acl_flex_keys.h"
@@ -107,7 +108,7 @@ EXPORT_SYMBOL(mlxsw_afk_destroy);
 
 struct mlxsw_afk_key_info {
 	struct list_head list;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	unsigned int blocks_count;
 	int element_to_block[MLXSW_AFK_ELEMENT_MAX]; /* index is element, value
 						      * is index inside "blocks"
@@ -334,7 +335,7 @@ mlxsw_afk_key_info_create(struct mlxsw_afk *mlxsw_afk,
 	if (err)
 		goto err_picker;
 	list_add(&key_info->list, &mlxsw_afk->key_info_list);
-	key_info->ref_count = 1;
+	refcount_set(&key_info->ref_count, 1);
 	return key_info;
 
 err_picker:
@@ -356,7 +357,7 @@ mlxsw_afk_key_info_get(struct mlxsw_afk *mlxsw_afk,
 
 	key_info = mlxsw_afk_key_info_find(mlxsw_afk, elusage);
 	if (key_info) {
-		key_info->ref_count++;
+		refcount_inc(&key_info->ref_count);
 		return key_info;
 	}
 	return mlxsw_afk_key_info_create(mlxsw_afk, elusage);
@@ -365,7 +366,7 @@ EXPORT_SYMBOL(mlxsw_afk_key_info_get);
 
 void mlxsw_afk_key_info_put(struct mlxsw_afk_key_info *key_info)
 {
-	if (--key_info->ref_count)
+	if (!refcount_dec_and_test(&key_info->ref_count))
 		return;
 	mlxsw_afk_key_info_destroy(key_info);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 7c59c8a13584..b01b000bc71c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -9,6 +9,7 @@
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <net/net_namespace.h>
 #include <net/tc_act/tc_vlan.h>
 
@@ -55,7 +56,7 @@ struct mlxsw_sp_acl_ruleset {
 	struct rhash_head ht_node; /* Member of acl HT */
 	struct mlxsw_sp_acl_ruleset_ht_key ht_key;
 	struct rhashtable rule_ht;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	unsigned int min_prio;
 	unsigned int max_prio;
 	unsigned long priv[];
@@ -99,7 +100,7 @@ static bool
 mlxsw_sp_acl_ruleset_is_singular(const struct mlxsw_sp_acl_ruleset *ruleset)
 {
 	/* We hold a reference on ruleset ourselves */
-	return ruleset->ref_count == 2;
+	return refcount_read(&ruleset->ref_count) == 2;
 }
 
 int mlxsw_sp_acl_ruleset_bind(struct mlxsw_sp *mlxsw_sp,
@@ -176,7 +177,7 @@ mlxsw_sp_acl_ruleset_create(struct mlxsw_sp *mlxsw_sp,
 	ruleset = kzalloc(alloc_size, GFP_KERNEL);
 	if (!ruleset)
 		return ERR_PTR(-ENOMEM);
-	ruleset->ref_count = 1;
+	refcount_set(&ruleset->ref_count, 1);
 	ruleset->ht_key.block = block;
 	ruleset->ht_key.chain_index = chain_index;
 	ruleset->ht_key.ops = ops;
@@ -222,13 +223,13 @@ static void mlxsw_sp_acl_ruleset_destroy(struct mlxsw_sp *mlxsw_sp,
 
 static void mlxsw_sp_acl_ruleset_ref_inc(struct mlxsw_sp_acl_ruleset *ruleset)
 {
-	ruleset->ref_count++;
+	refcount_inc(&ruleset->ref_count);
 }
 
 static void mlxsw_sp_acl_ruleset_ref_dec(struct mlxsw_sp *mlxsw_sp,
 					 struct mlxsw_sp_acl_ruleset *ruleset)
 {
-	if (--ruleset->ref_count)
+	if (!refcount_dec_and_test(&ruleset->ref_count))
 		return;
 	mlxsw_sp_acl_ruleset_destroy(mlxsw_sp, ruleset);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 50ea1eff02b2..f20052776b3f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -9,6 +9,7 @@
 #include <linux/rhashtable.h>
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
+#include <linux/refcount.h>
 #include <net/devlink.h>
 #include <trace/events/mlxsw.h>
 
@@ -155,7 +156,7 @@ struct mlxsw_sp_acl_tcam_vregion {
 		struct mlxsw_sp_acl_tcam_rehash_ctx ctx;
 	} rehash;
 	struct mlxsw_sp *mlxsw_sp;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 struct mlxsw_sp_acl_tcam_vchunk;
@@ -176,7 +177,7 @@ struct mlxsw_sp_acl_tcam_vchunk {
 	unsigned int priority; /* Priority within the vregion and group */
 	struct mlxsw_sp_acl_tcam_vgroup *vgroup;
 	struct mlxsw_sp_acl_tcam_vregion *vregion;
-	unsigned int ref_count;
+	refcount_t ref_count;
 };
 
 struct mlxsw_sp_acl_tcam_entry {
@@ -769,7 +770,7 @@ mlxsw_sp_acl_tcam_vregion_create(struct mlxsw_sp *mlxsw_sp,
 	vregion->tcam = tcam;
 	vregion->mlxsw_sp = mlxsw_sp;
 	vregion->vgroup = vgroup;
-	vregion->ref_count = 1;
+	refcount_set(&vregion->ref_count, 1);
 
 	vregion->key_info = mlxsw_afk_key_info_get(afk, elusage);
 	if (IS_ERR(vregion->key_info)) {
@@ -856,7 +857,7 @@ mlxsw_sp_acl_tcam_vregion_get(struct mlxsw_sp *mlxsw_sp,
 			 */
 			return ERR_PTR(-EOPNOTSUPP);
 		}
-		vregion->ref_count++;
+		refcount_inc(&vregion->ref_count);
 		return vregion;
 	}
 
@@ -871,7 +872,7 @@ static void
 mlxsw_sp_acl_tcam_vregion_put(struct mlxsw_sp *mlxsw_sp,
 			      struct mlxsw_sp_acl_tcam_vregion *vregion)
 {
-	if (--vregion->ref_count)
+	if (!refcount_dec_and_test(&vregion->ref_count))
 		return;
 	mlxsw_sp_acl_tcam_vregion_destroy(mlxsw_sp, vregion);
 }
@@ -924,7 +925,7 @@ mlxsw_sp_acl_tcam_vchunk_create(struct mlxsw_sp *mlxsw_sp,
 	INIT_LIST_HEAD(&vchunk->ventry_list);
 	vchunk->priority = priority;
 	vchunk->vgroup = vgroup;
-	vchunk->ref_count = 1;
+	refcount_set(&vchunk->ref_count, 1);
 
 	vregion = mlxsw_sp_acl_tcam_vregion_get(mlxsw_sp, vgroup,
 						priority, elusage);
@@ -1008,7 +1009,7 @@ mlxsw_sp_acl_tcam_vchunk_get(struct mlxsw_sp *mlxsw_sp,
 		if (WARN_ON(!mlxsw_afk_key_info_subset(vchunk->vregion->key_info,
 						       elusage)))
 			return ERR_PTR(-EINVAL);
-		vchunk->ref_count++;
+		refcount_inc(&vchunk->ref_count);
 		return vchunk;
 	}
 	return mlxsw_sp_acl_tcam_vchunk_create(mlxsw_sp, vgroup,
@@ -1019,7 +1020,7 @@ static void
 mlxsw_sp_acl_tcam_vchunk_put(struct mlxsw_sp *mlxsw_sp,
 			     struct mlxsw_sp_acl_tcam_vchunk *vchunk)
 {
-	if (--vchunk->ref_count)
+	if (!refcount_dec_and_test(&vchunk->ref_count))
 		return;
 	mlxsw_sp_acl_tcam_vchunk_destroy(mlxsw_sp, vchunk);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7164f9e6370f..87617df694ab 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -501,7 +501,7 @@ struct mlxsw_sp_rt6 {
 
 struct mlxsw_sp_lpm_tree {
 	u8 id; /* tree ID */
-	unsigned int ref_count;
+	refcount_t ref_count;
 	enum mlxsw_sp_l3proto proto;
 	unsigned long prefix_ref_count[MLXSW_SP_PREFIX_COUNT];
 	struct mlxsw_sp_prefix_usage prefix_usage;
@@ -578,7 +578,7 @@ mlxsw_sp_lpm_tree_find_unused(struct mlxsw_sp *mlxsw_sp)
 
 	for (i = 0; i < mlxsw_sp->router->lpm.tree_count; i++) {
 		lpm_tree = &mlxsw_sp->router->lpm.trees[i];
-		if (lpm_tree->ref_count == 0)
+		if (refcount_read(&lpm_tree->ref_count) == 0)
 			return lpm_tree;
 	}
 	return NULL;
@@ -654,7 +654,7 @@ mlxsw_sp_lpm_tree_create(struct mlxsw_sp *mlxsw_sp,
 	       sizeof(lpm_tree->prefix_usage));
 	memset(&lpm_tree->prefix_ref_count, 0,
 	       sizeof(lpm_tree->prefix_ref_count));
-	lpm_tree->ref_count = 1;
+	refcount_set(&lpm_tree->ref_count, 1);
 	return lpm_tree;
 
 err_left_struct_set:
@@ -678,7 +678,7 @@ mlxsw_sp_lpm_tree_get(struct mlxsw_sp *mlxsw_sp,
 
 	for (i = 0; i < mlxsw_sp->router->lpm.tree_count; i++) {
 		lpm_tree = &mlxsw_sp->router->lpm.trees[i];
-		if (lpm_tree->ref_count != 0 &&
+		if (refcount_read(&lpm_tree->ref_count) &&
 		    lpm_tree->proto == proto &&
 		    mlxsw_sp_prefix_usage_eq(&lpm_tree->prefix_usage,
 					     prefix_usage)) {
@@ -691,14 +691,15 @@ mlxsw_sp_lpm_tree_get(struct mlxsw_sp *mlxsw_sp,
 
 static void mlxsw_sp_lpm_tree_hold(struct mlxsw_sp_lpm_tree *lpm_tree)
 {
-	lpm_tree->ref_count++;
+	refcount_inc(&lpm_tree->ref_count);
 }
 
 static void mlxsw_sp_lpm_tree_put(struct mlxsw_sp *mlxsw_sp,
 				  struct mlxsw_sp_lpm_tree *lpm_tree)
 {
-	if (--lpm_tree->ref_count == 0)
-		mlxsw_sp_lpm_tree_destroy(mlxsw_sp, lpm_tree);
+	if (!refcount_dec_and_test(&lpm_tree->ref_count))
+		return;
+	mlxsw_sp_lpm_tree_destroy(mlxsw_sp, lpm_tree);
 }
 
 #define MLXSW_SP_LPM_TREE_MIN 1 /* tree 0 is reserved */
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6c749c148148..6397ff0dc951 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -61,7 +61,7 @@ struct mlxsw_sp_bridge_port {
 	struct mlxsw_sp_bridge_device *bridge_device;
 	struct list_head list;
 	struct list_head vlans_list;
-	unsigned int ref_count;
+	refcount_t ref_count;
 	u8 stp_state;
 	unsigned long flags;
 	bool mrouter;
@@ -495,7 +495,7 @@ mlxsw_sp_bridge_port_create(struct mlxsw_sp_bridge_device *bridge_device,
 			     BR_MCAST_FLOOD;
 	INIT_LIST_HEAD(&bridge_port->vlans_list);
 	list_add(&bridge_port->list, &bridge_device->ports_list);
-	bridge_port->ref_count = 1;
+	refcount_set(&bridge_port->ref_count, 1);
 
 	err = switchdev_bridge_port_offload(brport_dev, mlxsw_sp_port->dev,
 					    NULL, NULL, NULL, false, extack);
@@ -531,7 +531,7 @@ mlxsw_sp_bridge_port_get(struct mlxsw_sp_bridge *bridge,
 
 	bridge_port = mlxsw_sp_bridge_port_find(bridge, brport_dev);
 	if (bridge_port) {
-		bridge_port->ref_count++;
+		refcount_inc(&bridge_port->ref_count);
 		return bridge_port;
 	}
 
@@ -558,7 +558,7 @@ static void mlxsw_sp_bridge_port_put(struct mlxsw_sp_bridge *bridge,
 {
 	struct mlxsw_sp_bridge_device *bridge_device;
 
-	if (--bridge_port->ref_count != 0)
+	if (!refcount_dec_and_test(&bridge_port->ref_count))
 		return;
 	bridge_device = bridge_port->bridge_device;
 	mlxsw_sp_bridge_port_destroy(bridge_port);
-- 
2.43.0


