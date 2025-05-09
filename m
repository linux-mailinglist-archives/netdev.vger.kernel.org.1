Return-Path: <netdev+bounces-189322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5996EAB197A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6973A80AB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E5F23957D;
	Fri,  9 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blJbBGZl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20519239096;
	Fri,  9 May 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806073; cv=none; b=nzRZwiOmu6/K+fooZZS4lyanGtyj8GPuEcPC9bx9n7BODcjwbvAcffsy72l5Iaalgv6S+cOwtu825RKOZb+DaJQt9DdaCymh3hGNWd/Z+0UNAyQAErH/yQTkKEfXdmPlSBZmtzoeGcWxPWAoF6QLfrIVAymDfkbtxsXM9JMG4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806073; c=relaxed/simple;
	bh=jHVEVy1GEirWdHs1IJVtpuQ6jElofdeZ5cfT2E8mzAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZloRxcPNR2IRvNucw6adOR/5fT6UEwcZtYUiqF2M/qpKBtgoerPoBaamv4qtTI2DllErJg79GoTl3xTCkt4zTxo94DxkMdInCHmDafL8pskhpwUypQb3Tc7xFJ78RjrAAqLtTjvL++xpxA4KKCJHt+zmy8Y1s2Q5gVz0kud1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blJbBGZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D24C4CEF0;
	Fri,  9 May 2025 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806072;
	bh=jHVEVy1GEirWdHs1IJVtpuQ6jElofdeZ5cfT2E8mzAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=blJbBGZlbVe/Z1qy8Z3Y3v54wvg0wbaEm4Zilv0BiBuVxsTplqgYtrNksZuUuOSfF
	 aIL9FFUhxhWCng6qFBvJjDF+E3w51MHLr5TCP8GGs22iQeHGbqQ7lqVpYgfdRpGhDu
	 ORtyOzfo361x9H946PHUEQFuI0MV6Bt7VPWaVs/KUzLzx5NG6bkXHe2m/tGAyJ8axd
	 uDqFCaz+p7IGr5+YN/GNf+EqoL2FXGaR1jrJYXEHCxjYEN+hOX63FmecDgWeSNo1zP
	 siZzByFkZ1xGuAIa8M8NVNCsun9owLSzfR6QHQq25qchxKC78uWmv0Ll3HAZkcDUHD
	 WwcXcshDcsL0g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:39 -0400
Subject: [PATCH v9 03/10] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-3-8ab888a4524d@kernel.org>
References: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
In-Reply-To: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
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
 h=from:subject:message-id; bh=jHVEVy1GEirWdHs1IJVtpuQ6jElofdeZ5cfT2E8mzAk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUuWhoxCBEpB72n/4e/EUzY2pNuIvDqSMshL
 uK32GMxI1+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLgAKCRAADmhBGVaC
 FV3dEACLyIDmGtCpTrVgq8v05y9ny8X7TcKpv8H64O1hmizVTSOSzXlfyjBbz7rsIK92Pkq0rcv
 ryhDiqruL4zhKhJu2TSE4Ax8SRnKGtEEO0N63TQ4P9bqxl9EzCvq/rSDc+X1CHT8DVZxxFQrWnH
 41ICG1hTB8rCcFf/dbl40M4548aJxYxbjnT5TSW1+JkRmcIF3DMxQSaRwGr2sE2kLTH4+/aKIFu
 Fv8MSJgDdiGWgKAag2a6yFop61leCL/916AEeMxS6GSgnBqs30YVS7yRnta/ONkLJQJWlZo/FeG
 FwpxkIovLzUHQJ9lOQdXj2A7Ls4q5tTelJwh2LpsH7nEGz1byQDFkKJTZ4dVNt5plYIUzkGjoHo
 kaGwrGtx+I8vf+dGYtTxSMFxkxp2ePP97Opm00ZwQJ00YUlfdaf1ruo7lvnESckltCM6h6amwuz
 A0hocimBCngqZCm16++UqkFjegU+Ac2+pD7Gy1f/8Kileyl14P9C2n0LB9yVHaYHp03Cg67bbxp
 uU2K7PzC8U0rXkXUKn2K3Se1E6KwNdLAGK/tESDmBAi5W/lJ8L/hrDOaXNZCMKYmjCY20WuyH30
 C7uryVIOtxdpAZf8ihUh5iqEaPOGWevRP/ZMvMYG6E+aIZvlht4shHaUMnAcJXG7xKR0+GKkPsz
 VxfkUUwBYz9NdDA==
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
index 34ac37db209077d6771d5f4367e53d19ba3169c6..607718d00ffa74bd6d9abf97e913abcfd56dd1c8 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -63,21 +63,37 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
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
@@ -96,8 +112,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
-			   dir->name, dir, stats);
+		pr_ostream(s, "%s%s@%p: couldn't get stats, error %pe\n",
+			   s->prefix, dir->name, dir, stats);
 		return;
 	}
 
@@ -107,14 +123,15 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
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
 
@@ -124,7 +141,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 void ref_tracker_dir_print_locked(struct ref_tracker_dir *dir,
 				  unsigned int display_limit)
 {
-	struct ostream os = {};
+	struct ostream os = { .func = pr_ostream_log,
+			      .prefix = "ref_tracker: " };
 
 	__ref_tracker_dir_pr_ostream(dir, display_limit, &os);
 }
@@ -143,7 +161,10 @@ EXPORT_SYMBOL(ref_tracker_dir_print);
 
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


