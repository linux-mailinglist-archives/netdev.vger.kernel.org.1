Return-Path: <netdev+bounces-25156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0750773132
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D2D01C20968
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92E17745;
	Mon,  7 Aug 2023 21:26:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15217AA1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEAAC433C9;
	Mon,  7 Aug 2023 21:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443578;
	bh=32H+SFOGjkQzZoSa4CTQjr3UAOc/ko2lldBhq1l87xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJ7z2hXoHY08ki3SRMX5Gc1jk/0So9vZKZNQDmrjIMVoruhhZgdbY/33FHKFRH+OF
	 kNfDTBK4Ekz715khISbwUdyJvIaZnmT3XvlvmHIE6Lsuk9iDP277ECuzQxfA63Ft/F
	 wm4pK6TCEznrBhjEr6WTeWw2Ji15i1xbwnHNsOzLYkVE4kwpMoIHNdfEGICMt7gmsR
	 ujlBeM10TD35jVShUhpOef4E6Co0CzYifIM69GhSafDczHCligHT9COKb4lHpxhnK7
	 UO+b6ye9zVUKm/nqzLGGmjxFALwkgJ+I5QfiSYiBIHb9jmTgurmQ5pRyLDloik5PMy
	 zr4SNsBWTT7Ew==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [net 04/11] net/mlx5: Return correct EC_VF function ID
Date: Mon,  7 Aug 2023 14:26:00 -0700
Message-ID: <20230807212607.50883-5-saeed@kernel.org>
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

From: Daniel Jurgens <danielj@nvidia.com>

The ECVF function ID range is 1..max_ec_vfs. Currently
mlx5_vport_to_func_id returns 0..max_ec_vfs - 1. Which
results in a syndrome when querying the caps with more
recent firmware, or reading incorrect caps with older
firmware that supports EC VFs.

Fixes: 9ac0b128248e ("net/mlx5: Update vport caps query/set for EC VFs")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c4be257c043d..682d3dc00dd1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -361,7 +361,7 @@ static inline bool mlx5_core_is_ec_vf_vport(const struct mlx5_core_dev *dev, u16
 
 static inline int mlx5_vport_to_func_id(const struct mlx5_core_dev *dev, u16 vport, bool ec_vf_func)
 {
-	return ec_vf_func ? vport - mlx5_core_ec_vf_vport_base(dev)
+	return ec_vf_func ? vport - mlx5_core_ec_vf_vport_base(dev) + 1
 			  : vport;
 }
 
-- 
2.41.0


