Return-Path: <netdev+bounces-261709-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHDWMZ0SoWlwqAQAu9opvQ
	(envelope-from <netdev+bounces-261709-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:42:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D09C1B2573
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 04:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899B230E7847
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79B20E025;
	Fri, 27 Feb 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A1ysB/02"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E02332EC0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772163570; cv=none; b=MwJCOS7tweiaOKDBEWHQkUwfbRIUfgPCIjtto1DaIhPyACcdm7W/SJzERA3t6v+M/6n5FIzMxzXxVkE7q6T2vKYTt8/pcxHLsIW+ndVMgZLe9nRDPRaZIQtbVtfkvVJK01J50gjNnBKDrs9UYjiJKABu+hWswLQvdNo7aqbGZhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772163570; c=relaxed/simple;
	bh=F+J0wNpTbMns+3gl9I+4DiML5JgGjx0gQGZR3DcQkBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fkP3x0tBZTpPIsXpI9eUzTT0oNtpvcB33AroeYCrmulElhpAsckDjnyjqO+SZz6T3bnClM2Ml3o0fenWUVZiAY6MTIsa3uT46lhgTePLLWqR3Tef+G1GVEBddWSiI9Nx2YGMS8XonG7KNzb1wjhCdNI1RaAehOOVt5/bpoyEy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A1ysB/02; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c72d23dfso7781667a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 19:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772163569; x=1772768369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXLPpgIN10GTEc28eOJ5dru8Knb+UVvGbZfxe/JDD7M=;
        b=A1ysB/02u7kwbwpuRUwQvkzccPFke6NoZogLDMLiAbckFnxtv8JM2FuvSJJP+ieeui
         fSmsF23uDXSyunwk5c98tWUppvKFKUn19v9tY6OppkjbKVAYbivlU4PgQGQzYVpvNw6r
         3DK7wu1SX+kq5zCDt1CObImaw5l3Adlu9pQp9ldgjcBdhTNMLCcsmz6JcID82a+4SV5T
         zJ9x2H2/lRi0+QqJ1iz3KAi+fdXuR2funeGMHoKVFTE7PWZ+booMENB8dj6dUsSZOxss
         nNSfxYDJ7jM18WtdNgf/A/VG/qCqKXiHAuM07C0yvqBD7RFsPZa1pn/xLseTu+kcd597
         jarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772163569; x=1772768369;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXLPpgIN10GTEc28eOJ5dru8Knb+UVvGbZfxe/JDD7M=;
        b=sLB5l/g29KKDA0V7EC47CXfKeE5CQj5ffcJ+5LDB1trWMUxGXYkjPb3XVzNDxLpdb3
         OgXv0+Ls6apJxYHIz8HtC4a+xTa1ts07wcGjSH9d3WfBn7EpIKGSVgdum11C7UEV8Hgd
         Rz4/jO5bKUybUrPnomto85AkMRVjS2dVM3EG93dhiXj849We0HCxEdTJkP76FARe8W0X
         hqkrYcB05bNClZnafvdt6dRqC5LuFRqc7+0vZepwd6XGGyBj7pp/wkL2r5j69K43UpAt
         m5ol1rJgJze8CTkorNjMKecj3P1wpNyrpWylTV8ZVoby5AEkJv/BzIH0xlAA5SBIsj7U
         pGdA==
X-Forwarded-Encrypted: i=1; AJvYcCXfXIDtik6pAqOK9izEelw93l7MKOw7t41zeAkXdPavCMV0yUmqOpmFGsX32Wr/nCpbBgHEayA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC8z6GOVAPFpqcX7nX0tVZ0khDrPB+y/RTdCZf2JMXFPRFwK21
	ZvLqaNoylePgSq9uNqSueCZ993cjEFkk50iVsvmgoP3bhIUYqTmZn73FpXOsJwIBrvgsLZEK9gg
	7qiTy+w==
X-Received: from pjqt8.prod.google.com ([2002:a17:90a:ae08:b0:349:8a6d:dfd1])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5102:b0:355:35b0:8b88
 with SMTP id 98e67ed59e1d1-35965d11b4dmr1113584a91.32.1772163568573; Thu, 26
 Feb 2026 19:39:28 -0800 (PST)
Date: Fri, 27 Feb 2026 03:38:36 +0000
In-Reply-To: <20260227033903.3307272-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260227033903.3307272-14-kuniyu@google.com>
Subject: [PATCH v2 net-next 13/15] ipmr/ip6mr: Convert net->ipv[46].ipmr_seq
 to atomic_t.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261709-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D09C1B2573
X-Rspamd-Action: no action

We will no longer hold RTNL for ipmr_mfc_add() and ipmr_mfc_delete().

MFC entry can be loosely connected with VIF by its index for
mrt->vif_table[] (stored in mfc_parent), but the two tables are
not synchronised.  i.e. Even if VIF 1 is removed, MFC for VIF 1
is not automatically removed.

The only field that the MFC/VIF interfaces share is
net->ipv[46].ipmr_seq, which is protected by RTNL.

Adding a new mutex for both just to protect a single field is overkill.

Let's convert the field to atomic_t.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/mroute_base.h | 8 ++++----
 include/net/netns/ipv4.h    | 2 +-
 include/net/netns/ipv6.h    | 2 +-
 net/ipv4/ipmr.c             | 4 ++--
 net/ipv6/ip6mr.c            | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
index 0075f6e5c3da..0baa6f994da9 100644
--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -76,7 +76,7 @@ static inline int mr_call_vif_notifiers(struct net *net,
 					struct vif_device *vif,
 					struct net_device *vif_dev,
 					unsigned short vif_index, u32 tb_id,
-					unsigned int *ipmr_seq)
+					atomic_t *ipmr_seq)
 {
 	struct vif_entry_notifier_info info = {
 		.info = {
@@ -89,7 +89,7 @@ static inline int mr_call_vif_notifiers(struct net *net,
 	};
 
 	ASSERT_RTNL();
-	(*ipmr_seq)++;
+	atomic_inc(ipmr_seq);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
 
@@ -198,7 +198,7 @@ static inline int mr_call_mfc_notifiers(struct net *net,
 					unsigned short family,
 					enum fib_event_type event_type,
 					struct mr_mfc *mfc, u32 tb_id,
-					unsigned int *ipmr_seq)
+					atomic_t *ipmr_seq)
 {
 	struct mfc_entry_notifier_info info = {
 		.info = {
@@ -209,7 +209,7 @@ static inline int mr_call_mfc_notifiers(struct net *net,
 	};
 
 	ASSERT_RTNL();
-	(*ipmr_seq)++;
+	atomic_inc(ipmr_seq);
 	return call_fib_notifiers(net, event_type, &info.info);
 }
 
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 380ff34c0233..94dca64fec41 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -280,7 +280,7 @@ struct netns_ipv4 {
 	struct fib_rules_ops	*mr_rules_ops;
 #endif
 	struct fib_notifier_ops	*ipmr_notifier_ops;
-	unsigned int		ipmr_seq;	/* protected by rtnl_mutex */
+	atomic_t		ipmr_seq;
 #endif
 #ifdef CONFIG_IP_ROUTE_MULTIPATH
 	struct sysctl_fib_multipath_hash_seed sysctl_fib_multipath_hash_seed;
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 34bdb1308e8f..499e4288170f 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -118,7 +118,7 @@ struct netns_ipv6 {
 	struct seg6_pernet_data *seg6_data;
 	struct fib_notifier_ops	*notifier_ops;
 	struct fib_notifier_ops	*ip6mr_notifier_ops;
-	unsigned int ipmr_seq; /* protected by rtnl_mutex */
+	atomic_t		ipmr_seq;
 	struct {
 		struct hlist_head head;
 		spinlock_t	lock;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 77ae0fd9ec31..77684acc8ad4 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -3226,7 +3226,7 @@ static const struct net_protocol pim_protocol = {
 
 static unsigned int ipmr_seq_read(const struct net *net)
 {
-	return READ_ONCE(net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
+	return atomic_read(&net->ipv4.ipmr_seq) + ipmr_rules_seq_read(net);
 }
 
 static int ipmr_dump(struct net *net, struct notifier_block *nb,
@@ -3247,7 +3247,7 @@ static int __net_init ipmr_notifier_init(struct net *net)
 {
 	struct fib_notifier_ops *ops;
 
-	net->ipv4.ipmr_seq = 0;
+	atomic_set(&net->ipv4.ipmr_seq, 0);
 
 	ops = fib_notifier_ops_register(&ipmr_notifier_ops_template, net);
 	if (IS_ERR(ops))
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e047a4680ab0..85010ff21c98 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1280,7 +1280,7 @@ static int ip6mr_device_event(struct notifier_block *this,
 
 static unsigned int ip6mr_seq_read(const struct net *net)
 {
-	return READ_ONCE(net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
+	return atomic_read(&net->ipv6.ipmr_seq) + ip6mr_rules_seq_read(net);
 }
 
 static int ip6mr_dump(struct net *net, struct notifier_block *nb,
@@ -1305,7 +1305,7 @@ static int __net_init ip6mr_notifier_init(struct net *net)
 {
 	struct fib_notifier_ops *ops;
 
-	net->ipv6.ipmr_seq = 0;
+	atomic_set(&net->ipv6.ipmr_seq, 0);
 
 	ops = fib_notifier_ops_register(&ip6mr_notifier_ops_template, net);
 	if (IS_ERR(ops))
-- 
2.53.0.473.g4a7958ca14-goog


