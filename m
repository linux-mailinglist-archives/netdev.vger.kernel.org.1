Return-Path: <netdev+bounces-228555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D66BCE120
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 19:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767AF4E1B0B
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2314A21A436;
	Fri, 10 Oct 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNXM0Tqj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299D218AB0
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760116921; cv=none; b=i+q0Ruq3toEK3VYsAv4XuqOvTy867GApK0IIeiwqokLVqCRLMVs8mI3zIYrhDG5rk2cw3+Z+B+rtmxogNnKj1UADakTIqTkCpfqVCwfNQegFK1lVp+RdCRMpokEf53t7gtOvTKIoGraQqgkrhz5X0Qhf7XI4ZqNpQl6E9Cfs+fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760116921; c=relaxed/simple;
	bh=OdBoAtR499cMXnZcUh2ZuDSK7qu4WgMS/ZlAlocCV9M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gopOmNLAq6hX9L3Z/4TDGgQ4HHWnB5xZYjA5Sw58F7/L88PM0AJMMdEn3cbZRT1WljdBakTPeT1w2QLwTG0LNalAf3TKPSDZL92UDWycwZjJHEijePCy8be66ro6i5HVHID3hYDvD3WHg8+Zyuq5cPVpdrciopZLOsjWdg1RXPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNXM0Tqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CD9C4CEF1;
	Fri, 10 Oct 2025 17:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760116920;
	bh=OdBoAtR499cMXnZcUh2ZuDSK7qu4WgMS/ZlAlocCV9M=;
	h=From:Date:Subject:To:Cc:From;
	b=KNXM0Tqj/WkRTA3AroCpsxgUjpqtpfh416eJ3+YwL4J8LbJsCdDe8heXIDVMJpukH
	 lOqnXRhhuyZ0Jc4fY+sPbDmzc06CbKqJuSibwPFb+gY5sXyl2aV40SwhWe3cv6pUrI
	 7+I3KVWlifs27uJeIMevpHAB8EkNAO7+bRoRMpy7aEJI0Thif/RhW/jAZaUPbCAHHr
	 Y3/MYMe40cSuqEv8s4P20TBjH8I2N62P1Ief4gmajt6P3YZJzkOTKvdfbE4XDDU9Aj
	 F+bO4i1F8tx1ZnRiXt2F6ddMagVPgAd/8APm+eEaSXgX0Cn6EpLNk/PbGEj0juW1I/
	 PpdcPgkRbMHqg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 10 Oct 2025 19:21:43 +0200
Subject: [PATCH net] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKZA6WgC/x3MQQqDMBBG4avIrDuQUQriVYqLmPw2s0lqYooi3
 r2hy2/x3kUFWVFo6i7K+GrRFBvk0ZELNr7B6pupN/1TjBi2mlOwvB+81HLyVlHBi19FHNw4wFN
 LPxmrHv/tiyJ2mu/7BwJujplrAAAA
X-Change-ID: 20251010-airoha-tx-busy-queue-bdf11cec83ed
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Completion napi can free out-of-order tx descriptors if hw QoS is
enabled and packets with different priority are queued to same DMA ring.
Take into account possible out-of-order reports checking if the tx queue
is full using circular buffer head/tail pointer instead of the number of
queued packets.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..5e2ff52dba03a7323141fe9860fba52806279bd0 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1873,6 +1873,19 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
 #endif
 }
 
+static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
+{
+	u16 index = (q->head + nr_frags) % q->ndesc;
+
+	/* completion napi can free out-of-order tx descriptors if hw QoS is
+	 * enabled and packets with different priorities are queued to the same
+	 * DMA ring. Take into account possible out-of-order reports checking
+	 * if the tx queue is full using circular buffer head/tail pointers
+	 * instead of the number of queued packets.
+	 */
+	return index >= q->tail && (q->head < q->tail || q->head > index);
+}
+
 static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 				   struct net_device *dev)
 {
@@ -1926,7 +1939,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	txq = netdev_get_tx_queue(dev, qid);
 	nr_frags = 1 + skb_shinfo(skb)->nr_frags;
 
-	if (q->queued + nr_frags > q->ndesc) {
+	if (airoha_dev_is_tx_busy(q, nr_frags)) {
 		/* not enough space in the queue */
 		netif_tx_stop_queue(txq);
 		spin_unlock_bh(&q->lock);

---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20251010-airoha-tx-busy-queue-bdf11cec83ed

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


