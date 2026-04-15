Return-Path: <netdev+bounces-278672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOJMMLUs32nOPgAAu9opvQ
	(envelope-from <netdev+bounces-278672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:14:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A722400C68
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 541DE3029771
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 06:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF32437F742;
	Wed, 15 Apr 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYSTFRpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306862C3757
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233572; cv=none; b=Kjsg6I9yFk1kzVfcJRpb0jKkArvusHOV1O9e7ZMueSzpcL1Smno5QRXFHMqXXzKQV3wospQ75raHCoSN13ZZ4aXJWi0l0l+ag4anQjLzrLg2D0DQOKNQlUMsq3mUpESNLax0yleM00o/BHV4UQeRzZCpspWIU4vDYji6oQoetEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233572; c=relaxed/simple;
	bh=YBuKzw5MiBpMt8chIfY6CgsYp+HFY9LSLYxZHviAwOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=orcNS0cwohmHibPIFqApVTmF8dzqpZOurkX1B4wvdU6Y3kQOdiWtzLXkZlugY5t4AJ2vwoKsoiiWOOLhZr3xmm1Z/mwnUeb2CeB8uP+NIlVWvS1S+CLj++kj6mp/s5lB8jIMT7nuE2SMKrnNhNaxxHKZVZqBIa02ieHVuMUbj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qYSTFRpu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso98350985e9.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776233569; x=1776838369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSNgeZakK1IlX2VGc1M5dpQgdhHGi7URNL9nqA5mqxk=;
        b=qYSTFRpumHuJ2JxejMEtRFv6oOHkEjf8uQUgnObhNbcAY9KMUkFb9SNrkzSKDgwA58
         PctjuUijtjHOHGrOn28xdU2IO0Ljj7wb2rSBX/3vdXDZ83RLVbt36RB6o+LJo9vk1twf
         SAGt0LL19BU6l581/w64zfihfFfTKhKZ0cSYuTkFdznA2AA0IDGAT0jpr9123hMiNNLy
         einB+hp2Ar9aX8xrdVZZOJNCao0FS4oKgPau89KLWRpvW3PcHA/BprRcTDxgOkTKlYQo
         99CHyB7dEI5dpxnZqloFDSDGvG6qnoycc6Mm7DZB1x1gXvLRU047y4a9AlcDxzLLmNLE
         vsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233569; x=1776838369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSNgeZakK1IlX2VGc1M5dpQgdhHGi7URNL9nqA5mqxk=;
        b=pBETjzSSlrSj47rd6yoIYR3ErMkY0MwAIzEYIoCWBdCd3S6XIxC8L1swzhJ/g3Duig
         /3WVZlaQ7n/LiERreuhVyze6sveTrbteo84/KAhcYyzvWZx5U+clxpGBUr3lqciez197
         99RN0ijRLJI10MSuR7K/HL7eqtz4lNJAbRyjxSXotae3Xpt7gv3hKvjvfSykZJaHQRdz
         Hme00f/Z+u1lbXEOAJPfBRYYm3eXjHc0Px1g/VMMOro2oWSa/w6daOihgfrffXj5aW3A
         rGJsVd9bdfUTnJl24fqf7MaZXPjXkiePmoFx8BXtH8N1x5yudXdK9gz+i0iT+evJ+Kq0
         4M9Q==
X-Gm-Message-State: AOJu0YxthQTT6UI5aEy0RNWoJ8kaIETOyQIT8O8/FLec2cPvyvuKbqUC
	tSK8TVjkOTeF5TsoBU+G/3FtotyevU7xNHPlEEF7t0weGigbEV7+8nvvYQKMB/64
X-Gm-Gg: AeBDieto12YslmuDghEXizW3lPpvFZwta7876QqUO60RnPsp4bIjjh1f94YQED/Y727
	EJf22QRCLJnm6THFserYNM/F8Xw50faMbkVqb5EAc2+G3dMZnIF0E4XKdoGJ39K4PHIwjxt+POI
	Xe9iwCb3uMovDKYg07R4P/472V/4mmAF310s1KmCRyY1hCDBEVdmmBPLaReuvGpnb8Cbxk83P8+
	8ekxa/XV9JzPnOvAm+c/9PW5yxi4Hm2HqALYJfKaVlF0UaKQk/7b21g7CsW97JcYXq9AxtlxAlN
	VrSbvZ9j5Yi67CrgiLXdXaJk1o3YnjFajgVqd8QkyxPwRdeSoy/ec6tZ5d6CF+8tHze1yAG9Fo+
	WibTOsIRARIY2P+5KpPzHddiTX8159L9ScxJeN7CNXrZOMaBA1p4zEuv5Qaxtul2a9Wkt0xKxjt
	hfUazzqm9oWr/nCGIZjZIAhDy+9nWFiFtLn0nqiMjHDda+gF0N14DBznuBUxfZnRjX1JT4a9ySE
	sU5T5VQD90cDpJqwu6eB/CXSMahdOcHuniMtW3yEA/KObfyDhfDtpmE
X-Received: by 2002:a05:600c:608e:b0:488:8185:e672 with SMTP id 5b1f17b1804b1-488d688d2fbmr277894905e9.30.1776233569070;
        Tue, 14 Apr 2026 23:12:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:a041:e04f:2600:a4ae:7896:c26b:4cc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f1e95130sm23697125e9.13.2026.04.14.23.12.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 23:12:48 -0700 (PDT)
From: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
X-Google-Original-From: SnailSploit | Kai Aizen <95986478+SnailSploit@users.noreply.github.com>
To: netdev@vger.kernel.org
Cc: tipc-discussion@lists.sourceforge.net,
	jmaloy@redhat.com,
	ying.xue@windriver.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	Kai Aizen <kai.aizen.dev@gmail.com>
Subject: [PATCH] [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer vs bearer teardown
Date: Wed, 15 Apr 2026 09:12:11 +0300
Message-ID: <20260415061211.45530-1-95986478+SnailSploit@users.noreply.github.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278672-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,redhat.com,windriver.com,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.989];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[users.noreply.github.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6A722400C68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kai Aizen <kai.aizen.dev@gmail.com>

CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
workqueue without RTNL.  That patch closed the workqueue path by adding
rtnl_lock() around the call.

However, three additional functions in the same subsystem access
tipc_net->monitors[] from softirq context with no RCU protection at all:

  tipc_mon_peer_up()      - called from tipc_node_write_unlock()
  tipc_mon_peer_down()    - called from tipc_node_write_unlock()
  tipc_mon_remove_peer()  - called from tipc_node_link_down()

These three are invoked from the packet receive path (tipc_rcv ->
tipc_node_write_unlock / tipc_node_link_down) and hold only the per-node
rwlock, not RTNL.

Concurrently, bearer_disable() -- which always holds RTNL per its own
inline documentation -- calls tipc_mon_delete(), which:

  1. acquires mon->lock
  2. sets tn->monitors[bearer_id] = NULL
  3. frees all peer entries
  4. releases mon->lock
  5. calls kfree(mon)                     <-- no synchronize_rcu()

The race is structural: there is no shared lock between the data-path
reader (which reads monitors[id] then acquires mon->lock) and the
teardown path (which acquires mon->lock, NULLs the slot, then frees).
A softirq thread can read a non-NULL mon pointer, get preempted, and
resume after kfree(mon) has run on another CPU, then call
write_lock_bh(&mon->lock) on freed memory:

  CPU 0 (softirq / tipc_rcv)            CPU 1 (RTNL / bearer_disable)
  tipc_mon_peer_up()
    mon = tipc_monitor(net, id)
    [mon is non-NULL]
                                         tipc_mon_delete()
                                           write_lock_bh(&mon->lock)
                                           tn->monitors[id] = NULL
                                           ...
                                           write_unlock_bh(&mon->lock)
                                           kfree(mon)
    write_lock_bh(&mon->lock)   <-- UAF

The fix mirrors the existing bearer_list[] pattern in the same module:
convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
RCU_INIT_POINTER() + synchronize_rcu() on deletion (before the kfree),
and the appropriate rcu_dereference_bh() vs rtnl_dereference() variant
at each read site depending on execution context.

synchronize_rcu() in tipc_mon_delete() is placed after the
write_unlock_bh() and before timer_shutdown_sync() + kfree() to ensure
all softirq-context readers that already observed the old pointer have
completed before the memory is freed.

Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
Cc: stable@vger.kernel.org
Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
---
 net/tipc/core.h    |  2 +-
 net/tipc/monitor.c | 45 +++++++++++++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/tipc/core.h b/net/tipc/core.h
index 9ce5f9ff6..cd582f7a2 100644
--- a/net/tipc/core.h
+++ b/net/tipc/core.h
@@ -109,7 +109,7 @@ struct tipc_net {
 	u32 num_links;
 
 	/* Neighbor monitoring list */
-	struct tipc_monitor *monitors[MAX_BEARERS];
+	struct tipc_monitor __rcu *monitors[MAX_BEARERS];
 	int mon_threshold;
 
 	/* Bearer list */
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index a94b9b36a..2a0665e1d 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -97,9 +97,21 @@ struct tipc_monitor {
 	unsigned long timer_intv;
 };
 
-static struct tipc_monitor *tipc_monitor(struct net *net, int bearer_id)
+/*
+ * tipc_monitor_rcu_bh - dereference monitors[] from softirq / data path.
+ * Caller must be in an RCU-bh read-side critical section (softirq context
+ * implicitly satisfies this on non-PREEMPT_RT kernels; use explicit
+ * rcu_read_lock_bh() where needed on RT).
+ */
+static struct tipc_monitor *tipc_monitor_rcu_bh(struct net *net, int bearer_id)
+{
+	return rcu_dereference_bh(tipc_net(net)->monitors[bearer_id]);
+}
+
+/* tipc_monitor_rtnl - dereference monitors[] from RTNL-held control path. */
+static struct tipc_monitor *tipc_monitor_rtnl(struct net *net, int bearer_id)
 {
-	return tipc_net(net)->monitors[bearer_id];
+	return rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 }
 
 const int tipc_max_domain_size = sizeof(struct tipc_mon_domain);
@@ -194,7 +206,7 @@ static struct tipc_peer *get_peer(struct tipc_monitor *mon, u32 addr)
 
 static struct tipc_peer *get_self(struct net *net, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 
 	return mon->self;
 }
@@ -351,7 +363,7 @@ static void mon_assign_roles(struct tipc_monitor *mon, struct tipc_peer *head)
 
 void tipc_mon_remove_peer(struct net *net, u32 addr, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_peer *self;
 	struct tipc_peer *peer, *prev, *head;
 
@@ -421,7 +433,7 @@ static bool tipc_mon_add_peer(struct tipc_monitor *mon, u32 addr,
 
 void tipc_mon_peer_up(struct net *net, u32 addr, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_peer *self = get_self(net, bearer_id);
 	struct tipc_peer *peer, *head;
 
@@ -440,7 +452,7 @@ void tipc_mon_peer_up(struct net *net, u32 addr, int bearer_id)
 
 void tipc_mon_peer_down(struct net *net, u32 addr, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_peer *self;
 	struct tipc_peer *peer, *head;
 	struct tipc_mon_domain *dom;
@@ -480,7 +492,7 @@ void tipc_mon_peer_down(struct net *net, u32 addr, int bearer_id)
 void tipc_mon_rcv(struct net *net, void *data, u16 dlen, u32 addr,
 		  struct tipc_mon_state *state, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_mon_domain *arrv_dom = data;
 	struct tipc_mon_domain dom_bef;
 	struct tipc_mon_domain *dom;
@@ -566,7 +578,7 @@ void tipc_mon_rcv(struct net *net, void *data, u16 dlen, u32 addr,
 void tipc_mon_prep(struct net *net, void *data, int *dlen,
 		   struct tipc_mon_state *state, int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_mon_domain *dom = data;
 	u16 gen = mon->dom_gen;
 	u16 len;
@@ -600,7 +612,7 @@ void tipc_mon_get_state(struct net *net, u32 addr,
 			struct tipc_mon_state *state,
 			int bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = tipc_monitor_rcu_bh(net, bearer_id);
 	struct tipc_peer *peer;
 
 	if (!tipc_mon_is_active(net, mon)) {
@@ -651,7 +663,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
 	struct tipc_peer *self;
 	struct tipc_mon_domain *dom;
 
-	if (tn->monitors[bearer_id])
+	if (rtnl_dereference(tn->monitors[bearer_id]))
 		return 0;
 
 	mon = kzalloc_obj(*mon, GFP_ATOMIC);
@@ -663,7 +675,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
 		kfree(dom);
 		return -ENOMEM;
 	}
-	tn->monitors[bearer_id] = mon;
+	rcu_assign_pointer(tn->monitors[bearer_id], mon);
 	rwlock_init(&mon->lock);
 	mon->net = net;
 	mon->peer_cnt = 1;
@@ -682,7 +694,7 @@ int tipc_mon_create(struct net *net, int bearer_id)
 void tipc_mon_delete(struct net *net, int bearer_id)
 {
 	struct tipc_net *tn = tipc_net(net);
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = rtnl_dereference(tn->monitors[bearer_id]);
 	struct tipc_peer *self;
 	struct tipc_peer *peer, *tmp;
 
@@ -691,7 +703,7 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 
 	self = get_self(net, bearer_id);
 	write_lock_bh(&mon->lock);
-	tn->monitors[bearer_id] = NULL;
+	RCU_INIT_POINTER(tn->monitors[bearer_id], NULL);
 	list_for_each_entry_safe(peer, tmp, &self->list, list) {
 		list_del(&peer->list);
 		hlist_del(&peer->hash);
@@ -700,6 +712,7 @@ void tipc_mon_delete(struct net *net, int bearer_id)
 	}
 	mon->self = NULL;
 	write_unlock_bh(&mon->lock);
+	synchronize_rcu();
 	timer_shutdown_sync(&mon->timer);
 	kfree(self->domain);
 	kfree(self);
@@ -712,7 +725,7 @@ void tipc_mon_reinit_self(struct net *net)
 	int bearer_id;
 
 	for (bearer_id = 0; bearer_id < MAX_BEARERS; bearer_id++) {
-		mon = tipc_monitor(net, bearer_id);
+		mon = rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 		if (!mon)
 			continue;
 		write_lock_bh(&mon->lock);
@@ -798,7 +811,7 @@ static int __tipc_nl_add_monitor_peer(struct tipc_peer *peer,
 int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *msg,
 			     u32 bearer_id, u32 *prev_node)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 	struct tipc_peer *peer;
 
 	if (!mon)
@@ -827,7 +840,7 @@ int tipc_nl_add_monitor_peer(struct net *net, struct tipc_nl_msg *msg,
 int __tipc_nl_add_monitor(struct net *net, struct tipc_nl_msg *msg,
 			  u32 bearer_id)
 {
-	struct tipc_monitor *mon = tipc_monitor(net, bearer_id);
+	struct tipc_monitor *mon = rtnl_dereference(tipc_net(net)->monitors[bearer_id]);
 	char bearer_name[TIPC_MAX_BEARER_NAME];
 	struct nlattr *attrs;
 	void *hdr;
-- 
2.43.0


