Return-Path: <netdev+bounces-183755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41E0A91D70
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D543AAD6A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455324C66F;
	Thu, 17 Apr 2025 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQ8D1RDH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD724C09A;
	Thu, 17 Apr 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895486; cv=none; b=tBJcfv2t6QCZ+eEEtAMuMEWrzTVKSlw20d0U/XeVw0V1lU0PkN6FylMx1TRITa8Js7a6vWJw0lFWHkthN6qJYxM848HuP2VPKvpx12Dt8JIntjkawAs/Y9F14oBkg1M8L86ANtQdVXlk5NdmijaKf6guZtdfNN7cSa06/0iWypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895486; c=relaxed/simple;
	bh=yAtQC+T/kvIyaWVd4i2QUou/vgOvw6JReC/jdUjP8LA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k+iPeMedT64BHXBDEIFB0+hpO9DysEmAWYDVHdydG9yfovDTh6vOaXtk/X+id94/BSwZiLVCOZBGOmRgRM4bWYYqrYU4TNyndgZKy0aCR6h7K9+njJ9MVWjeASiVh1ImoytBVDLlxgJwH8Ojs2XcMKiEU0z/FxxShgI+F+F2ocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQ8D1RDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F17C4CEEA;
	Thu, 17 Apr 2025 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895485;
	bh=yAtQC+T/kvIyaWVd4i2QUou/vgOvw6JReC/jdUjP8LA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MQ8D1RDHtmAN2jG4WAqAmBlSGJzLhLlxw8G+K3vA6rWZuHBpsRQ8VTL+Cnm7uAogI
	 izPL41Tp11xH11Wh+pERILy7ClalB27x2/51gcJfRny3QMD3YP/E2srYswYkWLFVii
	 +n2a3PKH4X019uMgu1aqiPSGgS/X7Er7ujHEr4/+AW9xXuYTWgp9+L9dZqmneLOfkb
	 ECW2POriEXxnWUFZ5YaOH2vLfKZnAYQvSyDdhFdrmvsDf3uAWEMqCHd/hDk2/LvtzN
	 rca6RSW7KkeMdsabuxL0Jo57Ag66Kk1FEzllWne+xtKxh3whrUGYo0N1Ymi31nulsV
	 mB+u/1CH3ieiA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:07 -0400
Subject: [PATCH v3 4/8] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-4-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP321YN2F1YjeV3Kjoqgiv/5q5RrzHMy/MKrh
 K3HY1aQK8uJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99gAKCRAADmhBGVaC
 FWtjEADBHGturis7doC2MJvP1kXI2piqnl55Mcwg9P56MIcn/7Q7kWWXJ+mGit7NsJIusTsgdHQ
 tKuA8xpPwDiSMNJVqzuyqbVwhzF2dPlGfh1Fv+krUrrBjKsa/l9GRmN0/QuAjLUHOdckbe9Eu/z
 XS2FUf7akH5cWCZx89e3bI6CsZ9pHeD7htAZL985wVRra2i0LlSzD57Ui8F5twJNIRFjWj69e6D
 TlVjHoxbQDN61OFKU483be0+B/9Cku338oPcts4AnQQXyLhMZXIv+HSiKLD5e0mLXEuBTEfNMOL
 NDbA7kbRTdm3TVedaFx8Ll5YRp55mGEsIbzOxMkvbp/k4Gzn3hS/rOCJYM+i5IitUhLYCPszSxt
 tS6Ys5xuX8DGOiPPDD7VQiahcVXIiaVE1ZA2U7NuaJHXFID75OnTsMZLU40CIp4fWxyuBcmZieJ
 kBC6y8C0WKZh1iT7ZeBhxHOfdOif/YUKGlN+Dt0IBD6lSINQydxoQuDftwawE/LD4k/Ug9NA/ep
 TFREerQ22/ykur8oJxJ29rvB1WFWNjNavHHdlmQz0TyBqyVoVT8O+qTs1PDiU6AUmLtY80h6yR6
 54YJ4vrbHD7yCqr6BTiElVNYPpOP/4XaX+syqsCDiTtRU1S7Z15UtOQC0WFjrUpwrGyH47Sx5ay
 vQyTSXggLgqwXXA==
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


