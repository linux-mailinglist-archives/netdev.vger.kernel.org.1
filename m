Return-Path: <netdev+bounces-272786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI9nKtgCyGnagAUAu9opvQ
	(envelope-from <netdev+bounces-272786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:33:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E222434F2BE
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 17:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A58F0301F794
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482033C18B;
	Sat, 28 Mar 2026 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KJJw8ahx"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030726FA5A
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 16:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774715603; cv=none; b=S+td6yb9shvpjaEMd9Oq3Ba8+dXqdzPlKjENXAwz+/FS0h9aDmxcLuAekZqFEgZ9nut+GGZUQNDlKPut6Oky4ImaO8ZKB4huh5TBDSIT67cq8t4TwOMloLsPuVYpBTg++zWCUbG7mMDMQ8gYK+7nY4rXK2cO+pmwUpmd6qsLj34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774715603; c=relaxed/simple;
	bh=Fq6eHI+AA+1FVZs9j/tF5tTRiJpn5tD7qFqbJjL24RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8nQHgChtLIdWoccI9zX8gLWqQ20HEh6i9lCMZU6zp6JdA0wvLSTFRVu32vmzdXr74GY5CZ5eW1/whkfkG3GJFwX9c8fHvEGg82bb8MWJ8ETMfmX8tgT7DhJ021XExO/YA5u4SQmvKKv6hsfZTIFrcbXxSI3ttW3t19na9mH72o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KJJw8ahx; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774715597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BQAfoUisJ6V0zmjJY8J3so7sKalecxOlLQSbXuTuX9E=;
	b=KJJw8ahx7Jck7gs/XkaQsS2Mh7QMyEdHPanzyPN8WKT2Q2kdk+gWoRd9PxoisgRrh9WFzd
	MeeIfFufbjLj7JfDfzXf22GfRokFsIQSiAgargO2grbpvr9vXwgbURvEP29/6kMTonGArV
	x8TYq/E56UPNMa8Qzm0jwWcKcXpnkH0=
From: Yufan Chen <yufan.chen@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yufan.chen@linux.dev
Subject: [PATCH net v2] net: ftgmac100: fix ring allocation unwind on open failure
Date: Sun, 29 Mar 2026 00:32:57 +0800
Message-ID: <20260328163257.60836-1-yufan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537; i=ericterminal@gmail.com; h=from:subject; bh=Fq6eHI+AA+1FVZs9j/tF5tTRiJpn5tD7qFqbJjL24RM=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWSeYGpJ2uknrZ35KvPcluPf81jsSrq+vO77K+Zz71aLd EXsHB21joksDGJcDJZiiix3/++bm+t1a8517sO5MHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe oZGOgY4xAxenAEy1vQnDP7OZv8QfzDm5aM+1fYw8Jr8/d3zJN+1jnLxEcX5nwXJ58ySGfzp7lk2 yt/y+d+e+wzPV7cN+/lzBkGj/VffNcSWN3CSlNcwA
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272786-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yufan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E222434F2BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ftgmac100_alloc_rings() allocates rx_skbs, tx_skbs, rxdes, txdes, and
rx_scratch in stages. On intermediate failures it returned -ENOMEM
directly, leaking resources allocated earlier in the function.

Rework the failure path to use staged local unwind labels and free
allocated resources in reverse order before returning -ENOMEM. This
matches common netdev allocation cleanup style.

Fixes: d72e01a0430f ("ftgmac100: Use a scratch buffer for failed RX allocations")
Cc: stable@vger.kernel.org
Signed-off-by: Yufan Chen <yufan.chen@linux.dev>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 28 ++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1e91e79c8..6d2fe5c2f 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -977,19 +977,19 @@ static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
 	priv->tx_skbs = kcalloc(MAX_TX_QUEUE_ENTRIES, sizeof(void *),
 				GFP_KERNEL);
 	if (!priv->tx_skbs)
-		return -ENOMEM;
+		goto err_free_rx_skbs;
 
 	/* Allocate descriptors */
 	priv->rxdes = dma_alloc_coherent(priv->dev,
 					 MAX_RX_QUEUE_ENTRIES * sizeof(struct ftgmac100_rxdes),
 					 &priv->rxdes_dma, GFP_KERNEL);
 	if (!priv->rxdes)
-		return -ENOMEM;
+		goto err_free_tx_skbs;
 	priv->txdes = dma_alloc_coherent(priv->dev,
 					 MAX_TX_QUEUE_ENTRIES * sizeof(struct ftgmac100_txdes),
 					 &priv->txdes_dma, GFP_KERNEL);
 	if (!priv->txdes)
-		return -ENOMEM;
+		goto err_free_rxdes;
 
 	/* Allocate scratch packet buffer */
 	priv->rx_scratch = dma_alloc_coherent(priv->dev,
@@ -997,9 +997,29 @@ static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
 					      &priv->rx_scratch_dma,
 					      GFP_KERNEL);
 	if (!priv->rx_scratch)
-		return -ENOMEM;
+		goto err_free_txdes;
 
 	return 0;
+
+err_free_txdes:
+	dma_free_coherent(priv->dev,
+			  MAX_TX_QUEUE_ENTRIES *
+			  sizeof(struct ftgmac100_txdes),
+			  priv->txdes, priv->txdes_dma);
+	priv->txdes = NULL;
+err_free_rxdes:
+	dma_free_coherent(priv->dev,
+			  MAX_RX_QUEUE_ENTRIES *
+			  sizeof(struct ftgmac100_rxdes),
+			  priv->rxdes, priv->rxdes_dma);
+	priv->rxdes = NULL;
+err_free_tx_skbs:
+	kfree(priv->tx_skbs);
+	priv->tx_skbs = NULL;
+err_free_rx_skbs:
+	kfree(priv->rx_skbs);
+	priv->rx_skbs = NULL;
+	return -ENOMEM;
 }
 
 static void ftgmac100_init_rings(struct ftgmac100 *priv)
-- 
2.47.3

