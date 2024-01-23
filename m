Return-Path: <netdev+bounces-65160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8917F839609
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378AE28B511
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA227FBB2;
	Tue, 23 Jan 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BOD5gV4/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F407F7F6
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029832; cv=none; b=QtQu5DGHWBlBZZx8Lh5Z+1sHGkX4g1QZxkYImTEubYfO9bF2aHBWF2RQ52HHSX5ogCYPMTMddweKyTzLeqzviw91A+s1Axwy9AeFU8jtQ7tZZ3LIfFYDFXM4h9HzPJ6n0E1/QTdmDHKsx49n61MkOgpSG6g1TYeYRPO28QvRw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029832; c=relaxed/simple;
	bh=IZlNcmro5jRU8tfss8l4kcikYKFr3QcGzVLjy+bV/Vg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFjrFcvTioJ3hHqQNE6TsZb7SdmDx2+SUSc3gbhpJW597LiJ2Vzy4SWy1LqXepm6myCYz6bsWdpDFxmY2rhaKir3mNRiurlW9ahET9482wW7JmYI/JMMxTmG0kicHM1vX4QEvVLIf9f3rQyfOaQsT18+vC8TgnttbdM5itxmy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BOD5gV4/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706029832; x=1737565832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sTBeqlEVuf9EHtcJ4hxm171+iqZwMxe8f79dl6N03uQ=;
  b=BOD5gV4/o6R0LcvCfWRjngpUQCBt7hJPSfMzp1Yq5ITXJigzAnS/8HNQ
   QvXwbmNO8TVHHJvrgbSrGwYWwEcryFxxl+MxuY6hSEt03m1jzro3M5CoV
   yMUK3P5uWmyiluh06TSYLpCqJ0p0TCEQNVZRhrTKset49Et+SMaLOJro+
   w=;
X-IronPort-AV: E=Sophos;i="6.05,214,1701129600"; 
   d="scan'208";a="391940884"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:10:26 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id CB24D40D6F;
	Tue, 23 Jan 2024 17:10:24 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:21554]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.126:2525] with esmtp (Farcaster)
 id d1630c5e-5c33-4a8b-800b-2af9780728fb; Tue, 23 Jan 2024 17:10:24 +0000 (UTC)
X-Farcaster-Flow-ID: d1630c5e-5c33-4a8b-800b-2af9780728fb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:10:23 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:10:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Pavel
 Begunkov" <asml.silence@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH v5 net-next 3/5] af_unix: Return struct unix_sock from unix_get_socket().
Date: Tue, 23 Jan 2024 09:08:54 -0800
Message-ID: <20240123170856.41348-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240123170856.41348-1-kuniyu@amazon.com>
References: <20240123170856.41348-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Currently, unix_get_socket() returns struct sock, but after calling
it, we always cast it to unix_sk().

Let's return struct unix_sock from unix_get_socket().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 include/net/af_unix.h |  2 +-
 net/unix/garbage.c    | 19 +++++++------------
 net/unix/scm.c        | 19 +++++++------------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index ac38b63db554..2c98ef95017b 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -14,7 +14,7 @@ void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
 void wait_for_unix_gc(void);
-struct sock *unix_get_socket(struct file *filp);
+struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
 #define UNIX_HASH_MOD	(256 - 1)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 051f96a3ab02..d5ef46a75f1f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -105,20 +105,15 @@ static void scan_inflight(struct sock *x, void (*func)(struct unix_sock *),
 
 			while (nfd--) {
 				/* Get the socket the fd matches if it indeed does so */
-				struct sock *sk = unix_get_socket(*fp++);
+				struct unix_sock *u = unix_get_socket(*fp++);
 
-				if (sk) {
-					struct unix_sock *u = unix_sk(sk);
+				/* Ignore non-candidates, they could have been added
+				 * to the queues after starting the garbage collection
+				 */
+				if (u && test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
+					hit = true;
 
-					/* Ignore non-candidates, they could
-					 * have been added to the queues after
-					 * starting the garbage collection
-					 */
-					if (test_bit(UNIX_GC_CANDIDATE, &u->gc_flags)) {
-						hit = true;
-
-						func(u);
-					}
+					func(u);
 				}
 			}
 			if (hit && hitlist != NULL) {
diff --git a/net/unix/scm.c b/net/unix/scm.c
index e92f2fad6410..b5ae5ab16777 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -21,9 +21,8 @@ EXPORT_SYMBOL(gc_inflight_list);
 DEFINE_SPINLOCK(unix_gc_lock);
 EXPORT_SYMBOL(unix_gc_lock);
 
-struct sock *unix_get_socket(struct file *filp)
+struct unix_sock *unix_get_socket(struct file *filp)
 {
-	struct sock *u_sock = NULL;
 	struct inode *inode = file_inode(filp);
 
 	/* Socket ? */
@@ -34,10 +33,10 @@ struct sock *unix_get_socket(struct file *filp)
 
 		/* PF_UNIX ? */
 		if (s && ops && ops->family == PF_UNIX)
-			u_sock = s;
+			return unix_sk(s);
 	}
 
-	return u_sock;
+	return NULL;
 }
 EXPORT_SYMBOL(unix_get_socket);
 
@@ -46,13 +45,11 @@ EXPORT_SYMBOL(unix_get_socket);
  */
 void unix_inflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		if (!u->inflight) {
 			BUG_ON(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
@@ -69,13 +66,11 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
 void unix_notinflight(struct user_struct *user, struct file *fp)
 {
-	struct sock *s = unix_get_socket(fp);
+	struct unix_sock *u = unix_get_socket(fp);
 
 	spin_lock(&unix_gc_lock);
 
-	if (s) {
-		struct unix_sock *u = unix_sk(s);
-
+	if (u) {
 		BUG_ON(!u->inflight);
 		BUG_ON(list_empty(&u->link));
 
-- 
2.30.2


