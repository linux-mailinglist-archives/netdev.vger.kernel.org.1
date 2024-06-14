Return-Path: <netdev+bounces-103721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4634E909335
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B381D287C0D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26031A38CD;
	Fri, 14 Jun 2024 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gESeyIuc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2D19D07B
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395808; cv=none; b=s4WnEpHMfHqhUhgboi59XtUaiO3QTgwYZk9i89mu3B3n9g8NQo/AGivFlxyC7VKey1TxbhcD3CZ/SiltDN40W1yT3LUQAzCtx/ffGYa0iFFG4J1l68TB6DZuulcMEwLpGLoO8nq9KHMpW5W3/Ckws8vGNThpUanHGD/ZLBVACnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395808; c=relaxed/simple;
	bh=gPX57Ew5+GBcvnxHftF4he2Y7rnUkrK+5E/idZG+fmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDo6JB7vnZ6kIHSlrl0FE74zB8u1jWHXJaSWEWX9hywVKBElUchSjGjYnaE4IJwFm8UL2vH7Fq/Rf0LCbIHIWD98xfozBobO9HBR/xfQmYJkX4SuRDKJ+MmSejI9XsZpfmdHv+lLg6fDUq9wortj8T8WIdQLUCbU/NxQTArkVmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gESeyIuc; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395807; x=1749931807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXTssWzGPt4rcNnM+Sd0i1owQ04i5fO2rjnzYMMAroE=;
  b=gESeyIucw9ECkDKt0FuLgPRPPh7OqfKx5nwvtUpjCVJbQ0eelZbj79Me
   Uq7AP7DDnT4Rwfph82ZL7ySr+KHaxlDiyIwm7UzwuCWXJ94sVc763UvSL
   /OJ357MgRnbtigoEwHy/5DJMTrchiwuqq3KU2WQRWme/Jmr2iz78sKTkq
   4=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="403412395"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:10:04 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:26208]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.196:2525] with esmtp (Farcaster)
 id 3dd2ac64-4906-420c-a277-ee4dde5a52a0; Fri, 14 Jun 2024 20:10:03 +0000 (UTC)
X-Farcaster-Flow-ID: 3dd2ac64-4906-420c-a277-ee4dde5a52a0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 14 Jun 2024 20:10:02 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:09:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 06/11] af_unix: Remove U_LOCK_DIAG.
Date: Fri, 14 Jun 2024 13:07:10 -0700
Message-ID: <20240614200715.93150-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk_diag_dump_icons() acquires embryo's lock by unix_state_lock_nested()
to fetch its peer.

The embryo's ->peer is set to NULL only when its parent listener is
close()d.  Then, unix_release_sock() is called for each embryo after
unlinking skb by skb_dequeue().

In sk_diag_dump_icons(), we hold the parent's recvq lock, so we need
not acquire unix_state_lock_nested(), and peer is always non-NULL.

Let's remove unnecessary unix_state_lock_nested() and non-NULL test
for peer.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/diag.c       | 17 +++--------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index fd813ad73ab8..c42645199cee 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -98,7 +98,6 @@ struct unix_sock {
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
 enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
-	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
 	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
 			     * candidates to close a small race window.
 			     */
diff --git a/net/unix/diag.c b/net/unix/diag.c
index d2d66727b0da..9138af8b465e 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -73,20 +73,9 @@ static int sk_diag_dump_icons(struct sock *sk, struct sk_buff *nlskb)
 
 		buf = nla_data(attr);
 		i = 0;
-		skb_queue_walk(&sk->sk_receive_queue, skb) {
-			struct sock *req, *peer;
-
-			req = skb->sk;
-			/*
-			 * The state lock is outer for the same sk's
-			 * queue lock. With the other's queue locked it's
-			 * OK to lock the state.
-			 */
-			unix_state_lock_nested(req, U_LOCK_DIAG);
-			peer = unix_sk(req)->peer;
-			buf[i++] = (peer ? sock_i_ino(peer) : 0);
-			unix_state_unlock(req);
-		}
+		skb_queue_walk(&sk->sk_receive_queue, skb)
+			buf[i++] = sock_i_ino(unix_peer(skb->sk));
+
 		spin_unlock(&sk->sk_receive_queue.lock);
 	}
 
-- 
2.30.2


