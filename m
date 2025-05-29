Return-Path: <netdev+bounces-194240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A863AC8031
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC01899444
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A894230BF0;
	Thu, 29 May 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUJfCWin"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721D422CBFD;
	Thu, 29 May 2025 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532086; cv=none; b=icy2AQJpy5SK6uIugLLHtc+b+auXGlZC1lPake+SiIbfqyml9RlMw5ukTgv7o4hdPHmqLBoB9edSvpcpvD2GCUw8Moyg94MJ9BBeHz10g6HobPdFrHQlUzDRGtP7EEpWx35XgYTNJd8wy7b5yhcgibL5r5vLJOThA88GxWr4ib4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532086; c=relaxed/simple;
	bh=wAehig3CgK9jQX57OpnOj7ZF1fb8ByqK1MLiGa6luaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D3NxikYZrP7/w63h552drDfFYoKXkuZzHlugp85HnNnW0ENNt+gxSNtIK0Wsnvolt8CIN38H+vmFnhcMDnTmXN8373pCNNWJFX2FAG5ztzRcJxts+lorNPiZssVuVobtQ3NX1aUgSPMieHzZKKipTl7AclzDXhYxcWni1rPKdiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUJfCWin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA12C4CEF1;
	Thu, 29 May 2025 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748532085;
	bh=wAehig3CgK9jQX57OpnOj7ZF1fb8ByqK1MLiGa6luaQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AUJfCWinRxeYJMpUbnSVZmKU29TRH7DsfLVZM6V1GoQzqe3Qf7kGO6IsRrcrjYvzy
	 lj7eZ173IoRx8CqaTtrLPpCPtbpf++AsPb8uR8Rs16ZNEfjamPPKgCIRIAGabxoaOp
	 QzA4Oj25jx6o9gofgITRcfc7/N/59/ZcCpSSkKGmqgdB7b/bn1dc+dw3SnzsYE6TAj
	 zxf5HeM9Yg77GQbi/O54/PitKeqC6+e5prwYTfSRFy0NHpJnLC+aujQBXUx2HA8+bX
	 GXbUShWZtBHRtV/daSxEiZ5Q8ISMjpaKwJA87bIHdegJw8z56EHqJPUE6tIPeTB+Wx
	 wJjja7s0E2QSg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 May 2025 11:20:42 -0400
Subject: [PATCH v12 06/10] ref_tracker: allow pr_ostream() to print
 directly to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-reftrack-dbgfs-v12-6-11b93c0c0b6e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wAehig3CgK9jQX57OpnOj7ZF1fb8ByqK1MLiGa6luaQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoOHtmzR4/zvXVJiDIizB6A00wECexd05651FxB
 FkIGUYsN+qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDh7ZgAKCRAADmhBGVaC
 FVCNEACtlOsXCW3GVxf2Wx7xqW+9KmPWxOfHnhPhoxg7+CO9kknQhM5OMrorNc8T8+4DLRKfWCp
 H9wxTThj0zwwJ8B6aSbdkUzrv3aDuDN0WbuF7DZLl/7a3wLN3DCaij85SCjOyWXV6xE68eZmYDa
 As3znfb+TSViw4ML2GrMlVutWxIRTKjUMcWYJv71DOSSFaAAgKHGJ7DXvps3rrJu1yG8mswGn8j
 Hief9f1x3IBuMjNr8+2d1bSuFK0PhUbRRSVpsI9F1pINJyohmDW8Nvd63W/2xFYOPsNd3KqXIhM
 /7GiEaXllnlB5qAXotuL5fHy5loZSE+WQ0JTwhvXOG5s/g9xkHhcoM1gd7MS1YTYUbY/xK1i6Pr
 PjIu0/Dr+46y6n4ceF7MIi5QVGQ1qSiFJHyDuu48HVoxvCGrIPtK2DPX8v+QVXItprPzx/nSqE/
 UTWa1Qhhksrlddn1KdbeF2J+4PSRpLscm0IQc6ggECzvkcNrEKoqN2kvEQMJgGuC1winO75gYi0
 wmgGitraq3JfWFrASSHW08f/+6SYuF4d1Z4t96sfpu7KHgpEZwwxpropWR4B7LGs+FmirRocDAz
 d4CPE4o7jhVGZs2mFeVzd2sCr+Z6eefJ8oEU22Im4jVMwPblW+vP8VWu1eZjKQkIIwK+OwhmI+q
 wiYA05H6hRTvlWA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow pr_ostream to also output directly to a seq_file without an
intermediate buffer. The first caller of +ref_tracker_dir_seq_print()
will come in a later patch, so mark that __maybe_unused for now. That
designation will be removed once it is used.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 4f2112b001de3049ed542ea3c4f2bc1e9cce6043..5fed791da84f523500d2edf262fbb20adbd921bc 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
@@ -66,6 +67,7 @@ struct ostream {
 	void __ostream_printf (*func)(struct ostream *stream, char *fmt, ...);
 	char *prefix;
 	char *buf;
+	struct seq_file *seq;
 	int size, used;
 };
 
@@ -300,6 +302,30 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 
 static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
 
+static void __ostream_printf pr_ostream_seq(struct ostream *stream, char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	seq_vprintf(stream->seq, fmt, args);
+	va_end(args);
+}
+
+static __maybe_unused int
+ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
+{
+	struct ostream os = { .func = pr_ostream_seq,
+			      .prefix = "",
+			      .seq = seq };
+	unsigned long flags;
+
+	spin_lock_irqsave(&dir->lock, flags);
+	__ref_tracker_dir_pr_ostream(dir, 16, &os);
+	spin_unlock_irqrestore(&dir->lock, flags);
+
+	return os.used;
+}
+
 static int __init ref_tracker_debugfs_init(void)
 {
 	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);

-- 
2.49.0


