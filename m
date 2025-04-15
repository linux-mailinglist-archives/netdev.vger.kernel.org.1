Return-Path: <netdev+bounces-182962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B692BA8A736
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC41D443D49
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15816238C01;
	Tue, 15 Apr 2025 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDVFPBsz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1535238178;
	Tue, 15 Apr 2025 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743027; cv=none; b=LSTpIhb3TnrqViGuOOjrGDSpPj0i0ITc+VuPyOfMHO/I2asNVg9GOC1W7C5JOCUtguSvinzOSMsjUwoUyAm30dM5hasYvflYXXtn/vZnYipgAtDu0UKEQ697s6wmRIObg0IRlx2zYxvy2uebRim/fh3ElQEhIIx38TRbZ8419gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743027; c=relaxed/simple;
	bh=TpRqbPL6NAJfjpOsN7HGdRXU52acB9kP7nuR9u71qVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJmg3xZzZa32liVox18KRrAduLRd/tfIRL4PxkKRtU5U7k8nTxWrFOAh1VJ8vSQ9ZHvNjobqCdWAUO+c8UFcdI9FvFusLnGYD/Ep5lCLv+VuTD5vnS1PoOMlZUVzKW1i2t5sPLIUbKuoAbZWAPsmMK7tetMK01TofGOYVZrI3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDVFPBsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53240C4CEE9;
	Tue, 15 Apr 2025 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743026;
	bh=TpRqbPL6NAJfjpOsN7HGdRXU52acB9kP7nuR9u71qVU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UDVFPBszllzzv8APHAkVF+aItQP6kTrhFhOzlIXVw3TKP+Vmk4RAbe4AVXmf5SEbL
	 ATgSRTwfsn83GFoV/n7SD5V8UnVom94vw9XgOcPPSn6CNpkb4oeJ8aTFmiXd3R/yVI
	 pJwdMbjm2aE1QV3yZxUy4NkK2AubQgnIiRycK/u5opuNk3bqgQODW+qSs61UKEg/kH
	 pdKFoK+t/a6X1k6C62ROnv3UnvHn6s45EI+BVziiZ2gcWgpPYGCLMC7NZ8vPJJlun/
	 t8xnnUdobGXeGX0w+DMACqYJ1qbxRdy4wnbAy2dPg3JKpuM4fvY1uHTlXqZRj4lZky
	 Lnsi8GYrMhl+g==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:43 -0400
Subject: [PATCH v2 5/8] ref_tracker: add ability to register a file in
 debugfs for a ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-5-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TpRqbPL6NAJfjpOsN7HGdRXU52acB9kP7nuR9u71qVU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qppT7LqNwrKjEjKimw+ZIgbFcBzs/fdT97/H
 pgbn9622SCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaQAKCRAADmhBGVaC
 FfFCEACBgDJZL23l2dsACNxJeTUzXEw6WkPfMlyfawToLDEFKBmei7K7qQIj3SVLPZgwlYQl1QR
 ru+qmUsV5Uc5Tbv4oHeQBWloFgeMHqxTl/9YpLra8wumyKIWLvmFBPjOTR1Ip0Q23QiciqmXQl1
 63RiexjB+UziBp/k1/ZbgnEW+IxvkBoC9qZ1IZEIDk1+ddU9QzoDphzyuFR/OLkRkk5oBJUqMfY
 tOkGUFTUSZq7uB0a5NzZ7WmFgr4z156kh9pBLs363lYOYndQnTfiB1A3w3iyF85VStsZeDGzDOv
 SsvMgD70YoDp6tvBOnq2oM7/4/XbkOM55UDP/U9H6/JPpLfgGd3MSWgB2lsQcPg7LhuNJGnM1N9
 Chhnbz7bHeiQIx1FYC30KtOf8uEPKlxvFGYqvl0zcFn7pOwhzI7C+vmAwtfS14aQS/bYDKgwSkJ
 Pkr3F2qEwYKRnEBcpHYRH+koc5UYFPqV9Ql+5yn3JRbGhTDS6zciuhaaVHRIrGWTiTArFSxWwAj
 X5Q6uoI/eWcVNNf1ok0FPeO/NnAQXxw1BRoW9Y3lieWNImoUvO4fp9XL4kqkwMSDpLhkfZlnSnp
 QWpPdfZS4/IEzBbXNd8s40ARdmZ44vMlCOEcKkFHqqObLIP6fL+RsFFs8TXvS1n4hOS4GSafS6Q
 qCbwA14ZJp6Jjkg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, there is no convenient way to see the info that the
ref_tracking infrastructure collects. Add a new function that other
subsystems can optionally call to update the name field in the
ref_tracker_dir and register a corresponding seq_file for it in the
top-level ref_tracker directory.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 13 ++++++++++
 lib/ref_tracker.c           | 59 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

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
index 4857bcb6d4bf557a0089f51328e75e8209e959e6..f47ff67f24ef4b84bd9ce8d027559509e3e5fcfa 100644
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
@@ -327,6 +336,56 @@ static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_fil
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
+	strscpy(dir->name, name, sizeof(dir->name));
+
+	dir->dentry = debugfs_create_file(dir->name, S_IFREG | 0400,
+					  ref_tracker_debug_dir, dir,
+					  &ref_tracker_debugfs_fops);
+	if (IS_ERR(dir->dentry))
+		pr_warn("ref_tracker: unable to create debugfs file for %s: %pe\n",
+			dir->name, dir->dentry);
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


