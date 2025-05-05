Return-Path: <netdev+bounces-187794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58897AA9ABD
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E59189ECBC
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127712701AA;
	Mon,  5 May 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gL5CUQ9l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD32701A4;
	Mon,  5 May 2025 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466416; cv=none; b=Uusig/N07ciF3qdlDc3U0NCvOPAp26YZ9IsKTFsO6God9/sGZ9lvYhQYdL9QoctOjEEkPmbMQ2Jx83hJ1VRHtG5lL/OngtMKI1DlATz7jjY+xhNBOz6vje28yOFVJVxVuIUO5zaEs3FF37AnQOdaVXgIa1/dGLRUWW7aSa57oSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466416; c=relaxed/simple;
	bh=XwNqVIexu/lptKD/9mAKjpUTud5pI8FDB+cvkqs7KjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tp5YnJq5ov24O45D5T1/ZmHQx36KiWzIjGslwgU8zCj9euwTZ0tzQC3zOU04tD8873s0Mw6wthkVa8B69Gq/xGwSyr4kSqX/GZ2yQ2pf9DfTIP/5iAAQBK4OI7JmgIWToR152RiDkVjxonq8chtmE8TNG43AlkgWtVxNWLtfN78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gL5CUQ9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D485C4CEEE;
	Mon,  5 May 2025 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466415;
	bh=XwNqVIexu/lptKD/9mAKjpUTud5pI8FDB+cvkqs7KjY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gL5CUQ9lz1OJlb5Hd0RN9DV+gQXwBzOpJX5wsFfSroA/GzgQ2ihafylcwIxeufS6W
	 vmsL5HUZuiWufzIjfCoZ69A4GqEtSlHoNBOLsdRfoqUJqUhGLcKUxW8+Pfvn+ErGU/
	 6UvczOb3YdVd5vDV4UlvelBZf+9KdFvVFdEqco1jFu/yU5o0WcKl+6jQzBh4ZcP95Q
	 2zPmpS7wCRzW3nL1mQyHwE6z2SOSSp2q9cY09EPD7CkoPaVjUVbs4sqO3vg6tjCfeP
	 WhedAtD+1Qb6DQ2sJS7PxlJDTOTWoU0y1BtO51F5qpNtgKSLIwXFZUnzXRpxJhuzNz
	 s6ArrUn+tOBZA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 05 May 2025 13:33:17 -0400
Subject: [PATCH v7 03/10] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-reftrack-dbgfs-v7-3-f78c5d97bcca@kernel.org>
References: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
In-Reply-To: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4242; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=XwNqVIexu/lptKD/9mAKjpUTud5pI8FDB+cvkqs7KjY=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoGPZlMQ90l7Y0Fpb1tcNnuKqBU+1AkPwPJCbwv
 zV53wXkqHCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBj2ZQAKCRAADmhBGVaC
 Fd6aD/48q9WF3rO9QZKZQoDwaRaOcE8AGZb61hvWvJFRJvRXGxnBBP39T7ZpCBtB/1YOTVRWO8r
 IZGwLs4CqKIuIwLQmM75mUsvzeZ+zgLC60vscQp6jpzV3owwIwGr4zLm9eIeNIlNyllodL9eyy7
 7HczUx8znOF3yCye9LWsF4fpWrmMMdMM7jHkLb0EzigFjX8vhQEh6FaX6x+HFWXjnynIFx4OGPk
 33gUHRh4HyN3ru2+ldUWRw+tmwXumq2FP8D+Ua86cNoPOm3rUBW1b3b7k25IaokC7Xl1sPZBT8e
 5OFHwlb2SMILS47ETEVn2hKZQ9vXVvVvZdEI+PHQAExF8Ikeb1ZCin3zuQ11oiff/iposHdh08p
 0lYqjPaa5HXblsFSJzs/K+AXI+ZfKxI5JvPUIkWuN5CUEJn13RsnqPL2tQBaDxvE3fwuaCUvX8S
 G4JeN/05jb28ZQtnlNa1VtcHnvvypzv/q+PHsy6aIbT9JIA7O7bWiZ70jhoSzOcnloJnsFm7mNt
 ntJFLGvuZyhdMirhVd3UoaOEl64dxzV6uLCrM5YzjS0WMu3UsfkB/Kxwcb1hYrGS8DLjTmGaiuN
 cDFYERFDuvR5aY+8QhUMdvWHnBEFrBnZvXfvroe8qxOq/iyBzL+PUmbpKKQRrOmTHPCWT37eK7S
 oY0qP67ElbL19RA==
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
 include/linux/ref_tracker.h |  2 ++
 lib/ref_tracker.c           | 51 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 8eac4f3d52547ccbaf9dcd09962ce80d26fbdff8..a0a1ee43724ffa00e60c116be18e481bfe1d1455 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -6,6 +6,8 @@
 #include <linux/spinlock.h>
 #include <linux/stackdepot.h>
 
+#define __ostream_printf __printf(2, 3)
+
 struct ref_tracker;
 
 struct ref_tracker_dir {
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a66cde325920780cfe7529ea9d827d0ee943318d..510d927c785576fd90292d325d20a465d5f38079 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -65,21 +65,37 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 }
 
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
@@ -98,8 +114,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
-			   dir->name, dir, stats);
+		pr_ostream(s, "%s%s@%p: couldn't get stats, error %pe\n",
+			   s->prefix, dir->name, dir, stats);
 		return;
 	}
 
@@ -109,14 +125,15 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
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
 
@@ -126,7 +143,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 void ref_tracker_dir_print_locked(struct ref_tracker_dir *dir,
 				  unsigned int display_limit)
 {
-	struct ostream os = {};
+	struct ostream os = { .func = pr_ostream_log,
+			      .prefix = "ref_tracker: " };
 
 	__ref_tracker_dir_pr_ostream(dir, display_limit, &os);
 }
@@ -145,7 +163,10 @@ EXPORT_SYMBOL(ref_tracker_dir_print);
 
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


