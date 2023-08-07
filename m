Return-Path: <netdev+bounces-25162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93C77313D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D099F1C20968
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3D1805B;
	Mon,  7 Aug 2023 21:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E24C19894
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022A7C433BB;
	Mon,  7 Aug 2023 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443585;
	bh=ptbn7c5citEqnNC50q4CiIz8YiWMaLJIXwSmh9GAhmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4IaQMEU++SeRtFYrXp1f6P4pw/c05ZWrG2CixM1sjWbMCdz25JTviOJdDQ7rlHgA
	 GD7pz+VClRZm4ElSKVXSgxbMkRzNbb1os/5T6X9RNC9hBou5p1s+ZvC2N/Qj/woJGH
	 0iuU2G48rUxnUSBeKQriSWDMOi4/i6QlqENbtUF9fDhZJc51WJ0qnmwotuwj3dwjnk
	 UT7g9UgU+1Mb/wCTAfLiHpFTU4mZiqw+P5/rkL6GYFgQgdBnGIOrc+dNkCCViicytt
	 KYo03bCYZbWmTTevEps9zXPnNl6iSyMOsfiUTo5f3i7RFIJtRwFo7xjaijTXlnac1E
	 1mQPCoqKxF89Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net 10/11] net/mlx5: Reload auxiliary devices in pci error handlers
Date: Mon,  7 Aug 2023 14:26:06 -0700
Message-ID: <20230807212607.50883-11-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

Handling pci errors should fully teardown and load back auxiliary
devices, same as done through mlx5 health recovery flow.

Fixes: 72ed5d5624af ("net/mlx5: Suspend auxiliary devices only in case of PCI device suspend")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index f42abc2ea73c..72ae560a1c68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1989,7 +1989,7 @@ static pci_ers_result_t mlx5_pci_err_detected(struct pci_dev *pdev,
 
 	mlx5_enter_error_state(dev, false);
 	mlx5_error_sw_reset(dev);
-	mlx5_unload_one(dev, true);
+	mlx5_unload_one(dev, false);
 	mlx5_drain_health_wq(dev);
 	mlx5_pci_disable_device(dev);
 
-- 
2.41.0


