Return-Path: <netdev+bounces-50336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C88D7F560C
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2731C20B53
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD115A3;
	Thu, 23 Nov 2023 01:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ib+DM5GO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7396EB9
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700704182; x=1732240182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LEtR/52tk6O+ZmqlyI2ty+yaMWBLGgQ8WUnrkUqOlnA=;
  b=ib+DM5GOvWBcrRssNhIt0CmgT5xAB7IkDORJLXSHJpuvRAd+blXxAy02
   xgqw0S4LdsZYaoYUbty5fnOr4ff2jl/q2nWqoph6KW3gWb0XR4pVtWPsI
   +GIqemnUz82pmO+d8d6YS9HAFBlIFyksRFnEEQdZMK5sI+Svj4UKghFV1
   o=;
X-IronPort-AV: E=Sophos;i="6.04,220,1695686400"; 
   d="scan'208";a="254348655"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:49:40 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id F097D492F4;
	Thu, 23 Nov 2023 01:49:37 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:62525]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.2:2525] with esmtp (Farcaster)
 id edcf8e46-9f1b-47b6-a101-b6c0d1c720c6; Thu, 23 Nov 2023 01:49:37 +0000 (UTC)
X-Farcaster-Flow-ID: edcf8e46-9f1b-47b6-a101-b6c0d1c720c6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:49:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 23 Nov 2023 01:49:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 4/4] af_unix: Try to run GC async.
Date: Wed, 22 Nov 2023 17:47:47 -0800
Message-ID: <20231123014747.66063-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231123014747.66063-1-kuniyu@amazon.com>
References: <20231123014747.66063-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
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
 net/unix/garbage.c    | 10 ++++++++--
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index c628d30ceb19..f8e654d418e6 100644
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
index 880027ecf516..c1aae77d120b 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -35,6 +35,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -105,6 +106,10 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			return -EBADF;
 		*fpp++ = file;
 		fpl->count++;
+#if IS_ENABLED(CONFIG_UNIX)
+		if (unix_get_socket(file))
+			fpl->count_unix++;
+#endif
 	}
 
 	if (!fpl->user)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 1e6f5aaf1cc9..bbad3959751d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1925,11 +1925,12 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
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
@@ -2201,11 +2202,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
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
index 8bc93a7e745f..73091d6b7fc4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -184,8 +184,9 @@ static void inc_inflight_move_tail(struct unix_sock *u)
 }
 
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
+#define UNIX_INFLIGHT_SANE_USER 32
 
-void wait_for_unix_gc(void)
+void wait_for_unix_gc(struct scm_fp_list *fpl)
 {
 	/* If number of inflight sockets is insane, kick a
 	 * garbage collect right now.
@@ -195,7 +196,12 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC)
 		queue_work(system_unbound_wq, &unix_gc_work);
 
-	flush_work(&unix_gc_work);
+	/* Penalise users who want to send AF_UNIX sockets
+	 * but whose sockets have not been received yet.
+	 */
+	if (fpl && fpl->count_unix &&
+	    READ_ONCE(fpl->user->unix_inflight) > UNIX_INFLIGHT_SANE_USER)
+		flush_work(&unix_gc_work);
 }
 
 static void __unix_gc(struct work_struct *work)
-- 
2.30.2


