Return-Path: <netdev+bounces-223513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0EDB59644
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA0B2A20DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47FC30CDA3;
	Tue, 16 Sep 2025 12:32:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753701DF261
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758025956; cv=none; b=rs9tAx/XqXkT99QYuCAMctaGEEc3GXVzTKIUksbWlX3J1TwzyUPHvO7c5y/6kZCIJfP7Yu2c6DuZ7jhdLSB2Sb7WCzjueI4OgNu/6f6kU2KY3bzZ3NrvFpHBkNPGKvOa4kiqCCZO2VgqlHW1wqkpIF/gWJmbTPihB2mJcN9RuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758025956; c=relaxed/simple;
	bh=aeHsp/BrxjT7uPo8mJBmbAr8WyQYkAjoDE08FlKrS0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6MIqE83/9t4cHfqkAR5MwE3JIGOoKT5rEphrBwjv9UvmG/lnAn8/OIG/yuKXJHCjCZIYw6FyNpqU7CHfzY0aqMFM2btVdypUgPalNylPiWnWVtf9fY7geSdoGKGOQVcll9wmcU2dxVfvM1kvBOWOHAkVHhEH3Ujae12UTiAN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5972536D8604E0a64D0d3AaD8.dip0.t-ipconnect.de [IPv6:2003:c5:9725:36d8:604e:a64:d0d3:aad8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C9808FA184;
	Tue, 16 Sep 2025 14:24:51 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 3/4] batman-adv: keep skb crc32 helper local in BLA
Date: Tue, 16 Sep 2025 14:24:40 +0200
Message-ID: <20250916122441.89246-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916122441.89246-1-sw@simonwunderlich.de>
References: <20250916122441.89246-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The batadv_skb_crc32() helper was shared between Bridge Loop Avoidance and
Network Coding. With the removal of the network coding feature, it is
possible to just move this helper directly to Bridge Loop Avoidance.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 34 ++++++++++++++++++++++++++
 net/batman-adv/main.c                  | 34 --------------------------
 net/batman-adv/main.h                  |  1 -
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 747755647c6a4..b992ba12aa247 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,6 +12,7 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
+#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -1584,6 +1585,39 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+/**
+ * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
+ *  the header
+ * @skb: skb pointing to fragmented socket buffers
+ * @payload_ptr: Pointer to position inside the head buffer of the skb
+ *  marking the start of the data to be CRC'ed
+ *
+ * payload_ptr must always point to an address in the skb head buffer and not to
+ * a fragment.
+ *
+ * Return: big endian crc32c of the checksummed data
+ */
+static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
+{
+	unsigned int to = skb->len;
+	unsigned int consumed = 0;
+	struct skb_seq_state st;
+	unsigned int from;
+	unsigned int len;
+	const u8 *data;
+	u32 crc = 0;
+
+	from = (unsigned int)(payload_ptr - skb->data);
+
+	skb_prepare_seq_read(skb, from, to, &st);
+	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
+		crc = crc32c(crc, data, len);
+		consumed += len;
+	}
+
+	return htonl(crc);
+}
+
 /**
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the mesh interface information
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 1dcacfc310ee9..3a35aadd8b419 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -11,7 +11,6 @@
 #include <linux/build_bug.h>
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
-#include <linux/crc32.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gfp.h>
@@ -561,39 +560,6 @@ void batadv_recv_handler_unregister(u8 packet_type)
 	batadv_rx_handler[packet_type] = batadv_recv_unhandled_packet;
 }
 
-/**
- * batadv_skb_crc32() - calculate CRC32 of the whole packet and skip bytes in
- *  the header
- * @skb: skb pointing to fragmented socket buffers
- * @payload_ptr: Pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
- *
- * payload_ptr must always point to an address in the skb head buffer and not to
- * a fragment.
- *
- * Return: big endian crc32c of the checksummed data
- */
-__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
-{
-	u32 crc = 0;
-	unsigned int from;
-	unsigned int to = skb->len;
-	struct skb_seq_state st;
-	const u8 *data;
-	unsigned int len;
-	unsigned int consumed = 0;
-
-	from = (unsigned int)(payload_ptr - skb->data);
-
-	skb_prepare_seq_read(skb, from, to, &st);
-	while ((len = skb_seq_read(consumed, &data, &st)) != 0) {
-		crc = crc32c(crc, data, len);
-		consumed += len;
-	}
-
-	return htonl(crc);
-}
-
 /**
  * batadv_get_vid() - extract the VLAN identifier from skb if any
  * @skb: the buffer containing the packet
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 7352b11df968c..2be1ac17acaa4 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -248,7 +248,6 @@ batadv_recv_handler_register(u8 packet_type,
 			     int (*recv_handler)(struct sk_buff *,
 						 struct batadv_hard_iface *));
 void batadv_recv_handler_unregister(u8 packet_type);
-__be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr);
 
 /**
  * batadv_compare_eth() - Compare two not u16 aligned Ethernet addresses
-- 
2.47.3


