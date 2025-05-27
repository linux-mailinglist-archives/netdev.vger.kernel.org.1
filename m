Return-Path: <netdev+bounces-193627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46731AC4D9A
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0895F17DDAB
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD7726FDB3;
	Tue, 27 May 2025 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnjhh0za"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1BA26FD97;
	Tue, 27 May 2025 11:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345638; cv=none; b=Qc5FvZz6N8KdgcxThFOb2/+m/ABLMXQqLHmLrWcql2o8jMTIlabRzp2P/wMGrl2eahydsm4KC1qu5YjeGeJ79EzHrNN8W9QWLdmAwF96/av+PyIu3p+MhLC/yf0t9NYtCrqMa/DxQ6VD7wnkiKS530tCz27YefvHMyIyMoLz394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345638; c=relaxed/simple;
	bh=YUzGN4pDQEVUn13ezU+iyAv9BvSGVVgHmEotghHtWUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=udHwWVYXuWJX5DqVHUqlgFlY+X2xv5V3n6Eq8LFZ6qITptbzTo5K+2qkLAuAp3X/jDTZoUEF3MQ9jk/F/2AJgwKnkMxmlj68nWOOOy/rS+qlVQHZsWo9zhmsAPqk20b41e1WVwganePQy/ql5Re9zjVt4Xc/GCiXlYZx4PBxSj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnjhh0za; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DBFC4CEEF;
	Tue, 27 May 2025 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345637;
	bh=YUzGN4pDQEVUn13ezU+iyAv9BvSGVVgHmEotghHtWUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mnjhh0zaMGonQFqvwUhynv4VlkBwe3VguzvYDDybEEuQCNzBzoypxem9mcvi6Buas
	 mqVbhG4QJONLh9w4emj/m6QqLxFAadJsM3Z/0LCxpnFX7LY7RtAlgevgKOI7NbCW5h
	 cb7FJpU8CMnsMeLam4vbQUh/d8A71ZVhDt9Nm00yF715FU0hs7yj1m0SPEDO7+xqdv
	 We0MF331ICMRIWN2k2Xy4cVAWLJiQWDpQudUbSNw8s+npuHSi2usz8vyCCD/5tNU7c
	 q9J3CJs2TgWC/WkkDV0Q1KDdWwtSaQdk8V9W5NPefOFuRxhi6wpgBaL2nha0wIBmHZ
	 /XhH7OClK1NEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 07:33:37 -0400
Subject: [PATCH v10 6/9] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-reftrack-dbgfs-v10-6-dc55f7705691@kernel.org>
References: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
In-Reply-To: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5577; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YUzGN4pDQEVUn13ezU+iyAv9BvSGVVgHmEotghHtWUM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNaMWmtSvO1R7JKPUjs4Ie2DNnBBP+wQYlA5Oy
 +2biAmO8yuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDWjFgAKCRAADmhBGVaC
 FV5OEADXU6SKcSx+Sw+A0vGtQ8gLPZkPN2+2XCy6kqyExhbKtdj33oKXgZ2vYjav430Y6UIi0Dm
 9VKBhL/f9IPdqhixHjSobxLZRX4DigpyD2FMY6vr+ET5bYRrVCp9oNEEy5vP+fyNxzhZafq6itD
 aw3TrPSiLFQhMFqw2gURNhj/p/PBGZbucZPtQ7WVTFPah8DobGtLflFyZEK58zT20xYfmy8Tc20
 /I1NPhCR4aG+/13yauWyCJqrBDTiw/m1LK4Tzb4G0dgb97r4GNhzEfGBy2nOkoaRPXodLDNLtbB
 dnCXZ9EiIutuHRZGaS7ciQW1Y/Q0AH1kyzU7A0qnOSR7WMQQV8bX2wcxbcUvju2/o8361NHBkWh
 PNcuOikMD0wGFGb1qzDM3D0rUXh1KQv7lYzrHV4VEcHT185wm/bS69ZSVfoh87NbTqN16sbFQW5
 2+GqI5hKtw31CZBVxVVdy0CPPwY7Un/3UwFS8D+RhwnFsSg5vMfLiRNK6oQT5DuRkRM6McWhNvT
 Uz5dDfZiC+tnDvJGch87X0nD4Kr7ShToU7DUtRMk0DhoLXAAmJpzLdIRuoE9bVibg8F/cM3BUpu
 06C7JFLqI3WWQHkVJKO/KYm3ObxRJYwj6G8XzsmBrB/9CbW527L9n9K62t7N+N0+Ki6C94OhMD/
 L/ZqUJOZ0ud1NEA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, there is no convenient way to see the info that the
