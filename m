Return-Path: <netdev+bounces-269159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EVNG575umlwdwIAu9opvQ
	(envelope-from <netdev+bounces-269159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:14:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BEE2C1DF4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A162303CA7F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F083F0777;
	Wed, 18 Mar 2026 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="dJmZrrWg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839D93F0767
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773861222; cv=none; b=i42j3Ttr0aRswAJhXT679tWOBP8qgvAPyWY3Quf94KAbXIWthzwfeRjzNu/EVDS5NkKhlRK/IfHPAad12/t3o9GjnVPnjMmbd7+HWWK+ArySPKTXewZffd6YkGvfBS7isr17/obl23CIQzCRz4k2rfaQSYECb2P/VW/K+inCvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773861222; c=relaxed/simple;
	bh=xq/+xvoT0Hu+ErcCDpnpPBW6PY0iRF0ZVwGcVOToUDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLljq4PQlRUn2RmgQfrF7KPxA8DebFnoF/dKf/Lq/ldcYXvVDqBTXILHpuhaa6POElXspCgGTwbo3Efaw04M7Rht49L3aERVtVlUqpvzZSrXoQPcakR9KLVg4ZG2LNSuDRF/gQhiF1tKuNiQ++0Msjy1bbfrN5UsedOS7ulwJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=dJmZrrWg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b05fd1d147so704895ad.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773861218; x=1774466018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TUMkjbkfsbcNIiidb7T5QT1qP0bw5g2hAra5IFGolA=;
        b=dJmZrrWghetNryNYML+a5wEQdEt85plG/q/BDGO97ngbI95I+JdwsiwgfCyOz+NbTG
         PiKZUepblN6VNtyiZ3BogwIV7Se+KcH3LjD9bWtg+9+NXBd+k6hzIUE4SsgSEIdEJ0L2
         dTZOIMET7OCtj7/1y3fdU3MieVLZB506uj07yDAsVYqN4YTeLTU1psV+qJyKKToDRDRI
         kiLXvgevre/zbA08h+3J2DCT6HO1iaO5+IEdUK2gP2hSTGi7hPHq7sszo7iU6XqQEUcU
         4W2B0SaB0Inzohd7632cwOipJDA9IRlPyfuaAy+7Xl8HImFQ9t+6Qv1hc4ilmcUkx3n5
         wsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773861218; x=1774466018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TUMkjbkfsbcNIiidb7T5QT1qP0bw5g2hAra5IFGolA=;
        b=m1l8voNsjC9LQs6g8QH6OycLTUlVibnGEyrIZMeX58PN38e7akMH0AoUmklGUDPxMV
         ozWJ1IzJU/RPnFgzLxD59GIUMlRrzJZEmLQ5sHCQ3E0i4ZfJjk7FGsPyCBZpUXooGgZI
         nUYITzpix1c79Dt0oGArEH87OPMYXzhH70IWpuH9Qdm59ZlRSsK0KiUorvnZTJJDV6eR
         5D56sBcieFJpjw1a/QBpFU8z6fdQlodA6WcaR93zedSYQYYZlidfeamFSAxjt1476sVn
         S7C9Xt8I64k23f2hiKiXgGdC0wvpvYCGs/KxK44EnO41k+JjcDquYL0aGu3HDqW9U1rt
         QmYA==
X-Gm-Message-State: AOJu0YyVTB3H5t8sWHfn0cF/t9uCZ7zrjvn3rAqfzbo35d3+kxFGnp2K
	qMN7ssjjnof0Y1isqE8Rs2TsECBzJ/J8FvJ82K3axA0qacwvgQQSxlEVjHaxd9Mcqd3Bcx+kZk3
	DLw8xNCQ=
X-Gm-Gg: ATEYQzzFzzWYYzpFzg+hYYh3f2GdGASF3/B1u0Ag2KqKqND1u0Ydcdifgq29Wl6wHdn
	QXdZomxa0Ht4Me+fa1bnAXnzBtTBZSEzzQL9lFWDzfZY1gNwVB5/rRw/bifg3a35Ew7DzBGvcFj
	hbyMsSQgeylYAxUNku8bo37FGiI9Lg8tRJj+RX2Lm3dDWO1c9a5pvXXGTmTioLVu+HXPNckto89
	ahTZovmSKRBFjNffnaZwjbRCFQQChPd6UfcqQysDIKXocG2CfsOYLyIFSwL1JrWn3b77pRM02YS
	pCOPz52uSUFQx4yd56Ue09ORr0w8UP5izoAvrw7BK9xq+C0QqmbRV2U5afAPOCbrOKQ7Jk4kJU/
	+drJjcvmaGnRgCCnsjE9RNqoTrq92eArkY0YI2UMfT54HOHJUejd4TchJPv8S17K0zYuIU6DAIr
	hQdvGE0h6aE6tnKg==
X-Received: by 2002:a17:903:1986:b0:2b0:4eeb:f80a with SMTP id d9443c01a7336-2b06e3c5238mr46225905ad.29.1773861218335;
        Wed, 18 Mar 2026 12:13:38 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e619428sm33536815ad.68.2026.03.18.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 12:13:37 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v3 02/12] net: tso: Add tso_dma_map helpers
