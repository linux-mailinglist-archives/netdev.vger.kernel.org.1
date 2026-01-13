Return-Path: <netdev+bounces-249553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB367D1AEAD
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F57F300C0CC
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84334D915;
	Tue, 13 Jan 2026 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2TRaVXDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF3E30DEAC
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330491; cv=none; b=WyFi49mp97BWQwQYIgNKtSqmGLajWDz48HQL003UNoc8oY0VivDKjGcj0Hww8n7AA+yuZ/Ckw1Wiw8K4jHtV5RxBby9g0h2KWArUaowJXxk0dpHU2NBEx+vrL1HZdoH1ddcEz5nrsI2Rmpnzzisdk/t/O11wZFYqaaUDIQZJ5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330491; c=relaxed/simple;
	bh=rAy3yooNBLjH8MpcXBQu414KwY6i2PXFMSX45Ekp1Jw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ANBO8dQNdypvrsSsF/q4x8bJ8UmmuR+MXgyvvQx1rXzegen/+VnU46KDBXoBc71ekLGu74kxzYBOSL6N1lsD98cWIURh+1/S9lSX2yJf7fLwXEGHOZFDc71oLubjXgB6L6WhXxWf3eilD5LtG81fc6L9EEu4XxB7ZQ5R+OBZIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2TRaVXDM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f27176aa7so115278895ad.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768330489; x=1768935289; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2L0ZmDOwqQEFT1x/tt2l42V00vJsq1Kz90dfZa40+gI=;
        b=2TRaVXDMeIoMrm14fkxVIDel5VvofYhoyLjCF4jlsixr5YJWZXrwneVVl6rxWSiz4r
         hWvnKGMvKZyec9bWEwnir9c6X3VVgE1vqTuastncKyKUdz3ubMSO8tBKUQoSDczjq60q
         Rccve8L0e5fwXzgJDGXQdQ9XzHkWvRY8aa7oF7rT6uzZuLGf/sxv5R+CtzpVQMD2N07z
         E6Fyir//FKEdFZJ//TDuX5PkeOXrf57BPwF/xICNzWX60u1weSSIVkqojXPy8Ngk742t
         qbTawM/BQVkXoKPwzHu/ANUQO+Y/72UJHW2yJRKIGRkOaD6r5dF3GOVL0RZgOYzNW8TU
         d3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330489; x=1768935289;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2L0ZmDOwqQEFT1x/tt2l42V00vJsq1Kz90dfZa40+gI=;
        b=eGchuCHLHW8ywD8fIMLxECyVh1qOjRpNnm+ohmpv24d1rQ8OQjlP/mZuRX5NIfFA+/
         P7n0EmE4C+z2HLI7lqS/PPdatSG4nFpVZz8F3IgdJvJnzxLRfDKrR7QfGQ3kYAonSXYc
         eBd/KJ4sx5ROpHUQX83j3j5uzntlrx4tamHymBtU9BU156tZd1+cuPgCLB7k0cbj4Itc
         sE3IS8xgb3zX5FEjFGrA7Zby5r1TBm+uGDVYu2X4REMgKd9NnqcNdSp1tK6Oei5wdtPL
         kbvPsTQXcnWFAQKmcD1XkYL5uArIjvKTJdifwhGxVmfY98KgG8IXOezlRh2i6WWvR49C
         5t1A==
X-Forwarded-Encrypted: i=1; AJvYcCVLxKO2ZNaHfqmVbMia0MOEaNUjJzhzviFqM/ZfogJIDbg8JmibfX0AvIk7FsZyD+p58TVuS7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt7x+sbW9DiCaowxT7+sIAdjtKXJ5RSSXiT2moU8ykgXzDD3N5
	MyEueZdkh/XbUNwh06w2GyyIWcCFmk2hyYJC1tBNzDYPXaiRDBEoPsa4RfZWfBX/STDYXuToEOh
	wpiKYGw==
X-Received: from pjbge11.prod.google.com ([2002:a17:90b:e0b:b0:34c:e366:3f3f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec90:b0:298:2637:800b
 with SMTP id d9443c01a7336-2a599e34891mr115855ad.31.1768330489041; Tue, 13
 Jan 2026 10:54:49 -0800 (PST)
Date: Tue, 13 Jan 2026 18:54:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260113185446.2533333-1-kuniyu@google.com>
Subject: [PATCH v1 net] l2tp: Fix memleak in l2tp_udp_encap_recv().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported memleak of struct l2tp_session, l2tp_tunnel,
sock, etc. [0]

The cited commit moved down the validation of the protocol
version in l2tp_udp_encap_recv().

The new place requires an extra error handling to avoid the
memleak.

Let's call l2tp_session_put() there.

[0]:
BUG: memory leak
unreferenced object 0xffff88810a290200 (size 512):
  comm "syz.0.17", pid 6086, jiffies 4294944299
  hex dump (first 32 bytes):
    7d eb 04 0c 00 00 00 00 01 00 00 00 00 00 00 00  }...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc babb6a4f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    __do_kmalloc_node mm/slub.c:5656 [inline]
    __kmalloc_noprof+0x3e0/0x660 mm/slub.c:5669
    kmalloc_noprof include/linux/slab.h:961 [inline]
    kzalloc_noprof include/linux/slab.h:1094 [inline]
    l2tp_session_create+0x3a/0x3b0 net/l2tp/l2tp_core.c:1778
    pppol2tp_connect+0x48b/0x920 net/l2tp/l2tp_ppp.c:755
    __sys_connect_file+0x7a/0xb0 net/socket.c:2089
    __sys_connect+0xde/0x110 net/socket.c:2108
    __do_sys_connect net/socket.c:2114 [inline]
    __se_sys_connect net/socket.c:2111 [inline]
    __x64_sys_connect+0x1c/0x30 net/socket.c:2111
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 364798056f518 ("l2tp: Support different protocol versions with same IP/port quadruple")
Reported-by: syzbot+2c42ea4485b29beb0643@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/696693f2.a70a0220.245e30.0001.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/l2tp/l2tp_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 687c1366a4d0f..70335667ef037 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1086,8 +1086,10 @@ int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	tunnel = session->tunnel;
 
 	/* Check protocol version */
-	if (version != tunnel->version)
+	if (version != tunnel->version) {
+		l2tp_session_put(session);
 		goto invalid;
+	}
 
 	if (version == L2TP_HDR_VER_3 &&
 	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
-- 
2.52.0.457.g6b5491de43-goog


