Return-Path: <netdev+bounces-194242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9550EAC8036
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA12EA42E61
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939162343BE;
	Thu, 29 May 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSzdUfoO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC13233D9C;
	Thu, 29 May 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532090; cv=none; b=IrdHAAFt61ScVMnaWA1RbcKtpVmFGFv2m30Thgnh3cL/r/Bj92uHodsjdaWVnfK4B0VrMrTlsTby+QK64UXLdbCK9Wjgof6OBGKpc8MJGH1Mpyoq2pybK22l/FJKIZeoopvwmUpOlGNm1zugwmq1x9/idBrycbreBE0iYjHbge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532090; c=relaxed/simple;
	bh=TYdiGaavXoUhBEfyJ2tof4CzGHWJn078+gZ8gTQMfh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNBtrsxT08JI/NuwTVgcUpx7vsT1Br1ABuBtXDHqOj9C61Il6lwn23Lz9AG4VpyjsYVr2SmUQhAina09rW0f0e61MsopFmQB3cVLXIPxwEc99/4cFhIwp3WAGpYhcNgyMmwwE5msl93ACmP6fJaB0pzsL9Sdbutn3Xmp/rgu8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSzdUfoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30090C4CEF1;
	Thu, 29 May 2025 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748532090;
	bh=TYdiGaavXoUhBEfyJ2tof4CzGHWJn078+gZ8gTQMfh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SSzdUfoOTKfagcpSWk8/saZ49LwK2g8CVmDSUgDAK2faZub3eaaVGSnGLBtNqKRnh
	 7RktK5Rp12TQVtFN3BXQmHvGL8rf0egwMC9qbthfQ+5YXH7U46QYqodFg5vdvaP1No
	 zwYkUoDbLdm+a0Z3tB0W1ArgLOck+qcJbRxGBxbSYVRrYvb/CPlbEaeveUvQXY2IFs
	 7akbAsO3TU5HDV40Jg/LX9L5qJzIQ9f1ZbX/A+TU8DYCU7vQawW99CxpccBwQNi6jX
	 dl7t4p6zTTGDP0goQl/bT1EveuBbEyg3NPnO2hXgBBadOj/bUi9iJK/IlpE2EHhsII
	 /eXo+3vzhCgHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 May 2025 11:20:44 -0400
Subject: [PATCH v12 08/10] ref_tracker: add a way to create a symlink to
 the ref_tracker_dir debugfs file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-reftrack-dbgfs-v12-8-11b93c0c0b6e@kernel.org>
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
In-Reply-To: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3044; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TYdiGaavXoUhBEfyJ2tof4CzGHWJn078+gZ8gTQMfh4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoOHtnIA/msdeh0SYjk5pNmKitkc6lL1jlnNBjz
 XK+CBCnD6eJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDh7ZwAKCRAADmhBGVaC
 FfM7EADCnX8FNq0rJLAa/m5YacLEeBDeXnKOAOu1EUGd0x9Sc/13o3JV8v58xmiX/hggibKW4M1
 RxSeS+FbqyzI8zlA6AtCy/jjs4AcDRohpOdVsfha8371KB4cSurv9GvREmdmRLGiJ48mcfpUi6R
 4JCjgmNhXfSP72aCCZ4/RVz4ZWsZvcFVpIMRIxQHMnRN3D/51Q9wbCOifHnRm8rGGsY9fxMKSeJ
 S+iv0HK1QHDu82iehMPD1VNFQ2ef38ZZ/NCgSLZX3nKgU+FHpypPTemO3pUCZZ7oSwEw/uVcSvu
 0+7U3s5rb3QkAxcgIeIAUJ8EDBOZ9aZnQ52Gy9ToJoGQX73TqeIDJfrG1HJe8bn4tAMrvifd+aw
 aVxRHTcMzKR7dEUwU3TBDaKNJX3DleEN2ikcFoDswZNJxitIK4E8z1KU8GROoMqyEYxspNnAeNI
 zCZAQrxsCoTD/2UJr3AlTeJ3ZURlc1khik4G1MQDzmfLxMe64T2oEITH9OBuKDq889bM+QdCpxE
 u2AWKsWEWAesDyUrPdBXef+N5OBeqFp79yl6Ktaylew3wcf6mGCnlf1yPoBba8fEiqXpEgzbLw4
 XiIipF4V7DxMgJPT286+LIzZlEC34hbkAHT3i+rrXXCeVFsRQyH8AUaCpv1vdBn+46EHzbLXeFa
 xgj2Buo4+MijiSQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the ability for a subsystem to add a user-friendly symlink that
points to a ref_tracker_dir's debugfs file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 13 +++++++++++++
 lib/ref_tracker.c           | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index dd289fdda12b1a10197912f5796f97002e785aaf..ddc5a7b2bd84692bbc1e1ae67674ec2c6857e1ec 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -22,6 +22,7 @@ struct ref_tracker_dir {
 	const char		*class; /* object classname */
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
+	struct dentry		*symlink;
 #endif
 	char			name[32];
 #endif
@@ -32,6 +33,7 @@ struct ref_tracker_dir {
 #ifdef CONFIG_DEBUG_FS
 
 void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir);
+void ref_tracker_dir_symlink(struct ref_tracker_dir *dir, const char *fmt, ...);
 
 #else /* CONFIG_DEBUG_FS */
 
@@ -39,6 +41,11 @@ static inline void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
 {
 }
 
+static inline __ostream_printf
+void ref_tracker_dir_symlink(struct ref_tracker_dir *dir, const char *fmt, ...)
+{
+}
+
 #endif /* CONFIG_DEBUG_FS */
 
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
@@ -56,6 +63,7 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 	dir->class = class;
 #ifdef CONFIG_DEBUG_FS
 	dir->dentry = NULL;
+	dir->symlink = NULL;
 #endif
 	strscpy(dir->name, name, sizeof(dir->name));
 	ref_tracker_dir_debugfs(dir);
@@ -91,6 +99,11 @@ static inline void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
 {
 }
 
+static inline __ostream_printf
+void ref_tracker_dir_symlink(struct ref_tracker_dir *dir, const char *fmt, ...)
+{
+}
+
 static inline void ref_tracker_dir_exit(struct ref_tracker_dir *dir)
 {
 }
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index aed35a898466888fcb4e4186774933f54793008a..d778820bea952d96c9a1c280dfd6531135bd85e0 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -384,8 +384,30 @@ void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
 }
 EXPORT_SYMBOL(ref_tracker_dir_debugfs);
 
+void __ostream_printf ref_tracker_dir_symlink(struct ref_tracker_dir *dir, const char *fmt, ...)
+{
+	char name[NAME_MAX + 1];
+	va_list args;
+	int ret;
+
+	/* Already created, or dentry doesn't exist? Do nothing */
+	if (!IS_ERR_OR_NULL(dir->symlink) || IS_ERR_OR_NULL(dir->dentry))
+		return;
+
+	va_start(args, fmt);
+	ret = vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
+	name[sizeof(name) - 1] = '\0';
+
+	if (ret < sizeof(name))
+		dir->symlink = debugfs_create_symlink(name, ref_tracker_debug_dir,
+						      dir->dentry->d_name.name);
+}
+EXPORT_SYMBOL(ref_tracker_dir_symlink);
+
 static void ref_tracker_debugfs_remove(struct ref_tracker_dir *dir)
 {
+	debugfs_remove(dir->symlink);
 	debugfs_remove(dir->dentry);
 }
 

-- 
2.49.0


