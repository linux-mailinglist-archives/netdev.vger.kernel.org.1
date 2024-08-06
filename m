Return-Path: <netdev+bounces-116270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EBE949B8A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 00:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B668028474B
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 22:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7B178397;
	Tue,  6 Aug 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gK9VOtEJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5B1178381;
	Tue,  6 Aug 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722984620; cv=none; b=pzODR4dl52FFdxK9GwLR4EYj9TXOBqGA+wqbmPYq+ED3sXecvV3W1xMer0aDWzSmcJoA7UE1Fiv1NtEYYpxyUjx4qwODNKBmSNGXN4uwoiCoZx++e4QwUhSFIggmaxBu8SOqmH//gZCwRThb4B7219w4XMYg0StAD08LMJnJP8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722984620; c=relaxed/simple;
	bh=3b3HeWBqA+k/ZS8D7tL/hj7cKIV21t1HBhctoaBI+7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xifaey0Ktz2v0Wi6efPVxesxXNhQI70jWGz3RY6IE+VXgOyCzpCAXyL68Sxo7rqFpspCiCLvKvQCnk0svGe0+xoNrU8bkndhDwiwyycRUno5O7RXKf/cIhTHNdnTqjwu45UVBHamuwVO51gbu9axrcL1RL5U72pDhAzW1RTxLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gK9VOtEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB15C4AF16;
	Tue,  6 Aug 2024 22:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722984620;
	bh=3b3HeWBqA+k/ZS8D7tL/hj7cKIV21t1HBhctoaBI+7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gK9VOtEJv7MRsheqgdSoDQiYYeqWfF7V1TmwbNaCJKmEuu7I5sZfSX/yU3ofcZDTX
	 mF9/dcQnaL8RHeWkcV+vHLpVxJ5JaNHI0zXRIUACB/qFWIgnqBbenoC47AkgJ2bBJv
	 GJr8ctTceWV4og1UW/N96D56wNFkK7rhtE8DlOKehdPxc0oVDUXWPhphMNbhcHtFtk
	 H7Hg5AUimYfSWuXBCyVnNhnkcNxQ/kYxBXcC5LERb0+qFthODMma+lzynqd0kY4uYz
	 Mp7GMTU0S8OeX3LEb75hdxVKRrwxhND4a5wzRPKHtsoQRbuvuhywJ4OvP+mm7f6y1a
	 PZrWyslQ8dRvA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 07/10] tools/include: Sync network socket headers with the kernel sources
Date: Tue,  6 Aug 2024 15:50:10 -0700
Message-ID: <20240806225013.126130-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
In-Reply-To: <20240806225013.126130-1-namhyung@kernel.org>
References: <20240806225013.126130-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  d25a92ccae6b net/smc: Introduce IPPROTO_SMC
  060f4ba6e403 io_uring/net: move charging socket out of zc io_uring
  bb6aaf736680 net: Split a __sys_listen helper for io_uring
  dc2e77979412 net: Split a __sys_bind helper for io_uring

This should be used to beautify socket syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
  diff -u tools/perf/trace/beauty/include/linux/socket.h include/linux/socket.h

Please see tools/include/uapi/README for details (it's in the first patch
of this series).

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/in.h                  | 2 ++
 tools/perf/trace/beauty/include/linux/socket.h | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index e682ab628dfa..d358add1611c 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -81,6 +81,8 @@ enum {
 #define IPPROTO_ETHERNET	IPPROTO_ETHERNET
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
+  IPPROTO_SMC = 256,		/* Shared Memory Communications		*/
+#define IPPROTO_SMC		IPPROTO_SMC
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
 #define IPPROTO_MPTCP		IPPROTO_MPTCP
   IPPROTO_MAX
diff --git a/tools/perf/trace/beauty/include/linux/socket.h b/tools/perf/trace/beauty/include/linux/socket.h
index 89d16b90370b..df9cdb8bbfb8 100644
--- a/tools/perf/trace/beauty/include/linux/socket.h
+++ b/tools/perf/trace/beauty/include/linux/socket.h
@@ -76,7 +76,7 @@ struct msghdr {
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
 	struct kiocb	*msg_iocb;	/* ptr to iocb for async requests */
 	struct ubuf_info *msg_ubuf;
-	int (*sg_from_iter)(struct sock *sk, struct sk_buff *skb,
+	int (*sg_from_iter)(struct sk_buff *skb,
 			    struct iov_iter *from, size_t length);
 };
 
@@ -442,11 +442,14 @@ extern int __sys_accept4(int fd, struct sockaddr __user *upeer_sockaddr,
 extern int __sys_socket(int family, int type, int protocol);
 extern struct file *__sys_socket_file(int family, int type, int protocol);
 extern int __sys_bind(int fd, struct sockaddr __user *umyaddr, int addrlen);
+extern int __sys_bind_socket(struct socket *sock, struct sockaddr_storage *address,
+			     int addrlen);
 extern int __sys_connect_file(struct file *file, struct sockaddr_storage *addr,
 			      int addrlen, int file_flags);
 extern int __sys_connect(int fd, struct sockaddr __user *uservaddr,
 			 int addrlen);
 extern int __sys_listen(int fd, int backlog);
+extern int __sys_listen_socket(struct socket *sock, int backlog);
 extern int __sys_getsockname(int fd, struct sockaddr __user *usockaddr,
 			     int __user *usockaddr_len);
 extern int __sys_getpeername(int fd, struct sockaddr __user *usockaddr,
-- 
2.46.0.rc2.264.g509ed76dc8-goog


