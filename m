Return-Path: <netdev+bounces-279676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAKPJAHf5Wl8owEAu9opvQ
	(envelope-from <netdev+bounces-279676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57051428029
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05233300FA1B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7E386426;
	Mon, 20 Apr 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5cAo5JV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8302F3859F7
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672491; cv=none; b=Y0JwNNq+Tsd5oogUnDFU072t4vnfU6Kr2yVdXV9Sk/xpYDhmXhpcf2yX+EJ1oHSDVrX5retiN4QCCrxd5GTpL2BzmAW4K7Cw3qfe4iEW0HK+HLjxe/f7hVJHYSWfw9jYJAMr1/llJkK0vd/prFhSK1nzAzv55w1ZiHzs/k3owyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672491; c=relaxed/simple;
	bh=topljgtv1QUKQr9gAQktFewd+50qP9U7HbRk/au7sXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsmmQZBR42URMs9d/B38tHggDacnOH0Q1TmCax6DSjpiUxp37DPDb9Xo1nEgb9wYB0JrJ9gUSXvycAcjUY22l46VZUQdP7ZB0nCat/r63VlUAU/S/IGWRmPCVd5XzOne5IQsE8NFTG3oWbP5vBXO9Jf1eEmwgdZMEj+yh9w9e4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5cAo5JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2935C19425;
	Mon, 20 Apr 2026 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776672491;
	bh=topljgtv1QUKQr9gAQktFewd+50qP9U7HbRk/au7sXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=u5cAo5JVB95nnlODY/NPvD2OYvMLUFT7sL5+TooWNY+BZsw0wTX96X7xBqPBLSA90
	 zWFUxnh23MeUU0IpAnede5IgnX4g4EXgbL3/hDB1TF8Rd0GIwgq/6MPgrCWl00fyR0
	 5kOIcWerO7WtvCR23zKw3GrTsJ++ZkZP3flm0vT5iKNzUy+7xK6T0JP/OuQRkxVycJ
	 wVOcffyYoW4/38LYWCWzsw5Mfuqf25oPy8Fh51+rIaOslIA+XmmCBpme2O2C/seZ7h
	 4wWmdU5wwebXnLaX13TJNJb52H1/wteBGSEqBKlqmipLqEpyOOSg9WN3yd3LvQ2bwC
	 qLONGq4BOnMWw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 20 Apr 2026 10:07:48 +0200
Subject: [PATCH net v2 2/2] net: airoha: Add size check for TX NAPIs in
 airoha_qdma_cleanup()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-airoha_qdma_init_rx_queue-fix-v2-2-d99347e5c18d@kernel.org>
References: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
In-Reply-To: <20260420-airoha_qdma_init_rx_queue-fix-v2-0-d99347e5c18d@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279676-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57051428029
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If airoha_qdma_init routine fails before airoha_qdma_tx_irq_init() runs
successfully for all TX NAPIs, airoha_qdma_cleanup() will
unconditionally runs netif_napi_del() on TX NAPIs, triggering a NULL
pointer dereference. Fix the issue relying on q_tx_irq size value to
check if the TX NAPIs is properly initialized in airoha_qdma_cleanup().
Moreover, run netif_napi_add_tx() just if irq_q queue is properly
allocated.

Fixes: 23020f049327 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index fc79c456743c..fd8c4f817d85 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -996,8 +996,6 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 	struct airoha_eth *eth = qdma->eth;
 	dma_addr_t dma_addr;
 
-	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
-			  airoha_qdma_tx_napi_poll);
 	irq_q->q = dmam_alloc_coherent(eth->dev, size * sizeof(u32),
 				       &dma_addr, GFP_KERNEL);
 	if (!irq_q->q)
@@ -1007,6 +1005,9 @@ static int airoha_qdma_tx_irq_init(struct airoha_tx_irq_queue *irq_q,
 	irq_q->size = size;
 	irq_q->qdma = qdma;
 
+	netif_napi_add_tx(eth->napi_dev, &irq_q->napi,
+			  airoha_qdma_tx_napi_poll);
+
 	airoha_qdma_wr(qdma, REG_TX_IRQ_BASE(id), dma_addr);
 	airoha_qdma_rmw(qdma, REG_TX_IRQ_CFG(id), TX_IRQ_DEPTH_MASK,
 			FIELD_PREP(TX_IRQ_DEPTH_MASK, size));
@@ -1398,8 +1399,12 @@ static void airoha_qdma_cleanup(struct airoha_qdma *qdma)
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++)
+	for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
+		if (!qdma->q_tx_irq[i].size)
+			continue;
+
 		netif_napi_del(&qdma->q_tx_irq[i].napi);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(qdma->q_tx); i++) {
 		if (!qdma->q_tx[i].ndesc)

-- 
2.53.0


