Return-Path: <netdev+bounces-303732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iikQMGA5RWpb8woAu9opvQ
	(envelope-from <netdev+bounces-303732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:59:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D59B6EF6F4
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 17:59:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="Yhd/Brw+";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303732-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303732-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41669300E249
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 15:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96048C8DA;
	Wed,  1 Jul 2026 15:59:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE43546EF;
	Wed,  1 Jul 2026 15:59:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921558; cv=none; b=VWUPEFaB0K/8zbn0ZS/M9oaqp/hzXa1cUfIyu3lq8AwY84uq2Kf8kBOD8nol+YyQEMOn7kElKjaoJXqMSZYUdfnMCFR4OHNmhUOuZqsvxqKI3pSjDpxo6iqHltJdXWG2l2IgkuRxHnNBWkkSXwo2t6aSyAc6rLFPlNmbWJ+vARY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921558; c=relaxed/simple;
	bh=EVVHUEAGMBiAkNXRvqQ0md7sIb4G+gir1ZkuPwyWUxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyY7C1ru8NFeTk1woVWw0glBKZTMoES6qWRXLDwHNW5z/Txhp5qwJ/xw/Fbvm8tl6yzW0lFnm3cZHTIcVXx6iV78jzC47zHsC037y1LFBDmL1M6G7OW5TfI0cyiqhvC03/f46nI54lN92EWzjZGaWrS3FlvUsRDcZ5423LA8+pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Yhd/Brw+; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DAD681A0DB9;
	Wed,  1 Jul 2026 15:59:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF1F460288;
	Wed,  1 Jul 2026 15:59:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 41DD9104C967F;
	Wed,  1 Jul 2026 17:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782921554; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IrhSpt2aptNeyN+BmWYKYU3AotvUPsK1MLmZ8vMBUas=;
	b=Yhd/Brw+qzMOk/ThPDQ8kuuedq7tNCiVB/g4QuEjKc2Hy79tKEwatAdwgK2RQ6ibECCCvr
	iyEU8+O7VkygKevmkF9rKRI8nSoChxgpHQUA/uZJtfga6/f6CMR/6o+EZ2HNtufaeTUgAS
	w9KvO4S4XhDSQxKMSow5E0Ti5+ZytCyC4jkaBu4LTW0lM61znQUNa0AKNlMYpv0OpcvfGg
	+VraXv61xwa8GFfgmRlckA39eibnCctfuEW2+58mEv5hqEJoAet2Bd3/J5nzQ5wS9u2eV2
	hJJX2BQfs0QggWq9csfMlrlS8uPT/HxiA3vhN3CMIpvHXBJK15zMctbQ/nRikw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 01 Jul 2026 17:59:04 +0200
Subject: [PATCH net-next v3 01/15] net: macb: drop "consistent" from
 alloc/free function names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-macb-context-v3-1-00268d5b1502@bootlin.com>
References: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
In-Reply-To: <20260701-macb-context-v3-0-00268d5b1502@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:theo.lebrun@bootlin.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:richardcochran@gmail.com,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nicolas.ferre@microchip.com,m:claudiu.beznea@tuxon.dev,m:pvalerio@redhat.com,m:nb@tipi-net.de,m:vladimir.kondratiev@mobileye.com,m:gregory.clement@bootlin.com,m:benoit.monin@bootlin.com,m:tawfik.bayouk@mobileye.com,m:thomas.petazzoni@bootlin.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D59B6EF6F4

Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
functions have not been only allocating or freeing consistent memory
mappings.

Rename from macb_alloc_consistent() to macb_alloc() and
       from macb_free_consistent()  to macb_free().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fd282a1700fb..d677a93b9d72 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2646,7 +2646,7 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
 }
 
-static void macb_free_consistent(struct macb *bp)
+static void macb_free(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	struct macb_queue *queue;
@@ -2711,7 +2711,7 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 	return 0;
 }
 
-static int macb_alloc_consistent(struct macb *bp)
+static int macb_alloc(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
@@ -2769,7 +2769,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	return 0;
 
 out_err:
-	macb_free_consistent(bp);
+	macb_free(bp);
 	return -ENOMEM;
 }
 
@@ -3157,7 +3157,7 @@ static int macb_open(struct net_device *dev)
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
 
-	err = macb_alloc_consistent(bp);
+	err = macb_alloc(bp);
 	if (err) {
 		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
@@ -3202,7 +3202,7 @@ static int macb_open(struct net_device *dev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
-	macb_free_consistent(bp);
+	macb_free(bp);
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);
 	return err;
@@ -3235,7 +3235,7 @@ static int macb_close(struct net_device *dev)
 	netif_carrier_off(dev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	macb_free_consistent(bp);
+	macb_free(bp);
 
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);

-- 
2.55.0


