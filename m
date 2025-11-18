Return-Path: <netdev+bounces-239390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5F3C67D31
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 08:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6069C35819F
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A132F90C5;
	Tue, 18 Nov 2025 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB+0rRN8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6251F2ECE9E
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763449463; cv=none; b=YPuj86keKuc5c4YTL4BKXHZUfFVJ0Uw0cHBKjGvPUoTX28UZiyjp63/eYt4jr7NEyVT1VoTEuXt+mLlWlhmCodxZ3hu9jUJJW+xA4xcTSIzUEBgyScboyYfCFGwKanS4dmreD8bZv+iBgTAXJh2/Jueq/dykxDgXYmV4ZCUdvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763449463; c=relaxed/simple;
	bh=QM3d5KZwlDTYqlEAfpn9wkt9114sgt9NvWr/a3iuPVw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nEYdNk+ZqCr2wdptINuxo1rkSat3RPggq/OYIpCF1crB4juKDv/Ff+8MfSs9XxxqCFkPp3KX4ZB6kxIJ5XM0RcyYCoSfX+Kp8PgasWMH0Ej4vv+aPaMFi4u3zcL2gI2tZiBRekK7NTHRrQDfA2YWdtRieqaYAxYnVdlscGSAhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB+0rRN8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-298456bb53aso58060425ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 23:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763449461; x=1764054261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rzPjqqd/KWxOgO2W+6Z8f1qGfvSxbwM8UkM0u1p+nzs=;
        b=CB+0rRN8S6YPM29bHtT6mvTzhBXs5Gkg4S14baI/Nkqk8f7/SpqAQHURjb669MZza8
         B73y7NTBsryZZfx5KxHm0Rm2EFuLrQdFe3yr6CbmS/q2PWBGM1LdW0pQPvaPfjJfoakQ
         DadTYXlzUabjRf7bKQ2MjKdqdjHSgCW7SHaYf1i0law50W9oRwYXr/d6luwZBlNw1wHJ
         nyYPVn5dN9onZ+7fEZYWYdpKv8C+PM+4xtaI4hwTgGtomwgt0Lb7LRfuezGr1PWuujII
         oddZR7XjDQf8CIPl2GuOg7yupxGMKhtXz2aXvydYy7SAT7ETihvRhExeCVGJCLtV5Hl+
         7Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763449461; x=1764054261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzPjqqd/KWxOgO2W+6Z8f1qGfvSxbwM8UkM0u1p+nzs=;
        b=qxdhjb4y1mj4J1tT9gvWCLwguSQcu6pNcjXcAei6D+6xyQTX5oBs8eXIZ9foKcX1LV
         J59Mz4IBSZnRLJs3MopnlsymKX7B/b/NpGWgSH5JWP48N1zZ8bvkXaAIFzRWrLJCR1AH
         wCYGmN+6ZWD2yu/rNSFyXN+Qq6wWcxI82l+mQPuJ280aDNEmtFlFiKLXqLbNY7MbTDFP
         tUIU1P1Xw7TxmJsGgqRqoNUighofJ4vBz0XlPB7aLK03bf/QoVtIRmfNQldH4+nnnzEi
         WhjCw3srN6D2K+oMQeysAshES8etMoIhPd1mR9N3w+mPznN7MT8efBAO4Ug+KfR3Ewmd
         RkiA==
X-Gm-Message-State: AOJu0Yw3GsTeHwlY52zJvde1i2eIX1ej14n6vb/ODb0ZCghcgsyPyCU3
	mAHI+O+ITBeTJm1+nhMUagJl3xOwtAIq3IBBUyhKBqXIljCr/5kfI3KqfG9XNeh2sDx9zw==
X-Gm-Gg: ASbGncuHzNtjl2u4T63tx7MG/QqaM8Ce+OuiNs6A0emRC6kf3mK8+E67VkCmZYLXcD8
	+nvv5F/1WMlHP4O06P/q1RjhgQ1wFfQ5YSatFTtv4KCYGW//+Nrfs7kXvMCT6Qlx/Bxta/E5HJo
	SbbROvbDupEyhpfIlZ/NRCKs29UqHg7XbPtBm0wT6BBpSCsfrOw0C0XWVJq/0s8pLaxeQ2lMhqL
	l8oRpC+MPJkZ9bo/+qdWqb8sDAf3U+qLggZQzUg1OaamG2jMIHMwM9YVzVGvGgK8qaM6DlqRK20
	UJTICIYCVV7P9KxOlV17gmJxYlMErcnDFnn3Sxih29bruFY3SB5RHxZa8G6MPCcNGPw0sNFCLZz
	F/SqkUbRVdtfZb1VvUD/ZiOU1hVFXcAMGngODJvW9j8z2mZV4sMykhOoJB0BplIawHvgBKqz7Ic
	092U3J2+eZj03+h/nGvhDSGqqg
