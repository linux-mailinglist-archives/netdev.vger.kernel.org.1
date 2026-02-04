Return-Path: <netdev+bounces-256605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKrhMgr6gmm2fwMAu9opvQ
	(envelope-from <netdev+bounces-256605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:49:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF0E2D38
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 08:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE41A3017515
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3F38E12E;
	Wed,  4 Feb 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfC8ph7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BA5389459
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770191343; cv=none; b=dGntWUW4it5N5IQFT4LlmJP1FF4wmMP8jd5exGGoUdcbVR0WvyY9sy1eVWDPfXSzKVU3RXYQIdCxf7wbg4CHXN0VYFK7YvoKAlQLOpiacNp0U8XivNBXRvuBq8fcPNcPRuRfLmmLFdv0GHbqyiEf3eSMGSSojkgZFDN+a+77a24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770191343; c=relaxed/simple;
	bh=oUueKk0WFJ6D3kF92z95RBq4UO36sCKQCxrcBBbfe0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s8FZ4kX1oUTJWqnq7W5BcArMLFI+NeBNpcaZyxTtATw1obA0hPexRu4uoprYWYqYA6JxkyUFh7qpXk2f6WUenFgioC3FoDiKZB+T/+jy17E1pC2f9eNzCy+brdOpbJIG3YGFgMGs3fdkb92opShVsy8nVjUztokCF3b1XeFK9dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfC8ph7+; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b6b0500e06so9388150eec.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 23:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770191342; x=1770796142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJgoZ8VUm2HG9EGStqByiUo8aUNMP6s0utjDXaavqus=;
        b=QfC8ph7+PKpJqNSyB5iqOOxl/V+oKc6vOtCysC9u+WeS9oZ1o+he38XsXZOvRR66Ok
         036w9b1Nkq1tHVuR5O5llrBDHhQJeH51nO5Hd0PlnLsnptwhdIEqwsGKcQX7335uB7AR
         i9GX2HNXUj3Ldknjz71YQm3+AUdFdFXVoX5Gbo+2uwnW1kCwWccobFsPHpOeb8nd7XfD
         DZbBev+OZPgay/X9R6oKZ/F3J00MyBRqnoGzSUZYULHxmNTAuN9vR1UwYGG9TavqE5iF
         wglQsMQBMNlP0V+XuXsD5FjJ9CS4frF/f9pBzYvyczii6xqV6dlZ2rwQaqaw6blV529h
         Z8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770191342; x=1770796142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJgoZ8VUm2HG9EGStqByiUo8aUNMP6s0utjDXaavqus=;
        b=nXrqUGmxDshcHnPjsOtXSFANmlhiBhj5XmpiNmAS+DfxgEOXOdUjeUkgVargPZKt71
         zru3Qbl7bpY7027VQpwVa+MVeWH2Jy9ddqaEmdhy8nK8+GA+B3ijkOztc00IYroPfXdb
         4w3H1KUA6R0EamO0fBOpcOGeu1P0Q6lIQ2iD4kLQXpwz0Nh48O1tfTunpwWFVhQNLENv
         ykg0btd6NVuQcZ/pjbKvJZeNxZAXq9e0NJJacstKdkHoeBkW132aafWwXzfg4cUdiO5v
         AuGpnd23BKEEj+I3qy8D3mBNlHdAWiGczQigTkWjVia4iLcVAOh/5WkoI+5shAq2KFSm
         pBGA==
X-Forwarded-Encrypted: i=1; AJvYcCWUobMd4usM2LlR3VvK8FMFnUSg9KX8Xqv+lY0I+oMsLPOt3XLIadYuUMjuw450XKF9/QsdfuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZ+Ia/bnXtTmkFFn4A485PqLXOUHyZ7atY4vZ8U3sIO6tD63e
	Te7pf2PxqdbYBbGUB5aBu2hyzzLSpsSwJvUepRA1+US8dyZJEilFnABX
X-Gm-Gg: AZuq6aIIBNCG8sSER6gksxl3i8Sd/q4cA2uXsUQmTMTUuv1tNENZJhQ3/g/IEzC5dZs
	pHbzN4DK/G4NjeCoHgulv4NvM+ewqeM8kIctBRfD14U9wFGDK5Vyum3l3wgH6V6mhhS+Cg9OvgL
	VpQKU9cnPCKNjLWV+/uIKdDcGRM6tukq7MYNtp/GqudWbRuX7QUMbGqI6yRKfrRWc3GdQYlps+2
	HtS0tR+lL0kNjmbRYuHILC/lVVLF2Z6Vyl8LxI/Vs6w0gsXuQUqkFVirIpShE1BB1B4kzQCaAqg
	TbH8IEI9g26L3X/bxfciy+WIKIK2Ywt5itxeQmOhTuiAJZoTTYItCpfdzOMUItnk73g1Hc4chEP
	oiyhNIklOHSbIt/FyxUZ+uwb5sHRrsHORWR+Mho9sW6aquV46VCwcKtMv7lIBUfN5C8Ua763f8E
	fZd697yEGsITYPww==
X-Received: by 2002:a05:7301:3d18:b0:2b8:26b8:3421 with SMTP id 5a478bee46e88-2b83291bc15mr1018731eec.4.1770191342381;
        Tue, 03 Feb 2026 23:49:02 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832e4d18fsm1083095eec.13.2026.02.03.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 23:49:01 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>
Cc: Qiliang Yuan <yuanql9@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Wed,  4 Feb 2026 02:48:42 -0500
Message-ID: <20260204074854.3506916-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-256605-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68DF0E2D38
X-Rspamd-Action: no action

Currently, unhash_nsid() scans the entire system for each netns being
killed, leading to O(M_dying_net * N_alive_net * N_id) complexity, as
__peernet2id() also performs a linear search in the IDR.

Optimize this to O(N_alive_net * N_id) by batching unhash operations. Move
unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
single-pass traversal over survivor namespaces.

Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
write lock after the netns is removed from the global list. This batches
the unhashing work and eliminates the O(M_dying_net) multiplier.

To minimize the impact on struct net size, 'is_dying' is placed in an
existing hole after 'hash_mix' in struct net.

Use a restartable idr_get_next() loop for iteration. This avoids the
unsafe modification issue inherent to idr_for_each() callbacks and allows
dropping the nsid_lock to safely call sleepy rtnl_net_notifyid().

Clean up redundant nsid_lock and simplify the destruction loop now that
unhashing is centralized.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v6:
 - Use M_dying_net and N_alive_net terminology for clarity.
 - Correct complexity analysis: __peernet2id() performs a linear search.
 - Move 'is_dying' to a structural hole after 'hash_mix' to save memory.
 - Scope 'id' variable locally within the traversal loop.
 - Simplify IDR traversal logic with unconditional increment.
v5:
 - Use idr_get_next() for restartable iteration safely handling removals.
 - Drop unhash_nsid_callback() to avoid context safety issues.
v4:
 - Move unhash_nsid() out of the batch loop to reduce complexity from O(M*N) to O(N).
 - Use idr_for_each() for efficient, single-pass IDR traversal.
 - Mark 'is_dying' under net_rwsem to safely identify and batch unhashing.
 - Simplify destruction loop by removing redundant locking and per-netns unhash logic.
v3:
 - Update target tree to net-next.
 - Post as a new thread instead of a reply.
v2:
 - Move 'is_dying' setting to __put_net() to eliminate the O(M_batch) loop.
 - Remove redundant initializations in preinit_net().
v1:
 - Initial implementation of batch unhash_nsid().

 include/net/net_namespace.h |  1 +
 net/core/net_namespace.c    | 34 +++++++++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..db291cc7afe3 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -120,6 +120,7 @@ struct net {
 	 * it is critical that it is on a read_mostly cache line.
 	 */
 	u32			hash_mix;
+	bool			is_dying;
 
 	struct net_device       *loopback_dev;          /* The loopback */
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a6e6a964a287..aef44e617361 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
 }
 EXPORT_SYMBOL_GPL(net_ns_get_ownership);
 
-static void unhash_nsid(struct net *net, struct net *last)
+static void unhash_nsid(struct net *last)
 {
-	struct net *tmp;
+	struct net *tmp, *peer;
+
 	/* This function is only called from cleanup_net() work,
 	 * and this work is the only process, that may delete
 	 * a net from net_namespace_list. So, when the below
@@ -634,22 +635,26 @@ static void unhash_nsid(struct net *net, struct net *last)
 	 * use for_each_net_rcu() or net_rwsem.
 	 */
 	for_each_net(tmp) {
-		int id;
+		int id = 0;
 
 		spin_lock(&tmp->nsid_lock);
-		id = __peernet2id(tmp, net);
-		if (id >= 0)
-			idr_remove(&tmp->netns_ids, id);
-		spin_unlock(&tmp->nsid_lock);
-		if (id >= 0)
-			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
+		while ((peer = idr_get_next(&tmp->netns_ids, &id))) {
+			int curr_id = id;
+
+			id++;
+			if (!peer->is_dying)
+				continue;
+
+			idr_remove(&tmp->netns_ids, curr_id);
+			spin_unlock(&tmp->nsid_lock);
+			rtnl_net_notifyid(tmp, RTM_DELNSID, curr_id, 0, NULL,
 					  GFP_KERNEL);
+			spin_lock(&tmp->nsid_lock);
+		}
+		spin_unlock(&tmp->nsid_lock);
 		if (tmp == last)
 			break;
 	}
-	spin_lock(&net->nsid_lock);
-	idr_destroy(&net->netns_ids);
-	spin_unlock(&net->nsid_lock);
 }
 
 static LLIST_HEAD(cleanup_list);
@@ -674,6 +679,7 @@ static void cleanup_net(struct work_struct *work)
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
 		ns_tree_remove(net);
 		list_del_rcu(&net->list);
+		net->is_dying = true;
 	}
 	/* Cache last net. After we unlock rtnl, no one new net
 	 * added to net_namespace_list can assign nsid pointer
@@ -688,8 +694,10 @@ static void cleanup_net(struct work_struct *work)
 	last = list_last_entry(&net_namespace_list, struct net, list);
 	up_write(&net_rwsem);
 
+	unhash_nsid(last);
+
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
-		unhash_nsid(net, last);
+		idr_destroy(&net->netns_ids);
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
-- 
2.51.0


