Return-Path: <netdev+bounces-186533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B59A9F885
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A1017CFB3
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B4E297A62;
	Mon, 28 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItJW/ApR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1B7297A5B;
	Mon, 28 Apr 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864828; cv=none; b=mcPNWtLp04dQhBDCf8lnvR1fXHQ8E9cyToxqbgmKY7F9XEABSFj7LCTwdsdXPeMrmdBQ7yzD5UIuTkUswcp+nqVcrluEoGVxbdL4y8fkblgVpdCwgida7bRa+yYkQE0H+ETNlG7p24Ru7p3nE8GxSaU29prn/7K7u5m7w5Runi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864828; c=relaxed/simple;
	bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgt365IHnis3WjA/YvfPmNu8FbAFYLY4Pe3EwhJf3UBcqzHxpJP4LU2zOaivarjdrQm+/zOFqKr3K8L2NiDYTs+zUf12UHtIFgj4pS00gZCqYP4lRmiDhEbAyZ2wv0xNdJZ0vb4yLGl/LKOlLZXyfZ5PP9g8X8ykSWzqJbMTuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItJW/ApR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF877C4CEF2;
	Mon, 28 Apr 2025 18:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864828;
	bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ItJW/ApRtFZNn8Pqn0PWf5YpYdYsk5BXh98Hnctw2dako7/BsLN+yRGp/nVrJTLTp
	 HuX1P37y9/HQ42hbKrbuaxWa+k4P3An6hpBe8Y6RHkLEmOY74FT/RqBZ/K/ItdfFyI
	 X6W+uQU1U8HYIPZlCT0EYDIC0PVVrq/7ch/PhgmBi+YSbmm41nGGZlsCmTqA7XnoKT
	 bRYgVxrukMqkH9+U+2jqoa+3wzV84NVZPaQS5Rf/qI7g47qnMe4yyXIMgeHmOMQ8Ss
	 8CK1s4V+R825UJiRISB6HUUygAxOh2EE8F4NDicauTgSnrt3RMV3pzRRedB9bQMr6G
	 80HEcEERy9gJA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 11:26:27 -0700
Subject: [PATCH v5 04/10] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-reftrack-dbgfs-v5-4-1cbbdf2038bd@kernel.org>
References: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
In-Reply-To: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD8h19lmvXGTuNFcSN5fIMVwJMgTnbS9ux8eeC
 9Smvy1t8q2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/IdQAKCRAADmhBGVaC
 FdZpD/9wFVujdvH6ipX25y57L5uQZU/l/dal5kV1364+dlMrFDwCExdLvbXQJclwLlzOnkGKXQw
 lSedyy9xO5/QjCKxbveMsqGstv0uqyENt0uqsFhzmtyAU4Z2UFcFRxGE2qQJ6ccdxFXb12WsULh
 3RWPDrgdZBQCrjeublN6njJdjEgg0CDo4OEotR+TDI38x71uYXRG/TB5SNRsY2T5FlOfMrgoF98
 1ANLNmsaLi6sr1IfIIAVp7Zf2kmXBZBwpisqWZ5jizuea7ZmDfSWHbL0dFpBO1SdhZCmeY4Es+/
 I+k3mY2IrJEFxwSUHHDL0X2/NloauEVq8qmBFkj/JuVCN9LaZ2FJ9wsMqXi+SRRBzyvSCiaIn7P
 JFTkQSeLJt7KrcC/4f/fRvhCtBUTJ4OztkOfv2YGDSBzZVyLZqzvbQ6tib3Z58TZGJ2+ThUdHci
 oyP96WTKknq3CTTrACZv5doziX1v0mZUs+Xe3jybtSrOEocmJVCRkm77u3mbxp+LpLH77hZPnIf
 h4GRUmfPh+t6wnMO7AiM3L1a5k4QzT0Ci7SJk5JfzaWnv0g2vvL+a/1zaeDfAaep1vY9zYayY9Z
 Z0HVST/xtbwoWkIzyNReQHC44rAA2zY1aB/4FJxAUt8G11WBDN7kemAMh75M/FM/BF2Jwx4rPgf
 fcVwGbNnM79rzLg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow pr_ostream to also output directly to a seq_file without an
intermediate buffer.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