X-Google-Smtp-Source: AGHT+IEMdNz9Fmc12jWXTcv/fnh+qy3HVv4Rm1a0OlxUBcLOs1+Ombv+jZHLtgrWtNZLtivW4qfwDw==
X-Received: by 2002:a17:903:1b47:b0:295:543a:f7e3 with SMTP id d9443c01a7336-2986a6f0acdmr177344435ad.27.1763449461260;
        Mon, 17 Nov 2025 23:04:21 -0800 (PST)
Received: from gmail.com ([119.123.172.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2345e3sm161573215ad.1.2025.11.17.23.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 23:04:20 -0800 (PST)
From: jiefeng.z.zhang@gmail.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	irusskikh@marvell.com,
	Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
Subject: [PATCH net] net: atlantic: fix fragment overflow handling in RX path
Date: Tue, 18 Nov 2025 15:04:02 +0800
Message-Id: <20251118070402.56150-1-jiefeng.z.zhang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>

The atlantic driver can receive packets with more than MAX_SKB_FRAGS (17)
fragments when handling large multi-descriptor packets. This causes an
out-of-bounds write in skb_add_rx_frag_netmem() leading to kernel panic.

The issue occurs because the driver doesn't check the total number of
fragments before calling skb_add_rx_frag(). When a packet requires more
than MAX_SKB_FRAGS fragments, the fragment index exceeds the array bounds.

Add a check in __aq_ring_rx_clean() to ensure the total number of fragments
(including the initial header fragment and subsequent descriptor fragments)
does not exceed MAX_SKB_FRAGS. If it does, drop the packet gracefully
and increment the error counter.

Signed-off-by: Jiefeng Zhang <jiefeng.z.zhang@gmail.com>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index f21de0c21e52..51e0c6cc71d7 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -538,6 +538,7 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 		bool is_ptp_ring = aq_ptp_ring(self->aq_nic, self);
 		struct aq_ring_buff_s *buff_ = NULL;
 		struct sk_buff *skb = NULL;
+		unsigned int frag_cnt = 0U;
 		unsigned int next_ = 0U;
 		unsigned int i = 0U;
 		u16 hdr_len;
@@ -546,7 +547,6 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 			continue;
 
 		if (!buff->is_eop) {
-			unsigned int frag_cnt = 0U;
 			buff_ = buff;
 			do {
 				bool is_rsc_completed = true;
@@ -628,6 +628,30 @@ static int __aq_ring_rx_clean(struct aq_ring_s *self, struct napi_struct *napi,
 						  aq_buf_vaddr(&buff->rxdata),
 						  AQ_CFG_RX_HDR_SIZE);
 
+		/* Check if total fragments exceed MAX_SKB_FRAGS limit.
+		 * The total fragment count consists of:
+		 * - One fragment from the first buffer if (buff->len > hdr_len)
+		 * - frag_cnt fragments from subsequent descriptors
+		 * If the total exceeds MAX_SKB_FRAGS (17), we must drop the
+		 * packet to prevent an out-of-bounds write in skb_add_rx_frag().
+		 */
+		if (unlikely(((buff->len - hdr_len) > 0 ? 1 : 0) + frag_cnt > MAX_SKB_FRAGS)) {
+			/* Drop packet: fragment count exceeds kernel limit */
+			if (!buff->is_eop) {
+				buff_ = buff;
+				do {
+					next_ = buff_->next;
+					buff_ = &self->buff_ring[next_];
+					buff_->is_cleaned = 1;
+				} while (!buff_->is_eop);
+			}
+			u64_stats_update_begin(&self->stats.rx.syncp);
+			++self->stats.rx.errors;
+			u64_stats_update_end(&self->stats.rx.syncp);
+			dev_kfree_skb_any(skb);
+			continue;
+		}
+
 		memcpy(__skb_put(skb, hdr_len), aq_buf_vaddr(&buff->rxdata),
 		       ALIGN(hdr_len, sizeof(long)));
 
-- 
2.39.5


