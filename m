Return-Path: <netdev+bounces-32112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52815792CB8
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 19:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA681C209CA
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40869DDB2;
	Tue,  5 Sep 2023 17:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7645CA7D
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 17:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B6FC433C8;
	Tue,  5 Sep 2023 17:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693936128;
	bh=kR9BQTLsggdv2cDgnEPwaNqdQIrxJs5taW7mou0zPsE=;
	h=From:To:Cc:Subject:Date:From;
	b=YOU1oNLQlgeBMLjgcTPGDV05EZNEuXGQISq+/OL19+OPluWMv1CWB9YQwR/RD3b2e
	 +7eUSRUw2ciZECm9nO/PUmTWNgIjwQFMPv8e374zFOImoRWZz8ykRO1plUG1AMlexH
	 DFt1+XaxFnEqVGncKVTd/wevpQRn1b6qM9Ygv2hM6KBCEYrK0tZh+DPSFcHpeMQnoX
	 WeqU1j/0wgAP2K9Eq7rPqktTq0oTzlcBqqWOniVv31mDJSKuElSGVRRfGuQJgPOKXt
	 xnR+HHQJbIAiF4F08yIE/jmdxqf+GeVl5V8JGJW+uo9vbRPqayqAblRmp1AIsY5moM
	 TxEMXJaRgeEtQ==
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
Subject: [PATCH net 1/2] net/mlx5e: Clear mirred devices array if the rule is split
Date: Tue,  5 Sep 2023 10:48:45 -0700
Message-ID: <20230905174846.24124-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, the mirred devices are recorded and checked while
parsing the actions. In order to avoid system crash, the duplicate
action in a single rule is not allowed.

But the rule is actually break down into several FTEs in different
tables, for either mirroring, or the specified types of actions which
use post action infrastructure.

It will reject certain action list by mistake, for example:
    actions:enp8s0f0_1,set(ipv4(ttl=63)),enp8s0f0_0,enp8s0f0_1.
Here the rule is split to two FTEs because of pedit action.

To fix this issue, when parsing the rule actions, reset if_count to
clear the mirred devices array if the rule is split to multiple
FTEs, and then the duplicate checking is restarted.

Fixes: 554fe75c1b3f ("net/mlx5e: Avoid duplicating rule destinations")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c        | 4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c    | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c     | 4 +++-
 .../ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c  | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c      | 1 +
 .../net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c   | 4 +++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c               | 1 +
 7 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
index 92d3952dfa8b..feeb41693c17 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/ct.c
@@ -17,8 +17,10 @@ tc_act_parse_ct(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
-	if (mlx5e_is_eswitch_flow(parse_state->flow))
+	if (mlx5e_is_eswitch_flow(parse_state->flow)) {
 		attr->esw_attr->split_count = attr->esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	attr->flags |= MLX5_ATTR_FLAG_CT;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
index 291193f7120d..f63402c48028 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/mirred.c
@@ -294,6 +294,7 @@ parse_mirred_ovs_master(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
+	parse_state->if_count = 0;
 	esw_attr->out_count++;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
index 3b272bbf4c53..368a95fa77d3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
@@ -98,8 +98,10 @@ tc_act_parse_pedit(struct mlx5e_tc_act_parse_state *parse_state,
 
 	attr->action |= MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
 
-	if (ns_type == MLX5_FLOW_NAMESPACE_FDB)
+	if (ns_type == MLX5_FLOW_NAMESPACE_FDB) {
 		esw_attr->split_count = esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
index ad09a8a5f36e..2d1d4a04501b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/redirect_ingress.c
@@ -66,6 +66,7 @@ tc_act_parse_redirect_ingress(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
+	parse_state->if_count = 0;
 	esw_attr->out_count++;
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
index c8a3eaf189f6..a13c5e707b83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan.c
@@ -166,6 +166,7 @@ tc_act_parse_vlan(struct mlx5e_tc_act_parse_state *parse_state,
 		return err;
 
 	esw_attr->split_count = esw_attr->out_count;
+	parse_state->if_count = 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
index 310b99230760..f17575b09788 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/vlan_mangle.c
@@ -65,8 +65,10 @@ tc_act_parse_vlan_mangle(struct mlx5e_tc_act_parse_state *parse_state,
 	if (err)
 		return err;
 
-	if (ns_type == MLX5_FLOW_NAMESPACE_FDB)
+	if (ns_type == MLX5_FLOW_NAMESPACE_FDB) {
 		attr->esw_attr->split_count = attr->esw_attr->out_count;
+		parse_state->if_count = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 318083690fcd..c24828b688ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3936,6 +3936,7 @@ parse_tc_actions(struct mlx5e_tc_act_parse_state *parse_state,
 			}
 
 			i_split = i + 1;
+			parse_state->if_count = 0;
 			list_add(&attr->list, &flow->attrs);
 		}
 
-- 
2.41.0


