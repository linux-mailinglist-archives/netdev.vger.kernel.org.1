Return-Path: <netdev+bounces-255698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7KNOCnUOgGmk2AIAu9opvQ
	(envelope-from <netdev+bounces-255698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:39:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DC9C7E63
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 03:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DC4373001002
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936E42101AE;
	Mon,  2 Feb 2026 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/4ynlUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76881F3B87
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769999986; cv=none; b=Q2ObwiI+oq8jnjkysuTBSgZ1Yh5FXR6xXJpv5mxFbdhLocIy/T+hl2yP/0Dx2hWWrph1R/PAeoMivE6vJADj8EF5T4v6ix5h3kaxswl0KCIM3Tq2JHrah6Tz0VVOE1ZqtXbNwuhptuG8m2TsUEa1ksg+9hKleCuT346TyZczhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769999986; c=relaxed/simple;
	bh=Z7zPk3LEOfLna/wInmtQon2g2llZ/GxvcxtzL0FuoJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qt5n0dgjZ/AS+MSFuM9mOTkaElmxKNMgW38dSuB4psjlbZQlHJ+3Z7i69qdtUHJtwOmUmqKSW8Jlgxvxqc2TXSSvh/RdN284Zl0evJ/3k09PGI0nKvs88U7BiZSF1hM4pDUxb6CzGSUWxNEwvz6iWNK3Z7wxi/eD8mE6j814PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/4ynlUh; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b71515d8adso3903351eec.1
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 18:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769999984; x=1770604784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6bhRTSu7n3BtGDmVoIOQl35YeNLuyGxN6y3r/5ixOk=;
        b=A/4ynlUhqgXaygKfUtI3HuV3rQLhrO9z8NXhuMdgQ3bMNmNtxGPzKVJncRkUe3YiGJ
         Km5jJ0PAvqlhCTS1PX3I5EOqBGz+vduU2zY5JqYeyDijBWmoOTVGnrEUh4Sm9Q3i1fiQ
         3U1NCM1BkK1qXanG3ZEKM9NxMVVD85u5ENVx8ld1a1FeFDJkWMs0sX8zFyN4eoFnXgKM
         8iuhJXs8QrUyFzp/zMUBqAhMTfmAWEeUtBLOHpF2DfQiFaRGGtL92RDxSivQLqpsHU0N
         E29mjryPcmDTSgoZ6YEWMwL81LKeJoHg2rBlTJ0muetWoJbfA1hvuYkrtMMoRhkYXKNL
         oAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769999984; x=1770604784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6bhRTSu7n3BtGDmVoIOQl35YeNLuyGxN6y3r/5ixOk=;
        b=PfV9oQKZyTxQ6hoZ6Ts50KHI/rFjVS8YztJe3v31OlXpIao8UCy0sY7qlCWKS5lHAL
         rImz72iPFtix7M9LvDXcgnMSW/8OOpkFqls84vfAV32o/VqD1bbqtQmj1PbYg/rr/JbQ
         lZfftK+81mUmMD+7L+YSc+lKx5Z0ofNQHyRqd375A3nJSH8VG7H5kyIZwb5ljtSaZ+1g
         f/vnxGtQUFVOrIQzmmtLYh94BpGDFFxCiBMJ7BzARXVgCjlKnfj4JHJtF2mqg6r2oruh
         CS57+ECnmFTHWIE3+jU5SHXdahn+BN933tiRVvthvTp6bGuRhduGTinBFNOn+//SmFN4
         RV7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWubFMnXNH3hHjVTCKJE/PfEQyl8lx+5LNS9+hTloXqj5OtTJzCblGq9tnJBfVONkfNsS2QDGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqBdjJb1SOeYQsmEMuefDDnBg6IywpLXANg528vX8XxA7pbwsZ
	uIcd472k+FyysjHI5pLLzjDKXpO47753pktDxGB0Kpn2gAb0iiW6iyTX
X-Gm-Gg: AZuq6aLhuZTZBJcTCfG3iUQvVtRsDPfL/d0BpdIH2WThmCvtiUr5esEoEjH3SD91SLU
	tQbHfzVXMehR/FX0N/T41lBS2V7ESsyPwy3nPLOO+XvoxbmKiD8JF+yHifVXx6GWVdrEBRwp4v4
	SDVQ8ZB4eBNiRhlfc59qIQ57uCkZeVNPN6BVW2/g90b32/l7+Uny46JiHnzp5CmzSj5tOqQMnOs
	B7ySmF44voHOeCB1lK8OmAKQ9Kbq29tDtriaPESBuUTzAI8dTucxfq25sXy6pAkkAMhryJ+AgkE
	x5/1vJmzAcFhuLIDsA+XawKuMhHw6kS1AbH8iWUUUlFxkAj/BbPX8oaMu9mCZjaCRavfdvtdnNJ
	kPL/uvhYGq/3EvoDhuGDfTgvxaJNviFna+d7fnyyTTMSgVU5+pELHt0pZsaCRwUftRcbQPRqKLq
	vfP7k=
X-Received: by 2002:a05:7301:6095:b0:2ae:5ddf:e223 with SMTP id 5a478bee46e88-2b7c865e73emr5379977eec.15.1769999983728;
        Sun, 01 Feb 2026 18:39:43 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16eab80sm18842353eec.9.2026.02.01.18.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 18:39:43 -0800 (PST)
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
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Sun,  1 Feb 2026 21:39:19 -0500
Message-ID: <20260202023931.2788955-1-realwujing@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-255698-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,suse.cz,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B4DC9C7E63
X-Rspamd-Action: no action

Currently, unhash_nsid() scans the entire system for each netns being
killed, leading to O(M_batch * N_system * log(N_ids)) complexity.

Optimize this to O(N_system * N_ids) by batching unhash operations. Move
unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
single-pass traversal over survivor namespaces.

Identify dying peers by an 'is_dying' flag, which is set under net_rwsem
write lock after the netns is removed from the global list. This batches
the unhashing work and eliminates the O(M_batch) multiplier.

Use a restartable idr_get_next() loop for iteration. This avoids the
unsafe modification issue inherent to idr_for_each() callbacks and allows
dropping the nsid_lock to safely call sleepy rtnl_net_notifyid().

Clean up redundant nsid_lock and simplify the destruction loop now that
unhashing is centralized.

Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
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
 net/core/net_namespace.c    | 34 ++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

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
index a6e6a964a287..3061c83786ac 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -624,9 +624,11 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
 }
 EXPORT_SYMBOL_GPL(net_ns_get_ownership);
 
