Return-Path: <netdev+bounces-105463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBDD911400
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0579D1F21856
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA606EB7C;
	Thu, 20 Jun 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Z08OXsOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB659167
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917245; cv=none; b=TeXi4WAKoSFw9IhxfX7MMPdMsL4ky2RG9hZTVU52mr+WY9zDFbCYoFCjCxn1Jxt76V/AjNuFkWzq4rYHKu33WfUAjvfU8RQgsGzJ202ACsfXdq9bqEF6/UNfyx16/qFmFlpgesIdY6+ZbS8h/YgZiuww5N0VSJCG6jAZQw6GVcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917245; c=relaxed/simple;
	bh=VXfLhM0pdgpcmpkI53B3dMw0myLTnmJbz9O8XTNJBlg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0b+HhfLbKXbl7FxDt3jLP57mfd5Bon7FSpicB+GCWtaUanngLGHCVTfu7XHlaVvXjifBsK+8ctThpJ3PFlQJkjNiRlGbO0rTPBmTAPPj8AvhuwNlsdLaxwQvwLMTpkTbyu+M/Z/gnzjL8c4ZxkWMJ/Lhm+eIeOH90/PK4WRIkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Z08OXsOQ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917243; x=1750453243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=opcddPPdpPn8FrZtL/vH+Kh2sc5OEMM8TKnPAZG9dBI=;
  b=Z08OXsOQgdy4cNb0PJ/r4XROoEeoQqPpTm7uW6ojsjFhYZCN70bSki0J
   ZtcNZy9r8yT+hT8ykPDfBdtSGBqPod2a0x6EfByZ4xxw+xJ30a2gE2Nom
   b31fL2D+O/9S1Tw8ShFudZJt+H6woxlPlDExw+rcKC0xueNgEwsQEUPNe
   A=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="304844709"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:00:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:30695]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.47:2525] with esmtp (Farcaster)
 id 3f82a987-d0ce-4371-ae50-4af68dd39ae2; Thu, 20 Jun 2024 21:00:43 +0000 (UTC)
X-Farcaster-Flow-ID: 3f82a987-d0ce-4371-ae50-4af68dd39ae2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:00:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:00:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 10/11] af_unix: Remove put_pid()/put_cred() in copy_peercred().
Date: Thu, 20 Jun 2024 13:56:22 -0700
Message-ID: <20240620205623.60139-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA002.ant.amazon.com (10.13.139.96) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When (AF_UNIX, SOCK_STREAM) socket connect()s to a listening socket,
the listener's sk_peer_pid/sk_peer_cred are copied to the client in
copy_peercred().

Then, the client's sk_peer_pid and sk_peer_cred are always NULL, so
we need not call put_pid() and put_cred() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index d11664c2faad..3d0ace7ca017 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -772,9 +772,6 @@ static void update_peercred(struct sock *sk)
 
 static void copy_peercred(struct sock *sk, struct sock *peersk)
 {
-	const struct cred *old_cred;
-	struct pid *old_pid;
-
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
 		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
@@ -782,16 +779,12 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 		spin_lock(&peersk->sk_peer_lock);
 		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
 	}
-	old_pid = sk->sk_peer_pid;
-	old_cred = sk->sk_peer_cred;
+
 	sk->sk_peer_pid  = get_pid(peersk->sk_peer_pid);
 	sk->sk_peer_cred = get_cred(peersk->sk_peer_cred);
 
 	spin_unlock(&sk->sk_peer_lock);
 	spin_unlock(&peersk->sk_peer_lock);
-
-	put_pid(old_pid);
-	put_cred(old_cred);
 }
 
 static int unix_listen(struct socket *sock, int backlog)
-- 
2.30.2


