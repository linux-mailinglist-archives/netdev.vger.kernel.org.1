Return-Path: <netdev+bounces-85355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D17BD89A5CB
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7043D1F215D2
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D917279D;
	Fri,  5 Apr 2024 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JySw1SUx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E11E1327FD
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349735; cv=none; b=HH/r4fFDl4bIJ1PJ+8BAtUZcvzTpxgTT7Fa3QngsSXqHjQGd1uHHLP3vMvmYaTavLJysqmCnBAbArBNPiW68mLgp8wRrG7DuZkK+GdBmkF7Syl0YhnglkV6ng6tUo3evh+/ScXBzmQnW2iKWyK8yDcddy9LvAfoPKJ2Eilk54DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349735; c=relaxed/simple;
	bh=vi113DOlksn3eqf8YjkMHTEW2/3w314LKNev7pMexqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9MZg94ayzqM7ZPGSm/MjGywHg7g/9OcVAV5b/wnX3ogsg93VT915gYM+GyRwrtpIoAgJC47gjjhxGZ2s8nHrmvgadH+vwjFndzU5+1mdAim6GsCpzRnQQtlpyThHkhiRPHqr4WnWcGd5yBJktE9DXvsmeSLxguwwPyK1cViYlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JySw1SUx; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712349734; x=1743885734;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=riSH8p2OAViU+/tuE3xLjogJVCGGb0Fie/Radpbupcg=;
  b=JySw1SUxM/NHqjP+UOUxcC7QsQ55bjGHEI0zN64nrdto0Z6uNz+WQyz6
   EQwPaLC1siK8YJcFOkQ2c6akQGfm7B9CtmAXDeoqJMM9dPmH67+atWu1A
   b+22fhBXwMKC7/si+5WxIESyXe92EDgOlmKRpKhATaLk6UXYYC0NxLtfx
   s=;
X-IronPort-AV: E=Sophos;i="6.07,182,1708387200"; 
   d="scan'208";a="409533790"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 20:42:09 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:14123]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.222:2525] with esmtp (Farcaster)
 id 78e7187a-29ec-4b5d-83d2-458e6eafa690; Fri, 5 Apr 2024 20:42:08 +0000 (UTC)
X-Farcaster-Flow-ID: 78e7187a-29ec-4b5d-83d2-458e6eafa690
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 20:42:08 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 5 Apr 2024 20:42:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] af_unix: Clear stale u->oob_skb.
Date: Fri, 5 Apr 2024 13:41:45 -0700
Message-ID: <20240405204145.93169-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC004.ant.amazon.com (10.13.139.203) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller started to report deadlock of unix_gc_lock after commit
4090fa373f0e ("af_unix: Replace garbage collection algorithm."), but
it just uncovers the bug that has been there since commit 314001f0bf92
("af_unix: Add OOB support").

The repro basically does the following.

  from socket import *
  from array import array

  c1, c2 = socketpair(AF_UNIX, SOCK_STREAM)
  c1.sendmsg([b'a'], [(SOL_SOCKET, SCM_RIGHTS, array("i", [c2.fileno()]))], MSG_OOB)
  c2.recv(1)  # blocked as no normal data in recv queue

  c2.close()  # done async and unblock recv()
  c1.close()  # done async and trigger GC

A socket sends its file descriptor to itself as OOB data and tries to
receive normal data, but finally recv() fails due to async close().

The problem here is wrong handling of OOB skb in manage_oob().  When
recvmsg() is called without MSG_OOB, manage_oob() is called to check
if the peeked skb is OOB skb.  In such a case, manage_oob() pops it
out of the receive queue but does not clear unix_sock(sk)->oob_skb.
This is wrong in terms of uAPI.

Let's say we send "hello" with MSG_OOB, and "world" without MSG_OOB.
The 'o' is handled as OOB data.  When recv() is called twice without
MSG_OOB, the OOB data should be lost.

  >>> from socket import *
  >>> c1, c2 = socketpair(AF_UNIX, SOCK_STREAM, 0)
  >>> c1.send(b'hello', MSG_OOB)  # 'o' is OOB data
  5
  >>> c1.send(b'world')
  5
  >>> c2.recv(5)  # OOB data is not received
  b'hell'
  >>> c2.recv(5)  # OOB date is skippeed
  b'world'
  >>> c2.recv(5, MSG_OOB)  # This should return an error
  b'o'

In the same situation, TCP actually returns -EINVAL for the last
recv().

Also, if we do not clear unix_sk(sk)->oob_skb, unix_poll() always set
EPOLLPRI even though the data has passed through by previous recv().

To avoid these issues, we must clear unix_sk(sk)->oob_skb when dequeuing
it from recv queue.

The reason why the old GC did not trigger the deadlock is because the
old GC relied on the receive queue to detect the loop.

When it is triggered, the socket with OOB data is marked as GC candidate
because file refcount == inflight count (1).  However, after traversing
all inflight sockets, the socket still has a positive inflight count (1),
thus the socket is excluded from candidates.  Then, the old GC lose the
chance to garbage-collect the socket.

With the old GC, the repro continues to create true garbage that will
never be freed nor detected by kmemleak as it's linked to the global
inflight list.  That's why we couldn't even notice the issue.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7f7f201cc2668a8fd169
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 5b41e2321209..8f105cf535be 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2665,7 +2665,9 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 				}
 			} else if (!(flags & MSG_PEEK)) {
 				skb_unlink(skb, &sk->sk_receive_queue);
-				consume_skb(skb);
+				WRITE_ONCE(u->oob_skb, NULL);
+				kfree_skb(skb);
+				kfree_skb(skb);
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
-- 
2.30.2


