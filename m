Return-Path: <netdev+bounces-284418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAMoHzzz+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:40:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 135204CEABE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 259D23061E8F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729C447886A;
	Tue,  5 May 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VkGQS3/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A49447D930
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987957; cv=none; b=oi56Ytmq4gyGGIA5PKwU4PuPIzN8+/UJ+9vZq1SDc24glG00zYRjjvYFzBeqVatj3WAT5syGtposV1zi/rMQe3AyxmKCuVjQA8f3lisjlAS66C/WnbPmGUWv+niEyUCEjfX9DiIgisJ+Q48N5QU6qP2THvUtgq7foZN5kiipQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987957; c=relaxed/simple;
	bh=O2FHuiyQxSB6zDAdOL0TVbP80yOtms/h2T5kCsUoB24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=imqR1dJ12VMi985lAwUKBTjZycmaCu+5GjgCmNJjQMe8MnwZW5V+4/gRpG2HUnKsktxt8LpAReNRnIv4l2We21odyt6/5B8KhyzDH97cnNdG8f2iA5U9nMPMEsPv0YB5jltKjO6TUc74sXzhVIq0AtZRQLUWJqYMfpuJDB6Srok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VkGQS3/D; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7bd8cb261c3so45123677b3.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777987954; x=1778592754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z4Q/osjFtRsil5bbkM0j8g06TmrSjcLd1kYJ1RIZHUI=;
        b=VkGQS3/DwMd4c2s9yHu0uBd5HVb8fjhpoVBz47ZTnNqgy5NU7u+Y+Fm54nvZ29fVyR
         ItttXNKbJZka4lMKVZA7SG9xv5DE8n7vPpDCl+stj2TxqvAHTeN4vqAxY7RanIwPCBqB
         laolI5RQxsag+HVyhlFa0BPz4Y0sny9AIQp+gv8tgtIz4GDHdRXknHnEhSpeEstihe9j
         mlHlWTXy4X9QdIJbOUxmYlXuvGuqFRdzI9XcECwL5RMKzQiWPD11PVhuq+1fol7E9xqL
         3DsUvPIPeLtR9vYl5YNKYPzgL+SU/DFMC/3qhvqpIaslEa2klRyr0cu/E9TcRmBPLxD3
         HA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987954; x=1778592754;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z4Q/osjFtRsil5bbkM0j8g06TmrSjcLd1kYJ1RIZHUI=;
        b=O2pKFU/z85IYt/HY3nbPuJeYjkqqBjePHbLV+5ryFNFzwuF4fhlW6WoSBKPl/M3BLL
         hSsPA2w8K02nweqjURQndrh0ujcAXMLK49ujMF3dHgNvKhfmmyBVyveC/uDfGMaG0Dda
         VcxIEGAAJWogBjrEH5EHmZnhpTMqjIY6BDBfH4mrkkvWhj/etWghuPvMm4bIJ+rWl8pR
         8RFVx/aeP9iTQOGBQGp33/QKqUOmULlDdUqfS0oqgu7WbM8ecTS2NvwBThaDPZcueLQr
         lxfQBD4JH5M1Yyx73S/J2AOz4/XGTRf4MZDFGKp8rKVPYRivkWoZ+4Teyt8Yz99SCYPr
         K/mw==
X-Forwarded-Encrypted: i=1; AFNElJ+lbZpTTDYUhIJebJ5iSdr9F7PWa4DCDhPuQfzxXY5FLObyUQAOdky5mHh62vZXwXSbfjxu0uo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Srf0FtgFc0/TIxzuKvrjWCLL1rJi398s1Zm7G7znBlLBJmA+
	GUk25u7H3JJSEDIWlyaIFKYTs0VGdBawwt4nzM6HssalrDhJEPV4UZWzVK/UpodbU9lOKFLrH87
	MtdAGhW7eCmRCQg==
X-Received: from yxf25.prod.google.com ([2002:a53:b119:0:b0:650:1bff:6046])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:4185:b0:65c:47ad:26c3 with SMTP id 956f58d0204a3-65c47ad2d7amr10597372d50.25.1777987954093;
 Tue, 05 May 2026 06:32:34 -0700 (PDT)
Date: Tue,  5 May 2026 13:32:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505133233.3039575-1-edumazet@google.com>
Subject: [PATCH net] inetpeer: add a missing read_seqretry() in inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Damiano Melotti <melotti@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 135204CEABE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284418-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When performing a lockless lookup over the inet_peer rbtree,
if a matching node is found, inet_getpeer() returns it immediately
without validating the seqlock sequence.

This missing check introduces a race condition:

Trigger Path: When a host receives an incoming fragmented IPv4 packet,
ip4_frag_init() (in net/ipv4/ip_fragment.c) calls inet_getpeer_v4()
to track the peer.

The Race: If the packet is from a new source IP, CPU A acquires the
write_seqlock, allocates a new inet_peer node (p), sets its IP address
(daddr), and links it to the rbtree (rb_link_node).

Uninitialized Access: Due to the lack of memory barriers between
rb_link_node and the initialization of the rest of the struct
(like refcount_set(&p->refcnt, 1)), CPU A can make the node visible
to readers before its refcnt is initialized.
This is especially true on weakly-ordered architectures like ARM64
where the CPU can reorder the memory stores.

Lockless Reader: Concurrently, CPU B processes a second fragmented packet
from the same source IP. CPU B does a lockless lookup, finds the newly
inserted node, and returns it immediately.

Use-After-Free (UAF): CPU B reads p->refcnt as uninitialized garbage
(left over from previous kmalloc-128/192 allocations).
If the garbage is > 0, refcount_inc_not_zero(&p->refcnt) succeeds.
CPU A then executes refcount_set(&p->refcnt, 1), overwriting CPU B's increment.
When CPU B finishes with the fragment queue, it calls inet_putpeer(),
which drops the refcount to 0 and frees the node via RCU.
The node is now freed but remains linked in the rbtree,
resulting in a Use-After-Free in the rbtree.

Fixes: b145425f269a ("inetpeer: remove AVL implementation in favor of RB tree")
Reported-by: Damiano Melotti <melotti@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/inetpeer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index d8083b9033c2722bc03876da91b4f0b83da003b8..5b957a831e7c39f2e9b224469f0eba4703833475 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -179,7 +179,8 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
 
-	if (p)
+	/* Make sure tree was not modified during our lookup. */
+	if (p && !read_seqretry(&base->lock, seq))
 		return p;
 
 	/* retry an exact lookup, taking the lock before.
-- 
2.54.0.545.g6539524ca2-goog


