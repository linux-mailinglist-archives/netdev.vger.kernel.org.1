Return-Path: <netdev+bounces-175585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A65AA667D1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C140B164AF5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AFE17A2E0;
	Tue, 18 Mar 2025 03:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M7myYGC9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACB22114
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269873; cv=none; b=T2vBIIR00/uqAo7BaTZkK05fAUnIG14U4aoHdXAbg977JQSd/Fb3A0OMSTcmvJhEH8UGn92AuqcAN5pUKxgxJ8+hUleuZU3y5Ja/SkbD0Z3RKvTA6f/I7ID6YoPInCg06exoApIm2kY7OWSd7yn1OpjC70/l1ZkeB8Ve08eRfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269873; c=relaxed/simple;
	bh=WTKnP05XLwFyKkRF/orQ6TX2IpgxFtOzBstEktUuEo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sAYAihuOMivEiS5wqgL+fitYvegi82aNB8HdBVQUIYD+wgCnnbvaqKBxn7M9uzXy7XGqpi85lYxS7SJlR/ZYPmA0EIXYOhRpiliFPcJTRal4EiULT33KdXosY1DIwj1k3DblYMfzJWdM1vo1U5FK80T46nHocj4RxnqVaVEQ7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M7myYGC9; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742269871; x=1773805871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CdELdiQWbkOh27E7Cfs/FfK7uvvMSKexMvGjY8Qhtt8=;
  b=M7myYGC98jHlr2K9g1z22IugCkh37Val8xwRMfqFp7WDKEbhLzQk7eqC
   fb7qHR/j0Ot0FRui+VDW6Fuggh1CgLVfjEfas/P3N6KipAE7wTnQ/kIh5
   4VN1qY642GrsGJH5xx0+mB5MSokQGtBgJbK25XUDYwn++xcWWs8f7UHbM
   s=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736812800"; 
   d="scan'208";a="481240168"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:51:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:20665]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.235:2525] with esmtp (Farcaster)
 id 9095c6df-7d9e-444e-9a2d-592418a0944a; Tue, 18 Mar 2025 03:51:06 +0000 (UTC)
X-Farcaster-Flow-ID: 9095c6df-7d9e-444e-9a2d-592418a0944a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:51:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:51:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/4] af_unix: Explicitly include headers for non-pointer struct fields.
Date: Mon, 17 Mar 2025 20:48:50 -0700
Message-ID: <20250318034934.86708-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318034934.86708-1-kuniyu@amazon.com>
References: <20250318034934.86708-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

include/net/af_unix.h indirectly includes some definitions for structs.

Let's include such headers explicitly.

  linux/atomic.h   : scm_stat.nr_fds
  linux/net.h      : unix_sock.peer_wq
  linux/path.h     : unix_sock.path
  linux/spinlock.h : unix_sock.lock
  linux/wait.h     : unix_sock.peer_wake
  uapi/linux/un.h  : unix_address.name[]

linux/socket.h is removed as the structs there are not used directly,
and linux/un.h is clarified with uapi as un.h only exists under
include/uapi.

While at it, duplicate headers are removed from .c files.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h | 8 ++++++--
 net/unix/af_unix.c    | 3 ---
 net/unix/diag.c       | 3 ---
 net/unix/garbage.c    | 5 -----
 net/unix/unix_bpf.c   | 1 -
 5 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index b5d70baba52b..b588069ece7e 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -2,11 +2,15 @@
 #ifndef __LINUX_NET_AFUNIX_H
 #define __LINUX_NET_AFUNIX_H
 
+#include <linux/atomic.h>
 #include <linux/mutex.h>
+#include <linux/net.h>
+#include <linux/path.h>
 #include <linux/refcount.h>
-#include <linux/socket.h>
-#include <linux/un.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 #include <net/sock.h>
+#include <uapi/linux/un.h>
 
 #if IS_ENABLED(CONFIG_UNIX)
 struct unix_sock *unix_get_socket(struct file *filp);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6390e04fe916..c081440cf576 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -92,7 +92,6 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
-#include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
@@ -110,12 +109,10 @@
 #include <linux/string.h>
 #include <linux/termios.h>
 #include <linux/uaccess.h>
-#include <linux/un.h>
 #include <net/af_unix.h>
 #include <net/checksum.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
-#include <net/sock.h>
 #include <net/tcp_states.h>
 
 #include "af_unix.h"
diff --git a/net/unix/diag.c b/net/unix/diag.c
index c7e8c7d008f6..8b2247e05596 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -3,13 +3,10 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/sock_diag.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/uidgid.h>
 #include <linux/unix_diag.h>
 #include <net/af_unix.h>
 #include <net/netlink.h>
-#include <net/sock.h>
 #include <net/tcp_states.h>
 
 #include "af_unix.h"
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 8c8c7360349d..cd75502c47f1 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -66,18 +66,13 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
-#include <linux/mutex.h>
-#include <linux/net.h>
 #include <linux/netdevice.h>
 #include <linux/proc_fs.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
 #include <linux/string.h>
-#include <linux/un.h>
-#include <linux/wait.h>
 #include <net/af_unix.h>
 #include <net/scm.h>
-#include <net/sock.h>
 #include <net/tcp_states.h>
 
 #include "af_unix.h"
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index 979dd4c4261a..e0d30d6d22ac 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -4,7 +4,6 @@
 #include <linux/bpf.h>
 #include <linux/skmsg.h>
 #include <net/af_unix.h>
-#include <net/sock.h>
 
 #include "af_unix.h"
 
-- 
2.48.1


