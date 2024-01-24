Return-Path: <netdev+bounces-65510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC6F83AE0B
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9960B1F21AF0
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3F77CF18;
	Wed, 24 Jan 2024 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVJulX7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8477C0BD
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706112647; cv=none; b=cl75eHm1k2IsNr7uAE3B/Iaxx79EWgQtMCfH3mp2YZEF7/W8AiJ87gHu2uVbiWXoAz3oQDC7hF8J3AtBu6sagts1AQ+sIXkYCnGb1c9+o5q4Seuo1mWQYCsUncatTfiIcPhYiRZ8zyUOdKSGJPTZ95BTVCffDilI7gVaYZYyQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706112647; c=relaxed/simple;
	bh=14+iqBeVD9ZtJcK5xsKcKLvFsR2WUCXk0co6Bbfojlo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ro4l/BAijCfRDGAnk8wWaJsEP8mLIfvJ5r7GDZPQVxdeL85hJuZecHbcQM6gIIFgKLLaskoZ+DYjjNXbJpHw5s6BE4SO5GreghCynx/JqUhxMS7l4mwfIF8G+DW3y9hq4XKAgOkV00IZjxjOr7U7IVN7hAmjVQFUVen4rJWxks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVJulX7r; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-291041c44e2so237009a91.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706112645; x=1706717445; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7mXpnA5UwK8efRQZtD5qbWdHNoXALh+/9vmjo88DPjk=;
        b=AVJulX7r1WJH3RJu1IB9pig6lZMbsMimVDBSzkWCmGRmyyYDdzDh50Soonk/4XIz/b
         sOh7S0i/Pr0kVMdocEzI+8oN4F9ZocQ3h0AFFE11QEkZgfSF+5cHrn1g6cO31enwd9wa
         y/pmhT2zrQ7J0YbuY33w4PH2ZG3hMNJV3/3pnSSRvRYMFN93PP/i8kofQQeTWwzkIHoP
         wu5Xus1Ub1jApxQzGiPpLa3NWF/J+UYGguyh3i1MPdBCf5G22F1QEDziDko1OkdobvXW
         hI6UQ9OI3v8CuqFeW3Qy1zWdw3ijEINQtehzPk8vtEKdqpgZhJD8xEe3pHqzl9dqoJG/
         /iHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706112645; x=1706717445;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mXpnA5UwK8efRQZtD5qbWdHNoXALh+/9vmjo88DPjk=;
        b=vEQiuWKq/B6lYdod3xhON8aVbZTbVHmHNic4bJxKib50qCcI3BP84OY79xaCvUW7Ab
         rr2VlacNU/NADxgbDo8MF40jskTmUXS8xSPlKGJUQBZgCPc3PhIPQFKyQhXOJMLRMf+h
         9S6BFZs0Cofv9xaSqRpkW9OhXiB9RA0DPsPJU5Dnwbw+0yocW0FYf8vQszpietcnZzEv
         RYHLFy7ZozZmMdFWXWosWkaea7qdPULvQQ/gysUars3FKy07ex2ej6lfJeL0RZEdJ7cz
         /otV6bweo5tdKSpXjhmluqgudNFsOKRU8DdoXXw0M43cH+56f+gLVV1RicyWvgxxzR7Q
         KooQ==
X-Gm-Message-State: AOJu0YzZfO83sPd9JtKdj/jJ+8PL7lThLDH1TP7X7Io2H/8MtVG114qa
	Y7U5Smbt2De0IT4062EbT4L7KqS/B1qTK9kjy9owLWBKtiTDV3kgQnGu0g2JdlPCt1DyO26SjBL
	du+G0zpjjCdfplnZbOf44FuwdzkSddAhUpGwfCJV+f6X1W1eKsSujqQ6y6yshO2jQW8lWdPmX3n
	RhSGhtt/Rc52OMY5dK79virL96cvPWYkoD+z0ToZS9s4YcIizWnub0XABX8W8WhtqZ
X-Google-Smtp-Source: AGHT+IEk991lG/xhHU+U8w5c0Pl/ptIXHvdHNLifVwlJOSA9eZ4SiPrZooKLaBf+9roav3O8HgZ2OpfpiyBtSr1s23U=
X-Received: from pkaligineedi.sea.corp.google.com ([2620:15c:11c:202:5bff:7416:b04f:2886])
 (user=pkaligineedi job=sendgmr) by 2002:a17:90a:fb50:b0:28d:8d11:6552 with
 SMTP id iq16-20020a17090afb5000b0028d8d116552mr42167pjb.4.1706112645029; Wed,
 24 Jan 2024 08:10:45 -0800 (PST)
Date: Wed, 24 Jan 2024 08:10:25 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240124161025.1819836-1-pkaligineedi@google.com>
Subject: [PATCH net] gve: Fix skb truesize underestimation
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, shailend@google.com, 
	jfraker@google.com, stable@kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

For a skb frag with a newly allocated copy page, the true size is
incorrectly set to packet buffer size. It should be set to PAGE_SIZE
instead.

Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 7a8dc5386fff..76615d47e055 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -356,7 +356,7 @@ static enum pkt_hash_types gve_rss_type(__be16 pkt_flags)
 
 static struct sk_buff *gve_rx_add_frags(struct napi_struct *napi,
 					struct gve_rx_slot_page_info *page_info,
-					u16 packet_buffer_size, u16 len,
+					unsigned int truesize, u16 len,
 					struct gve_rx_ctx *ctx)
 {
 	u32 offset = page_info->page_offset + page_info->pad;
@@ -389,10 +389,10 @@ static struct sk_buff *gve_rx_add_frags(struct napi_struct *napi,
 	if (skb != ctx->skb_head) {
 		ctx->skb_head->len += len;
 		ctx->skb_head->data_len += len;
-		ctx->skb_head->truesize += packet_buffer_size;
+		ctx->skb_head->truesize += truesize;
 	}
 	skb_add_rx_frag(skb, num_frags, page_info->page,
-			offset, len, packet_buffer_size);
+			offset, len, truesize);
 
 	return ctx->skb_head;
 }
@@ -486,7 +486,7 @@ static struct sk_buff *gve_rx_copy_to_pool(struct gve_rx_ring *rx,
 
 		memcpy(alloc_page_info.page_address, src, page_info->pad + len);
 		skb = gve_rx_add_frags(napi, &alloc_page_info,
-				       rx->packet_buffer_size,
+				       PAGE_SIZE,
 				       len, ctx);
 
 		u64_stats_update_begin(&rx->statss);
-- 
2.43.0.429.g432eaa2c6b-goog


