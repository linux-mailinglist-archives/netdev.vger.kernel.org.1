Return-Path: <netdev+bounces-272756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBTyM6aex2mSZwUAu9opvQ
	(envelope-from <netdev+bounces-272756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:25:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C7D34DE81
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 10:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837233034B24
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAC92DBF75;
	Sat, 28 Mar 2026 09:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OmM2nbuG"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F82434166B
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774689880; cv=none; b=ucuSw6cj2l4DyxlgKnmGgG7HMBY2bS1tqMEBKb5FPy0vba0o6QMaOPlLIKCDZ0rSztinZnho1F44MiFHuz8VQPoK05M3AUO+/VUHdiok11+psp4TSMFiEyvCBVGDhR+bv1BEneK2OWK5wbzyL4N0xWwn5pBYGv8NfNzXyC6+tHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774689880; c=relaxed/simple;
	bh=NzyrU5zPm0aE7B5Xv/X9tBXqZrUh/Ux/aTbQVo2C6kI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjCCN38xbEjo82QmGFtj/ahlrwJigVD41kM8tKL8QzNJOf4Lot9WyHFZCAdo7dr83yZ04+abY/tCVjwCXBZ7rNMWMQowgBmtuBhRP1cFcYcsvml+QwaHjEl3XBOteJlHvCgKq9GkjIRWi3A32CcS5szTMM0aCcM+Jzg0Bh03fJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OmM2nbuG; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774689877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1cmrkz5W6UykUZpniAtrjuFU7d70RC0nIF5M0anlmZQ=;
	b=OmM2nbuGpixhtFvCZ4RytYBhDEgmm1oxpd+WnC4RS6xOPA0/+4ZCII/P0axwaARlXJsPDc
	wRMsiLwoCGDFokdEc5/PPsW7Fbl28kFx0v4e5qzZpqsyFfngQ8J900Fom0QUBa73Y9SU1L
	Sr5bNojQucHT/eiDGEkkSScAr4dyBdU=
From: Yufan Chen <yufan.chen@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yufan.chen@linux.dev,
	Yufan Chen <ericterminal@gmail.com>
Subject: [PATCH] net/ftgmac100: fix ring allocation unwind leaks on open failure
Date: Sat, 28 Mar 2026 17:24:28 +0800
Message-ID: <20260328092428.75430-1-yufan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2882; i=ericterminal@gmail.com; h=from:subject; bh=U/Fkrvdf6DiDU9bwx1OrsOmxztxIWo5PjRRPWmVxAlk=; b=owGbwMvMwCXWM/dCzeS3H+sZT6slMWQen8Pk+CesaLntKVc1/xlfphsybC2+2y50rXHn5ZPv2 DQT1Q986pjIwiDGxWAppshy9/++ublet+Zc5z6cCzOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq GRrpGOgYM3BxCsBUv9rJ8FcwzmSXh/CT5C7GJ9uLdF/Jp+nH7Kgy89qZKlQStz/s+nRGhokS+k2 pJmf4Q+2P3wnXvmBSZ3R/fZ6fw/oFJrJSb1lyeQA=
X-Developer-Key: i=ericterminal@gmail.com; a=openpgp; fpr=DDFFBE9D6D4ADA9CD70BC36D8C9DD07C93EDF17F
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272756-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yufan.chen@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32C7D34DE81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yufan Chen <ericterminal@gmail.com>

ftgmac100_alloc_rings() allocated rx_skbs, tx_skbs, rxdes, txdes, and rx_scratch in stages but returned directly on any intermediate allocation failure. This left previously allocated objects unreleased and could accumulate leaks across repeated ifup retries under memory pressure.

Switch ftgmac100_alloc_rings() to a centralized goto-based unwind path that calls ftgmac100_free_rings() on failure so partially allocated ring resources are always released before returning -ENOMEM.

Also clear rx_skbs, tx_skbs, and rx_scratch pointers in ftgmac100_free_rings() after freeing. This prevents stale pointers from being reused during later retry failures and keeps ring teardown idempotent.

Signed-off-by: Yufan Chen <ericterminal@gmail.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 1e91e79c8..147300e60 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -946,7 +946,9 @@ static void ftgmac100_free_rings(struct ftgmac100 *priv)
 {
 	/* Free skb arrays */
 	kfree(priv->rx_skbs);
+	priv->rx_skbs = NULL;
 	kfree(priv->tx_skbs);
+	priv->tx_skbs = NULL;
 
 	/* Free descriptors */
 	if (priv->rxdes)
@@ -965,31 +967,34 @@ static void ftgmac100_free_rings(struct ftgmac100 *priv)
 	if (priv->rx_scratch)
 		dma_free_coherent(priv->dev, RX_BUF_SIZE,
 				  priv->rx_scratch, priv->rx_scratch_dma);
+	priv->rx_scratch = NULL;
 }
 
 static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
 {
+	int err = -ENOMEM;
+
 	/* Allocate skb arrays */
 	priv->rx_skbs = kcalloc(MAX_RX_QUEUE_ENTRIES, sizeof(void *),
 				GFP_KERNEL);
 	if (!priv->rx_skbs)
-		return -ENOMEM;
+		goto out;
 	priv->tx_skbs = kcalloc(MAX_TX_QUEUE_ENTRIES, sizeof(void *),
 				GFP_KERNEL);
 	if (!priv->tx_skbs)
-		return -ENOMEM;
+		goto out;
 
 	/* Allocate descriptors */
 	priv->rxdes = dma_alloc_coherent(priv->dev,
 					 MAX_RX_QUEUE_ENTRIES * sizeof(struct ftgmac100_rxdes),
 					 &priv->rxdes_dma, GFP_KERNEL);
 	if (!priv->rxdes)
-		return -ENOMEM;
+		goto out;
 	priv->txdes = dma_alloc_coherent(priv->dev,
 					 MAX_TX_QUEUE_ENTRIES * sizeof(struct ftgmac100_txdes),
 					 &priv->txdes_dma, GFP_KERNEL);
 	if (!priv->txdes)
-		return -ENOMEM;
+		goto out;
 
 	/* Allocate scratch packet buffer */
 	priv->rx_scratch = dma_alloc_coherent(priv->dev,
@@ -997,9 +1002,13 @@ static int ftgmac100_alloc_rings(struct ftgmac100 *priv)
 					      &priv->rx_scratch_dma,
 					      GFP_KERNEL);
 	if (!priv->rx_scratch)
-		return -ENOMEM;
+		goto out;
 
 	return 0;
+
+out:
+	ftgmac100_free_rings(priv);
+	return err;
 }
 
 static void ftgmac100_init_rings(struct ftgmac100 *priv)
-- 
2.47.3


