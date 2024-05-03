Return-Path: <netdev+bounces-93386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3FD8BB7A0
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 00:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAAC1C24517
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A637F499;
	Fri,  3 May 2024 22:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MjHlmFxT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8991E4B0
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775627; cv=none; b=ESFUv8d9XtO0wEPENvrALNso68QQsvT/R4+0Dj8hFWYD/y5P7se4sxzOtwr3fBxj6vAs7JhDZMNvpkDQ6EMpUwEpIUIHxMQTF8vGUNbdu4Hg48HAOu9o8UKsoHAIXMy3NVkSPbRKK/lp3WiSh5TV/upj0eChBKUUGEEVxoYh1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775627; c=relaxed/simple;
	bh=K5OWe0bStvco8pgYhqZa36kByCsGBW343YCB95la5Nc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un8OLZnOAzSOOLadzi5jrfxpbxXb404qe8F6HdsTzQ9eE0R4BlExEcXfkG8Bdh/ndLYuUsKX20j1Rk+CI/mLOMHIB803Q8kcibZifkdvDIPcNE/48gHMzt6avn1WmmlQW2HOTqcHH+3BQZ0JrG+KJuHoI6ll8bEITRUJOTeFPNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MjHlmFxT; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714775625; x=1746311625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZLNwY0fkJzz0vjQdt0irInetE8uhIRWHE7DhB5yQ8M=;
  b=MjHlmFxTMxSVAMQ25F9XGgd2kS5VA7KB6kMlaY4aJIK+BfJnW19jcw0U
   7hieOO8/6ySWgLKxHjzRDJMnoS3BPxEhNgsEA5cL1FcaVkOIxGs96toJ5
   49U4wxnVCW3hhlANpNztR7ZFK52n+iIfQvIcJ4V1zAkkPZPsUVrCfWFGY
   g=;
X-IronPort-AV: E=Sophos;i="6.07,252,1708387200"; 
   d="scan'208";a="86872014"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 22:33:43 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:10404]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.127:2525] with esmtp (Farcaster)
 id a7b5d5c6-db7c-4c2f-b004-0521eeee1ce2; Fri, 3 May 2024 22:33:43 +0000 (UTC)
X-Farcaster-Flow-ID: a7b5d5c6-db7c-4c2f-b004-0521eeee1ce2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:33:38 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 3 May 2024 22:33:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/6] af_unix: Move wait_for_unix_gc() to unix_prepare_fpl().
Date: Fri, 3 May 2024 15:31:48 -0700
Message-ID: <20240503223150.6035-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240503223150.6035-1-kuniyu@amazon.com>
References: <20240503223150.6035-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_(dgram|stream)_sendmsg() call wait_for_unix_gc() to trigger GC
when the number of inflight AF_UNIX sockets is insane.

This does not happen in the sane use case.  If this happened, the
insane process would continue sending FDs.

We need not impose the duty in the normal sendmsg(), and instead,
we can trigger GC in unix_prepare_fpl(), which is called when a fd
of AF_UNIX socket is passed.

Also, this renames wait_for_unix_gc() to __unix_schedule_gc() for the
following changes.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 1 -
 net/unix/af_unix.c    | 4 ----
 net/unix/garbage.c    | 9 ++++++---
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b6eedf7650da..ebd1b3ca8906 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -24,7 +24,6 @@ void unix_update_edges(struct unix_sock *receiver);
 int unix_prepare_fpl(struct scm_fp_list *fpl);
 void unix_destroy_fpl(struct scm_fp_list *fpl);
 void unix_gc(void);
-void wait_for_unix_gc(struct scm_fp_list *fpl);
 
 struct unix_vertex {
 	struct list_head edges;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index dc1651541723..863058be35f3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1925,8 +1925,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	wait_for_unix_gc(scm.fp);
-
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags&MSG_OOB)
 		goto out;
@@ -2202,8 +2200,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (err < 0)
 		return err;
 
-	wait_for_unix_gc(scm.fp);
-
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 478b2eb479a2..85c0500764d4 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -271,6 +271,8 @@ void unix_update_edges(struct unix_sock *receiver)
 	}
 }
 
+static void __unix_schedule_gc(struct scm_fp_list *fpl);
+
 int unix_prepare_fpl(struct scm_fp_list *fpl)
 {
 	struct unix_vertex *vertex;
@@ -292,6 +294,8 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
 	if (!fpl->edges)
 		goto err;
 
+	__unix_schedule_gc(fpl);
+
 	return 0;
 
 err:
@@ -607,7 +611,7 @@ void unix_gc(void)
 #define UNIX_INFLIGHT_TRIGGER_GC 16000
 #define UNIX_INFLIGHT_SANE_USER (SCM_MAX_FD * 8)
 
-void wait_for_unix_gc(struct scm_fp_list *fpl)
+static void __unix_schedule_gc(struct scm_fp_list *fpl)
 {
 	/* If number of inflight sockets is insane,
 	 * force a garbage collect right now.
@@ -622,8 +626,7 @@ void wait_for_unix_gc(struct scm_fp_list *fpl)
 	/* Penalise users who want to send AF_UNIX sockets
 	 * but whose sockets have not been received yet.
 	 */
-	if (!fpl || !fpl->count_unix ||
-	    READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
+	if (READ_ONCE(fpl->user->unix_inflight) < UNIX_INFLIGHT_SANE_USER)
 		return;
 
 	if (READ_ONCE(gc_in_progress))
-- 
2.30.2