ref_tracking infrastructure collects. Attempt to create a file in
debugfs when called from ref_tracker_dir_init().

The file is given the name "class@%px", as having the unmodified address
is helpful for debugging. This should be safe since this directory is only
accessible by root

If debugfs file creation fails, a pr_warn will be isssued.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 23 ++++++++++++++
 lib/ref_tracker.c           | 73 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 3968f993db81e95c0d58c81454311841c1b9cd35..dd289fdda12b1a10197912f5796f97002e785aaf 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -20,12 +20,27 @@ struct ref_tracker_dir {
 	struct list_head	list; /* List of active trackers */
 	struct list_head	quarantine; /* List of dead trackers */
 	const char		*class; /* object classname */
+#ifdef CONFIG_DEBUG_FS
+	struct dentry		*dentry;
+#endif
 	char			name[32];
 #endif
 };
 
 #ifdef CONFIG_REF_TRACKER
 
+#ifdef CONFIG_DEBUG_FS
+
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir);
+
+#else /* CONFIG_DEBUG_FS */
+
+static inline void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
+{
+}
+
+#endif /* CONFIG_DEBUG_FS */
+
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
 					const char *class,
@@ -39,7 +54,11 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 	refcount_set(&dir->untracked, 1);
 	refcount_set(&dir->no_tracker, 1);
 	dir->class = class;
+#ifdef CONFIG_DEBUG_FS
+	dir->dentry = NULL;
+#endif
 	strscpy(dir->name, name, sizeof(dir->name));
+	ref_tracker_dir_debugfs(dir);
 	stack_depot_init();
 }
 
@@ -68,6 +87,10 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 {
 }
 
+static inline void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
+{
+}
+
 static inline void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 {
 }
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 6e85e7eb347d86775ba38a72dad7159f9ac41ed9..1df12625d80cc7cff65d9f6be89e1dd5c5ffb7f6 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -29,6 +29,14 @@ struct ref_tracker_dir_stats {
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
@@ -184,6 +192,7 @@ void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 	bool leak = false;
 
 	dir->dead = true;
+	ref_tracker_debugfs_remove(dir);
 	spin_lock_irqsave(&dir->lock, flags);
 	list_for_each_entry_safe(tracker, n, &dir->quarantine, head) {
 		list_del(&tracker->head);
@@ -311,8 +320,7 @@ static void __ostream_printf pr_ostream_seq(struct ostream *stream, char *fmt, .
 	va_end(args);
 }
 
-static __maybe_unused int
-ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
+static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
 {
 	struct ostream os = { .func = pr_ostream_seq,
 			      .prefix = "",
@@ -326,6 +334,67 @@ ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
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
+ * @dir: ref_tracker_dir to be associated with debugfs file
+ *
+ * In most cases, a debugfs file will be created automatically for every
+ * ref_tracker_dir. If the object was created before debugfs is brought up
+ * then that may fail. In those cases, it is safe to call this at a later
+ * time to create the file.
+ */
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
+{
+	char name[NAME_MAX + 1];
+	int ret;
+
+	/* No-op if already created */
+	if (!IS_ERR_OR_NULL(dir->dentry))
+		return;
+
+	ret = snprintf(name, sizeof(name), "%s@%px", dir->class, dir);
+	name[sizeof(name) - 1] = '\0';
+
+	if (ret < sizeof(name))
+		dir->dentry = debugfs_create_file(name, S_IFREG | 0400,
+						  ref_tracker_debug_dir, dir,
+						  &ref_tracker_debugfs_fops);
+	else
+		dir->dentry = ERR_PTR(-ENAMETOOLONG);
+
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


