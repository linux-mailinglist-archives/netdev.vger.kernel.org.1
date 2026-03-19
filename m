Return-Path: <netdev+bounces-269611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DyWAJ88vGlxvgIAu9opvQ
	(envelope-from <netdev+bounces-269611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:12:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBA2D0A3B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E6E1300679C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B953EE1F8;
	Thu, 19 Mar 2026 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCQ35x8b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962D16FF37
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943965; cv=none; b=GwrcxieI/j3OCbYGNXmJsVe5AHj8lAqGSZN8J+Kz0NvkiXGG6TpY7ACVriOiEeKVdGyxt9sts/k7U7kooE4e8Ik4Nu2SVkB8PM11wEcEGAUF+fqaTe7h0t4lo7TbJt6yPjXTA1A5gSbWp+mvRcnXzdxlVUv3/3uBZOnBhSq6Sbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943965; c=relaxed/simple;
	bh=cz++0EVJ9nALORMfrWKRiSgQb6xnsyXY3S2o1askMN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BTL/TvWFdgP4mRvBklTMh0qt4+hINd2RbpCs/FdsfKNA/9xY4lIg3WyHleY5OrDTKVHmfiiKygifPq2YkQGDhTKFFSJmS3HpST+hiyk4THC8bwt+yzlwrDj8pET+UTdMf2tcjgUI8Mk3oRNTON8U90fEZwJ2cHavAQVqMeJBIQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCQ35x8b; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so995751f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 11:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943962; x=1774548762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAAT0drvlwEmUW4j2igW7dbw5rYw/CBM9N8ricd4PIc=;
        b=hCQ35x8bIVs2a0yIi0j5e6w2oDcUufId8ahnO4KmIa3fRDCumkKpafyX0uSBlg49lu
         RHjmkM7nzl+HGSwrPNKANNu36Upy0NEvmJJ44FmP+0un6EvglloBHIBYu3xa/18HIo8K
         nJGYkHgadiQ1PeTTow0+UvAesItgUoTBnJ81P+1Ikf7WaRGgMbU/agupRQNufd1m5ZNI
         19qqhedfDrTH6n8jt+Xq/HIrhbzL/5fzEsfLWTWl/xbGSML+zFC6/tXhgaeIy6kNsdCS
         N1pJGaUwJMq9LjLBuDorjT1ds5SK6Xw+hP+UI8rJkRNv/QDfUuCK8UQvKDixjCmETPmk
         8ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943962; x=1774548762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAAT0drvlwEmUW4j2igW7dbw5rYw/CBM9N8ricd4PIc=;
        b=qKQnuuMvT4omqzmSwPpcixNJw2BLWvJzsY2CUn2TNih1k6Z0L9YMsuyheryE8NfvbQ
         MNvW8k8ryUfM0JJC/YPhMQ4R5/jG1/kwC2GEnkkr5sDEZ3cKzsjYFKpqhxhjLkFZ3Cxz
         1+W6WdtRZc5wYp1XLJNsjfNObRcCKRlgAEpRCFkF59fJZ5FFILchs5nLJL4y6fTMUwDc
         +Vugh8o3OA/WZl9tAtiX+L0Q7xLtxQ5TLXHiFmbmLQg/BdePtDOFSahd/r0vWIWFN21F
         tVKi5cMOLPma36TZCgItBwbWrUnwjAxmwxngJqPSqfFfIsyN9/JAbMwqCPPC2f61F/SA
         EWjQ==
X-Gm-Message-State: AOJu0YycrJ1UgZCUYWPACuBqJ6vO8JADmmlxXgwcZvFfK4bfiYh9zI9Z
	qXo4n4NW46shdO7wfinkk2DDwjEJTGCB4K4W54GhlGTg2i4t4pk7N7N4
X-Gm-Gg: ATEYQzxrTTGZmWxuyWA8p5KqP3klQaVJBByrzyKuNVlXdssU1q1DuIZq859KO7LeaEB
	mc1D8spNooPc/m/A+LNdLn0mKp3oLrlWA+zWN4PZByoEOnePuXMA+J631SjwAOCaZV/AoZD7n2x
	+4n+q/ObfnhQF9RLiblnQlmkJ8lRzvngZ8kXRxIEFTayQXwefpZMiYl8RNsuO4nA+EWZnjxZ3vB
	7dx19zAGq9xkgvU/AC5qrwkIMOjqyz3is+DpQSs6G+1xtmrJBUmK6EWo61nI6WblnokNGWcPfJv
	+b3wxKStg2O0t7uBLiGu6jwgPI0t4vzgC9gheGLERGIkmk3EYpMKPwl8zqgIywLCFGb0t/2QgJJ
	8371/LaxDStjWSWxvZqwVbQQyBwDxRuny0mUa18jXxddXmE0EH/cqqe+d3KfhNWz96Yw7PZJ8p2
	ZTLcjzViV2DegGh63WIlR8vHO6w/EomoQRBJQqZkwOF0lx/+z61nA+0Beh7J4mXtOqGbIVLF2xG
	2qXLrssEGKy
X-Received: by 2002:a05:6000:2007:b0:439:cc67:abe9 with SMTP id ffacd0b85a97d-43b642879afmr605775f8f.27.1773943961554;
        Thu, 19 Mar 2026 11:12:41 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470b243sm292657f8f.26.2026.03.19.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:12:40 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH net] net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
