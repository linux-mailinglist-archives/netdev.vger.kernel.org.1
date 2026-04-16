Return-Path: <netdev+bounces-278953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDpQKpqP4Gl6jwAAu9opvQ
	(envelope-from <netdev+bounces-278953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:28:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AC940B079
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AEFA301F271
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D338A72D;
	Thu, 16 Apr 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMZ+Vgaw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732AC38A716
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324480; cv=none; b=AILRR4q3u25K+tVccKA/qYw1RVbQ2w8bZX2OcU9Z0L7HcXrtO400Ye+yqtz+G1sOtYsb1r47pi9HJaYYbMRJklC9alUPJ7uOZpVel4ALqawYzTbV7fAzrQRTlwW1Iutf8WxIovHhk9LDd48THUeCsa+K1RpNFnn1KQPgJ8oGHm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324480; c=relaxed/simple;
	bh=D7Cxemf7toPxHK5bmLoIZKJO9NzRia6nXorlx/QM1yM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQOawX36K8N9xekQBk7gDGBGkvB+HQ2cmFeQHh3cvkHOK7AI29xdFYh+YepUa/D5N8jYpdnOFdkkbMNW4klobRSoiKYTwWEzTwKkD/Nf/DnRWX99gvHNx9OrwIwDAjYhaM2Z/eGlajdgkjf9DQpDTkctSVMyCLNQzA0qnjKVjAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMZ+Vgaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A3DC2BCAF;
	Thu, 16 Apr 2026 07:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776324480;
	bh=D7Cxemf7toPxHK5bmLoIZKJO9NzRia6nXorlx/QM1yM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pMZ+VgawOTwpxLLbUPzBSsn8UUzFu8NUhlB/JTY2bnilIutmv46GU5hWQ8cvmMtO8
	 z6iUaDDP+oBBhfMj54PT9rIXZa3xaviy9PyJSF1tkDXNEQtFG9cA4Rn5F9q6WiKMc5
	 qwPue8wIX540PNPNXNzvEqrmqvmHfUmXDIcKrIYStq0k4W+nuf1p++/g+wwjKQwZBg
	 W8EaJBZiDfXt/TQO5YbNTYk3H0t46+2iUEUPnsH0Fy/G24KDzTvJ4Suw7MABYgNMa/
	 ew2QjgZFDgoWJLN532YQvd6AjjyCddDGNjzgXvyxqxADvUblD3mvfhUkFeDBuL2QzH
	 TbdpHVzzCbo6w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Apr 2026 09:27:41 +0200
Subject: [PATCH net v3 3/3] net: airoha: Add missing bits in
 airoha_qdma_cleanup_tx_queue()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-3-2b69f5788580@kernel.org>
References: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
In-Reply-To: <20260416-airoha_qdma_cleanup_tx_queue-fix-net-v3-0-2b69f5788580@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278953-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[4.211.64.104.asn.rspamd.com:server fail];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12AC940B079
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Similar to airoha_qdma_cleanup_rx_queue(), reset DMA TX descriptors in
airoha_qdma_cleanup_tx_queue routine. Moreover, reset TX_DMA_IDX to
TX_CPU_IDX to notify the NIC the QDMA TX ring is empty.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index dfe8a0bd2abd..903682e88e89 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1039,12 +1039,15 @@ static int airoha_qdma_init_tx(struct airoha_qdma *qdma)
 
 static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 {
-	struct airoha_eth *eth = q->qdma->eth;
-	int i;
+	struct airoha_qdma *qdma = q->qdma;
+	struct airoha_eth *eth = qdma->eth;
+	int i, qid = q - &qdma->q_tx[0];
+	u16 index = 0;
 
 	spin_lock_bh(&q->lock);
 	for (i = 0; i < q->ndesc; i++) {
 		struct airoha_queue_entry *e = &q->entry[i];
+		struct airoha_qdma_desc *desc = &q->desc[i];
 
 		if (!e->dma_addr)
 			continue;
@@ -1055,8 +1058,33 @@ static void airoha_qdma_cleanup_tx_queue(struct airoha_queue *q)
 		e->dma_addr = 0;
 		e->skb = NULL;
 		list_add_tail(&e->list, &q->tx_list);
+
+		/* Reset DMA descriptor */
+		WRITE_ONCE(desc->ctrl, 0);
+		WRITE_ONCE(desc->addr, 0);
+		WRITE_ONCE(desc->data, 0);
+		WRITE_ONCE(desc->msg0, 0);
+		WRITE_ONCE(desc->msg1, 0);
+		WRITE_ONCE(desc->msg2, 0);
+
 		q->queued--;
 	}
+
+	if (!list_empty(&q->tx_list)) {
+		struct airoha_queue_entry *e;
+
+		e = list_first_entry(&q->tx_list, struct airoha_queue_entry,
+				     list);
+		index = e - q->entry;
+	}
+	/* Set TX_DMA_IDX to TX_CPU_IDX to notify the hw the QDMA TX ring is
+	 * empty.
+	 */
+	airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid), TX_RING_CPU_IDX_MASK,
+			FIELD_PREP(TX_RING_CPU_IDX_MASK, index));
+	airoha_qdma_rmw(qdma, REG_TX_DMA_IDX(qid), TX_RING_DMA_IDX_MASK,
+			FIELD_PREP(TX_RING_DMA_IDX_MASK, index));
+
 	spin_unlock_bh(&q->lock);
 }
 

-- 
2.53.0


