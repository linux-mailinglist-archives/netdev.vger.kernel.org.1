Return-Path: <netdev+bounces-64673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90060836479
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 14:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E42B24164
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D83CF63;
	Mon, 22 Jan 2024 13:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mVrWdCLs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4D3D542
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930183; cv=fail; b=towscfE0GGn/vozSxJSsthuYlTRBoVF+BxS8qwLZXfpICGS63RF/nlJ90Vm2nw6+CyBgshD/b6gGw6q2w6WbxSlsysVu+g0lYk8idtXZQKSSboqL/E1bw1OEJ1pAESu4Mgdebzh2wQ2lGQaQYBJAeWIh5btWzeulq1dyfZ/uPew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930183; c=relaxed/simple;
	bh=snqRu+5EjOdEPnQ2spa7aCTykhv7qWKEZSK33a2K03I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcadh+i1IkPBBhYxP4rYShxKikjLl5XlVyH+mdAbDP6kJ4aE7p1kpe1i37mZPEks2tgJQwzEBMn9yhL3mfd2wIPxKJK2DR4BLh3l+3OvlwY/jxwCXofyG4ymoF3PlIkjN+GArZ8hbe6mfR29neY9rB+TS3m4+k3G082JG8ilDXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mVrWdCLs; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu3ZqlHpuKR+10Atao6G2aNEh22nBRpzndpm5uR5dTYtBNU+ZnRV7M4ZOddk4X1T3RmFErGhCMoOdeaubGQ0VY6A6UsMC6ACkYJfT1DeAMVhrf32cCOIPKmY+RHS0axiDcWwbktoeIooZJETLmX1ksE467FYbT9q/ojdoEZKhhhxHbOQuwKk8ujZBHpNtaZ9SI5Pwvx7/Ucz8/x/B3rk5Oy7H7mHTeJHWPJTKVr269sx5HNGQI/LAFvN44y5ph2+5W2jVmEUGDWpn0hto9ETSZ7BuiPsTwEelG6hPiJzOW8/luvjSzTJhGxsCp2wekXWLmgdnkaBlDYUa0i5xtjtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIW6PvRNO+0tM5JlGl+eBNsKztkIVZ0yhoJoCgWF7/4=;
 b=Z7+ANmGPKplf4766v3m+zAdwEygX+qJ1wnVH4qFv8GQNTQhuBdr8DNtDqENKBoha4Aj8Nng8ledQs9RgiJV7TQKX1PllYh8EEtCszc+RWvzL38ZVAtu+sS5CESc1+ojKuRyVDTPog2dtXL7W36ZdBowLykbows2zlg3wVEy2OT+YoWg93nXbV2XfPXbbQIH+mFiNsodqappOVXSVZMp1yqC+Ia/YqTjfEm+WgZTULAxEbwNAaeJtz4y0wundy/dLPpFPBKHSbZYfBDZWXQq4neo+8r/2eQt+qLMOcxh40c+GrdHsagj6KtSAtXzMksl6Nj0lUbVCTpkIAnk9G7AFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIW6PvRNO+0tM5JlGl+eBNsKztkIVZ0yhoJoCgWF7/4=;
 b=mVrWdCLsiv3/uhoajkcIU+J0P3dITW6xz7plKXgkgs6GvQAqSlKerO4lU9NOOfXpEm0/aD9a87krOJOP84YSrX+cSWvYm/lKn0h9vAE3E9SHVeRb/suceZUC9m3CeSy9n4hKfkbZoMUXXyX5m5QbyqjCL0sBgo1iPALzae2FxsNOlRxahK8wmQoobimFE39opN3CzX01Imn8USH5VrOZdXkn/mehypbbqfwpYffJLDOMA/21dmWCiRlzkTpZnvHIg917nP/AZIXUihHCPk5IE1EonBEhWrYshAUHMmNLqr8olEmeSGyBLay6F+1zejgIgj/LDhZvRTq2cyuAHViWnw==
