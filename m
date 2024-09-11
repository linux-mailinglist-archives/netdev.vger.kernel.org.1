Return-Path: <netdev+bounces-127549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F46975B8E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAE02848B4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77161BBBDA;
	Wed, 11 Sep 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erPQ9+Tu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832261BBBD5
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085884; cv=none; b=r8OSxpe59w4lkUrPURVgPqIBIC5+ET5fmCakv0IegqDZm5dADfbxPmsEPhHAJPBCxE3GJrCyp2wo0r+niO7GDIr5qHRAaMrz/414kqmVjcJMOnhprcByjM+eZ/dNmVyOKAREorT8mCNFq4FUojg2C0tiAXC0GfMhE9C5s0zYB1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085884; c=relaxed/simple;
	bh=STGgjkD6BnXOtiKYB68lDHFJ+B2ejdofy6hf3Rc4vuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2ZSDI3ijWH9/Ezwg8DJrWyHi7UxrHeWf3U/uxzHLGv38+HR9JHkHV0aNrhXyuSc030MdIMwBIzKq9IRuZqRlBu0ZVoj/SpU2KMTgsdKuXxqjf8KAwcX/C5szH+LL0tS1qFPX2OQYI6Fxnjl+tWZvUsXibNtvSKyc7ApriQQgWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erPQ9+Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563B1C4CECC;
	Wed, 11 Sep 2024 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085884;
	bh=STGgjkD6BnXOtiKYB68lDHFJ+B2ejdofy6hf3Rc4vuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erPQ9+TuczjPhuTcPwDRL5h/NNI1OD70Ettkal+T38ox++34fNYrAQV6k2Hld8WXJ
	 Pib2bMeMyddBkAe7iK/Ss1XzQ5DUGP2KhKSKR62qXksZ/Fjp72CiAyFUT0ZE5VnuV+
	 wlKoAL+thPFqCwmQ77WUUNcvwJNwDdzCUQqhrtqfhv1EJYjJq5ovpp4wg0a48apnvI
	 /QCdAu5TB3W3yw8/QyWbdvLDKzVkywlem4AVk8Jc7me2P0lnqYMog5qEbsd+15752g
	 ceOAqBuIbVofUjb7AlZMUBim7w3ZM+HcP8ksnbt7RJfGBM18PYhTwZ3TFeiDdN+mmH
	 9wUTxLWwvKroA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next 05/15] net/mlx5: fs, move hardware fte deletion function reset
Date: Wed, 11 Sep 2024 13:17:47 -0700
Message-ID: <20240911201757.1505453-6-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Downstream patches will need this as we might not want to reset
it when a pending rule is connected to the FTE.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index e32725487702..899d91577a54 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -683,6 +683,8 @@ static void del_hw_fte(struct fs_node *node)
 				       fte->index, fg->id);
 		node->active = false;
 	}
+	/* Avoid double call to del_hw_fte */
+	fte->node.del_hw_func = NULL;
 }
 
 static void del_sw_fte(struct fs_node *node)
@@ -2265,8 +2267,6 @@ void mlx5_del_flow_rules(struct mlx5_flow_handle *handle)
 		tree_remove_node(&handle->rule[i]->node, true);
 	if (list_empty(&fte->node.children)) {
 		fte->node.del_hw_func(&fte->node);
-		/* Avoid double call to del_hw_fte */
-		fte->node.del_hw_func = NULL;
 		up_write_ref_node(&fte->node, false);
 		tree_put_node(&fte->node, false);
 	} else if (fte->dests_size) {
-- 
2.46.0