-static void unhash_nsid(struct net *net, struct net *last)
+static void unhash_nsid(struct net *last)
 {
-	struct net *tmp;
+	struct net *tmp, *peer;
+	int id;
+
 	/* This function is only called from cleanup_net() work,
 	 * and this work is the only process, that may delete
 	 * a net from net_namespace_list. So, when the below
@@ -634,22 +636,23 @@ static void unhash_nsid(struct net *net, struct net *last)
 	 * use for_each_net_rcu() or net_rwsem.
 	 */
 	for_each_net(tmp) {
-		int id;
-
+		id = 0;
 		spin_lock(&tmp->nsid_lock);
-		id = __peernet2id(tmp, net);
-		if (id >= 0)
-			idr_remove(&tmp->netns_ids, id);
+		while ((peer = idr_get_next(&tmp->netns_ids, &id))) {
+			if (peer->is_dying) {
+				idr_remove(&tmp->netns_ids, id);
+				spin_unlock(&tmp->nsid_lock);
+				rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
+						  GFP_KERNEL);
+				spin_lock(&tmp->nsid_lock);
+			} else {
+				id++;
+			}
+		}
 		spin_unlock(&tmp->nsid_lock);
-		if (id >= 0)
-			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
-					  GFP_KERNEL);
 		if (tmp == last)
 			break;
 	}
-	spin_lock(&net->nsid_lock);
-	idr_destroy(&net->netns_ids);
-	spin_unlock(&net->nsid_lock);
 }
 
 static LLIST_HEAD(cleanup_list);
@@ -674,6 +677,7 @@ static void cleanup_net(struct work_struct *work)
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
 		ns_tree_remove(net);
 		list_del_rcu(&net->list);
+		net->is_dying = true;
 	}
 	/* Cache last net. After we unlock rtnl, no one new net
 	 * added to net_namespace_list can assign nsid pointer
@@ -688,8 +692,10 @@ static void cleanup_net(struct work_struct *work)
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


