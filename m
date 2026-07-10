Return-Path: <netdev+bounces-306639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sz61KDwwUWo2AgMAu9opvQ
	(envelope-from <netdev+bounces-306639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:47:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F045573D1BE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 19:47:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fPfeCXaU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306639-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306639-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3ED230037EA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79D374725;
	Fri, 10 Jul 2026 17:47:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66423603D3
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 17:47:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783705658; cv=none; b=dWWgZpGr7quOtsJ+hq2oKeIXbYZq/apzaFp6ZjWuGGwrVu1wxKINO7fHogxOfHAH8mU79C8i2yIGBCRXYE+u8c9KDPeY5R+A8TS4rzQUVTzBn1yrp7Kvb2TJkug5WerI0WTKo1ImwJkDgx6AIvMu3f/QrwXzYdfcoiGHysaQrAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783705658; c=relaxed/simple;
	bh=4b0AqcIMhIJ5ZbjskxyymRxbmi9O4aj7aOWacnAUjUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLt16SVDtHmEy82CLXD2UXjE/CdOxTM0y361GGcu7lEB9CcgcoEXkIPMdrmldmuCt/+8DTL24dibIu5N3bYw0eEyx/DLy1PRA82G6LFCBsNzZPs6yEKoDMr6N+T/VxICqR91/Ej3eW+HXFYL6OZJfaLjlR2XfzlIJvWkZZTDq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPfeCXaU; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso14851215ad.3
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783705656; x=1784310456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DTSVDCF45UPt8odAkpuTFIMWRAzm5GXA164W4J3m4sg=;
        b=fPfeCXaUnLuwesQxKsAoULMN72LPWYt5DoiCh3y+Mn3PEffKK8AHo/p1FhYLbe94nv
         C9SI0jnaC3/LrAnvmZYxjBJ3W9Ms/xeqjBcTsPNYWtp/Ndbl8GfoKwDqXYJ3+pLodYC4
         JXf5oWdQ7rljMoOdBIW+iIrB42FvDGhHzzQSKGMRvoGkbn31aeFn2NEGAYG3jpVjl36K
         LCT6+fWjzFvavd0JCxJ1AhRuSzsdoU/waU0dbC0T4RGGhzXXlV7rUPZ+hUU7/0OzcczL
         gW30ra2HDWCfbR2GATNG30PTcM1maSoXizPqluOz6dbqY9jHhqQ++4tHLpqTZvvBUegB
         Cg7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783705656; x=1784310456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DTSVDCF45UPt8odAkpuTFIMWRAzm5GXA164W4J3m4sg=;
        b=hvl7LBtDRIQJ2AEs+5ORje1dP8m4kVQj3QwHKS0wQDYL5wRAUx+QsW69qz9+tOMTYk
         05/w2XWoKfpXm6FAm/L/S6bGapNxD98G4wCK0o3+lokDBd+KzVvyWFdM4BKW0XJ9FJry
         t/KeKrz49rMJeglnE+Fd0/ehK2Y4HxFmiI22wBUzcLryPOqQh/SQdgpaD3dy6zhnAnFt
         KcsmQirxYI6G0YX2yH02od4wixQK5lcLkxt9fDbZhUasHxtIAlrU/COeFo9Idso0tBn4
         ODs+p56Hp9fUxz00lLN27rGRYyOzkQueLlF8pdpyGZnu1I6cJ2cz0h/J2kdOTno99srU
         lVxw==
X-Gm-Message-State: AOJu0Yw98FLJgi1kAW1OuSP0A+jZJfjmcymYkVEP8sS8Du6OvQW5Fshf
	pTR9c8dxV+36fRO5G6sMkoxpic3WOGChEKkrDyvCyRiSujeu6CngjUZJ
X-Gm-Gg: AfdE7cnaEGa5bkDVlZjjxpeSmrIgKlldZCzwjJ8tsuf7aH/uG8yAoD5SrFOzA7cNkjD
	fAg7D64hb5JDMIY1Bom4A5kD2ZlO8/yW2YHwXEcCZ66eSyo9ENRzPtp9Ybd8J7M5SGtlJHogkVD
	6I3TOiKSmaiJwG/spKon+bOl/1TyrpnQvJK4i8zdUWoMo02y+LGBaz9P9C+YG/38nyVTb9KVSUo
	3j9mxpcjNCQLY565unBe+z5hqZVLIPlS2oigh5KBiP29h3WK7JZqgW4uY3u8UVkXF50b0UApzWf
	a6F5sgjFFrMmVYe6Zl21ywy3CCYrlfOG/jrTyNlK1iUlLRHtSUYN/RgYSiKf7efJ7aoGSqw+ghh
	Clt7+W4b5EPQW+vA2fjtxuHCjJUSspZaOEhpUG6yZYzHxd4z+/PAZbA2buIFHYBtKqZTYQ0fJaQ
	PB1l/oSM4l48raqTd0FoYd7aBErX8DzehWiSdf63UIJS9YapoeaINjTfBQiA==
X-Received: by 2002:a05:6a21:6916:b0:3bf:6c08:fb9e with SMTP id adf61e73a8af0-3c110ba1064mr22179637.50.1783705656011;
        Fri, 10 Jul 2026 10:47:36 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm39670474c88.13.2026.07.10.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:47:35 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net v4] tipc: serialize udp bearer replicast list updates
