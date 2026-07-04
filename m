Return-Path: <netdev+bounces-304728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ZDnHY1iSWoc1AAAu9opvQ
	(envelope-from <netdev+bounces-304728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E11F570848C
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:44:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=R2iHtmiC;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304728-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304728-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E60301E746
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F10131AA9B;
	Sat,  4 Jul 2026 19:43:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804FB3242B2
	for <netdev@vger.kernel.org>; Sat,  4 Jul 2026 19:43:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783194235; cv=none; b=ulbDql4cIQG5zOWFDW24/nlsG5i/QhRGm/C/JWgdkif3daPjJj5Ig5m8gb6LpG/9A/IYlJZiCtMqAicWHF8uWf60YrBNICnWUZFft3I9fFFrJiCfQUt5ycfbpH25VubKrm1QmwCjjBzZbWC+REpol9y5qjdtwGZi6RqpnMIEA9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783194235; c=relaxed/simple;
	bh=PhbAHeLF9WWjvlrTJwBVC2zp0lkSlQj7I6RfJxoy99E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ow5/tChZZD+anTfjkqZMxAy5fBy7N7QHdSNtdqLBPesigLS4Ej7vIzpW59CoHl103pxLVv93FYITxFkT0LeFlYKfgC1WL8uNAHyTTxSP2ChFSMYwukHrVoOlAyK8Hf3K/DZfXF1V+QddKyuRh1c8sPsk1UoUizSPEgFLMSgGvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2iHtmiC; arc=none smtp.client-ip=209.85.160.201
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-517e054fe07so31927401cf.1
        for <netdev@vger.kernel.org>; Sat, 04 Jul 2026 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783194232; x=1783799032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nevsi9HlhNgyPsyGPnoBdnU4xXQeLqEGFUgWrsmPTM=;
        b=R2iHtmiCDthUiS5YX3KIp8g1pbxakaap2a8mi31MFWiFKlHXxMDHJNRl3jIU2fjYDa
         iL3NWrJ+CcAvuSVlcfkcklOSiWpWiWzjVtkFITDnS7dHM/fZZPQkII/L/0dEkrEVXhLN
         WfKmi2s+02mWg78LJw1gZfsCDVIE61sbabPJytQXcQl685lS3thpuD+gJdeKu569r955
         QBjGMGtRBO2Z8oB8dljXKZZvQMsxzhVVjP9kSJli4tjLeMBHl0wlGgYx2BpitgWyT5q8
         /H3wnDXYsRE3dlH93++Gb/4xNrH6zWyy8pR40LDltB68pbOJJqfAMISaeydr6sMjGN5W
         N0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783194232; x=1783799032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Nevsi9HlhNgyPsyGPnoBdnU4xXQeLqEGFUgWrsmPTM=;
        b=GqZp/epRCNRdXlG00eYBULVw+fg0U2zT5UoDOQrDuDlfjhcWXq4G1ckofHX+4fXE+v
         F4E/0JopA9Fzxha1b/focnSBafhM4RSB3Dn9bk932PAxlzzq874+whb3CK4VKpgX+qtw
         LSmjVTO6bDHvojgRu4Y4mXRWuS9Ue0stcUOqcu7d0JB6ih1W6a302yDqOF+iEhhaQcY9
         Kjb67xpLgbdN6OypYWPpZeY9wIbsf2yrITHIjaLURIUShYmODC398LJw2FzYxRFw9PON
         6FR0lUhfPQmRTaIxbQXh17TNsf3xRwEdminR67RIMIMDbM9BPY4T+E7DMh/FJ2G5D3N0
         2pRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/pKSFt+QxgDqT0pEwDTsS9SlnGgujNrkB2WJcQGeUGvKdugJucb6GMlnpJfSq7sa5AFJRKVWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LQfA9w8JQ3caO7jc1FUOuasU4Pk0ikBqEAlovkM/FUNWf/Km
	195qg7RORnzWsM75btktEUfAxkhZsYZmtgJEPvPMh1xW4lxLsDoQh9d5sWiaUwbLkbxNS0BqRF6
	l8AI4fpSYnZaG8w==
X-Received: from qtkf18.prod.google.com ([2002:ac8:7f12:0:b0:51c:779:41db])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5810:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c4c38bea9mr62925231cf.35.1783194232248;
 Sat, 04 Jul 2026 12:43:52 -0700 (PDT)
Date: Sat,  4 Jul 2026 19:43:45 +0000
In-Reply-To: <20260704194346.4065071-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260704194346.4065071-1-edumazet@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260704194346.4065071-3-edumazet@google.com>
Subject: [PATCH net 2/3] ipv6: mcast: Fix potential UAF in MLD delayed work
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304728-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:edumazet@google.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,nvidia.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E11F570848C

A race condition exists between device teardown and incoming MLD query
processing, leading to a Use-After-Free in the MLD delayed work.

During device destruction, the primary reference to inet6_dev is dropped,
which can drop its refcount to 0. The actual freeing of inet6_dev memory
is deferred via RCU.

Concurrently, the packet receive path runs under RCU read lock and obtains
the inet6_dev pointer. Because the memory is RCU-protected, CPU-0 can
safely dereference inet6_dev even if its refcount has hit 0.

However, if CPU-0 calls igmp6_event_query() and schedules delayed work, it
attempts to acquire a reference using in6_dev_hold(). This increments the
refcount from 0 to 1, triggering a "refcount_t: addition on 0" warning.
Since the inet6_dev memory is still scheduled to be freed after the RCU
grace period, the device is freed while the work is still scheduled.
When the work runs, it accesses the freed memory, causing a kernel panic.

Fix this by using refcount_inc_not_zero() (via a new helper
in6_dev_hold_safe()) to prevent acquiring a reference if the device is
already being destroyed. If the refcount is 0, we do not schedule the work.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/addrconf.h |  5 +++++
 net/ipv6/mcast.c       | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index 539bbbe54b14e8108ff7304d7a08bc605655cc31..8ced27a8229b6e0580f934be2223676cc123307b 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -446,6 +446,11 @@ static inline void in6_dev_hold(struct inet6_dev *idev)
 	refcount_inc(&idev->refcnt);
 }
 
