Return-Path: <netdev+bounces-65364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA2483A3F3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DEA2B21D28
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B0C175A1;
	Wed, 24 Jan 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+FGgY8p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FACD17553
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084354; cv=none; b=fueVjSO5QoF7Cg4tclGQFaEIpihj1UB+cLxrml2h8LQzxgd4IDE2CFOns2luNce6W5dAQNZTcdCvkLIoICjyXbRidVAOXLZChGEgzrvTfndQ7MXoTJQbPsFMwSYoPZCYdy6ulgnd2EtIzbJyBWPr3BIkxZkJlQ2pPTbW/EipVmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084354; c=relaxed/simple;
	bh=E7KTKsbWWq+XBFUM++BPngc0d4VNozZpEzVUPMSKCKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VVN629byYoiRuYZbNKwnxABp1IZpS9ppsg8GuqYw8PS1XSBIgOnjhu4lH/wsq2k3FwnYhkVaSMTSv1ZFGCfS7TOXU5qPfS16cyTYvHeFNV7e4k5qNVEXqt2Qbw6o5dwHViyWdNbbj62JM52t5wixvExE7qktA01NfS+U74W3t4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+FGgY8p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1BAC433C7;
	Wed, 24 Jan 2024 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084353;
	bh=E7KTKsbWWq+XBFUM++BPngc0d4VNozZpEzVUPMSKCKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j+FGgY8pmf6bw9+DKqnsVErCZB8bPQ8qajCVflbUEEFagaXmmo4V911HUr+mImLuK
	 3s8OHJm51aQC8wwKcgKTUN2/4BYenYBXlEADGgEaXqWHOS29ikS2vU6M1hs1E57S22
	 04V5ZLEBnXbpJVc2GGAij1ILKiYw92J4V633juIPL4hC9IVPKoRd5sw0yeEbvwYbPK
	 RfGqrKnhdv5xFnboTG9Z4FYNpuhfNmUMHfCmg+OcEqSxNgcTSmOI/XInxeVQGw9si9
	 B4lSacVGC5lsuiMvo9DRkpEVzwAXHR4N4vSrjw1UxpTY1jSvCwiUk1KZJReJEqdP1C
	 BiByMrrRurGLA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: [net 07/14] net/mlx5: Bridge, fix multicast packets sent to uplink
Date: Wed, 24 Jan 2024 00:18:48 -0800
Message-ID: <20240124081855.115410-8-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

To enable multicast packets which are offloaded in bridge multicast
offload mode to be sent also to uplink, FTE bit uplink_hairpin_en should
be set. Add this bit to FTE for the bridge multicast offload rules.

Fixes: 18c2916cee12 ("net/mlx5: Bridge, snoop igmp/mld packets")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c           | 2 ++
 include/linux/mlx5/fs.h                                    | 1 +
 include/linux/mlx5/mlx5_ifc.h                              | 2 +-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
index a7ed87e9d842..22dd30cf8033 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_mcast.c
@@ -83,6 +83,7 @@ mlx5_esw_bridge_mdb_flow_create(u16 esw_owner_vhca_id, struct mlx5_esw_bridge_md
 		i++;
 	}
 
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	rule_spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 	dmac_v = MLX5_ADDR_OF(fte_match_param, rule_spec->match_value, outer_headers.dmac_47_16);
 	ether_addr_copy(dmac_v, entry->key.addr);
@@ -587,6 +588,7 @@ mlx5_esw_bridge_mcast_vlan_flow_create(u16 vlan_proto, struct mlx5_esw_bridge_po
 	if (!rule_spec)
 		return ERR_PTR(-ENOMEM);
 
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	rule_spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
 
 	flow_act.action |= MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT;
@@ -662,6 +664,7 @@ mlx5_esw_bridge_mcast_fwd_flow_create(struct mlx5_esw_bridge_port *port)
 		dest.vport.flags = MLX5_FLOW_DEST_VPORT_VHCA_ID;
 		dest.vport.vhca_id = port->esw_owner_vhca_id;
 	}
+	rule_spec->flow_context.flags |= FLOW_CONTEXT_UPLINK_HAIRPIN_EN;
 	handle = mlx5_add_flow_rules(port->mcast.ft, rule_spec, &flow_act, &dest, 1);
 
 	kvfree(rule_spec);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 1616a6144f7b..9b8599c200e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -566,6 +566,8 @@ static int mlx5_cmd_set_fte(struct mlx5_core_dev *dev,
 		 fte->flow_context.flow_tag);
 	MLX5_SET(flow_context, in_flow_context, flow_source,
 		 fte->flow_context.flow_source);
+	MLX5_SET(flow_context, in_flow_context, uplink_hairpin_en,
+		 !!(fte->flow_context.flags & FLOW_CONTEXT_UPLINK_HAIRPIN_EN));
 
 	MLX5_SET(flow_context, in_flow_context, extended_destination,
 		 extended_dest);
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 6f7725238abc..3fb428ce7d1c 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -132,6 +132,7 @@ struct mlx5_flow_handle;
 
 enum {
 	FLOW_CONTEXT_HAS_TAG = BIT(0),
+	FLOW_CONTEXT_UPLINK_HAIRPIN_EN = BIT(1),
 };
 
 struct mlx5_flow_context {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 37230253f9f1..c726f90ab752 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -3576,7 +3576,7 @@ struct mlx5_ifc_flow_context_bits {
 	u8         action[0x10];
 
 	u8         extended_destination[0x1];
-	u8         reserved_at_81[0x1];
+	u8         uplink_hairpin_en[0x1];
 	u8         flow_source[0x2];
 	u8         encrypt_decrypt_type[0x4];
 	u8         destination_list_size[0x18];
-- 
2.43.0


