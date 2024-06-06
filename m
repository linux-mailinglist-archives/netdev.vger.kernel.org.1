Return-Path: <netdev+bounces-101464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E32838FF035
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6024A285E03
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C549419A28D;
	Thu,  6 Jun 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YNv2SQSb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40F198A2E
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717685568; cv=fail; b=nAz1/0kKmTeA2AeT8iy/NzpxRJxYRPUoz9yLTJISKCoZUT5zXbwVpLQNcxjCds85EdjxHq1r/jebHuG0YKVjYOIzPrxqSE5GmFc+yqZTIymji28rLK+LgIvKiTyQ1YnGRbxuxl+KuauK4X8OCdA64enoLV8MydvRgPSN8HJeSXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717685568; c=relaxed/simple;
	bh=wT7/QoYwvCUNafPrCTGlrnVbCO0jAcFDoAlzdjYMbTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TK/g2Tv9aBNJKcSrFzm0KUL/Q9spsvMciTmPiHkkxupG90vp1zk12OSK8q930iotyel3c58dKqzpJKgtSPXTl+y8wXbCALXTFvm6qA4dIE4iJSKDdSdFeth0ni0Mwpp+I78W8G0xhatWFTpsGzxrkJunqHLcFSfUIPi9DIIGoqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YNv2SQSb; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMyOG6wV2VQ+XaJe/K5JTQdKTGXaz8rDXjnwFv2w4V91tOPA5VFJzfNB5hnmx0DfyjwurF7UOR0TfX9OOwPR9z9j0r4FffAkwnRq1Ww2FF4J/q5dY2Lz6T+UwHXYT4Z2Va1xtUYaTDn7T3WjcsVD7slhklMjlyNzlnD+Q+iy5qRyx9vZkpQqGkacSae1uxYAG4r7G0Cf5mePJf/3pOoHiXa7aVNUFmq8Z/qBMmLuTbTlx2Dq4omt0b01wM8L7NA+ywMefy0mc2hXTg7wo8Ggw1ua2HBpBOzZwb6qEdKCSzeTfTLpMyUX9UOLMDqaL3XZXQ+53Fv6PLUlOmEBV2k0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61aW2yK2fXIFv+5jOXYzKMgWbcTcAgi/ieODbDQPBwg=;
 b=VJmvY9/VOm3KwrN4KgDNOtIJcZheMul/DedEx2sjh6qo9BsEEOu+C5PBNxWGNz9DQgGn4vOgQN5a4uFr6x6uuI/4CYEUZhZXimhAiEulU8hHBnhDB4KcbBfSfI+bQN8k7IzxLWtqwaEai8qW8LUJqCOnaFpST3ZwATNKn6+TdGjTGQoUgNvwfkYcqjMN55K7K+XJdYcDBzV7GRXkhd2XP2aE0rgNSP+IRVxmqrpGyc6cBdUoRa34leo6BogD3wYf256gACjTAOBEDwOdoYN8XYKVNQZKnHd4lrlW5G5nSPIdOLhLEoT39bmJVQBj9XSeUpTv4qz+dPQ/acx3zS61iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61aW2yK2fXIFv+5jOXYzKMgWbcTcAgi/ieODbDQPBwg=;
 b=YNv2SQSbB1hlsVkf7vF9MiUSC+Fp20cOp+Fz4J8Ozgfx4HAQXgp0XjxDTrik1aYqv8anNiOqvrZgeP/8vtrrFU5qIPRYR+3IFNjhlf11ZMRG4V94ydvsW9a4VJIkjt5COW01qXsBdF9oc5kNwBxKiw0Pp2Z0ny3r8jMOVfPvFJjXJlRluBo/sBpGeimBRQIJaxmmRyxUx6FeDzYsnFqwlFSAib3Ng5GyjAntewFqLp5RH4F4TaH5Cim/O4lLhNz26HfCztaciXdk6BpcozJwMzaXNCfg1GW+9wFgHn9m9zKE5lGLGYUY28IUB1AAED+788IdvFqbC8icSvSewlFEcw==
