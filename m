Return-Path: <netdev+bounces-182270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899AA8861A
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2733A3BA694
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 14:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51928466F;
	Mon, 14 Apr 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHix8buo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234E27990C;
	Mon, 14 Apr 2025 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641958; cv=none; b=TyqRGRMY2DoYQ41h1w89QgNqvqNJurnu00SXJ6JI90M96wcf86q+2ZY0WC8jyJ1OPtqfb5U2LabxkRB3laTpaAOoHkKrA4uE82P3iwXdn+sSOTyIQOeV9b3xvZA9xgYAKCO4kznuc+NbakEao858YSfrkkB07RtaWtoat8gD9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641958; c=relaxed/simple;
	bh=XBZvlZ0SdxFGpx32+WA7hNOkQ8CEyXU9W3CJef/2nwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=htLjd1p1AXvsFfMdFUtbjLdxxDfqBkFODVEeYxEPPuU5ZI/fEcpgeLMC2xfxI+s4i7cLxYe1kbEoca7Cadle611lrNYru1oy+f/p8zWzW6E4v43CvE7GQZdbEdAXSfJQBb5wVhQx1lTu6Nz+hl2Kd33qj/8YJQAY4EC1cEc4PDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHix8buo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE47C4CEE2;
	Mon, 14 Apr 2025 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641958;
	bh=XBZvlZ0SdxFGpx32+WA7hNOkQ8CEyXU9W3CJef/2nwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fHix8buosuw5Fbb92XljZVxg3l/vMz8JaAAY9AOgrU/668RpduCK7U4FP0EJSiF9r
	 huET3sXyNMzpA1zpDUocq1XDjqNYmirolz6Y2In6Qlpt2BsMsByUbolv6zu2e4dnKk
	 gaFT3S2PuLPpA4Bo5kK0ZIMm9GAcMAGLIIJkQLr0KXuc6XYi0tUKL/vmFH9KvLneFU
	 3MJRZwzxzritAXNFJy1T7C5CueB+LCYx/Gy5j4l7Kd11s20OQeo69S8LyEu3RDJu27
	 iHtEYV7EqiIJEnP7OZM2vH3d65eBgIpUoHHI4ccl3X50IkCIlKkg8w8DcO9llqxNiM
	 RotzkV8zGTrDA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 14 Apr 2025 10:45:47 -0400
Subject: [PATCH 2/4] ref_tracker: add ability to register a file in debugfs
 for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-reftrack-dbgfs-v1-2-f03585832203@kernel.org>
References: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
In-Reply-To: <20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6233; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XBZvlZ0SdxFGpx32+WA7hNOkQ8CEyXU9W3CJef/2nwI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/R+h472UuOZ40DXg7VKHLHPxuZREfFp4Z5CwF
 DelGmrR1mSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/0foQAKCRAADmhBGVaC
 FceOD/0T4cwLe0yu3aODVe1oYuCSAuXSk+F83nKl/+M/G6QIq6GBOPPe6neFp7qoeawBXOTfFi4
 KwkX6hPuUxx+2PU2zSE7Zkv+TXOU19q1ADvaFuPNQhdjB48NBOj7dMQdnDrgKjOE7KSKyeFlgnW
 NlpEzFLwrC17Ak+seU2/cPDBijabQTgGtk50jDmcP60gqPMwnGDjcmAKLnHyTYdTxC/tgUQZaP+
 SnpHzlMwsUMt6wQQCHKBqc5tWc2Xan8HbG3kRIZtYgtjSvPxlTeleYMtUEdK0rzNWz97xSgM4E+
 kaQK+KXVsyX4tKJWtH2R+1/xC1flmWA3bVPbuIIxy+KAcV9jRsByRgJp/PdHN8YJQZcqrjszSjd
 CP1HB7Rzv3ZHNxM3/xYn5XaNSrzuEuGUCOeWQL7EGm43CygjmOzSwghePcAa2BbfaNyqgzo9rCF
 5ZwjBFJliB2ykrxvOXQyiLw2dyQZt7lAd59j/Pab3TFvhjWun4/BOsBZXirT7+f0/eXZAncyFxb
 6ax2ZILuOTCB2wZo/SngPTMlNwmjq4MWv7dPIV835gvENRdRVcrRfZPgGoqDcQfx8+ykwmqMcTY
 7RhGxk/hpbAYP0ZSalg03HhghuqymjJKYUOs0nSGdVTYlbfGNBji7YbRZIiCWTv9l0Es7kJ3IQA
 st6Ml+IgO6+jdew==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, there is no convenient way to see the info that the
