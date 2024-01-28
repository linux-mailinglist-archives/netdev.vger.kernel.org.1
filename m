Return-Path: <netdev+bounces-66457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C86583F504
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 11:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E2C282990
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 10:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4061B286;
	Sun, 28 Jan 2024 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HGIuwS2W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02461EB20
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706438324; cv=none; b=kh4zfaXWFKYYbHQSTZ1JKeBpe8LzNRbuVQF30gL5K+jinw/MPrGCbPsDt/P7Z+iK8YV0ykAqgFHfxIMqV++LugYDR14iKDpFonrVlxGTHYMvZdC4wN+n6ibi2+LkZ3BgiptcA/tYuzxR6Zm2+ytH6fpqZOq5WMUq7TiaoTvgaKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706438324; c=relaxed/simple;
	bh=n5TwMpOanVmCHTym/cBbHtlt0jT+DzWUDXuB2JwkOso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZhBgejz98jXLpdroMz4+tFQwtYEpayQCEijKoBDrTn2v5TF+NwckGv57TReoLsl3X1g8UACDUGEoNdFrPl+1oXfv70iDgFaHEbj+4X1jM08ZqyLKzTweG9N3oekpV6vk9gO5x0InuUxRjVoumm8+mq+cyGtA9LAl6j1rbIX9n8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HGIuwS2W; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706438323; x=1737974323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=reF9tv+X0ZpvN+LgefQ3hBJ/zDlDPsQP+Sb6wsrzhfk=;
  b=HGIuwS2Wj3i9yPrlDNOCe5VBt2+oQvvxSmt7LKKzWA1RKIeBUborrGIf
   /4yetLUyrNvPb9uH8wMkSh6sWYPCuADdHeSTbtUeG1hXE0fxsebX3NVo8
   GqCxww3/u/Lo5cyW05eGA6q4xJbk/122X321DqtxLxSFXvh6hXt4ux7pN
   Y=;
X-IronPort-AV: E=Sophos;i="6.05,220,1701129600"; 
   d="scan'208";a="609230264"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 10:38:41 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1e-m6i4x-529f0975.us-east-1.amazon.com (Postfix) with ESMTPS id D88EA4A735;
	Sun, 28 Jan 2024 10:38:38 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:12882]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.136:2525] with esmtp (Farcaster)
 id 02c15e7f-08ff-4b70-b2bb-8fa79c0c983c; Sun, 28 Jan 2024 10:38:38 +0000 (UTC)
X-Farcaster-Flow-ID: 02c15e7f-08ff-4b70-b2bb-8fa79c0c983c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:38:36 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 10:38:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/2] af_unix: Don't hold client's sk_peer_lock in copy_peercred().
Date: Sun, 28 Jan 2024 02:37:32 -0800
Message-ID: <20240128103732.18185-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240128103732.18185-1-kuniyu@amazon.com>
References: <20240128103732.18185-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB001.ant.amazon.com (10.13.138.82) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

When (AF_UNIX, SOCK_STREAM) socket connect()s to a listening socket,
the listener's sk_peer_pid/sk_peer_cred are copied to the client in
copy_peercred().

Then, two sk_peer_locks are held there; one is client's and another
is listener's.  However, we need not hold the client's lock.

The only place where the client's sk_peer_pid/sk_peer_cred are set
is copy_peercred(), and once they are set, they never change.

Let's not hold client's sk_peer_lock in copy_peercred().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f07374d31f7c..c5c292393be8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -706,26 +706,10 @@ static void update_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	const struct cred *old_cred;
-	struct pid *old_pid;
-
-	if (sk < peersk) {
-		spin_lock(&sk->sk_peer_lock);
-		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
-	} else {
-		spin_lock(&peersk->sk_peer_lock);
-		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
-	}
-	old_pid = sk->sk_peer_pid;
-	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
+	spin_lock(&peersk->sk_peer_lock);
+	sk->sk_peer_pid = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
-
-	spin_unlock(&sk->sk_peer_lock);
 	spin_unlock(&peersk->sk_peer_lock);
-
-	put_pid(old_pid);
-	put_cred(old_cred);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
-- 
2.30.2


