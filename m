Return-Path: <netdev+bounces-209374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E3B0F69E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113271C20356
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4A42EF2AD;
	Wed, 23 Jul 2025 15:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIhZnDCP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E712FD89C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282864; cv=none; b=pGCzHZoIEGYaEqhxgzCeYCRcbtmaFul1QgIMItknXkKrR5XWrhYFvlCKJjhSUWsSCBZLQby8BRLuIej99JoOd4M9Wv7w9s6FrHimX6xsDJG+9XKVyENBubbYRlU8MWmv0tJZWQzcPEU8EiABEQ53sxKJfNDaZRo5jwTVLuIf27k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282864; c=relaxed/simple;
	bh=qFrNRftYYRFSsbjJxx0Z1DarwhlBLVjErZMJy4Vaqpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjSYgM3ylFgkmZQgicxNzuIGTOEztURCLTKHABKjauMcPzutccUejAfA8ItdY0YbOM/mrQeNdl6W+bOchGfGfVtexO/t7mrwC4NT4MMKj+E2N8EGbUTTraOeIaxNc1VU4zEnHq5GPO+Yuoo5jfsp2bK3QCC/5U7kzmqygeejx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIhZnDCP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b45edf2303so6103661f8f.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282806; x=1753887606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ym8OS0V8bBUvcl2Zh7CpV4Rstv20WrbCPt8/82MXEpU=;
        b=LIhZnDCPlj+KSLQPQ/PKg6EVDGWrHxADeqw6oUQ/tt17UIwRcsB6s5VOzRmLKdcrLN
         cPLmcv7/72WPftLezZ7b7pp25xglqjsU/Uh0AeCHrAKIQlEYHmIOTcwKTMeWsAUL1Kj6
         Ut6o0TrWi51L2QYX+9dL3ggptUO2kXA/T4fWR+sMAyTatvPiZF1JiybLX9Jix3jFgyBz
         9tasbpVKp/172c9pKQzJGo9c8tzf0786qYCs237SzF08blEYYFAJl++rt8+vLXwS4kAU
         i7U4ibzJ9RO5YnY1WuwdTAIyYOL6jnvhYqewd+Z1YFOBXRNC5sBMs/NbEfJ2QT6U5l9L
         XBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282806; x=1753887606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym8OS0V8bBUvcl2Zh7CpV4Rstv20WrbCPt8/82MXEpU=;
        b=MYqTDbxfTPji1OapdMOEH11DkTcKr6pa08kfkMfQRGBnbwUw3mLhn/bMn7tWu/OxrA
         nVS0yZxxRuLR//SJ68jOWsdQpm/zkK3I+G/LKcm3e3Ltogtb/kYNWEMnEpnoJkfFxyHd
         hsbTwsxbMlWoCaF9elJ5ZuvWsssbuz6OIFlYcPkFmJPdpQLc+S39Q6pwxYTZxj69hdf1
         G+Jf0TP0FKhCicuWQdd1GY8xj1jaRwOKMfoCtPs44fMuia3DA+5QZy7tEYEZmavHBdG6
         8AKLciLTEuM2Q2GekGwgifdF1wcS1a34v4vP+NR+7JmmlWjHulLlWon3q9XQDHJLL6Zs
         Q5jg==
X-Gm-Message-State: AOJu0YyDyaif/Bz7LaszC+97vceeAciTM7HS1yMdZgYxy1jIojEYvzEW
	8W8PgJ8fLzK48NwZNJ/ugZXWNtVc0WP17/+skEuNka2fBSVuWc3HkGTW1BAQQGQJ
X-Gm-Gg: ASbGncts2liPBsGdfzooES+NuHxv8Wof7iWjuCW2A76uvnq0SeCm5Y3hCo4Gt2kYRov
	3MFjEF1QlEhDpkZKhKUNuHfO9xiDz3Y6cFSTcYkMHWNjbyKYqWpUWtt4xyIeJaPKzWVigd9I534
	suxOIzWfiKFQXnRJWZIMzXBgWMn7xz0k58T+ZxnfFUyBt/OVHx2LtXrfJvvxij2CklQTWpM0XAI
	/jaUQxLYEF7UJn9beu3NDYjYWvAIx0Q/YK6MJnGhBr8x4sb4tExpBBDiokNy+oglDprTUtv6FQ/
	wVydGjGFhxvts6yqwVpynlloIU+/W/5wcVqa5B319An3edmwPE0b/vnioo1kLRgizccHYTHanJj
	kUgipxG2ASLtGH2ZHiqc=
X-Google-Smtp-Source: AGHT+IEH7urWoow9a3Zaa08PimrBgn+ceQYEmTS7zV3/bqvOGoNVtzkobka9B9fDgdSjW4Fow43qfw==
X-Received: by 2002:a05:6000:2088:b0:3b6:10af:88e6 with SMTP id ffacd0b85a97d-3b768f05626mr2655739f8f.43.1753282806370;
        Wed, 23 Jul 2025 08:00:06 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca487fdsm16555037f8f.48.2025.07.23.08.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:05 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 3/9] eth: fbnic: Use shinfo to track frags state on Rx
Date: Wed, 23 Jul 2025 07:59:20 -0700
Message-ID: <20250723145926.4120434-4-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove local fields that track frags state and instead store this
information directly in the shinfo struct. This change is necessary
because the current implementation can lead to inaccuracies in certain
scenarios, such as when using XDP multi-buff support. Specifically, the
XDP program may update nr_frags without updating the local variables,
resulting in an inconsistent state.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 79 ++++++--------------
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h |  4 +-
 2 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 1fc7bd19e7a1..f5725c0972a5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -892,9 +892,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	xdp_prepare_buff(&pkt->buff, hdr_start, headroom,
 			 len - FBNIC_RX_PAD, true);
 
