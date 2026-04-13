Return-Path: <netdev+bounces-277986-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA7sErip3GkEUgkAu9opvQ
	(envelope-from <netdev+bounces-277986-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B741F3E9228
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3EA3005D16
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6503A960F;
	Mon, 13 Apr 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVuX+jD0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985513A873E
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069007; cv=none; b=K6hpdCFCfhw4QHFvWqypd5niB4ieGiUTmGPK+HkXUJrdoroX+NimU7yAV64COJOpnCRKSyuH9L8DZMEMLOmbK8QOLk1eZFY9HUklvAmjEjKNahW6UJeSbXSdo6oKzDqfxvOo1Nyr2t5suu2/QP0R64/t4oQB7ke+ZEt6I5oz4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069007; c=relaxed/simple;
	bh=Zmf17Ef7V1/I9+tjQStHwQFn4sJYJNvogny1tDE3r9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=etHVSjGaHJmX8R1sLKPe4Qh+5yBDPn+txwWLMnVRJC7U/9qgllNwAAOYuH2okMgDXC7zCvfDwTbg9FUShAEG3vnASF8j1x+UeON+MOcSGxbos4TljZMpt//oX30+LclyCY/d7YpOJPa86ywwF8oCZsfskYs9I6MNyV2ScswI/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVuX+jD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9525EC116C6;
	Mon, 13 Apr 2026 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776069007;
	bh=Zmf17Ef7V1/I9+tjQStHwQFn4sJYJNvogny1tDE3r9Y=;
	h=From:Date:Subject:To:Cc:From;
	b=PVuX+jD0WGBgtt9stuVLqQgyCRxVxnTKU6VCuQkugMknm9u76hJRSoTp//vGve1Nd
	 wup09DPBMarQ20v2q9/H5/hcBF8VOWWpetWrTN4yLO6QP2S0GKEg/iLriBW8vwX3Uu
	 IFxOj7hFmEPyVUpaxH3ozBV6jKrLfIEFD+uJekw/z9A+Bie58NMcORrWqudIrfNA39
	 O3QlVCyKfAyRcD962bMFt9XwnvGyrFg+00LLJk9iq4QsY6L7P1aLG8v5X0pcssBBxe
	 7OqfJDAljXkiubgKIOSlBjW3oSN6BCKXk2Xc79VF+o3eQOM6ww/P8omZYAH1RN5kHG
	 tkRFS5cEHv8pw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 13 Apr 2026 10:29:49 +0200
Subject: [PATCH net] net: airoha: Fix possible TX queue stall in
 airoha_qdma_tx_napi_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-airoha-txq-potential-stall-v1-1-7830363b1543@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqDMBAA0KvIrDsQY/z1KsXFEKd1ICSaDEUQ7
 97Q5du8Cwpn4QLP5oLMXymSYkX7aMBvFD+MslaDNXYwzoxIktNGqOeBe1KOKhSwKIWAtPbW952
 ZHU9Qgz3zW85//oLICst9/wDuW38ccQAAAA==
X-Change-ID: 20260407-airoha-txq-potential-stall-ad52c53094e8
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277986-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B741F3E9228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since multiple net_device TX queues can share the same hw QDMA TX queue,
there is no guarantee we have inflight packets queued in hw belonging to a
net_device TX queue stopped in the xmit path because hw QDMA TX queue
can be full. In this corner case the net_device TX queue will never be
re-activated. In order to avoid any potential net_device TX queue stall,
we need to wake all the net_device TX queues feeding the same hw QDMA TX
queue in airoha_qdma_tx_napi_poll routine.

Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9e995094c32a..e7610f36b8e4 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -855,6 +855,19 @@ static int airoha_qdma_init_rx(struct airoha_qdma *qdma)
 	return 0;
 }
 
+static void airoha_qdma_wake_tx_queues(struct airoha_qdma *qdma)
+{
+	struct airoha_eth *eth = qdma->eth;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+
+		if (port && port->qdma == qdma)
+			netif_tx_wake_all_queues(port->dev);
+	}
+}
+
 static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct airoha_tx_irq_queue *irq_q;
@@ -931,12 +944,21 @@ static int airoha_qdma_tx_napi_poll(struct napi_struct *napi, int budget)
 
 			txq = netdev_get_tx_queue(skb->dev, queue);
 			netdev_tx_completed_queue(txq, 1, skb->len);
-			if (netif_tx_queue_stopped(txq) &&
-			    q->ndesc - q->queued >= q->free_thr)
-				netif_tx_wake_queue(txq);
-
 			dev_kfree_skb_any(skb);
 		}
+
+		if (q->ndesc - q->queued == q->free_thr) {
+			/* Since multiple net_device TX queues can share the
+			 * same hw QDMA TX queue, there is no guarantee we have
+			 * inflight packets queued in hw belonging to a
+			 * net_device TX queue stopped in the xmit path.
+			 * In order to avoid any potential net_device TX queue
+			 * stall, we need to wake all the net_device TX queues
+			 * feeding the same hw QDMA TX queue.
+			 */
+			airoha_qdma_wake_tx_queues(qdma);
+		}
+
 unlock:
 		spin_unlock_bh(&q->lock);
 	}

---
base-commit: 2dddb34dd0d07b01fa770eca89480a4da4f13153
change-id: 20260407-airoha-txq-potential-stall-ad52c53094e8

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


