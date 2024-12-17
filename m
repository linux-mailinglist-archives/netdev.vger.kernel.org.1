Return-Path: <netdev+bounces-152499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950E79F44E3
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A5D188C66D
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 07:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D11189B83;
	Tue, 17 Dec 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="auImnbBl"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0E14D708;
	Tue, 17 Dec 2024 07:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419750; cv=none; b=DXjjl7u9AmWJKNQWVObA/i/u9Po2rwhoaemt6u4SedDgJniwZ/uyHWCTAo1WjH39cLIr351aKZ7vzHzHK0Tqemb2epMlfZzdz/KxSjgcMX9h150Z58ZBIWbfwtdwu+/oiubOXP/g9ELc1mWmpytgimL5rCyDznhW0QR3I/PRTGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419750; c=relaxed/simple;
	bh=kTVdy9ReBo/7XNpMXr4kBtyMaQ2uih8+hawSlKQJfEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rkB7K8jgfESusZssrU7Y0hJHuiYZSpyVBkZKDvCqDZ0Iq8B+QdIWFEVaNtMwfHP28EwKS+2uW0UOEScZ1YufEpf9aoWfHcgzQoo3xcl+P5Q9HOOghDPcw3ZbqtQT8tE1CJb6bkxCuxRWDSxe45miilq00p0Uc71dNmeepVBprUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=auImnbBl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4KntO
	sxXMjWsr/ncZlDW+jwQAg/0we4qvxhbj2LOY/s=; b=auImnbBlGzonWEv0Jc1Dq
	4BU8r/FrxP5kH1Hh6Og5s906Yq6/au0lq5VuuTp8o7LzC93ILEa8N7JAAJwqYpaE
	7QweyL1+Js/XkcmOHO6LlmQmBWOHLRInbqnS5kfu04wP/lVbJmolPGyIyb2q8Q0d
	KNsxmxhvvP9mUF5q7Pkeig=
