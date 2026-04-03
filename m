Return-Path: <netdev+bounces-274795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LitLokMz2kNsgYAu9opvQ
	(envelope-from <netdev+bounces-274795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:40:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D347D38F93E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9218630367B3
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 00:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1412241690;
	Fri,  3 Apr 2026 00:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="DeUWS0Ya"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17D23B638
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 00:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775176551; cv=none; b=NeWo/uT62XsTAc66K1L8jLJ/HBEfWZQLaJhKmR/spkKf/luPUu1+LZp/ChBgaGxOjdXJZbHn1HPW2LzZJHy2HMLJx9uMplImuszzPftTXrh+TQud3Xn+7k7NsZ9vFFSbxTUv5Iw8bGzir+p1xOBrznKsoSrx8awcCYzf60erPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775176551; c=relaxed/simple;
	bh=aocsnZ96VmK29khd6F+PQ7orwzWSe+c8kQ2igvf/n34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5JWApiuQsrGpTF1i8AjMxgZijXoamXwjd8Y/q2+BoaTuLoCukdPoIPqirm5VqylzfxvnxKcLMtThyu93UyoqY3ARYKZO77ok5L9/u+zw0M9t6j7U58VjPEvBOZni3UJCoItjTi+poovTXmuPkVtiBuaQDyPeSM1n1rscWGQKbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=DeUWS0Ya; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d90833cacso880211a91.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775176549; x=1775781349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nUdbRbDP4j+PIfnlCM8F+wfqa8xn/bf/ZjUPUuyqR4=;
        b=DeUWS0Ya8wgCGTbXPf7qkK4oEl+p5W5i5F+hcC5F/2gVU/6BO/d6hYloAlV9EABjZG
         +32+QQT0FmIxHsRomT3trbFpGXEe6JargAN88D0M3iTuCBs79Lro+pzCfueE7N6G40ll
         1p1SX0X4XHt9TdCJJXrqFonXvE9/yBltwA46hsxnGo9Fkq6sbKFGgHud/UwvN1daavgh
         +9zDG4GuT+V/V2gdsKJ1cburWxg6f45L5AekA1a+dOcuIU/cXxi2MWMZq9pxi2CQRN8s
         MDT9d5yafyS7SJtekKE3UNJf95FOiOYNUwm6mxzjWfKJZVQm+2pWZXUa722kYFvzYiah
         xzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775176549; x=1775781349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3nUdbRbDP4j+PIfnlCM8F+wfqa8xn/bf/ZjUPUuyqR4=;
        b=Fvk1e22QuvuBzdkRmM8zsrr0RPLpGMIFJM0650kEOxfoxkRKs2mbrGo37wWeWdSxeR
         4CdDrfe1cITzCXqMBEiOmbLBNC8+nLiYUWlYbRahefn6ulcx+2L9SvKpAa6a8LKjICrN
         igXxdb8haRwoE5zWXv4Nrg21Xvf3nBpKch1a0wj71mYUU2VZECfwGiH3VFAAZK1noel9
         s6296deNbbYJPZ4KL7ONjdin9LK46D1RjETLM5YycZ/7Smn7zKrPlElwX5PP9SKNgsfB
         /HStl8eM85jeZchLRGWnEw/V3X2T81hOYsj2Su8KGVU2XFcV165L49o/6r5/bf6LitNg
         rzUQ==
X-Gm-Message-State: AOJu0Yz5XthYSIyro8sdNdDWhz2i+czYZv2lm2gvJbNHsV612e5KAwq4
	DRRVq6XWHAIOwQt2IZCCLllSSqbJtA9dlY8uCrx2Zf4MxqBXELYARHkU+JvVlibGK3Jz/dcPa/v
	xOpsaVXA=
X-Gm-Gg: AeBDieuMMecqGppQlT6y6feals6ChezoMGGtRO5vufwNEMff5URQ+bEw+d2XL6nfBY6
	TIhirC9yxAVWw9UG+ybTk47IJTCJSwjeou+MS/tAxIRA6cWYnKjeZfSZA0FFyRHY9Sl2vJdL5X6
	Tk9cueCMwaVYhnrfl4ufSOkVRCV45+SAtii3jnTkbxmJmQQE+yavZ7cvh/YtDJeSpq+TZpaZ/59
	+VGvVm29qZvKOTdQ9xy4Rg1fEWp2oFpwgIRTNeAOX67qGrf41k3tYjQTEd1WSVD3x5P5PXbvDEi
	ZcmzqRhXMk9U1BZ9ICaBrL5Cn771/L2OFHp1JdGiDfznf9S2pGCoFtNVuI3erw8wRpa/IZ43u/H
	334ipukwoWB8IFNqVid8dLs/4kiMuPBTEnlP4Zyi0kEMewWUxoA3dLfscYv/r2YeGQJzB4Ogk9Y
	GgMbOLXrgQu51NiQ==
X-Received: by 2002:a17:90b:3952:b0:35b:a9f3:62ee with SMTP id 98e67ed59e1d1-35de69d6c96mr816530a91.27.1775176549198;
        Thu, 02 Apr 2026 17:35:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd368f538sm5544798a91.14.2026.04.02.17.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 17:35:48 -0700 (PDT)
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
Subject: [net-next v8 01/10] net: tso: Introduce tso_dma_map and helpers
Date: Thu,  2 Apr 2026 17:35:08 -0700
Message-ID: <20260403003524.2564973-2-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403003524.2564973-1-joe@dama.to>
References: <20260403003524.2564973-1-joe@dama.to>
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
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-274795-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,dama-to.20251104.gappssmtp.com:dkim,dama.to:email,dama.to:mid]
X-Rspamd-Queue-Id: D347D38F93E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add struct tso_dma_map to tso.h for tracking DMA addresses of mapped
GSO payload data and tso_dma_map_completion_state.

