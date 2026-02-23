Return-Path: <netdev+bounces-260152-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPDlLR+cnGmhJgQAu9opvQ
	(envelope-from <netdev+bounces-260152-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D91717B792
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259C43058314
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B852340285;
	Mon, 23 Feb 2026 18:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKt850e3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cX6qf7Fb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D90341046
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771871251; cv=none; b=Lmq+lsopiU+QAKSHkMFW4+ZwT/othjdfGWNg59ps5HnydYMCT0wXbxH+tqd6yhd9Co8Mq0O9aVgP4LvxNjXRHbMS0Gx2LRNcpAl9QouvC6gjJDW10OQ39ysnHSHcFYlaUwrQM+Iq0rQGTPFcbqUQ8TpURDdUzTT79esSE1pX1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771871251; c=relaxed/simple;
	bh=v6Tki8PIzbQ/piW0KeofRD721izKv89rUV5XRTbhLuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7PD1t7QklGdI5+hgwum1WGgGSQmmNGNDRUErcl6R4ycBrtywnJcZgvzKIwnWjg/cCBM/oeQCWBBa8dt0kNvskP7L8ffQblrcqDkw+fGTPZkv/CyJSpS5MGI03PByXIcn7MDX4MW3kCPMGnq/3siQUrw38cc44Ie+XasjlvCxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKt850e3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cX6qf7Fb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771871248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D8wk5wXgz2pw8tb5Dy+ttn3CgZjKxgIbLtD0Vu9wgr4=;
	b=CKt850e3JCLs9zf2pqKO68geeE2tYrF/kVPQqPu6ygbd0hgB65Rz9zViDU/6jYswUdiFVM
	rZhvYRH7X3iemrqtj7GNoDzIle9EHYq50BBcfW1Ui3Cx+YLy+8XTyXi2CVovynnPyyg/va
	iPWFvEm65xqgyrZnifrQw+ytpn3UtCg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ZwfRIqwwM1K4twkppaaPWg-1; Mon, 23 Feb 2026 13:27:27 -0500
X-MC-Unique: ZwfRIqwwM1K4twkppaaPWg-1
X-Mimecast-MFC-AGG-ID: ZwfRIqwwM1K4twkppaaPWg_1771871247
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4837246211bso49260135e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771871246; x=1772476046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8wk5wXgz2pw8tb5Dy+ttn3CgZjKxgIbLtD0Vu9wgr4=;
        b=cX6qf7Fbm1ua6inTCs9MGU7cxJqwOByMD5UemZ8KnSO732rH0GcBbFpg0GfqTJZPGb
         dDU+re4bdITJQhsBhr+njcKbSmP+GaJF4I8zdyzIxqhLD1P5qsHOaUUGNLLclkz93g9N
         bhk/PQ1DtyPpvJpQzN0P5gvj2ASJe1CHje1NeiPH3+egpJJ+vGzXhtZ5z+RDfGaIOJjC
         lZXHn0kHcAms80SxuqK3ppjYg1zipRws8ecnI3NtJewKmg+xl3qdPkpEIE04LTF0/3HI
         JQgS4JdLOske0QzJNoH+AlXLy42CKPQJr+saJ9N0WjnrsIHoHoFlaU4YQGUlPjyHelLL
         JRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771871246; x=1772476046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D8wk5wXgz2pw8tb5Dy+ttn3CgZjKxgIbLtD0Vu9wgr4=;
        b=eEVZIX6wBj0XSeKLrTaWrizJ1Z7sOAip7IDfPgQi83PkFsGgt1Zhm8WVlKOh9TXHj2
         EEQgRcBUurEHOAfLZHVSrtkI2F4zMQdEuFeCj/+Rsj/MFTRAXejTd3SeFL2KM9aAQLnt
         T+YvI78oWzMTKOjrXZqIP+FWJePeVZ0dfvcMo/eJoHtwYuxZWTDJAcwCb/29uEE6VLey
         qaRrS8mgTFF4sIxq5dqGND49ndVu67aMNSyLl953IE5gC7TGob1956AWF2wYR09J8eqX
         FSGFY98JKbbeMGILR6vORx5qySplHc+AeXPSiYRuIHXo0xrS4ir9ogU/8cfgDKEUaQzN
         19ZQ==
X-Gm-Message-State: AOJu0Yzhloi494LkXtmIn5FSDVO9UOfMm+JVuq88OWOddomK+W34yK/4
	g+a/otiWQRZnrXx5pXwzbLSfsOeam2kr/ocwLdchWz1b3XoSMk9WFhn+GUcg3mSQdWXJ04gB6Bq
	a/lVpNFcTpXYmdO6BEHllTdu9Zw5OXZtK/hIjiP8uRNqm1HxipIbYDntPjAApM3VIsxBABJnTb/
	zHE5vT2oIEYHIr92BvL9FTg3NFjF9qVRhInKiO+gXb5w==
X-Gm-Gg: AZuq6aIfIL/9MrRuBBrAAlLCZdPofDMeZcU72OZKmrPoQ7Xz+PPGJbIYYB7XQBLInOq
	CzJsoyc0KT+oJhV+116oBI61DomySYpOVHKNcegnz6xQwnMHFA2fwGmUmWNNMSJoKXHYIzHm+hy
	UGmvcC1Z3Z6zwHR/8x/ngk3ma2HSksWdQLAPRuJAAVh2yNa1YAXhB7owSJCMgupHUmy+B+PMSIi
	CqT84mKC0Uk5nBXeB6yGl5PL3Cs8+nJRMTX/9HkYoDQAqCSzTRED81/iRK8KEty9bwVYQMqQWGK
	IOwlYZQL+VoDudwcEqNkBqxCbL59P8UHQGAxwBnJY2qxwsiis26j0TyGsAe9mUA3xq2Ah9uXshR
	A3PS+TMdKH0ppTdCVptT3ETJubOcpkJ0lPnBt7asr4zN/QNIJegB4kbK0WIM=
X-Received: by 2002:a05:600c:8b2f:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-483a95fc1c8mr166795705e9.13.1771871245617;
        Mon, 23 Feb 2026 10:27:25 -0800 (PST)
X-Received: by 2002:a05:600c:8b2f:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-483a95fc1c8mr166795135e9.13.1771871245097;
        Mon, 23 Feb 2026 10:27:25 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a8df83bcsm233099925e9.13.2026.02.23.10.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 10:27:22 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 7/8] net: macb: make tx path skb agnostic