Received: from BL0PR02CA0025.namprd02.prod.outlook.com (2603:10b6:207:3c::38)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 13:29:37 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:207:3c:cafe::16) by BL0PR02CA0025.outlook.office365.com
 (2603:10b6:207:3c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 13:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 13:29:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 05:29:19 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 05:29:16 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>,
	<jiri@resnulli.us>, <vladbu@mellanox.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] net/sched: flower: Fix chain template offload
Date: Mon, 22 Jan 2024 15:28:43 +0200
Message-ID: <20240122132843.400854-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 641f7d7a-be03-4e23-e03a-08dc1b4e2dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HYfSuXGdZ4Y3Gtx8sjX3lrBXRtHqKLJX706olVOWXeJnmKwUq9E2NuOrF4wravY2PgpRvfdWQ858RhXccxvtGo6uJO8oNjSiv4FW1ls9ktPhry4EpK+JWprvhlC+EYJdHKnjkEXFkdaiK3eHGbolZA+0PODjNTIKgdceqj45FOQcICxfWfAD75tFbArH+zjO/HxFY3J6K1xm447nV0XZfcL0yXWVTMq/M9JqbaLeu3XkzMs/JH7unPV1vzYQrUYfjdnzTJf2CgYANm5OavPPWFnf+hxjLDhnufWw/TBZhcms97A8lVmUX9Atf3fMsqQ0Kc4AbcUtUxl2yiC+zpd2epFdXCMiz9zeZMULjzix9bCvpe4DbXdBArQ7DtumxnXJlPVUAC2AwQVs4OZX7nrTMMdxct91ZeMZVWqrCVw7qlBIOotHRw9w6EFbhX8bRnZZqOsEhqDjLLZV4AW9rDI0voe56wN/fpxXCGKXtqVGeDnpTfH5Fj+talzd7Uu8g3V4BNzq01ODorHAV0x87HcbE4zY50I37bg2mVvLGfyBT+IUtcYCdCrOxG0XYhPNy8uFn738FZAt7b3WozRtapfwrlwOOWQpUAqAQ/MKk1kT9Cj8aw9syoLlbcTvT7Oous2JnTrcJYANdI40KEyPxXsPWJCfrbqMJeUkRlkU+qmTSIinDjEY21+ghUe3eej3iOq4qspjIzMxZINCZfBw5JwjW6RQByD6uZu0dLQDQH2MylMuQyYvFbNwfMvhGbmcbAa3
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(336012)(426003)(1076003)(26005)(2616005)(107886003)(16526019)(36756003)(86362001)(82740400003)(7636003)(356005)(41300700001)(83380400001)(36860700001)(5660300002)(2906002)(47076005)(8936002)(8676002)(4326008)(478600001)(70206006)(70586007)(6916009)(316002)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 13:29:36.6725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641f7d7a-be03-4e23-e03a-08dc1b4e2dc2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

When a qdisc is deleted from a net device the stack instructs the
underlying driver to remove its flow offload callback from the
associated filter block using the 'FLOW_BLOCK_UNBIND' command. The stack
then continues to replay the removal of the filters in the block for
this driver by iterating over the chains in the block and invoking the
'reoffload' operation of the classifier being used. In turn, the
classifier in its 'reoffload' operation prepares and emits a
'FLOW_CLS_DESTROY' command for each filter.

However, the stack does not do the same for chain templates and the
underlying driver never receives a 'FLOW_CLS_TMPLT_DESTROY' command when
a qdisc is deleted. This results in a memory leak [1] which can be
reproduced using [2].

Fix by introducing a 'tmplt_reoffload' operation and have the stack
invoke it with the appropriate arguments as part of the replay.
Implement the operation in the sole classifier that supports chain
templates (flower) by emitting the 'FLOW_CLS_TMPLT_{CREATE,DESTROY}'
command based on whether a flow offload callback is being bound to a
filter block or being unbound from one.

As far as I can tell, the issue happens since cited commit which
reordered tcf_block_offload_unbind() before tcf_block_flush_all_chains()
in __tcf_block_put(). The order cannot be reversed as the filter block
is expected to be freed after flushing all the chains.

