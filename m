Return-Path: <netdev+bounces-184162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C950EA9389C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2522F466CCA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8CD1C84AA;
	Fri, 18 Apr 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sy4y7PTE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE31C5F37;
	Fri, 18 Apr 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986281; cv=none; b=K4qzXHNgmNXuvx2Tr58LQDsazbybtKGxoTQWQPaW+Fd4jy3XknfYw+WJhbsK67ISqQQ8lu1RNaeAVnc0eMraSU3eQxLOJcXmU/R5/j07b8JU7uUTILMjTW+RaihuhpJw50R+R6sBmCCbPPgW8Eevp6EqnrCsAp4toddoe7M+FmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986281; c=relaxed/simple;
	bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ay/ZkjNPrVbBwi5tSrKk2/0Qp5QOqnnyh8YG84uez1ND2sOAWZoepcHUR8aeAJbjJ6YDiNqPleGI94uN2nRJbNhmzqMkbrRIQkT3FYwECK+fhuvv0QcYrSYMVKFEA4/TqifFJatL9LCVoYWA7tj0SjD4KSbhiV4VdtRtgW2Puyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sy4y7PTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5651FC4CEE2;
	Fri, 18 Apr 2025 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986281;
	bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sy4y7PTEdAWaHOLkwEEL+uDCGvA6ZEDjO+WyRUgAP7P176slTRHm1L/2ZJMK+DaoU
	 dpPGC5idMXlMS+xzwtLX9iZHQ6ZYKqq39BBZlOk3kFlcBZlD0jv7tyCR4hfUDnIDWQ
	 cxDFfiVOhZoyUMlJCfj4wIoDX7ebvcek8DIj9lmg5TiE75b9iBJMv8B06q11dCnzC0
	 MG/QyK7ll31ZkSWtzmJLrgLVZA63fYL0bdRZohWW0E2Nxu7K6t3uslv7oRC2zms8u4
	 MI+DfZlXMQmJkTR29J14L+TWH91Md+GYHtLPm+l/TUoKjVho4u1PYcKltgXit0/K6e
	 /zt9tRdC1W5og==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:28 -0400
Subject: [PATCH v4 4/7] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-4-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1942; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=fZKlpIcOJEF616o9qzMIcvZOI/oG1RfsOsr5fOV2mTY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmCinpbaziQltBaRohrpGTmSAVuUse0XYHvoA
 PTj1MwrV4aJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgogAKCRAADmhBGVaC
 FSzlEACnnocC2WTgHkIMfOzvJieuIk8aTMSGhsQw+yQI0hAQWK7kr11tlVg56oRdHShiz5Hj2So
 +8FSHRSg9chXDGx0IQ/kFss0f9zSBvs8I8/dkm4xj1e09U0GjLD6yFvPKb4dN83+imFJtkVSWwk
 lVXJ1XYhrnwxaakfHmfrP0E0b2TM9B32apfFXeVTWbOu+tvW414d3f7EfjukF6BjdzE5xpY6wRg
 eoszf9vVIpqGzhCXuwUPW58W190AbhJHO+fqEputaWrbl9fiO5cRTLwwifOHxRqQR3TNI+XGVOr
 eQSM0o05UyPjeg5GBHHFuwEpxwQZYtw5LEqYCJLBorr2PdYg1h1+FE0bwlL1Mt45sJkWZIMEAcg
 3m4dyrK/SZJnwanXx2G8LpBQ76CFpQyPnAI3A4II3hN1JyGLHKRLEdiTu4zC6HUz94+n+oklBRj
 in6Zt8etwWg76JPdy4UjrCdK9/+DLd/b1uiGDbsGGwF+7f0o7tNnLuj6fIzh24JLgV2Cy+6szow
 8usiGhJaiQM922oh5i5bwpu3oU8uSFY7aeNHOOk1b9gbGiKsx3ytqW56jC3sbJxQwMWABnnLlyB
 KXQfplR4op5om4m6c2rX8c5sZJdrfqSoqNULv/wTCUlCLTUEn4Nj+jkkf3yvKTAQdkW37zoGo7l
 JRPrO2lXTfFrD8A==
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


