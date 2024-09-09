Return-Path: <netdev+bounces-126674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3979722FA
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA79C28480D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3118A6B7;
	Mon,  9 Sep 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwcqleAE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494518A6AF
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911138; cv=none; b=GWnyUEDtY9gC9RQGXyLi/qmb8Az/AIehdtQA0+6CuQwN93YbJp8WobJIpKsrZ+ldZpcJVvzI179YZ9JX+LqFUMDiCWfqBQzGH69DhQSjFHPVRjS32F34Q13j/WpKiTFXusRa454GWHFEPS528vRXWhVd/v2Zo0BmMfRX3+Zd2Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911138; c=relaxed/simple;
	bh=KHMt23UizMB8OooRYadoZ1U9pt5L9vT/aPMWkUPJyOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdD2f+1sH3CsQy5l3UIO9QZukIMikBmoacDSs+fW9JrwdK9ORnrXUe3BpQzydO1jzDjED5voFoLRo3DfYsQAQHSzyQzJCcJzjSKuxa3VuIqTFROXr3NaQDyGWxdiz2M1cpgiRQ3++JRwnd5ojmqm/4Go02NH+RQqhkyPTCpvCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwcqleAE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71246C4CEC5;
	Mon,  9 Sep 2024 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911137;
	bh=KHMt23UizMB8OooRYadoZ1U9pt5L9vT/aPMWkUPJyOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwcqleAE+KQTbXYifckdMmAdbqg7HL8Ytl2g3nSYmTZqmslFNR37we2iq5bcO3hMM
	 os01sq/9MKe8oHroSTq/dIbcjCYqB8HnMPkfWr5ystm/jQgrd+TN/ahoEbMDSnTraf
	 GWiHdWDD436yK56h4VBFwckLtUszHcXWtsUXe8vLaASm86/q3P0aFL72/CL0/fJJES
	 FMo1WTaLXNZ2zyN1ObcE6LQG23IOykUsHrMYhyaPy9PiJBYIgmCBFhxBeJP6MvNHAF
	 PDDgPSQqc9Y7x25ynTNGZciRDDc5OBdqRJgOw3+wI1aPWrVXVNswbraE/SgfmW/TdA
	 JBLlU7Gy0dTWg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net 3/7] net/mlx5e: Add missing link mode to ptys2ext_ethtool_map
Date: Mon,  9 Sep 2024 12:45:01 -0700
Message-ID: <20240909194505.69715-4-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shahar Shitrit <shshitrit@nvidia.com>

Add MLX5E_400GAUI_8_400GBASE_CR8 to the extended modes
in ptys2ext_ethtool_table, since it was missing.

Fixes: 6a897372417e ("net/mlx5: ethtool, Add ethtool support for 50Gbps per lane link modes")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 1e829b97eaac..1cf3c54d343e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -208,6 +208,12 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT,
 				       ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_400GAUI_8_400GBASE_CR8, ext,
+				       ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT,
+				       ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100GAUI_1_100GBASE_CR_KR, ext,
 				       ETHTOOL_LINK_MODE_100000baseKR_Full_BIT,
 				       ETHTOOL_LINK_MODE_100000baseSR_Full_BIT,
-- 
2.46.0


