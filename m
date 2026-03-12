Return-Path: <netdev+bounces-267219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVHGbI/s2l6TgAAu9opvQ
	(envelope-from <netdev+bounces-267219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800827AF16
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91F5F3029447
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C73BD223;
	Thu, 12 Mar 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="2DFV/DZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBE3BC68D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354912; cv=none; b=i2A42DdVbNp5fEqVygNm8vohDBXfte7aUFBN5PdnqC1oBQUjnq1TeS77ugpcITwoWbnsxDVSAOJPDGZtW5jOVSvs7aF7xkin3UglRx6SrMhAG4lLCews75oVfrLCMryGSe0U+M638g22m2QXLo/2TtHo+jR5HjFW8myd7N0UCdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354912; c=relaxed/simple;
	bh=X9VHKvATHxHvX/KMPAT55nhb5PDXdcI5BfyrlNhdZIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPTMkEA4mrORXH/Cy5Sp2tGMdI+zwRQmmuMzUkljDZ+moU5/MAx8x+7ES3GjHxl0+3pw0Vr2QzjQIsKZBQQzDh0CZV0lsRXtF0JqOQrVViSsGFpc5GD516KycsmnoSrSnIoOaUwgSl4VbPOEdRcL2ynBLxGnGVKWVV87KsR134s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=2DFV/DZU; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ae8177446fso12038085ad.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354910; x=1773959710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECNOcyzIL3pvAcmxfJ0jNS0/PNd0BF4YXgB3fthJC9U=;
        b=2DFV/DZULxNeQ68eKEROxwx56JK3Ru5eooNh5P8HcN52AvNy4zpbR/jMtQQ7wnuoMa
         aYzpIednwHfB9bpBxMseeU8pU5QVO1lJQutEL0/e2UmrdyX8P64Dxs8o9Nwz8O6CymOh
         Q5vR2+RxfsCMQURx4do740XtdqvD0pjYZEzIPmbbNOViPuR5/DqeDFISnwkP8tqWS7aL
         gOyr2T2zb4zOVOg3mk/046qYqYTnOa16ifEiJE2qqC+WyzYjSXjbYZI7ZymrZ38PV7LB
         8CcI7fVDOnvcLryE8PXmhHCC69mrsStEDFyM9nTnnKSgdZYgZPsjEGPH8SCt3b89eJEo
         dgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354910; x=1773959710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ECNOcyzIL3pvAcmxfJ0jNS0/PNd0BF4YXgB3fthJC9U=;
        b=cZhdsOVoz3PPOWbBDgOVVg66bZ5yOBFuim9xAJQbrSAqYhEQYAorCUSoetqr6uE9zj
         itWDqx3KyBsFKEpB2LSGoTaKcSB3kDfgNBMNIfRntm4fkBRIAOzdXmRIOcgw7sGPlMom
         2Ht/cxuhwTy0QXQRo5w2EdVoDw4LUBOknxzxeXF2Lgu5gWB6zhQAhVyFSsZL+A57kcBc
         ot13M28NlYnK70RjyYG0h9PciU4kbKtxdJR0mHHUicseKF9ev7UDEImZRiAOx1aSP9Nn
         ERd3J9HfPx3SotFqhYGu2wOBMZ8MZCgXtsO4fC1JQd72yr6yPwwYZ7t/nhpc7s2ia2PH
         GQAA==
X-Gm-Message-State: AOJu0YyaKankZ/iTg2CNE4jZp0gD9bgHQKsiCFveDBtGrO0meYfuHOGp
	hQAzyIKxjSTQMr9mcWh5Jk7/CRGLcmUHte1utpn3GFNmk37tFPOQS2heMvlpeTkgJEEJWzijNE4
	0jStMxtI=
X-Gm-Gg: ATEYQzzHwHges/Qd7YVa+czyKJDdgbpCKLc7ZUIYQ0yh1qimTxRIzaoC4gpHMXx2a9E
	esGhIosqj9T+BIumY6Jp4OO9BfFu0SDyis3IdqLlAboQXjyOJLE0AcMb8xWmACeipjy2irrGkWh
	OiwcbExVKSR3aAg6N9578HPakTwKUl61b+W2+iSc6K+P7+dSxTZ1KKl/ZwWuE0BqeSk/KONHYsS
	ujjeSJiSO4wy/QoHFdfgHu/q8tDf77bxiTa3Hpz63bXCM8Xn7aUkopWNEl+y+orBMiQrStwLoRf
	dgYnwNeoW0sHNt71EBHs42PZ2CziD2M57TW7/5K9mBXifIAAsyneB4Ok82RMiWrVrrlmG5Yotvj
	I3SF945rBl7SGGdyxpnUMummEJL44ro5//TbX0NSurneJIRrOAlp80bGTyV7M5R39w6jcZ2wslT
	1ndRQ=
X-Received: by 2002:a17:903:3c43:b0:2ae:5baa:cef6 with SMTP id d9443c01a7336-2aecaa26653mr9883235ad.19.1773354910240;
        Thu, 12 Mar 2026 15:35:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece63133fsm317385ad.41.2026.03.12.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:09 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 02/12] net: tso: Add tso_dma_map helpers
Date: Thu, 12 Mar 2026 15:34:39 -0700
Message-ID: <20260312223457.1999489-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama-to.20230601.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: 6800827AF16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add helpers to initialize, iterate, and clean up a tso_dma_map:

tso_dma_map_init(): DMA-maps the linear payload region and all frags
upfront into the tso_dma_map struct. Returns 0 on success, cleans up
partial mappings on failure.

