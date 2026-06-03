Return-Path: <netdev+bounces-294558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UuccH8bDH2qApgAAu9opvQ
	(envelope-from <netdev+bounces-294558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:03:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FC46347EA
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 08:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SzKMMwi1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294558-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 814F3303ABCA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 06:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A73F44D3;
	Wed,  3 Jun 2026 06:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD53F54CC;
	Wed,  3 Jun 2026 06:01:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466467; cv=none; b=LMtxi47PDywMNx4Hv8AjP+V9NmoaDu1e1Y7i7MFyodUuhkkDu+cCnzGgx/n9k/hdx6IPxWkhASmZp2hpkWTbMamgoUS7IpqczZZPZwXdGFx9xD16zZt2/2WC0b898SxwrDIThdBh1QIdCCCRAd4sajAe4XTJl0CCvRnbiG7X8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466467; c=relaxed/simple;
	bh=iF9Lxe07CX958qTShZ+aqqxTIfMMIcyELwvLt13GGuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXmAQDs+XRd0cKP9pQf9LKiIzTv/EapRfnx3N8b5KD/nzkU3ixHVK4I5W42ISIVRoWHQILfhtfV8pU47hFSPfSEF3rFPKzemtdcn5UOsXZkLGkONPIk4ZQ9bpMGyBMdwknL19BMebkYQNknONhD0+cLN1QTgVss7dbfV7ZRYGZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzKMMwi1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95801F00893;
	Wed,  3 Jun 2026 06:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780466466;
	bh=iC+uS4ZP82VJD953nLEW4lqTruY47tW/e9JwQJuoejQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SzKMMwi14DTNZkaCzbC0VIpEZc9yCYa+827mhsdpD2H8f3g6BNaLNqnjEfReb/6Gg
	 loj9KrSOFWXRyFc3t2D9fKSZbRBV6VfbzjuluX6gko3cRQ+16HosHWqMAm6lEDvdzu
	 SI6gQ54gYN4zfxpHbdALBwZrvHSBjJ7oG6lSt6nAnXGVZ4PM0vZeDKtfC7QWbNG+Qg
	 c50n99jJqa97kMkxC+FdDOoB8OPZBUjKzjElfvD5ZP/A9hXUwXt6w7bFdTHTUbPXHr
	 5VEOrNlQh1JYE65QJ0fA1OY+1z1JkK9dlVEUZcAcxeMomByM6HxE2rEqiw/7tn2Mim
	 62Y62soBQxq2g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 03 Jun 2026 08:00:16 +0200
Subject: [PATCH net-next v9 2/6] net: airoha: Remove private net_device
 pointer in airoha_gdm_dev struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-airoha-eth-multi-serdes-v9-2-5d476bc2f426@kernel.org>
References: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
In-Reply-To: <20260603-airoha-eth-multi-serdes-v9-0-5d476bc2f426@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 Benjamin Larsson <benjamin.larsson@genexis.eu>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294558-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lorenzo@kernel.org,m:ansuelsmth@gmail.com,m:benjamin.larsson@genexis.eu,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,genexis.eu,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2FC46347EA

Remove redundant net_device pointer inside airoha_gdm_dev struct and
rely on netdev_from_priv routine instead. Please note this patch does
not introduce any logical change, just code refactoring.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 23 ++++++++++++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  1 -
 drivers/net/ethernet/airoha/airoha_ppe.c |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 6574901ebd19..57a16de0a2ec 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -629,7 +629,7 @@ static int airoha_qdma_rx_process(struct airoha_queue *q, int budget)
 		if (!port->dev)
 			goto free_frag;
 
-		netdev = port->dev->dev;
+		netdev = netdev_from_priv(port->dev);
 		if (!q->skb) { /* first buffer */
 			q->skb = napi_build_skb(e->buf - AIROHA_RX_HEADROOM,
 						q->buf_size);
@@ -853,6 +853,7 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 		struct airoha_gdm_dev *dev;
+		struct net_device *netdev;
 		int j;
 
 		if (!port)
@@ -865,11 +866,12 @@ static void airoha_qdma_wake_netdev_txqs(struct airoha_queue *q)
 		if (dev->qdma != qdma)
 			continue;
 
-		for (j = 0; j < dev->dev->num_tx_queues; j++) {
+		netdev = netdev_from_priv(dev);
+		for (j = 0; j < netdev->num_tx_queues; j++) {
 			if (airoha_qdma_get_txq(qdma, j) != qid)
 				continue;
 
-			netif_wake_subqueue(dev->dev, j);
+			netif_wake_subqueue(netdev, j);
 		}
 	}
 	q->txq_stopped = false;
@@ -1867,7 +1869,7 @@ static int airoha_dev_init(struct net_device *netdev)
 
 	/* QDMA0 is used for lan ports while QDMA1 is used for WAN ports */
 	dev->qdma = &eth->qdma[!airoha_is_lan_gdm_dev(dev)];
-	dev->dev->irq = dev->qdma->irq_banks[0].irq;
+	netdev->irq = dev->qdma->irq_banks[0].irq;
 	airoha_set_macaddr(dev, netdev->dev_addr);
 
 	switch (port->id) {
@@ -3038,7 +3040,6 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	}
 
 	dev = netdev_priv(netdev);
-	dev->dev = netdev;
 	dev->port = port;
 	port->dev = dev;
 	dev->eth = eth;
@@ -3101,7 +3102,7 @@ static int airoha_register_gdm_devices(struct airoha_eth *eth)
 		if (!port)
 			continue;
 
-		err = register_netdev(port->dev->dev);
+		err = register_netdev(netdev_from_priv(port->dev));
 		if (err)
 			return err;
 	}
@@ -3216,8 +3217,12 @@ static int airoha_probe(struct platform_device *pdev)
 			continue;
 
 		dev = port->dev;
-		if (dev && dev->dev->reg_state == NETREG_REGISTERED)
-			unregister_netdev(dev->dev);
+		if (dev) {
+			struct net_device *netdev = netdev_from_priv(dev);
+
+			if (netdev->reg_state == NETREG_REGISTERED)
+				unregister_netdev(netdev);
+		}
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
@@ -3245,7 +3250,7 @@ static void airoha_remove(struct platform_device *pdev)
 
 		dev = port->dev;
 		if (dev)
-			unregister_netdev(dev->dev);
+			unregister_netdev(netdev_from_priv(dev));
 		airoha_metadata_dst_free(port);
 	}
 	airoha_hw_cleanup(eth);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fbb50dc73af8..1f162fa1405e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -540,7 +540,6 @@ struct airoha_qdma {
 struct airoha_gdm_dev {
 	struct airoha_gdm_port *port;
 	struct airoha_qdma *qdma;
-	struct net_device *dev;
 	struct airoha_eth *eth;
 
 	DECLARE_BITMAP(qos_sq_bmap, AIROHA_NUM_QOS_CHANNELS);
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 047141b2d6d8..c9711bb7ef1c 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1475,8 +1475,8 @@ void airoha_ppe_check_skb(struct airoha_ppe_dev *dev, struct sk_buff *skb,
 
 void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev)
 {
+	struct net_device *netdev = netdev_from_priv(dev);
 	struct airoha_gdm_port *port = dev->port;
-	struct net_device *netdev = dev->dev;
 	struct airoha_eth *eth = dev->eth;
 	const u8 *addr = netdev->dev_addr;
 	u32 val;

-- 
2.54.0


