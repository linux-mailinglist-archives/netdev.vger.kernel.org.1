Return-Path: <netdev+bounces-14858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D87441F3
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD31C20C36
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3DC174F5;
	Fri, 30 Jun 2023 18:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE11174DE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E03C433C8;
	Fri, 30 Jun 2023 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148948;
	bh=AiOvjIWc6l7HOJCJDI3ZP1yivqFs7OHnrnSUUXcRC8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKg8mO7BdqYJP2RnTNZehh0gS15wQ6OvvKGEAqASsOg7zgwJYW12EnHYh8yapBAHP
	 cNf1ZAOcrY8n8VsdNLs1w3oTma88x+HoBcI+QpL0bWChUz2231QtlxR1yP8lW7HCCv
	 ySnwok/fLG7yGzuNw5uESj+Zdm5YCO0Tr9f0DFuhk+50nAPRPZJ8SiUd2rfl3/VQHQ
	 3DqnRE+BxDXwibrz/3tsrUex2gvINTv8tCWquEFs1N2ztNDxtxF2cyvfCEt5+VExto
	 5sPmTJE4ozk/GT8OQPvkFsrevGGV8/PMYqVHY/yI/MiF5D3C6dW0FvVxBur7z2lI7+
	 tHOIOJl13dsfA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Simon Horman <simon.horman@corigine.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net 2/9] net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
Date: Fri, 30 Jun 2023 11:15:37 -0700
Message-ID: <20230630181544.82958-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630181544.82958-1-saeed@kernel.org>
References: <20230630181544.82958-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchao Shao <shaozhengchao@huawei.com>

The memory pointed to by the fs->any pointer is not freed in the error
path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
Fix by freeing the memory in the error path, thereby making the error path
identical to mlx5e_fs_tt_redirect_any_destroy().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 03cb79adf912..be83ad9db82a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 	err = fs_any_create_table(fs);
 	if (err)
-		return err;
+		goto err_free_any;
 
 	err = fs_any_enable(fs);
 	if (err)
@@ -606,8 +606,8 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 err_destroy_table:
 	fs_any_destroy_table(fs_any);
-
-	kfree(fs_any);
+err_free_any:
 	mlx5e_fs_set_any(fs, NULL);
+	kfree(fs_any);
 	return err;
 }
-- 
2.41.0


