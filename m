Return-Path: <netdev+bounces-184164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB893A938A1
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68759238FD
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1641D5CEA;
	Fri, 18 Apr 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTjtiKn/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE99A1D54FA;
	Fri, 18 Apr 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986282; cv=none; b=BXUt+7Ci0Pkph3+z0fwoMoTeZYiTjyiJXh5LAG7G8gmPavdfsEjduiP9rtSxqhN81O+BQ5VFzai368HYqRoej9ucylSDbRpuwz7OHqGfwbuJxtocuMDdVp67ryxL2vShtVgCFiFx18depwcpcnvVk8hCvOi76Qh2l8rCbKRZQXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986282; c=relaxed/simple;
	bh=l5/XOHywB9lKjB1qgOx9rhhgBpmkHLAVDfkHYdzS1Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CE4mAfWoAYkNeBOKunT5gp4uzjkf+kq+G/Scg8r2EUBOe8daLAz+LRCVwYiBYwNkOayAOfnf9ZOOSVmSUSK5ge4kBlLb9xueEaVjAxl8n3FUolPHH3EzT29e85VSOIwwiwjGsRYQo4828x2Cft3bsSMQWBaKlwu7l1ytm0JkHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTjtiKn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA22C4CEF9;
	Fri, 18 Apr 2025 14:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986282;
	bh=l5/XOHywB9lKjB1qgOx9rhhgBpmkHLAVDfkHYdzS1Fg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kTjtiKn/w38dMuRUDh+BdC+255OuOoMasSWp230BxiqmoMMQ4b25hP7F5WzgEqSK+
	 3qWMyAy/1pdXEr87RJIq5ndUwIIz8PBUCHnJ/GF7upWKKq2gP/GQNLCF1DwjjX1Lbm
	 o9VYVn7Yl8vzbm3UeMany5YyMnQgYNGAPzhGUPBLsKC8hkjZhyfaKlHJGlVoyrXydt
	 k19PLxhFhajEYDfdAdKE1pETGX6s7agtrf+qyE4GxfOOeVbvF53E5F3L7Z3mv93D9E
	 GksUQ1rrC7A6JQBcDVOylsn2iZOUz+TCN6P+UTl5TkCd5LIRpIJE+TRDGMnAFH1yka
	 2SLPPGyIEJ2/g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:29 -0400
Subject: [PATCH v4 5/7] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-5-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4764; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=l5/XOHywB9lKjB1qgOx9rhhgBpmkHLAVDfkHYdzS1Fg=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmCiJpDdmm1FGJD8EuWDaTj+Dcpr+3q8vu+WH
 hl5eOuH+g6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgogAKCRAADmhBGVaC
 FVObEADORujHToNmXBqCti8BoLyGbf6NoTYZyONOTh5/R5VC7GCv380knsTd6pe2EUA5jARdq7O
 uP8gxEUXJci3WuEr/TpZys9y8PyQj81uuVXky2eKn20qJRg+CHb6k0CaKTYLQMK5KdqXkN02+BB
 L83y42sD50ojjEsqbwHQVxQKMVmnSDKAI9eDFlFklg3NcRbfi6axfv3k5nukQhJQCXjg13tjzLT
 PdMzw17VpGbKMD9pdt0CnpUyM6/p0c/FCQAbQMDtNmKj9peA5o/2bPBQ2GMPX639wRym5Uj3AoK
 0X7W1H1jnI7CuMZgNKkZBAFNe6JS2TgolAjvoa8Z3epRs4ztzvGOb70sQrRY8TpBX5aY+loOHdf
 2Gz2pKJscASiySZ5pxSryIIbGTa6s/kmaYu5r0kIMHkuCY8fcLIO/xMO7IG9h0fYakS02SZKwao
 lmoMxC7Kxxgnk6M5SmAjjf/DxmYVzUBjsRKqIB606HyL204PXWxh2xHGCpaLIGzXZijHzTC5bNN
 9W8IbmiTpXS3M+LuE/TmhkOMh8QheIrEnLjORW6oMQiDM1+UgO21HODEb+Mvv8dCtK9+Vo5MfHk
 Yi9+Jgc6ay8htmOvb10LsIxboTC+RN1z3b4MRmaPlw5NFz9MroXZbf1+BPEjsRbEkCalEoaefDt
 jpPuFI7mnrgO5VA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, there is no convenient way to see the info that the
ref_tracking infrastructure collects. Add a new function that other
subsystems can optionally call to update the name field in the
ref_tracker_dir and register a corresponding seq_file for it in the
top-level ref_tracker directory.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


