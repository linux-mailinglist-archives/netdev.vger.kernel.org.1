Return-Path: <netdev+bounces-305533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z3BMJrEtTWrZwAEAu9opvQ
	(envelope-from <netdev+bounces-305533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:47:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602E71DFF8
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 18:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YNhFPIYb;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305533-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305533-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9E13009CFB
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 16:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32264435AAC;
	Tue,  7 Jul 2026 16:43:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B60424646
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:43:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442617; cv=none; b=FV6qlwY6HU5x3unsQfXxroJ6rvtMr99UplcvX3VbT8ru7Qb6Fb7/kXkJjAhf2a++x9hS6BVpoiIdF2YTbwFyS6U+6O31j+x/yL3CcBl0LANC97rbj2AaeKPpnW1wyJL68zzdzhuDSyEg2VNriGd5qbf57Cr0YSQ2BJLKPhUnDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442617; c=relaxed/simple;
	bh=jzHICN97GNQ/H3cgv7acbGCZES1wBsgQKMhHugF5knA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8mfWvGAaqVMnI4O+alxDvTA9Yaxf6/cJiFyyiQPFNJe/yzUu3QjYRrzylJix4uglSbVEAS/iuAVlHop3WE1zlcmb9ZI29z33OlI5Y3fTYdVAcUXh2dAOYwjQ5Lc3viNeA1sDLrxWlQLdAz+PiFq2YRGedkYr1r+xqfwCjRHZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNhFPIYb; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso3140476a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783442615; x=1784047415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=urBcuOuF/SwkK7kb6rHPGAids0fQr1UL/SvOJ60mfhE=;
        b=YNhFPIYb1LKWIHe+0YqbZ5wQwU4kvSoB7qPYmT8xWfuoBmT8BVaX9fz9A3sol85ETN
         u+i7XHg4FBGuKKxaPffAP+CkangMH4Chfem6BX7dTj/t74x6z6fvC3ThxF6E0merBSLo
         xkR7U8kpO8U9J8R9p4Hl+nYcGhCN9OLz0eQMU54ByM2cFW24BGIkQKWlIcHwa4ZExqVJ
         RYneB3KBlpZ1W5++jQXQkr5qBZlsIIPG70ywNIofs/oL3nYTwjRANHoW8geB4LajzCZP
         M4+yopE5KprxSUGT/zVovEDoQY/OXpz5QF1ZF+ycUIZM4VBdgyHIXMbOKgs+Yna2Y+cz
         cS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442615; x=1784047415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=urBcuOuF/SwkK7kb6rHPGAids0fQr1UL/SvOJ60mfhE=;
        b=ekOrARd+5kLvn8z+drq4m0SSnu5GFEta0CjqJZ6uXIDyGqhBEiVOx5MMeyAlbtlai6
         c717XGENias9Fiou2CFiq+TF7m8XsFcYFYIiGI0oergYj9rWO+kC6wzJwa58DNGlZHh1
         /CuN2eUIqNghTzX7Ky1dwc1ivxbcFZfsXjInpEyRNcc76syK5w0p+5iZs+gsw+Eniy/w
         0QP8uk7hm2T/E4IIoq1oRVUskfRnwVwc5qFamM0vh6aJ++dP6bM0njbX69yuiecbGpki
         aU5yec0Xk9VZD/J0HvJMk1XlygrVf+Gws0OreGBCB8j44AIxgKM9jixKbZpsaaS9bN+j
         t3xQ==
X-Gm-Message-State: AOJu0YwIX/IjqsgxCT9KjFhkc47MJtdY3NHYyOASnUjJkCbDpSBQZKSL
	YhJP4byaU55xjZFxV450NlgMM3zvV/4bZl+bnatK2e6zeNQsoj5qMRXn
X-Gm-Gg: AfdE7cn6/q9I8eEvjXcI/izM9DhARWQnjihHJVZSOtQKiJNc2ksBakuZmXrUkqsCrHX
	SJOYQ3QQL1jVZg46zPjz9RYQxl83mOvl0ZYE89KPfk+xHMn6NfsMzlBMbqDfk9WsRnx+zycgXYj
	7bB5hM7lCl2gmN6ZIl6VyiprqDXi0YtQhGq8ay8aqINLk0hW0ns4/AUTwQUkqeWTZqGtmaIcym4
	VLuWuCg6OuTY3MZsybAgKwCHxH0gWXpoVVIT3ceRZB0G2ssIWRcCBC/7/k+sIn03u1iBhYybLpz
	UJeWyQKhGL0AmRY2b/q7KAUX01lvX/SsJg1s3sNViTZOM+kZlNpadgC7Ie0gg/uce/G/Py2bSyI
	LG8uL66QWZs1T0D5sadwVd7fZEg2QGESVeohi0vlrnMYzD+4vKGA7kbRaaEn/DD79FQ0NbI7/r1
	9YEY/2wDtqCEFDLt+XPTRxWvuBzt4ILHu1jX8AmOlXNVd8GBJy0NBLm1FosNtk9I008Jta
X-Received: by 2002:a05:6a21:b85:b0:3b4:7b2a:6a0a with SMTP id adf61e73a8af0-3c08ee94f8dmr8406554637.35.1783442615034;
        Tue, 07 Jul 2026 09:43:35 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d8da9sm15101068c88.14.2026.07.07.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:43:34 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v2] tipc: serialize udp bearer replicast list updates
