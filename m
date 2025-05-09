Return-Path: <netdev+bounces-189326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3102AB1988
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A468F1C43F41
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3242023D2B3;
	Fri,  9 May 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZyDCpm4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3742367AE;
	Fri,  9 May 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806081; cv=none; b=MM6MQcUW9suoU8S4zML2cv2HY+2nIcdlEncMVCKIO+AXP0POF+QUl94CW9WtqzFnWjchFLYrTKo4ffDU4qSYYySE2SKRL3E21Q9aaNyvu10IoZ+jI3FA1GUKd42cwZTHVG4ltOWx8/WtyaS1gnN3u4XjSQuSIhAreVcy9mxJ0JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806081; c=relaxed/simple;
	bh=G4yxeje4skzZFbWd4GKautKhwMx5ZwXU4VPyyJVpR7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=deoWjH/9nuBP701O2wQmrujuDSCg4YKhHCjVwpgUeQzD8r2PD5xti3aDGe6YkIrL5jjLObnRS/qN4SIvQdIf1vNm2Wjw9a2MZfp86Q8wfHxeCRTLxc1KFu9WzYNJ2yLjvdyURX+UenoakF5L+xoE8X7UVhgQxtvagPO5nLcP96I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZyDCpm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26DCC4CEEE;
	Fri,  9 May 2025 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806080;
	bh=G4yxeje4skzZFbWd4GKautKhwMx5ZwXU4VPyyJVpR7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OZyDCpm4liOBfQXkDwH4iRjxeNZMGFi06s5+CxPYcLn0hX220seVGxvt7xRzYJoSD
	 Cu7ENmiYbdRLjdfTW/BpEP/wzSMV3W1vB8RVpvhU/RfSGReweE/TnJBK1rFbKtBE7V
	 I6TCgprFTFjAcok+Xgrrf7V63/xiRZmH+MY6BYKh6XfCQp8uzzjj5AGgA9fopLLX+g
	 ufXSZhnPSAOqOPNEYPw0h4XuxH16Lo6XLC3sq5A1QiuuCZgNdyRidITmrv94DHQZ7m
	 s/ybbSjUaPZadPJzfxRHjRh9uPqGQTot48ezlrkBSNYHbTaG1/6Rn4EW5cEUXolYuJ
	 Zu+bCWQkZ9xeA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:43 -0400
Subject: [PATCH v9 07/10] ref_tracker: add a way to create a symlink to the
 ref_tracker_dir debugfs file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-7-8ab888a4524d@kernel.org>
References: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
In-Reply-To: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3234; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=G4yxeje4skzZFbWd4GKautKhwMx5ZwXU4VPyyJVpR7k=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUvGYGe6F/cnFCkvaIK6evhIi7cgOPXIwLB6
 SkUkRADOVeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLwAKCRAADmhBGVaC
 FWA/EACN7jX6v+FRhwTq4/5nQa2FSnYN3+OQoGqWVHWuYVvlrQz5j+m4aDx6OC6IRRUeVITDLCw
 ky2UrY0PxoSSQhrzm3yGWKk1q6q5U1wy307sGuVjuaY+lL2BTMcebIsk/X54uQkq/EsYYtYWT5X
 A9N4673/PFXL1IkoMaiEbKL1YPU+dBacK6iKAdp1/sqScE4IeajPdblHS3tf2t2rAep+7CBprQk
 DbXS3oyvhyDNyI2c4T6fntUHiDYFx+wG5ejci7i7VfYsbEit2WpwFNMpS03Xfk5lHsfYZD79UIN
 vlbWaSKIrmV3jzwK8SFzkAIlF9diLF2aW+l0X69vU8dOBfr+Tyl7N2R4x9byIQe9b/fHDlstqpD
 sVsLhE0mGbESYeTbEy1W5/zNzF16ibv03E3s3fWnLaKbdyRu/GUJBjef2zNaBqcoNZ6iQdNmKm3
 OQnLT/N2jLh+OlGmtQ39l3tu3XzN3CB4Aj81vvMG3j377GBoI2L83r7esD/bB59T3kSZq4IHGjr
 5ErilMCakJcRz1Xg5PB4LWsiPd3B0WhSXiM11lvn7tkl7R4o2GyHpxNcRW8ocmznZV8WUmNPSuP
 gahW4xtI3W3eV8J+3vt0mwW/UgOSTgEVqIapU5ea29T+a+0B0tKk0Zl7p7OuggGGlaaa/BygBlS
 U49cU1mwv/0W2AQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add the ability for a subsystem to add a user-friendly symlink that
points to a ref_tracker_dir's debugfs file.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 13 +++++++++++++
 lib/ref_tracker.c           | 28 ++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
index 1df12625d80cc7cff65d9f6be89e1dd5c5ffb7f6..5e84e5fd78e147a036d4adb511e657da07866a55 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -390,8 +390,36 @@ void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
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
+	else
+		dir->symlink = ERR_PTR(-ENAMETOOLONG);
+
+	if (IS_ERR(dir->symlink))
+		pr_warn("ref_tracker: unable to create debugfs symlink for %s: %pe\n",
+			name, dir->symlink);
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