Date: Fri, 10 Jul 2026 10:47:19 -0700
Message-ID: <20260710174718.1969789-2-bestswngs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,est.tech,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306639-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jmaloy@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F045573D1BE

tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list with
list_add_rcu() / list_del_rcu(), but nothing serializes them. The add runs
from the encap receive softirq (via tipc_udp_rcast_disc()) without
rtnl_lock(), so it can race the cleanup delete and corrupt the list:

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

Add a spinlock to struct udp_bearer and take it around the list_add_rcu()
in tipc_udp_rcast_add() and the list_del_rcu() loop in cleanup_bearer() so
the two writers can no longer corrupt the list.

Reject a duplicate peer under the same lock before allocating, and remove
tipc_udp_is_known_peer(). The old lockless pre-check in
tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer
could both find it absent and add it twice. Doing the check under
rcast_lock in tipc_udp_rcast_add(), before the allocation, makes it the
single point of truth for both the discovery and the netlink add paths and
keeps a flood of the same address from churning the allocator.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
v4: (per Tung's review)
 - Reject a duplicate under rcast_lock before allocating rcast, so a
   flood of the same address can't churn the allocator.
v3:
 - Check for a duplicate peer in tipc_udp_rcast_add() under rcast_lock
   and remove tipc_udp_is_known_peer().
v2:
 - Narrow the lock to the list mutation.

 net/tipc/udp_media.c | 53 ++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5..3f0d75d72 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -94,6 +94,7 @@ struct udp_replicast {
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
+ * @rcast_lock:	serialize updates to @rcast.list against concurrent updaters
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
@@ -278,26 +280,6 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
 	return err;
 }
 
-static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
-				   struct udp_media_addr *addr)
-{
-	struct udp_replicast *rcast, *tmp;
-	struct udp_bearer *ub;
-
-	ub = rcu_dereference_rtnl(b->media_ptr);
-	if (!ub) {
-		pr_err_ratelimited("UDP bearer instance not found\n");
-		return false;
-	}
-
-	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
-		if (!memcmp(&rcast->addr, addr, sizeof(struct udp_media_addr)))
-			return true;
-	}
-
-	return false;
-}
-
 static int tipc_udp_rcast_add(struct tipc_bearer *b,
 			      struct udp_media_addr *addr)
 {
@@ -308,16 +290,34 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 	if (!ub)
 		return -ENODEV;
 
+	/* Serialize with other updaters and reject a duplicate before
+	 * allocating, so a flood of the same address can't churn the
+	 * allocator.
+	 */
+	spin_lock_bh(&ub->rcast_lock);
+	list_for_each_entry(rcast, &ub->rcast.list, list) {
+		if (!memcmp(&rcast->addr, addr, sizeof(*addr))) {
+			spin_unlock_bh(&ub->rcast_lock);
+			return 0;
+		}
+	}
+
 	rcast = kmalloc_obj(*rcast, GFP_ATOMIC);
-	if (!rcast)
+	if (!rcast) {
+		spin_unlock_bh(&ub->rcast_lock);
 		return -ENOMEM;
+	}
 
 	if (dst_cache_init(&rcast->dst_cache, GFP_ATOMIC)) {
+		spin_unlock_bh(&ub->rcast_lock);
 		kfree(rcast);
 		return -ENOMEM;
 	}
 
 	memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
+	list_add_rcu(&rcast->list, &ub->rcast.list);
+	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
+	spin_unlock_bh(&ub->rcast_lock);
 
 	if (ntohs(addr->proto) == ETH_P_IP)
 		pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);
@@ -325,8 +325,6 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 	else if (ntohs(addr->proto) == ETH_P_IPV6)
 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
 #endif
-	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
-	list_add_rcu(&rcast->list, &ub->rcast.list);
 	return 0;
 }
 
@@ -361,9 +359,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (likely(tipc_udp_is_known_peer(b, &src)))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &src);
 }
 
@@ -644,9 +639,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr)
 		return -EINVAL;
 	}
 
-	if (tipc_udp_is_known_peer(b, &addr))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &addr);
 }
 
@@ -679,6 +671,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +812,12 @@ static void cleanup_bearer(struct work_struct *work)
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