Date: Wed, 18 Mar 2026 12:13:07 -0700
Message-ID: <20260318191325.1819881-3-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318191325.1819881-1-joe@dama.to>
References: <20260318191325.1819881-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269159-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[dama.to];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C5BEE2C1DF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adds skb_frag_phys() to skbuff.h, returning the physical address
of a paged fragment's data, which is used by the tso_dma_map helpers
introduced in this commit described below:

tso_dma_map_init(): DMA-maps the linear payload region and all frags
upfront. Prefers the DMA IOVA API for a single contiguous mapping with
one IOTLB sync; falls back to per-region dma_map_phys() otherwise.
Returns 0 on success, cleans up partial mappings on failure.

tso_dma_map_cleanup(): Handles both IOVA and fallback teardown paths.

tso_dma_map_count(): counts how many descriptors the next N bytes of
payload will need. Returns 1 if IOVA is used since the mapping is
contiguous.

tso_dma_map_next(): yields the next (dma_addr, chunk_len) pair.
On the IOVA path, each segment is a single contiguous chunk. On the
fallback path, indicates when a chunk starts a new DMA mapping so the
driver can set dma_unmap_len on that descriptor for completion-time
unmapping.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v3:
   - Added skb_frag_phys helper include/linux/skbuff.h.
   - Added tso_dma_map_use_iova() inline helper in tso.h.
   - Updated the helpers to use the DMA IOVA API and falls back to per-region
     mapping instead.

 include/linux/skbuff.h |  11 ++
 include/net/tso.h      |  21 ++++
 net/core/tso.c         | 274 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9cc98f850f1d..d8630eb366c5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3758,6 +3758,17 @@ static inline void *skb_frag_address_safe(const skb_frag_t *frag)
 	return ptr + skb_frag_off(frag);
 }
 
+/**
+ * skb_frag_phys - gets the physical address of the data in a paged fragment
+ * @frag: the paged fragment buffer
+ *
+ * Returns: the physical address of the data within @frag.
+ */
+static inline phys_addr_t skb_frag_phys(const skb_frag_t *frag)
+{
+	return page_to_phys(skb_frag_page(frag)) + skb_frag_off(frag);
+}
+
 /**
  * skb_frag_page_copy() - sets the page in a fragment from another fragment
  * @fragto: skb fragment where page is set
diff --git a/include/net/tso.h b/include/net/tso.h
index 8f8d9d74e873..919058b4c9a1 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -68,4 +68,25 @@ struct tso_dma_map {
 	} frags[MAX_SKB_FRAGS];
 };
 
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
+/**
+ * tso_dma_map_use_iova - check if this map used the DMA IOVA path
+ * @map: the map to check
+ *
+ * Returns true if the IOVA API was used for this mapping. When true,
+ * the driver must call tso_dma_map_cleanup() at completion time instead
+ * of doing per-region DMA unmaps.
+ */
+static inline bool tso_dma_map_use_iova(struct tso_dma_map *map)
+{
+	return dma_use_iova(&map->iova_state);
+}
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..731d5a5be1f8 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,275 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
 	return hdr_len;
 }
 EXPORT_SYMBOL(tso_start);
