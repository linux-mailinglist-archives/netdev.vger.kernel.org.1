Return-Path: <netdev+bounces-183756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD4A91D73
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4753ACCC2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756F22451E0;
	Thu, 17 Apr 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAXztTpY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38924DFE2;
	Thu, 17 Apr 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895487; cv=none; b=TwOsQRj0GOZeHlbUsyflWYnaKQGM/Wk4FDz4zws6EbjeG1DATjF+Hn/xOuh7KLuHjdOSciGeix6gC/fccnSm4yT8etU94v0NP9fXGrLjivjEHcM+AN7M8wlxN++mxXEol7ulD6yvJVE/m3SLKwQYh1Cs2pGPKv2CK/ljOmNx30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895487; c=relaxed/simple;
	bh=6qwNLfV08a081p8l5NdqWtBl1v6XpiD3YghkRvP5Q64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4M9cISA5j4c2Jo/nbAgcEOrFCMdW7FI6pBF9fJJRoB0K7XKzWkD/nGSels3h27nv/tpxZOolOJ/rlat8f28cufaTFqnhPw0S7Xq8KqgACEVJ/Wo7r0vTbd1nh3nFFobkbLAHtGDv27hp6TxyKD/BKuGP6D1BM+V+BCpNJZvZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAXztTpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6754C4CEEB;
	Thu, 17 Apr 2025 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895486;
	bh=6qwNLfV08a081p8l5NdqWtBl1v6XpiD3YghkRvP5Q64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sAXztTpYkuKtJiMo5Dj7Wk3egZifONi13v5uA4p2U5yfun1HN2oj/O9wMgFK+oonG
	 AQTrOME0gWBdRQ07zcoN2+JrvGOQzpHUlL3YQcwLXrGEieDc64Ni8a+2qZYihpNpIj
	 bbtQYWahhFNzgyakZfb9QBbYoO/TQmeXxoJzkDiqfzflMjuOh4FuOxgk/baNSCib8z
	 DAprdPUA39Zu9KYEz0DVN5Yqq6oTYyOfc8Jtjd99nWKvmJ0CaWw7kSoSE8b4nSm4ai
	 IU7w6piPvX/Iljsx4Tt4nZLkG/omMOuCL4kgFt8irurQW88fpIafCZbonEWgQmA3PW
	 Zbh0mQSTIAZgg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:08 -0400
Subject: [PATCH v3 5/8] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-5-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4721; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=6qwNLfV08a081p8l5NdqWtBl1v6XpiD3YghkRvP5Q64=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP328Pnh4XIGauu7eNH34xHdvP3fkm9eq8aEt
 vRxMAuIfuqJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99gAKCRAADmhBGVaC
 FQQGD/9WZCNs2HMR8vVqnszE4GtbpM5AyYbLOPJI25pDLYtuFefAsoh0kHpfBCNwnqijOSnlLyx
 eCem742jNsj6REcDPqBIA6nhRN0Ek95G3cGTv0/iJQHF57utJvuGVyQ8n8SAeWwcjSF7SI5a1GV
 MCPoctKL0+KKFPJlsTmI5As2PWuH1wVZtZN0j40J0Ww1f62lSZs4MH0QVwGn+n1o2K/nxQIpfRK
 VJo+NNEt+CznLdw1GZgs/6CNbDWFUcdNZyyikPCG3tfCEBKsdlSNqMXkP4lOztei6gADmlX5Mx8
 Kzb2yzk8pbX4O7MD60gHX4wGXPrnCSOvQCGkmr6jF5Qrt0c9zqz6BbO2HuUpLU9XKDMr5ZNiXpv
 jIQgx2kPDWwz6n2EjDYMAJOHuTTVc49D9/7peoiAvbTZw78249+t2M+1XoUJC3OJTumvdO/0Lui
 WJVBhcMBJ4cVsH6lIL8v/QsUtkNicS5HPt5rQMyIA8Qc6aSHoHQXHdRd+1GBYeDHpzDbv0mXI6d
 YQoCs3kMWiQv4rRNdDdJhNBkWYS3kqylo1FIze+QycWtw4vqE/A5ThKS+dMKFkYvbS+jnl4HP3j
 Y8pmkpUE0sW1jMBE/Ah2dMgXCwYLyVgz37/StJ6Aim9pT6OJTH5rIfGVgm78JfL2puaOx0zKmZR
 bYd0lRNpb9xLO1A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, there is no convenient way to see the info that the
