Return-Path: <netdev+bounces-13521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8AC73BECE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883F71C212A9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06810971;
	Fri, 23 Jun 2023 19:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B1D10780
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5117C433C0;
	Fri, 23 Jun 2023 19:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548558;
	bh=LdVQuvHVapaMdRMSV4+kPlipV2u/HQEq7luE8sywjzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VIIlYrN5lf4l9twfDtrOR7HzU7EGlt1DdaOoHYiIc4TMLiZXpxfuDJamzIGqe7sE0
	 LwcauwPgCb/lQ/YFrdv1Dpbr67mhRoTlOtKLGXd2Je+lt+MyaSaPqZizZCC5T8hIPz
	 Ny+Owphuyje18COYtncuoH//je6nOAxiAbz9LEDolgSTfqHFd6rqRKIILEAcX+up6Z
	 D00FzyxMNLc8y+GPynvT4MJHXdmYY21wUrsB2PKJFpFWoSCFT0a5jqQWyGjgRFunL4
	 qqAlsUzH1cb7WsFcBK2cDxnaJRp+86v4mmPzi+IbUS8k5F6O/h2cG/Qv5YFp0EX7h5
	 MQpztIWvVU2FQ==
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
Subject: [net-next V2 04/15] net/mlx5: Fix error code in mlx5_is_reset_now_capable()
Date: Fri, 23 Jun 2023 12:28:56 -0700
Message-ID: <20230623192907.39033-5-saeed@kernel.org>
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


