Return-Path: <netdev+bounces-280050-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EqBH3s752no5QEAu9opvQ
	(envelope-from <netdev+bounces-280050-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:55:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D06FD438727
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BAF6301F310
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EEF3845B4;
	Tue, 21 Apr 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtgE3DSZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAF399019
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761622; cv=none; b=pFI6ZriAJnMZBa+w9ga4Zl34herQclkNME9jygga3QT/GfoJqqweyx66W0X+/TsLWgdJA8LJ+1rIiSKfRCoq+ZAfKaZp8vKeYUp55cazWJlXjxktIEzTEVdSGqUBGvB7tiQ9HjR7f/Ey+/mDdfKSNeP8UBaz4Ape2/UXn/MKFbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761622; c=relaxed/simple;
	bh=aZT8+RjuUD+glDzBq4Jw2xxfNL/4kIryQSIGXkNI1xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=axH5uXhuLlaCVkaivM4gTlqUgjLCyh8DI/BUws83Ew/kV2g2J1I8RsJ0vp5BCGyaGUdXbG9SW7ixvd9baWwgqJJJm1RRGRQWUCv3C8sPjT8d16EPVOMQz0G0muLYoU5yVwrgzJ/CmXN69bT+cf68CMAswdouwh5eLk3a/9ntDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtgE3DSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1DFC2BCB5;
	Tue, 21 Apr 2026 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761622;
	bh=aZT8+RjuUD+glDzBq4Jw2xxfNL/4kIryQSIGXkNI1xI=;
	h=From:Date:Subject:To:Cc:From;
	b=gtgE3DSZmxbKHqvljeBTE4VkSpsaCQcfqK77jf8BpxOBJu2+QcK+1UCw8KZwAH7X1
	 cjWp8o/bVOL04vJtwowMv5M5XiXfPAt0n9G4JjcyapBl5LjFIaHsWpYldijXROhO5i
	 oRVDl9vQcd8p2yTh8rKvmElBh64sYRjdQohWHX1zBGJ3CVbJSKZlT9IgCIVVhQUZ/x
	 KtOXjgFFtg3ZcamjhkMvXuQES9je+AtuPqLrrtJpNLAv67310o9jhXVY9SzOkNgFPB
	 Mn7+HK9lXOMaLueRs4KZrp1wPFpI3L34+WlRUsqYLfhuTqlNmo3GNUax7uXlehTo5i
	 SyCAnt4583wwQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 21 Apr 2026 10:53:33 +0200
Subject: [PATCH net] net: airoha: Do not wake all netdev TX queues in
 airoha_qdma_wake_netdev_txqs()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-airoha-wake_netdev_txqs-optmization-v1-1-e0be95115d53@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NwQrCMBAFf6Xs2YUm1Ar+ikhZm6ddxKQmoRZL/
 93F4xxmZqOCrCh0bjbKWLRoigbu0NA4SXyANRiTb33fdt6xaE6T8EeeGCJqwDLU9V04zfWlX6n
 mc390Jzeiw00CWWnOuOv6v1zIJLru+w8sfKiDegAAAA==
X-Change-ID: 20260421-airoha-wake_netdev_txqs-optmization-65171ce4ebad
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280050-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D06FD438727
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Do not wake every netdev TX queue across all ports sharing the QDMA
running netif_tx_wake_all_queues routine in airoha_qdma_wake_netdev_txqs()
but only the ones that are mapped the specific QDMA stopped hw TX queue.
This patch can potentially avoid waking already stopped netdev TX queues
that are mapped to a different QDMA hw TX queue.
Introduce airoha_qdma_get_txq utility routine.

Fixes: b94769eb2f30 ("net: airoha: Fix possible TX queue stall in airoha_qdma_tx_napi_poll()")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 19 +++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h |  5 +++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 19f67c7dd8e1..2ca569501045 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -847,13 +847,24 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 {
 	struct airoha_qdma *qdma = q->qdma;
 	struct airoha_eth *eth = qdma->eth;
-	int i;
+	int i, qid = q - &qdma->q_tx[0];
 
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
+		int j;
+
+		if (!port)
+			continue;
 
-		if (port && port->qdma == qdma)
-			netif_tx_wake_all_queues(port->dev);
+		if (port->qdma != qdma)
+			continue;
+
+		for (j = 0; j < port->dev->num_tx_queues; j++) {
+			if (airoha_qdma_get_txq(qdma, j) != qid)
+				continue;
+
+			netif_wake_subqueue(port->dev, j);
+		}
 	}
 	q->txq_stopped = false;
 }
@@ -1965,7 +1976,7 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
 	u16 index;
 	u8 fport;
 
-	qid = skb_get_queue_mapping(skb) % ARRAY_SIZE(qdma->q_tx);
+	qid = airoha_qdma_get_txq(qdma, skb_get_queue_mapping(skb));
 	tag = airoha_get_dsa_tag(skb, dev);
 
 	msg0 = FIELD_PREP(QDMA_ETH_TXMSG_CHAN_MASK,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 87b328cfefb0..c3ea7aadbd82 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -631,6 +631,11 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
 
+static inline u16 airoha_qdma_get_txq(struct airoha_qdma *qdma, u16 qid)
+{
+	return qid % ARRAY_SIZE(qdma->q_tx);
+}
+
 static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
 	/* GDM1 port on EN7581 SoC is connected to the lan dsa switch.

---
base-commit: a663bac71a2f0b3ac6c373168ca57b2a6e6381aa
change-id: 20260421-airoha-wake_netdev_txqs-optmization-65171ce4ebad

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


