Return-Path: <netdev+bounces-102739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D79709046F0
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AAF1F24D18
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954F8155A57;
	Tue, 11 Jun 2024 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gB/I5SMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A200155A47
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145059; cv=none; b=ACqBSzWdGSLm0e0lNGcL4AaBCVCsn9TQyx3wpH2eEmcgYbZ3l+t0PEVjJrcPxr5O9UHodAX4Yd0js/x6H8TnYwuiEkoozfSuUQEdgkKPYbgBzxDDqhfvL4V1Cr+0lkW8RdF4G8hNja735n1p60hY/xaWJU/lawSGOades9QZ57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145059; c=relaxed/simple;
	bh=50hZNp0XHKqnKqHQ8BZKwVW7yGrYoIXhnmhAmsszcHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCCYppv29R/hmZVvJcVyUflRTsi138byVGciJFBR6jWetsvTrRFtdY6S1QMqaMRHhXQ8IyYvPD/GCaI3idUGpvgFTB0GKfuikUT+3ihdpeaNrtrSZQX/x3PgsrpSA9t9GkLlYXLe5qRh0To/G229Uimp2OcDxL0AZhRDX3Vnu2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gB/I5SMC; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145058; x=1749681058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jR2uKftRJkftoSp6KkdaeDBHopvjTHeZH9+rN/5Jp3s=;
  b=gB/I5SMC9+L1mkcYfPDM9kcWjQDEb5hhHYZDm3PlTEP+50un4bH22Kxe
   dE8b6IMbGtr6DCzudQGv1FU2L1dkh/tcCQI3LJL3uXqozPghQB3sEvxtM
   +XC0tx1Lb1li3PaMD+IMC68aftUiv7ekTNKGRuE2wWa8kdaFJrebD8nAP
   k=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="96098966"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:30:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:45992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.16:2525] with esmtp (Farcaster)
 id 91730b71-8e02-4fe8-a25a-5e5b439e6787; Tue, 11 Jun 2024 22:30:55 +0000 (UTC)
X-Farcaster-Flow-ID: 91730b71-8e02-4fe8-a25a-5e5b439e6787
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:30:55 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:30:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 04/11] af_unix: Define locking order for U_LOCK_SECOND in unix_stream_connect().
Date: Tue, 11 Jun 2024 15:28:58 -0700
Message-ID: <20240611222905.34695-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240611222905.34695-1-kuniyu@amazon.com>
References: <20240611222905.34695-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

While a SOCK_(STREAM|SEQPACKET) socket connect()s to another, we hold
two locks of them by unix_state_lock() and unix_state_lock_nested() in
unix_stream_connect().

Before unix_state_lock_nested(), the following is guaranteed by checking
sk->sk_state:

  1. The first socket is TCP_LISTEN
  2. The second socket is not the first one
  3. Simultaneous connect() must fail

So, the client state can be TCP_CLOSE or TCP_LISTEN or TCP_ESTABLISHED.

Let's define the expected states as unix_state_lock_cmp_fn() instead of
using unix_state_lock_nested().

Note that 2. is detected by debug_spin_lock_before() and 3. cannot be
expressed as lock_cmp_fn.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h |  1 -
 net/unix/af_unix.c    | 26 +++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b6eedf7650da..fd813ad73ab8 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -98,7 +98,6 @@ struct unix_sock {
 #define unix_state_unlock(s)	spin_unlock(&unix_sk(s)->lock)
 enum unix_socket_lock_class {
 	U_LOCK_NORMAL,
-	U_LOCK_SECOND,	/* for double locking, see unix_state_double_lock(). */
 	U_LOCK_DIAG, /* used while dumping icons, see sk_diag_dump_icons(). */
 	U_LOCK_GC_LISTENER, /* used for listening socket while determining gc
 			     * candidates to close a small race window.
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a6dc8bb360ca..8d03c5ef61df 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -143,6 +143,30 @@ static int unix_state_lock_cmp_fn(const struct lockdep_map *_a,
 	a = container_of(_a, struct unix_sock, lock.dep_map);
 	b = container_of(_b, struct unix_sock, lock.dep_map);
 
+	if (a->sk.sk_state == TCP_LISTEN) {
+		/* unix_stream_connect(): Before the 2nd unix_state_lock(),
+		 *
+		 *   1. a is TCP_LISTEN.
+		 *   2. b is not a.
+		 *   3. concurrent connect(b -> a) must fail.
+		 *
+		 * Except for 2. & 3., the b's state can be any possible
+		 * value due to concurrent connect() or listen().
+		 *
+		 * 2. is detected in debug_spin_lock_before(), and 3. cannot
+		 * be expressed as lock_cmp_fn.
+		 */
+		switch (b->sk.sk_state) {
+		case TCP_CLOSE:
+		case TCP_ESTABLISHED:
+		case TCP_LISTEN:
+			return -1;
+		default:
+			/* Invalid case. */
+			return 0;
+		}
+	}
+
 	/* unix_state_double_lock(): ascending address order. */
 	return cmp_ptr(a, b);
 }
@@ -1583,7 +1607,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out_unlock;
 	}
 
-	unix_state_lock_nested(sk, U_LOCK_SECOND);
+	unix_state_lock(sk);
 
 	if (unlikely(sk->sk_state != TCP_CLOSE)) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EINVAL;
-- 
2.30.2


