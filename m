Return-Path: <netdev+bounces-306412-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9iV2Fh1nUGoiyQIAu9opvQ
	(envelope-from <netdev+bounces-306412-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:29:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B1736F78
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 05:29:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eZ9n+QCh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306412-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306412-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EEF830174E4
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 03:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90AF367B6D;
	Fri, 10 Jul 2026 03:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286B3672AC
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 03:29:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654171; cv=none; b=sBPdVnTQTFRuGVYT5m6LD/aUP0vH5wZRFH5aBCx9QW0SxL+yFZkGou1pxkfkFNd3f3Xw0Q7+eraPa6wY3agrYFoOtYeJmkNB9eTcyPsenjxqqSbX+kMdhIwSmCKdJd3/uAVZvLMb/uuG5KiYZWCMnh4iTvD26KIaDt61E41fTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654171; c=relaxed/simple;
	bh=5TYO/Wd6tl4LpGGjhxsPJMkGk6HXhbveSmQhJ8eP+h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDmSxl4ttR3V2RxW0bBa0FRwSCeWd9ewoE45baTiOSKNiDYYQjOhj787d1yJ7ZSAHXEY91aOd1QnqoqlfP2B2jYLzSjspkdINuPThJwwL3POKjQEYR2VbOPnkMTzKeXxtW7+bxVtpWGS9bKY9M1kF2JcGqo6p2Zww422L5Sctfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ9n+QCh; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso683757a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783654169; x=1784258969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nxoHTdu7ii+aHwieBMWPqoLypcrKazNhNG1p+ougjzY=;
        b=eZ9n+QChSWTF8buha7eKLrCOh3t7YHNmue+W5lz9khpVXawq8G82Aqs94p9WAuMcYh
         4gWZcP1vyR+m39Yyo/nOLPeczUYGEz9xtqEflI3c9VCZGPr/hmT1S6If8/m/+z86b1zY
         to1A1KUnljCQZMw9W742F/E96WQeH7smpLlQsDIYPW5iULIG7Zkpt8ysNvrEELAQ2BMT
         2iKoGHZiS2JrdyKo/Nidzt6ihn/CDKNL4gNpdi3vpD8lUI668EAcPnxfxorVIGemw7FT
         Ryin9ajNxYvdOCVNUXFJi9RQ2WSDnfORo9GYX6vhzLNQP4XSSAS4l/tGTmvbBGaewxp8
         ekhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783654169; x=1784258969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nxoHTdu7ii+aHwieBMWPqoLypcrKazNhNG1p+ougjzY=;
        b=lghIWPnBnmkaRXsxwK9pEksfay42wvM7NxTQolkiJUMfawl1/5M8JUsQIIUhAHYfCJ
         s3TgAKYdY44cT7l29JzrQMC1sI+aN2CgYv72mheNJsPPUzYAh5H+aH5jzhv/3QY6AtfX
         4qmqIQWM69hlCPEAlMIjEoy+t/e+j4QF9e8rRqP7zp90cAs6AYc8vfK9C/hUpIheBV5E
         XT2V7uDNp2Xeqgb6c3aFephhsPC9gVyd3rZIerlo+Cu9f00Npv4ZwwBGem8SErn+KU+f
         YA3b2lFBBjqlyMHrBo7jSBx3WP9ELXVmxs+ixflQlePQZs8M8ISp/WPwMw6Sepd8uSr0
         Ekvg==
X-Gm-Message-State: AOJu0Yxr12bhUSr0RoQyr7o7lzNVXDfNGfxq9bEwIMpUNcd8+1sYwOtN
	XVgpQwkZRp6v5mZUB/sUpO23JjzmqS8GTIK4sJZ5bzY8SxOBV0rVMB7E
X-Gm-Gg: AfdE7cnVGl2s4x+4AWb5rb89RbWg2tF1qHgbkP7RCsoNlRUJCWvlZPQYhTt1qzQVoUz
	8kuklHQpnLZdnkqZnm/huJTD5UulQwZJlkx6sIXVmxdBIeHPgBr4nv5fDuN8ksvUFe7NrKfZeOd
	/HsSqcHagexHMgUFb58OsOzkLfbRPVj2bAEm4jFrREu2gq237ycYJ7kDX3Q3a5chJkBS9sSTW/k
	tZd7HltMoU6EzeFRrwPHLlqVXdYyuYepob7IemAd4/7bqxME/nzVbn6iJxXQb3uWUvRoZ4T/ctM
	4z38VuXBHUjB+ytuzYmjkP2+giDKEdVNHFR+Cvr3PiLRiGbw9zgKzOWAdTAXvRYRNERmXbvZoxJ
	kaEqrcFDmwg9jsQYiSoZ2HJaYy0puc9AxqYQGCEgDeo0E9gZttnn5F00LHWNFM3a46l1Gn5Y+Fy
	yTTh1deAyyGwyZzhrY494HpKFCUuofhLWSVqkRSOLjGBiP5TzJOfL4qv4vCg==
X-Received: by 2002:a17:90a:da8b:b0:380:40b:f30a with SMTP id 98e67ed59e1d1-3893ff630b6mr9874146a91.13.1783654168970;
        Thu, 09 Jul 2026 20:29:28 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a583bcsm40512297eec.19.2026.07.09.20.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 20:29:28 -0700 (PDT)
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
Subject: [PATCH net v3] tipc: serialize udp bearer replicast list updates
Date: Thu,  9 Jul 2026 20:29:02 -0700
Message-ID: <20260710032901.4099197-2-bestswngs@gmail.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,est.tech,asu.edu,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-306412-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,est.tech:email,asu.edu:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D66B1736F78

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

Check for a duplicate peer under the same lock before adding, and remove
tipc_udp_is_known_peer(). The old lockless pre-check in
tipc_udp_rcast_disc() was racy: two softirqs discovering the same peer
could both find it absent and add it twice. Doing the check under
rcast_lock in tipc_udp_rcast_add() makes it the single point of truth for
both the discovery and the netlink add paths.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Suggested-by: Tung Nguyen <tung.quang.nguyen@est.tech>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
v3: (per Tung's review)
 - Check for a duplicate peer in tipc_udp_rcast_add() under rcast_lock
   before adding, and remove tipc_udp_is_known_peer().
 - This also drops the list_for_each_entry_rcu() change to
   tipc_udp_is_known_peer() from v2, since the helper is gone.
v2:
 - Narrow the lock to the list mutation.

 net/tipc/udp_media.c | 45 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5..3a7d9b15c 100644
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
@@ -278,30 +280,10 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
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
-	struct udp_replicast *rcast;
+	struct udp_replicast *rcast, *tmp;
 	struct udp_bearer *ub;
 
 	ub = rcu_dereference_rtnl(b->media_ptr);
@@ -326,7 +308,19 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 		pr_info("New replicast peer: %pI6\n", &rcast->addr.ipv6);
 #endif
 	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
+
+	/* serialize with other updaters and drop duplicates under the lock */
+	spin_lock_bh(&ub->rcast_lock);
+	list_for_each_entry(tmp, &ub->rcast.list, list) {
+		if (!memcmp(&tmp->addr, addr, sizeof(*addr))) {
+			spin_unlock_bh(&ub->rcast_lock);
+			dst_cache_destroy(&rcast->dst_cache);
+			kfree(rcast);
+			return 0;
+		}
+	}
 	list_add_rcu(&rcast->list, &ub->rcast.list);
+	spin_unlock_bh(&ub->rcast_lock);
 	return 0;
 }
 
@@ -361,9 +355,6 @@ static int tipc_udp_rcast_disc(struct tipc_bearer *b, struct sk_buff *skb)
 		return 0;
 	}
 
-	if (likely(tipc_udp_is_known_peer(b, &src)))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &src);
 }
 
@@ -644,9 +635,6 @@ int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr)
 		return -EINVAL;
 	}
 
-	if (tipc_udp_is_known_peer(b, &addr))
-		return 0;
-
 	return tipc_udp_rcast_add(b, &addr);
 }
 
@@ -679,6 +667,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +808,12 @@ static void cleanup_bearer(struct work_struct *work)
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


