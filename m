Return-Path: <netdev+bounces-227524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 370B2BB213A
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 01:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08E119C5AB3
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 23:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997B326B0BC;
	Wed,  1 Oct 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PluDTP0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A423B60A
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361880; cv=none; b=VwmO6i0GOl+AreTPBr+x6Tn79tn0K6BFaZKekTDYRzHIubiwOtA+uvNvyqmKXxp1Mf1CpQQgSZ/00YhQG2h+fXO0W7zhFAo25rZAFnPR571uBIvPVYAsE1TQZ8mIjyNsCdnZ7RWast1iadqb7XqU79RvfM+A80vNajYP90s0lOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361880; c=relaxed/simple;
	bh=/YJyWVc70DsYNkENqsjV3BVENXgCeiYbvOJ2kGJtCZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KyDu2LKvblX3uf73ci4jfjTVXjIVkbaLLw4yfsKfFS/dceXyssLIgmxCefQmGThEX87EJtVZeCdgdGFtSKiNgpLnQ5IJ+S+f1vQv9ZQHs+fx4xNYDwUdXoRHNlKzNodGQ4nk3ATOOz7mLMSZBu0+J9SgRLAcZIG2BfYFsSqJ8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PluDTP0j; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so3476365ad.3
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 16:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759361878; x=1759966678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fawE0McOsv/LkcXHlBVgxtKf5QfaxJEVJNmSqn6topU=;
        b=PluDTP0jBaUr5drkA22g0eFJ/yiG2o/nWug3rreY5u1oq6TX4WRTXps87HBWze99Rb
         UkjQIbJ6IvGOhwu23AU/AmT/IzZnlSSNr2vUyXK0XP4RrFEtiIhP1VR42uSQSh8fmGc2
         2YeAFBpmwu0ChO/E2dEpKXZNYR9OZJHx/mfIQVukc2bOrjmqpBSpxJOVZQaoWMVQF3Qn
         4i9L2g+c8cW3nkFSsbF5ZkCitZ5cYgQSYArM2zHYd1mKPNzB8UuDUNKe9sI5KhssX9Pi
         JzxqllRS4LEYQjKv1D6D5QkSQvv8UMrZ239KgKalhy+Ju3YgOaTVQE+/BxGtUyXzFkC5
         5V9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759361878; x=1759966678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fawE0McOsv/LkcXHlBVgxtKf5QfaxJEVJNmSqn6topU=;
        b=Nr8KuIqz9WqHalYWxaWRqVs9sgqDVRqQ1JmDDSSnSFtvmycFhRU7FEpIxxy3MUFybC
         aDCkXVAqTbsfPOXW2qD+vOxANvJpRIlXC4ySOlWJ+LlW5++BG9rK9LTp8g/0ZGfbVqid
         HvDK4/y9cpbdT2Dj4niMlHeZXfdZwl4eo2E9r6c9Oe2I9OVjshLKsL50WOrepLwfxaVT
         njfigkJEj6fN+tM6xABU/LjxCgsLsXjPwM/PS+soFR8AeD/GrnHSzIAYt/zIjYZjP1/s
         LdyV+V3Fw/QLh1Lew8plZA03XCBiAc42eg9jq81DRt2/9wT8KPJ4zkAf5qBEkNjdkjk2
         vPVg==
X-Forwarded-Encrypted: i=1; AJvYcCU+x1Xv+qwWDNQzASeqI1ZJUcbxI5bPj08TJDPwUexpGvkbgOaR/CndOr75X+vTOeGRsnjCm4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+5bXPizB9CnVCk+BTXcIT1Mkani/bwxOrb6754g6ethlyrm0
	FJZypw/vjUWVS6rwLw35PMxPNT0NNb8CMU+BnRWHagZ2zH1DJ4o9GvceRyqJtTvNWGSlb45Zma4
	alfgqeQ==