[1]
unreferenced object 0xffff888107e28800 (size 2048):
  comm "tc", pid 1079, jiffies 4294958525 (age 3074.287s)
  hex dump (first 32 bytes):
    b1 a6 7c 11 81 88 ff ff e0 5b b3 10 81 88 ff ff  ..|......[......
    01 00 00 00 00 00 00 00 e0 aa b0 84 ff ff ff ff  ................
  backtrace:
    [<ffffffff81c06a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff81ab374e>] __kmalloc+0x4e/0x90
    [<ffffffff832aec6d>] mlxsw_sp_acl_ruleset_get+0x34d/0x7a0
    [<ffffffff832bc195>] mlxsw_sp_flower_tmplt_create+0x145/0x180
    [<ffffffff832b2e1a>] mlxsw_sp_flow_block_cb+0x1ea/0x280
    [<ffffffff83a10613>] tc_setup_cb_call+0x183/0x340
    [<ffffffff83a9f85a>] fl_tmplt_create+0x3da/0x4c0
    [<ffffffff83a22435>] tc_ctl_chain+0xa15/0x1170
    [<ffffffff838a863c>] rtnetlink_rcv_msg+0x3cc/0xed0
    [<ffffffff83ac87f0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83ac6270>] netlink_unicast+0x540/0x820
    [<ffffffff83ac6e28>] netlink_sendmsg+0x8d8/0xda0
    [<ffffffff83793def>] ____sys_sendmsg+0x30f/0xa80
    [<ffffffff8379d29a>] ___sys_sendmsg+0x13a/0x1e0
    [<ffffffff8379d50c>] __sys_sendmsg+0x11c/0x1f0
    [<ffffffff843b9ce0>] do_syscall_64+0x40/0xe0
unreferenced object 0xffff88816d2c0400 (size 1024):
  comm "tc", pid 1079, jiffies 4294958525 (age 3074.287s)
  hex dump (first 32 bytes):
    40 00 00 00 00 00 00 00 57 f6 38 be 00 00 00 00  @.......W.8.....
    10 04 2c 6d 81 88 ff ff 10 04 2c 6d 81 88 ff ff  ..,m......,m....
  backtrace:
    [<ffffffff81c06a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff81ab36c1>] __kmalloc_node+0x51/0x90
    [<ffffffff81a8ed96>] kvmalloc_node+0xa6/0x1f0
    [<ffffffff82827d03>] bucket_table_alloc.isra.0+0x83/0x460
    [<ffffffff82828d2b>] rhashtable_init+0x43b/0x7c0
    [<ffffffff832aed48>] mlxsw_sp_acl_ruleset_get+0x428/0x7a0
    [<ffffffff832bc195>] mlxsw_sp_flower_tmplt_create+0x145/0x180
    [<ffffffff832b2e1a>] mlxsw_sp_flow_block_cb+0x1ea/0x280
    [<ffffffff83a10613>] tc_setup_cb_call+0x183/0x340
    [<ffffffff83a9f85a>] fl_tmplt_create+0x3da/0x4c0
    [<ffffffff83a22435>] tc_ctl_chain+0xa15/0x1170
    [<ffffffff838a863c>] rtnetlink_rcv_msg+0x3cc/0xed0
    [<ffffffff83ac87f0>] netlink_rcv_skb+0x170/0x440
    [<ffffffff83ac6270>] netlink_unicast+0x540/0x820
    [<ffffffff83ac6e28>] netlink_sendmsg+0x8d8/0xda0
    [<ffffffff83793def>] ____sys_sendmsg+0x30f/0xa80

[2]
 # tc qdisc add dev swp1 clsact
 # tc chain add dev swp1 ingress proto ip chain 1 flower dst_ip 0.0.0.0/32
 # tc qdisc del dev swp1 clsact
 # devlink dev reload pci/0000:06:00.0

Fixes: bbf73830cd48 ("net: sched: traverse chains in block with tcf_get_next_chain()")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/sch_generic.h |  4 ++++
 net/sched/cls_api.c       |  9 ++++++++-
 net/sched/cls_flower.c    | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index ba3e1b315de8..934fdb977551 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -375,6 +375,10 @@ struct tcf_proto_ops {
 						struct nlattr **tca,
 						struct netlink_ext_ack *extack);
 	void			(*tmplt_destroy)(void *tmplt_priv);
+	void			(*tmplt_reoffload)(struct tcf_chain *chain,
+						   bool add,
+						   flow_setup_cb_t *cb,
+						   void *cb_priv);
 	struct tcf_exts *	(*get_exts)(const struct tcf_proto *tp,
 					    u32 handle);
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 92a12e3d0fe6..ff3d396a65aa 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1560,6 +1560,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 	     chain_prev = chain,
 		     chain = __tcf_get_next_chain(block, chain),
 		     tcf_chain_put(chain_prev)) {
+		if (chain->tmplt_ops && add)
+			chain->tmplt_ops->tmplt_reoffload(chain, true, cb,
+							  cb_priv);
 		for (tp = __tcf_get_next_proto(chain, NULL); tp;
 		     tp_prev = tp,
 			     tp = __tcf_get_next_proto(chain, tp),
@@ -1575,6 +1578,9 @@ tcf_block_playback_offloads(struct tcf_block *block, flow_setup_cb_t *cb,
 				goto err_playback_remove;
 			}
 		}
+		if (chain->tmplt_ops && !add)
+			chain->tmplt_ops->tmplt_reoffload(chain, false, cb,
+							  cb_priv);
 	}
 
 	return 0;
