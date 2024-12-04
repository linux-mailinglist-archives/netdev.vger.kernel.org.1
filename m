Return-Path: <netdev+bounces-149086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1399E42C1
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 19:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E13BA20D0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 17:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2A6227B9F;
	Wed,  4 Dec 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lakVjt3g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C8227B80
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331953; cv=none; b=WaUS0VItF4eQzoOzPw9fdwKlxx+BzWYyQygbHdiJU3IANLcNCfAhUgIzNG+2Vrv5avU1fS8Zu4VYHG29TXnkoU7Vgp642isB+EtHzcDOp44dlMKSFvCOiFt2L2eRF2HVG7meOwSwvmlW8KLVye/PrCFr0EmnNQHvkhDLhrBhxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331953; c=relaxed/simple;
	bh=IegG3mIQXanxKFWATok8kFRHSRMOBCpG/dWiBSjDsy8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YIdHk5uWKQgXxAEL3tX6LgKRhfBjovqbcx8jlM4hugTheH5CKDxqDm2vFm6binQIX7ZxtMsM79OyOhjXs1xSf5xrWaZ95gLeY/eLIqao1Aw2+hWJ1zeisO/rj1nXLqoVtcyQ8rPIeKKts4XJ10YzEdPuYSTX2jNf40Tf0jqMLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lakVjt3g; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4669b6cb826so131866041cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 09:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733331950; x=1733936750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OBxlJzlqlh/d4rVVKRBPjJYRRbVSJFIRW82i3s/Bhf4=;
        b=lakVjt3gdtz+kHrOlLUnWgWqPVHQRsQHWwY0nmN42T8lQ+D6l43IriBUi8fqoM5Ned
         QAFT++B1Ps6x5F0angAa6XlTQpwJTwc7KQiwIo9HaeDKM/mX50cInY8EaESCjiEzaLPX
         Cx0YXrIBId4DVGLvCHx/OATZwAtZ3nlt3RZmPa+AFfIwWsR8EQUb0MdZjAhmbfCi749Q
         9WpMFaKeHm6jW1maiqjSTtB1W799E97qvJ3vCvk0ctgjVmf7Jmp/Bqu6fjiwtSdR8qHv
         8ANGnG4nB49WD5c5y9KknyTyNJBkDTCV97RIekenNVmjOM9QhhHKwXcVBm5+xM5PTGrE
         9diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733331950; x=1733936750;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBxlJzlqlh/d4rVVKRBPjJYRRbVSJFIRW82i3s/Bhf4=;
        b=JCBG4FbD0D5ObZcpvyXHlntxm9+L7PDBa/gqtzvnNTc4tn8/ISJSTf97UbRkEJjRku
         pui6aneCBU3b2uHmv0+YgFwfE/HuuJ64/WwrlxVLNCg8GoFeAc9/UCScM15HUKvXcIFB
         l+aKZcuMc7LuddvYFj1HsrmApbnU2ztNC2FNbpkR8MMZT7t8EZWEJ+ECxprU013XtNVi
         8EkBzG6vttistfDOsq3k2xc3J2riNP7f1JU0cN7scbykQkQMsn3Kp1r3LglD1xE4IHsb
         AJJh6cR7/KQesww33xlA62yZM2e9yQjZvFLn0gquNH1hRHg8LnYVIsnhy7LE7eRCj2mH
         ZbSw==
X-Gm-Message-State: AOJu0YwbYeQaplZPBa18QrzTGyJYvEPBmuX2J0cr5hojfK0zSfTKODIq
	ZwYE9UEzOJHVmgxbSRLL/p0Voo3cfaStFh+fBsapKTojSDFAWmwcmDurLzbeIfRR0RcVL10Te3S
	Pq/+4b1JUnQ==
X-Google-Smtp-Source: AGHT+IFUyWbYF1FknHI+AmNLA9H3H9FTA9peMKHqodHm8q7gpy23A7QQqS3X2oPeEbuHWFGlXRas8I8C+w2XBw==
X-Received: from qtbge24.prod.google.com ([2002:a05:622a:5c98:b0:466:ac09:3a10])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7f0f:0:b0:466:8cc1:623b with SMTP id d75a77b69052e-4670c0a8261mr81187831cf.28.1733331950436;
 Wed, 04 Dec 2024 09:05:50 -0800 (PST)
Date: Wed,  4 Dec 2024 17:05:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241204170548.4152658-1-edumazet@google.com>
Subject: [PATCH net] tipc: fix NULL deref in cleanup_bearer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found [1] that after blamed commit, ub->ubsock->sk
was NULL when attempting the atomic_dec() :

atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);

Fix this by caching the tipc_net pointer.

[1]

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 UID: 0 PID: 5896 Comm: kworker/0:3 Not tainted 6.13.0-rc1-next-20241203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events cleanup_bearer
 RIP: 0010:read_pnet include/net/net_namespace.h:387 [inline]
 RIP: 0010:sock_net include/net/sock.h:655 [inline]
 RIP: 0010:cleanup_bearer+0x1f7/0x280 net/tipc/udp_media.c:820
Code: 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 3c f7 99 f6 48 8b 1b 48 83 c3 30 e8 f0 e4 60 00 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 1a f7 99 f6 49 83 c7 e8 48 8b 1b
RSP: 0018:ffffc9000410fb70 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: ffff88802fe45a00
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffffc9000410f900
RBP: ffff88807e1f0908 R08: ffffc9000410f907 R09: 1ffff92000821f20
R10: dffffc0000000000 R11: fffff52000821f21 R12: ffff888031d19980
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88807e1f0918
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556ca050b000 CR3: 0000000031c0c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Fixes: 6a2fa13312e5 ("tipc: Fix use-after-free of kernel socket in cleanup_bearer().")
Reported-by: syzbot+46aa5474f179dacd1a3b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67508b5f.050a0220.17bd51.0070.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/tipc/udp_media.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index b7e25e7e9933b69aa6a3364e3287c358b7ac9421..108a4cc2e001077169a4e4c3bebd42715db9a803 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -807,6 +807,7 @@ static void cleanup_bearer(struct work_struct *work)
 {
 	struct udp_bearer *ub = container_of(work, struct udp_bearer, work);
 	struct udp_replicast *rcast, *tmp;
+	struct tipc_net *tn;
 
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
 		dst_cache_destroy(&rcast->dst_cache);
@@ -814,10 +815,14 @@ static void cleanup_bearer(struct work_struct *work)
 		kfree_rcu(rcast, rcu);
 	}
 
+	tn = tipc_net(sock_net(ub->ubsock->sk));
+
 	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->ubsock);
+
+	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
-	atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
+	atomic_dec(&tn->wq_count);
 	kfree(ub);
 }
 
-- 
2.47.0.338.g60cca15819-goog