ref_tracking infrastructure collects. Add a new function that other
subsystems can optionally call to update the name field in the
ref_tracker_dir and register a corresponding seq_file for it in the
top-level ref_tracker directory.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 13 +++++++++++
 lib/ref_tracker.c           | 57 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 8eac4f3d52547ccbaf9dcd09962ce80d26fbdff8..77a55a32c067216fa02ba349498f53bd289aee0c 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 struct ref_tracker;
 
@@ -17,6 +18,9 @@ struct ref_tracker_dir {
 	bool			dead;
 	struct list_head	list; /* List of active trackers */
 	struct list_head	quarantine; /* List of dead trackers */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*dentry;
+#endif
 	char			name[32];
 #endif
 };
@@ -34,10 +38,15 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 	dir->dead = false;
 	refcount_set(&dir->untracked, 1);
 	refcount_set(&dir->no_tracker, 1);
+#ifdef CONFIG_DEBUG_FS
+	dir->dentry = NULL;
+#endif
 	strscpy(dir->name, name, sizeof(dir->name));
 	stack_depot_init();
 }
 
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir, const char *name);
+
 void ref_tracker_dir_exit(struct ref_tracker_dir *dir);
 
 void ref_tracker_dir_print_locked(struct ref_tracker_dir *dir,
@@ -62,6 +71,10 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 {
 }
 
+static inline void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir, const char *name)
+{
+}
+
 static inline void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 {
 }
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 4857bcb6d4bf557a0089f51328e75e8209e959e6..d53105b959c122a85558cbe84551726f6429e08e 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -31,6 +31,14 @@ struct ref_tracker_dir_stats {
 	} stacks[];
 };
 
+#ifdef CONFIG_DEBUG_FS
+static void ref_tracker_debugfs_remove(struct ref_tracker_dir *dir);
+#else
+static inline void ref_tracker_debugfs_remove(struct ref_tracker_dir *dir)
+{
+}
+#endif
+
 static struct ref_tracker_dir_stats *
 ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 {
@@ -197,6 +205,7 @@ void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 	bool leak = false;
 
 	dir->dead = true;
+	ref_tracker_debugfs_remove(dir);
 	spin_lock_irqsave(&dir->lock, flags);
 	list_for_each_entry_safe(tracker, n, &dir->quarantine, head) {
 		list_del(&tracker->head);
@@ -327,6 +336,54 @@ static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_fil
 	return os.used;
 }
 
+static int ref_tracker_debugfs_show(struct seq_file *f, void *v)
+{
+	struct ref_tracker_dir *dir = f->private;
+
+	return ref_tracker_dir_seq_print(dir, f);
+}
+
+static int ref_tracker_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct ref_tracker_dir *dir = inode->i_private;
+
+	return single_open(filp, ref_tracker_debugfs_show, dir);
+}
+
+static const struct file_operations ref_tracker_debugfs_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ref_tracker_debugfs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+/**
+ * ref_tracker_dir_debugfs - create debugfs file for ref_tracker_dir
+ * @dir: ref_tracker_dir to finalize
+ * @name: updated name of the ref_tracker_dir
+ *
+ * In some cases, the name given to a ref_tracker_dir is based on incomplete information,
+ * and may not be unique. Call this to finalize the name of @dir, and create a debugfs
+ * file for it. If the name is not unique, a warning will be emitted but it is not fatal
+ * to the tracker.
+ */
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir, const char *name)
+{
+	dir->dentry = debugfs_create_file(name, S_IFREG | 0400,
+					  ref_tracker_debug_dir, dir,
+					  &ref_tracker_debugfs_fops);
+	if (IS_ERR(dir->dentry))
+		pr_warn("ref_tracker: unable to create debugfs file for %s: %pe\n",
+			name, dir->dentry);
+}
+EXPORT_SYMBOL(ref_tracker_dir_debugfs);
+
+static void ref_tracker_debugfs_remove(struct ref_tracker_dir *dir)
+{
+	debugfs_remove(dir->dentry);
+}
+
 static int __init ref_tracker_debugfs_init(void)
 {
 	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);

-- 
2.49.0


