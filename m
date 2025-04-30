Return-Path: <netdev+bounces-187109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9790AA4FD3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42399502693
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970026461E;
	Wed, 30 Apr 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSz/1MDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E326139C;
	Wed, 30 Apr 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025629; cv=none; b=Pkt5PudzwgNMWX/UVnZeidEz5+gabSSGBkV+13zFhy4DpS0gNxGUMR/yVuGgcm2E1pJLW5dBjDkj937Q14lu9ILylEJRJ3jux8Q62E8t5sXMjnK5P2g0iwzPPPsIELzGc3fabf8cafsQ1BXBKq+AxnDNFrUz4aLKVnN4zXuphpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025629; c=relaxed/simple;
	bh=fKwdzrNkBVnGeIy3K4ltVt8KOl+gKU1yoyKwM/eux4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nK1XhLT2HXYmU0gKPMQo6lSlPP/MH9AOpwydIqesL0viDKfPMwA6fL4nM1tZrHfBi1tJKyMYAQSrLrsQ4FhLbhbw0EwhPZZzoXAMLXATYKZsGJi/mIQvMNoAzMiAOFXmkAuJdyeTq6q4MnkgUNjukaMVy1IgmifoGDhZHx9pCnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSz/1MDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A24C4CEEF;
	Wed, 30 Apr 2025 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746025628;
	bh=fKwdzrNkBVnGeIy3K4ltVt8KOl+gKU1yoyKwM/eux4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qSz/1MDZEZVgLJeY9n8vKJ6tTBS8g8NuOZGfsG0LFGwDxGuSVSx6cXoJYlPOlJosR
	 MZD1yl+QVBH+gVi2LsTxfXQU6Gz3Ips2kqJa3u9GZDJY9dvFQepWprR5l5HclAVFPp
	 O7+erA56WJEtbjB5HHMH9F4/PcaJxeh8C++9VLENWEgUV77Grg2fpvzviJROPyyUox
	 rd4z2Ehi3qgzRitfvyAG7/BnR5lec/nhp0eKm2itZ+cNx9vdBK0Ib0oxRmLQbYWmJJ
	 dJ8G1A7ziHH7Ymyvz7t9980WduKC9wJ4UPoGZZWGb1mC0SyzaW82/aeXZv+GlL1npU
	 diqgB3sIlXSWA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:52 -0700
Subject: [PATCH v6 06/10] ref_tracker: automatically register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-reftrack-dbgfs-v6-6-867c29aff03a@kernel.org>
References: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
In-Reply-To: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5545; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fKwdzrNkBVnGeIy3K4ltVt8KOl+gKU1yoyKwM/eux4k=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoEjyUNnGQS0OYEdA4brxErxtiTXBj5ZSusgfCk
 UnOz8CB8vCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBI8lAAKCRAADmhBGVaC
 FTTYD/9meNbu8lLPrSnzpnTzU3KCwZP8U4SJlUXEnGkMatFWdm1oy1T6aTjTbnDGTc4vyCQkmYK
 FCVwNKDBk+L1kdwJtLJOk3n3+sRN17coPbBDS7T+xwISzd1gWvaS63jEpDCqtvG/E8bMsJj80Mn
 eMXq7lCvtP4PQjOnN9b/NjwP/GGwRf3iFeWT8ijeFQW2NYWLBEAfKjJnVc3fmqyZofQrKHXPHvR
 kY0BR4/yQuIF+g0OnOrTRdVqwBakOnF3QmfJ1PIRwtBl+f9MsSmtQN/0U+QrzWbYmlahrcCzq82
 mkjoSVu4nQB7X6OahhYZtpbR8m1aPgr+kStAbVJrbMgYk0ufEP8Rw4xR2UTiSFXeMVQHyjOLUQy
 7fQ6d0zfS80hWBJEAiVCoOGu/XLbP7IG8PwhLsIBHH05kiQnfqxJslhlScRGXtu89lath+REsBk
 NkGjLmRm3fhRfTva13Auj9luRvT24fMd4gXB//nybIdD9hFLFElCXBZs9HgWT/Orbpp+IzHSlbi
 09M7tnEFN+7PFuNXKC0zmWLeRg4YzI2bdZTxbBt+WupDxZCZ5L79gOnN9rLmH+/7ABuMKYvQGOS
 92BOJOhwGV6SQTwBKT2cLLhKk2bsvsoDj9126m3vaGaWlQL3D5Rel202YHe3Yrl5iXyfv3kOOV5
 Mu1hl8JvUE65daA==
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
 include/linux/ref_tracker.h | 14 +++++++++
 lib/ref_tracker.c           | 73 +++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 2adae128d4b5e45f156af4775a1d184bb596fa91..c6e65d7ef4d4fc74c60fcabd19166c131d4173e2 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 struct ref_tracker;
 
@@ -18,12 +19,17 @@ struct ref_tracker_dir {
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
 
+void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir);
+
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
 					const char *class,
@@ -37,7 +43,11 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
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
 
@@ -66,6 +76,10 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
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
index b69c11e83c18c19aaa2dc23f802291d4a7e82a66..3ee4fd0f33407881cfa140dcb7d8b40e3c2722de 100644
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
@@ -313,8 +322,7 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
-static __maybe_unused int
-ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
+static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
 {
 	struct ostream os = { .func = pr_ostream_seq,
 			      .prefix = "",
@@ -328,6 +336,67 @@ ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
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


