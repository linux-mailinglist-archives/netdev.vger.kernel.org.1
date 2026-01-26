Return-Path: <netdev+bounces-253431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMy5NRVPd2n0dwEAu9opvQ
	(envelope-from <netdev+bounces-253431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:25:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD4879CB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99EF8300380E
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2672332904;
	Mon, 26 Jan 2026 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EInhiTEo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA1F332EA9
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769426704; cv=none; b=bieGIh9/nTRZ5zv/j5Ny56yC+fz+YJ9AM5sAZMYCfWwSeV0c5vCDnRsJU6KD2DYeHlBReTSLPcIjl4JasQEHSZTPzbrrxqRNxaOHOJLrnPXxuYiCEgYNFTw6bRDFL0HqALb+OVjskxqdYt4Ux0N50oahbKhFYkwszLTc8gs7KWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769426704; c=relaxed/simple;
	bh=Mtm2H1Y8oOuQVd+PRp+dFj93+nf4N8QNg9rTYqrqjaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQvcpe/bfvidRmzNxKYBBKCdkxKusKNcFTqWqYNXGTZKtymDumtMv0l8NRs2NGqVTymogeIgmn7W5B4HK7r5vV+qG+ftnROjah27UBmTVfU4gi2UuSS2afnOa/n7ccZrFxFsoMx7u0nCkIsDgsQAv4fPA6Y77sS0cIsmVi3n0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EInhiTEo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b0ea1edf11so8482542eec.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 03:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769426702; x=1770031502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZKhkSOogmCeEXH98s2F1bz0X39ue/E5DNO3lCuMsCk=;
        b=EInhiTEojInl1fuBKk+iUEbsZ/YLZkD4SkSO6McakzE6K+YGxv6fmSiZmuSKK8xutq
         trWs0DJZo5Rofy9WjsOA/hV0uRIrvAAz8mRVdB8PIhKmcJW9OSKxwXNjBCujb+s4A5wx
         Mjhw9pB0K2jLtBEdiPXl8vWtpWhd10rEx769+Ur3+BDSSV3n0s58imxmmyNKpyZqxKjT
         UBLXmDesnt+xllVsyHeXFdl5QzJqeEDE4pXlWgrKV7jAqtzSmls9xWDJxpkK40N7S8rj
         Fr5Ei0fQQlJCAWgx8Gy1mqTp3kp6uA1LJAKOLec4KX+6zGcWfv3Znwb7OBxqzWUIH1lh
         cVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769426702; x=1770031502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dZKhkSOogmCeEXH98s2F1bz0X39ue/E5DNO3lCuMsCk=;
        b=G2BuSleeypJ6aqZcgbKIFT7zfiUGPXa3xGXxQYmTrMX/8VdMfKMyr7ljDM7/LdvOzI
         qMQUlnsJePFs+8pZYMBRChQOfxtV02KkC9H7YA+Rb967OQ4N+xBLn/vIAIQVSiVSRUw6
         yuKXOis9X/iXxQRte9ko+jzvWxvVCAfNt1Ro5iHibzPirwp+7KPjptBbrqEWp05498Xn
         RH6wGCgnubsKVwLY0qzukBIGL1fhnrcbfLxx7WJ2ZLIwU5dsjEmkf32lYyGOeJ5sXERt
         7f7me4QWIRHNw2IY68LWiJuQvmR5O004mPsyYs2izow6zjq0uTrsIm3iXHn9f8UBRW4R
         akLg==
X-Forwarded-Encrypted: i=1; AJvYcCXBUZaHaZQe7F0/tx2zr1PlrBWV5OAB2XsD5V1F3mR8WLi4Ak0+54/UvanrMwV6H4XdWm+/468=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdzNWorLjIUg/ci9cPWyuT20OI2qnV0/dVn0G9C6FkbqYtfSX
	VzboSdh0P5RccknzV68Dhyr/KSoLO7YlkudwrYVfao0b/K2O6DScWpn2
X-Gm-Gg: AZuq6aK5w19Ve95auaQX4d+gTHswbFbmjje+tGxDkJomBj9TArJ1FevPLkV9L8le8RK
	I0OK4yNjlps5TkTluKIksSO2EeFTOzA9/zIxrKD2J3FjWI6CQePdEf8Y9X6+Y6pY4pwY+9HCVNz
	o0NxA1klghlqqow6UFkvWwtToVu+/x3lZgrH/X1qbYNHoW5HT5ZMLyy+jy5x7S+ZafX/GpZvKhJ
	hxXNLcAA6TTcgPHNWw/aSPmF2ooq6fiMzNywSzu2PHGdGVtNVskWTtZuukYTlYTklsm/30Y7bEN
	ADEb/OaiBTt+1ivyyLEbNyvBubG+8dZbsyGhpGX+sC0Tp5vXEAq+n5sSwtRtwZ15v17XGW2AlXh
	lPiW9wK+tH7tLdz+IE27fZyc47+XkeCd1PuEQ1MwZnqGT1pJdZl/SwPH5MdBqzZnvQhn6eiYfCd
	+a/GY=
X-Received: by 2002:a05:7301:5784:b0:2af:7f2:50cc with SMTP id 5a478bee46e88-2b764839530mr2249978eec.38.1769426702372;
        Mon, 26 Jan 2026 03:25:02 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa08964sm12804457eec.28.2026.01.26.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 03:25:01 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: edumazet@google.com
Cc: brauner@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	realwujing@gmail.com,
	yuanql9@chinatelecom.cn
Subject: [PATCH v2] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Mon, 26 Jan 2026 06:24:51 -0500
Message-ID: <20260126112451.1071143-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CANn89i+pyHq-jfqoaXpk_07LVCn+REmW1wPTbKmxV7ykZCEHfg@mail.gmail.com>
References: <CANn89i+pyHq-jfqoaXpk_07LVCn+REmW1wPTbKmxV7ykZCEHfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253431-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,redhat.com,gmail.com,chinatelecom.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0BDD4879CB
X-Rspamd-Action: no action

Currently, unhash_nsid() scans the entire net_namespace_list for each
netns in a destruction batch during cleanup_net(). This leads to
O(M_batch * N_system * M_nsids) complexity, where M_batch is the
destruction batch size, N_system is the total number of namespaces,
and M_nsids is the number of IDs in each IDR.

Reduce the complexity to O(N_system * M_nsids) by introducing an
'is_dying' flag to mark namespaces being destroyed. This allows
unhash_nsid() to perform a single-pass traversal over the system's
namespaces. In this pass, for each survivor namespace, iterate
through its netns_ids and remove any mappings that point to a marked
namespace, effectively eliminating the M_batch multiplier.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v2:
 - Remove unrelated ifindex and is_dying initialization in preinit_net.
 - Move is_dying = true to __put_net() to avoid an extra loop in cleanup_net.
v1:
 - Initial proposal using 'is_dying' flag to batch unhash_nsid calls.

 include/net/net_namespace.h |  1 +
 net/core/net_namespace.c    | 46 ++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

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
index a6e6a964a287..50fdd4f9bb3b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -624,9 +624,10 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
 }
 EXPORT_SYMBOL_GPL(net_ns_get_ownership);
 
