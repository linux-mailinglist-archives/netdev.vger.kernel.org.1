Return-Path: <netdev+bounces-47453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC957EA53B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47DF280F2B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5B43B79A;
	Mon, 13 Nov 2023 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOtN1Ju1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABA225115
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852A4C433CC;
	Mon, 13 Nov 2023 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909718;
	bh=d7TU5tosjVH6LYlNN5NYJ1JYLk8V5kMfJxWX4Fx/nIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JOtN1Ju1IuX1ieM4s2Sv6UpfDn60kx1TLxw2FvhzBAnCHN+2SYLTmMaDHcsyN7Ev0
	 rYga2qBMaPFKmgMe5DO2zjU8xoHi5sUQeuhjV7x4+zP012mHnnoX1wDP3w2fLc3wUD
	 xAgRaC/1M3Z+X73YTy4rA+4pD1doSCNLff8IStEn23CE18gsBGjpbyW8HGyLxH2YqC
	 6XZLgFI0ntnrJwwQZsqAzGy2fosxMVBXin1YcSiWq5PdIVgfsNg+/xkexIWE/JJVNW
	 Va2kzB8BC006IdE5TV//3P+hSbO7FQzr3LEdagJFCokZtS7ApodWBAilbJxMIyvlHm
	 qmDXI1u/t51jQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net 08/17] net/mlx5e: TC, Don't offload post action rule if not supported
Date: Mon, 13 Nov 2023 13:08:17 -0800
Message-ID: <20231113210826.47593-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mi <cmi@nvidia.com>

If post action is not supported, eg. ignore_flow_level is not
supported, don't offload post action rule. Otherwise, will hit
panic [1].

Fix it by checking if post action table is valid or not.

