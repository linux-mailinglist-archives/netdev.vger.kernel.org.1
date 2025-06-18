Return-Path: <netdev+bounces-199108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92178ADEF43
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2BB118849A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B72ED17C;
	Wed, 18 Jun 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLDIOX3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FC2ED16A;
	Wed, 18 Jun 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256679; cv=none; b=YV6tnB0mDPvobg0rssU/K9MbtELQY9Z4psqHjZpJh1bJPWdTnFpmMlILp7MlIE+df+NxE5LbHKxW0OGlpPCigdr/wNaRk+iNqtPw/JXdpFdOlZla1w7J4LNa9URM8g5mriSF7hm+I8jqZ7txcMm+dFs1OhUXYXb3uO4xhS+9/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256679; c=relaxed/simple;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOPVJZqUXTIrkThTesKFU2vcwjbgaFe2f5/mWM0oLElKIAh8VNAtzC5qwUM62qFqsEAnXx7yUEO+ZeEq1/kdffwbBHHhoxVGp8A7db5Q1agMUoIA+X4yCD+s6JKo4VQ1S7RJifwoYYTqnIRGF/yYfQG1W3CmZ2mM6jJ8TISAOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLDIOX3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1136C4CEE7;
	Wed, 18 Jun 2025 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750256678;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uLDIOX3Hul4bZlkecwEkjoZmYKDdf+cAsfBiUohxb26sAfGNRvo3NOW+5wttooh3K
	 EXJfS/JXysjNl4W9KvYkmGx9kiCN6wI8pTMufW6b8m7rTalI/+lrHr3vbfk5T5AYO7
	 w8PGQJ9Jqo3ehQ4+3WjWjnhEG3S48pmW7VlBUEfZ9L6NbHJGZfeVsF0ozKOp2iH6YN
	 /oxlgcP7uexH3ZA00heFWEYx2j60zcgv/tT0Gf1rySR/+5azouNVEmI+lf+VzQ0KTD
	 QjxtwmlRn/HvkOoJ7Rzf/g9bjmgkWR2/IlptGai/1ltOBP57Y4Fcj8hXoXLSPYypB6
	 X2NZQ/dpYZHQg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 10:24:18 -0400
Subject: [PATCH v15 5/9] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-reftrack-dbgfs-v15-5-24fc37ead144@kernel.org>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
In-Reply-To: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
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
Cc: Krzysztof Karas <krzysztof.karas@intel.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUswZ+yCe+Nq+zcQFbm7S/FnJLTnyxRZRUr9FZ
 Y29ppwMt1CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFLMGQAKCRAADmhBGVaC
 FX/KEAC6AM8ZF4tPJcB31H1Vs2JCZprZGrT8qjn779PdPnWBNhYGD+J2yXb1TiIM/dPBrIenj+Z
 RPOTBt+TA5pw2vPjDjFa5WZ2Nma/oqXa72+Znar/vjBoCVjP4yXEOJos6CWlwBUooSI6qZ3fyjh
 azbNJXMjKD+9gI+yqMCPsEPnFAtqpCzMgg01FqJaNaodtwwQfHh5jFNuOQwuJl2uyF+Y8Z2nJsB
 ifSUUNt8fA9dHQe0fTzaSolM3WAO+D9J0ZsXe90ZHkJMtxCcL/AaWbEDocJAgJhSxBo8iszYYON
 fqMh20r/IeNWYG7ZPjpyvrQE2MgT+VWxJokupoO1Ax3lrPPAGrC2cTlJ7LtrFRyAOn/H/E3tEQU
 Xy1DPyFuzOz/h26Z/x3B0yS8h6aJ1YS222BdgYh9PLH500SxHGPfqbf/feM93SxO+dhHSwlGa3+
 cL/xwDVgNRcWmCDcpTS+hgewjrQpt1bfUwEqNcwLLTkrFaKa4gJKEvK4EOqFnj/ntfu6AI7u1+6
 1B94aXDEtng4LFaXoI3n3+0ACGKnutuVNYg0Xk473x8ex7VBlquo8qMus18N0MEc+AU7o83S35+
 z42G2vOGBE4U+VcLPda6i0WfwBwO8ehq+U+etyztZeREKmuIWtwfJUtOfgMY4rdTPNoxVO7m5uJ
 FbgrC6Up0DOQJgw==
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
index 42872f406b2a91b5bc611405cae7ce883fd8ed22..73b606570cce9e551d13e65365a87dc4ce748b13 100644
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
 
@@ -301,6 +303,30 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 
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


