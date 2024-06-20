Return-Path: <netdev+bounces-105462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 451AA9113FD
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1AA8B20C31
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9D482DE;
	Thu, 20 Jun 2024 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dwrVjBDG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC0639FD7
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917216; cv=none; b=ICNFBrSqkXt2W8jaTeep0Tl3xnYjfj9wi0PKPwMRlt+TI7e02ELTR8tlR4h3WnCAzSfn451KsRYgkq5khiQasrqJ0HVMikOhh6KsQuRD/LZtgfcd7lVFCUQqheFbVzaCp+su3RXPzuvE+zXyD2lE20FXejMYpMIU/jDlwb36A8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917216; c=relaxed/simple;
	bh=mX3zVi78KXKruNNKYwT5iMLE3IEO9p+lFRNLtRb6uwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8edQb3ZmvZT4XLUOdCdxiyfbxhYlVAco4wsjeIFcRpV2bonk0upyVI9yC79ddvN3myPOl5YLweyf586Ev8yCioTuf4P41bzE6ysS68hbOAMrguT551p+qfsgN1nqncgrIKUvHb3eK/WvzDETctjGzQKgjLp5RdOFIuMA8VWV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dwrVjBDG; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718917215; x=1750453215;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+nXQFtTFrw1NrUZ2+8CcNQ0d68wdpVaPU7AAweF0s4=;
  b=dwrVjBDG1BkQ4gltmlqVRJRIK3dqyrmthabaX9h5WElai5MmLD2V1vaa
   LLnFHWA7pY/7GxGeUgnmBbE5QBsXjWHaunJm8Q0ZIg2xUOVS1RbY275go
   z3W4cQbQd19gxgYeQ3zqCWHjwFnhvB+cCsU4C3Z6aJFqyMG0gli/+HLKe
   s=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="213072069"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 21:00:13 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:23256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 6482c1e7-8aee-400a-b3f7-97343d788f74; Thu, 20 Jun 2024 21:00:13 +0000 (UTC)
X-Farcaster-Flow-ID: 6482c1e7-8aee-400a-b3f7-97343d788f74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 20 Jun 2024 21:00:12 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 21:00:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 09/11] af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
Date: Thu, 20 Jun 2024 13:56:21 -0700
Message-ID: <20240620205623.60139-10-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

init_peercred() is called in 3 places:

  1. socketpair() : both sockets
  2. connect()    : child socket
  3. listen()     : listening socket

The first two need not hold sk_peer_lock because no one can
touch the socket.

Let's set cred/pid without holding lock for the two cases and
rename the old init_peercred() to update_peercred() to properly
reflect the use case.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 89675879038d..d11664c2faad 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -750,6 +750,12 @@ static void unix_release_sock(struct sock *sk, int embrion)
 }
 
 static void init_peercred(struct sock *sk)
+{
+	sk->sk_peer_pid = get_pid(task_tgid(current));
+	sk->sk_peer_cred = get_current_cred();
+}
+
+static void update_peercred(struct sock *sk)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
@@ -757,8 +763,7 @@ static void init_peercred(struct sock *sk)
 	spin_lock(&sk->sk_peer_lock);
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-	sk->sk_peer_pid  = get_pid(task_tgid(current));
-	sk->sk_peer_cred = get_current_cred();
+	init_peercred(sk);
 	spin_unlock(&sk->sk_peer_lock);
 
 	put_pid(old_pid);
@@ -810,7 +815,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	WRITE_ONCE(sk->sk_state, TCP_LISTEN);
 
 	/* set credentials so connect can copy them */
-	init_peercred(sk);
+	update_peercred(sk);
 	err = 0;
 
 out_unlock:
-- 
2.30.2


