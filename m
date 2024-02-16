Return-Path: <netdev+bounces-72530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4288587B0
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF65B293AC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9BB13A253;
	Fri, 16 Feb 2024 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SlbT3iHK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351A28E2B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117640; cv=none; b=tqAoMelYGOhX80L7Z53n8gaxkmTVzFbLupgxCvVxkPw8zh3HG1/iv3HrBfMvX/X1PLdtStQrCm2LczWq7rfW2ZTbLPvsvVwSvpqyer0t230nk1Q7R9Uf+Qy7X+cJ7F8eytU72OAPebYSws+62UL7ECaanyIrzd0dSg9NDWh0raE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117640; c=relaxed/simple;
	bh=tDrJCRbfwHK7vItsg5KdgejvO0gEMmMHJKwc0y6caNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYy6C8WN7VdCaYhQexei1HTmgvR03WQwG+y15xEiC+vZQfrOIaEMRhzLa4I5CrRKht+Dou+L542IIvqk9dBVA0oie6TdB9E3qhiXGe/t0Cf1hrS92E420Ip347S6Up9CEHoKHrNxnDOhVKCYoIpq0KzFOzbpnxW+IcOkwtxiiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SlbT3iHK; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117638; x=1739653638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fNHSQFqTQL3xO3VVWDcvUdHZsfRr6FMObga5P4qping=;
  b=SlbT3iHKc5FJqI/NoWgYLew1RP14Yjp3vCdSP8J9J8OHSJpNLRL6tkw3
   JG9Zzvb9qC2kPNA2ugZJQ/T8M6+I1qt4gKhQkp4tXWOI/iBK4EWWEghkn
   kWfeJGcyZ0UtI9TZPFlT15OQ4Y2s3QyZK0wNnwTa4sSyc4Pw+dkSXVbwG
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="613620079"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:07:15 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:37086]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.119:2525] with esmtp (Farcaster)
 id ed6de534-4104-464c-8b05-be6e80a50a1a; Fri, 16 Feb 2024 21:07:14 +0000 (UTC)
X-Farcaster-Flow-ID: ed6de534-4104-464c-8b05-be6e80a50a1a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:07:14 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:07:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/14] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Fri, 16 Feb 2024 13:05:44 -0800
Message-ID: <20240216210556.65913-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216210556.65913-1-kuniyu@amazon.com>
References: <20240216210556.65913-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When we send a fd using SCM_RIGHTS message, we allocate struct
scm_fp_list to struct scm_cookie in scm_fp_copy().  Then, we bump
each refcount of the inflight fds' struct file and save them in
scm_fp_list.fp.

Later, unix_attach_fds() inexplicably clones scm_fp_list of
scm_cookie and sets it to skb.  (We will remove this part after
replacing GC.)

Now we add a new function call in unix_attach_fds() to preallocate
to skb's scm_fp_list an array of struct unix_edge in the number of
inflight AF_UNIX fds.

There we just preallocate memory and do not use immediately because
sendmsg() could fail after this point.  The actual use will be in
the next patch.

When we queue skb with inflight edges, we will set the inflight
socket's unix_vertex as unix_edge->predecessor and the receiver's
vertex as successor, and then we will link the edge to the inflight
socket's unix_vertex.edges.

Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
so that MSG_PEEK does not change the shape of the directed graph.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  8 ++++++++
 include/net/scm.h     |  7 +++++++
 net/core/scm.c        |  7 +++++++
 net/unix/af_unix.c    |  5 +++++
 net/unix/garbage.c    | 18 ++++++++++++++++++
 5 files changed, 45 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 664f6bff60ab..cab9dfb666f3 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -23,6 +23,8 @@ extern unsigned int unix_tot_inflight;
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_init_vertex(struct unix_sock *u);
+int unix_alloc_edges(struct scm_fp_list *fpl);
+void unix_free_edges(struct scm_fp_list *fpl);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
@@ -32,6 +34,12 @@ struct unix_vertex {
 	unsigned long out_degree;
 };
 
+struct unix_edge {
+	struct unix_vertex *predecessor;
+	struct unix_vertex *successor;
+	struct list_head entry;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/include/net/scm.h b/include/net/scm.h
index 92276a2c5543..a1142dee086c 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -23,10 +23,17 @@ struct scm_creds {
 	kgid_t	gid;
 };
 
+#ifdef CONFIG_UNIX
+struct unix_edge;
+#endif
+
 struct scm_fp_list {
 	short			count;
 	short			count_unix;
 	short			max;
+#ifdef CONFIG_UNIX
+	struct unix_edge	*edges;
+#endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
 };
diff --git a/net/core/scm.c b/net/core/scm.c
index 9cd4b0a01cd6..bc75b6927222 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -87,6 +87,9 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		*fplp = fpl;
 		fpl->count = 0;
 		fpl->count_unix = 0;
+#if IS_ENABLED(CONFIG_UNIX)
+		fpl->edges = NULL;
+#endif
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 	}
@@ -376,6 +379,10 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 	if (new_fpl) {
 		for (i = 0; i < fpl->count; i++)
 			get_file(fpl->fp[i]);
+
+#if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->edges = NULL;
+#endif
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 	}
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ae145b6f77d8..0391f66546a6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1819,6 +1819,9 @@ static int unix_attach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_inflight(scm->fp->user, scm->fp->fp[i]);
 
+	if (unix_alloc_edges(UNIXCB(skb).fp))
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -1829,6 +1832,8 @@ static void unix_detach_fds(struct scm_cookie *scm, struct sk_buff *skb)
 	scm->fp = UNIXCB(skb).fp;
 	UNIXCB(skb).fp = NULL;
 
+	unix_free_edges(scm->fp);
+
 	for (i = scm->fp->count - 1; i >= 0; i--)
 		unix_notinflight(scm->fp->user, scm->fp->fp[i]);
 }
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 6a71997ac67a..ec998c7d6b4c 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -109,6 +109,24 @@ void unix_init_vertex(struct unix_sock *u)
 	INIT_LIST_HEAD(&vertex->edges);
 }
 
+int unix_alloc_edges(struct scm_fp_list *fpl)
+{
+	if (!fpl->count_unix)
+		return 0;
+
+	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
+				    GFP_KERNEL_ACCOUNT);
+	if (!fpl->edges)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void unix_free_edges(struct scm_fp_list *fpl)
+{
+	kvfree(fpl->edges);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


