Return-Path: <netdev+bounces-299865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TWiAFdVcMWpZiAUAu9opvQ
	(envelope-from <netdev+bounces-299865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:25:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D7F690729
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:25:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=YiWgxkXD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299865-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299865-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5196F30D520D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C60D3A451D;
	Tue, 16 Jun 2026 14:13:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f201.google.com (mail-vk1-f201.google.com [209.85.221.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BB7371893
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 14:13:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619201; cv=none; b=op7to3ItnNiSev6Ztu31zBCdFacblz/470aAINkyRxkc/3Ge3d4ahFRL/oRAkaitD6SCTnvhwRn7A+8IAVmVbJy/KpKgod72db3O1pg+KrEfCOdbhmyesCO770PkLyGwZFG8IdE0xdgLHqWR2aOBNFz3vysZRXC+8wwwCAkUJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619201; c=relaxed/simple;
	bh=6iWyrD9HaBSm8tfactCf0BfDHXPAlmU2Z6I8SYUZyXA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HekSvl0a1qVbeSktMnSyYzNpppzuo4k5YDX/tMNsEfb0oR7FSX9cmW2uA86tp5Xp9yQa/SHo6cuT53lL5u5vdEpKztTwRDY6AtHTLQoO693QpSoXsWSv2j+P5Fbd3ahgasFMEbt3rvrnRQFCQ+qprUQMocV/loDO9msaV+DQFDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiWgxkXD; arc=none smtp.client-ip=209.85.221.201
Received: by mail-vk1-f201.google.com with SMTP id 71dfb90a1353d-5a10b940840so5958868e0c.2
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781619199; x=1782223999; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UPTDNQ3ZdxKNHR3eMc9vEeu3DOJZZdhrADZs/8qBeRE=;
        b=YiWgxkXDnnRzVJKsOrsSU66sCayYa39bA6Zu2TquTShoENyNwsMFzJN1XUi2nQXxBr
         V1bfWhy4vR5V4EHxK3fPIe9ImMLIblG1FAPeSnlojp/ACT8vUYvSfmi6XiuyqzKKms67
         hxpdrVCvdqD+KtQwYrYUeLKReUGwiuZ/d3oezDYg1Oykc0G4s2tGE7QPKEf6V+K15VNu
         sD4Sned55OLsE8tOfT2sAxEYRor5N6kKpDTvah0H0cZEOSqJvO6Pogjv8bBVq2m3oi8v
         3r8v2iISkr6fkvrvHVfRe/vl99YXVGp3gD4NoPmqkF+cZbhceeEeWGb196lISLUbtSRD
         Ka4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781619199; x=1782223999;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPTDNQ3ZdxKNHR3eMc9vEeu3DOJZZdhrADZs/8qBeRE=;
        b=W8xSYhHXs9Iwq4XH6JK58XuZanAkglO1yM1Ru4Y6oJqzdSC5Ozfel7p/ZHciXzCpKl
         ekZ7fNu3gVxuR+IBDqHKuRZR2RknyF5LmbIhG6QY0TuguWYw9hggoDQsIJwkXetmVuER
         4jVAKAGeWNIPxaU3oL6TxpAVYcDO3WQW08WJSmBdPkQPHXVHE7W/lIKDMulLUkE4Dbhj
         RhKxnqrDBbVs1Mq8SR+XptfDk67R1+5j0IaDWNjV0cWRPWQpjDeyIm9L1XE8GZP8tV+G
         1kWBjtY3Dmd5Q/Ke1Ys3PGxtO1NRJyIU1BGk5iZz+Ft/eKI4VLz7cOohHmviwS+YdJDT
         QaqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+c0SXH3/LviMvFPMeXoz6cywIuPJiF+lEfS+slg73oF149G/gx+iC4od24ftlmF4/EH9+GEc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHcCkQy6pKwdFLlWIIPM9M3hXnR3yNjEq2qWINcihEgcZd7wn
	4HApkz7P9HSbRoc22sAXeHUpmhBLAQIdheRwGfyGhOs6TzCH9ZmFHb0+H7UQn93F0hBXVeW7rt/
	VD7YQEbMiyRmOkw==
X-Received: from qvbcu9.prod.google.com ([2002:a05:6214:17c9:b0:8ce:d125:daad])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6122:62a6:b0:56d:8ded:796c with SMTP id 71dfb90a1353d-5bb6c011ca1mr10074166e0c.4.1781619198666;
 Tue, 16 Jun 2026 07:13:18 -0700 (PDT)
Date: Tue, 16 Jun 2026 14:13:17 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616141317.407791-1-edumazet@google.com>
Subject: [PATCH net] net: serialize netif_running() check in enqueue_to_backlog()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com, 
	Julian Anastasov <ja@ssi.bg>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299865-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com,m:ja@ssi.bg,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com,ssi.bg];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,965506b59a2de0b6905c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ssi.bg:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8D7F690729

Syzbot reported a KASAN slab-use-after-free in fib_rules_lookup().

The root cause is a race condition where packets can escape the backlog
flushing during device unregistration (e.g., during netns exit).

Commit e9e4dd3267d0 ("net: do not process device backlog during unregistration")
introduced a lockless netif_running() check in enqueue_to_backlog() to
prevent queuing packets to an unregistering device.

However, this creates a TOCTOU race window.

A lockless transmitter (like veth_xmit) can pass
the check before dev_close() clears IFF_UP. If the transmitter is then
delayed, flush_all_backlogs() can run and finish before the transmitter
grabs the backlog lock and queues the packet. The packet then escapes
the flush and triggers UAF later when processed.

Fix this by moving the netif_running() check inside the backlog lock.
This serializes the check with the flush work (which also grabs the lock).
We then either queue the packet before the flush runs (so it gets flushed),
or check netif_running() after the flush/close completes (so it gets dropped).

Fixes: e9e4dd3267d0 ("net: do not process device backlog during unregistration")
Reported-by: syzbot+965506b59a2de0b6905c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a315824.b0403584.28d0ff.0000.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Julian Anastasov <ja@ssi.bg>
---
 net/core/dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 731e661d7be6574d5eca4a600e0a5623be4c2485..f81ce83fb3250d591ffa5eeb4c3067f8b75a54ca 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5381,8 +5381,6 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	u32 tail;
 
 	reason = SKB_DROP_REASON_DEV_READY;
-	if (unlikely(!netif_running(skb->dev)))
-		goto bad_dev;
 
 	sd = &per_cpu(softnet_data, cpu);
 
@@ -5394,6 +5392,10 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	backlog_lock_irq_save(sd, &flags);
 	qlen = skb_queue_len(&sd->input_pkt_queue);
 	if (likely(qlen <= max_backlog)) {
+		if (unlikely(!netif_running(skb->dev))) {
+			backlog_unlock_irq_restore(sd, flags);
+			goto bad_dev;
+		}
 		if (!qlen) {
 			/* Schedule NAPI for backlog device. We can use
 			 * non atomic operation as we own the queue lock.
-- 
2.54.0.1189.g8c84645362-goog


