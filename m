Return-Path: <netdev+bounces-182961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E40A8A735
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4543BE9D4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44D2238146;
	Tue, 15 Apr 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5+7RFoU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B763238144;
	Tue, 15 Apr 2025 18:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743025; cv=none; b=JtJ/bh8C4mXIa/zMgOHjH9nwSt8rYEuk4lf8q97+xaSnglrAJ21HPqZctr5MVDN7m98drjjKJmxadajPKBZJQ+M8yNzmW1/xwojQw4Yg9K4yDc1p7TBWjLtsEXl8sM7U9i1/I1leKtIF3RTGTXJpjQTtkUiLxz1IHHBu8rpuKnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743025; c=relaxed/simple;
	bh=yAtQC+T/kvIyaWVd4i2QUou/vgOvw6JReC/jdUjP8LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tp+n1P3VG+LZUtMx94thdOUlUKl9UB0/ECbW0DFsTWABO0LMtnOY5R1C1Riug9IPaBfdIhQz73yA1oOxd9wVnC0twiMen8sQF11r5WC0L7XYCW3yY9kwglz6MSIsU6clko4xvPCNT4NTtJab4oNs+bB0wUemUdjdGps++fibMdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5+7RFoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E82C4AF0B;
	Tue, 15 Apr 2025 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743025;
	bh=yAtQC+T/kvIyaWVd4i2QUou/vgOvw6JReC/jdUjP8LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W5+7RFoUS6hl2bpH5/ztZFjxl/6Ds8uW520Nyhzd2d30ZwdIbPSG6ZA1B2Wbbh37B
	 MYkYVJ7Buxs+y5JgsptS4TNHRi/T9jyn8ASadMGu9Jk7vtzRdQcccmy2IWnK88R2AU
	 JRIXoFF/N4JwRe5KC6+0VRCCKzeJgkvRBNpejkRN9ET8wsKchrJBPygeqx9fqAdhiX
	 VKKT9E3YuZ8ctJfQhXQKZkFu4OHfdJs8+DDvMPduTY6auikcKHURIuQxbBlB/TP16P
	 OOpZbXK8fyNEbEXjEcgxWW7yL/eP4Dd8TPLGeTvFH0gdV5tMc3P79zgdjXtaN5/GjD
	 73y9IOSiNhhlg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:42 -0400
Subject: [PATCH v2 4/8] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-4-b18c4abd122f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yAtQC+T/kvIyaWVd4i2QUou/vgOvw6JReC/jdUjP8LA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qppqbzqQnotbk6ZG/YJ56GMWjDeobk0RsJ1f
 oMs2PYiBQSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaQAKCRAADmhBGVaC
 FQz4D/0WlD5+uOnNzq0BfiPoe5tT/A5Z2ojN9aiU/LWeK51HtklSUetMWZ/66NCqj7mm8wMWLtT
 NlRRwP5ululHGf7akgbhChbAon4vKUYF3d4wL92b04XkM/wqFMa1bXSEG51FNGkGkoM5lgzDv6j
 kExKhBCMG3SN/cp4XZButqPtnY2pOtheSCIBe40GVTpu3/5i3IS95S8FcSp1n3yAcJKceVyXvVe
 Olk2/cqnsd5tpypxLKWzhFf9SZNno3fXP8QcqKceEX6r/lcFl4YQLWDo5vYEPWuAh6T6RvDL2Dl
 Gze4U0Cqi8lw/O26obcn3UrUR/UO3TeQBChhpCBBMZErZSraEIjI7svWM+xl7MW/no/COjBvDDW
 AyvmFJFefXWghcXQEtYvP7KTgDRadfB7tL40gcSX+pMvku0T3fEq+AvaP+uGElWKahE1VkwDdIh
 2dEnqSAdyrTs6/nerZhoT+3uJWfSYWxLFn3G2NPHvvnauRZ5Lw3/niiEB8ZWoY6gaBhdweEFgld
 W/apouR7xpijaODq7F8eVVXOG/rj17gzKSIBE2+fh7U/yO5a8w3OXXRX9nZcTeMDf5n1HUk5VnJ
 Z7c7OlLqXezVKro3b2VuqZ8iA4VLD42cXCe6VGvVcITEBE1Inex+bnY0ZC16D93c/sjRO3q+lVJ
 4i9Qo2Qahb0WRZQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow pr_ostream to also output directly to a seq_file without an
intermediate buffer.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index b6e0a87dd75eddef4d504419c0cf398ea65c19d8..4857bcb6d4bf557a0089f51328e75e8209e959e6 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
@@ -70,6 +71,7 @@ struct ostream {
 	void __ostream_printf (*func)(struct ostream *stream, char *fmt, ...);
 	char *prefix;
 	char *buf;
+	struct seq_file *seq;
 	int size, used;
 };
 
@@ -93,6 +95,15 @@ static void __ostream_printf pr_ostream_buf(struct ostream *stream, char *fmt, .
 	stream->used += min(ret, len);
 }
 
+static void __ostream_printf pr_ostream_seq(struct ostream *stream, char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	seq_vprintf(stream->seq, fmt, args);
+	va_end(args);
+}
+
 #define pr_ostream(stream, fmt, args...) \
 ({ \
 	struct ostream *_s = (stream); \
@@ -302,6 +313,20 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
+static int ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
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