Date: Thu, 19 Mar 2026 18:12:36 +0000
Message-ID: <20260319181236.14526-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269611-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.619];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xdp.data:url]
X-Rspamd-Queue-Id: 94FBA2D0A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cppi5_hdesc_get_psdata() returns a pointer into the CPPI descriptor.
In both emac_rx_packet() and emac_rx_packet_zc(), the descriptor is
freed via k3_cppi_desc_pool_free() before the psdata pointer is used
by emac_rx_timestamp(), which dereferences psdata[0] and psdata[1].
This constitutes a use-after-free on every received packet that goes
through the timestamp path.

Defer the descriptor free until after all accesses through the psdata
pointer are complete. For emac_rx_packet(), this means freeing in each
early-exit path and after emac_rx_timestamp() in the success path. For
emac_rx_packet_zc(), move the free to the end of the loop body after
emac_dispatch_skb_zc() (which calls emac_rx_timestamp()) has returned.

Fixes: 46eeb90f03e0 ("net: ti: icssg-prueth: Use page_pool API for RX buffer allocation")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 0a3cf2f848a5..31003962ecf7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -962,7 +962,6 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 		pkt_len -= 4;
 		cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
 		psdata = cppi5_hdesc_get_psdata(desc_rx);
-		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 		count++;
 		xsk_buff_set_size(xdp, pkt_len);
 		xsk_buff_dma_sync_for_cpu(xdp);
@@ -988,6 +987,7 @@ static int emac_rx_packet_zc(struct prueth_emac *emac, u32 flow_id,
 			emac_dispatch_skb_zc(emac, xdp, psdata);
 			xsk_buff_free(xdp);
 		}
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 	}
 
 	if (xdp_status & ICSSG_XDP_REDIR)
@@ -1057,7 +1057,6 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	/* firmware adds 4 CRC bytes, strip them */
 	pkt_len -= 4;
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
-	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 
 	/* if allocation fails we drop the packet but push the
 	 * descriptor back to the ring with old page to prevent a stall
@@ -1066,6 +1065,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	if (unlikely(!new_page)) {
 		new_page = page;
 		ndev->stats.rx_dropped++;
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 		goto requeue;
 	}
 
@@ -1077,11 +1077,14 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 		*xdp_state = emac_run_xdp(emac, &xdp, &pkt_len);
 		if (*xdp_state == ICSSG_XDP_CONSUMED) {
 			page_pool_recycle_direct(pool, page);
+			k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 			goto requeue;
 		}
 
-		if (*xdp_state != ICSSG_XDP_PASS)
+		if (*xdp_state != ICSSG_XDP_PASS) {
+			k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 			goto requeue;
+		}
 		headroom = xdp.data - xdp.data_hard_start;
 		pkt_len = xdp.data_end - xdp.data;
 	} else {
@@ -1093,6 +1096,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	if (!skb) {
 		ndev->stats.rx_dropped++;
 		page_pool_recycle_direct(pool, page);
+		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 		goto requeue;
 	}
 
@@ -1105,6 +1109,7 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, u32 *xdp_state)
 	if (emac->rx_ts_enabled)
 		emac_rx_timestamp(emac, skb, psdata);
 
+	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
 	if (emac->prueth->is_switch_mode)
 		skb->offload_fwd_mark = emac->offload_fwd_mark;
 	skb->protocol = eth_type_trans(skb, ndev);
-- 
2.53.0


