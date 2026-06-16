Return-Path: <netdev+bounces-299828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FouhHkBAMWrBfQUAu9opvQ
	(envelope-from <netdev+bounces-299828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:23:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F5E68F45B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 14:23:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kiZDmqFQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299828-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299828-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D4C33024950
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B24345757;
	Tue, 16 Jun 2026 12:23:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1635E1BD
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 12:23:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781612601; cv=none; b=SSqPBdxEtjyqwRVsVZILE6aJJHeSA3McTLHFxBqNs/hgCpflY4LfqoWcWw1Kk/xn/wt9iKJ61wEGkR5xYa7fuWneQFbU5HDmQpnTClNIpA31jPkyrbTq8G9QCONoL1wPp/BO07dgaE5L6KynnXbstPRKHEI28dXDsFpeTuVCrv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781612601; c=relaxed/simple;
	bh=yVeUvNux++Yj4q5eneVR9Cq6halnoFWGaX88rxVeWhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHe0AGOU+dUxR28JX39///aD1aK1mB6twUb4ZbVf62Mf7pUSvo5ynRcuC2HYMH8xE2EH1maxNOiZad/DXIN89XOYECBRkvQQA+ht8uJ363LdzX5gCWsso7Qm7eihOf+mSZfY4D/4kkjS5O2D8e+ZvQaU6NAbNTo6Oy4MUBrU2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiZDmqFQ; arc=none smtp.client-ip=74.125.82.175
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30bb2df6fbbso1294662eec.0
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781612599; x=1782217399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g3qEhg0IM5Q+9NZam+NDsCeaeWf8gVayCaGPWh17VjI=;
        b=kiZDmqFQY11O+KdmJFqJKMyT0oZe2scMhvE8LF20jlINN4I0FZbKLxjquw2O6Gi8re
         t7piv+VYcmWHsrZk4GfIHcgyTjHzDyAp42JQM6GIHCS5zQ6czNLmY7ttLZBrAg/h68q1
         Y5v5ykZcBJOrxCPyJGKjCpqtLwz+8JUOi4hvSZh+3PY9HTq3QnrKaKKo0UzVIFNHkSiC
         5XQkEE3JEbtXIApzpadriAVkBr930PezT1cGQM7EUuMeEh6wZ4AP1cWZszcLBm3ow9GS
         ujbOev1YSB6In7iWzFkIQv64Z4h3Ea+cWMul6f5CXwahQgq4kHNJC/07OYQGDRIhzB6i
         7FFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781612599; x=1782217399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3qEhg0IM5Q+9NZam+NDsCeaeWf8gVayCaGPWh17VjI=;
        b=d5VLxf7xTskFpd4Oy56T+4eU5Q15mFGuPIV6pD7F93OguU7+N8+JbIMp6UK4ScCmgX
         OHcXj/nluu4CZ8cGkhNx5X3ZkLrLw3eJzAufTRSuLKhucxLTEri0hGcDkGhhj/7LGgn8
         PcIO0o75kylrq3djb14de72eVm/ViRtl+l+fFIHaP2jBTyIlDHq/+TSodH4q79ECuHk2
         G6DwtQZz3N47xvdI8oHKPeh7aPsQPPN0WndxX+H+BNkuxiaL5KWPX6NYwCrp3xnHmsK/
         ET3bpg7lT4ZwSiX2ysWPuRVFyHNYP/QhwFMzSvDx5C/VRJTSnFEsj6675lrYpgA7E1YA
         hauA==
X-Gm-Message-State: AOJu0YxXWn92xCPUY0a5FytEqGq56bv6krLt316zl4+U5nF5Z2+pyAnC
	kcY4DuXmYa1mnIDadwehRgaNTJ5zDN+eD2b6jaN3c+4Ny5SfGFx5TIlycGtt1t2H0vY=
X-Gm-Gg: Acq92OHWhiZTh2JvfZTgTCHuNeUBYAVu+Qxrk0k51Wz9B/vMO2umK0oLY2f4hG7SgxN
	ENjUEHEsLuhd2ZDJtXqQU3dwTsmU69RFh88fRJbZD6rOqbk0V1BZOH1luSRPxNjRR+/Lz73ZgMj
	04/tZb1ExG01/5GT8uqLIuQ5Dm7UzhRFfqqAPXzCRGKNiQyZaQy/NbMiykDaxRUmpdOaBaU3I8x
	X8MN0rKfY7tLHKkNQlvukVrkrFTmdJwAFk66/oa+S0uqhnyqHcNgE4VPoYd4IalOL6fw+FIwdVz
	Hm+WJHa8ahnOWCZM8QdkEyfr3tz3Ns4q1BK6KrR0H/O1d6t1sMtIFJDIkd5dAfbV/XL5JLFklJ8
	ZgeA3npWXGATeIKr4Qj2FBJ66TW/HbFEc6BWsNh8pQg0zFjcn+HdKTWKT8nWbe7KmFI9m5D0b1T
	LpSzIsAicgxPyc83FxbBMPyTQSSQOmXmopHPOyXSx08Y94wlQbGfrk0LTbdPN+mGDA82On
X-Received: by 2002:a05:693c:37c2:b0:304:fa0d:85ba with SMTP id 5a478bee46e88-30ba59856damr2198824eec.12.1781612598945;
        Tue, 16 Jun 2026 05:23:18 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43b80sm18001224eec.21.2026.06.16.05.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:23:18 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Cc: jmaloy@redhat.com,
	ying.xue@windriver.com,
	tung.quang.nguyen@est.tech,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	davem@davemloft.net,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] tipc: fix use-after-free of the discoverer in tipc_disc_rcv()
