Return-Path: <netdev+bounces-303967-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TZxmIsLsRWoAGwsAu9opvQ
	(envelope-from <netdev+bounces-303967-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC726F3713
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 06:44:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Ym7E2U4H;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303967-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303967-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC031302FB6F
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 04:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8A7364029;
	Thu,  2 Jul 2026 04:44:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F932313E34
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 04:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782967481; cv=none; b=V+SMX09wM3eDCoiGOpuN1MfEgzIEFknwz/HVfDXDw0epqNiWbixyPUd7Ac9MchMlTLIEczy23SadhxgncD0/tXBBoJryAbA3WrkBwP03k8ZdUub5XVr8SzRonVTsRZgq/5kODTuye0dhCxiM5B449voXQf1+75mNnaOQRtLd0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782967481; c=relaxed/simple;
	bh=cz4544ye6wdYTvz11EuuYyKUVIbk85vqITIq7JMkWS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mb2eJmbxMAa9zeCe7lGq7Gsf9Sset3sJ5zlwcDHvzQ8P7dWL1A+AoZ2et/6nzw7e5UtSK29DeFA1CV5LUolLUpVXhKAMLiUq7esLmaegGBC7p4tVGvc1r2yNR8sf0TCwnEnqmCzHYAefGae0kolD1oQqZOE0jPGseUZOraLcP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ym7E2U4H; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84770f89b99so2186937b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 21:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782967479; x=1783572279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mPEgllbGTjIGqDh+oRhYJNrbBWThinSgWSdtEb1tc=;
        b=Ym7E2U4HwNCLGM3BWhHLOiIw2pdU7XbeqjXXNvwidEWxX1RqHeREkYiCc8Pzw2E9EP
         7DqCMOekTybvx6utUBQWO+ea44vE6ngfDrpQDRnVA7bVCiv6Tg/790bABzTsMDWjzpbl
         4aFo/lP+/9HPZWP2D3eY+m0XVARdRdJirDgOandAfuOwz3poU0bhJHwIsbMEXBmdQxEE
         Qcq+Iszc/iUU/583Utc/nD1ymsWaXgkATisGZ+2hMytbFe0rpGWSpImMxoACd9r8YqHa
         Lbbnbw1vwI43DTMz3szdKKJ6876I/i7QUZvU+1vVPF5wGjM+blz73UkTFqmdeMHh0hng
         eLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782967479; x=1783572279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3mPEgllbGTjIGqDh+oRhYJNrbBWThinSgWSdtEb1tc=;
        b=eyr2Sctyk+S9AXhHFWBJNPZr+TRb4Lb4gvLbH+JRp9aMQAdvLUQqKhsuP49jZ0Xw7m
         mAXgXeCrMn2rpa7Bf+ohZoukxNRLtVfRUQ+01dezJcNy4pWhE3jZ3tYWkdd3cGE//AIB
         TAfRR8CG/gWTKshVH5DcSW3LWsCVjhV1gwbL24w5T5fFkIN0yuX90KWLvPG9Bk14d5tB
         7Grh0WEf9B/JL5XpqZfoAk9qEK1s8PNB9tdHD4eZadMhOBr4kiitbYdAUe7itixQwbdl
         VTCyX442bkhPSWhHqlGe3Tvx3zXD/NCCXJbvndLlzilB6heLndrm0SuV91GFS6KT1Hl2
         6n1g==
X-Forwarded-Encrypted: i=1; AFNElJ9a+9bbxOdtJmJblI7uwTUhmw4FhTzh4JNwdj6/gArpuFL+eJWjtZ2K4tczU59Tepif7nzgz60=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4UHZiy2teGDlQP+6FO3nlFIow6N1paehP1k9EJ/xF/jAnjDl
	wNHx49umkWimNgz/74rDV90YmKvbOKdaqsJai48wvgt+xWKiYQVhKSshH3gHuD9XHPKjouQQY6K
	jVvqUVg==
X-Received: from pfob3.prod.google.com ([2002:aa7:8703:0:b0:846:7503:7358])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:298a:b0:847:926c:5837
 with SMTP id d2e1a72fcca58-847c06744b3mr4376605b3a.11.1782967479294; Wed, 01
 Jul 2026 21:44:39 -0700 (PDT)
Date: Thu,  2 Jul 2026 04:44:14 +0000
In-Reply-To: <20260702044437.591864-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260702044437.591864-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260702044437.591864-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/2] ipv4: fib: Define fib_table_hash_lock under CONFIG_IP_MULTIPLE_TABLES.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303967-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BC726F3713

When CONFIG_IP_MULTIPLE_TABLES is disabled, fib_new_table()
is fib_get_table(), and no new table is created.

Let's move net->ipv4.fib_table_hash_lock under
CONFIG_IP_MULTIPLE_TABLES.

While at it, netns_ipv4_sysctl.rst is updated.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst | 1 +
 include/net/netns/ipv4.h                                      | 2 +-
 net/ipv4/fib_frontend.c                                       | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
index 6dbd97d435e9..3dc03bff739e 100644
--- a/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
+++ b/Documentation/networking/net_cachelines/netns_ipv4_sysctl.rst
@@ -22,6 +22,7 @@ struct_mutex                    ra_mutex
 struct_fib_rules_ops*           rules_ops
 struct_fib_table                fib_main
 struct_fib_table                fib_default
+spinlock_t                      fib_table_hash_lock
 unsigned_int                    fib_rules_require_fldissect
 bool                            fib_has_custom_rules
 bool                            fib_has_custom_local_routes
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 59506320558a..cb7f8bf15671 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -118,6 +118,7 @@ struct netns_ipv4 {
 	struct fib_rules_ops	*rules_ops;
 	struct fib_table __rcu	*fib_main;
 	struct fib_table __rcu	*fib_default;
+	spinlock_t		fib_table_hash_lock;
 	unsigned int		fib_rules_require_fldissect;
 	bool			fib_has_custom_rules;
 #endif
@@ -127,7 +128,6 @@ struct netns_ipv4 {
 	atomic_t		fib_num_tclassid_users;
 #endif
 	struct hlist_head	*fib_table_hash;
-	spinlock_t		fib_table_hash_lock;
 	struct sock		*fibnl;
 	struct hlist_head	*fib_info_hash;
 	unsigned int		fib_info_hash_bits;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 54eb72695093..6f5d0d25b110 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1584,7 +1584,10 @@ static int __net_init ip_fib_net_init(struct net *net)
 	net->ipv4.sysctl_fib_multipath_hash_fields =
 		FIB_MULTIPATH_HASH_FIELD_DEFAULT_MASK;
 #endif
+
+#ifdef CONFIG_IP_MULTIPLE_TABLES
 	spin_lock_init(&net->ipv4.fib_table_hash_lock);
+#endif
 
 	/* Avoid false sharing : Use at least a full cache line */
 	size = max_t(size_t, size, L1_CACHE_BYTES);
-- 
2.55.0.rc0.799.gd6f94ed593-goog


