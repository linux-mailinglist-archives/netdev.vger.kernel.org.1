Return-Path: <netdev+bounces-47488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D60637EA68B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC671F22BB2
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20F23C060;
	Mon, 13 Nov 2023 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI8eJUDd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7723D992
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC52C433C9;
	Mon, 13 Nov 2023 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699916482;
	bh=nuxlBhuUKTe3LUPoLZrWONHSAdHypwshY0IvsFSl4EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qI8eJUDdw9UT/bB/fczbmn0Kl2h1I3Ll4BCQSD3kEOMfyBkx6QPQXkLaendvlwG8g
	 EEBvkLZj59rq5EZ0Cv0cuDsuUDFfoiCyE8rEh1bLbtAdSOnhk9So0oF1+guzZZeVbs
	 dSL8/rWOXihdr2c8S7E+eEmiojSSlcLAmMyUgsruN+PFqITZmd4iqJqVD3E7JjOz3h
	 FITVJZZ8avtXEyLlNyaMHoTy6m/3y3H1HaZ4or4CZaNv5lDO3cC/77bppcWzwAKO+d
	 BQm3yT1iWVBAIMU4Y5J6oio6yVwYcxb0bJasN2IivzlIYlew9/Wg4n6U97RTEs/eOv
	 3k1h+trVfn6pg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net-next 07/14] net/mlx5e: Access array with enum values instead of magic numbers
Date: Mon, 13 Nov 2023 15:00:44 -0800
Message-ID: <20231113230051.58229-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230051.58229-1-saeed@kernel.org>
References: <20231113230051.58229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gal Pressman <gal@nvidia.com>

Access the headers array using pedit_cmd enum values, and don't assume
anything about their values.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c           | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
index 368a95fa77d3..b14cd62edffc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/act/pedit.c
@@ -48,7 +48,8 @@ mlx5e_tc_act_pedit_parse_action(struct mlx5e_priv *priv,
 				struct pedit_headers_action *hdrs,
 				struct netlink_ext_ack *extack)
 {
-	u8 cmd = (act->id == FLOW_ACTION_MANGLE) ? 0 : 1;
+	u8 cmd = (act->id == FLOW_ACTION_MANGLE) ? TCA_PEDIT_KEY_EX_CMD_SET :
+						   TCA_PEDIT_KEY_EX_CMD_ADD;
 	u8 htype = act->mangle.htype;
 	int err = -EOPNOTSUPP;
 	u32 mask, val, offset;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 25743a7eda26..4e1f339e381f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3195,10 +3195,10 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	headers_c = mlx5e_get_match_headers_criteria(*action_flags, &parse_attr->spec);
 	headers_v = mlx5e_get_match_headers_value(*action_flags, &parse_attr->spec);
 
-	set_masks = &hdrs[0].masks;
-	add_masks = &hdrs[1].masks;
-	set_vals = &hdrs[0].vals;
-	add_vals = &hdrs[1].vals;
+	set_masks = &hdrs[TCA_PEDIT_KEY_EX_CMD_SET].masks;
+	add_masks = &hdrs[TCA_PEDIT_KEY_EX_CMD_ADD].masks;
+	set_vals = &hdrs[TCA_PEDIT_KEY_EX_CMD_SET].vals;
+	add_vals = &hdrs[TCA_PEDIT_KEY_EX_CMD_ADD].vals;
 
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		bool skip;
-- 
2.41.0