tso_dma_map_cleanup(): unmaps all DMA regions. Used on error paths.

tso_dma_map_count(): counts how many descriptors the next N bytes of
payload will need, without advancing the iterator.

tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
Indicates when a chunk starts a new DMA mapping so the driver can set
dma_unmap_len on that BD for completion-time unmapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 include/net/tso.h |   8 +++
 net/core/tso.c    | 165 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/include/net/tso.h b/include/net/tso.h
index cd4b98dbea71..a1fa605f26b4 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -62,4 +62,12 @@ struct tso_dma_map {
 	} frags[MAX_SKB_FRAGS];
 };
 
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(const struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..fdbef4ca840d 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,167 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
 	return hdr_len;
 }
 EXPORT_SYMBOL(tso_start);
+
+/**
+ * tso_dma_map_init - DMA-map GSO payload regions
+ * @map: map struct to initialize
+ * @dev: device for DMA mapping
+ * @skb: the GSO skb
+ * @hdr_len: per-segment header length in bytes
+ *
+ * DMA-maps the linear payload (after headers) and all frags.
+ * Positions the iterator at byte 0 of the payload.
+ *
+ * Returns 0 on success, -ENOMEM on DMA mapping failure (partial mappings
+ * are cleaned up internally).
+ */
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len)
+{
+	unsigned int linear_len = skb_headlen(skb) - hdr_len;
+	unsigned int nr_frags = skb_shinfo(skb)->nr_frags;
+	int i;
+
+	map->dev = dev;
+	map->skb = skb;
+	map->hdr_len = hdr_len;
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+
+	if (linear_len > 0) {
+		map->linear_dma = dma_map_single(dev, skb->data + hdr_len,
+						 linear_len, DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, map->linear_dma))
+			return -ENOMEM;
+		map->linear_len = linear_len;
+	}
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		map->frags[i].len = skb_frag_size(frag);
+		map->frags[i].dma = skb_frag_dma_map(dev, frag, 0,
+						     map->frags[i].len,
+						     DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, map->frags[i].dma)) {
+			tso_dma_map_cleanup(map);
+			return -ENOMEM;
+		}
+		map->nr_frags = i + 1;
+	}
+
+	if (linear_len == 0 && nr_frags > 0)
+		map->frag_idx = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(tso_dma_map_init);
+
+/**
+ * tso_dma_map_cleanup - unmap all DMA regions in a tso_dma_map
+ * @map: the map to clean up
+ *
+ * Unmaps linear payload and all mapped frags. Used on error paths.
+ * Success paths use the driver's completion path to handle unmapping.
+ */
+void tso_dma_map_cleanup(struct tso_dma_map *map)
+{
+	int i;
+
+	if (map->linear_len)
+		dma_unmap_single(map->dev, map->linear_dma, map->linear_len,
+				 DMA_TO_DEVICE);
+
+	for (i = 0; i < map->nr_frags; i++)
+		dma_unmap_page(map->dev, map->frags[i].dma, map->frags[i].len,
+			       DMA_TO_DEVICE);
+
+	map->linear_len = 0;
+	map->nr_frags = 0;
+}
+EXPORT_SYMBOL(tso_dma_map_cleanup);
+
+/**
+ * tso_dma_map_count - count descriptors for a payload range
+ * @map: the payload map
+ * @len: number of payload bytes in this segment
+ *
+ * Counts how many contiguous DMA region chunks the next @len bytes
+ * will span, without advancing the iterator. Uses region sizes from
+ * the current position.
+ *
+ * Returns the number of descriptors needed for @len bytes of payload.
+ */
+unsigned int tso_dma_map_count(const struct tso_dma_map *map, unsigned int len)
+{
+	unsigned int offset = map->offset;
+	int idx = map->frag_idx;
+	unsigned int count = 0;
+
+	while (len > 0) {
+		unsigned int region_len, chunk;
+
+		if (idx == -1)
+			region_len = map->linear_len;
+		else
+			region_len = map->frags[idx].len;
+
+		chunk = min(len, region_len - offset);
+		len -= chunk;
+		count++;
+		offset = 0;
+		idx++;
+	}
+
+	return count;
+}
+EXPORT_SYMBOL(tso_dma_map_count);
+
+/**
+ * tso_dma_map_next - yield the next DMA address range
+ * @map: the payload map
+ * @addr: output DMA address
+ * @chunk_len: output chunk length
+ * @mapping_len: full DMA mapping length when this chunk starts a new
+ *               mapping region, or 0 when continuing a previous one.
+ *               Driver can assign this to the last descriptor.
+ * @seg_remaining: bytes left in current segment
+ *
+ * Yields the next (dma_addr, chunk_len) pair and advances the iterator.
+ *
+ * Returns true if a chunk was yielded, false when @seg_remaining is 0.
+ */
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining)
+{
+	unsigned int region_len, chunk;
+
+	if (!seg_remaining)
+		return false;
+
+	if (map->frag_idx == -1) {
+		region_len = map->linear_len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->linear_dma + map->offset;
+		*mapping_len = (map->offset == 0) ? region_len : 0;
+	} else {
+		region_len = map->frags[map->frag_idx].len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->frags[map->frag_idx].dma + map->offset;
+		*mapping_len = (map->offset == 0) ? region_len : 0;
+	}
+
+	*chunk_len = chunk;
+	map->offset += chunk;
+
+	if (map->offset >= region_len) {
+		map->frag_idx++;
+		map->offset = 0;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(tso_dma_map_next);
-- 
2.52.0


