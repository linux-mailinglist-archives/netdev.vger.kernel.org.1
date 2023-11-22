Return-Path: <netdev+bounces-49864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309C7F3B5C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E699EB216F0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4DE210A;
	Wed, 22 Nov 2023 01:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mF4F7ljx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3966BA4
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 17:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1700617103; x=1732153103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sOP5MELKs9AxJlcPXbe5w1/acKCVuOyL+7AhyfLMy+A=;
  b=mF4F7ljxaIwOyg789n5JHPkU526dA/FLLiyPVnKoce75GP7ACVJwXLG1
   Tn8oAxRB76n9/KWh8hON6ZLVAUb+iA8HASpQpY2JShOYTSzvlKL3HwrdP
   UW/4b1AkmUXkw5PS1lnktuiatBfI+AA/W2SnSwh5f2F5RIN2zD8/E/o4+
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,217,1695686400"; 
   d="scan'208";a="596426403"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 01:38:21 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-8a14c045.us-west-2.amazon.com (Postfix) with ESMTPS id DB8D5803D4;
	Wed, 22 Nov 2023 01:38:20 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19642]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525] with esmtp (Farcaster)
 id 38e350bf-af73-4b45-950a-1d9f456b660f; Wed, 22 Nov 2023 01:38:20 +0000 (UTC)
X-Farcaster-Flow-ID: 38e350bf-af73-4b45-950a-1d9f456b660f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 22 Nov 2023 01:38:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Wed, 22 Nov 2023 01:38:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/4] af_unix: Try to run GC async.
Date: Tue, 21 Nov 2023 17:36:29 -0800
Message-ID: <20231122013629.28554-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231122013629.28554-1-kuniyu@amazon.com>
References: <20231122013629.28554-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
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

Note that even a sendmsg() call that only meets the condition 1) will be
blocked later in unix_scm_to_skb() by the spinlock, but we allow that as
a bonus for sane users.

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
 net/core/scm.c        |  3 +++
 net/unix/af_unix.c    |  6 ++++--
 net/unix/garbage.c    | 10 ++++++++--
 5 files changed, 17 insertions(+), 5 deletions(-)

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
index 880027ecf516..13d0e7e88be5 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -35,6 +35,7 @@
 #include <net/compat.h>
 #include <net/scm.h>
 #include <net/cls_cgroup.h>
+#include <net/af_unix.h>
 
 
 /*
@@ -105,6 +106,8 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			return -EBADF;
 		*fpp++ = file;
 		fpl->count++;
+		if (unix_get_socket(file))
+			fpl->count_unix++;
 	}
 
 	if (!fpl->user)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0ba7fb09c1bd..d1a54e65f2cf 100644
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


