Return-Path: <netdev+bounces-196624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89EAD596F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C955317EB7C
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C322BE7BA;
	Wed, 11 Jun 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ujl9WvnD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E272BE7B4
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653997; cv=none; b=F3haIeqyTEghGsKJSPX+/PijRYJqU7wh99gW6kiF7dMMhujlShkFn58c1id5mqnxFD7gUyRS7bB/kqLhWtMYJf3I/XyoLdmUwpT7Bw+/r2X9WhSjtjnJa2Dbl41lFzw4Mfm9WCnV16eWqtX/dOGJuPpJp/8iIhqNueno9lRwmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653997; c=relaxed/simple;
	bh=VEM8v/+kzDKTv9e/yeXXOvuUJWAuFumy8SVWyFQDc2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFwyABTVUoOGP8BnoS9pkwBtKT84foRsSN0Jhwrpvg0n5+Fg4FZvZ34zuYD1LxG46zwmNmLCBzW91jxB1TMhlBI34M+23kVZXMfeEPhyA44M9clpa+Hh/KtLjcYr8CdbsthMS3nsiaw5z5Z+ePrREB4Hadv4FfHmmkcVw6Xt2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ujl9WvnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09C6C4CEF4;
	Wed, 11 Jun 2025 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653997;
	bh=VEM8v/+kzDKTv9e/yeXXOvuUJWAuFumy8SVWyFQDc2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ujl9WvnDLD67hdEF6q7pNevUyJPPOqr1rqZofdIqAdkEkWXHi8o8jctWmJG2acw02
	 Q0fWciZigDjHnclcS701uDjkQO0SjsAq/LdzOTYMOJyNba4RpkRFEko6BIQkVqntEm
	 tlDQE1NwP6rhlI+umAYo8KohlGU0cQf4M4Fgqo4F/9mGUWhlE5EvyIQ1FHrHzxDkVI
	 i2JOGlrQZOjKJYiAhs1k8/HiBP3T8IE+E7X4aXUYqcl1/OT2LQ2zoOBNY+sGp+c30y
	 odKsGpVQ9QgR7hSW8xRCDCOPzwr7v6SLC6UkJoAjM2ybAPLpsJbejr96Y1DaHPgbJF
	 OBxxRlbxQrssg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next 6/9] eth: fbnic: migrate to new RXFH callbacks
Date: Wed, 11 Jun 2025 07:59:46 -0700
Message-ID: <20250611145949.2674086-7-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
References: <20250611145949.2674086-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new rxfh_fields callbacks, instead of de-muxing
the rxnfc calls. The code is moved as we try to declare the functions
in the order ing which they appear in the ops struct.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: kernel-team@meta.com
CC: mohsin.bashr@gmail.com
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 111 +++++++++---------
 1 file changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5c7556c8c4c5..1439d0c88fa6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -531,20 +531,6 @@ static int fbnic_get_rss_hash_idx(u32 flow_type)
 	return -1;
 }
 
-static int
-fbnic_get_rss_hash_opts(struct fbnic_net *fbn, struct ethtool_rxnfc *cmd)
-{
-	int hash_opt_idx = fbnic_get_rss_hash_idx(cmd->flow_type);
-
-	if (hash_opt_idx < 0)
-		return -EINVAL;
-
-	/* Report options from rss_en table in fbn */
-	cmd->data = fbn->rss_flow_hash[hash_opt_idx];
-
-	return 0;
-}
-
 static int fbnic_get_cls_rule_all(struct fbnic_net *fbn,
 				  struct ethtool_rxnfc *cmd,
 				  u32 *rule_locs)
@@ -779,9 +765,6 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 		cmd->data = fbn->num_rx_queues;
 		ret = 0;
 		break;
-	case ETHTOOL_GRXFH:
-		ret = fbnic_get_rss_hash_opts(fbn, cmd);
-		break;
 	case ETHTOOL_GRXCLSRULE:
 		ret = fbnic_get_cls_rule(fbn, cmd);
 		break;
@@ -803,41 +786,6 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	return ret;
 }
 
