Return-Path: <netdev+bounces-254049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E5IAedkeWl1wwEAu9opvQ
	(envelope-from <netdev+bounces-254049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:22:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A499BE1F
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E48300F9E3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFCE1C860C;
	Wed, 28 Jan 2026 01:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L96/DjME"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FC119309C
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769563363; cv=none; b=hHEuj6GEshvBbZogdpRJigKtkRsa0tWDdtANQAixCfbwoDCxvAnnTz9n2R1C6s7vsqkY1WIv79aNjfBw0iDTUXQzXdrMmrYt2U7dimaULzzvRiDI/ydPon5Dlo+tA0WvfSGPlWf7bS5WUB/Jh5f/BVOYkWLfaO94WdFqcl/2/Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769563363; c=relaxed/simple;
	bh=wdSxOj+/8brg2xyTPyKuK4zewxw/8x/s52TKc+XkVw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B0H9jsO7H4xovWlpuT7Hb/AICgtO4FxL2svhDcLv0GNnGqjlHERKXk0GFmrNmX+4vBcUb6PbfFDUCGBKW9R2nPcJWrEV0VaoyifO9rErLTusUDzW/XB9dy2t1Rg8c+3ye+w7HI4OfAPpkY3zsk1fD2kXUKRz49uKJAtFN/mqBkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L96/DjME; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12331482b8fso1293734c88.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 17:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769563361; x=1770168161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WdlJkODskdsR/d8eXcoiwCooiZWIMrUfvjPFzHYdnGE=;
        b=L96/DjMEm9QbxBY1xN7aB76nfrUgJMOHXvH4xt5dZ3wnaLf44oWHPIAg7TxYpZD5b/
         HUBQTainkroJ6I4sJEyvzsxvtvp+DKO7G+NPwnbsE4Jwcde4sD+DMuB8p+XdqAFfuZoP
         3YyrGzjemrT+tzV9jFmHVCA9QPgyz2dwDuXozIs3NY/CuGeHXnODxlnSl8NVAWiWW/VQ
         tvZh+7NFUceNs6yQjN+fOdlcw3dQ01VWu1oz9gWfGp7mQZhnTXDHjOiSucsriR4ZF8fD
         0xUlsNemLuirwpQ0PIwWnuIlO0XGORW7WyLB4V+xZotx0L12ef2IOiYxqoHufHOWUeL1
         YsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769563361; x=1770168161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdlJkODskdsR/d8eXcoiwCooiZWIMrUfvjPFzHYdnGE=;
        b=H3kVNUWS4hkQYjlACqcO/dhJCbGiipj6CxrzUu6y2pEbe0jdpJGxUEOBT8vo6ZETTI
         XPMVxobgvl7h1UrAAhsGTxK9F8EAdUK2FAb/E6aWZsszJsYA69WszgifomEdVSUYQTmw
         82n5yj03tH53jwinFVzuWGVrb6ewgD5D8SZyVDpntpaGUEFlG4Yb3yTgmJGJupa7D+EL
         aZif6LaGlod78bsHz6sTS97gZ2W+oIMgziMlI+J3OA44q8RTqIFr4JeZtsKBwn4FNyrG
         GWju0gbMSjsEop+R2NswwPGcxO/RkMumjlt7eV+iPN0bpvlVl26dcGt6wJN71xokT66d
         2p3g==
X-Forwarded-Encrypted: i=1; AJvYcCX3xiC8Lh19BycmIpDWMmxCBobqZNt1s24/bfWFXiYjHkiCElqIf5czeHLV2zOiQK9pgp8wc7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWnFUunNgca6J7PP+sA3U4eLBL0Ivi2VAitBtuYeZ7WTlJN/F
	JrNlUs6V1gCBj2pPmWhzIzHWM7EhtOLrSGVb4SeGVGkA5iavzldElcnq
X-Gm-Gg: AZuq6aIof9fbqJXrfN6/8x+ea50d9UTKo10XdaxLg2mwd+2BFZLOG/O9pZkHuXKD7aD
	llidGTaBLvBP0gwJEXpOi5o8neF/Qc6X+PVqK/IZLJft+R3mVOpdhF/9/mVVh6/xowxFZZXmgyx
	1kQ/DOXolxaFYDzg/Y/YqgfJ0TTSuEtSMo9AEraloJwrU0aGP41xEEgdQKOQE0r3bPF0OOrfCxl
	K7rNUSCjKn2f4PMO4eTV3hPWPJ5JQj5z4MEvFMMpqMOSHmpId4IafM01jGhKbxZtmL6YzcH2D9b
	2cf6NRz2bh+MZXIM5Uw9z/4ecDAaDXsgjtzGIw8L2kz0Dzkh9Vd6grCR8lPgSIN066rN2tJ73st
	67oHd1Czs2TxEMCDc69vLv5FAYog9rKFizaHzeb585D4HtfooKMbn1SllyDnaZUS/2AQ2XJ/kj/
	QdQWnwqiYoxHqvkA==
X-Received: by 2002:a05:7022:912:b0:11b:f056:a1b3 with SMTP id a92af1059eb24-124a00684dfmr2656657c88.11.1769563361149;
        Tue, 27 Jan 2026 17:22:41 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9de948esm581244c88.9.2026.01.27.17.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 17:22:40 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>
Cc: Qiliang Yuan <yuanql9@chinatelecom.cn>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] netns: optimize netns cleaning by batching unhash_nsid calls
Date: Tue, 27 Jan 2026 20:21:31 -0500
Message-ID: <20260128012145.1682016-1-realwujing@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-254049-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,queasysnail.net,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50A499BE1F
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
v3:
 - Update target tree to net-next.
 - Post as a new thread instead of a reply.
v2:
 - Move 'is_dying' setting to __put_net() to eliminate the O(M_batch) loop.
 - Remove redundant initializations in preinit_net().
v1:
 - Initial implementation of batch unhash_nsid().

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


