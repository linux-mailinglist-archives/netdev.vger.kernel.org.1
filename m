Return-Path: <netdev+bounces-44895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DD7DA359
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 00:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9733B1C211A9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C644176D;
	Fri, 27 Oct 2023 22:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmufRQb8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A74176A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 22:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F03C433C8;
	Fri, 27 Oct 2023 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698445226;
	bh=nuxlBhuUKTe3LUPoLZrWONHSAdHypwshY0IvsFSl4EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MmufRQb8kFGabhtZx8BrCg5G29ORfaga6khiq6FzKqWCL3D5kUPRI4KInZq4T/nH6
	 IBFW7UpAvh1c2KEmUSe7SwKzDqOjM/XiTGgIAHdEsr+VBO8WaEVkYGCPnnA4CmipXA
	 bHU/jfvI74NbnB5vpWx5i487ZBvxkm/2b7uAvtL6tHAIzBn+y6f+lgLi/QtddX+9om
	 YskeY3Evii8zkYPbF4zdWkuYH1LRnp34oz8TcF7HtWJOFkgBRaLcynd2lCXGRmAebq
	 rJO7HmYzCyGBqK3eRsDk96SF2RoHmhC4WVuEbZj6KGGxZAODE3ZgZhqaiLi0eaI/db
	 UxGZOBpL4KfNQ==
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
Subject: [net-next 11/11] net/mlx5e: Access array with enum values instead of magic numbers
Date: Fri, 27 Oct 2023 15:20:06 -0700
Message-ID: <20231027222006.115999-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027222006.115999-1-saeed@kernel.org>
References: <20231027222006.115999-1-saeed@kernel.org>
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


