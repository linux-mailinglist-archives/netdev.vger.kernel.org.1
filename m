Return-Path: <netdev+bounces-139912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332D39B4978
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 13:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70B7B22CE3
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F795205E2D;
	Tue, 29 Oct 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLeVeK+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FD1DF960
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204260; cv=none; b=rQMNzdUIIzAcW/jgdyLquUi36oBsagpHgqlL/YAq6dlqs2NfZzuowpEuXDoX7DZy1kATTes3cef72Mj7AyYfrakZYsjzo54y5D9NgHOsvNIZYl4rkoNUAm33MvZ7yREf7ESc6tZkU8RLKUKKNgW2LzMxYsjdqwnKszBskEG340g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204260; c=relaxed/simple;
	bh=/LUSzupHcKWrdrfuDausc+liN4esxpnvqcwq3WMS2II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y1mdwS9MezY9HFt+5Gt6mMyrMM0h5a6tEm568hTgXK0k6SbfdWeuNDReZZARZOt0mBDiYG29grvP2qdxqInjojQbwKoqjdkD7CBe1Q6/efY9Ec6yKRju8s5f2C9BF0EbihERMaeCJwHqcHnnyxK3c5/Z5mk8ieBoAxNQMiWn5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLeVeK+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735BAC4CEE3;
	Tue, 29 Oct 2024 12:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730204259;
	bh=/LUSzupHcKWrdrfuDausc+liN4esxpnvqcwq3WMS2II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WLeVeK+M273yJDTn4AI99XG7gGJ6pRCpJSFtfw2UFEs5WXvyE2fMSUP1SCTOqu52z
	 Vhy4yZ+vrjD+EY9GjW25n72BbbQGemvpDTTAPowEYDv5+HPdnxM7upEGncuuiBgH66
	 IkulVWJ7nkBoCJlm5N0TrRduHPJdT4x8WwHFqq3rbvVFHJZzTp0W4dsbGFWGVZ9N6d
	 D3ynPfT6+VuzyN+pXrSIekMUvD5WhkvnG3UkMjRr0GVlAINSrZpkwlK2K1g7toQNaf
	 fOc1LwkwpNQb3gzCwQ/5cKWNYKWrLAgXYx15Ct4eQdvaYCb0MmWnzrN+/xYq03XUFr
	 q/gF9+OAykjiA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 29 Oct 2024 13:17:09 +0100
Subject: [PATCH net-next 1/2] net: airoha: Read completion queue data in
 airoha_qdma_tx_napi_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-airoha-en7581-tx-napi-work-v1-1-96ad1686b946@kernel.org>
References: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
In-Reply-To: <20241029-airoha-en7581-tx-napi-work-v1-0-96ad1686b946@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Mark Lee <Mark-MC.Lee@mediatek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

In order to avoid any possible race, read completion queue head and
pending entry in airoha_qdma_tx_napi_poll routine instead of doing it in
airoha_irq_handler. Remove unused airoha_tx_irq_queue unused fields.
This is a preliminary patch to add Qdisc offload for airoha_eth driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 31 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index f463a505f5babed3e8e53bf62c92290fc94b3525..6cd8901ed38f0640a8a8f72174c120668b364045 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -752,11 +752,9 @@ struct airoha_tx_irq_queue {
 	struct airoha_qdma *qdma;
 
 	struct napi_struct napi;
-	u32 *q;
 
 	int size;
-	int queued;
-	u16 head;
+	u32 *q;
 };
 
 struct airoha_hw_stats {
@@ -1656,25 +1654,31 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
+	int id, done = 0, irq_queued;
 	struct airoha_qdma *qdma;
 	struct airoha_eth *eth;
-	int id, done = 0;
+	u32 status, head;
 
 	irq_q = container_of(napi, struct airoha_tx_irq_queue, napi);
 	qdma = irq_q->qdma;
 	id = irq_q - &qdma->q_tx_irq[0];
 	eth = qdma->eth;
 
-	while (irq_q->queued > 0 && done < budget) {
-		u32 qid, last, val = irq_q->q[irq_q->head];
+	status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(id));
+	head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
+	head = head % irq_q->size;
+	irq_queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
+
+	while (irq_queued > 0 && done < budget) {
+		u32 qid, last, val = irq_q->q[head];
 		struct airoha_queue *q;
 
 		if (val == 0xff)
 			break;
 
-		irq_q->q[irq_q->head] = 0xff; /* mark as done */
-		irq_q->head = (irq_q->head + 1) % irq_q->size;
-		irq_q->queued--;
+		irq_q->q[head] = 0xff; /* mark as done */
+		head = (head + 1) % irq_q->size;
+		irq_queued--;
 		done++;
 
 		last = FIELD_GET(IRQ_DESC_IDX_MASK, val);
@@ -2026,20 +2030,11 @@ static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
 
 	if (intr[0] & INT_TX_MASK) {
 		for (i = 0; i < ARRAY_SIZE(qdma->q_tx_irq); i++) {
-			struct airoha_tx_irq_queue *irq_q = &qdma->q_tx_irq[i];
-			u32 status, head;
-
 			if (!(intr[0] & TX_DONE_INT_MASK(i)))
 				continue;
 
 			airoha_qdma_irq_disable(qdma, QDMA_INT_REG_IDX0,
 						TX_DONE_INT_MASK(i));
-
-			status = airoha_qdma_rr(qdma, REG_IRQ_STATUS(i));
-			head = FIELD_GET(IRQ_HEAD_IDX_MASK, status);
-			irq_q->head = head % irq_q->size;
-			irq_q->queued = FIELD_GET(IRQ_ENTRY_LEN_MASK, status);
-
 			napi_schedule(&qdma->q_tx_irq[i].napi);
 		}
 	}

-- 
2.47.0


