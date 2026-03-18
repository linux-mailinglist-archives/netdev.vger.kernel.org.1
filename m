Return-Path: <netdev+bounces-268945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ApiNldxumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:33:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3A92B91AD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C151930465F9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB153ACF1D;
	Wed, 18 Mar 2026 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad+C2l3L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A593ACA48
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773826130; cv=none; b=sJ9W9vdo7dwFI9JZhl4e3LTAyytXIE3U8+yQtvEBQowKKP3UNS6vgbR7FKbQ+bNnYoD/HnX9zG9OeZkZOO0yBbiE76duvHqAn21MvYYjsyNIU4ukJS7Q9iuykLP1UGDkFySGSMzjfl09stWkRJ0EiQBRgczWcBt4PV+uOPPyhRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773826130; c=relaxed/simple;
	bh=cz++0EVJ9nALORMfrWKRiSgQb6xnsyXY3S2o1askMN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=brkSknc4y51VnIbpD6ZwtDRGwzUDGvmo1ODZ8KHIZkDoqKYo37b6D4fnCjEqHTIrLBiptCqzOcgsA6L3mFAY2sZw/mqygwH3NL39q1FCITCAND7cSghcxbzgtEuviHr1EBW+rv3WzZuCGOUkbAnmsyXRHGplR7w1BxX3CjYe/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad+C2l3L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b40003d13so376029f8f.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773826125; x=1774430925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAAT0drvlwEmUW4j2igW7dbw5rYw/CBM9N8ricd4PIc=;
        b=Ad+C2l3L8YYR/A2pZ7uYYJagMn4z2Xeaiy/EEb6vUQ8TeZwbOTMxjKzawEWjFGqZKK
         ADfUwe8z+ddQ6iG6Fo9LLby0WEuPOaDLuh2eIQCSXVPfFKx68jTkGFGELErkVqbaZdP/
         j/YfsRk5iR9TodRFkXsk/Ft/YtUK1LAXBD5Dr2rm/xyxBhaMwE0HcVnX2NS1iAH82qke
         nfXbVkk7NqkUsbUS5s5fO8bh7ILAGRizOQurpqPACcpGkpPyE4lS4903mI9np0063JeD
         5ch+ii7a7MW7nfZ/mBjgd4waCapgOng5MASN6racDuS0/RsLPp8C8uo29ENGUVR0ifQL
         gO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773826125; x=1774430925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAAT0drvlwEmUW4j2igW7dbw5rYw/CBM9N8ricd4PIc=;
        b=SmRiBP1rCPBk+l7pv915j370AbCYr1fWGyqNbCbGO4ubeK/QzrnK/ePHz7cIpuSHM1
         Nxfpkp7g12pTbmBHZzRgdvwcRKsL4JfW12Ka+9fqIroKIZ+HaN9F/i1ltzr6LvHEtldV
         H4wDNGrOiVMWTddTn4Z3mA8bM905uCjCsFJ7vvhfP3QAxnqwASmH47fnt1hxmOaPz1uv
         L6fuR+gIRq7VDFk2bz4W2j1b2RzKlfZa5vyzLsuUUgEy0RaWYPytmDblxQXZExRYJVKA
         DeXZ3HLCP5W34Olb8kaZbQs8uyiE9Xwneg6iwKp2Tk2nyfr545wIsaeUhbTNmBqK6lLu
         ZEgA==
X-Gm-Message-State: AOJu0Yy1eCXPE37TaNvk3wpllO1cR+JYUnBfhLq0Ef416GCQk4rGEqxl
	6I6/ZxTLTdBZP7ycCt5V5uUDgDzDmXu1/QBvplr8g7etSrP1EAOO/pi/
X-Gm-Gg: ATEYQzx73KZTdbdxtqAU/Cage+/N2yLSpuTKLrSv5bmiBmKdQII0s4QOkn1Qv7Tgfrn
	MNpNxKn8xnXKR7SoJtZp/jzjfajk/FI+pUsDWdcYxgFN4XNTBYipuqTuLSIGozsLJPkBpBCDT5X
	wm7vZROoa5xDxxAxHRaNROYDpFizAQcSJXU9tv+k4tTXJwfs6s1sHIONltEoO2ElUGXUus0L46A
	LvQlFi5McCYceChPL7D7D80DSL/so1RiD244ZhaNRPoKKYQhhha1zsXPDPKKtjKGRPITORMYGIA
	uQxKXqEiYfFlgQSC0AVD7R2qN9pZ888ZFkHMXqVaD22qtcwK6Ee8SV4jrRk4QyAVDY2fpZXSzF/
	FyWG9kuL6hoOzyOg+ULFiOTofla760tKwf2FqB/X+YeUmG16uupf3axDUI+ry0iQj04ZHG2dls4
	bDsSxFFeJCMXur/FrUI1mELoMqCXRx1IfYzYhcPoTIZCOefYg3CmJqQWmiQdGZKiPsz+SPyYKDL
	ZecY/DA1MNL
X-Received: by 2002:a05:600c:3148:b0:485:3a59:99ca with SMTP id 5b1f17b1804b1-486f444fd94mr46027485e9.16.1773826124468;
        Wed, 18 Mar 2026 02:28:44 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f420d7b5sm80873635e9.2.2026.03.18.02.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:28:44 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] net: ti: icssg-prueth: fix use-after-free of CPPI descriptor in RX path
Date: Wed, 18 Mar 2026 09:28:41 +0000
Message-ID: <20260318092841.14453-1-devnexen@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-268945-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xdp.data:url]
X-Rspamd-Queue-Id: 3A3A92B91AD
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


