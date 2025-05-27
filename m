Return-Path: <netdev+bounces-193626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6FDAC4D98
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F6717DD28
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C9A26A0C6;
	Tue, 27 May 2025 11:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDIYW+fw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C626A09A;
	Tue, 27 May 2025 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345636; cv=none; b=gCJims7uF92mq5HSRJno0Vd/WnFRzHl/QoVW7PjW+RwQoxAtoE80mmAUgSp3XS/1jbVDwkYJ3kOt3I/YkPSdq7m+FdfFHbXFSvnWBrpZ6nMxBk0EAy2z19LJMLWGWfCtkzvBJ9Y7K4GZSSmwnDa4AbYmDMO0PD95h28ASwCtVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345636; c=relaxed/simple;
	bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+XUjcmFE2SlsyexxkrVz7VcxhV1UoA/yV0kssyZ4BU46mhDgCVMreZ7KQB+qJOBzsLephSUJ6b1cUWYp/qpHSYR1K7wL+aSRWtnm8sn09T6whTnNI/Ivo/qtq8eU+lwD5p8Q/21eXCPI1LKh8zccjSXJCSNhwoTzaltkgwJhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDIYW+fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EEDC4CEE9;
	Tue, 27 May 2025 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345635;
	bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BDIYW+fwqMI09RZYAciuHlIbBjnGW9chKRJIXyJ+JL5+YeWSu83O2JWwx7h2Bn3tG
	 MIVhCIiFJI6aUIFYShuQbqTHqW1fkefm2y7ULlDcdsyrTX0y762VQqJ5MHudUAaAf7
	 3isfJvgj0+MFTq9c5MLIR7BR/MGDMoS8xyEcHpFhlJMOrwSgw+S0F+AWoGGRbcfUpW
	 0RVSXf13LU7h9r1eyptqijHfdpEVQspG1PGBOvBv1Barfgsg2YLhls2VCj8KlKe044
	 tSBqWFiZ9Ym43+pbLHlx0RyEhBMMiRWSXSkC5uwhz76fEZHJHc10+hwKnuEyfKev1W
	 CVNkb6+8ge1Nw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 07:33:36 -0400
Subject: [PATCH v10 5/9] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-reftrack-dbgfs-v10-5-dc55f7705691@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNaMWF/87pk7ph2I1igNw6LWz3m9XwND5YyFpF
 EGY0dEcpkKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDWjFgAKCRAADmhBGVaC
 FbrOEADTxFmBBAPCa8mCL+K+h5Tw44w48pwSG7qK06+nCX6ur7yrdfsYSzhaLQCl43wJmDh9HSC
 Asnf0wG+MEtPsrEWgW21rMHnMpXAFMw/FdaDs6eKYtd0nX2aP1GzKwNqXTvwTVMI4xIQRPh+XUv
 j3yOeqNFRPwVrJnHwnIDBkHRoY2PKtqJUnC9kdGl9wSCXlflVF1GQmCn4NNiZgWdR5uijz7+1M+
 RENwIZrlWPtNK0geqixyhMucaLc4ZsPMsWSwBOPSRPUOtrsqMS9mC2Hg1csMiKJXU5ZV44copG1
 XyhwfnkGWNF41vK+2piuYGdpIglp8cT5s/QlKFvFjllJtdfv/iv5CgRzinP6vglJnhBj9h/FlzM
 C7hygnr31iY1uT5TDSjBBHFb197UU9lijmAt20rqgFqiQ8RjmGsbL/VtdGA4aIV4GzY/e+0NOa0
 X8CQuLtD5h23YSZWAkdgm15DuJ7Ql13ELIDYoT6kg8u/ycQXb7uscSuNFQoFwDbvnLKEx2BN0md
 jBLoYa8INmRHFrDGDGfIabGPYxcauchE5SLlNXrWt5ReDALNW1/WB2uknh2mjBbJC1STqVGaWON
 Jr1mJJbqbECghXmff91VNiel/jQdoHOPpv73RZs/lamsm0vUQo0GwfyeL0HlwyW6XFHX+xm9rPG
 AS3QH+Sd+fUTvvQ==
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
index 607718d00ffa74bd6d9abf97e913abcfd56dd1c8..6e85e7eb347d86775ba38a72dad7159f9ac41ed9 100644
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


