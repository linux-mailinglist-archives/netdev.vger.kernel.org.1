Return-Path: <netdev+bounces-72534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0A8587B1
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7454E1F210E2
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0BE13AA5A;
	Fri, 16 Feb 2024 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="b+zedVmb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1EF13AA56
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117738; cv=none; b=qZCAaz9WmAbnaRrmHj37lOQi2mh5NY1+enKfQLbxhOLlf+RuCYCX9egQluvlVQEMmw3dYTSJTIdCKFVyHPseVufYIzd07LabhBZVhPkcmPHw7GHfD2BvCVEXZm+K/u+tOzKU8FGl/0B868uQ8xzF3g9xFal36B46eu5sA0uwjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117738; c=relaxed/simple;
	bh=kbf+UNRn7+yrNdYKQBVkwyIZ5N0L1HSNzsNYYomwWYg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iz9hjbYMX3/wGEJSysMvqof4ifB3NtxzSoVAPdF3IHbSbDNuDx7MJD0F4HgvbyV6Tc6yOKkjZ80HLjrhUEIO0VFb2np3fvqS1PBQklpI4Hd0OsuVc7zHygo5AOeqqtY8HjMnUJJBkIQa4o7tt+xosrwlQz1DkmAPDYqMZio2iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=b+zedVmb; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708117737; x=1739653737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gF3AVFQz38FQ9reOmGWGdj1c/AvDdCEFBI5UOcP46AE=;
  b=b+zedVmbNTIrxDppJu3LoX+/6c1TIP/pAyXRi4kaC97J7nOzxNcET9Cx
   cqGzXfzC/VkvM/WJSLMdazRTzuYOi4YUOtyRlxTKFZny1SLfMx5XwJ0Xe
   CErbp24fTVN/5LHWar5RB6mR6imqe9nAgxnW1N9Wh8dLf5USFRASmVkAT
   I=;
X-IronPort-AV: E=Sophos;i="6.06,165,1705363200"; 
   d="scan'208";a="381672989"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 21:08:55 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:24851]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.174:2525] with esmtp (Farcaster)
 id 9c6bc90a-375f-4647-b9e4-2c8fca8c9ed0; Fri, 16 Feb 2024 21:08:54 +0000 (UTC)
X-Farcaster-Flow-ID: 9c6bc90a-375f-4647-b9e4-2c8fca8c9ed0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 16 Feb 2024 21:08:54 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Fri, 16 Feb 2024 21:08:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 06/14] af_unix: Bulk update unix_tot_inflight/unix_inflight when queuing skb.
Date: Fri, 16 Feb 2024 13:05:48 -0800
Message-ID: <20240216210556.65913-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
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
index 97a43f8ec5a5..93d7760e4ab1 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -111,6 +111,7 @@ void unix_init_vertex(struct unix_sock *u)
 
 DEFINE_SPINLOCK(unix_gc_lock);
 static LIST_HEAD(unix_unvisited_vertices);
+unsigned int unix_tot_inflight;
 
 void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 {
@@ -144,6 +145,9 @@ void unix_add_edges(struct scm_fp_list *fpl, struct unix_sock *receiver)
 			list_add_tail(&edge->embryo_entry, &receiver->vertex.edges);
 	}
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight + fpl->count_unix);
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight + fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = true;
@@ -164,6 +168,9 @@ void unix_del_edges(struct scm_fp_list *fpl)
 			list_del_init(&edge->predecessor->entry);
 	}
 
+	WRITE_ONCE(unix_tot_inflight, unix_tot_inflight - fpl->count_unix);
+	WRITE_ONCE(fpl->user->unix_inflight, fpl->user->unix_inflight - fpl->count);
+
 	spin_unlock(&unix_gc_lock);
 
 	fpl->inflight = false;
@@ -206,7 +213,6 @@ void unix_free_edges(struct scm_fp_list *fpl)
 	kvfree(fpl->edges);
 }
 
-unsigned int unix_tot_inflight;
 static LIST_HEAD(gc_candidates);
 static LIST_HEAD(gc_inflight_list);
 
@@ -227,13 +233,8 @@ void unix_inflight(struct user_struct *user, struct file *filp)
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
 
@@ -250,13 +251,8 @@ void unix_notinflight(struct user_struct *user, struct file *filp)
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


