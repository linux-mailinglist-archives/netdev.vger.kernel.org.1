Return-Path: <netdev+bounces-82123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01688C594
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9207B25635
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998613C3F4;
	Tue, 26 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0xYgd05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA313C80D
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464422; cv=none; b=h016myHZA/gVYS1uUkvv/xRm3MtnGsMGCAUa7zn0y6wW/owb1lF2HIfpAbN5EVsIaphVvbHY8pO6Gw3/9M34jSwJRFe2NfpojYl0TRVEJLNFvyz43IvgriZZfaMaXFYZExcNMglkVbWnuErrPrpHKkaWaTXZ4jhw58+Uyrx+7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464422; c=relaxed/simple;
	bh=ercE3vCJHsDyP0t7JhZIg9P42vJZI0+O+T+p666bpic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxSNlWFx68OsnUvNwp6ykAckRWxC3EstCT3IKsizw7FjNkOQZsfY67IIFHcBFQr3+d6bro+pJb0yphCEsLde8x5mOAP7qh8zOMbK0ymg4lmzid43CspTVY2WZ9P4hLbBNmwqcNcowFLHcUOn4QM0IavqNPvxFdMDJFhIIwWbDiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0xYgd05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9F6C433F1;
	Tue, 26 Mar 2024 14:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464422;
	bh=ercE3vCJHsDyP0t7JhZIg9P42vJZI0+O+T+p666bpic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0xYgd05I1llFXLY6FwWWKmyX1faIVMZpauOTl+27CImtX14FPI19pAz8xBmYo8wn
	 T5CpiTGYCLwOYnFx+PRBprfPcgZI7dDIaLPWrNqRajICamWkMsHyIF1bLm4JpzIFdU
	 jdXxX5PaCk+0TKi+m6Ekpy9LfWn0M0JLjI/mWN9GSUN4RIJ6K6M2p5K06XFEW4Lcza
	 zFFypDKrIb4svGQicPSrfMFT1Whg8ep9GXbb8qlixtHNgo0W5PEwnGmEhngUjQCCJr
	 sLotnKsF3+o+cX6NxA36hXWwr/YVOPk5cZ37S4t4B4HYqQ5zDPJhcXNJJzlimzqMQf
	 JhBrzYsymIyKg==
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
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net 06/10] net/mlx5: RSS, Block changing channels number when RXFH is configured
Date: Tue, 26 Mar 2024 07:46:42 -0700
Message-ID: <20240326144646.2078893-7-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Changing the channels number after configuring the receive
flow hash indirection table may alter the RSS table size.
The previous configuration may no longer be compatible with
the new receive flow hash indirection table.

Block changing the channels number when RXFH is configured.

Fixes: 74a8dadac17e ("net/mlx5e: Preparations for supporting larger number of channels")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index cc51ce16df14..c5a203b5119d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -451,6 +451,17 @@ int mlx5e_ethtool_set_channels(struct mlx5e_priv *priv,
 
 	mutex_lock(&priv->state_lock);
 
+	/* Don't allow changing the number of channels if RXFH was previously configured.
+	 * Changing the channels number after configuring the RXFH may alter the RSS table size,
+	 * the previous configuration may no longer be compatible with the new RSS table.
+	 */
+	if (netif_is_rxfh_configured(priv->netdev)) {
+		err = -EINVAL;
+		netdev_err(priv->netdev, "%s: RXFH is configured, cannot change the number of channels\n",
+			   __func__);
+		goto out;
+	}
+
 	/* Don't allow changing the number of channels if HTB offload is active,
 	 * because the numeration of the QoS SQs will change, while per-queue
 	 * qdiscs are attached.
-- 
2.44.0


