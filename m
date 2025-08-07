Return-Path: <netdev+bounces-212060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2DBB1D9E2
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6B87581F88
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8014A60C;
	Thu,  7 Aug 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vdEFAP8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEF02B2DA
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754576510; cv=none; b=A5q6Lrh+5JIJDi/VtkxVd/nG+rlOR602E95OqQ56k0M3R14prrGvhAc5S+MfYw8u7twhKneHNoxJDJZoeXR2AmRWsJ4HQAgTXll6YIPpkDzcAjvvnT9QiRAxIV/o1c7sI3lAwo5LMnVstPhN4wNFo080GsDYMSkbW+B8uwDDeI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754576510; c=relaxed/simple;
	bh=Xa9tcoIjNBJAIAojX3oKOnB0qv9qi9XLbZ+LIxuOkO8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cMqBjdsW6JPesi7hIiK0WNRmvklqAoE6GJbK1yI8cNYpP57mFnVT9gWrJKH4nHmoDUwHhiESWsZYv+Yn6VJBq3qPW252Z5L9t+GmMqE9NPe9fNKjvpYr33jiaTTLMXMFDQFdY6B+JjBbuqa468Mr+zQVpEAH/0Bd2d7wcpO1tEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vdEFAP8j; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c5bb68b386so347134385a.3
        for <netdev@vger.kernel.org>; Thu, 07 Aug 2025 07:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754576508; x=1755181308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ck6zTqEdLVdiJxGUO3eHXHa5pK+btU2040a8FA38EZI=;
        b=vdEFAP8jPIxRvsQEtmpqeQ/PE0g3OqCJEAM9ddOnWsbL60xB62nGbgFWysXBRY5Cpj
         c1iPDCmJXTLjD11MnI2SB41peuV3hP2drF73rEcc0bLnOGEIHAUYtZzZBdQ9D6SPMur9
         q73SzGQj0/2Ubp3ZNEwZpRzkZKayTsnjDwKKwqRyc41qcuOeuhFg8V0aP05a2bAjhap2
         Grg4ayHqAz5/49ZAHX7gkEe36UotLOX2GIzEX2rfdubbuOsz18VamhNQU0IcnyPi2wvA
         30oeFT+hn0PD1qRUaJ3n031xx/rpE/+3YQJgc31fQ7DCMTvi1t9WqnrwBbt8vaNJFCEU
         Aaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754576508; x=1755181308;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ck6zTqEdLVdiJxGUO3eHXHa5pK+btU2040a8FA38EZI=;
        b=Df+Y8ZRWgD0E6idmZohPcqGojpYWL6dJlIvNv+h/m+Ee6sJJ0OqWDdlkpH0XIymwHM
         8PaRbmWOHBRwDFedM1As5Rigg0pJCZiJX6W5fr1wrkeH2+h0z2q2LiZTfD46Mvk1rWnh
         1RjnSArIJ9er3SEy0ptE1ak8K2QFWdE+NPBV9MKmSdycxwhTP4IipGkCbaVYgz7j0rO2
         x7zbtMglzvKEN/bw1pr6BWnVY3c8xYjjY0AISOcEqq7OKRsQ99ZUYjqJ3DY6CSu5bHsq
         xxoG1hmes0JqiRAVoKT4InSB3sqLNo1EyizGl5OBRty5b7TTUttc7hHwRvBpXE5AVEMl
         EtBw==
X-Forwarded-Encrypted: i=1; AJvYcCWKwYPLkwAj/hS6f6sQ0K9Xx1MvkW6EqeVxMebkw1SZVPclywauC/m7bjaVRysgGfaz4bSqSuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCeleWgaRmYmKQtdy7LMJb71s5lUi4yCgy5fy/R+6iTU+Q7+Cn
	gSdWAXhEV7qBQroFi4UXOSigYwYMWi1oZd0Fq5Il5jPuNxEYas4W8WDkJNoPKf8h08XaVnyC+1N
	2vh0LJtbUmqkBcQ==
X-Google-Smtp-Source: AGHT+IGIxBwOHj/UFZCaqIPI64RwRyYMsf0sYQIHRnpSSs0VN6xcZ/0ZXyQBZh6smpUIRmdKg1r7mKYSdjr5MQ==
X-Received: from qkkb17.prod.google.com ([2002:a05:620a:1191:b0:7e8:1203:3ab3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:394e:b0:7e6:20a9:1855 with SMTP id af79cd13be357-7e814e9c360mr973980685a.44.1754576507639;
 Thu, 07 Aug 2025 07:21:47 -0700 (PDT)
Date: Thu,  7 Aug 2025 14:21:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250807142146.2877060-1-edumazet@google.com>
Subject: [PATCH net] pptp: fix pptp_xmit() error path
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

I accidentally added a bug in pptp_xmit() that syzbot caught for us.

Only call ip_rt_put() if a route has been allocated.

BUG: unable to handle page fault for address: ffffffffffffffdb
PGD df3b067 P4D df3b067 PUD df3d067 PMD 0
Oops: Oops: 0002 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 6346 Comm: syz.0.336 Not tainted 6.16.0-next-20250804-syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:arch_atomic_add_return arch/x86/include/asm/atomic.h:85 [inline]
RIP: 0010:raw_atomic_sub_return_release include/linux/atomic/atomic-arch-fallback.h:846 [inline]
RIP: 0010:atomic_sub_return_release include/linux/atomic/atomic-instrumented.h:327 [inline]
RIP: 0010:__rcuref_put include/linux/rcuref.h:109 [inline]
RIP: 0010:rcuref_put+0x172/0x210 include/linux/rcuref.h:173
Call Trace:
 <TASK>
 dst_release+0x24/0x1b0 net/core/dst.c:167
 ip_rt_put include/net/route.h:285 [inline]
 pptp_xmit+0x14b/0x1a90 drivers/net/ppp/pptp.c:267
 __ppp_channel_push+0xf2/0x1c0 drivers/net/ppp/ppp_generic.c:2166
 ppp_channel_push+0x123/0x660 drivers/net/ppp/ppp_generic.c:2198
 ppp_write+0x2b0/0x400 drivers/net/ppp/ppp_generic.c:544
 vfs_write+0x27b/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: de9c4861fb42 ("pptp: ensure minimal skb length in pptp_xmit()")
Reported-by: syzbot+27d7cfbc93457e472e00@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/689095a5.050a0220.1fc43d.0009.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/pptp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index 4cd6f67bd5d3520308ee4f8d68547a1bc8a7bfd3..90737cb718928a2dddacdc098f1d48d4430d6ddd 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -159,17 +159,17 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	int len;
 	unsigned char *data;
 	__u32 seq_recv;
-	struct rtable *rt = NULL;
+	struct rtable *rt;
 	struct net_device *tdev;
 	struct iphdr  *iph;
 	int    max_headroom;
 
 	if (sk_pppox(po)->sk_state & PPPOX_DEAD)
-		goto tx_error;
+		goto tx_drop;
 
 	rt = pptp_route_output(po, &fl4);
 	if (IS_ERR(rt))
-		goto tx_error;
+		goto tx_drop;
 
 	tdev = rt->dst.dev;
 
@@ -265,6 +265,7 @@ static int pptp_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 
 tx_error:
 	ip_rt_put(rt);
+tx_drop:
 	kfree_skb(skb);
 	return 1;
 }
-- 
2.50.1.565.gc32cd1483b-goog


