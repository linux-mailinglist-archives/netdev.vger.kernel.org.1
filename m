Return-Path: <netdev+bounces-86307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64C89E5CB
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA75A283D84
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023C158A3D;
	Tue,  9 Apr 2024 22:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TdJHTEAY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0659158D8F
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703202; cv=none; b=ZN0EuiyqdOVr/QOYgNzW6cP8pPGe6KpKmJHit21PJxtNEQLv2VGjqh0fF48JtIsXwPTg02NDOegybhWIc5EsM+eIPlWYifauz0g5g3pEj+BxRWNglOtELz9f4zX6Om35fAscWckGDj7QHEcondZO2wx46TlTJrSy+1sAY5htmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703202; c=relaxed/simple;
	bh=/mFzy0/wXcNdV8jrPyJzMG4utX210cUFx+M2IVusYww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seEKh3GQWWXBlYcF7XdDUcjImCQHYx9HWARQFB9clkJkdh+10PswFPnZSelfEW7z8d3XFvWmB5DH2FQZ31Qid5Il/TNmW/RhNTG410Go7xOO0E+xSkPSUIudMrxIAqwHf+2fvO/itmRhZ0Qscoov3LLREMlLF+2G3SRsF5A0rQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TdJHTEAY; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712703201; x=1744239201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVdZPzfe9EF/CBelLXYDz0AmXvtZb+wa+Sc+QCYcmCs=;
  b=TdJHTEAY8+e7PChG73v5ls07sQ1pXec1VT2oeyIPLqPd9C6SoQYZGluk
   giSILAX5C+6fNfHEugiC1tXXUrS7d4t0HidyUQtVqP4WRQ1VqG+Q28W4V
   hpVcYSFJUaiGbMDA2DxyCgpRHtrrvGsEGM4Nh8Xqr3bOQQ8FgTL2hUrys
   0=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="388632866"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:53:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:29104]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.255:2525] with esmtp (Farcaster)
 id 37762a40-b759-423a-8c09-16996039ac07; Tue, 9 Apr 2024 22:53:19 +0000 (UTC)
X-Farcaster-Flow-ID: 37762a40-b759-423a-8c09-16996039ac07
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:53:18 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 9 Apr 2024 22:53:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 2/3] af_unix: Don't peek OOB data without MSG_OOB.
Date: Tue, 9 Apr 2024 15:52:08 -0700
Message-ID: <20240409225209.58102-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240409225209.58102-1-kuniyu@amazon.com>
References: <20240409225209.58102-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
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


