Return-Path: <netdev+bounces-105464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A773911405
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14070281540
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702117B3FE;
	Thu, 20 Jun 2024 21:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kES2uhOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE77710E
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917263; cv=none; b=ViPBtC6F3qArlRShSSmwyffOh9caCKnuunIjoP+g6tpIDyI+gm7aP6BDuQztEWw+n8PLi+BM578gWYwVbboozxwO8+aixitgDytCtHC9IVqA++CHADNisBx+T5R9RkXpQUtN5ASMFsswPHoBvHsJ3udNsFePmaPBqHIlHDigsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917263; c=relaxed/simple;
	bh=Fg4NrpOJYwfc1fIvp2tL/7cZ0UOzDglClvJxIVmDMHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImNmX7JmQNTyPyvy0I+yGTl0DVxWDaPTzJ3a5akWcOJADZzOfhquR+ft0atBgHgFE6vUrCo1axP+u1uTR8d7KNGcDZYSHEAHaeyyxkjyXISWMWKwBxi4EGyQhn0ExpUz85xVnuv9tdM9J9wwGk7rfuyaEKSp31qUt7X10J/M4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kES2uhOO; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917262; x=1750453262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SW+EI7TnDCaT5zKYwhGqjIKcz1wLrkAo34uS+7CyU7k=;
  b=kES2uhOOx9t3JGiYHJvBsKLdXZJd/PHnCogyL8T+UC7X52rH6sqDclG7
   EhC3T3ivOdnDqomRade8Gk1R16ZiYtUbPKdA5IQg1ymlaiv8ENES+rgzK
   +euLG0bVWjtb53FoGmwnqZMgifY+1lO/lfNSCdXmJDwE88raMPrXZ6+1o
   o=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="98286348"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:01:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:57523]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.61:2525] with esmtp (Farcaster)
 id 9d945f1b-c66e-49e8-87ed-54007b963327; Thu, 20 Jun 2024 21:01:01 +0000 (UTC)
X-Farcaster-Flow-ID: 9d945f1b-c66e-49e8-87ed-54007b963327
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:01:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:00:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 11/11] af_unix: Don't use spin_lock_nested() in copy_peercred().
Date: Thu, 20 Jun 2024 13:56:23 -0700
Message-ID: <20240620205623.60139-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When (AF_UNIX, SOCK_STREAM) socket connect()s to a listening socket,
the listener's sk_peer_pid/sk_peer_cred are copied to the client in
copy_peercred().

Then, two sk_peer_locks are held there; one is client's and another
is listener's.

However, the latter is not needed because we hold the listner's
unix_state_lock() there and unix_listen() cannot update the cred
concurrently.

Let's drop the unnecessary spin_lock() and use the bare spin_lock()
for the client to protect concurrent read by getsockopt(SO_PEERCRED).

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3d0ace7ca017..103a7909cb1a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -772,19 +772,12 @@ static void update_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	if (sk < peersk) {
-		spin_lock(&sk->sk_peer_lock);
-		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
-	} else {
-		spin_lock(&peersk->sk_peer_lock);
-		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
-	}
+	lockdep_assert_held(&unix_sk(peersk)->lock);
 
-	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
+	spin_lock(&sk->sk_peer_lock);
+	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
-
 	spin_unlock(&sk->sk_peer_lock);
-	spin_unlock(&peersk->sk_peer_lock);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
-- 
2.30.2