ref_tracking infrastructure collects. Add a new function that other
subsystems can optionally call to update the name field in the
ref_tracker_dir and register a corresponding seq_file for it in the
top-level ref_tracker directory.

Also, alter the pr_ostream infrastructure to allow the caller to specify
a seq_file to which the output should go instead of printing to an
arbitrary buffer or the kernel's ring buffer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 13 +++++++
 lib/ref_tracker.c           | 84 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 3 deletions(-)

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
index c96994134fe1ddfcbf644cc75b36b7e94461ec48..10452f66283b081460ef7f4f5640e30487bb1595 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
@@ -30,6 +31,14 @@ struct ref_tracker_dir_stats {
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
@@ -66,6 +75,7 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 
 struct ostream {
 	char *buf;
+	struct seq_file *seq;
 	int size, used;
 };
 
@@ -73,7 +83,9 @@ struct ostream {
 ({ \
 	struct ostream *_s = (stream); \
 \
-	if (!_s->buf) { \
+	if (_s->seq) { \
+		seq_printf(_s->seq, fmt, ##args); \
+	} else if (!_s->buf) { \
 		pr_err(fmt, ##args); \
 	} else { \
 		int ret, len = _s->size - _s->used; \
@@ -163,6 +175,7 @@ void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 	bool leak = false;
 
 	dir->dead = true;
+	ref_tracker_debugfs_remove(dir);
 	spin_lock_irqsave(&dir->lock, flags);
 	list_for_each_entry_safe(tracker, n, &dir->quarantine, head) {
 		list_del(&tracker->head);
@@ -279,7 +292,72 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static int __init ref_tracker_debug_init(void)
+static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
+{
+	struct ostream os = { .seq = seq };
+	unsigned long flags;
+
+	spin_lock_irqsave(&dir->lock, flags);
+	__ref_tracker_dir_pr_ostream(dir, 16, &os);
+	spin_unlock_irqrestore(&dir->lock, flags);
+
+	return os.used;
+}
+
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
+ * file for it.
+ */
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir, const char *name)
+{
+	strscpy(dir->name, name, sizeof(dir->name));
+
+	if (ref_tracker_debug_dir) {
+		dir->dentry = debugfs_create_file(dir->name, S_IFREG | 0400,
+						  ref_tracker_debug_dir, dir,
+						  &ref_tracker_debugfs_fops);
+		if (IS_ERR(dir->dentry)) {
+			pr_warn("ref_tracker: unable to create debugfs file for %s: %pe\n",
+				dir->name, dir->dentry);
+			dir->dentry = NULL;
+		}
+	}
+}
+EXPORT_SYMBOL(ref_tracker_dir_debugfs);
+
+static void ref_tracker_debugfs_remove(struct ref_tracker_dir *dir)
+{
+	debugfs_remove(dir->dentry);
+}
+
+static int __init ref_tracker_debugfs_init(void)
 {
 	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
 	if (IS_ERR(ref_tracker_debug_dir)) {
@@ -289,5 +367,5 @@ static int __init ref_tracker_debug_init(void)
 	}
 	return 0;
 }
-late_initcall(ref_tracker_debug_init);
+late_initcall(ref_tracker_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


