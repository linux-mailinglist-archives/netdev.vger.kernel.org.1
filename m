Return-Path: <netdev+bounces-232402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F6C054F4
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 858AB353783
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07E030AAC0;
	Fri, 24 Oct 2025 09:23:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48CE309EE2
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297813; cv=none; b=nCC2EIhNo7JfznOvLwyTyY5ntTIR87Q1WkT59Q3zbuxfVY5UIwsBJDNWVi2COm38WUN6z+M1tae9WKeC8v/92+yySXLY59MifRcOq2Zfo2saH+5m5x/LbTZHqdrI3PQsw09aS9jkF55rsuoadi3CrgVGRzBBQfPU9y/Og+sXAyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297813; c=relaxed/simple;
	bh=PsGANhBJNTG8on/ITUYeJj4DUg+q0AhdxYpKIMj/03Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVL1YA/vcEmkbCtTYaYpMhOByISRVhYvvNG0mT/7e0c3YNKt//5nVNoUbWBleFYX9KKz4vPTjN8AN/39KtdG3yFFdyNZprAu1NdTjO7J4joCJYyOlFp+PIR9AFMWw0ncXTZrgFwJ61X4naD1B8AcA+0iOsCpVP4OLevBaMW/N3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300C5970781D8B076411Bb4C554a3.dip0.t-ipconnect.de [IPv6:2003:c5:9707:81d8:b076:411b:b4c5:54a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 8837EFA182;
	Fri, 24 Oct 2025 11:23:29 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 2/2] batman-adv: use skb_crc32c() instead of skb_seq_read()
Date: Fri, 24 Oct 2025 11:23:15 +0200
Message-ID: <20251024092315.232636-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251024092315.232636-1-sw@simonwunderlich.de>
References: <20251024092315.232636-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

Make batadv_bla_check_duplist() just use the new function skb_crc32c(),
instead of calling skb_seq_read() with crc32c(). This is faster and
simpler.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/Kconfig                 |  1 +
 net/batman-adv/bridge_loop_avoidance.c | 51 ++++----------------------
 net/batman-adv/types.h                 |  2 +-
 3 files changed, 10 insertions(+), 44 deletions(-)

diff --git a/net/batman-adv/Kconfig b/net/batman-adv/Kconfig
index c299e2bc87eda..58c408b7a7d9c 100644
--- a/net/batman-adv/Kconfig
+++ b/net/batman-adv/Kconfig
@@ -35,6 +35,7 @@ config BATMAN_ADV_BLA
 	bool "Bridge Loop Avoidance"
 	depends on BATMAN_ADV && INET
 	select CRC16
+	select NET_CRC32C
 	default y
 	help
 	  This option enables BLA (Bridge Loop Avoidance), a mechanism
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index b992ba12aa247..3dc791c15bf72 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -12,7 +12,6 @@
 #include <linux/compiler.h>
 #include <linux/container_of.h>
 #include <linux/crc16.h>
-#include <linux/crc32.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/etherdevice.h>
@@ -1585,45 +1584,11 @@ int batadv_bla_init(struct batadv_priv *bat_priv)
 	return 0;
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
-static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
-{
-	unsigned int to = skb->len;
-	unsigned int consumed = 0;
-	struct skb_seq_state st;
-	unsigned int from;
-	unsigned int len;
-	const u8 *data;
-	u32 crc = 0;
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
  * batadv_bla_check_duplist() - Check if a frame is in the broadcast dup.
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: contains the multicast packet to be checked
- * @payload_ptr: pointer to position inside the head buffer of the skb
- *  marking the start of the data to be CRC'ed
+ * @payload_offset: offset in the skb, marking the start of the data to be CRC'ed
  * @orig: originator mac address, NULL if unknown
  *
  * Check if it is on our broadcast list. Another gateway might have sent the
@@ -1638,16 +1603,18 @@ static __be32 batadv_skb_crc32(struct sk_buff *skb, u8 *payload_ptr)
  * Return: true if a packet is in the duplicate list, false otherwise.
  */
 static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
-				     struct sk_buff *skb, u8 *payload_ptr,
+				     struct sk_buff *skb, int payload_offset,
 				     const u8 *orig)
 {
 	struct batadv_bcast_duplist_entry *entry;
 	bool ret = false;
+	int payload_len;
 	int i, curr;
-	__be32 crc;
+	u32 crc;
 
 	/* calculate the crc ... */
-	crc = batadv_skb_crc32(skb, payload_ptr);
+	payload_len = skb->len - payload_offset;
+	crc = skb_crc32c(skb, payload_offset, payload_len, 0);
 
 	spin_lock_bh(&bat_priv->bla.bcast_duplist_lock);
 
@@ -1727,7 +1694,7 @@ static bool batadv_bla_check_duplist(struct batadv_priv *bat_priv,
 static bool batadv_bla_check_ucast_duplist(struct batadv_priv *bat_priv,
 					   struct sk_buff *skb)
 {
-	return batadv_bla_check_duplist(bat_priv, skb, (u8 *)skb->data, NULL);
+	return batadv_bla_check_duplist(bat_priv, skb, 0, NULL);
 }
 
 /**
@@ -1745,12 +1712,10 @@ bool batadv_bla_check_bcast_duplist(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
 	struct batadv_bcast_packet *bcast_packet;
-	u8 *payload_ptr;
 
 	bcast_packet = (struct batadv_bcast_packet *)skb->data;
-	payload_ptr = (u8 *)(bcast_packet + 1);
 
-	return batadv_bla_check_duplist(bat_priv, skb, payload_ptr,
+	return batadv_bla_check_duplist(bat_priv, skb, sizeof(*bcast_packet),
 					bcast_packet->orig);
 }
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index ae1d7a8dc480f..8fc5fe0e9b053 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -734,7 +734,7 @@ struct batadv_bcast_duplist_entry {
 	u8 orig[ETH_ALEN];
 
 	/** @crc: crc32 checksum of broadcast payload */
-	__be32 crc;
+	u32 crc;
 
 	/** @entrytime: time when the broadcast packet was received */
 	unsigned long entrytime;
-- 
2.47.3


