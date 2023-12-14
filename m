Return-Path: <netdev+bounces-57161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB03812490
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5051F212DD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A1481E;
	Thu, 14 Dec 2023 01:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msAgFQl/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9865683
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA0C433C8;
	Thu, 14 Dec 2023 01:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517121;
	bh=sZ1vvZN930ubkRYTOH/Zjoypu1LdE6vr3fijysi4VU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msAgFQl/zWdhq5iOrax7eSxJSbzvMssJ2XBx44jsekORT/NLr+7lKEkwRHnoSYx4L
	 60JyuNGiTfvWSUc2RuWaHPTEXyZ84QnMS1+KgIaWRdSgKcasSJWy8OBkbUjF7Ao1TM
	 ootizzT3wSwxxcohDJ2XvkcV36ECy9crzXEynLC+NN2Z+agRUrW6uFQu/u+LtBxPV0
	 6iNKB/iF87766Kqy/WSsHzrS2ik04fps045ql7KtPciwphdHIRty3ojekc32jUOC/t
	 RMl3/w5Jse/d35llp2Dt3prvA/2KHt8F+6mHinEE6nPaQhCcWmmrTIdGlHddas2h4Z
	 gOryGPCWRSD1Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [net 12/15] net/mlx5e: Fix error code in mlx5e_tc_action_miss_mapping_get()
Date: Wed, 13 Dec 2023 17:25:02 -0800
Message-ID: <20231214012505.42666-13-saeed@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

Preserve the error code if esw_add_restore_rule() fails.  Don't return
success.

Fixes: 6702782845a5 ("net/mlx5e: TC, Set CT miss to the specific ct action instance")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 4809a66f3491..6106bbbe14de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5736,8 +5736,10 @@ int mlx5e_tc_action_miss_mapping_get(struct mlx5e_priv *priv, struct mlx5_flow_a
 
 	esw = priv->mdev->priv.eswitch;
 	attr->act_id_restore_rule = esw_add_restore_rule(esw, *act_miss_mapping);
-	if (IS_ERR(attr->act_id_restore_rule))
+	if (IS_ERR(attr->act_id_restore_rule)) {
+		err = PTR_ERR(attr->act_id_restore_rule);
 		goto err_rule;
+	}
 
 	return 0;
 
-- 
2.43.0


