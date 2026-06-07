Return-Path: <netdev+bounces-296247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vvceA1t3JWq5IQIAu9opvQ
	(envelope-from <netdev+bounces-296247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB4650AD0
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tk154.de header.s=DKIM001 header.b=n1uQpKeA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296247-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296247-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA98C3005386
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3102738888F;
	Sun,  7 Jun 2026 13:51:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AD2AE8D;
	Sun,  7 Jun 2026 13:51:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840274; cv=none; b=HZCl1sH2ViSXduGx2ZQTdRlKZZVuvcoPbhB1PcHNOA7caMGJLShfEM0akjnYXceaQI1LVzrTT7dS+r9ZyVJZyOuea8wmxnhn6SeEm1t69YbDr+S/Mg3q8Jq3PRSdgdQEKFQrkRoHRxckusL0QbHVqCyqn1WNYiUtlqmFlG31edI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840274; c=relaxed/simple;
	bh=+4txlRb61jWfcSdAwcGsJ21jPzWWq48W/vnO+eSxS/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LgEN/iAOhwCEoTOvrKx3XGibn6lnZx95K5iyOVmHKQR9AEN/UX3TJt9ULROAEfbvzAkF+UUKRvPtbmDxTUw0OfAXK5acZDASbFkKJZx+D/tbouaw7EPkFLVqx2aViUmcVJMX6uqmuLguC3FXSZ7gxfudmxjD1LdN38cADzZxvWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=n1uQpKeA; arc=none smtp.client-ip=85.220.189.106
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id 0FE5E240937;
	Sun, 07 Jun 2026 15:50:59 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 6BAE2240023;
	Sun,  7 Jun 2026 15:50:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1780840257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5THlrM0am5qqbwBY1A1KQHMu7kcoO5c1HP7D/7vY/wg=;
	b=n1uQpKeA/ffNHOSlH9IZ1XT1To3bBGqK9V6Tl4OoJFDbJGwWMiMCbcHRsqZaGId2FxZMoG
	n3lX+w1esYoPS3hCxnMygNlUVBaErPjdS4/AY0pEopcFMlfrmKwnq8inT+fu76WP5LbZdI
	T/iwlyZu3715vWLAcb6+tpjgB2l0OjBB5VXY6fjiIACLggB3YTUVX7PkZ+zIpub4sY/7hl
	qpYxR51Oj5vt1vd7jkXWKZS1jm9V1rzZW904IkzlAoF02UCjcPugUI5xruw0TYP+JYgHZr
	JSch64Fb3167GfL5xpKjiH3LsWwqQ/sEI8/00G4IbfvC0n584zJdhCllnFhorw==
Received: from Til-Notebook.lan (unknown [IPv6:2a00:1f:5743:3300:7fdc:421c:b21a:ba71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 642512402A5;
	Sun,  7 Jun 2026 15:50:54 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: marcin.s.wojtas@gmail.com,
	linux@armlinux.org.uk,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	mcroce@redhat.com,
	sven.auhagen@voleatech.de,
	lorenzo@kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net v5 4/4] net: mvpp2: build skb from XDP-adjusted data on XDP_PASS
Date: Sun,  7 Jun 2026 15:49:43 +0200
Message-ID: <20260607134943.21996-5-mail@tk154.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607134943.21996-1-mail@tk154.de>
References: <20260607134943.21996-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: a84e83
X-Rspamd-UID: 07283a
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tk154.de:s=DKIM001];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296247-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:marcin.s.wojtas@gmail.com,m:linux@armlinux.org.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:mcroce@redhat.com,m:sven.auhagen@voleatech.de,m:lorenzo@kernel.org,m:mail@tk154.de,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[tk154.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,fomichev.me,voleatech.de,tk154.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@tk154.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tk154.de:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tk154.de:mid,tk154.de:dkim,tk154.de:from_mime,tk154.de:email,vger.kernel.org:from_smtp,xdp.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70BB4650AD0

When an XDP program uses bpf_xdp_adjust_head() or bpf_xdp_adjust_tail()
and then returns XDP_PASS, mvpp2 still builds the skb from fixed offsets
derived from the original RX descriptor. Packet geometry changes made by
the XDP program are therefore discarded before the skb reaches the stack.

Update rx_offset and rx_bytes from xdp.data and xdp.data_end for
XDP_PASS. This makes skb_reserve() and skb_put() reflect the packet seen
by XDP, and makes RX byte accounting for XDP_PASS follow the length of the
skb passed to the network stack.

Keep a separate rx_sync_size for page-pool recycling on skb allocation
failure, which must stay tied to the received buffer range.

Non-PASS verdicts continue to account the descriptor length because no skb
is passed up in those cases.

Fixes: 07dd0a7aae7f ("mvpp2: add basic XDP support")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 481daafdc1cb..ccc24a1301f2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3917,10 +3917,10 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		struct mvpp2_bm_pool *bm_pool;
 		struct page_pool *pp = NULL;
 		struct sk_buff *skb;
-		unsigned int frag_size;
+		unsigned int frag_size, rx_sync_size;
 		dma_addr_t dma_addr;
 		phys_addr_t phys_addr;
-		int pool, rx_bytes, err, ret;
+		int pool, rx_bytes, rx_offset, err, ret;
 		struct page *page;
 		void *data;
 
@@ -3933,6 +3933,8 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		rx_status = mvpp2_rxdesc_status_get(port, rx_desc);
 		rx_bytes = mvpp2_rxdesc_size_get(port, rx_desc);
 		rx_bytes -= MVPP2_MH_SIZE;
+		rx_sync_size = rx_bytes + MVPP2_MH_SIZE;
+		rx_offset = MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM;
 		dma_addr = mvpp2_rxdesc_dma_addr_get(port, rx_desc);
 
 		pool = (rx_status & MVPP2_RXD_BM_POOL_ID_MASK) >>
@@ -3948,7 +3950,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 
 		dma_sync_single_range_for_cpu(dev->dev.parent, dma_addr,
 					      MVPP2_SKB_HEADROOM,
-					      rx_bytes + MVPP2_MH_SIZE,
+					      rx_sync_size,
 					      dma_dir);
 
 		/* Buffer header not supported */
@@ -3999,6 +4001,14 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 				continue;
 			}
 
+			rx_sync_size = max_t(unsigned int, rx_sync_size,
+					     xdp.data_end - xdp.data_hard_start -
+					     MVPP2_SKB_HEADROOM);
+
+			/* Update offset and length to reflect any XDP adjustments. */
+			rx_offset = xdp.data     - data;
+			rx_bytes  = xdp.data_end - xdp.data;
+
 			metasize = xdp.data - xdp.data_meta;
 		}
 
@@ -4010,8 +4020,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 			netdev_warn(port->dev, "skb build failed\n");
 			if (pp) {
 				page_pool_put_page(pp, virt_to_head_page(data),
-						   rx_bytes + MVPP2_MH_SIZE,
-						   true);
+						   rx_sync_size, true);
 			} else {
 				dma_unmap_single_attrs(dev->dev.parent, dma_addr,
 						       bm_pool->buf_size,
@@ -4041,7 +4050,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
 		ps.rx_packets++;
 		ps.rx_bytes += rx_bytes;
 
-		skb_reserve(skb, MVPP2_MH_SIZE + MVPP2_SKB_HEADROOM);
+		skb_reserve(skb, rx_offset);
 		skb_put(skb, rx_bytes);
 		if (metasize)
 			skb_metadata_set(skb, metasize);
-- 
2.54.0


