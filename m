Return-Path: <netdev+bounces-153555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977B69F8A47
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35C3163D2F
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 02:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5370805;
	Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrtB6JeS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32016F06B
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 02:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663170; cv=none; b=QUGMqEclCn/+firOM67VE2PqB8mu8Yq9AhyOFU8TG7h7VEzTfaAXGlKQxET9CmHi641rf2mqXaURuFn8GDOmXVI68+D/3x1dGRdnAEIMizPONPPdvT8807bPd7L4DUbVb8iw8fgTDhN7NvRjpHkRRTTDjfMzulfoz01UHre9oEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663170; c=relaxed/simple;
	bh=GyfA62CMUnRIVCXQ9vHcqtG/a6kUvbbQWK/JXDyUP2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=THm+1tvmMGBOrAe+ECSinf/lAeLahRiE3vCy+saGV3G6YcdyMCSY7UqvfkjmkRGeu2TslHlWQKYSYqltiJoEAYUv7l0o+1zwwHQ4cXA4jrF2BslmJhpfWnmqaF0oeZ/FVKLppUQZ02Rg1xeD36H7OvF82WbEwCaiO6yRtw90Jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qrtB6JeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED15DC4CED0;
	Fri, 20 Dec 2024 02:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663170;
	bh=GyfA62CMUnRIVCXQ9vHcqtG/a6kUvbbQWK/JXDyUP2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrtB6JeSpI6cqJvMFcqg/mAZYVxWfwq2PqohIAGGeV1Z8NjUezQmUO1dn7yulBOR0
	 m5EVJcHOju8coskMlZiArwp7QP48v9ulgSaRwDpXMUe3fTXddBXR8j7Defk54zt49v
	 a3+05VfrVv3YyM2lHuWyspgKyT1IIhNw8oGd+DJSvjQj3ytIXsQG31yygU84DVHwBH
	 gmwqXYDdB2rUuuuhvK+YBeIiiYQHP9zmkkyANtf8PfdnnPZpKJnzeLlU/vnpWmQ/eW
	 MhoOczz0x15bcCzeRfNAkpyWL7g5GAS3+il8zqsJ13pLUgOLzZoB1+94B8MFKRayRu
	 1pOi87gL+zITQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 05/10] eth: fbnic: let user control the RSS hash fields
Date: Thu, 19 Dec 2024 18:52:36 -0800
Message-ID: <20241220025241.1522781-6-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220025241.1522781-1-kuba@kernel.org>
References: <20241220025241.1522781-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Duyck <alexanderduyck@fb.com>

Support setting the fields over which RSS computes its hash.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 5523803c8edd..d1be8fc30404 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -167,6 +167,55 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
 	return ret;
 }
 
+#define FBNIC_L2_HASH_OPTIONS \
+	(RXH_L2DA | RXH_DISCARD)
+#define FBNIC_L3_HASH_OPTIONS \
+	(FBNIC_L2_HASH_OPTIONS | RXH_IP_SRC | RXH_IP_DST)
+#define FBNIC_L4_HASH_OPTIONS \
+	(FBNIC_L3_HASH_OPTIONS | RXH_L4_B_0_1 | RXH_L4_B_2_3)
+
+static int
+fbnic_set_rss_hash_opts(struct fbnic_net *fbn, const struct ethtool_rxnfc *cmd)
+{
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
+static int fbnic_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
+{
+	struct fbnic_net *fbn = netdev_priv(netdev);
+	int ret = -EOPNOTSUPP;
+
+	switch (cmd->cmd) {
+	case ETHTOOL_SRXFH:
+		ret = fbnic_set_rss_hash_opts(fbn, cmd);
+		break;
+	}
+
+	return ret;
+}
+
 static u32 fbnic_get_rxfh_key_size(struct net_device *netdev)
 {
 	return FBNIC_RPC_RSS_KEY_BYTE_LEN;
@@ -363,6 +412,7 @@ static const struct ethtool_ops fbnic_ethtool_ops = {
 	.get_ethtool_stats	= fbnic_get_ethtool_stats,
 	.get_sset_count		= fbnic_get_sset_count,
 	.get_rxnfc		= fbnic_get_rxnfc,
+	.set_rxnfc		= fbnic_set_rxnfc,
 	.get_rxfh_key_size	= fbnic_get_rxfh_key_size,
 	.get_rxfh_indir_size	= fbnic_get_rxfh_indir_size,
 	.get_rxfh		= fbnic_get_rxfh,
-- 
2.47.1


