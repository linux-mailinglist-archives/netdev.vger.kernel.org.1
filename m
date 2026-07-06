Return-Path: <netdev+bounces-305071-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id goIUK/y5S2oTZQEAu9opvQ
	(envelope-from <netdev+bounces-305071-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:21:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E02D711E39
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:21:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AxuWaLbB;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305071-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305071-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94395303E821
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED72EEE80;
	Mon,  6 Jul 2026 13:47:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B30F2E737D
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:47:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345665; cv=none; b=Bxf+zYGYwxHjXPHkxqUNUe+dgzmajYXX5USA47ICULdAdyKDejTcg68ZB6p7LHmQ7+MXhXV5CJRu5xewVFgbIhxp/hiikBSuooFqj0hynB1TrHLURmb5VbbEuaIJ935Qfzn4RRGTCHBxuh4oFI0xOXgX3hUYv/8z1/OcsD4Q70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345665; c=relaxed/simple;
	bh=pTTtgmt5jEfVB2U2+JdW7WxtEbzpmwosAPFK0tZp2uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWSxA6B0qnVCWh2AB0GMsBnkHOfpPQbslhXcpEWLeSmDrzhWgOo0hqzeJH9YGX6XSrB+BDT2E7Z/LOtIHsPEYnUskYtteduCSSfmdVZ7Y2kAR2uapV3rYOWw0YaM5UqEoWmCdHhb2RkMi6AjiUiBhCz8viFooH6jhTuAYnevZSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxuWaLbB; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so1742343a12.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345664; x=1783950464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yWs74MIuaQ3UGyklOH9NT4Sl0r8NQtJ6GpHW3lV4GUk=;
        b=AxuWaLbBFHP5Z0Bk5PzRgU3Sd09A5c7H5ibny2bG4UGbtjVscZSFOOqgNnAGtSL/Kc
         yCnID7wjJZF9M04ineNr70tGPI8u8HV64qXZBYlOJoVTgOoAAdRlBRBsxjqV0NYfR5dI
         ImhgV4nRCVnAF8AGuqwAaXgPdZqGdV5FeI3mlXcRp9dIF8CSP1Av839fFnseRvv9NlOY
         b8IKszOhW7fxGVBRkBGFFeg3gDgQBSTvmZ7T4MrLCcrlXfFpTbQCMEH8VbduqaBBr0jh
         jHWLHIg1fBhmSjx/ZsVMOb/7Ljmw6BLPvcS0A3riYOl8pyXEYy9x4VTufClCHCF6YscP
         /t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345664; x=1783950464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWs74MIuaQ3UGyklOH9NT4Sl0r8NQtJ6GpHW3lV4GUk=;
        b=i7iNvaJ8TgQ6hur+9WrW2y3RcObOC0tPheEjSKg5zb8aKrJZGXsoQJKCp9saf/KEKv
         uOt66LWfrIH0U4RC4ijeAqy+/Xm2vz8v97/DfD5tqErEzk9tXa6FfP7+NOR/hh4zeGLN
         g/9uNiuVeWOCCANja1G7T4B6v8FPW/b3/RYG3KYV6MMrf9rgPfkhNDdAe2UTGBLToZNM
         rFYwDYJ1lEcR7PSXKCmieFOy9jJwXaHYWQ8YUpWc22EFmhdxBdIE2Nuxsy1osWYjhD8G
         0zTQTfRXARnLdNj8/g6TLwB8d67hDpz1oQdRBDpNiaA/j/5gVUa03t+Zsjs8Wbb0Auwe
         QnIw==
X-Gm-Message-State: AOJu0Ywhclk/cEgxXEbQ4N6XOBIcA0f8dl9YpQVH615FmMOfCmtWVTHA
	tmAzVQ1oT+vcJWrGd403EODrifMIMnzDqGGDLPhhb3BUm1KDheaF6S/98rVubPFl
X-Gm-Gg: AfdE7ckLqQf3A+bJ3GDRXTX7yxRAwg2LDAVmIhtK7qH4V5zNC47aFZIvKfUYhV6ahFe
	SFJRbG8Cp+L8wsYYWVzauniq95cIjAguapB1MVvSpUoTYcHthk0vrV1gtY1s7sMPenIIpVJA5RV
	vcgloFfHR6I/VmMeOdnm7sjsJjlpeGt21fIS0AtN9i6BynWDlg/6xPza9UW+Qtf5QfTJqIjJq5Z
	biSltIO0iyBVVefIlGnlJlvBaJDofVDilg+xU4XDUkXonIkeHx0yzW6gWgxT62V7/wmjPo0rPXm
	AYoAXlgDzJ0za8G/FWHPXmtfpxdaGt72wFgT4KYPS09yuypJOvHC/ko0WAddwM0x0iPR0YfLc9O
	h/d0D1HWC3iB6VNFaYRpG2Qg2iJL9aIyqYDe8vcNFgaBrMoVpgDFjyyoH5QyM+GVighfCFDWKUR
	eK57Z6F7AORI5A+m+sMKw0S/kSm3a1u7py9uS9TWXIWn3LFOJp90ziRM0WQA==
X-Received: by 2002:a05:6a21:e0a2:b0:3b7:d8d5:2326 with SMTP id adf61e73a8af0-3c08ed14432mr812456637.1.1783345663348;
        Mon, 06 Jul 2026 06:47:43 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb7fe46sm61132751eec.14.2026.07.06.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:47:42 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	tipc-discussion@lists.sourceforge.net,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] tipc: serialize udp bearer replicast list updates
