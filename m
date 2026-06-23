Return-Path: <netdev+bounces-301420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oGQtO9nCOmp/GAgAu9opvQ
	(envelope-from <netdev+bounces-301420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:31:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D4C6B9113
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:31:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GlsFlyeB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301420-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301420-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D916C303422E
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B7389115;
	Tue, 23 Jun 2026 17:31:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F07388873
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235862; cv=none; b=Q2xlyy2u5L1b3VHhftcpv0feFmHuP4rtT/iyDEwjPJyfLPIZ+9DvQLQ8xW8oozGzt4L8zJHTsnsAHA+ATK4EVPsQdK8xjcQ6w0O7Mg+dvo+bP+o/N3JQczNUM5SmgysZ+zn2+Kk083FTkDkrl7oxQlsLrZ5dQVVFm0R9vjJdCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235862; c=relaxed/simple;
	bh=5GPCDXgh/aNXyLYA8BwFvMmL4iU4HtRYnFjYr3LKCFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X3Cpc7fwfQqg3o6pS11O2D/hjHA6hfHu8MDKc3qdN9BMJ4hl3UhuOUwHk4hIcGoUK7h2Q3qeDONkt2akpDm2bE/WMyc4bPINY/1Ts/T1UnJHFHAUaY+k49hTkYbC2tIfqRgteKjEaLQpH/+f0rEyvfXykBoZyCuab+luNz2JSe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlsFlyeB; arc=none smtp.client-ip=209.85.222.202
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-91931144870so5571885a.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782235860; x=1782840660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiarDXF7RoDxoYlqhiKZBD/2JS5v/w8baNECo+JUhmQ=;
        b=GlsFlyeBYxX8RoWbMYely6kmJ+Y55hMLdXLCSqDCvaT7zwGGhc4CojaCR34cY1l1DA
         tcJ+41wGmIXedE+PH9vnvBF/4J5F+dPbENotPyZB6XvJAXN4NBap1lQFsgmEoN1g2qF0
         kwdlP1jfw0055yLwa9gOS6aawr+VR2iGm6CO4nXqcWXIoXu40cbyqyInZ3lWEZhjzMp7
         5IoZJD8fhOaG6/4F9ZfVKg2nAgjOtC/rlKL/7JJyGbU+CPHEMCn3Zp3+iihYQ5FVtCUg
         jHAOQ7YCmNJOz7w6kEROafaT5CeUfP3QKwk5Pq4py1Z+HTC8oWa0aENobSZUt/YTghC6
         XcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235860; x=1782840660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WiarDXF7RoDxoYlqhiKZBD/2JS5v/w8baNECo+JUhmQ=;
        b=fTHNsTeLichpare1R72km+w2bjEKM+YzFFpi1Eb2wB77Xts/SeJP1JpRHbbO21K/mY
         jSIT0fn1keAHqf4Uq4uY9HkRWJrjY3rgo7oPsXupRI2nPkGzwbPMqQ0lPs38fBy2CKdC
         fqjfvumK/5xmqwCz3Cc99haRElA9ztfRuerXkb0tsESTB5dls4IYaV+WuTS8vdP6vleo
         w8sjZeIsXe0j4qTz4P+91PD1FoMSLRE3RqSspC60ICl+DixVVzelHIDJOc2t3gZGz/xt
         kakpXn7BVY6tDRPDnATJfcy87Rfof57EeWsi0OloYeeMUHFgkO8hItH0+BHYytD4jZ1i
         8FqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ztPf5orDs1r9XDTKV5pEx3s4kmQXXa7J7kDtz/Tb9g8wn+PrErnrbY1NI1SCl8gYBXyRckgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/hVRXkNUgh2H2ByBo2uAJ/8agDlHYtRx3NQuzJ/yK5f8xmhnF
	i26pN6tNyXltwGDHVTT1F3Kvt0FQAXBFeIWG2zaouxJcaSqbJovNmvMu+DXo1vIUTiPyeSrpmPF
	Op4TrwB5vkXNQuQ==
X-Received: from qklo26.prod.google.com ([2002:a05:620a:d5a:b0:915:67bb:b14b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4092:b0:915:9047:940b with SMTP id af79cd13be357-9264433523emr639605985a.1.1782235835968;
 Tue, 23 Jun 2026 10:30:35 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:30:30 +0000
In-Reply-To: <20260623173030.2925059-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623173030.2925059-3-edumazet@google.com>
Subject: [PATCH v2 net 2/2] tipc: avoid busy looping in tipc_exit_net()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, tipc-discussion@lists.sourceforge.net, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301420-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88D4C6B9113

Blamed commit introduced a busy-wait loop in tipc_exit_net()
to wait for pending UDP bearer cleanup works to complete:

       while (atomic_read(&tn->wq_count))
               cond_resched();

This loop can busy-wait for a long time if cond_resched() is a NOP. This
typically happens if the netns exit is executed by a high priority task,
or under kernels configured without preemption (CONFIG_PREEMPT_NONE). In
such cases, it wastes CPU cycles and can lead to soft lockups.

Fix this by replacing the busy loop with wait_var_event(), allowing the
thread to sleep properly until the work queue count reaches zero.

Accordingly, update cleanup_bearer() to use atomic_dec_and_test() and
wake_up_var() to wake up the waiter when the count drops to zero.

This uses the global wait queue hash table, avoiding the need to bloat
struct tipc_net with a wait_queue_head_t. The atomic_dec_and_test()
provides the necessary memory barrier to ensure the wakeup is not missed.

Fixes: 04c26faa51d1 ("tipc: wait and exit until all work queues are done")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: tipc-discussion@lists.sourceforge.net
---
 net/tipc/core.c      | 4 ++--
 net/tipc/udp_media.c | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 1ddecea1df6e9100334c47a28ff6c065292fb9ad..315975c3be8186784e9c44c9ff69d62c17ffd4b9 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -45,6 +45,7 @@
 #include "crypto.h"
 
 #include <linux/module.h>
+#include <linux/wait_bit.h>
 
 /* configurable TIPC parameters */
 unsigned int tipc_net_id __read_mostly;
@@ -118,8 +119,7 @@ static void __net_exit tipc_exit_net(struct net *net)
 #ifdef CONFIG_TIPC_CRYPTO
 	tipc_crypto_stop(&tipc_net(net)->crypto_tx);
 #endif
-	while (atomic_read(&tn->wq_count))
-		cond_resched();
+	wait_var_event(&tn->wq_count, atomic_read(&tn->wq_count) == 0);
 }
 
 static void __net_exit tipc_pernet_pre_exit(struct net *net)
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 66f3cb87a0aaaac8f40e8f237ab9a44d539b1cd8..62ae7f5b58409c89798c915dee752ac42487581f 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -40,6 +40,7 @@
 #include <linux/igmp.h>
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
+#include <linux/wait_bit.h>
 #include <linux/list.h>
 #include <net/sock.h>
 #include <net/ip.h>
@@ -830,7 +831,8 @@ static void cleanup_bearer(struct work_struct *work)
 	synchronize_net();
 
 	dst_cache_destroy(&ub->rcast.dst_cache);
-	atomic_dec(&tn->wq_count);
+	if (atomic_dec_and_test(&tn->wq_count))
+		wake_up_var(&tn->wq_count);
 	kfree(ub);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


