Return-Path: <netdev+bounces-194779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE4DACC572
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CCA1663F0
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC0C231A55;
	Tue,  3 Jun 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ67idAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F923315E;
	Tue,  3 Jun 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950056; cv=none; b=bHURoyf1Z/hr8/+xQl6hL34gItLgFngTxfn4oixJWm+iwV7lf5ERghA8sJdBc3ni14HpvbbtGgSNaXSy++HQUEpebd0UNm76xi7iQzs0pMZBctox0ruT1lhUpXdA89k1h/O5sNXakxhjDXkgDOWd33/JGePOZcXyt64KPCq0wQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950056; c=relaxed/simple;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIgg/2j4TbQoJVzBa09OXwlr8LmrZAqbnX6B2djBFJHKUblsvYd8dXiK9KgIZJhJb2RS+JV0fgqBz5/e3wMXtmeqFkYFjVnLb8wNC4rrHXDfe5OWTgAKFh9rkS+EMs1SIRrcFgEykXaCLm75BijEIdr6DSDeaHxRetk4KJWE4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ67idAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315F9C4CEF2;
	Tue,  3 Jun 2025 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950056;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hZ67idAkz1Q6WEjCvJXL8tiUJJl7YaEYyEbBZuiihtliUd1F0zKdiG3j7C+knHL6T
	 MGcArYUs+QlL/jtLXLwmL7/SD9AV4YVT5uuWSJftlZoJ8hxJw/SNFfQJDc8GOc8Qs7
	 cL8kTXvoo6PTkj8gMVJsl+WvFDLcD6JT/72BMaZIVcICtZPSuRBm0TG+vtHCVIfdE3
	 vTAe7l2schRgJHCJoBmXCpbNtjgifEvPjyvPApxH47a5AIToOEMeNlguciFYHbm/y1
	 8B2tC09pehQOZK+N7NyDdF51sjQlA4lxNvDFT1IEVyAz/RJ4FSs+rHwXnHUVsQqjxM
	 EFdxNleToic8A==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:27:16 -0400
Subject: [PATCH v13 5/9] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-reftrack-dbgfs-v13-5-7b2a425019d8@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
In-Reply-To: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPtwa9bpttiNqpcPN4Dy+8lJv4cCAkk+aG9TvK
 wIKUa64/syJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7cGgAKCRAADmhBGVaC
 FcSOD/0XA5UcipIKa/Kur3XJr6W8uSqfyPG2GmcQickNUCE8HdODpm1TkAUo47yCmvNl5qZqln9
 i2It8fvz1p5bOCyJZrbnNksGeXCCYdhc+tl19o+l1un2lTYDblk6KTo4XzyPGy9LSKsiTVJSU/c
 bHiDY3ilrllcFseuJ1N6INjf7aS++IR01NAzzIaRDv+E658gSc3ZSEjfOvdSulSSZuNRQE1PHpx
 TchJMTUtuRzR4qqu9VC9nZX06GaTAe8mlpai27RYDH/OdkBb/dYFAC1eFK68C0df6Bi2Qsf9pSk
 tCL8PBQeD6mlz9T5s41VPKG2fQuOMlm8MjAT4Jp3FfoGTTxkrC3uF4bNV+bg3EYONQD7rJeSSLG
 Ng5NlhwhiQRYE30KNBzfaLcheaRbEA5ckNinxtPWj3M9RT9l3GxXJDOskm3yUd9+jRsJ3AMkjq+
 r+mGkPpVm/MiGhqMt4eDi2XIbfMzsCCQ+6OcqwEp89Cv7/wp822ZwxbmCOUrSBTTOB+HPHMOv1D
 +DOLOBylfFEiG2tUIpwl1eM4r6gZ1n2/gOqZKUQJG221UvfVrJqdSmc678XONHhwy5uJ+LQb5gr
 ex3YfG/Nsxksm8CiNsMlx4md9Wf0ktlCptT541Ex4XRk5vsK4S9IPaph1yOyPqy22OASEMWdkly
 btSTkodR2Q7Xptw==
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