Date: Tue,  7 Jul 2026 09:42:49 -0700
Message-ID: <20260707164248.821265-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305533-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:tung.quang.nguyen@est.tech,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,est.tech:email,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0602E71DFF8

tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list
with list_add_rcu() / list_del_rcu(), but nothing serializes them. The
add runs from the encap receive softirq (via tipc_udp_rcast_disc())
without rtnl_lock(), so it can race the cleanup delete and corrupt the
list:

 list_del corruption. prev->next should be ffff8880298d7ab8,
   but was ffff88802449ad38. (prev=ffff888027e3ec98)
 kernel BUG at lib/list_debug.c:62!
 RIP: __list_del_entry_valid_or_report+0x17a/0x200
 Workqueue: events cleanup_bearer
 Call Trace:
  cleanup_bearer (net/tipc/udp_media.c:811)
  process_one_work (kernel/workqueue.c:3302)
  worker_thread (kernel/workqueue.c:3466)

The bearer can be enabled from an unprivileged user namespace, as the
TIPCv2 generic-netlink ops carry no GENL_ADMIN_PERM.

Add a spinlock to struct udp_bearer and take it around the
list_add_rcu() in tipc_udp_rcast_add() and the list_del_rcu() loop in
cleanup_bearer() so the two writers can no longer corrupt the list.

While here, switch the read-only walk in tipc_udp_is_known_peer() to
list_for_each_entry_rcu(); it never deletes, so list_for_each_entry_safe()
was misleading.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v2: (per Tung's review)
 - Narrow the lock to just list_add_rcu().
 - Drop the under-lock dup re-check; serializing the writers is enough.
 - Use list_for_each_entry_rcu() in tipc_udp_is_known_peer().

 net/tipc/udp_media.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5840..c6aa8c3c54ce 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -94,6 +94,7 @@ struct udp_replicast {
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
+ * @rcast_lock:	serializes updates to @rcast.list
  */
 struct udp_bearer {
 	struct tipc_bearer __rcu *bearer;
@@ -101,6 +102,7 @@ struct udp_bearer {
 	u32 ifindex;
 	struct work_struct work;
 	struct udp_replicast rcast;
+	spinlock_t rcast_lock; /* protects rcast.list */
 };
 
 static int tipc_udp_is_mcast_addr(struct udp_media_addr *addr)
@@ -281,7 +283,7 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
 static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
 				   struct udp_media_addr *addr)
 {
-	struct udp_replicast *rcast, *tmp;
+	struct udp_replicast *rcast;
 	struct udp_bearer *ub;
 
 	ub = rcu_dereference_rtnl(b->media_ptr);
@@ -290,7 +292,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
 		return false;
 	}
 
-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
+	list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
 		if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_addr)))
 			return true;
 	}
@@ -326,7 +328,9 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
 #endif
 	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
+	spin_lock_bh(&ub->rcast_lock);
 	list_add_rcu(&rcast->list, &ub->rcast.list);
+	spin_unlock_bh(&ub->rcast_lock);
 	return 0;
 }
 
@@ -679,6 +683,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +824,12 @@ static void cleanup_bearer(struct work_struct *work)
 	struct udp_replicast *rcast, *tmp;
 	struct tipc_net *tn;
 
+	spin_lock_bh(&ub->rcast_lock);
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
 		list_del_rcu(&rcast->list);
 		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
 	}
+	spin_unlock_bh(&ub->rcast_lock);
 
 	tn = tipc_net(sock_net(ub->sk));
 
-- 
2.43.0


