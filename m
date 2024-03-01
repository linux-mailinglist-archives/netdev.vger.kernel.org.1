Return-Path: <netdev+bounces-76401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBB86D9B0
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 03:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F45C1F22556
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F7A3A8D2;
	Fri,  1 Mar 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bufeeEmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681722B9A8
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709259885; cv=none; b=NBysmvqCyOm0y6VFKp7QYtxuEGN48oIFfy6nsU6ws3AtNOv26uB8Be2XYUFYyKWR8nOz5QIfTSoHMoOBlKJXU5KjhuyzlkLjyCov+ZtlJcHa/AVvzrjRi/6zya7TzKs4PfkH/Kwkjjj5cWnEeWQ62bnnzSsW5FLA2iZ/+dGiikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709259885; c=relaxed/simple;
	bh=RrrkbnJ8j9faRNlMqUvJ4cKRPZHzubkW90VXR+n9f5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTjFut3QWQ6JX3lXhDippLfv4Ho36hVaVzk5yPFgmTd+f4Q63vSSVv+r6PnxsunmMd9ecpmlCrMN2TvHMNq+LKhZZ11m77SX/5mH+CGMWekPhyaS1NQFMNkygwW5o0FahGHgGcwvbEdbDauxbbVj4fDQmkGz4W87exHHA6aaJtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bufeeEmD; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709259884; x=1740795884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ijyoOVzvkQmDmVQzGC69VWdIjFlPPcoVQQsg3Gm2rOQ=;
  b=bufeeEmDu1fZucpG2r5D96zpiNSuYS15wIIjBzJbjcevJXy4BUHnn4vJ
   4lEHsQo1L5t6wQ6P5IoU9m/XRR/skNaJ/r8RvxxUth+YTZUlfC9Sb3JAB
   LtkQDb9+YjEP71cB88KG9mdXkp/mARGBXg6NO1iyh1+/Sy9Ktc8qRhETa
   o=;
X-IronPort-AV: E=Sophos;i="6.06,194,1705363200"; 
   d="scan'208";a="637804091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 02:24:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:6707]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id eb7abef9-0c26-45b4-be9f-5daf5e2a93e8; Fri, 1 Mar 2024 02:24:40 +0000 (UTC)
X-Farcaster-Flow-ID: eb7abef9-0c26-45b4-be9f-5daf5e2a93e8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:24:39 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 1 Mar 2024 02:24:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 04/15] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Thu, 29 Feb 2024 18:22:32 -0800
Message-ID: <20240301022243.73908-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, we track the number of inflight sockets in two variables.
unix_tot_inflight is the total number of inflight AF_UNIX sockets on
the host, and user->unix_inflight is the number of inflight fds per
user.

We update them one by one in unix_inflight(), which can be done once
in batch.  Also, sendmsg() could fail even after unix_inflight(), then
we need to acquire unix_gc_lock only to decrement the counters.

Let's bulk update the counters in unix_add_edges() and unix_del_edges(),
which is called only for successfully passed fds.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/garbage.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 36d665936096..84c8ea524a98 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -144,6 +144,7 @@ static void unix_free_vertices(struct scm_fp_list *fpl)
 }
 
 DEFINE_SPINLOCK(unix_gc_lock);
+unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -168,7 +169,10 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 		unix_add_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
 out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = true;
@@ -191,7 +195,10 @@ void unix_del_edges(struct scm_fp_list *fpl)
 		unix_del_edge(fpl, edge);
 	} while (i < fpl->count_unix);
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
 out:
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = false;
@@ -234,7 +241,6 @@ void unix_destroy_fpl(struct scm_fp_list *fpl)
 	unix_free_vertices(fpl);
 }
 
-unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -255,13 +261,8 @@ void unix_inflight(struct user_struct *user, struct file *filp)
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
 
@@ -278,13 +279,8 @@ void unix_notinflight(struct user_struct *user, struct file *filp)
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


