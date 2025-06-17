Return-Path: <netdev+bounces-198393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE3ADBED2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 03:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046FF3B417F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95911DED63;
	Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMRlW/EX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A11DD9AB
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750124938; cv=none; b=F5goGEBzoGu9AHVaHEOb2KEabWXaVp+qhP0UEghUyo4CCYqVdORv+jZQ7Y306oj4tv3s7A8LuZzIsIHyTuafs9ARn7ckU7lqAfCjP42w6OVWkehb7jj+spmkB9Op/PVXMNx7q5+a8TuN3p3QQBtdnZJOYsh9Qv1ZOXHMwVi+2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750124938; c=relaxed/simple;
	bh=o2HdVt64P6zSejf1UFow3+GSPNMKziBQdRDRJyFNi8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K81cakj6BTec8D1tvyqOVh4qfat6ikhDmdHjf2YoXNST09rlWe6bKXors8a5q0IUfT4DaXOlS7+SOji7tTxALlCOFwirj6UcadBmeMC7KzSodY2E+ms2vk16W5/gnb+Mv93M9vIOigTSQaKpoKB+isk3KIBZa7s94Jw8ZgLTmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMRlW/EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307C6C4CEF0;
	Tue, 17 Jun 2025 01:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750124938;
	bh=o2HdVt64P6zSejf1UFow3+GSPNMKziBQdRDRJyFNi8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FMRlW/EXcckovnLnQ0fA6vtMnqOXi70wi+dEIhGfCyHPhJO/741VwgL6OtVqWdTpt
	 +mWf7acih4/YFHEvunO5IGRsDlqtmqavg+v1agntgEvQVXF9vSaFiTrKoB4vfETuY9
	 OWDrKOaEIEcDG4XJrIFyfttzmDNtcDpvnwXwjuz94QmXojevh9uxM8bYfInI6ek7/Y
	 YigidFDbau4ftSRP7SIeyfRX2sDAMwF9qfLALDEq7irn4iDLgrtW/rWq8Sk4zqa0Bl
	 XegGN7GxjVSgwziDkHsN77+N9JLXjxTGmYhpllRiTMm7tGhD17c6BIFxP42SIFkE0Z
	 D8Y5uJRLe4kKA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	madalin.bucur@nxp.com,
	ioana.ciornei@nxp.com,
	marcin.s.wojtas@gmail.com,
	bh74.an@samsung.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 5/5] eth: sxgbe: migrate to new RXFH callbacks
Date: Mon, 16 Jun 2025 18:48:48 -0700
Message-ID: <20250617014848.436741-6-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617014848.436741-1-kuba@kernel.org>
References: <20250617014848.436741-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
add dedicated callbacks for getting and setting rxfh fields").

RXFH is all this driver supports in RXNFC so old callbacks are
completely removed.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../ethernet/samsung/sxgbe/sxgbe_ethtool.c    | 45 +++----------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
index 4a439b34114d..ad73733644f9 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_ethtool.c
@@ -308,8 +308,8 @@ static int sxgbe_set_coalesce(struct net_device *dev,
 	return 0;
 }
 
-static int sxgbe_get_rss_hash_opts(struct sxgbe_priv_data *priv,
-				   struct ethtool_rxnfc *cmd)
+static int sxgbe_get_rxfh_fields(struct net_device *dev,
+				 struct ethtool_rxfh_fields *cmd)
 {
 	cmd->data = 0;
 
@@ -344,26 +344,11 @@ static int sxgbe_get_rss_hash_opts(struct sxgbe_priv_data *priv,
 	return 0;
 }
 
-static int sxgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
-			   u32 *rule_locs)
+static int sxgbe_set_rxfh_fields(struct net_device *dev,
+				 const struct ethtool_rxfh_fields *cmd,
+				 struct netlink_ext_ack *extack)
 {
 	struct sxgbe_priv_data *priv = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXFH:
-		ret = sxgbe_get_rss_hash_opts(priv, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
-static int sxgbe_set_rss_hash_opt(struct sxgbe_priv_data *priv,
-				  struct ethtool_rxnfc *cmd)
-{
 	u32 reg_val = 0;
 
 	/* RSS does not support anything other than hashing
@@ -421,22 +406,6 @@ static int sxgbe_set_rss_hash_opt(struct sxgbe_priv_data *priv,
 	return 0;
 }
 
-static int sxgbe_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
-{
-	struct sxgbe_priv_data *priv = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
-
-	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = sxgbe_set_rss_hash_opt(priv, cmd);
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
 static void sxgbe_get_regs(struct net_device *dev,
 			   struct ethtool_regs *regs, void *space)
 {
@@ -489,8 +458,8 @@ static const struct ethtool_ops sxgbe_ethtool_ops = {
 	.get_channels = sxgbe_get_channels,
 	.get_coalesce = sxgbe_get_coalesce,
 	.set_coalesce = sxgbe_set_coalesce,
-	.get_rxnfc = sxgbe_get_rxnfc,
-	.set_rxnfc = sxgbe_set_rxnfc,
+	.get_rxfh_fields = sxgbe_get_rxfh_fields,
+	.set_rxfh_fields = sxgbe_set_rxfh_fields,
 	.get_regs = sxgbe_get_regs,
 	.get_regs_len = sxgbe_get_regs_len,
 	.get_eee = sxgbe_get_eee,
-- 
2.49.0