Date: Mon, 23 Feb 2026 19:26:31 +0100
Message-ID: <20260223182632.1681809-8-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223182632.1681809-1-pvalerio@redhat.com>
References: <20260223182632.1681809-1-pvalerio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260152-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D91717B792
X-Rspamd-Action: no action

Rename macb_tx_buff member skb to ptr and introduce macb_tx_buff_type
to identify the buffer type macb_tx_buff represents.

This is the last preparatory step for xdp xmit support.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      | 23 +++++++++++-----
 drivers/net/ethernet/cadence/macb_main.c | 35 ++++++++++++++----------
 2 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 4e3cc0e9ea87..67fef88af2c6 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -959,19 +959,28 @@ struct macb_dma_desc_ptp {
 /* Scaled PPM fraction */
 #define PPM_FRACTION	16
 
-/* struct macb_tx_buff - data about an skb which is being transmitted
- * @skb: skb currently being transmitted, only set for the last buffer
- *       of the frame
+enum macb_tx_buff_type {
+	MACB_TYPE_SKB,
+	MACB_TYPE_XDP_TX,
+	MACB_TYPE_XDP_NDO,
+};
+
+/* struct macb_tx_buff - data about an skb or xdp frame which is being
+ * transmitted.
+ * @ptr: pointer to skb or xdp frame being transmitted, only set
+ *        for the last buffer for sk_buff
  * @mapping: DMA address of the skb's fragment buffer
  * @size: size of the DMA mapped buffer
  * @mapped_as_page: true when buffer was mapped with skb_frag_dma_map(),
  *                  false when buffer was mapped with dma_map_single()
+ * @type: type of buffer (MACB_TYPE_SKB, MACB_TYPE_XDP_TX, MACB_TYPE_XDP_NDO)
  */
 struct macb_tx_buff {
-	void			*skb;
-	dma_addr_t		mapping;
-	size_t			size;
-	bool			mapped_as_page;
+	void				*ptr;
+	dma_addr_t			mapping;
+	size_t				size;
+	bool				mapped_as_page;
+	enum macb_tx_buff_type		type;
 };
 
 /* Hardware-collected statistics. Used when updating the network
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f65f976123fd..50646ee90672 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -967,7 +967,8 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int budget)
+static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff,
+			  int budget)
 {
 	if (tx_buff->mapping) {
 		if (tx_buff->mapped_as_page)
@@ -979,9 +980,9 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_buff *tx_buff, int bud
 		tx_buff->mapping = 0;
 	}
 
-	if (tx_buff->skb) {
-		napi_consume_skb(tx_buff->skb, budget);
-		tx_buff->skb = NULL;
+	if (tx_buff->ptr) {
+		napi_consume_skb(tx_buff->ptr, budget);
+		tx_buff->ptr = NULL;
 	}
 }
 
@@ -1068,7 +1069,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		desc = macb_tx_desc(queue, tail);
 		ctrl = desc->ctrl;
 		tx_buff = macb_tx_buff(queue, tail);
-		skb = tx_buff->skb;
+		skb = tx_buff->ptr;
 
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
@@ -1076,7 +1077,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				macb_tx_unmap(bp, tx_buff, 0);
 				tail++;
 				tx_buff = macb_tx_buff(queue, tail);
-				skb = tx_buff->skb;
+				skb = tx_buff->ptr;
 			}
 
 			/* ctrl still refers to the first buffer descriptor
@@ -1204,7 +1205,9 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		/* Process all buffers of the current transmitted frame */
 		for (;; tail++) {
 			tx_buff = macb_tx_buff(queue, tail);
-			skb = tx_buff->skb;
+
+			if (tx_buff->type == MACB_TYPE_SKB)
+				skb = tx_buff->ptr;
 
 			/* First, update TX stats if needed */
 			if (skb) {
@@ -2170,7 +2173,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 			goto dma_error;
 
 		/* Save info to properly release resources */
-		tx_buff->skb = NULL;
+		tx_buff->ptr = NULL;
+		tx_buff->type = MACB_TYPE_SKB;
 		tx_buff->mapping = mapping;
 		tx_buff->size = size;
 		tx_buff->mapped_as_page = false;
@@ -2198,7 +2202,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 				goto dma_error;
 
 			/* Save info to properly release resources */
-			tx_buff->skb = NULL;
+			tx_buff->ptr = NULL;
+			tx_buff->type = MACB_TYPE_SKB;
 			tx_buff->mapping = mapping;
 			tx_buff->size = size;
 			tx_buff->mapped_as_page = true;
@@ -2216,7 +2221,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	}
 
 	/* This is the last buffer of the frame: save socket buffer */
-	tx_buff->skb = skb;
+	tx_buff->ptr = skb;
+	tx_buff->type = MACB_TYPE_SKB;
 
 	/* Update TX ring: update buffer descriptors in reverse order
 	 * to avoid race condition
@@ -5136,8 +5142,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		netif_stop_queue(dev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
+		lp->rm9200_txq[desc].ptr = skb;
 		lp->rm9200_txq[desc].size = skb->len;
+		lp->rm9200_txq[desc].type = MACB_TYPE_SKB;
 		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
 							      skb->len, DMA_TO_DEVICE);
 		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
@@ -5229,9 +5236,9 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			dev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
+		if (lp->rm9200_txq[desc].ptr) {
+			dev_consume_skb_irq(lp->rm9200_txq[desc].ptr);
+			lp->rm9200_txq[desc].ptr = NULL;
 			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
 					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
-- 
2.52.0


