Return-Path: <netdev+bounces-301419-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2DfxLs3COmp+GAgAu9opvQ
	(envelope-from <netdev+bounces-301419-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:30:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B36B910B
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:30:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=GnxjgxZW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301419-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301419-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8092D301A35A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B28030C60F;
	Tue, 23 Jun 2026 17:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD0B388873
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:30:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235844; cv=none; b=eebgJyjlS0dG2uRB1Bp2chyU1FSi4vf9hK7TUCyCeDYZ2fdn62AC5DRYrZNhRMmuWRJjEVKRud5QAnxGu45K+peNh5kqvXwiq2mgg7j9XiuvYVaMipVTwJKk70zLphURp+viM17lG7/XwXjWP3Wp4NR9Tp5i7uh1+s8rblJixJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235844; c=relaxed/simple;
	bh=5pxmfYp/d6yD//l9o3CfXBAnBIzh37tIRQhW+4hRD0E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h9smFRMytlh1KlKbqkUU1Auydc2R4Xco7JBdHK4yKSIuIBMeWituID+5rMN6snfI3VDlCHZj8O09ZimmSxIO4/4lCAXYIn5UT4+JLwUzc3whRwqUGw1JFeygX/Kv6le5LOc0UoFFdszeI9M8nV8cNsIfLuI/K/AWTPgFGeBMu8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GnxjgxZW; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-51768072950so309681cf.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782235842; x=1782840642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4GgACZL9yBy0dfeG/FhTFoH9/9R2+U2uHa1+9ggdJB0=;
        b=GnxjgxZW3LMF5KI6I4N0N1WeFGEQgfHeS20wjV1ConqM9DJ/RLnl/SWOGnSUpellWE
         +I3ZrzW7q2ptH08mnHptJtW77Ly/pAjroFjaTkoOsFxfbvtl/Yir9CsY2ymjV1cU6Jb+
         RR8wspWeqPxfu7EE57j3L9InYesMZBPS7kNpJO9i8AyN1ATQTfQcFLG2pnrfevKhL7RH
         k3RpgkjQJyCJ2YpHb8ja/Sz/bZw8N9aBIj8E622sVrY90PFjrthuCoHvuZS5WEz+ASGF
         2fQxWhMRKfojghAeGwXBa+8c9TbAIOaRA2bT7aVjn0zVYbNAIMm3/ZTl3GOZkiq9k6Gb
         6Yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235842; x=1782840642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GgACZL9yBy0dfeG/FhTFoH9/9R2+U2uHa1+9ggdJB0=;
        b=j9P/YQjQN5scWFLdBluhmgAb9ZKhK8zMulQSO5Ov2O/XSfoH6EPzYwzQ+lVtDumLVL
         Qa62C3KMuICcUJ06jJHzWMsz/CLoS1TxxaOWNA0aSHeU1eqa6x32/keFKLzn7roCAH8F
         2hn9ujoseQ8ZTSd4Qnz5VNuIr9Im+bEEcjy1/utvm2ok7OtacOIcBfXYIwVlaHXjNy9H
         bwCz9eSykF8I2XQZGrKJpL+wHf0PoT6k8pRFE3eojN25CMpS7ct1vT6L4dlVwVrlSt+V
         dmDgHirRz22XxuHm2yUt7Q3Ty8bGqltIXR5JejWwusyvey6wzNViYOffZYuPy3FTZJP6
         zZKg==
X-Forwarded-Encrypted: i=1; AFNElJ81jXC5huQknAMxTIqKDsEQHLXMRNDEFAwb9SoKbm2OkxayOg5B4s7MjUrd6Of7bP4YnC+ZE4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw823Qos7xHT0zCY2rIur5pVM3go3ZS1zRJfTnk3bn54uV1V0GJ
	pa6UU2Wtt1jibu6Vtw1xLQpE/UCKG6HcW9AzQ3Ua5f4JHrxWTAZB17cLMUWwbHfQRzIM0evfUSq
	0IZcblaFN/aKrXg==
X-Received: from qtbe1-n2.prod.google.com ([2002:a05:622a:e141:20b0:50b:4726:f15a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7e90:0:b0:517:9206:10fd with SMTP id d75a77b69052e-519e4a36ae8mr286669671cf.16.1782235833930;
 Tue, 23 Jun 2026 10:30:33 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:30:29 +0000
In-Reply-To: <20260623173030.2925059-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623173030.2925059-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260623173030.2925059-2-edumazet@google.com>
Subject: [PATCH v2 net 1/2] tipc: fix UAF in cleanup_bearer() due to premature dst_cache_destroy()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, tipc-discussion@lists.sourceforge.net, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:tipc-discussion@lists.sourceforge.net,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com,m:lucienxin@gmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301419-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,redhat.com,lists.sourceforge.net,vger.kernel.org,syzkaller.appspotmail.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,e14bc5d4942756023b77];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B60B36B910B

TIPC UDP media bearer teardown calls dst_cache_destroy() on its
replicast caches before calling synchronize_net() to wait for
concurrent RCU readers (transmitters) to finish:

static void cleanup_bearer(struct work_struct *work)
{
...
	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
		dst_cache_destroy(&rcast->dst_cache);
		list_del_rcu(&rcast->list);
		kfree_rcu(rcast, rcu);
	}
...
	dst_cache_destroy(&ub->rcast.dst_cache);
	udp_tunnel_sock_release(ub->sk);
	synchronize_net();
...
}

This is highly buggy because dst_cache_destroy() immediately frees the
per-CPU cache memory (free_percpu()) and releases the cached dst
entries without any synchronization.

If a concurrent transmitter (e.g., tipc_udp_xmit()) is running on another
CPU under RCU protection, it can call dst_cache_get() concurrently,
leading to:
1. Use-After-Free on the per-CPU cache pointer itself (crash).
2. "rcuref - imbalanced put()" warning if it attempts to release a
   dst that was concurrently released by dst_cache_destroy().

Furthermore, calling kfree(ub) immediately after synchronize_net() without
closing the socket first (or waiting after closing it) leaves a window
where a concurrent receiver (tipc_udp_recv()) could start after
synchronize_net(), access ub, and suffer a UAF when kfree(ub) runs.

To fix this, we must defer dst_cache_destroy() and kfree(ub) until after
we have ensured that no more readers can see the bearer/socket and all
existing readers have finished:

1. Defer rcast entry destruction (both dst_cache_destroy() and kfree())
   to an RCU callback using call_rcu_hurry().
   Using call_rcu_hurry() ensures the dst entries are released quickly.

2. Release the bearer socket using udp_tunnel_sock_release() (stops
   new receive readers).

3. Call synchronize_net() to wait for all outstanding RCU readers
   (both transmit and receive) to finish.

4. Now that it is safe, call dst_cache_destroy() on the main bearer
   cache, and free ub.

Note: 3) and 4) can be changed later in net-next to also use
call_rcu_hurry() and get rid of the synchronize_net() latency.

