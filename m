Return-Path: <netdev+bounces-263998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEqBJJB8qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED202206832
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6DD0326A9D3
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4C3DBD74;
	Wed,  4 Mar 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PExWwYIy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E463DA7FC;
	Wed,  4 Mar 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648690; cv=none; b=tkiV+rn9UXM15ga/o6QIvnEoPE23kbwFnLDyPANiFV+AeqL3eXok+sgO8SXmLzQ+SbX51v2bYl7Gfu0ZSlyGt7n3Ofjl1uMySvtE10hDhJnRhSvMKyzh6rLZC357dSqJi19WCqXgK9cf8a9aFbjFfdg4Eof+KtGr8Vg5sMLZZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648690; c=relaxed/simple;
	bh=lR/31OvnWqMELBpLtLx85N3MW+LVO6QwM8QgYOp7nE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AcMzwxXoHTrbX/UTAIJM/xiEEjP22B4a1VsFkEZy3o/QgQ0uT7ZJeh86vnEvAl2CclvR14G9Nmgejg4F0PaO/UI0v1mpE2Pi4nlSzdlU30Eub0FRjqpzIwYPKlIH/wNozsmfWW9MKb4uvm9lUpXbz+O4Vudtq78A5HnQ4fpPmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PExWwYIy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 3A7341A2CB5;
	Wed,  4 Mar 2026 18:24:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0C1125FF5C;
	Wed,  4 Mar 2026 18:24:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37591103695E4;
	Wed,  4 Mar 2026 19:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648684; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RKXDnQhH/EddQZ2g7wQh6dP4jPVhKwjH602UOlRULfw=;
	b=PExWwYIydaVRfi6sme5iJpEVrkn5wpp0eKVa+L+YOanEDC8j0zYgWTO3/hJRvJDBxpQ3Jf
	hxvPPW5eHv+aGDpn4/lSpboPXUXMdk7EcvaPmGUvLsGkcJt/V+ME0zJ5969jW0aFIzkT2i
	I9LnjRI3cx0Wf4QKDs3i3ggHgtUjkU6ta+IsHIxOkR/JGqU2D3SfGKJGmmoxsYacKEoa5S
	FzWqC4dQC8UYa4aHorpGGpctkDzrmh6nTiP19Ht9LrfQd97wTfqgzTeBFBeqRvtTm4dGJI
	AeRjO3LHs8iTKtciDj2qTMh1YllXCDTjuo90h7W5aSXjgxBjXrFrQBu/0T4TFA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 04 Mar 2026 19:24:25 +0100
Subject: [PATCH net-next 2/8] net: macb: account for stats in Rx XDP
 codepaths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-macb-xsk-v1-2-ba2ebe2bdaa3@bootlin.com>
References: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
In-Reply-To: <20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: ED202206832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263998-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

gem_xdp_run() returns an action.
Wrt stats, we land in three different cases:
 - Packet is handed to the stack (XDP_PASS), turns into an SKB and gets
   accounted for below in gem_rx(). No fix here.
 - Packet is dropped (XDP_DROP|ABORTED), we must increment the dropped
   counter. Missing; add it.
 - Packet is passed along (XDP_TX|REDIRECT), we must increment bytes &
   packets counters. Missing; add it.

Along the way, use local variables to store rx_bytes, rx_packets and
rx_dropped. Then increase stats only once at the end of gem_rx(). This
is simpler because all three stats must modified on a per interface and
per queue basis.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ab73d1a522c2..1aa90499343a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1627,6 +1627,7 @@ static u32 gem_xdp_run(struct macb_queue *queue, void *buff_head,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int packets = 0, dropped = 0, bytes = 0;
 	struct skb_shared_info *shinfo;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1669,8 +1670,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (unlikely(!buff_head)) {
 			dev_err_ratelimited(&bp->pdev->dev,
 					    "inconsistent Rx descriptor chain\n");
-			bp->dev->stats.rx_dropped++;
-			queue->stats.rx_dropped++;
+			dropped++;
 			break;
 		}
 
@@ -1700,11 +1700,29 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			if (last_frame) {
 				ret = gem_xdp_run(queue, buff_head, &data_len,
 						  &headroom, addr - gem_rx_pad(bp));
-				if (ret == XDP_REDIRECT)
-					xdp_flush = true;
 
-				if (ret != XDP_PASS)
-					goto next_frame;
+				switch (ret) {
+				/* continue to SKB handling codepath */
+				case XDP_PASS:
+					break;
+
+				/* dropped packet cases */
+				case XDP_ABORTED:
+				case XDP_DROP:
+					dropped++;
+					queue->rx_buff[entry] = NULL;
+					continue;
+
+				/* redirect/tx cases */
+				case XDP_REDIRECT:
+					xdp_flush = true;
+					fallthrough;
+				case XDP_TX:
+					packets++;
+					bytes += data_len;
+					queue->rx_buff[entry] = NULL;
+					continue;
+				}
 			}
 
 			queue->skb = napi_build_skb(buff_head, gem_total_rx_buffer_size(bp));
@@ -1743,10 +1761,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		/* now everything is ready for receiving packet */
 		if (last_frame) {
-			bp->dev->stats.rx_packets++;
-			queue->stats.rx_packets++;
-			bp->dev->stats.rx_bytes += queue->skb->len;
-			queue->stats.rx_bytes += queue->skb->len;
+			packets++;
+			bytes += queue->skb->len;
 
 			queue->skb->protocol = eth_type_trans(queue->skb, bp->dev);
 			skb_checksum_none_assert(queue->skb);
@@ -1769,7 +1785,6 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->skb = NULL;
 		}
 
-next_frame:
 		queue->rx_buff[entry] = NULL;
 		continue;
 
@@ -1784,11 +1799,17 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 						virt_to_head_page(buff_head),
 						false);
 
-		bp->dev->stats.rx_dropped++;
-		queue->stats.rx_dropped++;
+		dropped++;
 		queue->rx_buff[entry] = NULL;
 	}
 
+	bp->dev->stats.rx_packets += packets;
+	queue->stats.rx_packets += packets;
+	bp->dev->stats.rx_dropped += dropped;
+	queue->stats.rx_dropped += dropped;
+	bp->dev->stats.rx_bytes += bytes;
+	queue->stats.rx_bytes += bytes;
+
 	if (xdp_flush)
 		xdp_do_flush();
 

-- 
2.53.0


