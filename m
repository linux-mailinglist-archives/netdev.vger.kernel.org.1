Return-Path: <netdev+bounces-175583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB49A667C8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA68F1646EA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B215B554;
	Tue, 18 Mar 2025 03:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NjGJJ634"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC27C14AD0D
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269822; cv=none; b=K54IUk2H3ozc3gQiiPArNjpi3G6drWw8bfHp0UHrSDOv+VLGbJQ0KnBlLJwN5OnnWAjEIVVKHoHiotLfZc48i8SRvu8LsiBrNoMXGZsBLcvuGXUg0PF2X/hnxFOiUzhi9h49pCe+bkw5jNgtSVxbG74UwVW1t3kPFaEvtuldl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269822; c=relaxed/simple;
	bh=lCivVYCZhoVRtZs11fD1ihsv0ZyYpYTwkEmwZckhtz0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g2i4AiUf40ezthhxJbl07CYmzqI1XMDlrmy9wvQ8UIOo1i5o9icXfXtkn9wLeJtHvDSw9YRlgRk1LzUc7jNOnK0yxtLNzQa6tNIUBm6Np1moAJ3MLQr3O7SXueVtMUIMfHFNovoJmV75vCE+4P4fmZTN02CgTrKhEcLZqH/Gn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NjGJJ634; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742269822; x=1773805822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1linzMrVLP7C94NGdIv3oWI07a1/ziMGwBU61TWlW4=;
  b=NjGJJ634uSaAOndn7CsVanE68L5OJlDjFP/F0ygHlCLyQK+w+3/k9U6y
   hhRKV4mVSs0GiqQ90BX0GVXoibiyMy/ImIG+V/XoF/HHURm6O6lA0XmXS
   vTAMDemXjDY3SMa18iikU/0AtXQZZSJY+jdRSvcvCLraJOru+0NkfyIWw
   0=;
X-IronPort-AV: E=Sophos;i="6.14,255,1736812800"; 
   d="scan'208";a="471937724"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:50:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:53428]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.40:2525] with esmtp (Farcaster)
 id 15a97ad3-e7d4-44ea-a61d-ee38d583432f; Tue, 18 Mar 2025 03:50:14 +0000 (UTC)
X-Farcaster-Flow-ID: 15a97ad3-e7d4-44ea-a61d-ee38d583432f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:50:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.54) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 03:50:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 1/4] af_unix: Sort headers.
Date: Mon, 17 Mar 2025 20:48:48 -0700
Message-ID: <20250318034934.86708-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep patch to make the following changes cleaner.

No functional change intended.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/af_unix.h      |  4 +--
 net/unix/af_unix.c         | 62 +++++++++++++++++++-------------------
 net/unix/diag.c            | 15 ++++-----
 net/unix/garbage.c         | 17 +++++------
 net/unix/sysctl_net_unix.c |  1 -
 net/unix/unix_bpf.c        |  4 +--
 6 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 63129c79b8cb..c8dfdb41916d 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -2,10 +2,10 @@
 #ifndef __LINUX_NET_AFUNIX_H
 #define __LINUX_NET_AFUNIX_H
 
-#include <linux/socket.h>
-#include <linux/un.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/socket.h>
+#include <linux/un.h>
 #include <net/sock.h>
 
 #if IS_ENABLED(CONFIG_UNIX)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 7f8f3859cdb3..1ff0ac99f3f3 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -77,46 +77,46 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/signal.h>
-#include <linux/sched/signal.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/stat.h>
+#include <linux/bpf-cgroup.h>
+#include <linux/btf_ids.h>
 #include <linux/dcache.h>
-#include <linux/namei.h>
-#include <linux/socket.h>
-#include <linux/un.h>
+#include <linux/errno.h>
 #include <linux/fcntl.h>
+#include <linux/file.h>
 #include <linux/filter.h>
-#include <linux/termios.h>
-#include <linux/sockios.h>
-#include <linux/net.h>
-#include <linux/in.h>
+#include <linux/freezer.h>
 #include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/uaccess.h>
-#include <linux/skbuff.h>
-#include <linux/netdevice.h>
-#include <net/net_namespace.h>
-#include <net/sock.h>
-#include <net/tcp_states.h>
-#include <net/af_unix.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <net/scm.h>
+#include <linux/in.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/net.h>
+#include <linux/netdevice.h>
 #include <linux/poll.h>
+#include <linux/proc_fs.h>
 #include <linux/rtnetlink.h>
-#include <linux/mount.h>
-#include <net/checksum.h>
+#include <linux/sched/signal.h>
 #include <linux/security.h>
+#include <linux/seq_file.h>
+#include <linux/signal.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/socket.h>
+#include <linux/sockios.h>
 #include <linux/splice.h>
-#include <linux/freezer.h>
-#include <linux/file.h>
-#include <linux/btf_ids.h>
-#include <linux/bpf-cgroup.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/termios.h>
+#include <linux/uaccess.h>
+#include <linux/un.h>
+#include <net/af_unix.h>
+#include <net/checksum.h>
+#include <net/net_namespace.h>
+#include <net/scm.h>
+#include <net/sock.h>
+#include <net/tcp_states.h>
 
 static atomic_long_t unix_nr_socks;
 static struct hlist_head bsd_socket_buckets[UNIX_HASH_SIZE / 2];
diff --git a/net/unix/diag.c b/net/unix/diag.c
index 9138af8b465e..ba715507556a 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -1,15 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <linux/types.h>
-#include <linux/spinlock.h>
-#include <linux/sock_diag.h>
-#include <linux/unix_diag.h>
-#include <linux/skbuff.h>
+
 #include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/sock_diag.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
 #include <linux/uidgid.h>
-#include <net/netlink.h>
+#include <linux/unix_diag.h>
 #include <net/af_unix.h>
-#include <net/tcp_states.h>
+#include <net/netlink.h>
 #include <net/sock.h>
+#include <net/tcp_states.h>
 
 static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
 {
diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 9848b7b78701..6a641d4b5542 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -63,22 +63,21 @@
  *		wrt receive and holding up unrelated socket operations.
  */
 
+#include <linux/file.h>
+#include <linux/fs.h>
 #include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/socket.h>
-#include <linux/un.h>
+#include <linux/mutex.h>
 #include <linux/net.h>
-#include <linux/fs.h>
-#include <linux/skbuff.h>
 #include <linux/netdevice.h>
-#include <linux/file.h>
 #include <linux/proc_fs.h>
-#include <linux/mutex.h>
+#include <linux/skbuff.h>
+#include <linux/socket.h>
+#include <linux/string.h>
+#include <linux/un.h>
 #include <linux/wait.h>
-
-#include <net/sock.h>
 #include <net/af_unix.h>
 #include <net/scm.h>
+#include <net/sock.h>
 #include <net/tcp_states.h>
 
 struct unix_sock *unix_get_socket(struct file *filp)
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 357b3e5f3847..55118ae897d6 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -8,7 +8,6 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
-
 #include <net/af_unix.h>
 
 static struct ctl_table unix_table[] = {
diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
index bca2d86ba97d..86598a959eaa 100644
--- a/net/unix/unix_bpf.c
+++ b/net/unix/unix_bpf.c
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2021 Cong Wang <cong.wang@bytedance.com> */
 
-#include <linux/skmsg.h>
 #include <linux/bpf.h>
-#include <net/sock.h>
+#include <linux/skmsg.h>
 #include <net/af_unix.h>
+#include <net/sock.h>
 
 #define unix_sk_has_data(__sk, __psock)					\
 		({	!skb_queue_empty(&__sk->sk_receive_queue) ||	\
-- 
2.48.1