The tso_dma_map combines DMA mapping storage with iterator state, allowing
drivers to walk pre-mapped DMA regions linearly. Includes fields for
the DMA IOVA path (iova_state, iova_offset, total_len) and a fallback
per-region path (linear_dma, frags[], frag_idx, offset).

The tso_dma_map_completion_state makes the IOVA completion state opague
for drivers. Drivers are expected to allocate this and use the added
helpers to update the completion state.

Adds skb_frag_phys() to skbuff.h, returning the physical address
of a paged fragment's data, which is used by the tso_dma_map helpers
introduced in this commit described below.

The added TSO DMA map helpers are:

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

tso_dma_map_completion_save(): updates the completion state. Drivers
will call this at xmit time.

tso_dma_map_complete(): tears down the mapping at completion time and
returns true if the IOVA path was used. If it was not used, this is a
no-op and returns false.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v7:
   - Squashed the struct and helpers (patch 1 and 2 from v6) into this one
     patch.
   - Added tso_dma_map_completion_state and helpers
     tso_dma_map_completion_save and tso_dma_map_complete to operate on the
     struct and keep the DMA IOVA completely opaque from drivers.
   - Removed unnecessary duplicated code in tso_dma_map_next and
     tso_dma_map_cleanup.

 v4:
   - Fix the kdoc for the TSO helpers. No functional changes.

 v3:
   - struct tso_dma_map extended to track IOVA state and
     a fallback per-region path.
   - Added skb_frag_phys helper include/linux/skbuff.h.
   - Added tso_dma_map_use_iova() inline helper in tso.h.
   - Updated the helpers to use the DMA IOVA API and falls back to per-region
     mapping instead.

 include/linux/skbuff.h |  11 ++
 include/net/tso.h      | 100 +++++++++++++++
 net/core/tso.c         | 269 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 380 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index fbfa9852e82a..d204faab1e1e 100644
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
index e7e157ae0526..33f7dc9ed42e 100644
--- a/include/net/tso.h
+++ b/include/net/tso.h
@@ -3,6 +3,7 @@
 #define _TSO_H
 
 #include <linux/skbuff.h>
+#include <linux/dma-mapping.h>
 #include <net/ip.h>
 
 #define TSO_HEADER_SIZE		256
@@ -28,4 +29,103 @@ void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
 void tso_build_data(const struct sk_buff *skb, struct tso_t *tso, int size);
 int tso_start(struct sk_buff *skb, struct tso_t *tso);
 
