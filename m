Return-Path: <netdev+bounces-102380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C0902BD3
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055AA1F21BFC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00015099E;
	Mon, 10 Jun 2024 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="klpB1ySE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD815466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059191; cv=none; b=FOZiUUprUNTjmqKkYSlU+EisJryspVoUbQ6NH2AsXbVrCeMHw9ZJuQ3Le3Z4SsS3aPcawS6AIbE9Rd0WPRs9uy4ptA7nmRaS+RfhPWhrGgCxNz1zq086eVuf4JFs4av/vZlPFUEp8LMtRXa1eQ+JQByV2R6iqOWAv4Cu4kH9Pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059191; c=relaxed/simple;
	bh=6VMX0FRz06sgTQeIf12HrG28kQmoQa54NKgNcfPGHME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r62eSjzd93df0TciwzPBPl2sXucuhWuX0xsCKiJ5Xs2NgTnv68De/cEiK71LLLFpJkgRubyr6s3IWCkU9LUPIFJ1UdRx3dJB1imfxQwfuBRyzLR2TzE9fUh7o1oWXzr/g7VviCuQSdNBM18Rq6Pc1w+i58R8u8TdV+mn3JpoSWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=klpB1ySE; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718059190; x=1749595190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9yD0Y9jZeS68+FkNHr3KNRrp3kVEXwbCLx5iLaeKZBA=;
  b=klpB1ySEEvTQ6Ekcdo43IqRkvUUPdAxjiKDo1xw8/bNT6l3Mz0xFBkih
   NQFo9qR95q2fsNXEHD70K79BAbdXVaRpWuceqMhFdKsdox2HlkYgyoGgW
   CQ/F7vZjnOTONVVVbmceN0u6V1LEu7ug1Prh6P0TLxt25yDE/2Sjm5F3j
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="302454322"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:39:49 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:17584]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.129:2525] with esmtp (Farcaster)
 id 79792353-792d-4cb4-9b5e-84805f35c9d2; Mon, 10 Jun 2024 22:39:47 +0000 (UTC)
X-Farcaster-Flow-ID: 79792353-792d-4cb4-9b5e-84805f35c9d2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:39:43 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:39:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/11] af_unix: Don't use spin_lock_nested() in copy_peercred().
Date: Mon, 10 Jun 2024 15:35:01 -0700
Message-ID: <20240610223501.73191-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240610223501.73191-1-kuniyu@amazon.com>
References: <20240610223501.73191-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
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
index 7d9c4c9b6f85..0d706d8f56a0 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -755,19 +755,12 @@ static void update_peercred(struct sock *sk)
 
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


