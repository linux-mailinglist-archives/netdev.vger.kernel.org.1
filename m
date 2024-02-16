Return-Path: <netdev+bounces-72529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAC8587A3
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE231C26277
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638A12CDBC;
	Fri, 16 Feb 2024 21:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mfst4j5V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00F28E2B
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117618; cv=none; b=vBEh36H/U661l1PgjHaGLrs5YYd9tXhZhyivvZU2IFAee3Y4yqrXVVw/YbxhBdg1zDnycDOzLv+9KqeHK2gQtqBnrz1BJiE+9z0Y4j0ULoOhojcaT1ISNbxQIftNDpdvJ5HdUvCBABkDVwnAbSNml3GNqS03YGPEBkjEKzkH+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117618; c=relaxed/simple;
	bh=yCXsbPuUXSWnmyP68qIAls9pEc09WtzRY8NsAaCIozs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqBwkSNHs4I3IOfNq1KbuWGWdav0DrjsMet2t5H+Yh5pGlThV7eGb5MYiJpNTJD/SElaRoEBAPxEuWKFb6LblQRGLEypK/8h/dth4sFF17yOQ0scgaoyS9qYVqvoZ82XWwa1i0reco/DWC0nL5lUjI/+EmLX0G3hQgoK18Gahak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mfst4j5V; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117617; x=1739653617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e1P2JASlBZPYvR82g/gWgcenHoE/0XMLa9Yu6hd7l78=;
  b=mfst4j5VtHyI8epINNwJNgpIv0P58az2j68LfnMhrhK47jK3oBea4BtB
   iG8+6w1HQT2e7mk1MC0OiR/4Chvr1RT6J2roxKP0irVAHOjbJj8lEL9hV
   +Ci4iKrJgblXqJbetNDRvembeGERANqJoZ7EZRXhOTXay0LjWTmLOArao
   Y=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="381672608"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:06:54 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:54078]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.175:2525] with esmtp (Farcaster)
 id d12ed02c-d34f-462e-b9dc-2b26ac436b34; Fri, 16 Feb 2024 21:06:52 +0000 (UTC)
X-Farcaster-Flow-ID: d12ed02c-d34f-462e-b9dc-2b26ac436b34
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:06:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:06:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/14] af_unix: Add struct unix_vertex in struct unix_sock.
Date: Fri, 16 Feb 2024 13:05:43 -0800
Message-ID: <20240216210556.65913-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will replace the garbage collection algorithm for AF_UNIX,
where we will consider each inflight file descriptor of AF_UNIX
sockets as an edge in a directed graph.

Here, we introduce a new struct unix_vertex representing a vertex
in the graph and add it to struct unix_sock.

In the following patch, we will allocate another struct per edge,
which we finally link to the inflight socket's unix_vertex.edges
when sendmsg() succeeds.

Also, we will count the number of edges as unix_vertex.out_degree.

The first time an AF_UNIX socket is passed successfully, we will
link its unix_vertex.entry to a global list.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 8 ++++++++
 net/unix/af_unix.c    | 1 +
 net/unix/garbage.c    | 8 ++++++++
 3 files changed, 17 insertions(+)

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
index 51acf795f096..6a71997ac67a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -101,6 +101,14 @@ struct unix_sock *unix_get_socket(struct file *filp)
 	return NULL;
 }
 
+void unix_init_vertex(struct unix_sock *u)
+{
+	struct unix_vertex *vertex = &u->vertex;
+
+	vertex->out_degree = 0;
+	INIT_LIST_HEAD(&vertex->edges);
+}
+
 DEFINE_SPINLOCK(unix_gc_lock);
 unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
-- 
2.30.2


