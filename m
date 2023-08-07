Return-Path: <netdev+bounces-25159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6833477313A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382291C20D48
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83817ACD;
	Mon,  7 Aug 2023 21:26:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248D17FF1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2494C433C7;
	Mon,  7 Aug 2023 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443581;
	bh=Gm6liO7JLk3Oy0nBVtv3uPqjRq8YTiwMA4fvQg4E0JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DYLB2xG1eqfm2kFy3QSEH/MvDvNMgEp9DgABvCie6RMrfqpXG3NvZJeJcBq8+67tN
	 YxTP6cQLwhZqJ+1dH7PiEbz2vYHgR8b3yOvv1edCgL5Xb/XcoI+NmY7Ml1Y5G+pHac
	 Cl74yaA2ASQ/LGF3hK3FQ9hmG107mQ8kkGfnNgC+uAU8I6mYRL/ENoUYz08vyltUEU
	 xGFwz+rcvMTa0cDJ1XR8CiJmEJjuEV+00nWuDmgKRaCb4mVfb8hncLrK9YU9XQbtiE
	 K/RYiMvelm7fI70dkIRDCgsbEAbyxEOV/FrXMhPoGG4ZKJZ2dmwQeN1QonmlgUhpGc
	 IRDlNcTDQZpfg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net 07/11] net/mlx5e: Unoffload post act rule when handling FIB events
Date: Mon,  7 Aug 2023 14:26:03 -0700
Message-ID: <20230807212607.50883-8-saeed@kernel.org>
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

From: Chris Mi <cmi@nvidia.com>

If having the following tc rule on stack device:

filter parent ffff: protocol ip pref 3 flower chain 1
filter parent ffff: protocol ip pref 3 flower chain 1 handle 0x1
  dst_mac 24:25:d0:e1:00:00
  src_mac 02:25:d0:25:01:02
  eth_type ipv4
  ct_state +trk+new
  in_hw in_hw_count 1
        action order 1: ct commit zone 0 pipe
         index 2 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

        action order 2: tunnel_key  set
        src_ip 192.168.1.25
        dst_ip 192.168.1.26
        key_id 4
        dst_port 4789
        csum pipe
         index 3 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

        action order 3: mirred (Egress Redirect to device vxlan1) stolen
        index 9 ref 1 bind 1 installed 3807 sec used 3779 sec firstused 3800 sec
        Action statistics:
        Sent 120 bytes 2 pkt (dropped 0, overlimits 0 requeues 0)
        backlog 0b 0p requeues 0
        used_hw_stats delayed

When handling FIB events, the rule in post act will not be deleted.
And because the post act rule has packet reformat and modify header
actions, also will hit the following syndromes:

mlx5_core 0000:08:00.0: mlx5_cmd_out_err:829:(pid 11613): DEALLOC_MODIFY_HEADER_CONTEXT(0x941) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x1ab444), err(-22)
mlx5_core 0000:08:00.0: mlx5_cmd_out_err:829:(pid 11613): DEALLOC_PACKET_REFORMAT_CONTEXT(0x93e) op_mod(0x0) failed, status bad resource state(0x9), syndrome (0x179e84), err(-22)

Fix it by unoffloading post act rule when handling FIB events.

Fixes: 314e1105831b ("net/mlx5e: Add post act offload/unoffload API")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 0c88cf47af01..1730f6a716ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -1461,10 +1461,12 @@ static void mlx5e_invalidate_encap(struct mlx5e_priv *priv,
 		attr = mlx5e_tc_get_encap_attr(flow);
 		esw_attr = attr->esw_attr;
 
-		if (flow_flag_test(flow, SLOW))
+		if (flow_flag_test(flow, SLOW)) {
 			mlx5e_tc_unoffload_from_slow_path(esw, flow);
-		else
+		} else {
 			mlx5e_tc_unoffload_fdb_rules(esw, flow, flow->attr);
+			mlx5e_tc_unoffload_flow_post_acts(flow);
+		}
 
 		mlx5e_tc_detach_mod_hdr(priv, flow, attr);
 		attr->modify_hdr = NULL;
-- 
2.41.0


