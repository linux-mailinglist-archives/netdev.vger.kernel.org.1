Return-Path: <netdev+bounces-27496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A9A77C295
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50A21C20B8C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12158101D0;
	Mon, 14 Aug 2023 21:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E474D101F1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A114CC433B7;
	Mon, 14 Aug 2023 21:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049315;
	bh=YeWEjOIGOR9pAOiK4zC2cHT7U00m3qQKNgy+GyS9LPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7tyf2NK4j45I/0j1AGxPpcSaLV3UATh6TOc/MRNLsC6eOKhFrwGprFsZxeCaYkcR
	 RClgbivldj/0p+EUwgrQvlV6o08ksrv//pOhan/gm2t3UbtMCwo+pV+TUPrAS+nyPF
	 TuprhL3QVSAL1Jc9KkAAD+7S0Znwtm/SEWg7vXIKkeblGYWgS32BhfptIfM7bwVDtY
	 gOVZYzJfzh4FoNtsXsVZVdd0xp/mijmIF92ZklcWK5ST5We2XxiKF/yE/iItuwwQRS
	 ppiTxvZ2g1wIuzUZov/Eggvhu3v3x2fV7X4wpOov/wmg+L5Esm7BBAxS5KDUczDKnS
	 39gKq46Nz/gfQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 07/14] net/mlx5: Use auxiliary_device_uninit() instead of device_put()
Date: Mon, 14 Aug 2023 14:41:37 -0700
Message-ID: <20230814214144.159464-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Instead of using device_put(), use auxiliary_device_uninit() for
auxiliary device uninit which internally just calls device_put().

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
index 8e2abbab05f0..b2c849b8c0c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/dev.c
@@ -129,7 +129,7 @@ static void mlx5_sf_dev_add(struct mlx5_core_dev *dev, u16 sf_index, u16 fn_id,
 
 	err = auxiliary_device_add(&sf_dev->adev);
 	if (err) {
-		put_device(&sf_dev->adev.dev);
+		auxiliary_device_uninit(&sf_dev->adev);
 		goto add_err;
 	}
 
-- 
2.41.0


