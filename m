Return-Path: <netdev+bounces-183754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138FA91D6F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB68189D730
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295624C065;
	Thu, 17 Apr 2025 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM5B3Huz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BE24BC13;
	Thu, 17 Apr 2025 13:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895485; cv=none; b=XHERDPXDLx4h4+PTeyl74xVtXmYSkEnCNPfTI3CeNi5rnCuILcLPV4gBe4yxpyjExi+82klwXwjiFWg3ABloDeHhlwSOXosG/iHLYF1rzvk94ltBzWgLVSmfzzYtjoNfCLfeUNlTxI66xJPyn/M0kZs1rIb6RXcqSjIJnNrDhgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895485; c=relaxed/simple;
	bh=hJcBuOT2Wi8dUrGdHbQ64LKjsIpqJcmHANQQSzrErKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gcp43Ny05xvXquVZq72SSzHGGZ/hsB/V/fAgAF+Wt4NxpctV4ErPdyftYFgq7srArvyJznNck1ZFD2WzFTCojHW91FcX2lrTXQW26xM/+e5v9YLvvemcZrx77CgnyLlluytzN1RWo8cdo+PRtrOsnALqN2F1mjrsRwCCRNzBRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM5B3Huz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4773BC4CEF1;
	Thu, 17 Apr 2025 13:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895484;
	bh=hJcBuOT2Wi8dUrGdHbQ64LKjsIpqJcmHANQQSzrErKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DM5B3HuzAv4qMoqLojWxPh1BHPELcET7qkooVTvLOab8IybBaaM+9yUV9WPUiyfgZ
	 XrPBNgv1fmBp1ZHv0WN5+I45pXYP6cnjHd3w8AE3YYEl1N9Fbt4lwezyT+uuS+2Svh
	 N6JevzDFIrGkTP250CWYr6+MnQ1cq1hZ42A7YzgiwK5xdP7eIpYMSSh1G4sEBSEf+8
	 7OuAqU/dxUvoSYOOsNASUOIjrrKbDR5U4ENuB8vyEDASbMMUF4CbD5x45Iiga/dz8j
	 B0zYg9EXvgT51Hsz4rvcMRnPgHL9rPCR8fQwSRrgpd2MyFkQV7AjOwsARSHzF6LOz6
	 iMai7HM20rijQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:06 -0400
Subject: [PATCH v3 3/8] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-3-c3159428c8fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3802; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hJcBuOT2Wi8dUrGdHbQ64LKjsIpqJcmHANQQSzrErKQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP32Ngikqczj888xwpts95bbXi+Qwn535JNc0
 HgmF81ZXH2JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99gAKCRAADmhBGVaC
 FcM8D/9nMDELBlNeX4QMRyZzD79WVVcRS/LSHXnxTFLU/e2B4ZkoA7JMYM2xmM4H71kfJ+XfmWv
 KMQ5aicPEiEDlB4gh8z94u4QsTiLfQWgUisBFVswJ0q3jSxHtzka7JqD+Va5WkJKIFnkUYkOn73
 +inOHIJK3HhvToMf7Ew07LIhyGTGQoN6T2eVklPWuJKe8F55aR0k+teFJVYzMOLU4VCQzd/B8dc
 C+I6w6DjPXO81xzbAEgsegZl7VkKpuoRKhGlneQcTRUTgPSDdL/Slpvzo36kiNF6h1fLERqoRuh
 7Odqczgf0gpbGE99/ix6TgCU9JoO3qWdB7EJgULiO+Krzc+W5cr96FZhJwCnsgEIyrjHoS/qZbe
 uQeugzsAgbqxtHi+Oucl9RA/tD0R7vFxqaum/5/690kz7lEUTYi+BzMdpM4Zml3hEvtMt/BO4Fc
 wjmt45lzPZ4ysOsyYMYVOaumMkau4OIINQ2G8j5TLwqQ/Qa1O3UKZCnAbfOJ8EpYDn0DAXPwQTx
 /cmN2CJtkZzr/KUy0VbFLd66MwmquS4sc9GTIxOGYK6U5+vdt0Wc3fwCt38GFnWS82Ja9W0jFGv
 khNJHX+A601eeezW0itcBFQ9WZwx46z8jK4RVaRA0fT+cv5/z5ystlOTZ2eDE9ThaOATSvYsnjc
 RWIbVZdJ557bnvA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a later patch, we'll be adding a 3rd mechanism for outputting
