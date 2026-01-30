Return-Path: <netdev+bounces-254980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORNK9QXfGk/KgIAu9opvQ
	(envelope-from <netdev+bounces-254980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:30:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 139F2B6721
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C20EB300BDBD
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305EC309EFF;
	Fri, 30 Jan 2026 02:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+4iYFGU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A92D131A
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740201; cv=none; b=HzjT7HSc0VLbnRIETJLLrRMjNshUv6tr2IDwqeasnlq2cQ7nl1/AoFC7tX7LNQ30yGUdiEmKDDtKLw3prKzs+eCQk+D7DNlfWpwzSr796tBhA6yo/B8KhlSg7u1nm/IvLbqwZvtWzGfneU4v7JNhGmA35H7oZ2PERodFbjAXFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740201; c=relaxed/simple;
	bh=Hpy7Ihf3i1gURmCZqvZpH2haL+/JX9vw1L+0TwSCoM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMxwGxU+G8iYta+mXvAyKZyYq6t1QydZU8vsZTFjhc5c7pBg4F0MO22ozQC1BLgfeBkNby/92ukytKi1eeCaOxlk+v+S/w9amf7T3SwTzh3HQfWJY3GWhgUfJlhk+h+BqJkbn5M1ppbk7PNXSZY0lUE4N3SK9mwU9dDoK0Y11oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+4iYFGU; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12460a7caa2so2469325c88.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769740199; x=1770344999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L8pSvMXbcScI7VOTlnNV6K7+YBBPc5KlELWYhGa9o+w=;
        b=V+4iYFGUv7jH0E4F8vzKRU0xCWlWxyoRVrU3BW/XxiBQvzbT0dukr3ix/cpPqpE4pI
         bpVTnswXmQVpBqn/2YgzZJ0xVtPQVmloo0dbX/AXhGOmNCFY/B52AdIa6KF0ivvElHt7
         U2HHD6DbhgLZkRjzuCwZ+oWIpgudntcz1AfGhhE8z1ZNbm6mnWW49PGZ9auciBRqSJT2
         ebsyE4z1bxbkeOLcKeP/neGffJi9biAo5J+9pBbwGJqtKFVT75WB8d5Kob7pkh2xslbl
         KBhQzvLQ3g/2Y96ROMCtfUG7o7a7M2URmZtZYIqEadw62/ejoQbUZ7mz6+MJqfKGK06/
         plow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740199; x=1770344999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8pSvMXbcScI7VOTlnNV6K7+YBBPc5KlELWYhGa9o+w=;
        b=R3QbjV/c8qUciaKmC8IsM4P/cXy2fUzf/tnyXAIxCxK7/aikWsBXk66sJZnss2VqLq
         xsvvdhdffiKKZ3Oz36Dktv1mJuT7O8njshM2VWQbF3/oQeciJKDMGJQKMkmsF5k+abtX
         zyWChdkwrR/j8+2r3ZISjo7qvpaf4h6W59xPHa1QkaobPKsAtMZBK8BSroI8qPAOIOB4
         HkCETFhUTP/YHPAnUeeVWnP49yHgPUzquM1q8IaPKm6ROZXCCcMV6iG4QivVEzu5zw3S
         y0sQthv51G0GBeWz6d4OX35B1nGi6lpNG4IwITxtmNBW/adEFQtOuP5UKHTjqOCuRJNq
         eisA==
X-Forwarded-Encrypted: i=1; AJvYcCV8zCbQirFt5ECtz42/CspnDY7k97VJzCf3lmy8O+7LlamuiRwJcbxfm5FHJ1hgMhHHIr2YAxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDrP7fLpdzVKa+ko1m8k6JBCNOYG2vcjwBqBhwJMQDK7qZ7OnT
	OXfikNWIY+QWOGPm+PUfV9UGBWJ3fvy/rEWDVS571Rs4n8XzQyekUB+E
X-Gm-Gg: AZuq6aJJgvWXbGjgO6N5YIw0f68w2Gyu4z6oBkaSIimDKN2gqMn1v1vSsP6wrfbBEpY
	pfnkayT0DmUPaFtB1Jr6i/xpuI8Y6wugG0dJUCjus0k8wrLqF9w3h7iMQ75ZJopoDjWU5s85Xjc
	GovUeXl+splMHoUBAZayBrbGA2lIb9LHDUv8WBrtClo582SOpRjwOJ+DhuQVZKvpaLzuBNDtOWZ
	vOKyvYkiqjjIkqmC3NyvVrQDtYpi4mYIPziGg4sie2u34M88nE76vXFFMcjQc244nKDu6GnsunH
	uwbFVVKqyIhxpyvrCRM5gK0woTmbfuboATCQoTQFR/awXNu7eWVxmrO7qzb908+t7N2Swi8rJYm
	gcK97iCppWR2bek3ScsaxBouyGytbGqxhNGLwYgeplCGzIed+AuRqeNwN2dV4FoCC741VLl1Oxx
	KxyZc=
X-Received: by 2002:a05:7300:6da1:b0:2b4:80f0:3bf3 with SMTP id 5a478bee46e88-2b7c8632b58mr626406eec.1.1769740198655;
        Thu, 29 Jan 2026 18:29:58 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7b9e2774asm4331618eec.24.2026.01.29.18.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:29:58 -0800 (PST)
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
Subject: [PATCH v4] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Thu, 29 Jan 2026 21:29:37 -0500
Message-ID: <20260130022951.2489133-1-realwujing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254980-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 139F2B6721
X-Rspamd-Action: no action

Currently, unhash_nsid() scans the entire system for each netns being
killed, leading to O(M_batch * N_system * log(N_ids)) complexity.

Optimize this to O(N_system * N_ids) by batching unhash operations. Move
unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
single-pass traversal over survivor namespaces using idr_for_each().

Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
write lock after the netns is removed from the global list. This batches
the unhashing work and eliminates the O(M_batch) multiplier.

Clean up redundant nsid_lock and simplify the destruction loop now that
unhashing is centralized.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
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
 net/core/net_namespace.c    | 41 +++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index cb664f6e3558..bd1acc6056ac 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -69,6 +69,7 @@ struct net {
 
 	unsigned int		dev_base_seq;	/* protected by rtnl_mutex */
 	u32			ifindex;
+	bool			is_dying;
 
 	spinlock_t		nsid_lock;
 	atomic_t		fnhe_genid;
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a6e6a964a287..9ea05fb9df5b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -624,9 +624,29 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
 }
 EXPORT_SYMBOL_GPL(net_ns_get_ownership);
 
-static void unhash_nsid(struct net *net, struct net *last)
+static int unhash_nsid_callback(int id, void *p, void *data)
+{
+	struct net *tmp = data;
+	struct net *peer = p;
+
+	if (peer->is_dying) {
+		spin_lock(&tmp->nsid_lock);
+		if (idr_find(&tmp->netns_ids, id) == peer)
+			idr_remove(&tmp->netns_ids, id);
+		else
+			peer = NULL;
+		spin_unlock(&tmp->nsid_lock);
+
+		if (peer)
+			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL, GFP_KERNEL);
+	}
+	return 0;
+}
+
+static void unhash_nsid(struct net *last)
 {
 	struct net *tmp;
+
 	/* This function is only called from cleanup_net() work,
 	 * and this work is the only process, that may delete
 	 * a net from net_namespace_list. So, when the below
@@ -634,22 +654,10 @@ static void unhash_nsid(struct net *net, struct net *last)
 	 * use for_each_net_rcu() or net_rwsem.
 	 */
 	for_each_net(tmp) {
-		int id;
-
-		spin_lock(&tmp->nsid_lock);
-		id = __peernet2id(tmp, net);
-		if (id >= 0)
-			idr_remove(&tmp->netns_ids, id);
-		spin_unlock(&tmp->nsid_lock);
-		if (id >= 0)
-			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
-					  GFP_KERNEL);
+		idr_for_each(&tmp->netns_ids, unhash_nsid_callback, tmp);
 		if (tmp == last)
 			break;
 	}
-	spin_lock(&net->nsid_lock);
-	idr_destroy(&net->netns_ids);
-	spin_unlock(&net->nsid_lock);
 }
 
 static LLIST_HEAD(cleanup_list);
@@ -674,6 +682,7 @@ static void cleanup_net(struct work_struct *work)
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
 		ns_tree_remove(net);
 		list_del_rcu(&net->list);
+		net->is_dying = true;
 	}
 	/* Cache last net. After we unlock rtnl, no one new net
 	 * added to net_namespace_list can assign nsid pointer
@@ -688,8 +697,10 @@ static void cleanup_net(struct work_struct *work)
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


