Return-Path: <netdev+bounces-97601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F68CC445
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 17:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE76283097
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027737D3E6;
	Wed, 22 May 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oOfJXJD3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1267D08D
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392424; cv=none; b=szk1pDJQUsSVziclPsTT1KbmKqvp0pMeiBb8OkX/WKnW3TxZfW2gxQFcbChwfE/L3khZOIQ60FWxHnTgXOdfU/m7qMVzFuz0Yfb15cIsrK6Y2t3a34tH0CCqP9pK5Tb6P3vUk9WzqmnipSIDKfhC8P7zfPn2BgkSdOZ7DLeGr4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392424; c=relaxed/simple;
	bh=bNx6/ZQWgw65zfW+QRyiN3xErXI2/6JQ2avBpYCx1Bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gWgLRSRBDoqqxgDwixoYugTSCFzXJ0ZEqCEwDkq4A5RPLRi39vbmQIBJf4xA/s98SM4qfhahI+45m5k19AAB+Qxy2Nf0O35PSUXwZ9H7/58JHuStfSASn6qO1PjP3ggAoa5i1mlebxvtlQRqeMOCyB2zl98npcotgdMBjG9quEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oOfJXJD3; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716392424; x=1747928424;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A/cehJs/FMjhGJAhLqlP2WEYrm/EApNbQRXiCI9S3wk=;
  b=oOfJXJD3gWAB25RSrBrcbcfQZ+H55ldC3xZV9YsebuenWv0JlcyAln6v
   zIqyengCPcWAsyP5ike/wcfTjK7SdQH02aokR1+EZ5K+x9IrXzaHjEpKk
   +ZFhnUFM7qXa/3Jt93m/PuQ61fbc7XgI1TJLE8e6SaeHpQVZ42bQ/YSAS
   8=;
X-IronPort-AV: E=Sophos;i="6.08,181,1712620800"; 
   d="scan'208";a="402966234"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 15:40:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:19548]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.50:2525] with esmtp (Farcaster)
 id 92cca7dd-4fc4-433f-a0d0-4ee1a09b9dc2; Wed, 22 May 2024 15:40:19 +0000 (UTC)
X-Farcaster-Flow-ID: 92cca7dd-4fc4-433f-a0d0-4ee1a09b9dc2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 22 May 2024 15:40:19 +0000
Received: from 88665a182662.ant.amazon.com (10.143.93.121) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Wed, 22 May 2024 15:40:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
	<syzkaller@googlegroups.com>
Subject: [PATCH v2 net] af_unix: Annotate data-race around unix_sk(sk)->addr.
Date: Thu, 23 May 2024 00:40:02 +0900
Message-ID: <20240522154002.77857-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once unix_sk(sk)->addr is assigned under net->unx.table.locks and
unix_sk(sk)->bindlock, *(unix_sk(sk)->addr) and unix_sk(sk)->path are
fully set up, and unix_sk(sk)->addr is never changed.

unix_getname() and unix_copy_addr() access the two fields locklessly,
and commit ae3b564179bf ("missing barriers in some of unix_sock ->addr
and ->path accesses") added smp_store_release() and smp_load_acquire()
pairs.

In other functions, we still read unix_sk(sk)->addr locklessly to check
if the socket is bound, and KCSAN complains about it.  [0]

Given these functions have no dependency for *(unix_sk(sk)->addr) and
unix_sk(sk)->path, READ_ONCE() is enough to annotate the data-race.

Note that it is safe to access unix_sk(sk)->addr locklessly if the socket
is found in the hash table.  For example, the lockless read of otheru->addr
in unix_stream_connect() is safe.

Note also that newu->addr there is of the child socket that is still not
accessible from userspace, and smp_store_release() publishes the address
in case the socket is accept()ed and unix_getname() / unix_copy_addr()
is called.

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
v2: Add explanation why lockless read of otheru->addr is safe in
    unix_stream_connect()

v1: https://lore.kernel.org/netdev/20240518000148.27947-1-kuniyu@amazon.com/
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