+static inline bool in6_dev_hold_safe(struct inet6_dev *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 /* called with rcu_read_lock held */
 static inline bool ip6_ignore_linkdown(const struct net_device *dev)
 {
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 04b811b3be978e36b0fd4ecd8312313d73ed2ed9..7c3f739cf7638452f311c64331c89253361b34f9 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -1083,8 +1083,10 @@ static void mld_gq_start_work(struct inet6_dev *idev)
 	mc_assert_locked(idev);
 
 	idev->mc_gq_running = 1;
-	if (!mod_delayed_work(mld_wq, &idev->mc_gq_work, tv + 2))
-		in6_dev_hold(idev);
+	if (in6_dev_hold_safe(idev)) {
+		if (mod_delayed_work(mld_wq, &idev->mc_gq_work, tv + 2))
+			in6_dev_put(idev);
+	}
 }
 
 static void mld_gq_stop_work(struct inet6_dev *idev)
@@ -1102,8 +1104,10 @@ static void mld_ifc_start_work(struct inet6_dev *idev, unsigned long delay)
 
 	mc_assert_locked(idev);
 
-	if (!mod_delayed_work(mld_wq, &idev->mc_ifc_work, tv + 2))
-		in6_dev_hold(idev);
+	if (in6_dev_hold_safe(idev)) {
+		if (mod_delayed_work(mld_wq, &idev->mc_ifc_work, tv + 2))
+			in6_dev_put(idev);
+	}
 }
 
 static void mld_ifc_stop_work(struct inet6_dev *idev)
@@ -1121,8 +1125,10 @@ static void mld_dad_start_work(struct inet6_dev *idev, unsigned long delay)
 
 	mc_assert_locked(idev);
 
-	if (!mod_delayed_work(mld_wq, &idev->mc_dad_work, tv + 2))
-		in6_dev_hold(idev);
+	if (in6_dev_hold_safe(idev)) {
+		if (mod_delayed_work(mld_wq, &idev->mc_dad_work, tv + 2))
+			in6_dev_put(idev);
+	}
 }
 
 static void mld_dad_stop_work(struct inet6_dev *idev)
@@ -1395,6 +1401,7 @@ static void mld_process_v2(struct inet6_dev *idev, struct mld2_query *mld,
 void igmp6_event_query(struct sk_buff *skb)
 {
 	struct inet6_dev *idev = __in6_dev_get(skb->dev);
+	bool put = false;
 
 	if (!idev || idev->dead)
 		goto out;
@@ -1402,11 +1409,16 @@ void igmp6_event_query(struct sk_buff *skb)
 	spin_lock_bh(&idev->mc_query_lock);
 	if (skb_queue_len(&idev->mc_query_queue) < MLD_MAX_SKBS) {
 		__skb_queue_tail(&idev->mc_query_queue, skb);
-		if (!mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
-			in6_dev_hold(idev);
+		if (in6_dev_hold_safe(idev)) {
+			if (mod_delayed_work(mld_wq, &idev->mc_query_work, 0))
+				put = true;
+		}
 		skb = NULL;
 	}
 	spin_unlock_bh(&idev->mc_query_lock);
+
+	if (put)
+		in6_dev_put(idev);
 out:
 	kfree_skb(skb);
 }
@@ -1570,6 +1582,7 @@ static void mld_query_work(struct work_struct *work)
 void igmp6_event_report(struct sk_buff *skb)
 {
 	struct inet6_dev *idev = __in6_dev_get(skb->dev);
+	bool put = false;
 
 	if (!idev || idev->dead)
 		goto out;
@@ -1577,11 +1590,16 @@ void igmp6_event_report(struct sk_buff *skb)
 	spin_lock_bh(&idev->mc_report_lock);
 	if (skb_queue_len(&idev->mc_report_queue) < MLD_MAX_SKBS) {
 		__skb_queue_tail(&idev->mc_report_queue, skb);
-		if (!mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
-			in6_dev_hold(idev);
+		if (in6_dev_hold_safe(idev)) {
+			if (mod_delayed_work(mld_wq, &idev->mc_report_work, 0))
+				put = true;
+		}
 		skb = NULL;
 	}
 	spin_unlock_bh(&idev->mc_report_lock);
+
+	if (put)
+		in6_dev_put(idev);
 out:
 	kfree_skb(skb);
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog


