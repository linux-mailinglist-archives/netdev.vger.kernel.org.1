Return-Path: <netdev+bounces-76810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55986EF22
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F981F225E7
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B117757;
	Sat,  2 Mar 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6k7bMCS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB401773E
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364217; cv=none; b=NrP3fyGU86b2msDU2oPjVPck78qJd5+Z258p9sIwUHEQae4nSEFcJlcEECJprODM6ba286mNY7/3RXfd0cbTEvBCHyiqQHv6HYkqx4bmw5MHAHpsYg4r7hufnqPwFfzf7s+7c8aWLTsMmZysDgum+5vybBikkYE2g4i1kSRBRv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364217; c=relaxed/simple;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeCvEBe53QJhv0Wd2Hge+HwLH4tuYTSTJryW3eXQGbfv1WNBJ9yEI5izQNYw5D/+SdXaEIIoOdH+O1B/QZIJf0rIS8/V5n2k2XmDxiDLFzo7YknkIdsTjkCZ08HJ21DzYZ5UrlqstXzn6SuxNAdGfpHsZyLkFS8OM38RvAXWHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6k7bMCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79403C43394;
	Sat,  2 Mar 2024 07:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364216;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6k7bMCSNn97zoGwnmpdvK2KTcvsx1CFS0GY3MrYRsHes5LEvkDRZ1ITOlBxMohOd
	 lVlEp5525x7awBonuxFdgVX+LgsEMbV09DBedvBIn+Ymg0HCtML0CBh+sYlQMknqur
	 BK1wdEwe8fo7HZD9dL+DTJVh9tHgl0eFpc1EH9tJp/AtDdXT/cCUr0UK0SXtHyxqy5
	 RWQ0A2/m59AgiiX/9r2LfezoZWzNDmb1VqAPAstJjpgrOp48l7Z3NLzzic3fJC43rl
	 K7Do0jX/jh9F0hHPFTEDX+lrhTRmg+JqWenbaD6+WrsgP3PTjCqUwh9+zr4zMPLUhp
	 b3CJ/teLGROgQ==
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
	sridhar.samudrala@intel.com,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [net-next V4 14/15] net/mlx5: Enable SD feature
Date: Fri,  1 Mar 2024 23:22:44 -0800
Message-ID: <20240302072246.67920-15-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302072246.67920-1-saeed@kernel.org>
References: <20240302072246.67920-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Have an actual mlx5_sd instance in the core device, and fix the getter
accordingly. This allows SD stuff to flow, the feature becomes supported
only here.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h | 3 ++-
 include/linux/mlx5/driver.h                        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 0810b92b48d0..37d5f445598c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -59,10 +59,11 @@ struct mlx5_sd;
 
 static inline struct mlx5_sd *mlx5_get_sd(struct mlx5_core_dev *dev)
 {
-	return NULL;
+	return dev->sd;
 }
 
 static inline void mlx5_set_sd(struct mlx5_core_dev *dev, struct mlx5_sd *sd)
 {
+	dev->sd = sd;
 }
 #endif
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 41f03b352401..bf9324a31ae9 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -823,6 +823,7 @@ struct mlx5_core_dev {
 	struct blocking_notifier_head macsec_nh;
 #endif
 	u64 num_ipsec_offloads;
+	struct mlx5_sd          *sd;
 };
 
 struct mlx5_db {
-- 
2.44.0


