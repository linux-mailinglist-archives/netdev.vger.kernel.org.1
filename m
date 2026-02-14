Return-Path: <netdev+bounces-258685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJGQA/S9j2niTAEAu9opvQ
	(envelope-from <netdev+bounces-258685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 01:12:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C40313A1EC
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 01:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142D93007AD2
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 00:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9F64C97;
	Sat, 14 Feb 2026 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8zzbYU9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D682A13DBA0
	for <netdev@vger.kernel.org>; Sat, 14 Feb 2026 00:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771027952; cv=none; b=bgJ6lhggijEyHQevl3YGInpKie7dLH5ZMjsfLDuAjVvx+vRh46MGDCCGsEnb8xktRmTSjqIaQpZPOzdDcdFPZaPpDDi1JXmomJT4jRbpeCcE8+Ma82myoHhosuoee1CilizIXvUPgGnb9iEcOg80hBoxNLos42V9SiOkI4ucXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771027952; c=relaxed/simple;
	bh=aBiHy1g5Xkc5IxdeCktMrrpGsFp7xUT4c0xxkiTjR9I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hbVgGBn4ZJl7AMZyAzwghay8jENW1USj98xLXAAJRFGw3o3Uy3uBD9TN8dYQR5UG8xlKts4nO3s+LZcNCXkbR1jCWa/V351Jswl49QTUcscyiqTGg99gIIrE2+QHk113XIAh4nOom4W249GMcsjmEsdUQSyBT0sDRrqNhEKHQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8zzbYU9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b62da7602a0so1166546a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771027950; x=1771632750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/SseZuPVACGvCyr+zfyDhJIPT4Lkz8kZ02Cj7LiP/hw=;
        b=K8zzbYU9+hAD31AsSqII/oDsvF+VT4t2EaZti+P0lZrFDiW6HPhMS8dc1OGauzer14
         gm614zNXU4GvDJvVmOtJu3MYE+ngD0xiRm/0CdesaH24F3POOgf+8qZ+bk9mKbrGvaGX
         0Qf7NqTG6xbYV7+vcPWIID4Gc23FJdPpSmPEkhJWR2I3dzBJC20pKbBNg8amB/U4Qe4/
         tIOK4TJk0wVuxOFfesnikc39KkvUqE6Z2q7KTS8ktl6i+6AywhfVdx+jxzua4gd4B4b7
         aDHhj8/U1y9x32pbN7Zm8/2laQRrcEdQKqxIXqXfcteBxNQAJMWV2qfqJiy6FgH9w07Z
         XugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771027950; x=1771632750;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/SseZuPVACGvCyr+zfyDhJIPT4Lkz8kZ02Cj7LiP/hw=;
        b=ucTdq1KpIwVeMry2fBg2kOwySRuJxTq627IUkoIYbw5WKxldhoLOD63lvgHCLNplou
         OIxbpDOMzfuDjf0mraB6lZb3JU2EGYgihG62ioF+e86aRvKNkPfl3p8FrOF8EC/b8IKq
         YUiLRL+pAkCGID0drqRoL8TuUaTeEBj28OSqISFrN975wKCjSr+9wTuzLnrldJJvgZ3P
         lVPF8lA254olFqpreMEkiBlfsYsUTGt9gLJZQz6YaKBSg412ecmVEoHjt0vD9NJ49ERC
         qUxF29QRKbKtrQ2d8xtFVboj7faKIdavbSGif/OcTjB82WUXsEpffFRlMwLVJiovLonm
         zE1g==
X-Gm-Message-State: AOJu0YxtneZQrYWaOiIW1/7gkVCC9yaZnT1XMrALSCNJMBv31uCBehzm
	mH2EaXk9d++XHsDs9F+sRq3zNO4RLaaWZndkwq7iH8VjIAwJjFU/arx5EM5wZSXcMNINxUkm3Xe
	YJtkd6ZJvfpr5vnpePPvL6yZBImhtOjud9i81rpN+uxAVkf70M37/73G9gOQn3s7hp+HZmkXi/Y
	ByZEcmrLdqiDFx0PBAF5+1wvsK2UKsXgUVDP6zmFbLUgTor4Y=
X-Received: from pgbfe12.prod.google.com ([2002:a05:6a02:288c:b0:c64:8fdc:63f7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:e598:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-394837805a6mr901084637.12.1771027949947;
 Fri, 13 Feb 2026 16:12:29 -0800 (PST)
Date: Fri, 13 Feb 2026 16:12:26 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260214001226.744193-1-joshwash@google.com>
Subject: [PATCH net] gve: fix incorrect buffer cleanup in gve_tx_clean_pending_packets
 for QPL
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Rushil Gupta <rushilg@google.com>, Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, 
	Ankit Garg <nktgrg@google.com>, stable@vger.kernel.org, 
	Jordan Rhee <jordanrhee@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258685-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshwash@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C40313A1EC
X-Rspamd-Action: no action

From: Ankit Garg <nktgrg@google.com>

In DQ-QPL mode, gve_tx_clean_pending_packets() incorrectly uses the RDA
buffer cleanup path. It iterates num_bufs times and attempts to unmap
entries in the dma array.

This leads to two issues:
1. The dma array shares storage with tx_qpl_buf_ids (union).
 Interpreting buffer IDs as DMA addresses results in attempting to
 unmap incorrect memory locations.
2. num_bufs in QPL mode (counting 2K chunks) can significantly exceed
 the size of the dma array, causing out-of-bounds access warnings
(trace below is how we noticed this issue).

UBSAN: array-index-out-of-bounds in
drivers/net/ethernet/drivers/net/ethernet/google/gve/gve_tx_dqo.c:178:5 index 18 is out of
range for type 'dma_addr_t[18]' (aka 'unsigned long long[18]')
Workqueue: gve gve_service_task [gve]
Call Trace:
<TASK>
dump_stack_lvl+0x33/0xa0
__ubsan_handle_out_of_bounds+0xdc/0x110
gve_tx_stop_ring_dqo+0x182/0x200 [gve]
gve_close+0x1be/0x450 [gve]
gve_reset+0x99/0x120 [gve]
gve_service_task+0x61/0x100 [gve]
process_scheduled_works+0x1e9/0x380

Fix this by properly checking for QPL mode and delegating to
gve_free_tx_qpl_bufs() to reclaim the buffers.

Cc: stable@vger.kernel.org
Fixes: a6fb8d5a8b69 ("gve: Tx path for DQO-QPL")
Signed-off-by: Ankit Garg <nktgrg@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_tx_dqo.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 40b89b3e..6a31cb49 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -167,6 +167,9 @@ gve_free_pending_packet(struct gve_tx_ring *tx,
 	}
 }
 
+static void gve_unmap_packet(struct device *dev,
+			     struct gve_tx_pending_packet_dqo *pkt);
+
 /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.
  */
 static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
@@ -176,21 +179,12 @@ static void gve_tx_clean_pending_packets(struct gve_tx_ring *tx)
 	for (i = 0; i < tx->dqo.num_pending_packets; i++) {
 		struct gve_tx_pending_packet_dqo *cur_state =
 			&tx->dqo.pending_packets[i];
-		int j;
-
-		for (j = 0; j < cur_state->num_bufs; j++) {
-			if (j == 0) {
-				dma_unmap_single(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			} else {
-				dma_unmap_page(tx->dev,
-					dma_unmap_addr(cur_state, dma[j]),
-					dma_unmap_len(cur_state, len[j]),
-					DMA_TO_DEVICE);
-			}
-		}
+
+		if (tx->dqo.qpl)
+			gve_free_tx_qpl_bufs(tx, cur_state);
+		else
+			gve_unmap_packet(tx->dev, cur_state);
+
 		if (cur_state->skb) {
 			dev_consume_skb_any(cur_state->skb);
 			cur_state->skb = NULL;
@@ -1165,6 +1159,9 @@ static void gve_unmap_packet(struct device *dev,
 {
 	int i;
 
+	if (!pkt->num_bufs)
+		return;
+
 	/* SKB linear portion is guaranteed to be mapped */
 	dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
 			 dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
-- 
2.53.0.273.g2a3d683680-goog