Fixes: e9c1a793210f ("tipc: add dst_cache support for udp media")
Reported-by: syzbot+e14bc5d4942756023b77@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a396a66.52ae72c2.136ac7.0003.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: tipc-discussion@lists.sourceforge.net
---
v2: addressed Xin Long feedback
v1: https://lore.kernel.org/netdev/CANn89i+dkbrSAwvaWXW7yWMfcwUebuTBLG5T7AGZaZcpVYGyfQ@mail.gmail.com/T/#m7bbeedffe3bedb69e33236410e3833c7ce809850
 net/tipc/udp_media.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 988b8a7f953ad6da860e6190f1f244650f121dce..66f3cb87a0aaaac8f40e8f237ab9a44d539b1cd8 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -803,6 +803,14 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 	return err;
 }
 
+static void rcast_free_rcu(struct rcu_head *rcu)
+{
+	struct udp_replicast *rcast = container_of(rcu, struct udp_replicast, rcu);
+
+	dst_cache_destroy(&rcast->dst_cache);
+	kfree(rcast);
+}
+
 /* cleanup_bearer - break the socket/bearer association */
 static void cleanup_bearer(struct work_struct *work)
 {
@@ -811,18 +819,17 @@ static void cleanup_bearer(struct work_struct *work)
 	struct tipc_net *tn;
 
 	list_for_each_entry_safe(rcast, tmp, &ub->rcast.list, list) {
-		dst_cache_destroy(&rcast->dst_cache);
 		list_del_rcu(&rcast->list);
-		kfree_rcu(rcast, rcu);
+		call_rcu_hurry(&rcast->rcu, rcast_free_rcu);
 	}
 
 	tn = tipc_net(sock_net(ub->sk));
 
-	dst_cache_destroy(&ub->rcast.dst_cache);
 	udp_tunnel_sock_release(ub->sk);
 
-	/* Note: could use a call_rcu() to avoid another synchronize_net() */
 	synchronize_net();
+
+	dst_cache_destroy(&ub->rcast.dst_cache);
 	atomic_dec(&tn->wq_count);
 	kfree(ub);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