Received: from SA9PR13CA0043.namprd13.prod.outlook.com (2603:10b6:806:22::18)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:52:43 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::37) by SA9PR13CA0043.outlook.office365.com
 (2603:10b6:806:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.18 via Frontend
 Transport; Thu, 6 Jun 2024 14:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 14:52:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:25 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 6 Jun 2024
 07:52:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov
	<green@qrator.net>, <mlxsw@nvidia.com>
Subject: [PATCH net 4/6] lib: objagg: Fix general protection fault
Date: Thu, 6 Jun 2024 16:49:41 +0200
Message-ID: <3de2a4e3a61b58f948b3fd3b0f0763fabcd9a819.1717684365.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717684365.git.petrm@nvidia.com>
References: <cover.1717684365.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: a1dac28d-74f7-420d-0b4a-08dc8638526f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?flINteBcV1P8khnbuBGBgSbBVsTdJFmcICegK1jieqv2cHJxJ8+zd/BIXDbZ?=
 =?us-ascii?Q?SJPrBxQwAShAU7LyGugaS7j+382OSwQoVBKvYn4yPvXdZT64EtOSqAosbWv9?=
 =?us-ascii?Q?IZ7sGGv/WN6EX1cXsB10NASy1paYyVetrHrCZ1RJCmrp5BMDceyozOU5E4CM?=
 =?us-ascii?Q?DK6AMSAYWyt9LPb3Sx5ygv3D2gGOLqTZNgfuOKZIZZW1ne9ovgl3WMQpLk3x?=
 =?us-ascii?Q?Vb3A7VbBQKaM73aR1n65YTA4nHakb/p5f+i/OT0gFT/+4RWvsyx5Qvp88TgO?=
 =?us-ascii?Q?q2jrtRfX+dL061roJG7fry4RP8j4x6RHIgtO2FpzqnZ5toqolEsl7ZID8Was?=
 =?us-ascii?Q?1Eue9Qe+6UJz0C9LgDoQlk2DxWwX81/eFa6HjUv41pNOQlyxl2RhQjagsNvC?=
 =?us-ascii?Q?bQmwUJn3c+IbIe3s7Ik9a1bKiLUmRzPf2PGQEuL8HyyrMQYZQSGv8XNsZ+FC?=
 =?us-ascii?Q?uJzDM6bBnHwI9jC5H+IZd0ULz1II0SW18ZC4xJeBKiIjzSsL7I+nUATDZ9E4?=
 =?us-ascii?Q?2Ov4olQv1wGYWIm9jQrdPtynYae+xdax2wH8eOkBdhMKiejXGH0DX1Yz408t?=
 =?us-ascii?Q?pqGZR/vt0eok87BBRnAm4axivilMc6vDyGozeMnOCFTR41ersTq8/AdIyqR9?=
 =?us-ascii?Q?PsSFmXWHp1ZCRFi4NpUJGDKYHG1ZCMlVnpsBaAXWYl6wmniCyxkmJCojkuPy?=
 =?us-ascii?Q?URzxB/SOlxQA6q06Mh5iaR/tzCcFytLCyzl42sf3zChMm15p3TAOA1Qbj8L1?=
 =?us-ascii?Q?CcJfHXk3rJZAUIB0Mi9oOdXbQDCPoSkYkxdZ1d7p8Hoimajk0YCULz+fnx5w?=
 =?us-ascii?Q?lxpWJnr1fk9tFR9YTXCk3l3GTZkS/e4rXOlq1Rp6rGdKTZrpbk4rD2A6IaMP?=
 =?us-ascii?Q?Pig3bpwdIr27A7umlE1A/LGJQfkEOdHOg4l6sYDLuc2XI/bIh9C1fRbAaGK4?=
 =?us-ascii?Q?xRvFZTULUKj8JJiMrFUrxcIHS8JQNLtf8KCXD/6ibxruNe3wnax9bfCQAjjA?=
 =?us-ascii?Q?PTLGbkzs5JQtQfjNC/vDNiXRKLS51OntAKDV2n6TvQj0JcKPq2oId8/7Vsc+?=
 =?us-ascii?Q?99iAtLId3MDsJDmCLNquGTPA1tkBg6c4n/9GwTqPHh5aWd+ItVSlA+p2yGb7?=
 =?us-ascii?Q?T4xEKFOTs4PXndX7ImoySNPiypfQHN+7lWLjD6ptoRcXl8EVomVJlB1IhGu5?=
 =?us-ascii?Q?QbDw0xL9f6YShWLT3z3uck1SYrdTzk1eMYt2NE1myouNs636U7cjmrL95gmX?=
 =?us-ascii?Q?EBJWfLB4wD7YucJ0QnOMx+KsjHOSb0G5SZt3DBZzHUrCi/pvOYA/5lvKS/h1?=
 =?us-ascii?Q?V/V+MADzDgsU4u3dnFa1Hrog7cL/en1Ejx5UTyY83Anv7ual9qtLQ9sjnReH?=
 =?us-ascii?Q?DyaqUyZ55RaA9gf84b6geaMfHp6kCwavYD8qLmmwvds7oO4CHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:52:43.7504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1dac28d-74f7-420d-0b4a-08dc8638526f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

From: Ido Schimmel <idosch@nvidia.com>

The library supports aggregation of objects into other objects only if
the parent object does not have a parent itself. That is, nesting is not
supported.

Aggregation happens in two cases: Without and with hints, where hints
are a pre-computed recommendation on how to aggregate the provided
objects.

Nesting is not possible in the first case due to a check that prevents
it, but in the second case there is no check because the assumption is
that nesting cannot happen when creating objects based on hints. The
violation of this assumption leads to various warnings and eventually to
a general protection fault [1].

Before fixing the root cause, error out when nesting happens and warn.

[1]
general protection fault, probably for non-canonical address 0xdead000000000d90: 0000 [#1] PREEMPT SMP PTI
CPU: 1 PID: 1083 Comm: kworker/1:9 Tainted: G        W          6.9.0-rc6-custom-gd9b4f1cca7fb #7
Hardware name: Mellanox Technologies Ltd. MSN3700/VMOD0005, BIOS 5.11 01/06/2019
Workqueue: mlxsw_core mlxsw_sp_acl_tcam_vregion_rehash_work
RIP: 0010:mlxsw_sp_acl_erp_bf_insert+0x25/0x80
[...]
Call Trace:
 <TASK>
 mlxsw_sp_acl_atcam_entry_add+0x256/0x3c0
 mlxsw_sp_acl_tcam_entry_create+0x5e/0xa0
 mlxsw_sp_acl_tcam_vchunk_migrate_one+0x16b/0x270
 mlxsw_sp_acl_tcam_vregion_rehash_work+0xbe/0x510
 process_one_work+0x151/0x370
 worker_thread+0x2cb/0x3e0
 kthread+0xd0/0x100
 ret_from_fork+0x34/0x50
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Fixes: 9069a3817d82 ("lib: objagg: implement optimization hints assembly and use hints for object creation")
Reported-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 lib/objagg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/objagg.c b/lib/objagg.c
index 955538c90223..0f99ea5f5371 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -167,6 +167,9 @@ static int objagg_obj_parent_assign(struct objagg *objagg,
 {
 	void *delta_priv;
 
+	if (WARN_ON(!objagg_obj_is_root(parent)))
+		return -EINVAL;
+
 	delta_priv = objagg->ops->delta_create(objagg->priv, parent->obj,
 					       objagg_obj->obj);
 	if (IS_ERR(delta_priv))
-- 
2.45.0


