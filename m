Return-Path: <netdev+bounces-68757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3674847FC5
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581171F25777
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0D946A5;
	Sat,  3 Feb 2024 03:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a0M2Q9jO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CDA7468
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929306; cv=none; b=Cud3MnbIJA9tn47Ndf0bZGMovQmZkEs/zDqgHd85LabX8M2BRuxskmNdS3rgSK+KjnrqNhsaea3zFsWOv0DiV0frxDfRZCMqa2fdmeo/Jc/hObT/DV6LYZF4f7NPoogidR7k5JDPcLBUeETrGeKY+aTNVa8r7a1S6xJ3nFP+tIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929306; c=relaxed/simple;
	bh=/gaJlAxeumkI2rYAnl8dTF3izJBw9g1wXV4FT1k+b3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcCB40j9C68Hson5MqwsrQwwJnajGkOODLc0EnGfYnVLyKHnWWhBN4zn5klNB8ya4l1TtpSqG4/oq1ck/Z/JI8KCkUnIWnhjY/hiPzQq6ILE0oZE+cWeAD9YbCVdMIWOr+z8n7cqlzad4Yb96rDXJxs5YmQIjDx9JAtU2XJbHF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a0M2Q9jO; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929305; x=1738465305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gA9aF7I3YqUfB2NP+1NzZMckH+vkdyPEIx78ouKlMJc=;
  b=a0M2Q9jOZWyO/iDtZp1oeY6oic/atT3Kv3NX4a0KuSf4RNFESQuC3TGq
   XYDMZRKlaUPsyJE9tOwlkXCFStzVolai+jG5/HkgWRP5VNQbj7xQZRNUT
   /MVTi8BcgOwJe9fuhHZQT40FEbIsTWWKPRE2+Ylws/lzZdnSt88io16Be
   E=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="378639944"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:01:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:32706]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.242:2525] with esmtp (Farcaster)
 id 5f4346fa-a7f5-4fae-aacf-cc5811c4960b; Sat, 3 Feb 2024 03:01:40 +0000 (UTC)
X-Farcaster-Flow-ID: 5f4346fa-a7f5-4fae-aacf-cc5811c4960b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:01:38 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:01:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/16] af_unix: Add struct unix_vertex in struct unix_sock.
Date: Fri, 2 Feb 2024 19:00:43 -0800
Message-ID: <20240203030058.60750-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will replace the garbage collection algorithm for AF_UNIX,
where we will consider each inflight file descriptor of AF_UNIX
sockets as an edge in a directed graph.

Here, we introduce a new struct unix_vertex representing a vertex
in the graph and add it to struct unix_sock.

In the following patch, we will allocate another struct per edge,
which we finally link to the inflight socket's unix_vertex.edges
when sendmsg() succeeds.

The first time an AF_UNIX socket is passed successfully, we will
link its unix_vertex.entry to a global list.

Also, we will count the number of edges as unix_vertex.out_degree.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 8 ++++++++
 net/unix/af_unix.c    | 1 +
 net/unix/garbage.c    | 9 +++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 627ea8e2d915..664f6bff60ab 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -22,9 +22,16 @@ extern unsigned int unix_tot_inflight;
 
 void unix_inflight(struct user_struct *user, struct file *fp);
 void unix_notinflight(struct user_struct *user, struct file *fp);
+void unix_init_vertex(struct unix_sock *u);
 void unix_gc(void);
 void wait_for_unix_gc(struct scm_fp_list *fpl);
 
+struct unix_vertex {
+	struct list_head edges;
+	struct list_head entry;
+	unsigned long out_degree;
+};
+
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
@@ -62,6 +69,7 @@ struct unix_sock {
 	struct path		path;
 	struct mutex		iolock, bindlock;
 	struct sock		*peer;
+	struct unix_vertex	vertex;
 	struct list_head	link;
 	unsigned long		inflight;
 	spinlock_t		lock;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 4892e9428c9f..ae145b6f77d8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -996,6 +996,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	u->path.dentry = NULL;
 	u->path.mnt = NULL;
 	spin_lock_init(&u->lock);
+	unix_init_vertex(u);
 	INIT_LIST_HEAD(&u->link);
 	mutex_init(&u->iolock); /* single task reading lock */
 	mutex_init(&u->bindlock); /* single task binding lock */
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9b8473dd79a4..db9ac289ce08 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,15 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+void unix_init_vertex(struct unix_sock *u)
+{
+	struct unix_vertex *vertex = &u->vertex;
+
+	vertex->out_degree = 0;
+	INIT_LIST_HEAD(&vertex->edges);
+	INIT_LIST_HEAD(&vertex->entry);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


