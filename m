Return-Path: <netdev+bounces-86680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8389FDD3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 19:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4F81C218D7
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC9317B513;
	Wed, 10 Apr 2024 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nu/3Vm9O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3806017BB0F
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769086; cv=none; b=g3Zssb2Mdz39taYG+V4M0vhrDBVD9wspKgsT6kmnxeH+eBxTLpSfBcW3BFaJKV4qWJe5V6Fc7bswrBO14QeS0NOr0UZJZyJ+mvIrz/GkdKrT+pGbZxrUcVkHb3awu+pxFgew2MCwyUW2UYIPfu9I8PiX84Y3gSAuZ5b+WefcBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769086; c=relaxed/simple;
	bh=/mFzy0/wXcNdV8jrPyJzMG4utX210cUFx+M2IVusYww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNo2D9xQZqW0nG+h0010oOJsOzo4dYFcP49RROyNJ9bBz0Zhj3PDDxstWJ5VVbpL+8WzU3IZYC033Caj9BUdYQ52ofja+t1edr4Mc8qh0vWyek3vJFvnZpabBp1GtkQonAQoFW1OSiOsg4SdWODrU3rI5miYuKL7wPaZrlk3QMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nu/3Vm9O; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712769086; x=1744305086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVdZPzfe9EF/CBelLXYDz0AmXvtZb+wa+Sc+QCYcmCs=;
  b=nu/3Vm9OI+SBe/FR0NjdhaqJ/BiWJDE2w0WGyN/IVgCr4pNJDaanSOlj
   ImCE1zyPCz7W9mQUQIwwB0AAOJ0RcGqfiSPcznsbygFP77951Zsomhy99
   Gn93kkBM6X0aLVZadlScZQ58fTxeL3RmZL7OOQCfwiHEolflraXsMyaFv
   8=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="410588411"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 17:11:19 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:50874]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.40:2525] with esmtp (Farcaster)
 id 461b574c-ef01-4988-b614-f0cfd7e36fee; Wed, 10 Apr 2024 17:11:18 +0000 (UTC)
X-Farcaster-Flow-ID: 461b574c-ef01-4988-b614-f0cfd7e36fee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 17:11:17 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 17:11:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 2/2] af_unix: Don't peek OOB data without MSG_OOB.
Date: Wed, 10 Apr 2024 10:10:16 -0700
Message-ID: <20240410171016.7621-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240410171016.7621-1-kuniyu@amazon.com>
References: <20240410171016.7621-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, we can read OOB data without MSG_OOB by using MSG_PEEK
when OOB data is sitting on the front row, which is apparently
wrong.

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'a', MSG_OOB)
  1
  >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
  b'a'

If manage_oob() is called when no data has been copied, we only
check if the socket enables SO_OOBINLINE or MSG_PEEK is not used.
Otherwise, the skb is returned as is.

However, here we should return NULL if MSG_PEEK is set and no data
has been copied.

Also, in such a case, we should not jump to the redo label because
we will be caught in the loop and hog the CPU until normal data
comes in.

Then, we need to handle skb == NULL case with the if-clause below
the manage_oob() block.

With this patch:

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  >>> c1.send(b'a', MSG_OOB)
  1
  >>> c2.recv(1, MSG_PEEK | MSG_DONTWAIT)
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  BlockingIOError: [Errno 11] Resource temporarily unavailable

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f297320438bf..9a6ad5974dff 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2663,7 +2663,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 					WRITE_ONCE(u->oob_skb, NULL);
 					consume_skb(skb);
 				}
-			} else if (!(flags & MSG_PEEK)) {
+			} else if (flags & MSG_PEEK) {
+				skb = NULL;
+			} else {
 				skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
 				if (!WARN_ON_ONCE(skb_unref(skb)))
@@ -2745,11 +2747,9 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, sk, flags, copied);
-			if (!skb) {
+			if (!skb && copied) {
 				unix_state_unlock(sk);
-				if (copied)
-					break;
-				goto redo;
+				break;
 			}
 		}
 #endif
-- 
2.30.2


