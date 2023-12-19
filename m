Return-Path: <netdev+bounces-58760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F3818004
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 04:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990D11C22AAD
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAD1FDD;
	Tue, 19 Dec 2023 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FGh9qJVh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD334402
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702955013; x=1734491013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NqnB9kDoDNcjyVQpoPAUo2ElKx5LauqFeW66x8W/aDk=;
  b=FGh9qJVhU6lTBzcqla6aw7tb4GfXmz3NEPvtZbzrTwgcf934nQde24y8
   CL4xHzC5LxVfmTJkXFCzBoEOKmxXuJden39qWKL2Oairg/8xPWTgAX2HY
   mYAGgBmM5eDeOkWXXjxQjmk3bKaetkv6CKOjfVxY9vGiItcjrCJhtg3kt
   w=;
X-IronPort-AV: E=Sophos;i="6.04,287,1695686400"; 
   d="scan'208";a="52205665"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:03:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 04A9B40D97;
	Tue, 19 Dec 2023 03:03:17 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:33408]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id 4f5ad583-6813-4c09-9a1a-a6267f932ab6; Tue, 19 Dec 2023 03:03:17 +0000 (UTC)
X-Farcaster-Flow-ID: 4f5ad583-6813-4c09-9a1a-a6267f932ab6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 03:03:17 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 03:03:13 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 4/4] af_unix: Try to run GC async.
Date: Tue, 19 Dec 2023 12:01:02 +0900
Message-ID: <20231219030102.27509-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219030102.27509-1-kuniyu@amazon.com>
References: <20231219030102.27509-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist and the garbage
collector is not running, unix_(dgram|stream)_sendmsg() call unix_gc().
Also, they wait for unix_gc() to complete.

In unix_gc(), all inflight AF_UNIX sockets are traversed at least once,
and more if they are the GC candidate.  Thus, sendmsg() significantly
slows down with too many inflight AF_UNIX sockets.

However, if a process sends data with no AF_UNIX FD, the sendmsg() call
does not need to wait for GC.  After this change, only the process that
meets the condition below will be blocked under such a situation.

  1) cmsg contains AF_UNIX socket
  2) more than 32 AF_UNIX sent by the same user are still inflight

Note that even a sendmsg() call that does not meet the condition but has
AF_UNIX FD will be blocked later in unix_scm_to_skb() by the spinlock,
but we allow that as a bonus for sane users.

The results below are the time spent in unix_dgram_sendmsg() sending 1
byte of data with no FD 4096 times on a host where 32K inflight AF_UNIX
sockets exist.

Without series: the sane sendmsg() needs to wait gc unreasonably.

  $ sudo /usr/share/bcc/tools/funclatency -p 11165 unix_dgram_sendmsg
  Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
  ^C
       nsecs               : count     distribution
  [...]
      524288 -> 1048575    : 0        |                                        |
     1048576 -> 2097151    : 3881     |****************************************|
     2097152 -> 4194303    : 214      |**                                      |
     4194304 -> 8388607    : 1        |                                        |

  avg = 1825567 nsecs, total: 7477526027 nsecs, count: 4096

With series: the sane sendmsg() can finish much faster.

  $ sudo /usr/share/bcc/tools/funclatency -p 8702  unix_dgram_sendmsg
  Tracing 1 functions for "unix_dgram_sendmsg"... Hit Ctrl-C to end.
  ^C
       nsecs               : count     distribution
  [...]
         128 -> 255        : 0        |                                        |
         256 -> 511        : 4092     |****************************************|
         512 -> 1023       : 2        |                                        |
        1024 -> 2047       : 0        |                                        |
        2048 -> 4095       : 0        |                                        |
        4096 -> 8191       : 1        |                                        |
        8192 -> 16383      : 1        |                                        |

  avg = 410 nsecs, total: 1680510 nsecs, count: 4096

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  2 +-
 include/net/scm.h     |  1 +
 net/core/scm.c        |  5 +++++
 net/unix/af_unix.c    |  6 ++++--
 net/unix/garbage.c    | 10 +++++++++-
 5 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 2c98ef95017b..189e71c93a03 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -13,7 +13,7 @@ void unix_notinflight(struct user_struct *user, struct file *fp);
 void unix_destruct_scm(struct sk_buff *skb);
 void io_uring_destruct_scm(struct sk_buff *skb);
 void unix_gc(void);
-void wait_for_unix_gc(void);
+void wait_for_unix_gc(struct scm_fp_list *fpl);
 struct unix_sock *unix_get_socket(struct file *filp);
 struct sock *unix_peer_get(struct sock *sk);
 
diff --git a/include/net/scm.h b/include/net/scm.h
index e8c76b4be2fe..1ff6a2855064 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -24,6 +24,7 @@ struct scm_creds {
 
 struct scm_fp_list {
 	short			count;
+	short			count_unix;
 	short			max;
 	struct user_struct	*user;
 	struct file		*fp[SCM_MAX_FD];
diff --git a/net/core/scm.c b/net/core/scm.c
index 7dc47c17d863..6341e56daedb 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -36,6 +36,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -111,6 +112,10 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 		}
 		*fpp++ = file;
 		fpl->count++;
+#if IS_ENABLED(CONFIG_UNIX)
+		if (unix_get_socket(file))
+			fpl->count_unix++;
+#endif
 	}
 
 	if (!fpl->user)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1e9378036dcc..1720419d93d6 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1923,11 +1923,12 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	long timeo;
 	int err;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags&MSG_OOB)
 		goto out;
@@ -2199,11 +2200,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	bool fds_sent = false;
 	int data_len;
 
-	wait_for_unix_gc();
 	err = scm_send(sock, msg, &scm, false);
 	if (err < 0)
 		return err;
 
+	wait_for_unix_gc(scm.fp);
+
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 0dba36b0bb95..bf13357cc713 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -185,8 +185,9 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 
 static bool gc_in_progress;
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
 
-void wait_for_unix_gc(void)
+void wait_for_unix_gc(struct scm_fp_list *fpl)
 {
 	/* If number of inflight sockets is insane,
 	 * force a garbage collect right now.
@@ -200,6 +201,13 @@ void wait_for_unix_gc(void)
 		queue_work(system_unbound_wq, &unix_gc_work);
 	}
 
+	/* Penalise users who want to send AF_UNIX sockets
+	 * but whose sockets have not been received yet.
+	 */
+	if (!fpl || !fpl->count_unix ||
+	    READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+		return;
+
 	if (READ_ONCE(gc_in_progress))
 		flush_work(&unix_gc_work);
 }
-- 
2.30.2