Received: from hello.company.local (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3+efXJGFn1DYTBA--.20433S2;
	Tue, 17 Dec 2024 15:14:31 +0800 (CST)
From: Liang Jie <buaajxlj@163.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liang Jie <liangjie@lixiang.com>
Subject: [PATCH] net: Refine key_len calculations in rhashtable_params
Date: Tue, 17 Dec 2024 15:14:11 +0800
Message-Id: <20241217071411.3863379-1-buaajxlj@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3+efXJGFn1DYTBA--.20433S2
X-Coremail-Antispam: 1Uf129KBjvAXoWDCw4UJw17ZF1rWr1kKry8Xwb_yoWrAry3Ko
	Z3JFs0yw18Cr18X3ykGFykWF93XanrK393Jw4agws5uwnI9w1UGF13tw45Aayqqr1xGF4U
	uw1UXas8ZFW2qr1Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU52-eDUUUU
X-CM-SenderInfo: pexdtyx0omqiywtou0bp/xtbBZwS4IGdhI6se2QAAsy

From: Liang Jie <liangjie@lixiang.com>

This patch improves the calculation of key_len in the rhashtable_params
structures across the net driver modules by replacing hardcoded sizes
and previous calculations with appropriate macros like sizeof_field()
and offsetofend().

Previously, key_len was set using hardcoded sizes like sizeof(u32) or
sizeof(unsigned long), or using offsetof() calculations. This patch
replaces these with sizeof_field() and correct use of offsetofend(),
making the code more robust, maintainable, and improving readability.

Using sizeof_field() and offsetofend() provides several advantages:
- They explicitly specify the size of the field or the end offset of a
  member being used as a key.
- They ensure that the key_len is accurate even if the structs change in
  the future.
- They improve code readability by clearly indicating which fields are used
  and how their sizes are determined, making the code easier to understand
  and maintain.

For example, instead of:
    .key_len    = sizeof(u32),
we now use:
    .key_len    = sizeof_field(struct mae_mport_desc, mport_id),

And instead of:
    .key_len    = offsetof(struct efx_tc_encap_match, linkage),
we now use:
    .key_len    = offsetofend(struct efx_tc_encap_match, ip_tos_mask),

These changes eliminate the risk of including unintended padding or extra
data in the key, ensuring the rhashtable functions correctly.

Signed-off-by: Liang Jie <liangjie@lixiang.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c         |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.h         |  1 -
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c      |  2 +-
 drivers/net/ethernet/marvell/prestera/prestera_acl.c |  6 +++---
 .../net/ethernet/marvell/prestera/prestera_router.c  |  4 ++--
 .../ethernet/marvell/prestera/prestera_router_hw.c   |  6 +++---
 drivers/net/ethernet/mediatek/mtk_ppe_offload.c      |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/rep/neigh.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c   |  8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c      |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c |  2 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge_mcast.c   |  2 +-
 .../ethernet/mellanox/mlxsw/core_acl_flex_actions.c  |  6 +++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c       |  4 ++--
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c   |  4 ++--
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c |  4 ++--
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c  |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c    |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c   |  4 ++--
 .../net/ethernet/mellanox/mlxsw/spectrum_router.c    |  8 ++++----
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |  2 +-
 drivers/net/ethernet/netronome/nfp/bpf/main.c        |  2 +-
 .../net/ethernet/netronome/nfp/flower/conntrack.c    |  4 ++--
 drivers/net/ethernet/netronome/nfp/flower/metadata.c | 10 +++++-----
 drivers/net/ethernet/netronome/nfp/flower/qos_conf.c |  2 +-
 .../net/ethernet/netronome/nfp/flower/tunnel_conf.c  |  2 +-
 drivers/net/ethernet/sfc/mae.c                       |  2 +-
 drivers/net/ethernet/sfc/tc.c                        | 12 ++++++------
 drivers/net/ethernet/sfc/tc_conntrack.c              |  8 ++++----
 drivers/net/ethernet/sfc/tc_counters.c               |  8 ++++----
 drivers/net/ethernet/sfc/tc_encap_actions.c          |  2 +-
 drivers/net/netdevsim/fib.c                          |  4 ++--
 drivers/net/vxlan/vxlan_mdb.c                        |  2 +-
 drivers/net/vxlan/vxlan_vnifilter.c                  |  2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c        |  2 +-
 36 files changed, 72 insertions(+), 73 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index d2ca90407cce..7aff67fad4a9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -1982,28 +1982,28 @@ static int bnxt_tc_setup_indr_cb(struct net_device *netdev, struct Qdisc *sch, v
 static const struct rhashtable_params bnxt_tc_flow_ht_params = {
 	.head_offset = offsetof(struct bnxt_tc_flow_node, node),
 	.key_offset = offsetof(struct bnxt_tc_flow_node, cookie),
-	.key_len = sizeof(((struct bnxt_tc_flow_node *)0)->cookie),
+	.key_len = sizeof_field(struct bnxt_tc_flow_node, cookie),
 	.automatic_shrinking = true
 };
 
 static const struct rhashtable_params bnxt_tc_l2_ht_params = {
 	.head_offset = offsetof(struct bnxt_tc_l2_node, node),
 	.key_offset = offsetof(struct bnxt_tc_l2_node, key),
-	.key_len = BNXT_TC_L2_KEY_LEN,
+	.key_len = offsetofend(struct bnxt_tc_l2_key, inner_vlan_tci),
 	.automatic_shrinking = true
 };
 
 static const struct rhashtable_params bnxt_tc_decap_l2_ht_params = {
 	.head_offset = offsetof(struct bnxt_tc_l2_node, node),
 	.key_offset = offsetof(struct bnxt_tc_l2_node, key),
-	.key_len = BNXT_TC_L2_KEY_LEN,
+	.key_len = offsetofend(struct bnxt_tc_l2_key, inner_vlan_tci),
 	.automatic_shrinking = true
 };
 
 static const struct rhashtable_params bnxt_tc_tunnel_ht_params = {
 	.head_offset = offsetof(struct bnxt_tc_tunnel_node, node),
 	.key_offset = offsetof(struct bnxt_tc_tunnel_node, key),
-	.key_len = sizeof(struct ip_tunnel_key),
+	.key_len = sizeof_field(struct bnxt_tc_tunnel_node, key),
 	.automatic_shrinking = true
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.h
index 10c62b094914..9a48f6bc25ed 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.h
@@ -173,7 +173,6 @@ struct bnxt_tc_tunnel_node {
  */
 struct bnxt_tc_l2_node {
 	/* hash key: first 16b of key */
-#define BNXT_TC_L2_KEY_LEN			16
 	struct bnxt_tc_l2_key	key;
 	struct rhash_head	node;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index 69d045d769c4..ac5b209e46e7 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -1103,7 +1103,7 @@ static const struct rhashtable_params cxgb4_tc_flower_ht_params = {
 	.nelem_hint = 384,
 	.head_offset = offsetof(struct ch_tc_flower_entry, node),
 	.key_offset = offsetof(struct ch_tc_flower_entry, tc_flower_cookie),
-	.key_len = sizeof(((struct ch_tc_flower_entry *)0)->tc_flower_cookie),
+	.key_len = sizeof_field(struct ch_tc_flower_entry, tc_flower_cookie),
 	.max_size = 524288,
 	.min_size = 512,
 	.automatic_shrinking = true
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index cccb7ddf61c9..b06e188985ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -13,7 +13,7 @@
 
 static const struct rhashtable_params ice_fdb_ht_params = {
 	.key_offset = offsetof(struct ice_esw_br_fdb_entry, data),
-	.key_len = sizeof(struct ice_esw_br_fdb_data),
+	.key_len = sizeof_field(struct ice_esw_br_fdb_entry, data),
 	.head_offset = offsetof(struct ice_esw_br_fdb_entry, ht_node),
 	.automatic_shrinking = true,
 };
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_acl.c b/drivers/net/ethernet/marvell/prestera/prestera_acl.c
index cba89fda504b..312a725c10f7 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_acl.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_acl.c
@@ -79,14 +79,14 @@ struct prestera_acl_vtcam {
 };
 
 static const struct rhashtable_params prestera_acl_ruleset_ht_params = {
-	.key_len = sizeof(struct prestera_acl_ruleset_ht_key),
+	.key_len = sizeof_field(struct prestera_acl_ruleset, ht_key),
 	.key_offset = offsetof(struct prestera_acl_ruleset, ht_key),
 	.head_offset = offsetof(struct prestera_acl_ruleset, ht_node),
 	.automatic_shrinking = true,
 };
 
 static const struct rhashtable_params prestera_acl_rule_ht_params = {
-	.key_len = sizeof(unsigned long),
+	.key_len = sizeof_field(struct prestera_acl_rule, cookie),
 	.key_offset = offsetof(struct prestera_acl_rule, cookie),
 	.head_offset = offsetof(struct prestera_acl_rule, ht_node),
 	.automatic_shrinking = true,
@@ -95,7 +95,7 @@ static const struct rhashtable_params prestera_acl_rule_ht_params = {
 static const struct rhashtable_params __prestera_acl_rule_entry_ht_params = {
 	.key_offset  = offsetof(struct prestera_acl_rule_entry, key),
 	.head_offset = offsetof(struct prestera_acl_rule_entry, ht_node),
-	.key_len     = sizeof(struct prestera_acl_rule_entry_key),
+	.key_len     = sizeof_field(struct prestera_acl_rule_entry, key),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/drivers/net/ethernet/marvell/prestera/prestera_router.c
index de317179a7dc..dcde1fbd6da1 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
@@ -67,14 +67,14 @@ struct prestera_kern_fib_cache {
 static const struct rhashtable_params __prestera_kern_neigh_cache_ht_params = {
 	.key_offset  = offsetof(struct prestera_kern_neigh_cache, key),
 	.head_offset = offsetof(struct prestera_kern_neigh_cache, ht_node),
-	.key_len     = sizeof(struct prestera_kern_neigh_cache_key),
+	.key_len     = sizeof_field(struct prestera_kern_neigh_cache, key),
 	.automatic_shrinking = true,
 };
 
 static const struct rhashtable_params __prestera_kern_fib_cache_ht_params = {
 	.key_offset  = offsetof(struct prestera_kern_fib_cache, key),
 	.head_offset = offsetof(struct prestera_kern_fib_cache, ht_node),
-	.key_len     = sizeof(struct prestera_kern_fib_cache_key),
+	.key_len     = sizeof_field(struct prestera_kern_fib_cache, key),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
index 02faaea2aefa..9830b5512056 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_router_hw.c
@@ -35,19 +35,19 @@
 static const struct rhashtable_params __prestera_fib_ht_params = {
 	.key_offset  = offsetof(struct prestera_fib_node, key),
 	.head_offset = offsetof(struct prestera_fib_node, ht_node),
-	.key_len     = sizeof(struct prestera_fib_key),
+	.key_len     = sizeof_field(struct prestera_fib_node, key),
 	.automatic_shrinking = true,
 };
 
 static const struct rhashtable_params __prestera_nh_neigh_ht_params = {
 	.key_offset  = offsetof(struct prestera_nh_neigh, key),
-	.key_len     = sizeof(struct prestera_nh_neigh_key),
+	.key_len     = sizeof_field(struct prestera_nh_neigh, key),
 	.head_offset = offsetof(struct prestera_nh_neigh, ht_node),
 };
 
 static const struct rhashtable_params __prestera_nexthop_group_ht_params = {
 	.key_offset  = offsetof(struct prestera_nexthop_group, key),
-	.key_len     = sizeof(struct prestera_nexthop_group_key),
+	.key_len     = sizeof_field(struct prestera_nexthop_group, key),
 	.head_offset = offsetof(struct prestera_nexthop_group, ht_node),
 };
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index f20bb390df3a..0145c06ebec9 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -47,7 +47,7 @@ struct mtk_flow_data {
 static const struct rhashtable_params mtk_flow_ht_params = {
 	.head_offset = offsetof(struct mtk_flow_entry, node),
 	.key_offset = offsetof(struct mtk_flow_entry, cookie),
-	.key_len = sizeof(unsigned long),
+	.key_len = sizeof_field(struct mtk_flow_entry, cookie),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
index 2e9bee4e5209..dfd798c59051 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/neigh.c
@@ -269,7 +269,7 @@ static int mlx5e_rep_netevent_event(struct notifier_block *nb,
 static const struct rhashtable_params mlx5e_neigh_ht_params = {
 	.head_offset = offsetof(struct mlx5e_neigh_hash_entry, rhash_node),
 	.key_offset = offsetof(struct mlx5e_neigh_hash_entry, m_neigh),
-	.key_len = sizeof(struct mlx5e_neigh),
+	.key_len = sizeof_field(struct mlx5e_neigh_hash_entry, m_neigh),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index a84ebac2f011..5a3f370ab136 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -173,7 +173,7 @@ mlx5_tc_ct_entry_destroy_mod_hdr(struct mlx5_tc_ct_priv *ct_priv,
 static const struct rhashtable_params cts_ht_params = {
 	.head_offset = offsetof(struct mlx5_ct_entry, node),
 	.key_offset = offsetof(struct mlx5_ct_entry, cookie),
-	.key_len = sizeof(((struct mlx5_ct_entry *)0)->cookie),
+	.key_len = sizeof_field(struct mlx5_ct_entry, cookie),
 	.automatic_shrinking = true,
 	.min_size = 16 * 1024,
 };
@@ -181,14 +181,14 @@ static const struct rhashtable_params cts_ht_params = {
 static const struct rhashtable_params zone_params = {
 	.head_offset = offsetof(struct mlx5_ct_ft, node),
 	.key_offset = offsetof(struct mlx5_ct_ft, zone),
-	.key_len = sizeof(((struct mlx5_ct_ft *)0)->zone),
+	.key_len = sizeof_field(struct mlx5_ct_ft, zone),
 	.automatic_shrinking = true,
 };
 
 static const struct rhashtable_params tuples_ht_params = {
 	.head_offset = offsetof(struct mlx5_ct_entry, tuple_node),
 	.key_offset = offsetof(struct mlx5_ct_entry, tuple),
-	.key_len = sizeof(((struct mlx5_ct_entry *)0)->tuple),
+	.key_len = sizeof_field(struct mlx5_ct_entry, tuple),
 	.automatic_shrinking = true,
 	.min_size = 16 * 1024,
 };
@@ -196,7 +196,7 @@ static const struct rhashtable_params tuples_ht_params = {
 static const struct rhashtable_params tuples_nat_ht_params = {
 	.head_offset = offsetof(struct mlx5_ct_entry, tuple_nat_node),
 	.key_offset = offsetof(struct mlx5_ct_entry, tuple_nat),
-	.key_len = sizeof(((struct mlx5_ct_entry *)0)->tuple_nat),
+	.key_len = sizeof_field(struct mlx5_ct_entry, tuple_nat),
 	.automatic_shrinking = true,
 	.min_size = 16 * 1024,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 6b3b1afe8312..ee40c89b0f3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -4339,7 +4339,7 @@ static void get_flags(int flags, unsigned long *flow_flags)
 static const struct rhashtable_params tc_ht_params = {
 	.head_offset = offsetof(struct mlx5e_tc_flow, node),
 	.key_offset = offsetof(struct mlx5e_tc_flow, cookie),
-	.key_len = sizeof(((struct mlx5e_tc_flow *)0)->cookie),
+	.key_len = sizeof_field(struct mlx5e_tc_flow, cookie),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index c5ea1d1d2b03..9b9877bc7eb0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -15,7 +15,7 @@
 
 static const struct rhashtable_params fdb_ht_params = {
 	.key_offset = offsetof(struct mlx5_esw_bridge_fdb_entry, key),
-	.key_len = sizeof(struct mlx5_esw_bridge_fdb_key),
+	.key_len = sizeof_field(struct mlx5_esw_bridge_fdb_entry, key),
 	.head_offset = offsetof(struct mlx5_esw_bridge_fdb_entry, ht_node),
 	.automatic_shrinking = true,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
index 22dd30cf8033..7a39446c23f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
@@ -9,7 +9,7 @@
 
 static const struct rhashtable_params mdb_ht_params = {
 	.key_offset = offsetof(struct mlx5_esw_bridge_mdb_entry, key),
-	.key_len = sizeof(struct mlx5_esw_bridge_mdb_key),
+	.key_len = sizeof_field(struct mlx5_esw_bridge_mdb_entry, key),
 	.head_offset = offsetof(struct mlx5_esw_bridge_mdb_entry, ht_node),
 	.automatic_shrinking = true,
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
index 1915fa41c622..1dc77bf66c17 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -106,7 +106,7 @@ struct mlxsw_afa_set {
 };
 
 static const struct rhashtable_params mlxsw_afa_set_ht_params = {
-	.key_len = sizeof(struct mlxsw_afa_set_ht_key),
+	.key_len = sizeof_field(struct mlxsw_afa_set, ht_key),
 	.key_offset = offsetof(struct mlxsw_afa_set, ht_key),
 	.head_offset = offsetof(struct mlxsw_afa_set, ht_node),
 	.automatic_shrinking = true,
@@ -124,7 +124,7 @@ struct mlxsw_afa_fwd_entry {
 };
 
 static const struct rhashtable_params mlxsw_afa_fwd_entry_ht_params = {
-	.key_len = sizeof(struct mlxsw_afa_fwd_entry_ht_key),
+	.key_len = sizeof_field(struct mlxsw_afa_fwd_entry, ht_key),
 	.key_offset = offsetof(struct mlxsw_afa_fwd_entry, ht_key),
 	.head_offset = offsetof(struct mlxsw_afa_fwd_entry, ht_node),
 	.automatic_shrinking = true,
@@ -188,7 +188,7 @@ struct mlxsw_afa_policer {
 };
 
 static const struct rhashtable_params mlxsw_afa_policer_ht_params = {
-	.key_len = sizeof(u32),
+	.key_len = sizeof_field(struct mlxsw_afa_policer, fa_index),
 	.key_offset = offsetof(struct mlxsw_afa_policer, fa_index),
 	.head_offset = offsetof(struct mlxsw_afa_policer, ht_node),
 	.automatic_shrinking = true,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3f5e5d99251b..744084836fe7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2844,7 +2844,7 @@ struct mlxsw_sp_sample_trigger_node {
 static const struct rhashtable_params mlxsw_sp_sample_trigger_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_sample_trigger_node, trigger),
 	.head_offset = offsetof(struct mlxsw_sp_sample_trigger_node, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_sample_trigger),
+	.key_len = sizeof_field(struct mlxsw_sp_sample_trigger_node, trigger),
 	.automatic_shrinking = true,
 };
 
@@ -3005,7 +3005,7 @@ struct mlxsw_sp_ipv6_addr_node {
 static const struct rhashtable_params mlxsw_sp_ipv6_addr_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_ipv6_addr_node, key),
 	.head_offset = offsetof(struct mlxsw_sp_ipv6_addr_node, ht_node),
-	.key_len = sizeof(struct in6_addr),
+	.key_len = sizeof_field(struct mlxsw_sp_ipv6_addr_node, key),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
index 3e70cee4d2f3..3701911fa5d5 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c
@@ -78,14 +78,14 @@ struct mlxsw_sp_acl_rule {
 };
 
 static const struct rhashtable_params mlxsw_sp_acl_ruleset_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_acl_ruleset_ht_key),
+	.key_len = sizeof_field(struct mlxsw_sp_acl_ruleset, ht_key),
 	.key_offset = offsetof(struct mlxsw_sp_acl_ruleset, ht_key),
 	.head_offset = offsetof(struct mlxsw_sp_acl_ruleset, ht_node),
 	.automatic_shrinking = true,
 };
 
 static const struct rhashtable_params mlxsw_sp_acl_rule_ht_params = {
-	.key_len = sizeof(unsigned long),
+	.key_len = sizeof_field(struct mlxsw_sp_acl_rule, cookie),
 	.key_offset = offsetof(struct mlxsw_sp_acl_rule, cookie),
 	.head_offset = offsetof(struct mlxsw_sp_acl_rule, ht_node),
 	.automatic_shrinking = true,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index 07cb1e26ca3e..49201c4324ac 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -52,13 +52,13 @@ struct mlxsw_sp_acl_atcam_region_12kb {
 };
 
 static const struct rhashtable_params mlxsw_sp_acl_atcam_lkey_id_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_acl_atcam_lkey_id_ht_key),
+	.key_len = sizeof_field(struct mlxsw_sp_acl_atcam_lkey_id, ht_key),
 	.key_offset = offsetof(struct mlxsw_sp_acl_atcam_lkey_id, ht_key),
 	.head_offset = offsetof(struct mlxsw_sp_acl_atcam_lkey_id, ht_node),
 };
 
 static const struct rhashtable_params mlxsw_sp_acl_atcam_entries_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_acl_atcam_entry_ht_key),
+	.key_len = sizeof_field(struct mlxsw_sp_acl_atcam_entry, ht_key),
 	.key_offset = offsetof(struct mlxsw_sp_acl_atcam_entry, ht_key),
 	.head_offset = offsetof(struct mlxsw_sp_acl_atcam_entry, ht_node),
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index b1d08e958bf9..adf293dccda3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -198,7 +198,7 @@ struct mlxsw_sp_acl_tcam_ventry {
 };
 
 static const struct rhashtable_params mlxsw_sp_acl_tcam_vchunk_ht_params = {
-	.key_len = sizeof(unsigned int),
+	.key_len = sizeof_field(struct mlxsw_sp_acl_tcam_vchunk, priority),
 	.key_offset = offsetof(struct mlxsw_sp_acl_tcam_vchunk, priority),
 	.head_offset = offsetof(struct mlxsw_sp_acl_tcam_vchunk, ht_node),
 	.automatic_shrinking = true,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
index 69cd689dbc83..5805520c5bbc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_mr.c
@@ -91,7 +91,7 @@ struct mlxsw_sp_mr_route {
 };
 
 static const struct rhashtable_params mlxsw_sp_mr_route_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_mr_route_key),
+	.key_len = sizeof_field(struct mlxsw_sp_mr_route, key),
 	.key_offset = offsetof(struct mlxsw_sp_mr_route, key),
 	.head_offset = offsetof(struct mlxsw_sp_mr_route, ht_node),
 	.automatic_shrinking = true,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
index 5479a1c19d2e..11e1ae8decce 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -77,7 +77,7 @@ struct mlxsw_sp_nve_mc_list {
 };
 
 static const struct rhashtable_params mlxsw_sp_nve_mc_list_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_nve_mc_list_key),
+	.key_len = sizeof_field(struct mlxsw_sp_nve_mc_list, key),
 	.key_offset = offsetof(struct mlxsw_sp_nve_mc_list, key),
 	.head_offset = offsetof(struct mlxsw_sp_nve_mc_list, ht_node),
 };
@@ -810,7 +810,7 @@ struct mlxsw_sp_nve_ipv6_ht_node {
 };
 
 static const struct rhashtable_params mlxsw_sp_nve_ipv6_ht_params = {
-	.key_len = sizeof(struct mlxsw_sp_nve_ipv6_ht_key),
+	.key_len = sizeof_field(struct mlxsw_sp_nve_ipv6_ht_node, key),
 	.key_offset = offsetof(struct mlxsw_sp_nve_ipv6_ht_node, key),
 	.head_offset = offsetof(struct mlxsw_sp_nve_ipv6_ht_node, ht_node),
 };
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 7d6d859cef3f..f114b52a0ab0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -2196,7 +2196,7 @@ struct mlxsw_sp_neigh_entry {
 static const struct rhashtable_params mlxsw_sp_neigh_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_neigh_entry, key),
 	.head_offset = offsetof(struct mlxsw_sp_neigh_entry, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_neigh_key),
+	.key_len = sizeof_field(struct mlxsw_sp_neigh_entry, key),
 };
 
 struct mlxsw_sp_neigh_entry *
@@ -3375,7 +3375,7 @@ bool mlxsw_sp_nexthop_group_has_ipip(struct mlxsw_sp_nexthop *nh)
 static const struct rhashtable_params mlxsw_sp_nexthop_group_vr_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_nexthop_group_vr_entry, key),
 	.head_offset = offsetof(struct mlxsw_sp_nexthop_group_vr_entry, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_nexthop_group_vr_key),
+	.key_len = sizeof_field(struct mlxsw_sp_nexthop_group_vr_entry, key),
 	.automatic_shrinking = true,
 };
 
@@ -3662,7 +3662,7 @@ mlxsw_sp_nexthop6_group_lookup(struct mlxsw_sp *mlxsw_sp,
 static const struct rhashtable_params mlxsw_sp_nexthop_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_nexthop, key),
 	.head_offset = offsetof(struct mlxsw_sp_nexthop, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_nexthop_key),
+	.key_len = sizeof_field(struct mlxsw_sp_nexthop, key),
 };
 
 static int mlxsw_sp_nexthop_insert(struct mlxsw_sp *mlxsw_sp,
@@ -6561,7 +6561,7 @@ mlxsw_sp_fib4_entry_lookup(struct mlxsw_sp *mlxsw_sp,
 static const struct rhashtable_params mlxsw_sp_fib_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_fib_node, key),
 	.head_offset = offsetof(struct mlxsw_sp_fib_node, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_fib_key),
+	.key_len = sizeof_field(struct mlxsw_sp_fib_node, key),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 6397ff0dc951..cee484cbe31f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -127,7 +127,7 @@ struct mlxsw_sp_mdb_entry_port {
 static const struct rhashtable_params mlxsw_sp_mdb_ht_params = {
 	.key_offset = offsetof(struct mlxsw_sp_mdb_entry, key),
 	.head_offset = offsetof(struct mlxsw_sp_mdb_entry, ht_node),
-	.key_len = sizeof(struct mlxsw_sp_mdb_entry_key),
+	.key_len = sizeof_field(struct mlxsw_sp_mdb_entry, key),
 };
 
 static int
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/main.c b/drivers/net/ethernet/netronome/nfp/bpf/main.c
index f469950c7265..aae6b710b24e 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/main.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/main.c
@@ -15,7 +15,7 @@
 
 const struct rhashtable_params nfp_bpf_maps_neutral_params = {
 	.nelem_hint		= 4,
-	.key_len		= sizeof_field(struct bpf_map, id),
+	.key_len		= sizeof_field(struct nfp_bpf_neutral_map, map_id),
 	.key_offset		= offsetof(struct nfp_bpf_neutral_map, map_id),
 	.head_offset		= offsetof(struct nfp_bpf_neutral_map, l),
 	.automatic_shrinking	= true,
diff --git a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
index 15180538b80a..e9f0b6311b4e 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/conntrack.c
@@ -10,7 +10,7 @@
 const struct rhashtable_params nfp_tc_ct_merge_params = {
 	.head_offset		= offsetof(struct nfp_fl_ct_tc_merge,
 					   hash_node),
-	.key_len		= sizeof(unsigned long) * 2,
+	.key_len		= sizeof_field(struct nfp_fl_ct_tc_merge, cookie),
 	.key_offset		= offsetof(struct nfp_fl_ct_tc_merge, cookie),
 	.automatic_shrinking	= true,
 };
@@ -18,7 +18,7 @@ const struct rhashtable_params nfp_tc_ct_merge_params = {
 const struct rhashtable_params nfp_nft_ct_merge_params = {
 	.head_offset		= offsetof(struct nfp_fl_nft_tc_merge,
 					   hash_node),
-	.key_len		= sizeof(unsigned long) * 3,
+	.key_len		= sizeof_field(struct nfp_fl_nft_tc_merge, cookie),
 	.key_offset		= offsetof(struct nfp_fl_nft_tc_merge, cookie),
 	.automatic_shrinking	= true,
 };
diff --git a/drivers/net/ethernet/netronome/nfp/flower/metadata.c b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
index 80e4675582bf..16a3ccb674ff 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -34,7 +34,7 @@ struct nfp_fl_stats_ctx_to_flow {
 static const struct rhashtable_params stats_ctx_table_params = {
 	.key_offset	= offsetof(struct nfp_fl_stats_ctx_to_flow, stats_cxt),
 	.head_offset	= offsetof(struct nfp_fl_stats_ctx_to_flow, ht_node),
-	.key_len	= sizeof(u32),
+	.key_len	= sizeof_field(struct nfp_fl_stats_ctx_to_flow, stats_cxt),
 };
 
 static int nfp_release_stats_entry(struct nfp_app *app, u32 stats_context_id)
@@ -485,19 +485,19 @@ const struct rhashtable_params nfp_flower_table_params = {
 const struct rhashtable_params merge_table_params = {
 	.key_offset	= offsetof(struct nfp_merge_info, parent_ctx),
 	.head_offset	= offsetof(struct nfp_merge_info, ht_node),
-	.key_len	= sizeof(u64),
+	.key_len	= sizeof_field(struct nfp_merge_info, parent_ctx),
 };
 
 const struct rhashtable_params nfp_zone_table_params = {
 	.head_offset		= offsetof(struct nfp_fl_ct_zone_entry, hash_node),
-	.key_len		= sizeof(u16),
+	.key_len		= sizeof_field(struct nfp_fl_ct_zone_entry, zone),
 	.key_offset		= offsetof(struct nfp_fl_ct_zone_entry, zone),
 	.automatic_shrinking	= false,
 };
 
 const struct rhashtable_params nfp_ct_map_params = {
 	.head_offset		= offsetof(struct nfp_fl_ct_map_entry, hash_node),
-	.key_len		= sizeof(unsigned long),
+	.key_len		= sizeof_field(struct nfp_fl_ct_map_entry, cookie),
 	.key_offset		= offsetof(struct nfp_fl_ct_map_entry, cookie),
 	.automatic_shrinking	= true,
 };
@@ -505,7 +505,7 @@ const struct rhashtable_params nfp_ct_map_params = {
 const struct rhashtable_params neigh_table_params = {
 	.key_offset	= offsetof(struct nfp_neigh_entry, neigh_cookie),
 	.head_offset	= offsetof(struct nfp_neigh_entry, ht_node),
-	.key_len	= sizeof(unsigned long),
+	.key_offset	= sizeof_field(struct nfp_neigh_entry, neigh_cookie),
 };
 
 int nfp_flower_metadata_init(struct nfp_app *app, u64 host_ctx_count,
diff --git a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
index e7180b4793c7..1785ad13e1a8 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/qos_conf.c
@@ -555,7 +555,7 @@ int nfp_flower_setup_qos_offload(struct nfp_app *app, struct net_device *netdev,
 static const struct rhashtable_params stats_meter_table_params = {
 	.key_offset	= offsetof(struct nfp_meter_entry, meter_id),
 	.head_offset	= offsetof(struct nfp_meter_entry, ht_node),
-	.key_len	= sizeof(u32),
+	.key_len	= sizeof_field(struct nfp_meter_entry, meter_id),
 };
 
 struct nfp_meter_entry *
diff --git a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
index 0d7d138d6e0d..51ae5e2244aa 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c
@@ -201,7 +201,7 @@ struct nfp_tun_offloaded_mac {
 static const struct rhashtable_params offloaded_macs_params = {
 	.key_offset	= offsetof(struct nfp_tun_offloaded_mac, addr),
 	.head_offset	= offsetof(struct nfp_tun_offloaded_mac, ht_node),
-	.key_len	= ETH_ALEN,
+	.key_len	= sizeof_field(struct nfp_tun_offloaded_mac, addr),
 	.automatic_shrinking	= true,
 };
 
diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 50f097487b14..72907685cbec 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1053,7 +1053,7 @@ static bool efx_mae_asl_id(u32 id)
 
 /* mport handling */
 static const struct rhashtable_params efx_mae_mports_ht_params = {
-	.key_len	= sizeof(u32),
+	.key_len	= sizeof_field(struct mae_mport_desc, mport_id),
 	.key_offset	= offsetof(struct mae_mport_desc, mport_id),
 	.head_offset	= offsetof(struct mae_mport_desc, linkage),
 };
diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 0d93164988fc..da942b259e62 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -90,31 +90,31 @@ s64 efx_tc_flower_external_mport(struct efx_nic *efx, struct efx_rep *efv)
 }
 
 static const struct rhashtable_params efx_tc_mac_ht_params = {
-	.key_len	= offsetofend(struct efx_tc_mac_pedit_action, h_addr),
-	.key_offset	= 0,
+	.key_len	= sizeof_field(struct efx_tc_mac_pedit_action, h_addr),
+	.key_offset	= offsetof(struct efx_tc_mac_pedit_action, h_addr),
 	.head_offset	= offsetof(struct efx_tc_mac_pedit_action, linkage),
 };
 
 static const struct rhashtable_params efx_tc_encap_match_ht_params = {
-	.key_len	= offsetof(struct efx_tc_encap_match, linkage),
+	.key_len	= offsetofend(struct efx_tc_encap_match, ip_tos_mask),
 	.key_offset	= 0,
 	.head_offset	= offsetof(struct efx_tc_encap_match, linkage),
 };
 
 static const struct rhashtable_params efx_tc_match_action_ht_params = {
-	.key_len	= sizeof(unsigned long),
+	.key_len	= sizeof_field(struct efx_tc_flow_rule, cookie),
 	.key_offset	= offsetof(struct efx_tc_flow_rule, cookie),
 	.head_offset	= offsetof(struct efx_tc_flow_rule, linkage),
 };
 
 static const struct rhashtable_params efx_tc_lhs_rule_ht_params = {
-	.key_len	= sizeof(unsigned long),
+	.key_len	= sizeof_field(struct efx_tc_lhs_rule, cookie),
 	.key_offset	= offsetof(struct efx_tc_lhs_rule, cookie),
 	.head_offset	= offsetof(struct efx_tc_lhs_rule, linkage),
 };
 
 static const struct rhashtable_params efx_tc_recirc_ht_params = {
-	.key_len	= offsetof(struct efx_tc_recirc_id, linkage),
+	.key_len	= offsetofend(struct efx_tc_recirc_id, netdev),
 	.key_offset	= 0,
 	.head_offset	= offsetof(struct efx_tc_recirc_id, linkage),
 };
diff --git a/drivers/net/ethernet/sfc/tc_conntrack.c b/drivers/net/ethernet/sfc/tc_conntrack.c
index d90206f27161..36bb7c78f2b9 100644
--- a/drivers/net/ethernet/sfc/tc_conntrack.c
+++ b/drivers/net/ethernet/sfc/tc_conntrack.c
@@ -16,14 +16,14 @@ static int efx_tc_flow_block(enum tc_setup_type type, void *type_data,
 			     void *cb_priv);
 
 static const struct rhashtable_params efx_tc_ct_zone_ht_params = {
-	.key_len	= offsetof(struct efx_tc_ct_zone, linkage),
-	.key_offset	= 0,
+	.key_len	= sizeof_field(struct efx_tc_ct_zone, zone),
+	.key_offset	= offsetof(struct efx_tc_ct_zone, zone),
 	.head_offset	= offsetof(struct efx_tc_ct_zone, linkage),
 };
 
 static const struct rhashtable_params efx_tc_ct_ht_params = {
-	.key_len	= offsetof(struct efx_tc_ct_entry, linkage),
-	.key_offset	= 0,
+	.key_len	= sizeof_field(struct efx_tc_ct_entry, cookie),
+	.key_offset	= offsetof(struct efx_tc_ct_entry, cookie),
 	.head_offset	= offsetof(struct efx_tc_ct_entry, linkage),
 };
 
diff --git a/drivers/net/ethernet/sfc/tc_counters.c b/drivers/net/ethernet/sfc/tc_counters.c
index a421b0123506..067d75973f0a 100644
--- a/drivers/net/ethernet/sfc/tc_counters.c
+++ b/drivers/net/ethernet/sfc/tc_counters.c
@@ -17,14 +17,14 @@
 /* Counter-management hashtables */
 
 static const struct rhashtable_params efx_tc_counter_id_ht_params = {
-	.key_len	= offsetof(struct efx_tc_counter_index, linkage),
-	.key_offset	= 0,
+	.key_len	= sizeof_field(struct efx_tc_counter_index, cookie),
+	.key_offset	= offsetof(struct efx_tc_counter_index, cookie),
 	.head_offset	= offsetof(struct efx_tc_counter_index, linkage),
 };
 
 static const struct rhashtable_params efx_tc_counter_ht_params = {
-	.key_len	= offsetof(struct efx_tc_counter, linkage),
-	.key_offset	= 0,
+	.key_len	= sizeof_field(struct efx_tc_counter, fw_id),
+	.key_offset	= offsetof(struct efx_tc_counter, fw_id),
 	.head_offset	= offsetof(struct efx_tc_counter, linkage),
 };
 
diff --git a/drivers/net/ethernet/sfc/tc_encap_actions.c b/drivers/net/ethernet/sfc/tc_encap_actions.c
index 87443f9dfd22..fa081bbcdef6 100644
--- a/drivers/net/ethernet/sfc/tc_encap_actions.c
+++ b/drivers/net/ethernet/sfc/tc_encap_actions.c
@@ -17,7 +17,7 @@
 #include <net/arp.h>
 
 static const struct rhashtable_params efx_neigh_ht_params = {
-	.key_len	= offsetof(struct efx_neigh_binder, ha),
+	.key_len	= offsetofend(struct efx_neigh_binder, dst_ip6),
 	.key_offset	= 0,
 	.head_offset	= offsetof(struct efx_neigh_binder, linkage),
 };
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index 16c382c42227..4184b0f0a196 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -115,7 +115,7 @@ struct nsim_fib_event {
 static const struct rhashtable_params nsim_fib_rt_ht_params = {
 	.key_offset = offsetof(struct nsim_fib_rt, key),
 	.head_offset = offsetof(struct nsim_fib_rt, ht_node),
-	.key_len = sizeof(struct nsim_fib_rt_key),
+	.key_len = sizeof_field(struct nsim_fib_rt, key),
 	.automatic_shrinking = true,
 };
 
@@ -129,7 +129,7 @@ struct nsim_nexthop {
 static const struct rhashtable_params nsim_nexthop_ht_params = {
 	.key_offset = offsetof(struct nsim_nexthop, id),
 	.head_offset = offsetof(struct nsim_nexthop, ht_node),
-	.key_len = sizeof(u32),
+	.key_len = sizeof_field(struct nsim_nexthop, id),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 8735891ee128..29e7c91ffd2b 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -85,7 +85,7 @@ struct vxlan_mdb_flush_desc {
 static const struct rhashtable_params vxlan_mdb_rht_params = {
 	.head_offset = offsetof(struct vxlan_mdb_entry, rhnode),
 	.key_offset = offsetof(struct vxlan_mdb_entry, key),
-	.key_len = sizeof(struct vxlan_mdb_entry_key),
+	.key_len = sizeof_field(struct vxlan_mdb_entry, key),
 	.automatic_shrinking = true,
 };
 
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index d2023e7131bd..c70954c54e92 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -29,7 +29,7 @@ static inline int vxlan_vni_cmp(struct rhashtable_compare_arg *arg,
 const struct rhashtable_params vxlan_vni_rht_params = {
 	.head_offset = offsetof(struct vxlan_vni_node, vnode),
 	.key_offset = offsetof(struct vxlan_vni_node, vni),
-	.key_len = sizeof(__be32),
+	.key_len = sizeof_field(struct vxlan_vni_node, vni),
 	.nelem_hint = 3,
 	.max_size = VXLAN_N_VID,
 	.obj_cmpfn = vxlan_vni_cmp,
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 347a15544afe..8d405d15a09b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -757,7 +757,7 @@ struct mac80211_hwsim_data {
 static const struct rhashtable_params hwsim_rht_params = {
 	.nelem_hint = 2,
 	.automatic_shrinking = true,
-	.key_len = ETH_ALEN,
+	.key_len = sizeof_field(struct mac80211_hwsim_data, addresses[1]),
 	.key_offset = offsetof(struct mac80211_hwsim_data, addresses[1]),
 	.head_offset = offsetof(struct mac80211_hwsim_data, rht),
 };
-- 
2.25.1


