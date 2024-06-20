Return-Path: <netdev+bounces-105459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DA09113F4
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456EB1C21135
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9750A757E3;
	Thu, 20 Jun 2024 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ko4YbCSW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01AFB65D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917146; cv=none; b=fFob3zCEc9Fk0RgrpuVuUIh7XsMmU93lT3yj8B/0+JuQMZV3FqChdnPZSC97DOfKmC5QdevFgH2GqaE+Yok8AyjjDzZWyg8ObCfSiRjSDVSlUVWl5BbPNEx0+PhsyJZg/O8lXVgiidvYTBQzSYUcg3+xoDaBy4w4r9WOINbRbz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917146; c=relaxed/simple;
	bh=gPX57Ew5+GBcvnxHftF4he2Y7rnUkrK+5E/idZG+fmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UG3tKq2M0bX1w/4AboGNq46MGqQ12QXcemyAODdU37otdm7OSkGcvRPpoX1KWom303I/K1iyQccXq/Rht4CdInqj+z0q94W17ZUaGmTG0MVtjdaFaHR67GPOsFwLOXhhYpJjMtsMyjotGk7hczGsoSJY+JZz8OTw+2H+mDTY+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ko4YbCSW; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917145; x=1750453145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXTssWzGPt4rcNnM+Sd0i1owQ04i5fO2rjnzYMMAroE=;
  b=Ko4YbCSWecl6J6idRfNELGmYs3SSYu3hn+0TL9jnyjT13dcjvJYDpFV+
   RrGYR/KpwJcztHK/NxSXdJY25cVqtQH/GGgfygPSEzOvEFxXe14eVrC3s
   sUwNhjoqk2REtb1YuGFWqpglPNhvb+1nDa12HuZ79mKP/Vbab08+RxPfp
   k=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="404617492"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:59:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:14875]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.208:2525] with esmtp (Farcaster)
 id 209c2450-5f13-4f1d-a0ef-8e2f95535cb3; Thu, 20 Jun 2024 20:59:01 +0000 (UTC)
X-Farcaster-Flow-ID: 209c2450-5f13-4f1d-a0ef-8e2f95535cb3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:59:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:58:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 06/11] af_unix: Remove U_LOCK_DIAG.
Date: Thu, 20 Jun 2024 13:56:18 -0700
Message-ID: <20240620205623.60139-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620205623.60139-1-kuniyu@amazon.com>
References: <20240620205623.60139-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
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