-#define FBNIC_L2_HASH_OPTIONS \
-	(RXH_L2DA | RXH_DISCARD)
-#define FBNIC_L3_HASH_OPTIONS \
-	(FBNIC_L2_HASH_OPTIONS | RXH_IP_SRC | RXH_IP_DST)
-#define FBNIC_L4_HASH_OPTIONS \
-	(FBNIC_L3_HASH_OPTIONS | RXH_L4_B_0_1 | RXH_L4_B_2_3)
-
-static int
-fbnic_set_rss_hash_opts(struct fbnic_net *fbn, const struct ethtool_rxnfc *cmd)
-{
-	int hash_opt_idx;
-
-	/* Verify the type requested is correct */
-	hash_opt_idx = fbnic_get_rss_hash_idx(cmd->flow_type);
-	if (hash_opt_idx < 0)
-		return -EINVAL;
-
-	/* Verify the fields asked for can actually be assigned based on type */
-	if (cmd->data & ~FBNIC_L4_HASH_OPTIONS ||
-	    (hash_opt_idx > FBNIC_L4_HASH_OPT &&
-	     cmd->data & ~FBNIC_L3_HASH_OPTIONS) ||
-	    (hash_opt_idx > FBNIC_IP_HASH_OPT &&
-	     cmd->data & ~FBNIC_L2_HASH_OPTIONS))
-		return -EINVAL;
-
-	fbn->rss_flow_hash[hash_opt_idx] = cmd->data;
-
-	if (netif_running(fbn->netdev)) {
-		fbnic_rss_reinit(fbn->fbd, fbn);
-		fbnic_write_rules(fbn->fbd);
-	}
-
-	return 0;
-}
-
 static int fbnic_cls_rule_any_loc(struct fbnic_dev *fbd)
 {
 	int i;
@@ -1244,9 +1192,6 @@ static int fbnic_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_SRXFH:
-		ret = fbnic_set_rss_hash_opts(fbn, cmd);
-		break;
 	case ETHTOOL_SRXCLSRLINS:
 		ret = fbnic_set_cls_rule_ins(fbn, cmd);
 		break;
@@ -1346,6 +1291,60 @@ fbnic_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	return 0;
 }
 
+static int
+fbnic_get_rss_hash_opts(struct net_device *netdev,
+			struct ethtool_rxfh_fields *cmd)
+{
+	int hash_opt_idx = fbnic_get_rss_hash_idx(cmd->flow_type);
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (hash_opt_idx < 0)
+		return -EINVAL;
+
+	/* Report options from rss_en table in fbn */
+	cmd->data = fbn->rss_flow_hash[hash_opt_idx];
+
+	return 0;
+}
+
+#define FBNIC_L2_HASH_OPTIONS \
+	(RXH_L2DA | RXH_DISCARD)
+#define FBNIC_L3_HASH_OPTIONS \
+	(FBNIC_L2_HASH_OPTIONS | RXH_IP_SRC | RXH_IP_DST)
+#define FBNIC_L4_HASH_OPTIONS \
+	(FBNIC_L3_HASH_OPTIONS | RXH_L4_B_0_1 | RXH_L4_B_2_3)
+
+static int
+fbnic_set_rss_hash_opts(struct net_device *netdev,
+			const struct ethtool_rxfh_fields *cmd,
+			struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int hash_opt_idx;
+
+	/* Verify the type requested is correct */
+	hash_opt_idx = fbnic_get_rss_hash_idx(cmd->flow_type);
+	if (hash_opt_idx < 0)
+		return -EINVAL;
+
+	/* Verify the fields asked for can actually be assigned based on type */
+	if (cmd->data & ~FBNIC_L4_HASH_OPTIONS ||
+	    (hash_opt_idx > FBNIC_L4_HASH_OPT &&
+	     cmd->data & ~FBNIC_L3_HASH_OPTIONS) ||
+	    (hash_opt_idx > FBNIC_IP_HASH_OPT &&
+	     cmd->data & ~FBNIC_L2_HASH_OPTIONS))
+		return -EINVAL;
+
+	fbn->rss_flow_hash[hash_opt_idx] = cmd->data;
+
+	if (netif_running(fbn->netdev)) {
+		fbnic_rss_reinit(fbn->fbd, fbn);
+		fbnic_write_rules(fbn->fbd);
+	}
+
+	return 0;
+}
+
 static int
 fbnic_modify_rxfh_context(struct net_device *netdev,
 			  struct ethtool_rxfh_context *ctx,
@@ -1633,6 +1632,8 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
 	.get_rxfh		= fbnic_get_rxfh,
 	.set_rxfh		= fbnic_set_rxfh,
+	.get_rxfh_fields	= fbnic_get_rss_hash_opts,
+	.set_rxfh_fields	= fbnic_set_rss_hash_opts,
 	.create_rxfh_context	= fbnic_create_rxfh_context,
 	.modify_rxfh_context	= fbnic_modify_rxfh_context,
 	.remove_rxfh_context	= fbnic_remove_rxfh_context,
-- 
2.49.0


