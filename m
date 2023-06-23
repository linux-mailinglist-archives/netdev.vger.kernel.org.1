Return-Path: <netdev+bounces-13533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42D73BEE5
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FAC281D4A
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07930107B2;
	Fri, 23 Jun 2023 19:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F2125A0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDE1C433C8;
	Fri, 23 Jun 2023 19:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548569;
	bh=a3DfA3pEFUrCiTIBstXhFyg0ja2cqiRK6RpSlVthg2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnFu5E9fQZNhqayyr8VBl42ZDiGn03nO191r18pHKCHGM0QFwuLnc7JOpGjDrzMpK
	 E1Ihcq2+eZkvV4zs/ED2DkZpJKL327RmNiTYVtDvwhUUgTjTDjzbmDp1jsKAD/TyZU
	 cs1FCfYJUj6ZAnNPYfdRlmczTVDRsQAWlZZc9E9p8vSuT9FXyuwee22tPWAhP9/OSK
	 Vkt8WJucU+1SMhfrt6XxJCEPZ5CCJxnZ/oYr6jERM9IXCBj2aM/bBwuZNIMk0R+wVB
	 u3U+q1weTsQu7XEBDjD45XFnpFXT3F3wgattMXyNYdwF8pnaLvYbgGVlVKYZEbOz1e
	 licwXV2GZJRTw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next V2 15/15] net/mlx5: Remove pointless vport lookup from mlx5_esw_check_port_type()
Date: Fri, 23 Jun 2023 12:29:07 -0700
Message-ID: <20230623192907.39033-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

As xa_get_mark() returns false in case the entry is not present,
no need to redundantly check if vport is present. Remove the lookup.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index b4e465856127..faec7d7a4400 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1908,12 +1908,6 @@ int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
 
 static bool mlx5_esw_check_port_type(struct mlx5_eswitch *esw, u16 vport_num, xa_mark_t mark)
 {
-	struct mlx5_vport *vport;
-
-	vport = mlx5_eswitch_get_vport(esw, vport_num);
-	if (IS_ERR(vport))
-		return false;
-
 	return xa_get_mark(&esw->vports, vport_num, mark);
 }
 
-- 
2.41.0