Date: Mon,  6 Jul 2026 06:47:17 -0700
Message-ID: <20260706134716.3879-2-bestswngs@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,google.com,kernel.org,lists.sourceforge.net,asu.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-305071-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jmaloy@redhat.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:tipc-discussion@lists.sourceforge.net,m:xmei5@asu.edu,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E02D711E39

tipc_udp_rcast_add() and cleanup_bearer() both update ub->rcast.list
with list_add_rcu() / list_del_rcu(), but nothing serializes them. The
add runs from the encap receive softirq (via tipc_udp_rcast_disc())
without rtnl_lock(), so it can race the cleanup delete and corrupt the
list:

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

Add a spinlock and take it around both list updates. Re-check for the
peer under the lock in the add path so the check-then-add in
tipc_udp_rcast_disc() cannot insert a duplicate.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/udp_media.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 62ae7f5b5840..601174297a16 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -94,6 +94,7 @@ struct udp_replicast {
  * @ifindex:	local address scope
  * @work:	used to schedule deferred work on a bearer
  * @rcast:	associated udp_replicast container
+ * @rcast_lock:	serializes updates to @rcast.list
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
@@ -301,7 +303,7 @@ static bool tipc_udp_is_known_peer(struct tipc_bearer *b,
 static int tipc_udp_rcast_add(struct tipc_bearer *b,
 			      struct udp_media_addr *addr)
 {
-	struct udp_replicast *rcast;
+	struct udp_replicast *rcast, *tmp;
 	struct udp_bearer *ub;
 
 	ub = rcu_dereference_rtnl(b->media_ptr);
@@ -319,6 +321,17 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 
 	memcpy(&rcast->addr, addr, sizeof(struct udp_media_addr));
 
+	/* tipc_udp_rcast_disc() adds from softirq without rtnl_lock(). */
+	spin_lock_bh(&ub->rcast_lock);
+	list_for_each_entry(tmp, &ub->rcast.list, list) {
+		if (!memcmp(&tmp->addr, addr, sizeof(struct udp_media_addr))) {
+			spin_unlock_bh(&ub->rcast_lock);
+			dst_cache_destroy(&rcast->dst_cache);
+			kfree(rcast);
+			return 0;
+		}
+	}
+
 	if (ntohs(addr->proto) == ETH_P_IP)
 		pr_info("New replicast peer: %pI4\n", &rcast->addr.ipv4);
 #if IS_ENABLED(CONFIG_IPV6)
@@ -327,6 +340,7 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 #endif
 	b->bcast_addr.broadcast = TIPC_REPLICAST_SUPPORT;
 	list_add_rcu(&rcast->list, &ub->rcast.list);
+	spin_unlock_bh(&ub->rcast_lock);
 	return 0;
 }
 
@@ -679,6 +693,7 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&ub->rcast.list);
+	spin_lock_init(&ub->rcast_lock);
 
 	if (!attrs[TIPC_NLA_BEARER_UDP_OPTS])
 		goto err;
@@ -819,10 +834,12 @@ static void cleanup_bearer(struct work_struct *work)
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


