Return-Path: <netdev+bounces-134781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E999B265
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715B81F22B33
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5213DDAA;
	Sat, 12 Oct 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJyrHNWN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B392C95
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728723694; cv=none; b=McqyESEE1D0qMxs02XKhDHZiq7f0BxLBqws9E2UN7r22scpui2fmXO1TwrxZEnLXzUGFlhmsDln4IChRYPGr/q9PmSTuc3gadtySKu9jHbnnIf8FE3ESvnb8PVHsqw1MObl6jV0phnfZOSbYf7kE0SfBwG+e6lh66yT24ceYoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728723694; c=relaxed/simple;
	bh=4MmynX/AysKkMiYdD4/GQzTG1z/a1+Cno9IDU58CJYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JRf8Rs7xsaF2dBkWEWeAqDWw1Yf3eR0IElaRN7QXhL37JhZFc3f0MNt2yRGMYxZBqnrwIhBy9PGkh8KXHfocJcyaHzA825YKoXlqbNtUTdlWQSahFC4VZlu/qtc0Afa2neLmJY8bHYf5YXfPTIBPFaPXVCbKbIU6+Tt3rZ5q9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJyrHNWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C7C4CEC6;
	Sat, 12 Oct 2024 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728723694;
	bh=4MmynX/AysKkMiYdD4/GQzTG1z/a1+Cno9IDU58CJYs=;
	h=From:Date:Subject:To:Cc:From;
	b=sJyrHNWNAeSlanX6hQHbYI24lCB7g8cmmf6Cr5nG3a56lX7y8yXj6i1ovMyynAyx7
	 xG1aW4iO8GLLq/CEDRj0RUb1Xd1nXOPQtoU6vMUrQzxa4BJV2pUkdzYKK3w/3uvfBn
	 K74ZKURNCNgWK7j93kHkxjV1iJDcfcku3vzoN/AqHTcmaTn+bfFowVTtOQZdfcGcHZ
	 gdigfFiAKJfRa7he3sliMYsYOEGxLV6SKV6cSw/K6Y6QqvGRDKhOlj2ruXRzy03qNT
	 9mV8eMRrVQ1NMW8IptDKiCCfkuZGz9/nRF1UakcwTmrxXFrYsmtiBLtKn5/AesinwF
	 TkECnvVpy5FNw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 12 Oct 2024 11:01:11 +0200
Subject: [PATCH net-next v2] net: airoha: Implement BQL support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-en7581-bql-v2-1-4deb4efdb60b@kernel.org>
X-B4-Tracking: v=1; b=H4sIANY6CmcC/23Myw6CMBCF4Vchs7ZmWulFV76HYaEwwETSamsaD
 em7W1m7/E9yvhUSRaYEp2aFSJkTB19D7Rro56ufSPBQGxSqFo8HFOStdlLcnovQWmljRoXWEdT
 DI9LI7w27dLVnTq8QP5ud5W/9y2QppEDT9sOgLaJx5ztFT8s+xAm6UsoXSKZoT6UAAAA=
X-Change-ID: 20240930-en7581-bql-552566f2078e
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, 
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.2

Introduce BQL support in the airoha_eth driver reporting to the kernel
info about tx hw DMA queues in order to avoid bufferbloat and keep the
latency small.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- simplify BQL support and rebase on top of net-next main
- Link to v1: https://lore.kernel.org/r/20240930-en7581-bql-v1-1-064cdd570068@kernel.org
---
 drivers/net/ethernet/mediatek/airoha_eth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/airoha_eth.c b/drivers/net/ethernet/mediatek/airoha_eth.c
index e037f725f6d3505a8b91815ae26322f5d1b8590c..836a957aad77bec972c536567a4ee7d304ac7b52 100644
--- a/drivers/net/ethernet/mediatek/airoha_eth.c
+++ b/drivers/net/ethernet/mediatek/airoha_eth.c
@@ -1709,9 +1709,11 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 			WRITE_ONCE(desc->msg1, 0);
 
 			if (skb) {
+				u16 queue = skb_get_queue_mapping(skb);
 				struct netdev_queue *txq;
 
-				txq = netdev_get_tx_queue(skb->dev, qid);
+				txq = netdev_get_tx_queue(skb->dev, queue);
+				netdev_tx_completed_queue(txq, 1, skb->len);
 				if (netif_tx_queue_stopped(txq) &&
 				    q->ndesc - q->queued >= q->free_thr)
 					netif_tx_wake_queue(txq);
@@ -2487,7 +2489,9 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	q->queued += i;
 
 	skb_tx_timestamp(skb);
-	if (!netdev_xmit_more())
+	netdev_tx_sent_queue(txq, skb->len);
+
+	if (netif_xmit_stopped(txq) || !netdev_xmit_more())
 		airoha_qdma_rmw(qdma, REG_TX_CPU_IDX(qid),
 				TX_RING_CPU_IDX_MASK,
 				FIELD_PREP(TX_RING_CPU_IDX_MASK, q->head));

---
base-commit: c531f2269a53db5cf64b24baf785ccbcda52970f
change-id: 20240930-en7581-bql-552566f2078e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