-static void unhash_nsid(struct net *net, struct net *last)
+static void unhash_nsid(struct net *last)
 {
 	struct net *tmp;
+
 	/* This function is only called from cleanup_net() work,
 	 * and this work is the only process, that may delete
 	 * a net from net_namespace_list. So, when the below
@@ -636,20 +637,34 @@ static void unhash_nsid(struct net *net, struct net *last)
 	for_each_net(tmp) {
 		int id;
 
-		spin_lock(&tmp->nsid_lock);
-		id = __peernet2id(tmp, net);
-		if (id >= 0)
-			idr_remove(&tmp->netns_ids, id);
-		spin_unlock(&tmp->nsid_lock);
-		if (id >= 0)
-			rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0, NULL,
-					  GFP_KERNEL);
+		for (id = 0; ; id++) {
+			struct net *peer;
+			bool dying;
+
+			rcu_read_lock();
+			peer = idr_get_next(&tmp->netns_ids, &id);
+			dying = peer && peer->is_dying;
+			rcu_read_unlock();
+
+			if (!peer)
+				break;
+			if (!dying)
+				continue;
+
+			spin_lock(&tmp->nsid_lock);
+			if (idr_find(&tmp->netns_ids, id) == peer)
+				idr_remove(&tmp->netns_ids, id);
+			else
+				peer = NULL;
+			spin_unlock(&tmp->nsid_lock);
+
+			if (peer)
+				rtnl_net_notifyid(tmp, RTM_DELNSID, id, 0,
+						  NULL, GFP_KERNEL);
+		}
 		if (tmp == last)
 			break;
 	}
-	spin_lock(&net->nsid_lock);
-	idr_destroy(&net->netns_ids);
-	spin_unlock(&net->nsid_lock);
 }
 
 static LLIST_HEAD(cleanup_list);
@@ -688,8 +703,12 @@ static void cleanup_net(struct work_struct *work)
 	last = list_last_entry(&net_namespace_list, struct net, list);
 	up_write(&net_rwsem);
 
+	unhash_nsid(last);
+
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
-		unhash_nsid(net, last);
+		spin_lock(&net->nsid_lock);
+		idr_destroy(&net->netns_ids);
+		spin_unlock(&net->nsid_lock);
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
@@ -739,6 +758,7 @@ static DECLARE_WORK(net_cleanup_work, cleanup_net);
 void __put_net(struct net *net)
 {
 	ref_tracker_dir_exit(&net->refcnt_tracker);
+	net->is_dying = true;
 	/* Cleanup the network namespace in process context */
 	if (llist_add(&net->cleanup_list, &cleanup_list))
 		queue_work(netns_wq, &net_cleanup_work);
-- 
2.51.0