[1]
[445537.863880] BUG: unable to handle page fault for address: ffffffffffffffb1
[445537.864617] #PF: supervisor read access in kernel mode
[445537.865244] #PF: error_code(0x0000) - not-present page
[445537.865860] PGD 70683a067 P4D 70683a067 PUD 70683c067 PMD 0
[445537.866497] Oops: 0000 [#1] PREEMPT SMP NOPTI
[445537.867077] CPU: 19 PID: 248742 Comm: tc Kdump: loaded Tainted: G           O       6.5.0+ #1
[445537.867888] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[445537.868834] RIP: 0010:mlx5e_tc_post_act_add+0x51/0x130 [mlx5_core]
[445537.869635] Code: c0 0d 00 00 e8 20 96 c6 d3 48 85 c0 0f 84 e5 00 00 00 c7 83 b0 01 00 00 00 00 00 00 49 89 c5 31 c0 31 d2 66 89 83 b4 01 00 00 <49> 8b 44 24 10 83 23 df 83 8b d8 01 00 00 04 48 89 83 c0 01 00 00
[445537.871318] RSP: 0018:ffffb98741cef428 EFLAGS: 00010246
[445537.871962] RAX: 0000000000000000 RBX: ffff8df341167000 RCX: 0000000000000001
[445537.872704] RDX: 0000000000000000 RSI: ffffffff954844e1 RDI: ffffffff9546e9cb
[445537.873430] RBP: ffffb98741cef448 R08: 0000000000000020 R09: 0000000000000246
[445537.874160] R10: 0000000000000000 R11: ffffffff943f73ff R12: ffffffffffffffa1
[445537.874893] R13: ffff8df36d336c20 R14: ffffffffffffffa1 R15: ffff8df341167000
[445537.875628] FS:  00007fcd6564f800(0000) GS:ffff8dfa9ea00000(0000) knlGS:0000000000000000
[445537.876425] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[445537.877090] CR2: ffffffffffffffb1 CR3: 00000003b5884001 CR4: 0000000000770ee0
[445537.877832] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[445537.878564] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[445537.879300] PKRU: 55555554
[445537.879797] Call Trace:
[445537.880263]  <TASK>
[445537.880713]  ? show_regs+0x6e/0x80
[445537.881232]  ? __die+0x29/0x70
[445537.881731]  ? page_fault_oops+0x85/0x160
[445537.882276]  ? search_exception_tables+0x65/0x70
[445537.882852]  ? kernelmode_fixup_or_oops+0xa2/0x120
[445537.883432]  ? __bad_area_nosemaphore+0x18b/0x250
[445537.884019]  ? bad_area_nosemaphore+0x16/0x20
[445537.884566]  ? do_kern_addr_fault+0x8b/0xa0
[445537.885105]  ? exc_page_fault+0xf5/0x1c0
[445537.885623]  ? asm_exc_page_fault+0x2b/0x30
[445537.886149]  ? __kmem_cache_alloc_node+0x1df/0x2a0
[445537.886717]  ? mlx5e_tc_post_act_add+0x51/0x130 [mlx5_core]
[445537.887431]  ? mlx5e_tc_post_act_add+0x30/0x130 [mlx5_core]
[445537.888172]  alloc_flow_post_acts+0xfb/0x1c0 [mlx5_core]
[445537.888849]  parse_tc_actions+0x582/0x5c0 [mlx5_core]
[445537.889505]  parse_tc_fdb_actions+0xd7/0x1f0 [mlx5_core]
[445537.890175]  __mlx5e_add_fdb_flow+0x1ab/0x2b0 [mlx5_core]
[445537.890843]  mlx5e_add_fdb_flow+0x56/0x120 [mlx5_core]
[445537.891491]  ? debug_smp_processor_id+0x1b/0x30
[445537.892037]  mlx5e_tc_add_flow+0x79/0x90 [mlx5_core]
[445537.892676]  mlx5e_configure_flower+0x305/0x450 [mlx5_core]
[445537.893341]  mlx5e_rep_setup_tc_cls_flower+0x3d/0x80 [mlx5_core]
[445537.894037]  mlx5e_rep_setup_tc_cb+0x5c/0xa0 [mlx5_core]
[445537.894693]  tc_setup_cb_add+0xdc/0x220
[445537.895177]  fl_hw_replace_filter+0x15f/0x220 [cls_flower]
[445537.895767]  fl_change+0xe87/0x1190 [cls_flower]
[445537.896302]  tc_new_tfilter+0x484/0xa50

Fixes: f0da4daa3413 ("net/mlx5e: Refactor ct to use post action infrastructure")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en/tc/post_act.c       |  6 +++++
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 25 ++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 4e923a2874ae..86bf007fd05b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -83,6 +83,9 @@ mlx5e_tc_post_act_offload(struct mlx5e_post_act *post_act,
 	struct mlx5_flow_spec *spec;
 	int err;
 
+	if (IS_ERR(post_act))
+		return PTR_ERR(post_act);
+
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
@@ -111,6 +114,9 @@ mlx5e_tc_post_act_add(struct mlx5e_post_act *post_act, struct mlx5_flow_attr *po
 	struct mlx5e_post_act_handle *handle;
 	int err;
 
+	if (IS_ERR(post_act))
+		return ERR_CAST(post_act);
+
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 7ca9e5b86778..4809a66f3491 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -444,6 +444,9 @@ mlx5e_tc_add_flow_meter(struct mlx5e_priv *priv,
 	struct mlx5e_flow_meter_handle *meter;
 	enum mlx5e_post_meter_type type;
 
+	if (IS_ERR(post_act))
+		return PTR_ERR(post_act);
+
 	meter = mlx5e_tc_meter_replace(priv->mdev, &attr->meter_attr.params);
 	if (IS_ERR(meter)) {
 		mlx5_core_err(priv->mdev, "Failed to get flow meter\n");
@@ -3738,6 +3741,20 @@ alloc_flow_post_acts(struct mlx5e_tc_flow *flow, struct netlink_ext_ack *extack)
 	return err;
 }
 
+static int
+set_branch_dest_ft(struct mlx5e_priv *priv, struct mlx5_flow_attr *attr)
+{
+	struct mlx5e_post_act *post_act = get_post_action(priv);
+
+	if (IS_ERR(post_act))
+		return PTR_ERR(post_act);
+
+	attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	attr->dest_ft = mlx5e_tc_post_act_get_ft(post_act);
+
+	return 0;
+}
+
 static int
 alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		  struct mlx5e_tc_act_branch_ctrl *cond,
@@ -3761,8 +3778,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		break;
 	case FLOW_ACTION_ACCEPT:
 	case FLOW_ACTION_PIPE:
-		attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-		attr->dest_ft = mlx5e_tc_post_act_get_ft(get_post_action(flow->priv));
+		if (set_branch_dest_ft(flow->priv, attr))
+			goto out_err;
 		break;
 	case FLOW_ACTION_JUMP:
 		if (*jump_count) {
@@ -3771,8 +3788,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 			goto out_err;
 		}
 		*jump_count = cond->extval;
-		attr->action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
-		attr->dest_ft = mlx5e_tc_post_act_get_ft(get_post_action(flow->priv));
+		if (set_branch_dest_ft(flow->priv, attr))
+			goto out_err;
 		break;
 	default:
 		err = -EOPNOTSUPP;
-- 
2.41.0


