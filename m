Return-Path: <netdev+bounces-103726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F295490933A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 22:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BABFB22AD9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 20:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09831A3BB1;
	Fri, 14 Jun 2024 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AdE19p/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516311A2549
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718395929; cv=none; b=E6XKLR4c5QZ8pIWceQL6WcP3ByzFK9fZ/RP11mChI7P5xvYEfdmB3QN1tr2/Uxi377MA3oR/5BwlV9e1jmkU/U3aebjReFSQZOdm9v6hJolxBSFP+xL/T1TSV0+kNfJsFY7bdKpBWhF/YkqzbDqG26EeNVyNlELadVkmrx60UZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718395929; c=relaxed/simple;
	bh=9vLxe3idRk5b1uJOVF59H8w9g/fkg5OwN97ycQ9KALs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVbn8/EjOdJTTOvRCqZiCGU+wwHxVGO9Q9O7ION3vl+kCHZuNt76NzvFfFzyAiX5UKibYlJbFRXp1I8IHA2DWPt3ts3igFNjT//QFbHgEkTBVx+iLwhlj0oSnXIzRlp76lkv6hZd6KULCLwZr6v0dIRrm2KcTScKhXeTJLHFYj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AdE19p/S; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718395928; x=1749931928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hMQz1Iga9tD8kg9qYt9PG5emsh92pozfnDsJh2KFXf0=;
  b=AdE19p/SyC4rg10oAgVG0WYZ0Q8cm4A0fcLPH4qyZhwnN7rTArhVpXTL
   x+pRe14Oy/0cEfPakXIJqvejUB/PTl1rEWQA0hXLYPXnw3LHxipNMkgZa
   0lZG0lLf1Thr56I+EiFbrlYDwE8AsObDiG5mvqpwjTMG+ht64bV5bbwS8
   M=;
X-IronPort-AV: E=Sophos;i="6.08,238,1712620800"; 
   d="scan'208";a="303533955"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 20:12:08 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:14283]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.60.144:2525] with esmtp (Farcaster)
 id b3a190ba-6c13-4ae4-8af5-43251b5da7aa; Fri, 14 Jun 2024 20:12:07 +0000 (UTC)
X-Farcaster-Flow-ID: b3a190ba-6c13-4ae4-8af5-43251b5da7aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:12:07 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.24) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 20:12:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 11/11] af_unix: Don't use spin_lock_nested() in copy_peercred().
Date: Fri, 14 Jun 2024 13:07:15 -0700
Message-ID: <20240614200715.93150-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240614200715.93150-1-kuniyu@amazon.com>
References: <20240614200715.93150-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
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
index c828022128ec..4dffff23a0fd 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -760,19 +760,12 @@ static void update_peercred(struct sock *sk)
 
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


