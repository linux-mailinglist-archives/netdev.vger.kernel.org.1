Return-Path: <netdev+bounces-246395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8ECEB1E7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 03:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A0A33007654
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 02:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0D82773CB;
	Wed, 31 Dec 2025 02:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArsgC8aJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SGnw6ERa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F639274B2A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 02:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767149669; cv=none; b=JCRFByaLl+5O1IomOHY7iqUZ+pS12iuIuka0k8sPYePd5A6yN+2xUzYnJRaLaTyDxQjJndsRSTirc/XIPWLpLyposfTVMj9GJnacztXtqfGSWW9uo2GXN+1GVaH9oVOCPsHgMt4+2ZD7aKDMTp/LJYekOas9LGGSRXEqA56r7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767149669; c=relaxed/simple;
	bh=ZfhT/g/KXKfyDI1I/BMzMejSaXPtB4iu884BXeXIILY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKl7H6SwU1I+iE9smL+c4L1oC7Q0SScCOS1g8SvyMZV6c8RasY00JAZhCx4RUbNzlRMMVr5K/L4v3lVoWRqMbsyxuAW02cYTt5xtnJu1kyPyHCIa80Nyp+Ri5mR+NP4QgGO1eudoXQPtab+x4ktgCQK7xrEMjmUBSbeVGfyl7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArsgC8aJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SGnw6ERa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767149666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Ci8Uj4n1LPHgZebXoB/5YEcgElZddA0d+SGTjdwxBk=;
	b=ArsgC8aJKIPHIdaj6ZJl2wT+BpObUEto9svK3gvf2lV0NPLtAVUW0f2e1wtuSrtojBMVG6
	k4jZC/Kv41ymwjkxfmATaSzFSoskNYU+03UWrmHt9igiSjkaGtKNu0X2MVRrKsdPHJArvH
	z5RooPYvKi4BRiCM/WhFRzOT8eUipbY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-BZILgek3PjuobIVp8YOm2g-1; Tue, 30 Dec 2025 21:54:24 -0500
X-MC-Unique: BZILgek3PjuobIVp8YOm2g-1
X-Mimecast-MFC-AGG-ID: BZILgek3PjuobIVp8YOm2g_1767149664
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f527f5easo6179154f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 18:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767149663; x=1767754463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ci8Uj4n1LPHgZebXoB/5YEcgElZddA0d+SGTjdwxBk=;
        b=SGnw6ERamwI0FQJNe309QbnUdgdPkLxsqfE7bIMGmU6gJmxwKrGpce4hPjgAXOvSG+
         jXTN7+Ip/9lFJH4gkIIOcrwwKkzu0HyQnzYTh2X3cAJjq2ivEsjH1NfA7jwdTe7bWMnm
         URvWdvmcTMgQVJ9ptF1v2mbdw5YRj3ai+js5FlFKkT2SqaUn7x6hZO2853xEVQnrhePg
         U8sHVP5J6lY71ThNKgqWEcqZOegpmTuEr00gdSAxicsiDCsBEm4KgTXFjjgTC11MLaf5
         kq6Z2poPvFmZ2dq4zoQbjZi/d73I9DN90bVRHwOj9hUIrU2yFgUsNGbVidzQPky7fFtw
         KkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767149663; x=1767754463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ci8Uj4n1LPHgZebXoB/5YEcgElZddA0d+SGTjdwxBk=;
        b=XV/PCcgFutUBQbnjaXQ/802q2JlkLHjIWhuYSH31vQq5Wg7I8xevD+WWjDORCpqvHk
         GXxfkQ7fZSqim7rAEIS1pPLZLA2hz4O940WHol54V0xZG13FR2n3caZF+uo9s1zhhcf4
         cj7QfrcFGwV6I40+esRSdKO3UGtB4qzrraxTMeBvz6+TmMdKPhjfLC4fk2BDXtVP35b4
         u2Bj/2wbVpuTWvq4bBRYJKKzgeqJZDk7AlnZtrprHVLTs2VJW9FEk0jC5iFfen0V+DZR
         LftnoRZq/xYmKlPO3HPyL7yI9drE5U5yD9/W48yBAPkyhomqd5khynBd2p1oFUCb1tzi
         XC+Q==
X-Gm-Message-State: AOJu0YwAStLmXrdRZ9Z/Rhjms6H81LMdIULKbQqrBhAPpr4P4BhrVYme
	lEQ9Te2dlPoraS2Jqr0gp5iycjWgh8iA66/HHju5Iugsvfw+0kTeajg93L2cPwS7dSfhTSf3NHd
	a8rEuI123/6bOnbswgHRylwCAB3sR8qOOO3HQlLESlW9e2eph8vsBBWAUQVLcMn9lyCnOqjiMn8
	bPbM70ww6yNlRncz3p9PmoTSvY9l1doh5eAE2DaA==
