Return-Path: <netdev+bounces-87592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544D28A3A73
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 04:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0570A281BFD
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 02:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A7B10A19;
	Sat, 13 Apr 2024 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NyNW4Goh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44C3233
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712974788; cv=none; b=CGW8bdMtNh64gBPlejyZ2PTVJgnHb1Oly5cIQYzhhbGmu+ca+86p6lxtj54fG5v6Vpu09ciAm2bJGeZ2/ZYcoRKfnlECDySnZDgEcoA/g/csXMoQJFF3TrKVltpkBCZvTLIfcJlTtICrpRBaWkSlV9JNmja2IKcf15c17ZyVvGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712974788; c=relaxed/simple;
	bh=0OGH10wiYpf2AZI/uqfG/JA3Vi5gVziKMwrMV6O1F+M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pfviqJKy1q7hY35Ym2EavyzfqhaJkoojArIeW0aMa5NVR0LU3TxN+j9RtWBHN9ZJJhza4GOD1F4zgYDmTXaLSvDwAR0mD1Gy1fOiUYvbCW5vocQ14V+cTRIWXDWy5matNkrV0zUFXQoAPWxlA2dxXlg2ZbFm/Y1AFYIWg20M0e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NyNW4Goh; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712974787; x=1744510787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JdQCmdaLWrwxdL4kaJ9YAzFHVQXwi91EPJGsuy4SwDQ=;
  b=NyNW4GohOH+lJdV20rRA3zSJGXShHHxuoYEXWnFKYRUFdQnaIw6QYuMG
   ijnL7rP/UTE8IH3+7GFtU2S5/h0wlBfV8UahXK+6EJcfKQI/CCjBjM5Vm
   fR7mBjCa7Gm/hq8ibmJTuTegBUNd1K5sPv7crinnXvEPniQU0BXG3GTqm
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,198,1708387200"; 
   d="scan'208";a="411230528"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2024 02:19:42 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:32403]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.40:2525] with esmtp (Farcaster)
 id bb3885be-83a0-4812-bc7b-ad29838789b7; Sat, 13 Apr 2024 02:19:40 +0000 (UTC)
X-Farcaster-Flow-ID: bb3885be-83a0-4812-bc7b-ad29838789b7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 13 Apr 2024 02:19:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 13 Apr 2024 02:19:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, kernel test robot
	<oliver.sang@intel.com>
Subject: [PATCH v2 net-next] af_unix: Try not to hold unix_gc_lock during accept().
Date: Fri, 12 Apr 2024 19:19:28 -0700
Message-ID: <20240413021928.20946-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit dcf70df2048d ("af_unix: Fix up unix_edge.successor for embryo
socket.") added spin_lock(&unix_gc_lock) in accept() path, and it
caused regression in a stress test as reported by kernel test robot.

If the embryo socket is not part of the inflight graph, we need not
hold the lock.

To decide that in O(1) time and avoid the regression in the normal
use case,

  1. add a new stat unix_sk(sk)->scm_stat.nr_unix_fds

  2. count the number of inflight AF_UNIX sockets in the receive
     queue under unix_state_lock()

  3. move unix_update_edges() call under unix_state_lock()

  4. avoid locking if nr_unix_fds is 0 in unix_update_edges()

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202404101427.92a08551-oliver.sang@intel.com
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 +
 net/unix/af_unix.c    |  2 +-
 net/unix/garbage.c    | 20 ++++++++++++++++----
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 7311b77edfc7..872ff2a50372 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -67,6 +67,7 @@ struct unix_skb_parms {
 
 struct scm_stat {
 	atomic_t nr_fds;
+	unsigned long nr_unix_fds;
 };
 
 #define UNIXCB(skb)	(*(struct unix_skb_parms *)&((skb)->cb))
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 142d210b5b03..ed16d5f66df8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1719,12 +1719,12 @@ static int unix_accept(struct socket *sock, struct socket *newsock, int flags,
 	}
 
 	tsk = skb->sk;
-	unix_update_edges(unix_sk(tsk));
 	skb_free_datagram(sk, skb);
 	wake_up_interruptible(&unix_sk(sk)->peer_wait);
 
 	/* attach accepted sock to socket */
 	unix_state_lock(tsk);
+	unix_update_edges(unix_sk(tsk));
 	newsock->state = SS_CONNECTED;
 	unix_sock_inherit_flags(sock, newsock);
 	sock_graft(tsk, newsock);
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 12a4ec27e0d4..95240a59808f 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -209,6 +209,7 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		unix_add_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	receiver->scm_stat.nr_unix_fds += fpl->count_unix;
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
@@ -222,6 +223,7 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 
 void unix_del_edges(struct scm_fp_list *fpl)
 {
+	struct unix_sock *receiver;
 	int i = 0;
 
 	spin_lock(&unix_gc_lock);
@@ -235,6 +237,8 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	receiver = fpl->edges[0].successor;
+	receiver->scm_stat.nr_unix_fds -= fpl->count_unix;
 	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
 	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
@@ -246,10 +250,18 @@ void unix_del_edges(struct scm_fp_list *fpl)
 
 void unix_update_edges(struct unix_sock *receiver)
 {
-	spin_lock(&unix_gc_lock);
-	unix_update_graph(unix_sk(receiver->listener)->vertex);
-	receiver->listener = NULL;
-	spin_unlock(&unix_gc_lock);
+	/* nr_unix_fds is only updated under unix_state_lock().
+	 * If it's 0 here, the embryo socket is not part of the
+	 * inflight graph, and GC will not see it, so no lock needed.
+	 */
+	if (!receiver->scm_stat.nr_unix_fds) {
+		receiver->listener = NULL;
+	} else {
+		spin_lock(&unix_gc_lock);
+		unix_update_graph(unix_sk(receiver->listener)->vertex);
+		receiver->listener = NULL;
+		spin_unlock(&unix_gc_lock);
+	}
 }
 
 int unix_prepare_fpl(struct scm_fp_list *fpl)
-- 
2.30.2


