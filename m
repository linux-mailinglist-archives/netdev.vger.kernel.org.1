Return-Path: <netdev+bounces-212549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCDB21331
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82BCE6266B1
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A732D47EF;
	Mon, 11 Aug 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQVbBYFK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD2311C16
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933494; cv=none; b=GjqK/oai6yRn2H06pfcADnLcXunDq4zfJ204M+q6Xw+GhrRXYm1hShBesHMMvqDQgRuGtbScoawZI6ajxDmmR7hCpLP1eoALZlqVQw2GywyGMnOvKStuYLRu6nvkARtlxmeVcJnBkTCpIj8F1gTdOaPFbYhURtPPhfIeCn0sr28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933494; c=relaxed/simple;
	bh=RraDdlXe6ciaP6cYzKFgCu43EUAwSOZf2SxKtlzfM/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cosozWqgZUfSIc1R6FCNqxTY/2jjUuxKmmuf1CIy86usd3DVLTgHkp3p/OqTXT3sk227vVQBZatgMrxnOZfVz+Ba3sF58gkXGGodoya9g0VSg2G7TtBHi/aQobQYbOvCTY2kaC/sm1pP+pMeuAaMfJab/OkFwCgNccOSOC7mwCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQVbBYFK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76c47324232so2839258b3a.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 10:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754933492; x=1755538292; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=aQVbBYFKO4gAwr65dH45TLAvKY5lFG9OJxYIgtKTqGRZqW+zGIZfZ51O1ZeZX2O/nl
         7QlORFFS6Sr3cPL08/oaIFaOvT7wPbi2gUzDEpktQ9BH7DSsIQqxfgP8QRDFmoorQDx2
         XufPk4jn7l+yJE64Rxa7sajFUIWx8cy32jjMoOuEydqeutzw9K0U7swo2AknnX5bgBXB
         O0RyabM0ccBn9BsmeuGAQEdD+YVvCEhT5hJiIu4QuyE9NJkEAxdSZHOQU++ggxQEiNZA
         yGSRUNilrTqTk+uhdzLwlJ3JOKJETWiBFFLt38c8633zCrZqkVdN07zNJlzR1NcO9moi
         wfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754933492; x=1755538292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zi8XD71jgjXMWJD0GQyZXVIV2qpgVtIymKBEzG9L4F4=;
        b=kxTX0szIaItyRQDOEYJpbb2Tm8j1YDIjwjq8LXu+e7bMf7PbG52wuSA553/c1mj7zF
         X5wDVVCDluk3PVRCXBRiBOOR7P4ig+KFWhH91CjySeWWrjFrdJ7Yet4VrS4amONS6xqi
         cr7zLPWxAfN15yaqpKX8WBDYeqfd06avJHFWfHkvQDuN/fm1YW+++GxyBuOPyEEXFmJT
         0OgIgTligaRyYkBqaMR/+5qhd3Cc9jMNv3ZOjTF/j9idf111MOyKO2FdQB38HWL0jfEL
         IyQ6LsZHDV8jtuDA0r4QtVHKCe5lUhY0H0YQRRy2Zqi3rGEAO7UraI7J5uRVUmepGgDw
         WoZw==
X-Forwarded-Encrypted: i=1; AJvYcCVzH6iFPXUuPBaGq5b4r+ccohLOST5aCNPFJE2Kkiw1Ay0IHcQRbPD+pHLOlfqPEsCSbzaf2Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6ic7qp4XXdTJlVjxhWQpGgTB9dcNlXqsp5AGxmQyaZoEWj1a
	/47PV0EWOtGEsIFxsqbdY06B78e9oAlGuuGWLlW0BrAof3L+rfOgxLFEfLPLexlh42UQqI6/pGU
	obp8ejQ==
X-Google-Smtp-Source: AGHT+IHo2yNLTeCJQnssS8cRVh9LBZumUnUBfB6vxpMn5hTdAQ6pUphTOW3txkt3Suq2A0M516UNLF041yo=
X-Received: from pftb15.prod.google.com ([2002:a05:6a00:2cf:b0:76b:ca57:9538])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1b:b0:748:ffaf:9b53
 with SMTP id d2e1a72fcca58-76c461af0ebmr17005996b3a.16.1754933492214; Mon, 11
 Aug 2025 10:31:32 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:30:29 +0000
In-Reply-To: <20250811173116.2829786-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811173116.2829786-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811173116.2829786-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 01/12] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
sk->sk_memcg based on the current task.

MPTCP subflow socket creation is triggered from userspace or
an in-kernel worker.

In the latter case, sk->sk_memcg is not what we want.  So, we fix
it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().

Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
under #ifdef CONFIG_SOCK_CGROUP_DATA.

The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
correctly.

Let's move the code out of the wrong ifdef guard.

Note that sk->sk_memcg is freed in sk_prot_free() and the parent
sk holds the refcnt of memcg->css here, so we don't need to use
css_tryget().

Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 10 ++++++++++
 net/mptcp/subflow.c        | 11 +++--------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 785173aa0739..25921fbec685 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1604,6 +1604,7 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
 
 #if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
@@ -1661,6 +1662,11 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..08c6e06750ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5024,6 +5024,16 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+	if (sk->sk_memcg == newsk->sk_memcg)
+		return;
+
+	mem_cgroup_sk_free(newsk);
+	css_get(&sk->sk_memcg->css);
+	newsk->sk_memcg = sk->sk_memcg;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 3f1b62a9fe88..6fb635a95baf 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1717,19 +1717,14 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	/* only the additional subflows created by kworkers have to be modified */
 	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
 	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-#ifdef CONFIG_MEMCG
-		struct mem_cgroup *memcg = parent->sk_memcg;
-
-		mem_cgroup_sk_free(child);
-		if (memcg && css_tryget(&memcg->css))
-			child->sk_memcg = memcg;
-#endif /* CONFIG_MEMCG */
-
 		cgroup_sk_free(child_skcd);
 		*child_skcd = *parent_skcd;
 		cgroup_sk_clone(child_skcd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+
+	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+		mem_cgroup_sk_inherit(parent, child);
 }
 
 static void mptcp_subflow_ops_override(struct sock *ssk)
-- 
2.51.0.rc0.155.g4a0f42376b-goog


