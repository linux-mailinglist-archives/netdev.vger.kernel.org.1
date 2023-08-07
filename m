Return-Path: <netdev+bounces-25154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9010773130
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA031C20C1B
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38CD17746;
	Mon,  7 Aug 2023 21:26:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593117732
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B95C43391;
	Mon,  7 Aug 2023 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443576;
	bh=OnnVySlDz0XPSv9ZpvuFJ93WS2avdwrFg2/4BmHltdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ga3DmROevHo5DuYw+2VD3WWK/UktSZSs0hr//G6y5BPEGvZX0L+1vEdSFoRcrTOxL
	 YAZCh1GdhK2GXrZaqm7SnNFNi3AzpRNz1xkOvQD52n1NAN6l5QRlm59J8212IxLjoC
	 LLyf6jHfQ2JvpKy4gCX3DUmcIcRHlPOv1or7lzatFjye37As1l7EkPsPQD6Jf7LVrE
	 SDjxU77JrSP81/HbkgcQ3a2nud1kjLmN4r+oJ9AzLPKVZn+wLCMVbY00Ta3xSUEmHH
	 8ofZZhQcOxz2xMr6xrHq0wajLTwimiDihncEh9uPvoEQFVtuYfjgt1p7BMUKxOjPCV
	 cPDDB2tKaQjBw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net 02/11] net/mlx5e: TC, Fix internal port memory leak
Date: Mon,  7 Aug 2023 14:25:58 -0700
Message-ID: <20230807212607.50883-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The flow rule can be splited, and the extra post_act rules are added
to post_act table. It's possible to trigger memleak when the rule
forwards packets from internal port and over tunnel, in the case that,
for example, CT 'new' state offload is allowed. As int_port object is
assigned to the flow attribute of post_act rule, and its refcnt is
incremented by mlx5e_tc_int_port_get(), but mlx5e_tc_int_port_put() is
not called, the refcnt is never decremented, then int_port is never
freed.

The kmemleak reports the following error:
unreferenced object 0xffff888128204b80 (size 64):
  comm "handler20", pid 50121, jiffies 4296973009 (age 642.932s)
  hex dump (first 32 bytes):
    01 00 00 00 19 00 00 00 03 f0 00 00 04 00 00 00  ................
    98 77 67 41 81 88 ff ff 98 77 67 41 81 88 ff ff  .wgA.....wgA....
  backtrace:
    [<00000000e992680d>] kmalloc_trace+0x27/0x120
    [<000000009e945a98>] mlx5e_tc_int_port_get+0x3f3/0xe20 [mlx5_core]
    [<0000000035a537f0>] mlx5e_tc_add_fdb_flow+0x473/0xcf0 [mlx5_core]
    [<0000000070c2cec6>] __mlx5e_add_fdb_flow+0x7cf/0xe90 [mlx5_core]
    [<000000005cc84048>] mlx5e_configure_flower+0xd40/0x4c40 [mlx5_core]
    [<000000004f8a2031>] mlx5e_rep_indr_offload.isra.0+0x10e/0x1c0 [mlx5_core]
    [<000000007df797dc>] mlx5e_rep_indr_setup_tc_cb+0x90/0x130 [mlx5_core]
    [<0000000016c15cc3>] tc_setup_cb_add+0x1cf/0x410
    [<00000000a63305b4>] fl_hw_replace_filter+0x38f/0x670 [cls_flower]
    [<000000008bc9e77c>] fl_change+0x1fd5/0x4430 [cls_flower]
    [<00000000e7f766e4>] tc_new_tfilter+0x867/0x2010
    [<00000000e101c0ef>] rtnetlink_rcv_msg+0x6fc/0x9f0
    [<00000000e1111d44>] netlink_rcv_skb+0x12c/0x360
    [<0000000082dd6c8b>] netlink_unicast+0x438/0x710
    [<00000000fc568f70>] netlink_sendmsg+0x794/0xc50
    [<0000000016e92590>] sock_sendmsg+0xc5/0x190

So fix this by moving int_port cleanup code to the flow attribute
free helper, which is used by all the attribute free cases.

Fixes: 8300f225268b ("net/mlx5e: Create new flow attr for multi table actions")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 92377632f9e0..31708d5aa608 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1943,9 +1943,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 {
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5_flow_attr *attr = flow->attr;
-	struct mlx5_esw_flow_attr *esw_attr;
 
-	esw_attr = attr->esw_attr;
 	mlx5e_put_flow_tunnel_id(flow);
 
 	remove_unready_flow(flow);
@@ -1966,12 +1964,6 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 
 	mlx5_tc_ct_match_del(get_ct_priv(priv), &flow->attr->ct_attr);
 
-	if (esw_attr->int_port)
-		mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(priv), esw_attr->int_port);
-
-	if (esw_attr->dest_int_port)
-		mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(priv), esw_attr->dest_int_port);
-
 	if (flow_flag_test(flow, L3_TO_L2_DECAP))
 		mlx5e_detach_decap(priv, flow);
 
@@ -4268,6 +4260,7 @@ static void
 mlx5_free_flow_attr_actions(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *attr)
 {
 	struct mlx5_core_dev *counter_dev = get_flow_counter_dev(flow);
+	struct mlx5_esw_flow_attr *esw_attr;
 
 	if (!attr)
 		return;
@@ -4285,6 +4278,18 @@ mlx5_free_flow_attr_actions(struct mlx5e_tc_flow *flow, struct mlx5_flow_attr *a
 		mlx5e_tc_detach_mod_hdr(flow->priv, flow, attr);
 	}
 
+	if (mlx5e_is_eswitch_flow(flow)) {
+		esw_attr = attr->esw_attr;
+
+		if (esw_attr->int_port)
+			mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(flow->priv),
+					      esw_attr->int_port);
+
+		if (esw_attr->dest_int_port)
+			mlx5e_tc_int_port_put(mlx5e_get_int_port_priv(flow->priv),
+					      esw_attr->dest_int_port);
+	}
+
 	mlx5_tc_ct_delete_flow(get_ct_priv(flow->priv), attr);
 
 	free_branch_attr(flow, attr->branch_true);
-- 
2.41.0


