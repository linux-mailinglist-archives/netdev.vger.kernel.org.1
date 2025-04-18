Return-Path: <netdev+bounces-184163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97FA9389D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BBA19E74C6
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45B91C84C7;
	Fri, 18 Apr 2025 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofYeUzlo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796E1C6FFD;
	Fri, 18 Apr 2025 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986281; cv=none; b=Y6u6fBP8wS5i7g7oo2MsoqnJBXe7CuhBSDblE1kbBQ7gR+TT5OgTDzh4yuGwd3Mpy15Oz9zrVTRqRNqO6rJ0cOfyMDABuLi6+JlhFYOPBaHmQhfpQHYnrUX6WTt5CO/rsEczUJQMpDBi9IMSrUZ3lc0U4h0Z6xKpE6X9xdr0GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986281; c=relaxed/simple;
	bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=miBLwVMcZEaN/HIgaHiYf6+PGTByymA9kbGaUs2KdAn24+SaXldqK7BzREo6ZvxluPZiIrMb4bKQPn7g6gW/CChUpEzhPtJRKFcvA6h+04zGsy7eyx0qrdCaij7L6ufPC8Rsi49UIyADT+Hn2ILTyXzf+MlmzmvlfGJbfj9jefE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofYeUzlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6D7C4CEF2;
	Fri, 18 Apr 2025 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986280;
	bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ofYeUzlox9uWtcLNl7Esb2oBKMELkdJ1ZGY9Bmhgf2TertDURWl5TShacXPzHgg+S
	 HBEkd2DsXNkH5mA7r/1jXgMCLbsFiuBQ+e4rHYzqD7LKdw/zUT/ud+klGhv4aAcd3L
	 Mv8h+iaq6bqlFNjVrMVJPXP4Tph2XEFMv8y8XEJf8bgY+HZIpm0GtBPMko8KhVaky7
	 b28rf2dp9+5XgyuypflWSM5u/iVJ/ZPGZxpnXztAkP6yzVMbuoHcesWFVgn5ZZPuh7
	 0du+BPkOpcl7FcKF3CD3FHhCkwn7PXB5h97LerF+bpehj5IfnunYOlXYTQUw0Bq3q0
	 lKqOZ9oKenmLQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:27 -0400
Subject: [PATCH v4 3/7] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-3-5ca5c7899544@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGgCYKKgC08ojkyjrEZmeC7xYrrGwBw/T3ubSfBrpAusVY60X
 YkCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoAmCiAAoJEAAOaEEZVoIVwkQQAMDe
 s8XBGsAfFwViSoXC2FZCfUpv6SS7XHBf4kD7FHo2IDA1qnv7mevPEVBNiDuB1U0XoIluUJrWQRW
 WOkQ5jFeGGiRLBt92IkzdLjbe3Ccppi+EHpKUTIb9PPvtRKsstDEjwdNzBUM0goBgd/KCGtrdhI
 gJsgEKXt1gCTpe1jfjr41pc+bwSI4CRjYnyrnX3R/m03R4l4NtiS9cAAgKjERWHMfvrvetRJGYP
 rf9wjj1HJRpBoa8Zy5YjSUrIIW5fnNU+MyG1bV5LBXhy3zKiQaPWdUic3Ly9cfdTRkOyQ7yExyr
 Cm3SRq7KkYPMeXT0t1snbZig6ug1JogdD71puM8el/0gA2IUl3kS6FnfLG2yn8Bkawlil8hpxkl
 0GDcstxb76L/c3JxEpcT8XcAmjGBCB8hJRWUyTt0YnqxD2SSpbVrGYlhxFiha3LynyfVqKaph5C
 yqMjt1tv+rHk5jBoF+MgGKG3VAnIq3H907YGsbU5KkLdIN1YlFlPuGLmEPvnLzGf7jrwj3dgHMP
 H0oHNf++lr+xmSDMewziXJBxUw5+/de6jFDEbCCdZTVRtOw3AkluiQP5WOUwYNe5WZK0eM8LoGc
 zrbbb2pQG4+L27ONpThnPkdmMmp8dTDkL4G/hPNsuCD0UKu5uqIA1zR7uZYYFJK0Qf4xSw57cEU
 zKUEi
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a later patch, we'll be adding a 3rd mechanism for outputting
ref_tracker info via seq_file. Instead of a conditional, have the caller
set a pointer to an output function in struct ostream. As part of this,
the log prefix must be explicitly passed in, as it's too late for the
pr_fmt macro.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