-	pkt->data_truesize = 0;
-	pkt->data_len = 0;
-	pkt->nr_frags = 0;
+	pkt->add_frag_failed = false;
 }
 
 static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
@@ -905,8 +903,8 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned int pg_off = FIELD_GET(FBNIC_RCD_AL_BUFF_OFF_MASK, rcd);
 	unsigned int len = FIELD_GET(FBNIC_RCD_AL_BUFF_LEN_MASK, rcd);
 	struct page *page = fbnic_page_pool_get(&qt->sub1, pg_idx);
-	struct skb_shared_info *shinfo;
 	unsigned int truesize;
+	bool added;
 
 	truesize = FIELD_GET(FBNIC_RCD_AL_PAGE_FIN, rcd) ?
 		   FBNIC_BD_FRAG_SIZE - pg_off : ALIGN(len, 128);
@@ -918,34 +916,34 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	dma_sync_single_range_for_cpu(nv->dev, page_pool_get_dma_addr(page),
 				      pg_off, truesize, DMA_BIDIRECTIONAL);
 
-	/* Add page to xdp shared info */
-	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-
-	/* We use gso_segs to store truesize */
-	pkt->data_truesize += truesize;
-
-	__skb_fill_page_desc_noacc(shinfo, pkt->nr_frags++, page, pg_off, len);
-
-	/* Store data_len in gso_size */
-	pkt->data_len += len;
+	added = xdp_buff_add_frag(&pkt->buff, page_to_netmem(page), pg_off, len,
+				  truesize);
+	if (unlikely(!added)) {
+		pkt->add_frag_failed = true;
+		netdev_err_once(nv->napi.dev,
+				"Failed to add fragment to xdp_buff\n");
+	}
 }
 
 static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 			       struct fbnic_pkt_buff *pkt, int budget)
 {
-	struct skb_shared_info *shinfo;
 	struct page *page;
-	int nr_frags;
 
 	if (!pkt->buff.data_hard_start)
 		return;
 
-	shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-	nr_frags = pkt->nr_frags;
+	if (xdp_buff_has_frags(&pkt->buff)) {
+		struct skb_shared_info *shinfo;
+		int nr_frags;
 
-	while (nr_frags--) {
-		page = skb_frag_page(&shinfo->frags[nr_frags]);
-		page_pool_put_full_page(nv->page_pool, page, !!budget);
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nr_frags = shinfo->nr_frags;
+
+		while (nr_frags--) {
+			page = skb_frag_page(&shinfo->frags[nr_frags]);
+			page_pool_put_full_page(nv->page_pool, page, !!budget);
+		}
 	}
 
 	page = virt_to_page(pkt->buff.data_hard_start);
@@ -955,43 +953,12 @@ static void fbnic_put_pkt_buff(struct fbnic_napi_vector *nv,
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 				       struct fbnic_pkt_buff *pkt)
 {
-	unsigned int nr_frags = pkt->nr_frags;
-	struct skb_shared_info *shinfo;
-	unsigned int truesize;
 	struct sk_buff *skb;
 
-	truesize = xdp_data_hard_end(&pkt->buff) + FBNIC_RX_TROOM -
-		   pkt->buff.data_hard_start;
-
-	/* Build frame around buffer */
-	skb = napi_build_skb(pkt->buff.data_hard_start, truesize);
-	if (unlikely(!skb))
+	skb = xdp_build_skb_from_buff(&pkt->buff);
+	if (!skb)
 		return NULL;
 
-	/* Push data pointer to start of data, put tail to end of data */
-	skb_reserve(skb, pkt->buff.data - pkt->buff.data_hard_start);
-	__skb_put(skb, pkt->buff.data_end - pkt->buff.data);
-
-	/* Add tracking for metadata at the start of the frame */
-	skb_metadata_set(skb, pkt->buff.data - pkt->buff.data_meta);
-
-	/* Add Rx frags */
-	if (nr_frags) {
-		/* Verify that shared info didn't move */
-		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-		WARN_ON(skb_shinfo(skb) != shinfo);
-
-		skb->truesize += pkt->data_truesize;
-		skb->data_len += pkt->data_len;
-		shinfo->nr_frags = nr_frags;
-		skb->len += pkt->data_len;
-	}
-
-	skb_mark_for_recycle(skb);
-
-	/* Set MAC header specific fields */
-	skb->protocol = eth_type_trans(skb, nv->napi.dev);
-
 	/* Add timestamp if present */
 	if (pkt->hwtstamp)
 		skb_hwtstamps(skb)->hwtstamp = pkt->hwtstamp;
@@ -1094,7 +1061,9 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			/* We currently ignore the action table index */
 			break;
 		case FBNIC_RCD_TYPE_META:
-			if (likely(!fbnic_rcd_metadata_err(rcd)))
+			if (unlikely(pkt->add_frag_failed))
+				skb = NULL;
+			else if (likely(!fbnic_rcd_metadata_err(rcd)))
 				skb = fbnic_build_skb(nv, pkt);
 
 			/* Populate skb and invalidate XDP */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 398310be592e..be34962c465e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -69,9 +69,7 @@ struct fbnic_net;
 struct fbnic_pkt_buff {
 	struct xdp_buff buff;
 	ktime_t hwtstamp;
-	u32 data_truesize;
-	u16 data_len;
-	u16 nr_frags;
+	bool add_frag_failed;
 };
 
 struct fbnic_queue_stats {
-- 
2.47.1


