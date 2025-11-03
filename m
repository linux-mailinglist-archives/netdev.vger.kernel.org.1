Return-Path: <netdev+bounces-235189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501A5C2D4CF
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F743A867C
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E19331A545;
	Mon,  3 Nov 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YdWvraUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4133164A6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188783; cv=none; b=Blu1/77uC+KAa+OwRRiSJRv9wAu9fBwGKFuPW18MJ8pCopuncP0JCsDB6Dp6XNfeCMeKDcExgaUoGh+43dfLoU6BhjRZofO5/mrid9EB9sI9rmsYEqwmP7prL0jwCJMJ0TrB+tmOyXBoZkfXVwLLo9RtQRd+cKyoobCvs7iSb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188783; c=relaxed/simple;
	bh=qmBYKv77WZg1JaE2jVaTU7XQCAo2hhpIhkHJTjDwAbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ezHJLrY9CNViC0fzJ94EzSN0e7ALnWSR1ZSl19K2fhl2ePtx7JtWOeBqWlgeNVbc4iyohYXtkG5ldtKiMCt6sJkzHeatbJ20IVQqka8DIUqTxaq+dLk26ooVvvsp3+tL27ZTe6LBJ6qWL7lq6cVkgyJXCm9iZ1GCX5i9N6A2noQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YdWvraUX; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8804dd4acafso68840006d6.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 08:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762188781; x=1762793581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fk2EF1/javBbUuocueCNicWijFan1orkGpSmfIjUjGE=;
        b=YdWvraUXhV8vadM2wrEnJLGQIfDCRYlsj7DBaaP+nQENhRa8Gy3d1kQ+IK2w4PBLNG
         eYTt1p7OfAQIrUXCeuX8PGphZu02NN7HGV9XveFX+LAqSg1+LyFXFirsMP1ZbGbkCJdZ
         aGDCAG841Pmvjgf1jwex8cXTh+I81mRXx5OHXni/Z/geBlSNLtCmwwxh9PPadySzu+FD
         A5mBaOpx0tMEaEnfR8DUDiYMLRHz3ZoWUWRO2Zn45p5wly/hag+/Z+/rww3O2I/VgVoz
         3kGlIH+b9GIQlw9w410SpAnK+NUCMHRViPFJv08mY7keODLsizMc865cvG5tuVEfkDPn
         smRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188781; x=1762793581;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fk2EF1/javBbUuocueCNicWijFan1orkGpSmfIjUjGE=;
        b=Ticqhr3Ll32NsQA800g2ENFmwEnPjT3i8sCj8F43HkPWhcQw/ocuIrRwEPLDbGdDNu
         WDIrbuJVWSdzzpNDc7GOD8JY1in5yfLJ7TzOye3W+GJz/JELv2WnU2k67c6ebD3eg72Z
         mxh0MpzU+y3PB0Ag5aEHK3EHSiiJWYdjDHqMOBCE5b47+QU2d6nmWoTEkxevhf/Ldt5i
         iu9Li1L7bxBP5hPFvgBkrXnVlgXHQm2fPWqyZgZgrmj7wfYnk0slD4PjjAV8c3XD+3tF
         gCbJ861df1JqsnpizTl+uS40/ut6KLsr43hL4IUOza3KmdsxpwHKmh2bGcOvVaxeCCXE
         VdHA==
X-Forwarded-Encrypted: i=1; AJvYcCULgW4mpvZCK3FSFVrTwLvm/XaPr5086dgmbChbEj+0ypGkDpfFe9AXiN9ZUTujqPHBI/d++UA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6h4MHC2V5awbhh+1A1E2+NkhtbejJOOV1MkIDxzuci4kMpPoR
	PJjPLUCFtKiueDp0pdbydQ31r1yNciEuDmg036t8Wsi55krJz2K+MCqn2ueum6TYZUH1HtFrJUZ
	i0E9zL7Kfq59YYw==
