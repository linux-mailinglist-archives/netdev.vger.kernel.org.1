Return-Path: <netdev+bounces-97047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8EC8C8EB6
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 02:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF301F21F0C
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 00:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE500195;
	Sat, 18 May 2024 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HzGw32jH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436B38C
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715990527; cv=none; b=NMqJHmMkIAaSYRWZoVPaD0wabKJSnPb4IoYEFdmGax8BGsfBPbvrYybsN4Id94CVZ6ZZ9L1mujeqCTHH1nq+5S77eVjdSey3J5EtuLwPi5L97/WAlW6r8CNxWxqhiQB41eIlkQYvAbH556q3vaklS+2XweSFJm2AGJ9zAjMTpM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715990527; c=relaxed/simple;
	bh=rvE2LxZqPHQyJZtg6dadhaDGNtC98nxQIf1cpJLntwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ihGvVa/EtocSxcDYhhEl9iIBOCOipRt/RxZy6efIQdeVidH5drNFNx6dZqYepE0rFimCs5dJlhgG0R/KqEDDE6iFSEcLa9APLOJDGJ6GD7YMG2yOEQts3YgNEnuDlW1TUjEId9Du25//IBzyrZ6h8bhmYA67pWqZynNVTkX9VUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HzGw32jH; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715990526; x=1747526526;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tXM5VwUSF/0CAp+6eTNFi6AtU7b9McSfsAhhz2wkZw4=;
  b=HzGw32jHXN8xgQXn5jduCMiW7UWd9sh5DN6x6J84UW8Li/r1cm0pRIGc
   G3vs6tHXig/voFKu3DPtKoj0ZSkm5lY3HRZ8Fy33LDEF4GpcMqrIGZV5r
   67Pb4sg9K06pW8Y4d2x3yvro38/4pY2bLY8JSytaZTZm6oizjVKw72FHu
   s=;
X-IronPort-AV: E=Sophos;i="6.08,169,1712620800"; 
   d="scan'208";a="397266104"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 00:02:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:44439]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.96:2525] with esmtp (Farcaster)
 id 8435cd26-e051-4ccb-ab7a-8e8d75d6627f; Sat, 18 May 2024 00:02:03 +0000 (UTC)
X-Farcaster-Flow-ID: 8435cd26-e051-4ccb-ab7a-8e8d75d6627f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 00:02:02 +0000
Received: from 88665a182662.ant.amazon.com (10.119.8.176) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 00:01:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v1 net] af_unix: Annotate data-race around unix_sk(sk)->addr.
Date: Sat, 18 May 2024 09:01:48 +0900
Message-ID: <20240518000148.27947-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA001.ant.amazon.com (10.13.139.88) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once unix_sk(sk)->addr is assigned under net->unx.table.locks,
*(unix_sk(sk)->addr) and unix_sk(sk)->path are fully set up, and
unix_sk(sk)->addr is never changed.

unix_getname() and unix_copy_addr() access the two fields locklessly,
and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
and ->path accesses") added smp_store_release() and smp_load_acquire()
pairs.

In other functions, we still read unix_sk(sk)->addr locklessly to check
if the socket is bound, and KCSAN complains about it.  [0]

Given these functions have no dependency for *(unix_sk(sk)->addr) and
unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.

[0]:
BUG: KCSAN: data-race in unix_bind / unix_listen

write (marked) to 0xffff88805f8d1840 of 8 bytes by task 13723 on cpu 0:
 __unix_set_addr_hash net/unix/af_unix.c:329 [inline]
 unix_bind_bsd net/unix/af_unix.c:1241 [inline]
 unix_bind+0x881/0x1000 net/unix/af_unix.c:1319
 __sys_bind+0x194/0x1e0 net/socket.c:1847
 __do_sys_bind net/socket.c:1858 [inline]
 __se_sys_bind net/socket.c:1856 [inline]
 __x64_sys_bind+0x40/0x50 net/socket.c:1856
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

read to 0xffff88805f8d1840 of 8 bytes by task 13724 on cpu 1:
 unix_listen+0x72/0x180 net/unix/af_unix.c:734
 __sys_listen+0xdc/0x160 net/socket.c:1881
 __do_sys_listen net/socket.c:1890 [inline]
 __se_sys_listen net/socket.c:1888 [inline]
 __x64_sys_listen+0x2e/0x40 net/socket.c:1888
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x4f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x46/0x4e

value changed: 0x0000000000000000 -> 0xffff88807b5b1b40

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 13724 Comm: syz-executor.4 Not tainted 6.8.0-12822-gcd51db110a7e #12
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ca101690e740..92a88ac070ca 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
 		goto out;	/* Only stream/seqpacket sockets accept */
 	err = -EINVAL;
-	if (!u->addr)
+	if (!READ_ONCE(u->addr))
 		goto out;	/* No listens on an unbound socket */
 	unix_state_lock(sk);
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
@@ -1369,7 +1369,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
 		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-		    !unix_sk(sk)->addr) {
+		    !READ_ONCE(unix_sk(sk)->addr)) {
 			err = unix_autobind(sk);
 			if (err)
 				goto out;
@@ -1481,7 +1481,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -1951,7 +1952,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
-- 
2.30.2


