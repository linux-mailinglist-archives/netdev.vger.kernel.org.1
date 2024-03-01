Return-Path: <netdev+bounces-76399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E117186D9AE
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA331C22B77
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92BA3A8C6;
	Fri,  1 Mar 2024 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aGVfpZdJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820E3C487
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259834; cv=none; b=Ogz69KBNurY4XlAxQtVD6lzJ85VmCOHABuw1JGKaUsvrb7pIKeRIUcZ/mWD81ZJ3pGgelePWqyNTpg2XiKPncNcE3qMAyjq1RNS6ADTTWjY9uAh3QUUseLVXMw9l2gduT91V7h7yL0Aj0JM5IYw4UKpSIbLYOQbj2HGXgLYPtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259834; c=relaxed/simple;
	bh=cvAFTB5Fl4ABRm6q8gAQa76ykQI5qyDDvhFnu3Nlluc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWlkeEj2pLap2IDQUGB13eqVXbpSHvfEWN6OY9xeCPVtgOUrWF7fVDBNdcyeqGxzii2r3eNyukU5Xs6iVsab69tswhHzwQMBIOhjwnTJuEd7o9HIDBEstIo8+XCw4dv7+zC7ZT26wNkALHZQzLQWVvsJPpas3Z7IsDo+8URmeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aGVfpZdJ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259833; x=1740795833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G1uch6QHxqxni8gJ+VBi5uykeMpQSVHkOLmEZAqaNWs=;
  b=aGVfpZdJiihliDruSRfEOlg7qTD6r7SvhZCJ6T7BhZb04sU1kXNIQf03
   QB7nfzAIMWHNDihIr0AKeplvZjLDys6InACrBcYXT02RY/jFPdRElec+j
   JUKNtEUr1/t08wrbydN7s8JaKRtK3smeSW9kVsBByHv4xnwF0RI2LdM44
   A=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="276916559"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:23:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:4217]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.146:2525] with esmtp (Farcaster)
 id 21f64df5-d4f0-4123-90f0-3437c45a10f8; Fri, 1 Mar 2024 02:23:50 +0000 (UTC)
X-Farcaster-Flow-ID: 21f64df5-d4f0-4123-90f0-3437c45a10f8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:23:50 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:23:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 02/15] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Thu, 29 Feb 2024 18:22:30 -0800
Message-ID: <20240301022243.73908-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301022243.73908-1-kuniyu@amazon.com>
References: <20240301022243.73908-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

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


