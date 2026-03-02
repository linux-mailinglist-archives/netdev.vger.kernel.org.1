Return-Path: <netdev+bounces-262628-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIYhICR6pWm6CAYAu9opvQ
	(envelope-from <netdev+bounces-262628-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:53:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BE1D7E45
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 12:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 610FC3009F3D
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 11:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BC83603C3;
	Mon,  2 Mar 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ns/KAICb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mG9WPCkV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3553630B1
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772452365; cv=none; b=D8qV06P3/qXi3V427yekwjK2VRzLckJA7l0+SDUVHDe8Kb9I8yRS0Xus1X75pGL8E3ZGFTS2q1KgLs+aRKl8I/vKOxSw48u/8D2OySsxwPayzNzsNP1MZBFEk7gmxw1AvIT9YQ32SGj0Q305tyM7ZUU+fF/25P4Qif3riMhmuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772452365; c=relaxed/simple;
	bh=fzkGOsJaSG7pdC3P6qMD3l5IXnW5s56LXz4kd1LGXHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2U5gS9MpmWErq6x7RwRWIqKV2S+Kh/6mcmmkkccsWY0yGD2sJhETg01U5KJn9eYMJvI0qXbZQJGfLFnRxjef3N0eZ031F66QuzHIUIUrGbwR+n8IIG6SlThYEbVc8qzeewRT5349MnE1wv0gn2JkcDc++iOpotR1FXZdwTA3Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ns/KAICb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mG9WPCkV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772452363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v6DNV1lh6XKNY9JJjvOyOU3R2E882HVY/i5f6sKTOh4=;
	b=Ns/KAICbDy8WIcdHaNpvAlc65R2+xuxHLZ31Bx22438Lx6ean3CIWnGXLp2o4QmwYTrfYd
	4ccT/dHOBMKuama6Wjxm8NgpxED78pYx8k5Bsd8o9yeTHgXqjT0MqIZN2ULXwuJ+3YIH+N
	pUgcy0gmb9bT4tZK4EfYXb7IfeirJuE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-JRG9Hy-GOWSiGi1pWqDK6Q-1; Mon, 02 Mar 2026 06:52:42 -0500
X-MC-Unique: JRG9Hy-GOWSiGi1pWqDK6Q-1
X-Mimecast-MFC-AGG-ID: JRG9Hy-GOWSiGi1pWqDK6Q_1772452361
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439aa1d898cso1653419f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 03:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772452360; x=1773057160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6DNV1lh6XKNY9JJjvOyOU3R2E882HVY/i5f6sKTOh4=;
        b=mG9WPCkVQ3b0e2mrWWJ3K/CdVqILqua3vRY3hExJ882fBft1kaWBRux5fve0M8Tdk0
         DfgLiPEsHEeIfnoSKRnn1JVgPuBuulSpoOPYvSmHP1+U0vDZycAAa2+H4ULPfve1MXyj
         HZE3AlgITiIFXJu9Xan+CKtIkfvPHRClrVN4iX4+xE0ASgyfZRkabFQNb44XxMt/mhSz
         fTwBNQ/GVzEu6JPnlcNr8fmPpI++6dFwvmyRF2hOgi95n12mzrRD6gKy+6yLrjRFLYIn
         WjMeCFxtowLcVTEJ/NQKBL0d58001syLFVtHxRbhIyuG0Igk72a8T2bsaE8S0dB7g8GV
         bGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772452360; x=1773057160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6DNV1lh6XKNY9JJjvOyOU3R2E882HVY/i5f6sKTOh4=;
        b=AAOvyqpMl8XES7vcaRoUCfMer4HOM64lLulOtq354dAtYi85CtAS3X15QhhutZuWHX
         Ui1ppTRyc9QjLcclm14Jju9C5WFX3MIpmQIUQJFwocSvOAPQ7aVmT7UiUk1JaeKYL/Uj
         YDaXIUh6n6HHtu7HrCb7lpHZvEFs6kPkBNREQRBwMAqvc5fi2Bk3YSO814wPG+S2IHky
         4PRiWCsngiyV3BqGaaMGFp28pfD8iv5yUu9PGyujbnTjJ8KnjkPcInc50NyWSGLrFkdF
         ryb+1toMIkKSP1xo8OW3zW052P11hVXKCF8xwTP+q+tr38fjY+cENTuzhXGeQXyNPxIW
         X2MA==
X-Gm-Message-State: AOJu0YxVnSy/mAtJwEXKcCnBzaEb07g6U2wFQ+otUvjZ+NY2RWpW/9j+
	n+pQ5x752HUtjC/bCaqJNQDNZu4DlGndj7vtpKWbaB8hGureMJT8BkBW+9jktmUSoSMR4L6MorV
	JuzBRegzgkB/HdhfuQdmDs0z+zRgyD5ddwFilfP9eABL5Iq341USThSGtsgldLzTp3EUWw7vzjd
	PIw/8+CATrny7TbXz8duk9FM1oZpAaORotqbkT6E0SCA==
X-Gm-Gg: ATEYQzz8zwiQwCUewe3u6ww7GeLP2o1D8/PTCHMSVIb2OQ0bd5qrsFv2CNlfFlIvpXZ
	6IMurB2HavQSLs57dEz3f04jKZgR7Aeo1ppKVo3d2kVWvL8NRYd6PbSvenTPicpDb1L5/uBT0vl
	7xVOMvYHMPilCZE7EmZ6i+urM/QLHQfTN6cO91jPjHhiGu29bssczkgkR56xE/NRiwLBvk/VIvW
	jcqVvisG6ufvHy0MmbzOuMF3l7ImFHpFd8dYweBNdtynoL2wz3wYJD4cT250VTRpsfsoihNX6Ib
	C+C1huhm5sK5kXpe2zebMA+7jEUOM+My6B+JIM4sROCG1EFu6Ggnm9KwAZHRLU9m/eK6fhkKKCu
	ZT+nFjBkrrvHwVKlNIJZSLx60LfVM8agZ8e3cm0kbTUHBNY4zuHKXD8lDORQ=
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id ffacd0b85a97d-4399dde3046mr21726321f8f.7.1772452360198;
        Mon, 02 Mar 2026 03:52:40 -0800 (PST)
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id ffacd0b85a97d-4399dde3046mr21726252f8f.7.1772452359641;
        Mon, 02 Mar 2026 03:52:39 -0800 (PST)
Received: from localhost (net-93-146-155-42.cust.vodafonedsl.it. [93.146.155.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c765c67sm28795440f8f.32.2026.03.02.03.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:52:37 -0800 (PST)
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
Subject: [PATCH net-next v3 2/8] net: macb: rename rx_skbuff into rx_buff
Date: Mon,  2 Mar 2026 12:52:26 +0100
Message-ID: <20260302115232.1430640-3-pvalerio@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260302115232.1430640-1-pvalerio@redhat.com>
References: <20260302115232.1430640-1-pvalerio@redhat.com>
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
	TAGGED_FROM(0.00)[bounces-262628-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A8BE1D7E45
X-Rspamd-Action: no action

This is a preparation commit as the field in later patches will no
longer accomomdate skbuffs, but more generic frames.

Signed-off-by: Paolo Valerio <pvalerio@redhat.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +-
 drivers/net/ethernet/cadence/macb_main.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 2cb65ec37d44..3b184e9ac771 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1262,7 +1262,7 @@ struct macb_queue {
 	unsigned int		rx_tail;
 	unsigned int		rx_prepared_head;
 	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
+	void			**rx_buff;
 	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 347b510c0c25..fbd4872901c2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1281,7 +1281,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!queue->rx_buff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
 			skb = netdev_alloc_skb(bp->dev, bp->rx_buffer_size);
 			if (unlikely(!skb)) {
@@ -1300,7 +1300,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			queue->rx_buff[entry] = skb;
 
 			if (entry == bp->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
@@ -1403,7 +1403,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = queue->rx_buff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->dev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1412,7 +1412,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		queue->rx_buff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->dev, "gem_rx %u (len %u)\n", entry, len);
@@ -2411,11 +2411,11 @@ static void gem_free_rx_buffers(struct macb *bp)
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		if (!queue->rx_buff)
 			continue;
 
 		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
+			skb = queue->rx_buff[i];
 
 			if (!skb)
 				continue;
@@ -2429,8 +2429,8 @@ static void gem_free_rx_buffers(struct macb *bp)
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(queue->rx_buff);
+		queue->rx_buff = NULL;
 	}
 }
 
@@ -2493,13 +2493,13 @@ static int gem_alloc_rx_buffers(struct macb *bp)
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+		queue->rx_buff = kzalloc(size, GFP_KERNEL);
+		if (!queue->rx_buff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->dev,
-				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   "Allocated %d RX buff entries at %p\n",
+				   bp->rx_ring_size, queue->rx_buff);
 	}
 	return 0;
 }
-- 
2.52.0


