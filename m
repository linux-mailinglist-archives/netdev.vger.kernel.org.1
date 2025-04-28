Return-Path: <netdev+bounces-186532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00230A9F882
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F57ADEED
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418142973B5;
	Mon, 28 Apr 2025 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddc0RbMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C122973A9;
	Mon, 28 Apr 2025 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864827; cv=none; b=a3mHQDBBFvo7kTyFY7NsnF/uzk6FMzr8dWJROamVSwQjexxSRAWGLrsIlIYl+XN3w4bAgDO+jl20/K+e4YxauTRtwEovFaw/Jk2BWBzImyYZVkay3vqmAe14Q5H7x8mJRnMbWzblAuNuMpzHUBQ/fbFvkEEOCVoyAmcfYN4fMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864827; c=relaxed/simple;
	bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MXSExhh3HTvPNI6gB6dAaTBBgeU0KDsHuXgKAbisj7nBgcU4+9e7mJv2PX/DVD7GVz/RO2O4iKNttuxLm5d9qt+3UaeJi/hbYt9/qTtj9t3xMxwN4aasAu7V+hHvJj1i++nW2WXU9ji4f/ZShOVQjXbDR2MjaJh0IPaBSd/j/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddc0RbMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DE3C4CEEC;
	Mon, 28 Apr 2025 18:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864826;
	bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ddc0RbMZ2RNaGjr5X9rVNs9k+m7QQM8h9ZTzFISuxbFkEzYcex0f7XolRLH4wg7QI
	 UPmeUY7+pfi6pXn0qMc0QQ07+n3//mUfTzCOIZizWJdEUFX96+H1m0UGDLHzbQP5eL
	 bGcGFeIBjtYZLZa+ceoxqMbYDYWk6KDB2kwwvR417YfhnblMe1FLThpb2TZ+8n1t+Q
	 A07MBHSJqOd87ep7caLElsEBWrzd1yzTPBaE/2H3NbNM62H3geXFMg+i4m1MKIVhNL
	 8gp1S0LYC0c1OwLfnBCbBtiar2LRbzrWIrfg4kRs1qWH+t3bquH45njB6QD7/2R+52
	 ix7XD9pOd7FQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 11:26:26 -0700
Subject: [PATCH v5 03/10] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-reftrack-dbgfs-v5-3-1cbbdf2038bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3845; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=D7eYUyrEMPuIlNDnf5xYhfYtI7n2pvxbIb5qGlnf6w4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD8h1XVu89ohyOL3T1JI0o4sLiqB9ffJ6NnrkZ
 fWTJ/gucbeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/IdQAKCRAADmhBGVaC
 FVEfEAC1my8CPpLPuEeBqMbL7WKjg4rDZRfY4k/3dG35jzMdZQm0WyWtAVLj5fwf6n3ufm0CGkm
 1AV3VQJmbvK6aaS7shkE//6UHSj7ji5h1INoNVFgBeMn4615sKOVfgjC1q2Nia2ULNZLTJHbq8A
 oyVT3tSrW7dZiTyVlXQqqO+T9EU+oYK/QVWhgCqf6KZGL/tkyNYZv5w77POudhVvY5dlSPjTaG1
 yBrwzggguueY0zfPOihd5sZ4VVDNabamgAsY4zNqWD+CwXozQ3Ez6u627Ot64Xu/3XDtq37Tumg
 ++rHgBE5j+izUo6U7o8OnY/1f3b8VB0rNhQeq/hfmwuFKVhl9PrEHGWscK1/bvOvyqWWhEbDw+l
 4RBxAHHPLw+j/PYxaF/O+j4YTrJCzmlvtWDnWfHb9H9B26Po+j5PpUOuG9GdOZHXYD3Ur1taWAD
 lkUcpz4FEUnSiuOTFxz5nQvGTSfIJN3GoAUKjF7kGTfbK3qbzVZ0REcLbbsO1lt59cQRorUN+lQ
 S0Zw3fOR/CfPlLGSmY4QeFbZCT+PEBSpPJOscAmoHgcPcZm2cYISraSUnPqC1k/Y1a2miruSuKn
 NH043O9JVQhl/faC39DYaz7a/mnB9V8HceBJqqlYICs4CETcKt3fgvJt/aZ1MogwAnHRezTahAs
 Km7+wg8eavv/Orw==
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


