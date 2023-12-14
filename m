Return-Path: <netdev+bounces-57153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3705C812488
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D916F1F21A10
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7558ECB;
	Thu, 14 Dec 2023 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2qwZAG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9856B15D5
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C6C43391;
	Thu, 14 Dec 2023 01:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517113;
	bh=NRsoaUBSfxmxE3g/nKZBXfwndHkTwZe/5mRf5JQ6gcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2qwZAG5iAP54SbMEiBB3Zu5sKAtzeBKY2O8Cer1EK9cguEanzbW3WUZMTS0TH02A
	 Z6yEgEKHB1kv/AD6OPmL4d//cladf/XzF/5quv/gDZsZynqAHc3ZzeKM08w5k2EFUp
	 ykz7f3z86c/Y0zZ4C01+u0UlWMTTIqFP3K12lB3Dz8nWM190jpGiudjQ5dJ5N1ELJt
	 5CJAkHhsi834FYK1WfMFgXdFz+cOlWFeDE3l2CrGHR3GtzAt8NJLkPSUbmNzNTsNE8
	 rl+xJlTeh7eB3lRz2Tom/lwXf/K6pQ0NPXDe6PG4o30c663SMRakrQuWOzFqM74V/+
	 GiSLDBBlyJHdA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Shifeng Li <lishifeng@sangfor.com.cn>,
	Ding Hui <dinghui@sangfor.com.cn>,
	Simon Horman <horms@kernel.org>
Subject: [net 04/15] net/mlx5e: Fix slab-out-of-bounds in mlx5_query_nic_vport_mac_list()
Date: Wed, 13 Dec 2023 17:24:54 -0800
Message-ID: <20231214012505.42666-5-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shifeng Li <lishifeng@sangfor.com.cn>

Out_sz that the size of out buffer is calculated using query_nic_vport
_context_in structure when driver query the MAC list. However query_nic
_vport_context_in structure is smaller than query_nic_vport_context_out.
When allowed_list_size is greater than 96, calling ether_addr_copy() will
trigger an slab-out-of-bounds.

[ 1170.055866] BUG: KASAN: slab-out-of-bounds in mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.055869] Read of size 4 at addr ffff88bdbc57d912 by task kworker/u128:1/461
[ 1170.055870]
[ 1170.055932] Workqueue: mlx5_esw_wq esw_vport_change_handler [mlx5_core]
[ 1170.055936] Call Trace:
[ 1170.055949]  dump_stack+0x8b/0xbb
[ 1170.055958]  print_address_description+0x6a/0x270
[ 1170.055961]  kasan_report+0x179/0x2c0
[ 1170.056061]  mlx5_query_nic_vport_mac_list+0x481/0x4d0 [mlx5_core]
[ 1170.056162]  esw_update_vport_addr_list+0x2c5/0xcd0 [mlx5_core]
[ 1170.056257]  esw_vport_change_handle_locked+0xd08/0x1a20 [mlx5_core]
[ 1170.056377]  esw_vport_change_handler+0x6b/0x90 [mlx5_core]
[ 1170.056381]  process_one_work+0x65f/0x12d0
[ 1170.056383]  worker_thread+0x87/0xb50
[ 1170.056390]  kthread+0x2e9/0x3a0
[ 1170.056394]  ret_from_fork+0x1f/0x40

Fixes: e16aea2744ab ("net/mlx5: Introduce access functions to modify/query vport mac lists")
Cc: Ding Hui <dinghui@sangfor.com.cn>
Signed-off-by: Shifeng Li <lishifeng@sangfor.com.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 5a31fb47ffa5..21753f327868 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -277,7 +277,7 @@ int mlx5_query_nic_vport_mac_list(struct mlx5_core_dev *dev,
 		req_list_size = max_list_size;
 	}
 
-	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_in) +
+	out_sz = MLX5_ST_SZ_BYTES(query_nic_vport_context_out) +
 			req_list_size * MLX5_ST_SZ_BYTES(mac_address_layout);
 
 	out = kvzalloc(out_sz, GFP_KERNEL);
-- 
2.43.0