X-Google-Smtp-Source: AGHT+IHcL5vhgpHMnYaKcCkcW4ne/4hSZUL+vIxzOxmHOa0MVEZjTY0wMs8SBME3EZtdNpCrh6s3uGzl/Cg=
X-Received: from pjboi16.prod.google.com ([2002:a17:90b:3a10:b0:329:d461:9889])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b63:b0:267:a942:788c
 with SMTP id d9443c01a7336-28e7f2a152bmr63990295ad.1.1759361878314; Wed, 01
 Oct 2025 16:37:58 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:37:54 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001233755.1340927-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat below in tcp_conn_request(). [0]

If a listener is close()d while a TFO socket is being processed in
tcp_conn_request(), inet_csk_reqsk_queue_add() does not set reqsk->sk
and calls inet_child_forget(), which calls tcp_disconnect() for the
TFO socket.

After the cited commit, tcp_disconnect() calls reqsk_fastopen_remove(),
where reqsk_put() is called due to !reqsk->sk.

Then, reqsk_fastopen_remove() in tcp_conn_request() decrements the
last req->rsk_refcnt and frees reqsk, and __reqsk_free() at the
drop_and_free label causes the refcount underflow for the listener
and double-free of the reqsk.

Let's remove reqsk_fastopen_remove() in tcp_conn_request().

Note that other callers make sure tp->fastopen_rsk is not NULL.

[0]:
refcount_t: underflow; use-after-free.
WARNING: CPU: 12 PID: 5563 at lib/refcount.c:28 refcount_warn_saturate (lib/refcount.c:28)
Modules linked in:
CPU: 12 UID: 0 PID: 5563 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:refcount_warn_saturate (lib/refcount.c:28)
Code: ab e8 8e b4 98 ff 0f 0b c3 cc cc cc cc cc 80 3d a4 e4 d6 01 00 75 9c c6 05 9b e4 d6 01 01 48 c7 c7 e8 df fb ab e8 6a b4 98 ff <0f> 0b e9 03 5b 76 00 cc 80 3d 7d e4 d6 01 00 0f 85 74 ff ff ff c6
RSP: 0018:ffffa79fc0304a98 EFLAGS: 00010246
RAX: d83af4db1c6b3900 RBX: ffff9f65c7a69020 RCX: d83af4db1c6b3900
RDX: 0000000000000000 RSI: 00000000ffff7fff RDI: ffffffffac78a280
RBP: 000000009d781b60 R08: 0000000000007fff R09: ffffffffac6ca280
R10: 0000000000017ffd R11: 0000000000000004 R12: ffff9f65c7b4f100
R13: ffff9f65c7d23c00 R14: ffff9f65c7d26000 R15: ffff9f65c7a64ef8
FS:  00007f9f962176c0(0000) GS:ffff9f65fcf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000180 CR3: 000000000dbbe006 CR4: 0000000000372ef0
Call Trace:
 <IRQ>
 tcp_conn_request (./include/linux/refcount.h:400 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 ./include/net/sock.h:1965 ./include/net/request_sock.h:131 net/ipv4/tcp_input.c:7301)
 tcp_rcv_state_process (net/ipv4/tcp_input.c:6708)
 tcp_v6_do_rcv (net/ipv6/tcp_ipv6.c:1670)
 tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1906)
 ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:438)
 ip6_input (net/ipv6/ip6_input.c:500)
 ipv6_rcv (net/ipv6/ip6_input.c:311)
 __netif_receive_skb (net/core/dev.c:6104)
 process_backlog (net/core/dev.c:6456)
 __napi_poll (net/core/dev.c:7506)
 net_rx_action (net/core/dev.c:7569 net/core/dev.c:7696)
 handle_softirqs (kernel/softirq.c:579)
 do_softirq (kernel/softirq.c:480)
 </IRQ>

Fixes: 45c8a6cc2bcd ("tcp: Clear tcp_sk(sk)->fastopen_rsk in tcp_disconnect().")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/tcp_input.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a..e0057e5aaaf8 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7264,7 +7264,6 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 				    &foc, TCP_SYNACK_FASTOPEN, skb);
 		/* Add the child socket directly into the accept queue */
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
-			reqsk_fastopen_remove(fastopen_sk, req, false);
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
 			goto drop_and_free;
-- 
2.51.0.618.g983fd99d29-goog