@@ -3000,7 +3006,8 @@ static int tc_chain_tmplt_add(struct tcf_chain *chain, struct net *net,
 	ops = tcf_proto_lookup_ops(name, true, extack);
 	if (IS_ERR(ops))
 		return PTR_ERR(ops);
-	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump) {
+	if (!ops->tmplt_create || !ops->tmplt_destroy || !ops->tmplt_dump ||
+	    !ops->tmplt_reoffload) {
 		NL_SET_ERR_MSG(extack, "Chain templates are not supported with specified classifier");
 		module_put(ops->owner);
 		return -EOPNOTSUPP;
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e5314a31f75a..efb9d2811b73 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2721,6 +2721,28 @@ static void fl_tmplt_destroy(void *tmplt_priv)
 	kfree(tmplt);
 }
 
+static void fl_tmplt_reoffload(struct tcf_chain *chain, bool add,
+			       flow_setup_cb_t *cb, void *cb_priv)
+{
+	struct fl_flow_tmplt *tmplt = chain->tmplt_priv;
+	struct flow_cls_offload cls_flower = {};
+
+	cls_flower.rule = flow_rule_alloc(0);
+	if (!cls_flower.rule)
+		return;
+
+	cls_flower.common.chain_index = chain->index;
+	cls_flower.command = add ? FLOW_CLS_TMPLT_CREATE :
+				   FLOW_CLS_TMPLT_DESTROY;
+	cls_flower.cookie = (unsigned long) tmplt;
+	cls_flower.rule->match.dissector = &tmplt->dissector;
+	cls_flower.rule->match.mask = &tmplt->mask;
+	cls_flower.rule->match.key = &tmplt->dummy_key;
+
+	cb(TC_SETUP_CLSFLOWER, &cls_flower, cb_priv);
+	kfree(cls_flower.rule);
+}
+
 static int fl_dump_key_val(struct sk_buff *skb,
 			   void *val, int val_type,
 			   void *mask, int mask_type, int len)
@@ -3628,6 +3650,7 @@ static struct tcf_proto_ops cls_fl_ops __read_mostly = {
 	.bind_class	= fl_bind_class,
 	.tmplt_create	= fl_tmplt_create,
 	.tmplt_destroy	= fl_tmplt_destroy,
+	.tmplt_reoffload = fl_tmplt_reoffload,
 	.tmplt_dump	= fl_tmplt_dump,
 	.get_exts	= fl_get_exts,
 	.owner		= THIS_MODULE,
-- 
2.40.1


