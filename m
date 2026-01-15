Return-Path: <netdev+bounces-250275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CDD273AD
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 19:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D94EF328C7A1
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFFC3BFE34;
	Thu, 15 Jan 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SkjYnbj7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744DA3C1966
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497940; cv=none; b=Es8+Js4+8d7e2+dnYyBMCnP/EJPKMa61oh2S5ur7+OZ5qPTfzvEMR0A7IaEcUp5zgqh4FeOSWoabYlxK/LfKFvEsrv6iqBsW6zFDYgLRWwsocUk0OLPxzE4M5m7f5Y4Qa0PnDETbRVvwbQ+L7vtgcdI12XJUK+5q5fWvdjnRrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497940; c=relaxed/simple;
	bh=d8Hs0LZRQx7Ec421sxOns8CC11fO2/Ta/32U2CB0kMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lLGbBfavVcnJOz73t58flUIztvHpB2yakAf9r4tBcOHE93B6jq+UKVSuGi6Twrsb9kGBA3BmA2d2pIz+3vBGlQ0AwEzV0DPcBv6uOrKeQmXK5a7vKMTM2rYaolsUgO/HsqeEwpOGOnpGL6HZJv93BXrjwHaszvjkvdG2oFDY25M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SkjYnbj7; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so944320a91.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 09:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768497938; x=1769102738; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=usWAOJodgTM8O2nItSyKK+KeQHIdi5qKjpRhxn+Rgps=;
        b=SkjYnbj7jYQ+B47N086mvwbc0Mnxw+d+x0FLmFrZ9YBt4wbzcyJ7Nc3mBTKEovAvBi
         n/nx1/vAvhWGE1yjLNI/LnVukEwoDdmhF7szkk7vAB3xjLqZiD8tzDJiy0Y29f1uU0o0
         fDEe1LTMqi0SSCCpOemGKRNFU5hJxEBP/HGQ6XI7HU2LDU6PwfOLAD7i0JV1YJ3g50+q
         f1AOowH4M7eYdmttod96jGo1OV70+Gwu2fFIFQTlG+TXiADSRq21/jjJ1LCK2jYpDTc/
         etgp8r2VJRb8UQqDmJCADe06C5bmAfIbTXjmiYZg65LrTFLesccHawaqzxoB9cUyN2ah
         2yNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768497938; x=1769102738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usWAOJodgTM8O2nItSyKK+KeQHIdi5qKjpRhxn+Rgps=;
        b=JJqv4aD7s3CnM/JLMrV5ZhgzT1gb9CJRafqgDPt07MNpY/meE9rdZdoOe6mdIexbcu
         PrqMOAMGUpGxquqts+np+NOxL7plC2v71OV1z53MnEnMemaFQirUtV50WKv1EaqouSdS
         IBNi1L1znpzQAq6u5uh1TGTAEGJ0htY+ultupJFnauZQsZnmKiUd2+KQ4nlbLJlUcJsD
         ucYrh+K4wOVTOxJbJgLz4vN4fSBBMxTmoqYObZ2AjpF0qVI6h16N8mVrZb2LRS5J7eU9
         HDxJ+sJJ7vYLoVek3mAFXicdBNMNUzjnC+8EP3jWeLuR57H/GJd+szHPl8Tia+dP8m9A
         5HxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZX2T5K+hI6bqWlD0ODrR8Gl3xk7V7XZQ/3auRDbEGOC5GENTWOsQFpRbO6CQo/YpzTlOv7hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vQHtNEKQvcgEWoXIPzYh8/bszCjSYpnQ0U51R63Ila1GidsT
	Vw7GtaR6Gsl+ElxkS9l36YiioGqAmHbRuI8lGpQQgSnP26zeOOmlvsrcD5r7I3lVKnnUXBEd38S
	hwtcL1Q==
X-Received: from pjrv8.prod.google.com ([2002:a17:90a:bb88:b0:34a:b143:87d7])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc50:b0:343:c3d1:8bb1
 with SMTP id 98e67ed59e1d1-35272fbdd0dmr97585a91.28.1768497937727; Thu, 15
 Jan 2026 09:25:37 -0800 (PST)
Date: Thu, 15 Jan 2026 17:24:46 +0000
In-Reply-To: <20260115172533.693652-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115172533.693652-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260115172533.693652-2-kuniyu@google.com>
Subject: [PATCH v2 net 1/3] gue: Fix skb memleak with inner IP protocol 0.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported skb memleak below. [0]

The repro generated a GUE packet with its inner protocol 0.

gue_udp_recv() returns -guehdr->proto_ctype for "resubmit"
in ip_protocol_deliver_rcu(), but this only works with
non-zero protocol number.

Let's drop such packets.

Note that 0 is a valid number (IPv6 Hop-by-Hop Option).

I think it is not practical to encap HOPOPT in GUE, so once
someone starts to complain, we could pass down a resubmit
flag pointer to distinguish two zeros from the upper layer:

  * no error
  * resubmit HOPOPT

[0]
BUG: memory leak
unreferenced object 0xffff888109695a00 (size 240):
  comm "syz.0.17", pid 6088, jiffies 4294943096
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 40 c2 10 81 88 ff ff 00 00 00 00 00 00 00 00  .@..............
  backtrace (crc a84b336f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4958 [inline]
    slab_alloc_node mm/slub.c:5263 [inline]
    kmem_cache_alloc_noprof+0x3b4/0x590 mm/slub.c:5270
    __build_skb+0x23/0x60 net/core/skbuff.c:474
    build_skb+0x20/0x190 net/core/skbuff.c:490
    __tun_build_skb drivers/net/tun.c:1541 [inline]
    tun_build_skb+0x4a1/0xa40 drivers/net/tun.c:1636
    tun_get_user+0xc12/0x2030 drivers/net/tun.c:1770
    tun_chr_write_iter+0x71/0x120 drivers/net/tun.c:1999
    new_sync_write fs/read_write.c:593 [inline]
    vfs_write+0x45d/0x710 fs/read_write.c:686
    ksys_write+0xa7/0x170 fs/read_write.c:738
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xa4/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 37dd0247797b1 ("gue: Receive side for Generic UDP Encapsulation")
Reported-by: syzbot+4d8c7d16b0e95c0d0f0d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6965534b.050a0220.38aacd.0001.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/fou_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 3970b6b7ace5..ab8f309f8925 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -215,6 +215,9 @@ static int gue_udp_recv(struct sock *sk, struct sk_buff *skb)
 		return gue_control_message(skb, guehdr);
 
 	proto_ctype = guehdr->proto_ctype;
+	if (unlikely(!proto_ctype))
+		goto drop;
+
 	__skb_pull(skb, sizeof(struct udphdr) + hdrlen);
 	skb_reset_transport_header(skb);
 
-- 
2.52.0.457.g6b5491de43-goog


