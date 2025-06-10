Return-Path: <netdev+bounces-196168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98BAD3C1C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C2A63AB5E5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C4238173;
	Tue, 10 Jun 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5rL0v3E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10598238159;
	Tue, 10 Jun 2025 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567594; cv=none; b=mirnhCxBVyFEBi3rxlQCqGXWf9WXIWK8M2u0D6GtfLy2bNISr8k+UnCQVUHYHK95RH/DaHdfJt8P8y8OxLvLOYCKV2nlGQ82JVFYUNKtplZoKi2X2yhuAWH91U4GC3t8fiH1cfN5U8ZZMMOFRoycYWy3R9q+BMfs5Q8WYjEHWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567594; c=relaxed/simple;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ehTUnf8Np9GQzyuOcw5xf4fbDUWfZ1NoBlr076x834hWNxoYUIeYbbySZuOeHI0LZP6BYvXg9sBkocTFX7eJra4xYPpiDZdav3C/N2sPWOp5Ua7x5WxoPCkYlGrEy646QxBcaT9anLGuxOrlnqdWdI+PQfvyH5CVne2Do58CnxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5rL0v3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0AC4CEF0;
	Tue, 10 Jun 2025 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749567593;
	bh=fIUtfKsTxdswV0+z7NV6Nx2ljCgH4pcViNimfWT3u1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M5rL0v3EHgtzm1+YPuRcK2PSIOLO9mlfBdonjLj5F4sfLQypAm1+pB1TXYtMM7fpk
	 6KLgCw5CkKufVZ1l0tkGw6xLxxX/1vMyCfzgLNZDdN0DPv0EyOAfhqHmBB0Xe1KO+1
	 0VXLviw2MPa0tpydfSLnut1HqjP2FFqsjAGEc4/FTXyy/RH6I9ZFP6zdePgiG18yB7
	 nZA7IqiEUXYtL9A2aSJbrsJRp7YASgQqfFnSb1gSFuPq4wi3h+r+yV04K2vTORqz9D
	 HL8+Be9UTgYmTKddM1NeJzxOOM9X2twBrT9nli2s8bAMgU1mtfuj1CAOEjKH/cvfFr
	 toNQhgU8MIaXA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Jun 2025 10:59:25 -0400
Subject: [PATCH v14 5/9] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-reftrack-dbgfs-v14-5-efb532861428@kernel.org>
References: <20250610-reftrack-dbgfs-v14-0-efb532861428@kernel.org>
In-Reply-To: <20250610-reftrack-dbgfs-v14-0-efb532861428@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoSEhcnHtf/8juAzoak1v6poZL6p29vAqIwvQWR
 a6pOohhBWyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaEhIXAAKCRAADmhBGVaC
 Ff+HD/9vTdoNPo+3wTbGpEMt9ydg3c6ivO2MrcOnnHyyGvkoa/t7uiHV1J93vQln5SQpAnQpjls
 RtfB3oXiuxy3z/9it2bTtHqUlES5HpHDPhycMos5uAtjlPpFYVUkGUnKKlSEzzMjfK3xzHyOmE7
 1Aq3rXvaqxSU+SnxZRRVBECoSZn8Al1Wm7WRrpwmqGi38RD9zMBgl7VrqVcrSBwYe+WBaXg7erF
 VvajFxbiIRvv4CBFvVyhv3RXPWvknXC3sPs9mt2DEqpcEG3tuLsZUn4+EUBJedDdSwJK4UyaGcE
 k5pbvKZrUzUIzb0RNDlqYC76ej9KTT4I3UlqoLr8X3aoMSdM2vwmxQ3ve6UNL5DnHz89wzkwurZ
 E/B8XiseC1+x3kMON/Gcrwvu7v4hdggbPZdksjrgCQrCISoF4ka5AHjvh2/34bFCgbPjgDfBtbM
 iRj7E/OSQ6niXden1KFkbuekkrg/tP9B9/tYQMekqzw6kULbB7idAJF8eQWNqN7caOcHLoiEfYu
 ctfKLA0JCrrxTsBlPTjsKVW6PQvtMNf74ZwPHPDoe4TR2wlKNTpv6j/Wnod5L6VCoCIz/fbkZb0
 crqSXwCGeryhbAdVz1gwGlD3m143OGGHltOGC83GRviAcRp+Vh6uwjx4EwcuLED38MCuvB88dUC
 RpjWRF4q3ehSslw==
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


