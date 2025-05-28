Return-Path: <netdev+bounces-193989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE035AC6BE3
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F0D3A219D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7BA28B7D4;
	Wed, 28 May 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDuUEv4e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E773328B7C9;
	Wed, 28 May 2025 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442903; cv=none; b=lBWq+d31eqapH6WAAotGtqP9MWo6YJtczasQs2bCRm3MnNU0Klttn76aHbYAqQmmeFX0vqRayiPsEpc2MH2nGxCaYJYdB9ygHb9Re2kooVYyeUQ2rOgaS64isylMFjuSjVZEdG2UOvqC1yHvJOtWGxgwhtsAjxOTlFz7JHMZQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442903; c=relaxed/simple;
	bh=YUzGN4pDQEVUn13ezU+iyAv9BvSGVVgHmEotghHtWUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N7n0PUMKvSdrYwqfPZoWRG6rPZAHosQt4eJAvP3rSRxSDHKlq9YVdA7iEjEnmQJwiZ8CTNt0SbvxKvo0F6N2tshx9l7dpS2hZqPUpHFDo6KH4wtG4O3zuuhathkxVXJhfFhsOk4tg5klHyQ+WvPIS0lqM8iL6psdl4n2eoxs+L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDuUEv4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF4FCC4CEEF;
	Wed, 28 May 2025 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442902;
	bh=YUzGN4pDQEVUn13ezU+iyAv9BvSGVVgHmEotghHtWUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tDuUEv4eLCK1xSiJAa07yXp4KUTJgztf0yG/0xbMVvDEPDQux8oKgh7o8JZOH80HB
	 OjDipwJABUUiKw16Dg9TKKAL4BiD6oCwgiogHZHNliLeY90CgaMKWfFduSb76pwPRO
	 BCmqetRwEjlJTpu3FESmHaTWUye6tD28JM8QNwIatl0DhPTofh9pH7ECVOFE9t0gQJ
	 lnLacJnzxaCnJ/Ky24BHtsiJXs8p1lxppIStlmfUVil2ISLgsVBjVJ2RaElzjQeORl
	 5HSijHEmR/5uQdn7Tp5XhXlqdrT8Ee1kc5DFaXt9fx5KGtU9Polqiwl5Hg3gM2O6g5
	 WpH2bfZkl5L9Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:39 -0400
Subject: [PATCH v11 07/10] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-reftrack-dbgfs-v11-7-94ae0b165841@kernel.org>
References: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
In-Reply-To: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8FZjgVZBg6I+yFSchXKb+8fjEwvDfOWumKM
 M1qVwkNEQyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBQAKCRAADmhBGVaC
 FZwqD/447d166xLPc2jQc9YTZ0yDpKwSkOL2LsXqlIkpnAKe3WD0Sg7/lNI2kdUrNbNMxqabF04
 LRNI1ubydMJ0yZ4TMtQaRbnpTsbRmpsC4z9z74wflMTbxlCsZNYQChGRvPbkLBUaqTNgZc2T6tl
 UdnqxVoSeHDO5U4URoc3WTI6gKM1RSBhHU+ouH5H9jvNxzGBNhjqjxFWUsoRDZGXlHG1rgFKGni
 6+UCW5EKm285dPSrmVOxsjkeaBuHDR119KIvgvDB4I9d2P9kg7J0fpvq9sA2fTREJanUgw4hQub
 xuevjpVLMxURgFir265Uw+DFCqZVuEBVXs+jb3pTbnDj74cjTriTVHgyb4d7MLOEvSF318yHzTx
 wJHRrjyqiI5SRl9ur4e0x+r2ODxonMWk/tSvSj5BN2bRBHwDATM9NGN4XLVX6OY5D0VvP9Ni2vh
 CqVsVyvaQD5dgqWQezZYJ3kIsckrXmQ08mTZ5VrRKGKr60pHTFVFxLeJYApkJB/rZsXcC6yyKFW
 /toanbV5DME6huuqyIEkvNuxRKIT9WLQ0A3jz0m+AkY92fk5xHVq86WQC5k2BDsuRXHPM1u0srM
 uRAousj8+mEbKmOuZQpz45mLdWE5AQhOPqHzRDYfQvEv9Q+IFuWsmo4kbli4OkzTONjHVKL0wrr
 Hl57CG47IXyHcsw==
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


