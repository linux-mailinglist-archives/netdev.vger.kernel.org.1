Return-Path: <netdev+bounces-48182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86B7ECD9B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5791C20970
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73167446D4;
	Wed, 15 Nov 2023 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNNYw3Eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D63446CF
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF04C433CA;
	Wed, 15 Nov 2023 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077018;
	bh=nuxlBhuUKTe3LUPoLZrWONHSAdHypwshY0IvsFSl4EE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNNYw3Eh4PwxV5NKeRkjigIyyO1ANzAy+T5Z/wRYHjgpFERr5ADZFqW8f8tPm0ekN
	 wJROR2IMZJ2dwOBf3vQ+sqhKL8ejAG3FWW7sU4s5rwHT2F/6RplFsfuSc23NTCp62x
	 aONHTWSlHcg9e0NCvs56QqRBTOqjiuUxsCV936nhoU8xvJdNWlZajmFrKlCKVeK4+P
	 2aNvC6KN04GsnzGCGI52xWryWL/xlF61j8slGefGH1+GZwwHQfsP+SdkBhLPNOur8I
	 QGk0quf0jzCEoWHcs5ZI1pitQywm5vNb3jzqc8Ama4rzF0ksNFtAPth8WRAEIZKhKN
	 kFmsl7yjDWeSA==
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
Subject: [net-next V2 07/13] net/mlx5e: Access array with enum values instead of magic numbers
Date: Wed, 15 Nov 2023 11:36:43 -0800
Message-ID: <20231115193649.8756-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
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


