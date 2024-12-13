Return-Path: <netdev+bounces-151700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B79F0A71
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E6188A021
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14DF1C3C1C;
	Fri, 13 Dec 2024 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vwNQPFNd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EF41B87FD
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088166; cv=none; b=AnjmZugyrPsOD2PbXX1vw4G5pnEOlou15uejw0qOtUCIyKGvbQsS+PzWHCq+YaaGVKk79QQ7lA/lDhd9HOuqZmlBwQkEEi+sPlhywdXD+QNByimt6qyv+4i+mLJCfKWTu9Ws7FsRU0XluxTJb8YI5Z6/8ZXLWqmeXOfpZJ1W72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088166; c=relaxed/simple;
	bh=YGYfKaIkc762QAQiASxcLqZShpDrfuV2qzq5Wb+k3QE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDdzMx9BcylVCMWZZofKV6DC9qVDQ3BXACULfCCBJlMBVQQSql5hQLjlKrdfxiweMI8EmJOabKr365J3xj4/4trPOWvCJGTr6rc8W7gDCwHs8UJ88+CYkauYufBC19PAyEkAsh0y7vO4514DDMyVlFjFinbdN1lp/aq0QdbqRPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vwNQPFNd; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088165; x=1765624165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O3MrIR1Ht30L5jex6fun28KniI5z2bE8C4I8p+E76LE=;
  b=vwNQPFNdpdHc9pUHkvphrjGQ33CmEsm2DjUUy2zDwF8bnaJbx6QRo/Mg
   NBEneH0vZhKC2ayvy3uG+1tnY8Wa3zfT20d/UmM1oLkpGh9GOp0vSSDPF
   UT+wOjpteX3Av6WysIolWfHEjA0aDdkD8BJvDCKxBVfNq4MrEDnne19BD
   U=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="702731292"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:09:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:22393]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id 9abc7baa-ca7f-493f-8885-eb343ac31dbd; Fri, 13 Dec 2024 11:09:20 +0000 (UTC)
X-Farcaster-Flow-ID: 9abc7baa-ca7f-493f-8885-eb343ac31dbd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:09:20 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:09:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 01/12] af_unix: Set error only when needed in unix_stream_connect().
Date: Fri, 13 Dec 2024 20:08:39 +0900
Message-ID: <20241213110850.25453-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce skb drop reason for AF_UNIX, then we need to
set an errno and a drop reason for each path.

Let's set an error only when it's needed in unix_stream_connect().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6b1762300443..23f419f561b8 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1575,12 +1575,12 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	err = -ENOMEM;
-
 	/* Allocate skb for sending to listening sock */
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
-	if (skb == NULL)
+	if (!skb) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 restart:
 	/*  Find listening sock. */
@@ -1600,16 +1600,17 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto restart;
 	}
 
-	err = -ECONNREFUSED;
-	if (other->sk_state != TCP_LISTEN)
-		goto out_unlock;
-	if (other->sk_shutdown & RCV_SHUTDOWN)
+	if (other->sk_state != TCP_LISTEN ||
+	    other->sk_shutdown & RCV_SHUTDOWN) {
+		err = -ECONNREFUSED;
 		goto out_unlock;
+	}
 
 	if (unix_recvq_full_lockless(other)) {
-		err = -EAGAIN;
-		if (!timeo)
+		if (!timeo) {
+			err = -EAGAIN;
 			goto out_unlock;
+		}
 
 		timeo = unix_wait_for_peer(other, timeo);
 
-- 
2.39.5 (Apple Git-154)


