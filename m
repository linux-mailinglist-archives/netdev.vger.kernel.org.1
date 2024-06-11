Return-Path: <netdev+bounces-102746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A764E9046F9
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDC0B22A68
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44B815531E;
	Tue, 11 Jun 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sgPPNM8o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304B7711C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718145232; cv=none; b=oWSfj969+xHE61STXUe6yg6fv7te4JxtrrPA+E+MpgD/368D1rgfPzaYt6bgoOEH64+/hBPFuEMYZPb0+N3WEwNhq/PCUI6BkhzAdhf1VM99b6C68HDGEvQT4nRs7h6vP9eSr0QBIdnGD8JnDUnEriDOKVDo2LxqR5MmAnarZCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718145232; c=relaxed/simple;
	bh=tSo07x8keY0rW91pCGNvAhVyJ1tb3arFEabBCA5fzSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO7QKs052VJl7DKvLCgvufvid1PCy/zdi4ZtVu5vDCNoNzecm5ktPGdHjslCFEnW+7SRwR5hEoHzhhCmTDgx2FAFRbIx3hSuODemLvc9VxNFCfdX2pf54d8a5QZbB0KdIjFIHjeS4tG3sXp2Sw8phwWuZo1wqS56f6KR80YsY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sgPPNM8o; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718145231; x=1749681231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KdGUyi8XSiZi6HW/3583S9BJa70zclbFF6HTGLloIMU=;
  b=sgPPNM8ow1rSbeFnJmKtq630rSyhR6Rvod4d1NB7JaSCj5S2kKcPEpda
   ewoWUJ/EVLrzFb+BnkcaPZzZVmN4+9I2OqZ05UuJeSQCEwMF3yc2zA7HX
   MKFAEUr7zUCsV1nXasVCdLWiEpE14PawXOQ7uhRC95i48U2v2PWNIC7tp
   0=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="407211905"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:33:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:19380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.16:2525] with esmtp (Farcaster)
 id 689a2952-c491-4ec8-819c-46c422cfb839; Tue, 11 Jun 2024 22:33:49 +0000 (UTC)
X-Farcaster-Flow-ID: 689a2952-c491-4ec8-819c-46c422cfb839
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:33:45 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:33:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/11] af_unix: Don't use spin_lock_nested() in copy_peercred().
Date: Tue, 11 Jun 2024 15:29:05 -0700
Message-ID: <20240611222905.34695-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
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
index 64bfd25a6b31..1309f0beacf0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -757,19 +757,12 @@ static void update_peercred(struct sock *sk)
 
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