X-Gm-Gg: AY/fxX6ab23bicoukImfeeho1BYYD2jB/WqYt1tRo7uZn/uZEOs3PfDucdhWq4PhgHG
	CKvivG9wZ67+BJYGnMwSkLyJXwL8Cg/XvBz0tf6RQUREQ1KwPQe37pntf/aQwEWfG54tWu2U9NI
	gByiFRdZhQTqIzC6CYY7pgnjHgH+fgiWLbClnpkfR2AcRYf3zDyPpdugrSfZk/pINmjfLfgGWwW
	erqeiozF8XxROujVPqsAoOfuOrq+dKkZ1MxagTCMGsABjFVUldEhXnoQ2brZvaLPCG2cX9wBv1d
	zHCBZm4o70XdRYUnQU/FDQWhCJ1Nd+3EGbkZvGp5r0A8sBL/XMS7zXq3dM1zxXqwSa/I3d76l49
	1GOG7GWwf2TbTpq8pJM2kIrE=
X-Received: by 2002:a05:600c:828d:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47d20502f98mr321882695e9.10.1767149663367;
        Tue, 30 Dec 2025 18:54:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXyY9SNQaOqW5dzTdsToa8HRodCjlWWkzkH1jaaxruL8NcW5OPk4PZyT78Tl7K83rC5mi4YQ==
X-Received: by 2002:a05:600c:828d:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47d20502f98mr321882515e9.10.1767149662975;
        Tue, 30 Dec 2025 18:54:22 -0800 (PST)
Received: from fedora.redhat.com ([216.128.14.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm689497605e9.7.2025.12.30.18.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:54:21 -0800 (PST)
From: mheib@redhat.com
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kernelxing@tencent.com,
	kuniyu@google.com,
	willemdebruijn.kernel@gmail.com,
	atenart@kernel.org,
	aleksander.lobakin@intel.com,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH net v2] net: skbuff: fix truesize and head state corruption in skb_segment_list
Date: Wed, 31 Dec 2025 04:54:14 +0200
Message-ID: <20251231025414.149005-1-mheib@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

When skb_segment_list is called during packet forwarding through
a bridge or VXLAN, it assumes that every fragment in a frag_list
carries its own socket ownership and head state. While this is true for
GSO packets created by the transmit path (via __ip_append_data), it is
not true for packets built by the GRO receive path.

In the GRO path, fragments are "orphans" (skb->sk == NULL) and were
never charged to a socket. However, the current logic in
skb_segment_list unconditionally adds every fragment's truesize to
delta_truesize and subsequently subtracts this from the parent SKB.

This results a memory accounting leak, Since GRO fragments were never
charged to the socket in the first place, the "refund" results in the
parent SKB returning less memory than originally charged when it is
finally freed. This leads to a permanent leak in sk_wmem_alloc, which
prevents the socket from being destroyed, resulting in a persistent memory
leak of the socket object and its related metadata.

The leak can be observed via KMEMLEAK when tearing down the networking
environment:

unreferenced object 0xffff8881e6eb9100 (size 2048):
  comm "ping", pid 6720, jiffies 4295492526
  backtrace:
    kmem_cache_alloc_noprof+0x5c6/0x800
    sk_prot_alloc+0x5b/0x220
    sk_alloc+0x35/0xa00
    inet6_create.part.0+0x303/0x10d0
    __sock_create+0x248/0x640
    __sys_socket+0x11b/0x1d0

This patch modifies skb_segment_list to only perform head state release
and truesize subtraction if the fragment explicitly owns a socket
reference. For GRO-forwarded packets where fragments are not owners,
the parent maintains the full truesize and acts as the single anchor for
the memory refund upon destruction.

Fixes: ed4cccef64c1 ("gro: fix ownership transfer")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 net/core/skbuff.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a00808f7be6a..63d3d76162ef 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4656,7 +4656,14 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 		list_skb = list_skb->next;
 
 		err = 0;
-		delta_truesize += nskb->truesize;
+
+		/* Only track truesize delta and release head state for fragments
+		 * that own a socket. GRO-forwarded fragments (sk == NULL) rely on
+		 * the parent SKB for memory accounting.
+		 */
+		if (nskb->sk)
+			delta_truesize += nskb->truesize;
+
 		if (skb_shared(nskb)) {
 			tmp = skb_clone(nskb, GFP_ATOMIC);
 			if (tmp) {
@@ -4684,7 +4691,12 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 
 		skb_push(nskb, -skb_network_offset(nskb) + offset);
 
-		skb_release_head_state(nskb);
+		/* For GRO-forwarded packets, fragments have no head state
+		 * (no sk/destructor) to release. Skip this.
+		 */
+		if (nskb->sk)
+			skb_release_head_state(nskb);
+
 		len_diff = skb_network_header_len(nskb) - skb_network_header_len(skb);
 		__copy_skb_header(nskb, skb);
 
-- 
2.52.0


