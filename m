Return-Path: <netdev+bounces-40470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1F7C7764
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F9C282BCB
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC503CD07;
	Thu, 12 Oct 2023 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZYfo9in"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D6E3CD02
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52788C433C8;
	Thu, 12 Oct 2023 19:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140392;
	bh=XNFqj2N9WjmdA1DbxaMeEIAMiqbClp2Rg+44LSVkdH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZYfo9inJi5dLRoYmG64JByJ5PKqhXfqnKE1jn6wIl98iJahOo2qZpE6MlKVB7L5k
	 1+v3AhVYH69MiIUZnyiYDBnhhhPWTTE3sauZGTSAUAsXk+dtV3gmNWjPsM+P5UMZBy
	 gZRFUnIQPr16+ulKP/wGBRkfdOucBTcnpywVuIuGm8Nw7VvjXAySOIpxAkSFsVXE8y
	 +t6Jox954nqoT2cGPT1jZJEe1EC+FVUvY9BoILsSTtAlkdjWDknbSaPr0Y2TkvTydU
	 +qsBQuMeDW+oozzSg+mKFxgt/RQqgvyVwUkmsEj6vfeJ+9QcZddP4vmFAzBh8ZJ16S
	 sF9BMxzLuYZFw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net 04/10] net/mlx5: Handle fw tracer change ownership event based on MTRC
Date: Thu, 12 Oct 2023 12:51:21 -0700
Message-ID: <20231012195127.129585-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012195127.129585-1-saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

Currently, whenever fw issues a change ownership event, the PF that owns
the fw tracer drops its ownership directly and the other PFs try to pick
up the ownership via what MTRC register suggests.

In some cases, driver releases the ownership of the tracer and reacquires
it later on. Whenever the driver releases ownership of the tracer, fw
issues a change ownership event. This event can be delayed and come after
driver has reacquired ownership of the tracer. Thus the late event will
trigger the tracer owner PF to release the ownership again and lead to a
scenario where no PF is owning the tracer.

To prevent the scenario described above, when handling a change
ownership event, do not drop ownership of the tracer directly, instead
read the fw MTRC register to retrieve the up-to-date owner of the tracer
and set it accordingly in driver level.

Fixes: f53aaa31cce7 ("net/mlx5: FW tracer, implement tracer logic")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 7c0f2adbea00..ad789349c06e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -848,7 +848,7 @@ static void mlx5_fw_tracer_ownership_change(struct work_struct *work)
 
 	mlx5_core_dbg(tracer->dev, "FWTracer: ownership changed, current=(%d)\n", tracer->owner);
 	if (tracer->owner) {
-		tracer->owner = false;
+		mlx5_fw_tracer_ownership_acquire(tracer);
 		return;
 	}
 
-- 
2.41.0


