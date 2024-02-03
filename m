Return-Path: <netdev+bounces-68762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CB847FCB
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E3F028511A
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA457464;
	Sat,  3 Feb 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CEiV1DI9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E097482
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929429; cv=none; b=LLdPD0Yl/5/HowMs92s9IknwPW6cj75dRXFFvA1E6eoh2CeHFsWsmdZLyLlxYGJYu3MV28ZwsLRAXAUC0/KjoS7TsHTVM1NZloeA9nDLeRO7O+ajQNoLss2P6LTvaNyONaJNouuXmIBX3kH+MgQVvSCMRNYFQca7VDeqQNicVcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929429; c=relaxed/simple;
	bh=41ifp7j03N60vyWNqBum8ftvtNxqVgfoh9Xtofje0mQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnbfO+gbEANKiprNiyHwha5uj6efcFF5TAHRJe2G4nTQxaF3hv8c9/or6ddnbOg6yTaOHlcLD0uE3CotRAwjgzJyZpyIADeOFvZqmi1nQrFUSLtosbFNHOlS4XmxS1xHB3Eb646l44s71dHr6+rwymsMMTXHY9abN7vXU7+MGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CEiV1DI9; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929428; x=1738465428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oq8BUtQaSCM1Hr1NSt2x1vjxMxj8olB4fUXChQhXVJ0=;
  b=CEiV1DI9SJGn+9PmoJaX9ImkNhawrVZYn0t6p0p459s1P/OWWUASB5Oq
   Gz1wXptDbacAtJBzI7+BNTDjcOrZCjs5QZnziX4RCeFWSewezxE629GGQ
   H7rsQc9yo2uiy/drSuVKpDD7wwHEct46AQgTcH5QqHf6nCri6s9ba+5o+
   4=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="384065006"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:03:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:42719]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.239:2525] with esmtp (Farcaster)
 id d1dcd60b-2700-43c4-815e-8a71cae991b5; Sat, 3 Feb 2024 03:03:44 +0000 (UTC)
X-Farcaster-Flow-ID: d1dcd60b-2700-43c4-815e-8a71cae991b5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:03:42 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Sat, 3 Feb 2024 03:03:40 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/16] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Fri, 2 Feb 2024 19:00:48 -0800
Message-ID: <20240203030058.60750-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, we track the number of inflight sockets in two variables.
unix_tot_inflight is the total number of inflight AF_UNIX sockets on
the host, and user->unix_inflight is the number of inflight fds per
user.

We update them one by one in unix_inflight(), which can be done once
in batch.  Also, sendmsg() could fail even after unix_inflight(), then
we need to acquire unix_gc_lock only to decrease the counters.

Let's bulk update the counters in unix_add_edges() and unix_del_edges(),
which is called only for successfully passed fds.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index d731438d3c2b..42ed886c75d1 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -112,6 +112,7 @@ void unix_init_vertex(struct unix_sock *u)
 
 DEFINE_SPINLOCK(unix_gc_lock);
 static LIST_HEAD(unix_unvisited_vertices);
+unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -148,6 +149,9 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		}
 	}
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = true;
@@ -168,6 +172,9 @@ void unix_del_edges(struct scm_fp_list *fpl)
 			list_del_init(&edge->predecessor->entry);
 	}
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = false;
@@ -210,7 +217,6 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
-unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -231,13 +237,8 @@ void unix_inflight(struct user_struct *user, struct file *filp)
 			WARN_ON_ONCE(list_empty(&u->link));
 		}
 		u->inflight++;
-
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + 1);
 	}
 
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight + 1);
-
 	spin_unlock(&unix_gc_lock);
 }
 
@@ -254,13 +255,8 @@ void unix_notinflight(struct user_struct *user, struct file *filp)
 		u->inflight--;
 		if (!u->inflight)
 			list_del_init(&u->link);
-
-		/* Paired with READ_ONCE() in wait_for_unix_gc() */
-		WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - 1);
 	}
 
-	WRITE_ONCE(user->unix_inflight, user->unix_inflight - 1);
-
 	spin_unlock(&unix_gc_lock);
 }
 
-- 
2.30.2


