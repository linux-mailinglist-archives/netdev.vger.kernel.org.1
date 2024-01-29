Return-Path: <netdev+bounces-66850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B02841302
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A45C028458A
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579BA1EB42;
	Mon, 29 Jan 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="N7b5Q+H2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FF1E53A
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555118; cv=none; b=KO+e+E/XQPgKh/uJW+HqwhtSCtCIk+nEZci6cH/+lvE/zjtIQ/Bsp37BkOcrVpj6/XkBF+O3CwuKuFmbAnkKe+8R+IjtAfZ8sYDMMWT8XDN+fmB3MIy9OEQwbgWtd85gVJalF6UfittxORea1ckH7iG2jHRIglwwGvNLanhh+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555118; c=relaxed/simple;
	bh=l2K/XP1LdQqZt63RxEKBPTgMvCldISf07kgjjcLcc5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKHyWlf1r8DfFKjXt5W7aQktUdnt41aIIPb8gkuezu2zLcXQOd088aRymOkOD+rnrbYjYYtt272oaRwaBVwrK24e2rg4PRpDESdUhRk6Un1E7OPEugKwWA93zFB4BnyEYehSHjIMWZgYMpzZd8ipDQfIGaF/ddG9Htn8qcirH7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=N7b5Q+H2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706555116; x=1738091116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LaS4EizUAbZv3kpVKKVchDO2MZDVueYrOyrJy0GBc4E=;
  b=N7b5Q+H2fhWHH2Zoyx0TEdWakpzydb3xG1tBRtMm6eT5JcWixlQoXVSB
   FsT8FC8oyt99ruc5GvErKeR3mOlWWxQYh5RA8nf8C272P0Sz4xsw3SS8J
   BAQ+LxvGjk3CIowI0NIbeR73UfcZw2lZyFNA5WbQ5NthHtTeBpKzssh96
   o=;
X-IronPort-AV: E=Sophos;i="6.05,227,1701129600"; 
   d="scan'208";a="62008087"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:05:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id 3705940BD2;
	Mon, 29 Jan 2024 19:05:14 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:30725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.50:2525] with esmtp (Farcaster)
 id 74b4dae0-e082-46b9-a60f-d765d59c5f5f; Mon, 29 Jan 2024 19:05:13 +0000 (UTC)
X-Farcaster-Flow-ID: 74b4dae0-e082-46b9-a60f-d765d59c5f5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:05:13 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 29 Jan 2024 19:05:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/3] af_unix: Replace BUG_ON() with WARN_ON_ONCE().
Date: Mon, 29 Jan 2024 11:04:33 -0800
Message-ID: <20240129190435.57228-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240129190435.57228-1-kuniyu@amazon.com>
References: <20240129190435.57228-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

This is a prep patch for the last patch in this series so that
checkpatch will not warn about BUG_ON().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 8 ++++----
 net/unix/scm.c     | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 4046c606f0e6..af676bb8fb67 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -145,7 +145,7 @@ static void scan_children(struct sock *x, void (*func)(struct unix_sock *),
 			/* An embryo cannot be in-flight, so it's safe
 			 * to use the list link.
 			 */
-			BUG_ON(!list_empty(&u->link));
+			WARN_ON_ONCE(!list_empty(&u->link));
 			list_add_tail(&u->link, &embryos);
 		}
 		spin_unlock(&x->sk_receive_queue.lock);
@@ -213,8 +213,8 @@ static void __unix_gc(struct work_struct *work)
 
 		total_refs = file_count(u->sk.sk_socket->file);
 
-		BUG_ON(!u->inflight);
-		BUG_ON(total_refs < u->inflight);
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(total_refs < u->inflight);
 		if (total_refs == u->inflight) {
 			list_move_tail(&u->link, &gc_candidates);
 			__set_bit(UNIX_GC_CANDIDATE, &u->gc_flags);
@@ -294,7 +294,7 @@ static void __unix_gc(struct work_struct *work)
 		list_move_tail(&u->link, &gc_inflight_list);
 
 	/* All candidates should have been detached by now. */
-	BUG_ON(!list_empty(&gc_candidates));
+	WARN_ON_ONCE(!list_empty(&gc_candidates));
 
 	/* Paired with READ_ONCE() in wait_for_unix_gc(). */
 	WRITE_ONCE(gc_in_progress, false);
diff --git a/net/unix/scm.c b/net/unix/scm.c
index b5ae5ab16777..505e56cf02a2 100644
--- a/net/unix/scm.c
+++ b/net/unix/scm.c
@@ -51,10 +51,10 @@ void unix_inflight(struct user_struct *user, struct file *fp)
 
 	if (u) {
 		if (!u->inflight) {
-			BUG_ON(!list_empty(&u->link));
+			WARN_ON_ONCE(!list_empty(&u->link));
 			list_add_tail(&u->link, &gc_inflight_list);
 		} else {
-			BUG_ON(list_empty(&u->link));
+			WARN_ON_ONCE(list_empty(&u->link));
 		}
 		u->inflight++;
 		/* Paired with READ_ONCE() in wait_for_unix_gc() */
@@ -71,8 +71,8 @@ void unix_notinflight(struct user_struct *user, struct file *fp)
 	spin_lock(&unix_gc_lock);
 
 	if (u) {
-		BUG_ON(!u->inflight);
-		BUG_ON(list_empty(&u->link));
+		WARN_ON_ONCE(!u->inflight);
+		WARN_ON_ONCE(list_empty(&u->link));
 
 		u->inflight--;
 		if (!u->inflight)
-- 
2.30.2


