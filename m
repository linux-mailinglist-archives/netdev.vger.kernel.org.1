Return-Path: <netdev+bounces-175586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF6A667D2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5426616771A
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167518FC86;
	Tue, 18 Mar 2025 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EmSi7XN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7774E2114
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269894; cv=none; b=abktT/+EaJ0hp0Ah/HZmjDLgZMDJAr/yrOPa1Uz9+0pLuRGOGyn2EyV2DMKDaS8VqETkPJZ3vxhQGAMP+Eqe4L6OWGZascd6n2RAVtoKfvAdROqJht0Jl4oxSeI/HnUk3lCTX0C97c1qQ/z+UhfCh9SmKSbeIm3wO28XUz8HHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269894; c=relaxed/simple;
	bh=dH1vFL5tTM2cFmZzOmHd4O/Idu7xOuNcANf0oPXR3qY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKQfTtu9yrh+1J+HIflbKbE4vEZm6hLYGvz5RXKfVMhTuq0mVbe2/RxG/qWvBDOtHgvcdNnlXvWG7Ew8DXXMYVJJAjGK9nv8Y2+wqtZFoI+7cdJiaXjV22z6wl45VPshtWpG27ltmzy+uLt1SFpt+zlWXNVgT5K+havXpyAqw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EmSi7XN8; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742269893; x=1773805893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ibExYCl7BiZkDrdJSJxoMg3jdRAxYXq7FibqYggH8NI=;
  b=EmSi7XN8h9XU7KQRz0v4ALfe03AeGIBS61EnyN6a2VWZE4aXL9jwG7sV
   n4RAKqyGAO3sfDh6JfBXocVzaq+06qC+7y9DJHd42eN/J4eJXB3qIloAk
   m4AM5SQ6o/Yr6ACBGnQ9yeNPaU845uTLGCQ3E0ZWImaPswRCPfjeHxq0J
   0=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736812800"; 
   d="scan'208";a="481240229"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:51:31 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:59034]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.243:2525] with esmtp (Farcaster)
 id ecb416b6-b2ef-443a-abbc-c130eb1051e7; Tue, 18 Mar 2025 03:51:29 +0000 (UTC)
X-Farcaster-Flow-ID: ecb416b6-b2ef-443a-abbc-c130eb1051e7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:51:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:51:26 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 4/4] af_unix: Clean up #include under net/unix/.
Date: Mon, 17 Mar 2025 20:48:51 -0700
Message-ID: <20250318034934.86708-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net/unix/*.c include many unnecessary header files (rtnetlink.h,
netdevice.h, etc).

Let's clean them up.

af_unix.c:

  +uapi/linux/sockios.h   : Only exist under include/uapi
  +uapi/linux/termios.h   : Only exist under include/uapi

  -linux/freezer.h        : No longer use freezable_schedule_timeout()
  -linux/in.h             : No ipv4_is_XXX() etc
  -linux/module.h         : No longer support CONFIG_UNIX=m
  -linux/netdevice.h      : No dev used
  -linux/rtnetlink.h      : Not part of rtnetlink API
  -linux/signal.h         : signal_pending() is defined in sched/signal.h
  -linux/stat.h           : No struct stat used
  -net/checksum.h         : CHECKSUM_UNNECESSARY is defined in skbuff.h

diag.c:

  +linux/dcache.h         : struct dentry in sk_diag_dump_vfs()
  +linux/user_namespace.h : struct user_namespace in sk_diag_dump_uid()
  +uapi/linux/unix_diag.h : Only exist under include/uapi/

garbage.c:

  +linux/list.h           : struct unix_{vertex,edge}, etc
  +linux/workqueue.h      : DECLARE_WORK(unix_gc_work, ...)

  -linux/file.h           : No fget() etc
  -linux/kernel.h         : No cond_resched() etc
  -linux/netdevice.h      : No dev used
  -linux/proc_fs.h        : No procfs provided
  -linux/string.h         : No memcpy(), kmemdup(), etc

sysctl_net_unix.c:

  +linux/string.h         : kmemdup()
  +net/net_namespace.h    : struct net, net_eq()

  -linux/mm.h             : slab.h is enough

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c         | 12 ++----------
 net/unix/diag.c            |  4 +++-
 net/unix/garbage.c         |  7 ++-----
 net/unix/sysctl_net_unix.c |  3 ++-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c081440cf576..f78a2492826f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -84,36 +84,28 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/filter.h>
-#include <linux/freezer.h>
 #include <linux/fs.h>
-#include <linux/in.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
-#include <linux/netdevice.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
-#include <linux/rtnetlink.h>
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 #include <linux/seq_file.h>
-#include <linux/signal.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/socket.h>
-#include <linux/sockios.h>
 #include <linux/splice.h>
-#include <linux/stat.h>
 #include <linux/string.h>
-#include <linux/termios.h>
 #include <linux/uaccess.h>
 #include <net/af_unix.h>
-#include <net/checksum.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
 #include <net/tcp_states.h>
+#include <uapi/linux/sockios.h>
+#include <uapi/linux/termios.h>
 
 #include "af_unix.h"
 
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 8b2247e05596..79b182d0e62a 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -1,13 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/dcache.h>
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/sock_diag.h>
 #include <linux/types.h>
-#include <linux/unix_diag.h>
+#include <linux/user_namespace.h>
 #include <net/af_unix.h>
 #include <net/netlink.h>
 #include <net/tcp_states.h>
+#include <uapi/linux/unix_diag.h>
 
 #include "af_unix.h"
 
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index cd75502c47f1..01e2b9452c75 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -63,14 +63,11 @@
  *		wrt receive and holding up unrelated socket operations.
  */
 
-#include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/netdevice.h>
-#include <linux/proc_fs.h>
+#include <linux/list.h>
 #include <linux/skbuff.h>
 #include <linux/socket.h>
-#include <linux/string.h>
+#include <linux/workqueue.h>
 #include <net/af_unix.h>
 #include <net/scm.h>
 #include <net/tcp_states.h>
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 236b7faa9254..e02ed6e3955c 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -5,10 +5,11 @@
  * Authors:	Mike Shaver.
  */
 
-#include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/sysctl.h>
 #include <net/af_unix.h>
+#include <net/net_namespace.h>
 
 #include "af_unix.h"
 
-- 
2.48.1


