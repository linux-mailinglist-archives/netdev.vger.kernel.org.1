Return-Path: <netdev+bounces-253401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIhQDzk4d2nhdAEAu9opvQ
	(envelope-from <netdev+bounces-253401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:47:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED7862DF
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D1F300AEFB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2526C32D0CE;
	Mon, 26 Jan 2026 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnz/Yy/D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9810E3
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420854; cv=none; b=JQaQus20qHgSn8QtVQE0BYV2AVh/lclrFTdNzhufiYIaMu79+TTj+TLG8s0t6kot9yeqRKiZhGShvvnUXDnjB0BqkDTyCNAMYJaWRP3SrkSBDgywaM6xrdxzTSD+ucAIgLkRVYStqvi4mVRjdNMJ34gUYqGDGtsZCZa3HPbRFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420854; c=relaxed/simple;
	bh=NCfiALUxUfvAlwDgUNB51OMAugK2pgymVaa514mSZyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fpZgM6HowyyAWKukfxZXsrpVabHgFaGSSuT3Menqt4k3dwSeZnMOLLRn154xWPpAOgRpERhubbESjMY0xJexyOsN8uCHuwWU2mg+B6a6NoqNPf2N6TR/esnt4GMcAyaTpoUpUmujMTCbIHZ50bDy5J/yw3Qg2GZbQ0efU4Ra9SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnz/Yy/D; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12339e2e2c1so2693223c88.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 01:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420852; x=1770025652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdtQRDCU8hM43eKPfMFM0Zqsb+dtZgi7zi3Ez1tCjVE=;
        b=Vnz/Yy/DISD8CaoidAYofclNrB5OpkrdKL+b2wZPD8ACsP17oiPUt5DGb+blY/yhbA
         G/QjCu5emtN6Ex63jFRF5FSw+L/ie4v0IqAKDF/U2ActfzuzK/RRf4K2nFm52G5cncpA
         sKkEAz2Fsj7yyQM8xkD1A4fR4WiMucGnxEpE8e0G/IX+w78yLrX3NeNdCNpBGwJfpCR9
         eze+Po6mhf0hy568ycUGuXszgqJTq9cqD3HQmK7ZfwpApT/rHP7WTfOAD+wNSLwUjAK7
         ypg08SCpT1uzdO0uE0mkcW0w6WDFn9WlATTzp1c7HYjZdMTgSxiQSskMGN9ng1nzfibB
         QazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420852; x=1770025652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdtQRDCU8hM43eKPfMFM0Zqsb+dtZgi7zi3Ez1tCjVE=;
        b=b99nsFSpM2UsvakcH1PvypKr5CzRKbrxmAf3LizE71HEDQhInoc520joMWcs6VUGe/
         mxBnebCyrXaPWFh+pUhaTzcljmuqVgio7aMwUO2m26OkLvaEakSUv010bmxwTTH7tVPN
         j6A+YeCiq1V9cRROiTChZXeR0rvkieWIgENdZ2IJwjVfSX28ELva5xjS/Gkjy0/3EB1Y
         AnwJ4CyvkS9TKoN2y2UFZ3XbZ8e2B1TLMCIJExlorhaufLlx1LL19bxgbmVEt9hS/WL8
         yMoZkOVqCaa6WnP63+MYeUAVfKZ5dJTDWI7d/yC3vhfo2hDTmdLqb0725oY1KGR+i9LH
         44zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXID/6849YZeau6EDxU2B1uy+weP/ne7Eeq2SGF6p2JnkIU99nXxTzHINOXfFx9q9kt44AUXRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4lEeaP8DWCQpjDZ7eCtEYPprIAe29/5Bwe6xrTuPZEVsMxp26
	a/wC3GZ0k6l6O/EKUPGt1D1vAOSPQWiklFiyVc+gMRzosy5pwIvxLVRmzIxzoQ==
X-Gm-Gg: AZuq6aJ3ZwnyXg9aEsUpt1ucRopIOymWFWU8beNL3FXK+H7HzGNfPSlwljTeSLkViMu
	VO2GcH6jEI30bX4VGZoEqenFgzvDLqW32yGMZ3KtMSXIJ/qpdaUuPOx8uz00DgC29AXotanZ8UI
	C4vZENuLsYkAJlTc+NT9tS7JxEa4ES2R2ZnyVp4mDyQykTwH686rBNEGa5hPSFyJ6dJEHDvGqPX
	8qRItLoHOX5aJ5xe2LWIp3zbJw5itAxHo85Q5edJig51vyAIsYY0H3s60mJbzi6j5rUXjDyo0cc
	wWdzw7IFhtObmI+HmX2AnDPywflicNCd95DU0Xypzdx4c9NKbFFYlrgQijy2CUXHuYLZR7JB6qW
	QGQsmycsiLcklN07wz3x7eLXIWdsbYMz8ZJtxu+0m+U9hhVf9wVJQzRya5rvU85rNcpGGZOeu7I
	ehjRM=
X-Received: by 2002:a05:7022:2389:b0:11e:3e9:3e91 with SMTP id a92af1059eb24-1248ee063efmr1791962c88.26.1769420851763;
        Mon, 26 Jan 2026 01:47:31 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91b9e1sm18428029c88.5.2026.01.26.01.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:47:31 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: brauner@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiliang Yuan <realwujing@gmail.com>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: [PATCH] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Mon, 26 Jan 2026 04:47:18 -0500
Message-ID: <20260126094718.1031407-1-realwujing@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,chinatelecom.cn];
	TAGGED_FROM(0.00)[bounces-253401-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97ED7862DF
X-Rspamd-Action: no action

Currently, unhash_nsid() scans the entire net_namespace_list for each
netns in a destruction batch during cleanup_net(). This leads to
an O(M * N) complexity, where M is the batch size and N is the total
number of namespaces in the system.

Reduce the complexity to O(N) by introducing an 'is_dying' flag to mark
the entire batch of namespaces being destroyed. This allows unhash_nsid()
to perform a single-pass traversal over the system's namespaces. In
this pass, for each survivor namespace, iterate through its netns_ids
and remove any mappings that point to a marked namespace.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 include/net/net_namespace.h |  1 +
 net/core/net_namespace.c    | 50 +++++++++++++++++++++++++++----------
 2 files changed, 38 insertions(+), 13 deletions(-)

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
index a6e6a964a287..d24e46c034f2 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -413,6 +413,8 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;
+	net->ifindex = 0;
+	net->is_dying = false;
 	net->user_ns = user_ns;
 
 	idr_init(&net->netns_ids);
@@ -624,9 +626,10 @@ void net_ns_get_ownership(const struct net *net, kuid_t *uid, kgid_t *gid)
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
@@ -636,20 +639,34 @@ static void unhash_nsid(struct net *net, struct net *last)
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
@@ -688,8 +705,15 @@ static void cleanup_net(struct work_struct *work)
 	last = list_last_entry(&net_namespace_list, struct net, list);
 	up_write(&net_rwsem);
 
+	llist_for_each_entry(net, net_kill_list, cleanup_list)
+		net->is_dying = true;
+
+	unhash_nsid(last);
+
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
-		unhash_nsid(net, last);
+		spin_lock(&net->nsid_lock);
+		idr_destroy(&net->netns_ids);
+		spin_unlock(&net->nsid_lock);
 		list_add_tail(&net->exit_list, &net_exit_list);
 	}
 
-- 
2.51.0