+
+static int tso_dma_iova_try(struct device *dev, struct tso_dma_map *map,
+			    phys_addr_t phys, size_t linear_len, size_t total_len,
+			    size_t *offset)
+{
+	const struct sk_buff *skb;
+	unsigned int nr_frags;
+	int i;
+
+	if (!dma_iova_try_alloc(dev, &map->iova_state, phys, total_len))
+		return 1;
+
+	skb = map->skb;
+	nr_frags = skb_shinfo(skb)->nr_frags;
+
+	if (linear_len) {
+		if (dma_iova_link(dev, &map->iova_state,
+				  phys, *offset, linear_len,
+				  DMA_TO_DEVICE, 0))
+			goto iova_fail;
+		map->linear_len = linear_len;
+		*offset += linear_len;
+	}
+
+	for (i = 0; i < nr_frags; i++) {
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+		unsigned int frag_len = skb_frag_size(frag);
+
+		if (dma_iova_link(dev, &map->iova_state,
+				  skb_frag_phys(frag), *offset,
+				  frag_len, DMA_TO_DEVICE, 0)) {
+			map->nr_frags = i;
+			goto iova_fail;
+		}
+		map->frags[i].len = frag_len;
+		*offset += frag_len;
+		map->nr_frags = i + 1;
+	}
+
+	if (dma_iova_sync(dev, &map->iova_state, 0, total_len))
+		goto iova_fail;
+
+	return 0;
+
+iova_fail:
+	dma_iova_destroy(dev, &map->iova_state, *offset,
+			 DMA_TO_DEVICE, 0);
+	memset(&map->iova_state, 0, sizeof(map->iova_state));
+
+	/* reset map state */
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+
+	return 1;
+}
+
+/**
+ * tso_dma_map_init - DMA-map GSO payload regions
+ * @map: map struct to initialize
+ * @dev: device for DMA mapping
+ * @skb: the GSO skb
+ * @hdr_len: per-segment header length in bytes
+ *
+ * DMA-maps the linear payload (after headers) and all frags.
+ * Prefers the DMA IOVA API (one contiguous mapping, one IOTLB sync);
+ * falls back to per-region dma_map_phys() when IOVA is not available.
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
+	size_t total_len = skb->len - hdr_len;
+	size_t offset = 0;
+	phys_addr_t phys;
+	int i;
+
+	if (!total_len)
+		return 0;
+
+	map->dev = dev;
+	map->skb = skb;
+	map->hdr_len = hdr_len;
+	map->frag_idx = -1;
+	map->offset = 0;
+	map->iova_offset = 0;
+	map->total_len = total_len;
+	map->linear_len = 0;
+	map->nr_frags = 0;
+	memset(&map->iova_state, 0, sizeof(map->iova_state));
+
+	if (linear_len)
+		phys = virt_to_phys(skb->data + hdr_len);
+	else
+		phys = skb_frag_phys(&skb_shinfo(skb)->frags[0]);
+
+	if (tso_dma_iova_try(dev, map, phys, linear_len, total_len, &offset)) {
+		/* IOVA path failed, map state was reset. Fallback to
+		 * per-region dma_map_phys()
+		 */
+		if (linear_len) {
+			map->linear_dma = dma_map_phys(dev, phys, linear_len,
+						       DMA_TO_DEVICE, 0);
+			if (dma_mapping_error(dev, map->linear_dma))
+				return -ENOMEM;
+			map->linear_len = linear_len;
+		}
+
+		for (i = 0; i < nr_frags; i++) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			unsigned int frag_len = skb_frag_size(frag);
+
+			map->frags[i].len = frag_len;
+			map->frags[i].dma = dma_map_phys(dev, skb_frag_phys(frag),
+							 frag_len, DMA_TO_DEVICE, 0);
+			if (dma_mapping_error(dev, map->frags[i].dma)) {
+				tso_dma_map_cleanup(map);
+				return -ENOMEM;
+			}
+			map->nr_frags = i + 1;
+		}
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
+ * Handles both IOVA and fallback paths. For IOVA, calls
+ * dma_iova_destroy(). For fallback, unmaps each region individually.
+ */
+void tso_dma_map_cleanup(struct tso_dma_map *map)
+{
+	int i;
+
+	if (dma_use_iova(&map->iova_state)) {
+		dma_iova_destroy(map->dev, &map->iova_state, map->total_len,
+				 DMA_TO_DEVICE, 0);
+		memset(&map->iova_state, 0, sizeof(map->iova_state));
+		map->linear_len = 0;
+		map->nr_frags = 0;
+		return;
+	}
+
+	if (map->linear_len)
+		dma_unmap_phys(map->dev, map->linear_dma, map->linear_len,
+			       DMA_TO_DEVICE, 0);
+
+	for (i = 0; i < map->nr_frags; i++)
+		dma_unmap_phys(map->dev, map->frags[i].dma, map->frags[i].len,
+			       DMA_TO_DEVICE, 0);
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
+ * will span, without advancing the iterator. On the IOVA path this
+ * is always 1 (contiguous). On the fallback path, uses region sizes
+ * from the current position.
+ *
+ * Returns the number of descriptors needed for @len bytes of payload.
+ */
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len)
+{
+	unsigned int offset = map->offset;
+	int idx = map->frag_idx;
+	unsigned int count = 0;
+
+	if (!len)
+		return 0;
+
+	if (dma_use_iova(&map->iova_state))
+		return 1;
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
+ *               On the IOVA path this is always 0 (driver must not
+ *               do per-region unmaps; use tso_dma_map_cleanup instead).
+ * @seg_remaining: bytes left in current segment
+ *
+ * Yields the next (dma_addr, chunk_len) pair and advances the iterator.
+ * On the IOVA path, the entire payload is contiguous so each segment
+ * is always a single chunk.
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
+	/* IOVA path: contiguous DMA range, no region boundaries */
+	if (dma_use_iova(&map->iova_state)) {
+		*addr = map->iova_state.addr + map->iova_offset;
+		*chunk_len = seg_remaining;
+		*mapping_len = 0;
+		map->iova_offset += seg_remaining;
+		return true;
+	}
+
+	/* Fallback path: per-region iteration */
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


