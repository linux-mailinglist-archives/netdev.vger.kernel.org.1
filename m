Return-Path: <netdev+bounces-217294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150FFB383DA
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19B33A80BC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 13:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E813568E1;
	Wed, 27 Aug 2025 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vasama.org header.i=@vasama.org header.b="Iz9XGkdC"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74101352FED
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302008; cv=none; b=VuB+S4nTpFqr2M8LQC+eWQEuwPOysh+a/AaKY3SpTtKxTp1izEw6BuFrdO1GKz5O353QryFOYHK8jYrvi/H0xq92/ugdjeOPZ3Ooelseua6/z067fb/6ul+046POIEEOZhjndkSU6KI6Qq8wbL5ATi4p+GOXBmLDyI74ILYeDTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302008; c=relaxed/simple;
	bh=D+lUVgJMEwIFc1P/nCQWWdEyr5YF/+9aw/YBibb75hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tro7rKot3+okZcQ2r5+zqiZqtmtYdu1QRYncJY66nO6htVhtqEFIBssgItK71Apk/9mUHapqXNT/hGin10gX2FMyCsm6QvKbcO4491LkT8XPXjhxv448DYdDn8WrFVA6dKStjDwH8KNkwX4Hqa0qOEkKlYktzp2PrdNjNzfk2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vasama.org; spf=pass smtp.mailfrom=vasama.org; dkim=pass (1024-bit key) header.d=vasama.org header.i=@vasama.org header.b=Iz9XGkdC; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vasama.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasama.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasama.org; s=key1;
	t=1756301992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bm9rJ8OhJh58CJfDwiENOqiWNHMg/YizQnJOZe32I8E=;
	b=Iz9XGkdCGEOLeWt+/qF5laScjckCgrRAZhyTV6bKlvlibhVTZRgRY7RryaETSIvjLjnRw/
	d1D+/D/GJRTMGOjoIPy3LZpUIfmNPXaM3Ze5COMZypXOH5ydAjnGY58rl58/7QpqHD2mAm
	lD9tc2Az1ZCwayFnMysAC5Zbunqv6sc=
From: Lauri Vasama <git@vasama.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Lauri Vasama <git@vasama.org>,
	Jan Kara <jack@suse.cz>,
	Simon Horman <horms@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] Add RWF_NOSIGNAL flag for pwritev2
Date: Wed, 27 Aug 2025 16:39:00 +0300
Message-ID: <20250827133901.1820771-1-git@vasama.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

For a user mode library to avoid generating SIGPIPE signals (e.g.
because this behaviour is not portable across operating systems) is
cumbersome. It is generally bad form to change the process-wide signal
mask in a library, so a local solution is needed instead.

For I/O performed directly using system calls (synchronous or readiness
based asynchronous) this currently involves applying a thread-specific
signal mask before the operation and reverting it afterwards. This can be
avoided when it is known that the file descriptor refers to neither a
pipe nor a socket, but a conservative implementation must always apply
the mask. This incurs the cost of two additional system calls. In the
case of sockets, the existing MSG_NOSIGNAL flag can be used with send.

For asynchronous I/O performed using io_uring, currently the only option
(apart from MSG_NOSIGNAL for sockets), is to mask SIGPIPE entirely in the
call to io_uring_enter. Thankfully io_uring_enter takes a signal mask, so
only a single syscall is needed. However, copying the signal mask on
every call incurs a non-zero performance penalty. Furthermore, this mask
applies to all completions, meaning that if the non-signaling behaviour
is desired only for some subset of operations, the desired signals must
be raised manually from user-mode depending on the completed operation.

Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE signal
from being raised when writing on disconnected pipes or sockets. The flag
is handled directly by the pipe filesystem and converted to the existing
MSG_NOSIGNAL flag for sockets.

Signed-off-by: Lauri Vasama <git@vasama.org>
---
 fs/pipe.c               | 6 ++++--
 include/linux/fs.h      | 1 +
 include/uapi/linux/fs.h | 5 ++++-
 net/socket.c            | 3 +++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 731622d0738d..42fead1efe52 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -458,7 +458,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	mutex_lock(&pipe->mutex);
 
 	if (!pipe->readers) {
-		send_sig(SIGPIPE, current, 0);
+		if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
+			send_sig(SIGPIPE, current, 0);
 		ret = -EPIPE;
 		goto out;
 	}
@@ -498,7 +499,8 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 
 	for (;;) {
 		if (!pipe->readers) {
-			send_sig(SIGPIPE, current, 0);
+			if ((iocb->ki_flags & IOCB_NOSIGNAL) == 0)
+				send_sig(SIGPIPE, current, 0);
 			if (!ret)
 				ret = -EPIPE;
 			break;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..e440c5ae5d99 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -356,6 +356,7 @@ struct readahead_control;
 #define IOCB_APPEND		(__force int) RWF_APPEND
 #define IOCB_ATOMIC		(__force int) RWF_ATOMIC
 #define IOCB_DONTCACHE		(__force int) RWF_DONTCACHE
+#define IOCB_NOSIGNAL		(__force int) RWF_NOSIGNAL
 
 /* non-RWF related bits - start at 16 */
 #define IOCB_EVENTFD		(1 << 16)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 0bd678a4a10e..beb4c2d1e41c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -430,10 +430,13 @@ typedef int __bitwise __kernel_rwf_t;
 /* buffered IO that drops the cache after reading or writing data */
 #define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
 
+/* prevent pipe and socket writes from raising SIGPIPE */
+#define RWF_NOSIGNAL	((__force __kernel_rwf_t)0x00000100)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
 			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
-			 RWF_DONTCACHE)
+			 RWF_DONTCACHE | RWF_NOSIGNAL)
 
 #define PROCFS_IOCTL_MAGIC 'f'
 
diff --git a/net/socket.c b/net/socket.c
index 682969deaed3..bac335ecee4c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1176,6 +1176,9 @@ static ssize_t sock_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (sock->type == SOCK_SEQPACKET)
 		msg.msg_flags |= MSG_EOR;
 
+	if (iocb->ki_flags & IOCB_NOSIGNAL)
+		msg.msg_flags |= MSG_NOSIGNAL;
+
 	res = __sock_sendmsg(sock, &msg);
 	*from = msg.msg_iter;
 	return res;

base-commit: fab1beda7597fac1cecc01707d55eadb6bbe773c
-- 
2.43.0


