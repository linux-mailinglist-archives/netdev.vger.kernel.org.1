Return-Path: <netdev+bounces-57152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C6F812487
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE0E28284B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE122644;
	Thu, 14 Dec 2023 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsMuJX0i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F61376
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D54C433C7;
	Thu, 14 Dec 2023 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517112;
	bh=RMC3vJbPEWt8YUPXlNqDxRkjwzxZehv68rf/shGWCI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SsMuJX0i8/1pIfXRitGExx79DXATRv0YjZWSJHY1O1Py2h3CpGyj3aRFaTKq+T+Eq
	 C5HQ/cjXPYpgxempFGI7yprYttxcG+b3jBuyv62sNDu1yblUiYCt82S+MsTrDc86a5
	 /pndFcQxJ5NtMEL3vEqFYguCreSp9vy47LSfJqZlvv6Z8aOMgC7FuuOjK4gV5As7PM
	 kRZy4gwFuPDER8GvQoH7pYMIpPL+J39aal+KXqXCtzjf49hqWpelMAYI4sWaVx281C
	 VgP266SDCAq6qxo/FqYEcqP9J+yb91JYRMAZpYOFftCJ1xr+N4XBSU4Bki7W7EAY+F
	 8SdzFrL00iy1A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Cruz Zhao <cruzzhao@linux.alibaba.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: [net 03/15] net/mlx5e: fix double free of encap_header
Date: Wed, 13 Dec 2023 17:24:53 -0800
Message-ID: <20231214012505.42666-4-saeed@kernel.org>
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

From: Vlad Buslov <vladbu@nvidia.com>

Cited commit introduced potential double free since encap_header can be
destroyed twice in some cases - once by error cleanup sequence in
mlx5e_tc_tun_{create|update}_header_ipv{4|6}(), once by generic
mlx5e_encap_put() that user calls as a result of getting an error from
tunnel create|update. At the same time the point where e->encap_header is
assigned can't be delayed because the function can still return non-error
code 0 as a result of checking for NUD_VALID flag, which will cause
neighbor update to dereference NULL encap_header.

Fix the issue by:

- Nulling local encap_header variables in
mlx5e_tc_tun_{create|update}_header_ipv{4|6}() to make kfree(encap_header)
call in error cleanup sequence noop after that point.

- Assigning reformat_params.data from e->encap_header instead of local
variable encap_header that was set to NULL pointer by previous step. Also
assign reformat_params.size from e->encap_size for uniformity and in order
to make the code less error-prone in the future.

Fixes: d589e785baf5 ("net/mlx5e: Allow concurrent creation of encap entries")
Reported-by: Dust Li <dust.li@linux.alibaba.com>
Reported-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
Reported-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 00a04fdd756f..8dfb57f712b0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -302,6 +302,7 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 
 	e->encap_size = ipv4_encap_size;
 	e->encap_header = encap_header;
+	encap_header = NULL;
 
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
@@ -313,8 +314,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
 	reformat_params.type = e->reformat_type;
-	reformat_params.size = ipv4_encap_size;
-	reformat_params.data = encap_header;
+	reformat_params.size = e->encap_size;
+	reformat_params.data = e->encap_header;
 	e->pkt_reformat = mlx5_packet_reformat_alloc(priv->mdev, &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
@@ -407,6 +408,7 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	e->encap_size = ipv4_encap_size;
 	kfree(e->encap_header);
 	e->encap_header = encap_header;
+	encap_header = NULL;
 
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
@@ -418,8 +420,8 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
 	reformat_params.type = e->reformat_type;
-	reformat_params.size = ipv4_encap_size;
-	reformat_params.data = encap_header;
+	reformat_params.size = e->encap_size;
+	reformat_params.data = e->encap_header;
 	e->pkt_reformat = mlx5_packet_reformat_alloc(priv->mdev, &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
@@ -570,6 +572,7 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 
 	e->encap_size = ipv6_encap_size;
 	e->encap_header = encap_header;
+	encap_header = NULL;
 
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
@@ -581,8 +584,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
 	reformat_params.type = e->reformat_type;
-	reformat_params.size = ipv6_encap_size;
-	reformat_params.data = encap_header;
+	reformat_params.size = e->encap_size;
+	reformat_params.data = e->encap_header;
 	e->pkt_reformat = mlx5_packet_reformat_alloc(priv->mdev, &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
@@ -674,6 +677,7 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	e->encap_size = ipv6_encap_size;
 	kfree(e->encap_header);
 	e->encap_header = encap_header;
+	encap_header = NULL;
 
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
@@ -685,8 +689,8 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
 	reformat_params.type = e->reformat_type;
-	reformat_params.size = ipv6_encap_size;
-	reformat_params.data = encap_header;
+	reformat_params.size = e->encap_size;
+	reformat_params.data = e->encap_header;
 	e->pkt_reformat = mlx5_packet_reformat_alloc(priv->mdev, &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
-- 
2.43.0


