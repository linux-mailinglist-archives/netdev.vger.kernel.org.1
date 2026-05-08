Return-Path: <netdev+bounces-286009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GH5HqVh/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 802114FC49E
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A579530479D6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8573921DF;
	Fri,  8 May 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwyN7D5S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767F91DE8AD
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278442; cv=none; b=nP/nQcZu75WKo4vlwqsDT7wMs0z+MJBrwcVIoyAzOEnCCtKXZLM8CrQvqTS8nk8rvWgwS+bbpXgO+QbFyXS4NAu/ew3RmmmEsD85leWOD0agE+JfBiD5Y4jlHkHka4w61A5scuB7WMDXAAR+S4UJoL3fCjoXAVZpuvabFBLf5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278442; c=relaxed/simple;
	bh=kvNheU5ucwTdOfr7TPey0YWobFOJuZB9s6BU1toEeTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUtYXHKpL/CuTdCZDA0YRaagZdnGCtIjLKqcYZX2FLPcFI80ROeVY6Ys5bCeZAAKES46uO2URaFDHBRlI8k20mkydMZKGb7vhkIKmvdKLlepVG3veqIs4N1Ikubsbk0lVZv7LINuUjlJ8f8ivAhc60FLKhkltnYiSkAh5R7GlJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwyN7D5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761EAC2BCF4;
	Fri,  8 May 2026 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278441;
	bh=kvNheU5ucwTdOfr7TPey0YWobFOJuZB9s6BU1toEeTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CwyN7D5S9IRhnw8m0qfik1ysjey8ZIOcynhIelZergcQH9XXSM9+L2vUrWPpK4ZCJ
	 nInutzRCLDeL83r1ihSZSo8GUhL9zbzlqnWrHgotW99XSGYejQ/U4r0RvCk5u5i0o4
	 TzwXvF0irCzdJWqAINDjKWeyU0d8d5Od4eypJGHWn/0nHSRzVFY5yIw8Xo38AuyEz/
	 01a+kzMLktaoKPs2iX9v5NV4FQwpPxnJ03oNNc3R1KzhlhM60uDldzToRvy9YoaSPn
	 gnChPS56mlEpxUgbemn20SXpEED/CafBcIAy1tQmmjknqE/q/NuaX+DZF7tkchcjCq
	 7mwQwsPwvv1nw==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 09 May 2026 00:13:38 +0200
Subject: [PATCH net 3/4] net: ethernet: cortina: Carry over frag counter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-gemini-ethernet-fixes-v1-3-6c5d20ddc35b@kernel.org>
References: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
In-Reply-To: <20260509-gemini-ethernet-fixes-v1-0-6c5d20ddc35b@kernel.org>
To: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 802114FC49E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286009-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

The gmac_rx() NAPI poll function assembles packets in an
SKB from a ring buffer.

If the ring buffer gets completely emptied during a poll cycle,
we exit gmac_rx(), but the packet is not yet completely
assembled in the SKB, yet the fragment counter frag_nr is
reset to zero on the next invocation.

Solve this by making the RX fragment counter a part of the
port struct, and carry it over between invocations.

Reset the fragment counter only right after calling
napi_gro_frags(), on error (after calling napi_free_frags())
or if stopping the port.

Reset it in some place where not strictly necessary just to
emphasize what is going on.

This was found by Sashiko during normal patch review.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d5a56366fb43..4c762229ce42 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -123,6 +123,7 @@ struct gemini_ethernet_port {
 	struct hrtimer		rx_coalesce_timer;
 	unsigned int		rx_coalesce_nsecs;
 	struct sk_buff		*rx_skb;
+	unsigned int		rx_frag_nr;
 
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
@@ -1444,6 +1445,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
 	void __iomem *ptr_reg = port->rxq_rwptr;
+	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
@@ -1457,7 +1459,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
-	int frag_nr = 0;
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
@@ -1497,6 +1498,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			if (skb) {
 				napi_free_frags(&port->napi);
 				skb = NULL;
+				frag_nr = 0;
 			}
 			continue;
 		}
@@ -1507,6 +1509,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 				napi_free_frags(&port->napi);
 				port->stats.rx_dropped++;
 				skb = NULL;
+				frag_nr = 0;
 			}
 
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
@@ -1541,6 +1544,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		if (word3.bits32 & EOF_BIT) {
 			napi_gro_frags(&port->napi);
 			skb = NULL;
+			frag_nr = 0;
 			--budget;
 		}
 		continue;
@@ -1549,6 +1553,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		if (skb) {
 			napi_free_frags(&port->napi);
 			skb = NULL;
+			frag_nr = 0;
 		}
 
 		if (mapping)
@@ -1558,6 +1563,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	}
 
 	port->rx_skb = skb;
+	port->rx_frag_nr = frag_nr;
 	writew(r, ptr_reg);
 	return budget;
 }
@@ -1886,6 +1892,7 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
 	port->rx_skb = NULL;
+	port->rx_frag_nr = 0;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);

-- 
2.54.0