Date: Tue, 16 Jun 2026 05:22:47 -0700
Message-ID: <20260616122246.3136462-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,windriver.com,est.tech,google.com,kernel.org,davemloft.net,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299828-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:jmaloy@redhat.com,m:ying.xue@windriver.com,m:tung.quang.nguyen@est.tech,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:davem@davemloft.net,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7F5E68F45B

bearer_disable() frees b->disc with tipc_disc_delete()'s plain kfree(),
but tipc_disc_rcv() still dereferences b->disc in RX softirq under
rcu_read_lock() (tipc_udp_recv -> tipc_rcv -> tipc_disc_rcv).

L2 bearers are safe thanks to the synchronize_net() in
tipc_disable_l2_media(), but the UDP bearer defers that call to the
cleanup_bearer() workqueue, so the discoverer is freed with no grace
period:

 BUG: KASAN: slab-use-after-free in tipc_disc_rcv (net/tipc/discover.c:149)
 Read of size 8 at addr ffff88802348b728 by task poc_tipc/184
 <IRQ>
  tipc_disc_rcv (net/tipc/discover.c:149)
  tipc_rcv (net/tipc/node.c:2126)
  tipc_udp_recv (net/tipc/udp_media.c:391)
  udp_rcv (net/ipv4/udp.c:2643)
  ip_local_deliver_finish (net/ipv4/ip_input.c:241)
 </IRQ>
 Freed by task 181:
  kfree (mm/slub.c:6565)
  bearer_disable (net/tipc/bearer.c:418)
  tipc_nl_bearer_disable (net/tipc/bearer.c:1001)

The bearer is freed with kfree_rcu(); free the discoverer the same way.
Add an rcu_head to struct tipc_discoverer and free it and its skb from an
RCU callback.

Because the RCU callback (tipc_disc_free_rcu) lives in module text, a
call_rcu() that is still pending when the tipc module is unloaded would
invoke a freed function. Add an rcu_barrier() to tipc_exit() after the
bearer subsystem has been torn down, so all pending discoverer callbacks
have run before the module text goes away.

Reachable from an unprivileged user namespace: the TIPCv2 genl family is
netnsok and its bearer commands have no GENL_ADMIN_PERM. Needs CONFIG_TIPC
and CONFIG_TIPC_MEDIA_UDP.

Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2:
 - split the over-80-column container_of() line (Tung Quang Nguyen)
 - add rcu_barrier() to tipc_exit() so a pending call_rcu() cannot fire
   into freed module text after rmmod (Eric Dumazet)

 net/tipc/core.c     |  3 +++
 net/tipc/discover.c | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/tipc/core.c b/net/tipc/core.c
index 434e70eabe08..747328e58d30 100644
--- a/net/tipc/core.c
+++ b/net/tipc/core.c
@@ -218,6 +218,9 @@ static void __exit tipc_exit(void)
 	unregister_pernet_device(&tipc_net_ops);
 	tipc_unregister_sysctl();
 
+	/* Wait for tipc_disc_free_rcu() callbacks queued from module text. */
+	rcu_barrier();
+
 	pr_info("Deactivated\n");
 }
 
diff --git a/net/tipc/discover.c b/net/tipc/discover.c
index 3e54d2df5683..696b7a8ed54d 100644
--- a/net/tipc/discover.c
+++ b/net/tipc/discover.c
@@ -58,6 +58,7 @@
  * @skb: request message to be (repeatedly) sent
  * @timer: timer governing period between requests
  * @timer_intv: current interval between requests (in ms)
+ * @rcu: RCU head for deferred freeing
  */
 struct tipc_discoverer {
 	u32 bearer_id;
@@ -69,6 +70,7 @@ struct tipc_discoverer {
 	struct sk_buff *skb;
 	struct timer_list timer;
 	unsigned long timer_intv;
+	struct rcu_head rcu;
 };
 
 /**
@@ -382,6 +384,15 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 	return 0;
 }
 
+static void tipc_disc_free_rcu(struct rcu_head *rp)
+{
+	struct tipc_discoverer *d =
+		container_of(rp, struct tipc_discoverer, rcu);
+
+	kfree_skb(d->skb);
+	kfree(d);
+}
+
 /**
  * tipc_disc_delete - destroy object sending periodic link setup requests
  * @d: ptr to link dest structure
@@ -389,8 +400,7 @@ int tipc_disc_create(struct net *net, struct tipc_bearer *b,
 void tipc_disc_delete(struct tipc_discoverer *d)
 {
 	timer_shutdown_sync(&d->timer);
-	kfree_skb(d->skb);
-	kfree(d);
+	call_rcu(&d->rcu, tipc_disc_free_rcu);
 }
 
 /**
-- 
2.43.0


