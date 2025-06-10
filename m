Return-Path: <netdev+bounces-196166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525E3AD3C15
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D91C3A8BB1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA52367B6;
	Tue, 10 Jun 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNqqe3Ht"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB102367AF;
	Tue, 10 Jun 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567589; cv=none; b=ct/99x20J3ue+EPekmTjWVuyClLE/d4AswGUTVvNgNekVBT40LEM1vtus0TEUkli8n49tqgSKz0TpLlorllx6iBPF3aIDxRs9aTSnku/aABVJTQejqtCTNUdlcYnt8CHP9u9OXUeX8tdxZJiBfQwJwfO5qAoEyyH4mv6ShtLMO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567589; c=relaxed/simple;
	bh=TA7LFTdMJDELDuvkJuuGw4yjXy1LcM/cr6YWykJIBfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K1xvzacYHCPy9VDMYurnvZzIP9nf7VIMMDgzqV/1bCCW4MjJVnPt1D4xzPGAvvDhahASBl5cp4ZKGGW1BsCXepbVPGGhw/aPdNrnI7kMoMN0cbqDFpnzgSaHfLmhAFc6YHZ0BSpMw6afdmchJRUhOg85hv0KgxSVQJUjGzNN5nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNqqe3Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FBC4CEF0;
	Tue, 10 Jun 2025 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749567589;
	bh=TA7LFTdMJDELDuvkJuuGw4yjXy1LcM/cr6YWykJIBfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNqqe3Ht7L5uldmEHCP7RLJaG2BHU3kY8H80TOvJVTiDeo5JFq+w20dyptvq/CkfF
	 E1qitf9Vh1g3irZGKxiZhHYSQn8W+0L7g19lXcweWM4VKupRWGOu5xPqaOx3vUFFDR
	 15IRG54ikjZQ5oy2H1o9Eg0G5BQmKvgxpm9Lncy2KVtsttkiRMz/WY2JLte0F1wM4l
	 uypoA3ITLKC9OtgGWEr23lugj8/gk1lLfG/Ij/r919tL1GSj2BT3q7Ys2ASVRfTDgf
	 00KBw1BAntWdwdgmQAFVjuYWvHCpNqL4RTkoGz6DbXREN5QsKGr1S5tDc1Qf8JO5DC
	 yfbaM7I7o3RZA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Jun 2025 10:59:23 -0400
Subject: [PATCH v14 3/9] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-reftrack-dbgfs-v14-3-efb532861428@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4259; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=TA7LFTdMJDELDuvkJuuGw4yjXy1LcM/cr6YWykJIBfY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoSEhbBaxUwN4zmjZxczwu5+EAvIJySnjzanBf0
 QAwBGwzG+mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaEhIWwAKCRAADmhBGVaC
 FV+1EADPUoMc5SDvMOerP9H5Ji5Ywu/H6z3pilAz49hGSmmNpqumFD90az6zOBik1x2uagsUHH8
 FtjrCnfzcIXeqy2ExfHIrm22zTcxxmQfZ/r02Q270v7lspfRF6528sui2LNq2KBYQZvejSywHW8
 FG40u4hV/0XGNt0zxYGVBGfBFj5y2laaMK1HjZ5mnymOcA7rvaVk717oTAQrr3mpMAKYrp7O/E1
 RkrHX/oczM/cQM7hW/wMzBG7Fne4qaQ4pbWzQ2IXjGY/5Sd4aapQq+AKhO7XadZbS+LbtoT1Yiz
 yV0Ne8LVh4bTnrljrziZp/jdOoxZTL/jpTCygQ4vulVDkChnwcO0kgVdt1kjSZ8f6qUrvTqqe6R
 1q/NKh/wcy2bLtVCdRmtltqFHUf+zuIoifQ5q/avWysthzEuvSIt8Ugql8OSdd+GQbCijvOodrx
 lX93zrx3MXOc1YSaegRDubzNDdDUq+pVjS8jKzrKnqKN3mnAH1oek42h8jAtIQsaGgeuKUhxRAK
 6brHvKV6jIoB8I3wXAu00ffDzDKzNaUz04gzJF6LBJdy7evjHIS+0CtZoMXggcvWtgqOyhDmqQu
 ezBxKfXGm2VsVgt1TjgrQxe5ysVdPbgdGU8rXhjyqwXCCl1Kfyl+xInvrHDIewGA/MDYJ8tEcXW
 E2MNjijdb7hiKLw==
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
 lib/ref_tracker.c           | 52 ++++++++++++++++++++++++++++++++-------------
 2 files changed, 39 insertions(+), 15 deletions(-)

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
index d374e5273e1497cac0d70c02c282baa2c3ab63fe..42872f406b2a91b5bc611405cae7ce883fd8ed22 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -63,21 +63,38 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
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
+	if (ret > 0)
+		stream->used += min(ret, len);
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
@@ -96,8 +113,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
-			   dir->name, dir, stats);
+		pr_ostream(s, "%s%s@%p: couldn't get stats, error %pe\n",
+			   s->prefix, dir->name, dir, stats);
 		return;
 	}
 
@@ -107,14 +124,15 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
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
 
@@ -124,7 +142,8 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 void ref_tracker_dir_print_locked(struct ref_tracker_dir *dir,
 				  unsigned int display_limit)
 {
-	struct ostream os = {};
+	struct ostream os = { .func = pr_ostream_log,
+			      .prefix = "ref_tracker: " };
 
 	__ref_tracker_dir_pr_ostream(dir, display_limit, &os);
 }
@@ -143,7 +162,10 @@ EXPORT_SYMBOL(ref_tracker_dir_print);
 
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


