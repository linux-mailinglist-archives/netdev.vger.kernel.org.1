Return-Path: <netdev+bounces-163712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B144EA2B6D6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 00:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08EDD1882D7C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 23:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B9C23AE7A;
	Thu,  6 Feb 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSl9fHYY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A623AE77
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886021; cv=none; b=kCBa22LwlCoIHHs4fX6AXlHGFszhgskf/lVPFXfew6FkMHKgen0yVObSxDq4pj+mYbtl6IN6pgrK1dVWpT1rtRoWEIlGeH2myydelNy2oVc9UrAt9MSqbSZcp4knrXVzJX6Rj/t+XtuSB3HDKPRInUs3JreFcNxkTEwWNbGJr2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886021; c=relaxed/simple;
	bh=tZ3ctjAKX6px5Y74ILxz75nvP+HKEQgBrDUAtv8Lnjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0q15ghL+e2gSBZcnXAAUXcPMJKwns5Y+eHQQvoVZqDhEpNIcu2DYdCTu3VZN/F1dYaXuviIUfZIz88IdF7zNbT2GAOBRnwVt/ZMS9CFi+eHyfCNbCV3YYGwDa3kpNCR8j4iN1yTkBFwN6yZen/S14os/H8osSw4SJGn2Sfee7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSl9fHYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E628C4CEE5;
	Thu,  6 Feb 2025 23:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738886020;
	bh=tZ3ctjAKX6px5Y74ILxz75nvP+HKEQgBrDUAtv8Lnjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSl9fHYYgCwrUGZGaQE5gimmmCW4GwNXANgSkV4MFlx2FBKxbwP2RGv6Suy9gjxsc
	 nhB2XRBNlA8+VqCLYrnSaOhJ1o6OJ4QAKiUnTdOKzgx6kvKaCjPy5gmi7fPrUmdkPk
	 xeNSbF1Pod4SwYOwEHntntr+r5XGcrYjeCNN+xWN2XBigVn5kUdzRkbfNA2TovNnIK
	 +BRHEgU6S2sqn0fQV546IsJybsccQwKqNsFjDDI4OdsuUke/4dp5rDSgYz7tCwjDjq
	 pTkCWbvdgm9ntsbD3iVaSrZa2sx+AoMkH8qDaA97ktgLIm11pFwfm4K4uzaa/9pbig
	 fXnAiRZikFUiA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Daniel Zahka <daniel.zahka@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/7] eth: fbnic: support an additional RSS context
Date: Thu,  6 Feb 2025 15:53:30 -0800
Message-ID: <20250206235334.1425329-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206235334.1425329-1-kuba@kernel.org>
References: <20250206235334.1425329-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Zahka <daniel.zahka@gmail.com>

Add support for an extra RSS context. The device has a primary
and a secondary context.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 20cd9f5f89e2..4d73b405c8b9 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -374,6 +374,61 @@ fbnic_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	return 0;
 }
 
+static int
+fbnic_modify_rxfh_context(struct net_device *netdev,
+			  struct ethtool_rxfh_context *ctx,
+			  const struct ethtool_rxfh_param *rxfh,
+			  struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	const u32 *indir = rxfh->indir;
+	unsigned int changes;
+
+	if (!indir)
+		indir = ethtool_rxfh_context_indir(ctx);
+
+	changes = fbnic_set_indir(fbn, rxfh->rss_context, indir);
+	if (changes && netif_running(netdev))
+		fbnic_rss_reinit_hw(fbn->fbd, fbn);
+
+	return 0;
+}
+
+static int
+fbnic_create_rxfh_context(struct net_device *netdev,
+			  struct ethtool_rxfh_context *ctx,
+			  const struct ethtool_rxfh_param *rxfh,
+			  struct netlink_ext_ack *extack)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (rxfh->hfunc && rxfh->hfunc != ETH_RSS_HASH_TOP) {
+		NL_SET_ERR_MSG_MOD(extack, "RSS hash function not supported");
+		return -EOPNOTSUPP;
+	}
+	ctx->hfunc = ETH_RSS_HASH_TOP;
+
+	if (!rxfh->indir) {
+		u32 *indir = ethtool_rxfh_context_indir(ctx);
+		unsigned int num_rx = fbn->num_rx_queues;
+		unsigned int i;
+
+		for (i = 0; i < FBNIC_RPC_RSS_TBL_SIZE; i++)
+			indir[i] = ethtool_rxfh_indir_default(i, num_rx);
+	}
+
+	return fbnic_modify_rxfh_context(netdev, ctx, rxfh, extack);
+}
+
+static int
+fbnic_remove_rxfh_context(struct net_device *netdev,
+			  struct ethtool_rxfh_context *ctx, u32 rss_context,
+			  struct netlink_ext_ack *extack)
+{
+	/* Nothing to do, contexts are allocated statically */
+	return 0;
+}
+
 static void fbnic_get_channels(struct net_device *netdev,
 			       struct ethtool_channels *ch)
 {
@@ -586,6 +641,7 @@ fbnic_get_eth_mac_stats(struct net_device *netdev,
 }
 
 static const struct ethtool_ops fbnic_ethtool_ops = {
+	.rxfh_max_num_contexts	= FBNIC_RPC_RSS_TBL_COUNT,
 	.get_drvinfo		= fbnic_get_drvinfo,
 	.get_regs_len		= fbnic_get_regs_len,
 	.get_regs		= fbnic_get_regs,
@@ -598,6 +654,9 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
 	.get_rxfh		= fbnic_get_rxfh,
 	.set_rxfh		= fbnic_set_rxfh,
+	.create_rxfh_context	= fbnic_create_rxfh_context,
+	.modify_rxfh_context	= fbnic_modify_rxfh_context,
+	.remove_rxfh_context	= fbnic_remove_rxfh_context,
 	.get_channels		= fbnic_get_channels,
 	.set_channels		= fbnic_set_channels,
 	.get_ts_info		= fbnic_get_ts_info,
-- 
2.48.1