X-Google-Smtp-Source: AGHT+IG5FSQ4KN4e7cLAJINVAwNkmvKLCDJGlWsLOYXixdUGbCiVJoh305FUYUabxV7D6RJ6Od1HFFFy11YaOQ==
X-Received: from qvbre2.prod.google.com ([2002:a05:6214:5e02:b0:87f:fa55:64e5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5806:0:b0:4ec:f49c:af11 with SMTP id d75a77b69052e-4ed30f9c90amr168422131cf.46.1762188780505;
 Mon, 03 Nov 2025 08:53:00 -0800 (PST)
Date: Mon,  3 Nov 2025 16:52:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251103165256.1712169-1-edumazet@google.com>
Subject: [PATCH net-next] net: mark deliver_skb() as unlikely and not inlined
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

deliver_skb() should not be inlined as is it not called
in the fast path.

Add unlikely() clauses giving hints to the compiler about this fact.

Before this patch:

size net/core/dev.o
   text	   data	    bss	    dec	    hex	filename
 121794	  13330	    176	 135300	  21084	net/core/dev.o

__netif_receive_skb_core() size on x86_64 : 4080 bytes.

After:

size net/core/dev.o
  text	   data	    bss	    dec	    hex	filenamee
 120330	  13338	    176	 133844	  20ad4	net/core/dev.o

__netif_receive_skb_core() size on x86_64 : 2781 bytes.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index dccc1176f3c6565f96a7e2b5f42d009ef6435496..6886632b57605778284bb3dabdd05dfae5df37e0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2463,9 +2463,9 @@ int dev_forward_skb_nomtu(struct net_device *dev, struct sk_buff *skb)
 	return __dev_forward_skb2(dev, skb, false) ?: netif_rx_internal(skb);
 }
 
-static inline int deliver_skb(struct sk_buff *skb,
-			      struct packet_type *pt_prev,
-			      struct net_device *orig_dev)
+static int deliver_skb(struct sk_buff *skb,
+		       struct packet_type *pt_prev,
+		       struct net_device *orig_dev)
 {
 	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC)))
 		return -ENOMEM;
@@ -2484,7 +2484,7 @@ static inline void deliver_ptype_list_skb(struct sk_buff *skb,
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
 		if (ptype->type != type)
 			continue;
-		if (pt_prev)
+		if (unlikely(pt_prev))
 			deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
 	}
@@ -2545,7 +2545,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 		if (skb_loop_sk(ptype, skb))
 			continue;
 
-		if (pt_prev) {
+		if (unlikely(pt_prev)) {
 			deliver_skb(skb2, pt_prev, skb->dev);
 			pt_prev = ptype;
 			continue;
@@ -4421,7 +4421,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
 		return skb;
 
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
-	if (*pt_prev) {
+	if (unlikely(*pt_prev)) {
 		*ret = deliver_skb(skb, *pt_prev, orig_dev);
 		*pt_prev = NULL;
 	}
@@ -5883,7 +5883,7 @@ static inline int nf_ingress(struct sk_buff *skb, struct packet_type **pt_prev,
 	if (nf_hook_ingress_active(skb)) {
 		int ingress_retval;
 
-		if (*pt_prev) {
+		if (unlikely(*pt_prev)) {
 			*ret = deliver_skb(skb, *pt_prev, orig_dev);
 			*pt_prev = NULL;
 		}
@@ -5960,13 +5960,13 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 
 	list_for_each_entry_rcu(ptype, &dev_net_rcu(skb->dev)->ptype_all,
 				list) {
-		if (pt_prev)
+		if (unlikely(pt_prev))
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
 	}
 
 	list_for_each_entry_rcu(ptype, &skb->dev->ptype_all, list) {
-		if (pt_prev)
+		if (unlikely(pt_prev))
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 		pt_prev = ptype;
 	}
@@ -5997,7 +5997,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (skb_vlan_tag_present(skb)) {
-		if (pt_prev) {
+		if (unlikely(pt_prev)) {
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 			pt_prev = NULL;
 		}
@@ -6009,7 +6009,7 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 
 	rx_handler = rcu_dereference(skb->dev->rx_handler);
 	if (rx_handler) {
-		if (pt_prev) {
+		if (unlikely(pt_prev)) {
 			ret = deliver_skb(skb, pt_prev, orig_dev);
 			pt_prev = NULL;
 		}
-- 
2.51.1.930.gacf6e81ea2-goog


