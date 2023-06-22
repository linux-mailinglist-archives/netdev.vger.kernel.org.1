Return-Path: <netdev+bounces-12908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1E57396F9
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 07:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C13C1C2101E
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 05:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E4B522B;
	Thu, 22 Jun 2023 05:47:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44292567C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DBC433C0;
	Thu, 22 Jun 2023 05:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687412870;
	bh=LdVQuvHVapaMdRMSV4+kPlipV2u/HQEq7luE8sywjzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=laZWhdNq5HcdUKkIhOjiHvQqVcXkaMAJ2baid3q701m96rOFF5NIf1z8AkQrsCeTI
	 Bs0VwS6+R5IbFyfWVOjMF1oPPgPRqG3LB0lJCwXdFyorILg14s98yNVsQ/l7DGClDo
	 eSoyEM3xbMxNmsQoVJmDBlaztyVr0xy6PMOeaoFvzf542vEQ+hpph6F5dlqFwvJtmB
	 4GM5dd/4CpDnT+bP1sTHruyGj60Lh5qxeWeJmDOJLqLiB7z58mD7cNDjcXaKzIeEXW
	 9ge3PWbeIM+Oct9ggmWYLUbUaBYA9SerLHrysCWPnRIqTF+ARkdmESm31NXWWyds46
	 nJJgz5M0iDxpA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [net-next 04/15] net/mlx5: Fix error code in mlx5_is_reset_now_capable()
Date: Wed, 21 Jun 2023 22:47:24 -0700
Message-ID: <20230622054735.46790-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622054735.46790-1-saeed@kernel.org>
References: <20230622054735.46790-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

The mlx5_is_reset_now_capable() function returns bool, not negative
error codes.  So if fast teardown is not supported it should return
false instead of -EOPNOTSUPP.

Fixes: 92501fa6e421 ("net/mlx5: Ack on sync_reset_request only if PF can do reset_now")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 7af2b14ab5d8..fb7874da3caa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -327,7 +327,7 @@ static bool mlx5_is_reset_now_capable(struct mlx5_core_dev *dev)
 
 	if (!MLX5_CAP_GEN(dev, fast_teardown)) {
 		mlx5_core_warn(dev, "fast teardown is not supported by firmware\n");
-		return -EOPNOTSUPP;
+		return false;
 	}
 
 	err = pci_read_config_word(dev->pdev, PCI_DEVICE_ID, &dev_id);
-- 
2.41.0


