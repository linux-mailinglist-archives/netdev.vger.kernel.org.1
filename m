Return-Path: <netdev+bounces-228608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D03BD00A5
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CFE189236E
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5656B2367D6;
	Sun, 12 Oct 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIoQ0XBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E561400C
	for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760260827; cv=none; b=p73Q9WCl/TycTDMR/DzHwioerOb+SJY+3kdYix/ldoBfXKWJwtoIBwKG3tFuqyIYMFYQD6vRpniB4WhV4l/Xkif0mqLjcDOKWEh6BnUdDlc9ilhSfd6Y6WD+J9UYklwITsff6xjqjaZamd1gdhRe++owgH1p6YdpKM7Mfy8ItTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760260827; c=relaxed/simple;
	bh=3DV/u5wjSCtg1WSPlQteng/aS2VViRpDHJXCVKKehVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SSppRAkDBdabHbfxqvX5eFg9lObI5HhixBRPhpfJohkCsmwyHnLB2mVDkm6q07tHq7r77TOM6ysXSwmvahz/2zRrAwbd11q096Pc8lyWdBs+cvgPo4PNg7Std+pVELmyLX/kM4TOJJsDpYnAQ0fUPfLgGoTyCzKv93dvd6h8v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIoQ0XBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1370EC4CEE7;
	Sun, 12 Oct 2025 09:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760260826;
	bh=3DV/u5wjSCtg1WSPlQteng/aS2VViRpDHJXCVKKehVo=;
	h=From:Date:Subject:To:Cc:From;
	b=lIoQ0XBnPfDb39ejCm9t7Ft7oUm2id6K2uOyaSxfR0R/YIHmbv+gz/S4E+TNeiCZC
	 nmVo7/0XGlSQKliLIyrkKNh1byogSLS2jIZKFPdnnJynMHTDChYCFQpscK2HvfHI6Y
	 5YSSM4geEyhrwZQbOEAvvSSTIEyfqP6yHGVRX4PgXF6qMVAAXcFgyW4Upwy3YnGcI4
	 6xHImMKb9V2ERh0lqnaH3EvUfNok9CFF5jZCSL7/KgC3Vvl6xdadEvIYva9VoQ2I4z
	 d7ufZ7hVAK8O6z7VUvzqnWzMfWs3wDRlzb3RVLzUP9ppQIGszhLi3eV0q1xRhXHytg
	 uQN/AGn+koO6Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 12 Oct 2025 11:19:44 +0200
Subject: [PATCH net v2] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251012-airoha-tx-busy-queue-v2-1-a600b08bab2d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK9y62gC/32NQQ6CMBBFr0Jm7ZhOFaOuvIdhUegAE02rUyAQw
 t1tOIDL93/++yskVuEE92IF5UmSxJDBHgpoehc6RvGZwRpbkiGDTjT2DocZ6zEt+B15ZKx9S9R
 wcz2xhzz9KLcy79onBB6gymEvaYi67FcT7dV/60RIeGNybenNhcz58WIN/D5G7aDatu0HAPDQD
 b4AAAA=
X-Change-ID: 20251010-airoha-tx-busy-queue-bdf11cec83ed
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

Completion napi can free out-of-order tx descriptors if hw QoS is
enabled and packets with different priority are queued to same DMA ring.
Take into account possible out-of-order reports checking if the tx queue
is full using circular buffer head/tail pointer instead of the number of
queued packets.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Fix corner case when the queue is full
- Link to v1: https://lore.kernel.org/r/20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..433a646e9831773bf63600e7c3d3b2176c4d133e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1873,6 +1873,20 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
+static bool airoha_dev_tx_queue_busy(struct airoha_queue *q, u32 nr_frags)
+{
+	u32 tail = q->tail <= q->head ? q->tail + q->ndesc : q->tail;
+	u32 index = q->head + nr_frags;
+
+	/* completion napi can free out-of-order tx descriptors if hw QoS is
+	 * enabled and packets with different priorities are queued to the same
+	 * DMA ring. Take into account possible out-of-order reports checking
+	 * if the tx queue is full using circular buffer head/tail pointers
+	 * instead of the number of queued packets.
+	 */
+	return index >= tail;
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -1926,7 +1940,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	txq = netdev_get_tx_queue(dev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
-	if (q->queued + nr_frags > q->ndesc) {
+	if (airoha_dev_tx_queue_busy(q, nr_frags)) {
 		/* not enough space in the queue */
 		netif_tx_stop_queue(txq);
 		spin_unlock_bh(&q->lock);

---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20251010-airoha-tx-busy-queue-bdf11cec83ed

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


