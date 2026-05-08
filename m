Return-Path: <netdev+bounces-286007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLIwH45h/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-286007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:19:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0015D4FC490
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 997AF30474DF
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0C039C01E;
	Fri,  8 May 2026 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+iVgA2a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2544391E73
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278440; cv=none; b=DDs0YyKZ646y2hyU/fUR6mQ20nFXn/Y7yUHIyO2U7wBrvM85q4KNR9F28tB1W0Q2sosZVofH3DuqU0acPT7mtLquCJ6lSSx8BNpoSdFQXrRmpBJFP5i/KKVXiTGPDgcxc21crCybRWrUN/g+hhvxStjOZBGgaBSS+hKoYd8wQLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278440; c=relaxed/simple;
	bh=byXij5FSjOlY7Pa3cjjrwppSlcZI21EUiRJxccW1xNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VP/51ue+TnIHkA/JfYrGgMuJQsUSxIgR74oqmz5KAmdA+/LcrV2Z/1quY0Y1jbYIaHPrdAi3cKW/Ije6ZQFXTFzm4gdNM0Y2e/2P1x0jSpHupqJtJsgrrHEasK+6dc9tOBo6dNSEh3UfZXGyzKMwp52l3Egd7NYn9MYGirgCVhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+iVgA2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB2CC2BCB4;
	Fri,  8 May 2026 22:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278438;
	bh=byXij5FSjOlY7Pa3cjjrwppSlcZI21EUiRJxccW1xNQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z+iVgA2azj663aRyHp/YhBkHpOmmHcBIesXXWNT1JWM2na9+FXSAA4s4Sq7Xnl0dP
	 zUhxzMn3wc85uQIg2O1EBFOvX74U/Ntpgu4nMuaDvPk+fYNNURqsHq2uSt1F0YtF9f
	 /R/5QnPlcro5TqFP0TMiAnxDqNuVv/fPU/E6iUWz6+wFZx5PY+sVKQqrDTu2TEQDwc
	 Lpj+W68BgugTviAsukCEuMFYwqT+vVulHF5fwNaCD7C45oRLm8h3Al2gR+ibXscb7h
	 KXr8x+EscZ6n1yTJQRjCGtGaCPJugWW0HeWrZlHRSQHHlTn47qUexrlbNY22IPRQ+Z
	 /6DfEO4Lzp58Q==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 09 May 2026 00:13:37 +0200
Subject: [PATCH net 2/4] net: ethernet: cortina: Make RX SKB per-port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260509-gemini-ethernet-fixes-v1-2-6c5d20ddc35b@kernel.org>
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
X-Rspamd-Queue-Id: 0015D4FC490
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286007-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nebelreich.de,googlemail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rere.qmqm.pl];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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

The SKB used to assemble packets from fragments in gmac_rx()
is static local, but the Gemini has two ethernet ports, meaning
there can be races between the ports on a bad day if a device
is using both.

Make the RX SKB a per-port variable and carry it over between
invocations in the port struct instead.

Zero the pointer once we call napi_gro_frags(), on error (after
calling napi_free_frags()) or if the port is stopped.

Zero it in some place where not strictly necessary just to
emphasize what is going on.

This was found by Sashiko during normal patch review.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Link: https://sashiko.dev/#/patchset/20260505-gemini-ethernet-fix-v2-1-997c31d06079%40kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 466445c9e08b..d5a56366fb43 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -122,6 +122,8 @@ struct gemini_ethernet_port {
 	struct napi_struct	napi;
 	struct hrtimer		rx_coalesce_timer;
 	unsigned int		rx_coalesce_nsecs;
+	struct sk_buff		*rx_skb;
+
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
 	unsigned int		txq_order;
@@ -1442,10 +1444,10 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	unsigned short m = (1 << port->rxq_order) - 1;
 	struct gemini_ethernet *geth = port->geth;
 	void __iomem *ptr_reg = port->rxq_rwptr;
+	struct sk_buff *skb = port->rx_skb;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
-	static struct sk_buff *skb;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1504,6 +1506,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			if (skb) {
 				napi_free_frags(&port->napi);
 				port->stats.rx_dropped++;
+				skb = NULL;
 			}
 
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
@@ -1554,6 +1557,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		port->stats.rx_dropped++;
 	}
 
+	port->rx_skb = skb;
 	writew(r, ptr_reg);
 	return budget;
 }
@@ -1881,6 +1885,7 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	port->rx_skb = NULL;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);

-- 
2.54.0