+/**
+ * struct tso_dma_map - DMA mapping state for GSO payload
+ * @dev: device used for DMA mapping
+ * @skb: the GSO skb being mapped
+ * @hdr_len: per-segment header length
+ * @iova_state: DMA IOVA state (when IOMMU available)
+ * @iova_offset: global byte offset into IOVA range (IOVA path only)
+ * @total_len: total payload length
+ * @frag_idx: current region (-1 = linear, 0..nr_frags-1 = frag)
+ * @offset: byte offset within current region
+ * @linear_dma: DMA address of the linear payload
+ * @linear_len: length of the linear payload
+ * @nr_frags: number of frags successfully DMA-mapped
+ * @frags: per-frag DMA address and length
+ *
+ * DMA-maps the payload regions of a GSO skb (linear data + frags).
+ * Prefers the DMA IOVA API for a single contiguous mapping with one
+ * IOTLB sync; falls back to per-region dma_map_phys() otherwise.
+ */
+struct tso_dma_map {
+	struct device		*dev;
+	const struct sk_buff	*skb;
+	unsigned int		hdr_len;
+	/* IOVA path */
+	struct dma_iova_state	iova_state;
+	size_t			iova_offset;
+	size_t			total_len;
+	/* Fallback path if IOVA path fails */
+	int			frag_idx;
+	unsigned int		offset;
+	dma_addr_t		linear_dma;
+	unsigned int		linear_len;
+	unsigned int		nr_frags;
+	struct {
+		dma_addr_t	dma;
+		unsigned int	len;
+	} frags[MAX_SKB_FRAGS];
+};
+
+/**
+ * struct tso_dma_map_completion_state - Completion-time cleanup state
+ * @iova_state: DMA IOVA state (when IOMMU available)
+ * @total_len: total payload length of the IOVA mapping
+ *
+ * Drivers store this on their SW ring at xmit time via
+ * tso_dma_map_completion_save(), then call tso_dma_map_complete() at
+ * completion time.
+ */
+struct tso_dma_map_completion_state {
+	struct dma_iova_state iova_state;
+	size_t total_len;
+};
+
+int tso_dma_map_init(struct tso_dma_map *map, struct device *dev,
+		     const struct sk_buff *skb, unsigned int hdr_len);
+void tso_dma_map_cleanup(struct tso_dma_map *map);
+unsigned int tso_dma_map_count(struct tso_dma_map *map, unsigned int len);
+bool tso_dma_map_next(struct tso_dma_map *map, dma_addr_t *addr,
+		      unsigned int *chunk_len, unsigned int *mapping_len,
+		      unsigned int seg_remaining);
+
+/**
+ * tso_dma_map_completion_save - save state needed for completion-time cleanup
+ * @map: the xmit-time DMA map
+ * @cstate: driver-owned storage that persists until completion
+ *
+ * Should be called at xmit time to update the completion state and later passed
+ * to tso_dma_map_complete().
+ */
+static inline void
+tso_dma_map_completion_save(const struct tso_dma_map *map,
+			    struct tso_dma_map_completion_state *cstate)
+{
+	cstate->iova_state = map->iova_state;
+	cstate->total_len = map->total_len;
+}
+
+/**
+ * tso_dma_map_complete - tear down mapping at completion time
+ * @dev: the device that owns the mapping
+ * @cstate: state saved by tso_dma_map_completion_save()
+ *
+ * Returns true if the IOVA path was used and the mapping has been
+ * destroyed. Returns false if the fallback per-region path was used
+ * and the driver must unmap via its normal completion path.
+ */
+static inline bool
+tso_dma_map_complete(struct device *dev,
+		     struct tso_dma_map_completion_state *cstate)
+{
+	if (dma_use_iova(&cstate->iova_state)) {
+		dma_iova_destroy(dev, &cstate->iova_state, cstate->total_len,
+				 DMA_TO_DEVICE, 0);
+		return true;
+	}
+
+	return false;
+}
+
 #endif	/* _TSO_H */
diff --git a/net/core/tso.c b/net/core/tso.c
index 6df997b9076e..e39b6f30345e 100644
--- a/net/core/tso.c
+++ b/net/core/tso.c
@@ -3,6 +3,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip.h>
 #include <net/tso.h>
+#include <linux/dma-mapping.h>
 #include <linux/unaligned.h>
 
 void tso_build_hdr(const struct sk_buff *skb, char *hdr, struct tso_t *tso,
@@ -87,3 +88,271 @@ int tso_start(struct sk_buff *skb, struct tso_t *tso)
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
+ * Return: 0 on success, -ENOMEM on DMA mapping failure (partial mappings
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
+	} else {
+		if (map->linear_len)
+			dma_unmap_phys(map->dev, map->linear_dma, map->linear_len,
+				       DMA_TO_DEVICE, 0);
+
+		for (i = 0; i < map->nr_frags; i++)
+			dma_unmap_phys(map->dev, map->frags[i].dma, map->frags[i].len,
+				       DMA_TO_DEVICE, 0);
+	}
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
+ * Return: the number of descriptors needed for @len bytes of payload.
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
+ * Return: true if a chunk was yielded, false when @seg_remaining is 0.
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
+	} else {
+		region_len = map->frags[map->frag_idx].len;
+		chunk = min(seg_remaining, region_len - map->offset);
+		*addr = map->frags[map->frag_idx].dma + map->offset;
+	}
+
+	*mapping_len = (map->offset == 0) ? region_len : 0;
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