ref_tracker info via seq_file. Instead of a conditional, have the caller
set a pointer to an output function in struct ostream. As part of this,
the log prefix must be explicitly passed in, as it's too late for the
pr_fmt macro.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 53 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a66cde325920780cfe7529ea9d827d0ee943318d..b6e0a87dd75eddef4d504419c0cf398ea65c19d8 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -64,22 +64,40 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 	return stats;
 }
 
+#define __ostream_printf __printf(2, 3)
+
 struct ostream {
+	void __ostream_printf (*func)(struct ostream *stream, char *fmt, ...);
+	char *prefix;
 	char *buf;
 	int size, used;
 };
 
+static void __ostream_printf pr_ostream_log(struct ostream *stream, char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vprintk(fmt, args);
+	va_end(args);
+}
+
+static void __ostream_printf pr_ostream_buf(struct ostream *stream, char *fmt, ...)
+{
+	int ret, len = stream->size - stream->used;
+	va_list args;
+
+	va_start(args, fmt);
+	ret = vsnprintf(stream->buf + stream->used, len, fmt, args);
+	va_end(args);
+	stream->used += min(ret, len);
+}
+
 #define pr_ostream(stream, fmt, args...) \
 ({ \
 	struct ostream *_s = (stream); \
 \
-	if (!_s->buf) { \
-		pr_err(fmt, ##args); \
-	} else { \
-		int ret, len = _s->size - _s->used; \
-		ret = snprintf(_s->buf + _s->used, len, pr_fmt(fmt), ##args); \
-		_s->used += min(ret, len); \
-	} \
+	_s->func(_s, fmt, ##args); \
 })
 
 static void
@@ -98,8 +116,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
-			   dir->name, dir, stats);
+		pr_ostream(s, "%s%s@%p: couldn't get stats, error %pe\n",
+			   s->prefix, dir->name, dir, stats);
 		return;
 	}
 
@@ -109,14 +127,15 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		stack = stats->stacks[i].stack_handle;
 		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
 			sbuf[0] = 0;
-		pr_ostream(s, "%s@%p has %d/%d users at\n%s\n", dir->name, dir,
-			   stats->stacks[i].count, stats->total, sbuf);
+		pr_ostream(s, "%s%s@%p has %d/%d users at\n%s\n", s->prefix,
+			   dir->name, dir, stats->stacks[i].count,
+			   stats->total, sbuf);
 		skipped -= stats->stacks[i].count;
 	}
 
 	if (skipped)
-		pr_ostream(s, "%s@%p skipped reports about %d/%d users.\n",
-			   dir->name, dir, skipped, stats->total);
+		pr_ostream(s, "%s%s@%p skipped reports about %d/%d users.\n",
+			   s->prefix, dir->name, dir, skipped, stats->total);
 
 	kfree(sbuf);
 
@@ -126,7 +145,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 void ref_tracker_dir_print_locked(struct ref_tracker_dir *dir,
 				  unsigned int display_limit)
 {
-	struct ostream os = {};
+	struct ostream os = { .func = pr_ostream_log,
+			      .prefix = "ref_tracker: " };
 
 	__ref_tracker_dir_pr_ostream(dir, display_limit, &os);
 }
@@ -145,7 +165,10 @@ EXPORT_SYMBOL(ref_tracker_dir_print);
 
 int ref_tracker_dir_snprint(struct ref_tracker_dir *dir, char *buf, size_t size)
 {
-	struct ostream os = { .buf = buf, .size = size };
+	struct ostream os = { .func = pr_ostream_buf,
+			      .prefix = "ref_tracker: ",
+			      .buf = buf,
+			      .size = size };
 	unsigned long flags;
 
 	spin_lock_irqsave(&dir->lock, flags);

-- 
2.49.0


