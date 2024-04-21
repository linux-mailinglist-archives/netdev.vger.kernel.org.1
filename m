Return-Path: <netdev+bounces-89878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BA38AC05D
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65FA28122E
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 17:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E2383AF;
	Sun, 21 Apr 2024 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNHxDSXN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20625761
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721972; cv=none; b=nznU7fBcY1xySUmjH3Cg3Cq4zNiWbP+Ho4B2l0fVRktkDv23daJrSIqbgeea19NiokMB4KJcxnksq5uMDmS9cmgQoyEfi3iUuv+pwhyr5iSAKdLmG4Yfc6r8hZHJlWl6BqHLbtjTX37iuq1ggxyXdrhC0awfLcYxk94euPbN6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721972; c=relaxed/simple;
	bh=3Bk/nyWV4FtjWDBlj6QswWwmJfOqXkc7pgkUJEL4sGI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=u6uskx+y7Ry5szTFNFe7gZ4xNQCt6S/hb65/qpICNnrjr2G0Uh4WfHS8Ctg5JmyXIk+qQYzeC/3mjo/PYOysuseF7ojhJkvvGagADSnTWUoiWiOKH4o586UJ0j7+l8RamOLVVHNiG87lq4LFIDyZlf+WzCaCAHxEpggV7Qg0b9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNHxDSXN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d36b049so6051108276.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713721970; x=1714326770; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gv71F9ztEjVH6GItboyZC1upvXjIjDBgk0k5bCCSumw=;
        b=SNHxDSXNNafDy1DvMTkCcFpOks7A1vv+mYMpT76YFPF5wKTkC5a4w7O1NJd4to9t6O
         A3E+7HEThSPkWUtNwqhbvcoPInRRdA46BJ7hzthX/re6xCvIw59kfNIA5mFqG9sxkad8
         dS9ttu0jHo86n7i3nnAykaey26jar8Yi41i/4z1dWjNM9gYoBiJvMvICFjueKAVBgxwq
         UMIX4n7OwyQ6+ATs5RE44Zs/Zyd9ymcBhXda/bjxBGdSnKfvWc6CDTRcRQ4hq2gNWWd+
         /oKVvUZywWPXhcnUcCdZrdJzr4l6Ob5I7tBHmHVq0zfxIvDseIKnpRETnhzPie9tG08J
         GZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713721970; x=1714326770;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv71F9ztEjVH6GItboyZC1upvXjIjDBgk0k5bCCSumw=;
        b=PUM225QHTJQTwsDnQvI+B9yvoJPAsduhbIWcrh4qUa/JFX65trrj2bDZwO3fxqLHCN
         TEF9OGWyT1rkyd6Rxve0IF8phIt+6fjL1QHyickkqWAp7dmWgm4UCcYis7hYjl/Zvrd+
         wlNvgJ3RucPyWmaavAiUOKj7AG6/lY9CO+wljTbv4JQisaOzG8Fb4GIavAsCrXwNdfdI
         CL7t3bQK4ka9QHll0eTbgmi/EcdmNoI2X1f2Il/gccKavEM41YUyZlmfCGOiByfY2pbU
         1sPsglX/FsvJoEzsN+M9gTx9OiNFJ/TfO3L1pbx7F+HtEu2xCPzRprarvOE8w+6d2WP0
         krlg==
X-Gm-Message-State: AOJu0YxPoXYkdOguhULk74s0HFI6977aytPkcj7ykvYdEPeEPB+Gnasc
	mBItTtr2sKIulPE+2Vme0zG3DzKapYS/aMo8hk2DS1GBHXxzY9AgYGY02AQSNEKhUizUMLvcnI9
	hkfTZ7mpoOw==
X-Google-Smtp-Source: AGHT+IFfZfVmkSo1uhiZK4FrydWJqE8gmPW1qZ+YPbAFWrh5SsMx+Tfxohy9bQsChTWcCdkT8e80YER+qxp36Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:10c2:b0:de5:1e69:642c with SMTP
 id w2-20020a05690210c200b00de51e69642cmr128407ybu.5.1713721970386; Sun, 21
 Apr 2024 10:52:50 -0700 (PDT)
Date: Sun, 21 Apr 2024 17:52:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240421175248.1692552-1-edumazet@google.com>
Subject: [PATCH net] net: fix sk_memory_allocated_{add|sub} vs softirqs
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>, 
	Soheil Hassas Yeganeh <soheil@google.com>
Content-Type: text/plain; charset="UTF-8"

Jonathan Heathcote reported a regression caused by blamed commit
on aarch64 architecture.

x86 happens to have irq-safe __this_cpu_add_return()
and __this_cpu_sub(), but this is not generic.

I think my confusion came from "struct sock" argument,
because these helpers are called with a locked socket.
But the memory accounting is per-proto (and per-cpu after
the blamed commit). We might cleanup these helpers later
to directly accept a "struct proto *proto" argument.

Switch to this_cpu_add_return() and this_cpu_xchg()
operations, and get rid of preempt_disable()/preempt_enable() pairs.

Fast path becomes a bit faster as a result :)

Many thanks to Jonathan Heathcote for his awesome report and
investigations.

Fixes: 3cd3399dd7a8 ("net: implement per-cpu reserves for memory_allocated")
Reported-by: Jonathan Heathcote <jonathan.heathcote@bbc.co.uk>
Closes: https://lore.kernel.org/netdev/VI1PR01MB42407D7947B2EA448F1E04EFD10D2@VI1PR01MB4240.eurprd01.prod.exchangelabs.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Soheil Hassas Yeganeh <soheil@google.com>
---
 include/net/sock.h | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f57bfd8a2ad2deaedf3f351325ab9336ae040504..b4b553df7870c0290ae632c51828ad7161ba332d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1410,32 +1410,34 @@ sk_memory_allocated(const struct sock *sk)
 #define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
 extern int sysctl_mem_pcpu_rsv;
 
+static inline void proto_memory_pcpu_drain(struct proto *proto)
+{
+	int val = this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
+
+	if (val)
+		atomic_long_add(val, proto->memory_allocated);
+}
+
 static inline void
-sk_memory_allocated_add(struct sock *sk, int amt)
+sk_memory_allocated_add(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_add_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve >= READ_ONCE(sysctl_mem_pcpu_rsv)) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 static inline void
-sk_memory_allocated_sub(struct sock *sk, int amt)
+sk_memory_allocated_sub(const struct sock *sk, int val)
 {
-	int local_reserve;
+	struct proto *proto = sk->sk_prot;
 
-	preempt_disable();
-	local_reserve = __this_cpu_sub_return(*sk->sk_prot->per_cpu_fw_alloc, amt);
-	if (local_reserve <= -READ_ONCE(sysctl_mem_pcpu_rsv)) {
-		__this_cpu_sub(*sk->sk_prot->per_cpu_fw_alloc, local_reserve);
-		atomic_long_add(local_reserve, sk->sk_prot->memory_allocated);
-	}
-	preempt_enable();
+	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
 }
 
 #define SK_ALLOC_PERCPU_COUNTER_BATCH 16
-- 
2.44.0.769.g3c40516874-goog


