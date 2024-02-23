Return-Path: <netdev+bounces-74590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258C861F25
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E8A1F289DA
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A31482FF;
	Fri, 23 Feb 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BOZwBzlr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CE9148FF5
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 21:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724478; cv=none; b=c8dxTtzxueR8jyTEEpzwmAiakPJigKCGh9IsDfZcq8qryULzkGqQCLna+n/OzOo3EyyjDE5Jqk4DZ7/oyjkgO2C4EVXScsVXNjtoEbwG0FvUJMQvO+fsqAcIJOiuhm0898I9MEkDcveBXVz6PYewJr1Jy6e7qu96bkyJN8MzQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724478; c=relaxed/simple;
	bh=cvAFTB5Fl4ABRm6q8gAQa76ykQI5qyDDvhFnu3Nlluc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzuw6m8n5WceNTvGXSxOuogGVn9RKz3J44QBOnAqhWjG1+gop/nDkJ0117GcpakvHz0jKeZUydAYA412YwvBjvbeaiFu38+O8CdvI9CzLz1gTLVUY+cFlz3K/7ujMVkypAFvmtSutVlljT2Q7hUKCo2tilBYj+Ei4nd90tNYNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BOZwBzlr; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708724478; x=1740260478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G1uch6QHxqxni8gJ+VBi5uykeMpQSVHkOLmEZAqaNWs=;
  b=BOZwBzlrh6sQi5NCd1QDrx8A1O5QdpWgKyuuWItjrRcCZsrv20IV9i2s
   IzxWiSRPowkRLSwRbxdFv1NGBzsfdWJNAHD0dAl44L5yQz1Ev0W8+VYFk
   uRAqMTXASys+AQyERzJOnWSUT4Ny1Z+mNO75Wah78hhVxD+ymJb2OuzLg
   c=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="187028505"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 21:41:15 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:54755]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.16.177:2525] with esmtp (Farcaster)
 id 9e919f32-1b96-47f8-a703-b156e3e26cbe; Fri, 23 Feb 2024 21:41:13 +0000 (UTC)
X-Farcaster-Flow-ID: 9e919f32-1b96-47f8-a703-b156e3e26cbe
Received: from EX19D004ANA003.ant.amazon.com (10.37.240.184) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:41:13 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.9) by
 EX19D004ANA003.ant.amazon.com (10.37.240.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 21:41:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 02/14] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Fri, 23 Feb 2024 13:39:51 -0800
Message-ID: <20240223214003.17369-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223214003.17369-1-kuniyu@amazon.com>
References: <20240223214003.17369-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA003.ant.amazon.com (10.37.240.184)

As with the previous patch, we preallocate to skb's scm_fp_list an
array of struct unix_edge in the number of inflight AF_UNIX fds.

There we just preallocate memory and do not use immediately because
sendmsg() could fail after this point.  The actual use will be in
the next patch.

When we queue skb with inflight edges, we will set the inflight
socket's unix_sock as unix_edge->predecessor and the receiver's
unix_sock as successor, and then we will link the edge to the
inflight socket's unix_vertex.edges.

Note that we set NULL to cloned scm_fp_list.edges in scm_fp_dup()
so that MSG_PEEK does not change the shape of the directed graph.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 6 ++++++
 include/net/scm.h     | 5 +++++
 net/core/scm.c        | 2 ++
 net/unix/garbage.c    | 6 ++++++
 4 files changed, 19 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index c270877a5256..55c4abc26a71 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -33,6 +33,12 @@ struct unix_vertex {
 	unsigned long out_degree;
 };
 
+struct unix_edge {
+	struct unix_sock *predecessor;
+	struct unix_sock *successor;
+	struct list_head vertex_entry;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/include/net/scm.h b/include/net/scm.h
index e34321b6e204..5f5154e5096d 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -23,12 +23,17 @@ struct scm_creds {
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
 #ifdef CONFIG_UNIX
 	struct list_head	vertices;
+	struct unix_edge	*edges;
 #endif
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
diff --git a/net/core/scm.c b/net/core/scm.c
index 87dfec1c3378..1bcc8a2d65e3 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -90,6 +90,7 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		fpl->max = SCM_MAX_FD;
 		fpl->user = NULL;
 #if IS_ENABLED(CONFIG_UNIX)
+		fpl->edges = NULL;
 		INIT_LIST_HEAD(&fpl->vertices);
 #endif
 	}
@@ -383,6 +384,7 @@ struct scm_fp_list *scm_fp_dup(struct scm_fp_list *fpl)
 		new_fpl->max = new_fpl->count;
 		new_fpl->user = get_uid(fpl->user);
 #if IS_ENABLED(CONFIG_UNIX)
+		new_fpl->edges = NULL;
 		INIT_LIST_HEAD(&new_fpl->vertices);
 #endif
 	}
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 75bdf66b81df..f31917683288 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -127,6 +127,11 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 		list_add(&vertex->entry, &fpl->vertices);
 	}
 
+	fpl->edges = kvmalloc_array(fpl->count_unix, sizeof(*fpl->edges),
+				    GFP_KERNEL_ACCOUNT);
+	if (!fpl->edges)
+		goto err;
+
 	return 0;
 
 err:
@@ -136,6 +141,7 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 
 void unix_destroy_fpl(struct scm_fp_list *fpl)
 {
+	kvfree(fpl->edges);
 	unix_free_vertices(fpl);
 }
 
-- 
2.30.2


