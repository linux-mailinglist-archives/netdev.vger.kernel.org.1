Return-Path: <netdev+bounces-188633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7622FAAE02A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294051C08708
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A362288CB7;
	Wed,  7 May 2025 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osKYtV18"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8F288CB3;
	Wed,  7 May 2025 13:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623219; cv=none; b=F/61OMk0pCVB8wo5Mn7qDOiOMuLiII2B2RKEAuRmZWwr3YueFzGhT7mNFZM0biujx5mhMt4auLeJ8drw/ZkR5sjvpquCA4iEWjZSvRgiNfr3SghALGnVfywOER193Xt0ocD/2e60szjo+HU68vDqZXd73A2Z98k/hr7EpWDY0Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623219; c=relaxed/simple;
	bh=jHVEVy1GEirWdHs1IJVtpuQ6jElofdeZ5cfT2E8mzAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brWmg3xD87dqXSGvWz33Et+rIbIkp2R+PGDVHyYGEQDMjcKRnT0sgUz8npyvTHGQg+ca+Wx2kCyUEvVXsdbUZGl717UG3LFphFSJQ1OU6mDyHG5jI46M6QjYJn2Wv1BrHMEYrjm9mXsBOMwvFp/1NoQZUDNasJKdy3wn2ISfxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osKYtV18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A800C4CEE7;
	Wed,  7 May 2025 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623218;
	bh=jHVEVy1GEirWdHs1IJVtpuQ6jElofdeZ5cfT2E8mzAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=osKYtV18z2QIDgrRrGGA+bwgg2bLOo4nDe8G1LxKe8G0syYETLEOdSSdwvQ+QKt3g
	 twdu8YOW9sI8mpD2ku8uKnbSmItW1F1XWCuyadcmTKo3efwJSSNkKTGgIaktKUWhEW
	 OrMNopZBFM+d4ciPBqz/r15JHL9mo+4OUDzPz3bCQ199QNf3M+4ynb2+WDrw+rZhcm
	 TzMyCYg6D/N5/YMzPKhchkKRuFttYidqc/dAaTeERtIVOjwGYMoVdH6FUwKZjdIS/v
	 8EMJtb9GIhTTYKxS64zHZLuKAGpwlzhdmJczcgtR655D03XUYPTTBau+8zLgOVAmas
	 3wKc1IyXPAuMw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 May 2025 09:06:28 -0400
Subject: [PATCH v8 03/10] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-reftrack-dbgfs-v8-3-607717d3bb98@kernel.org>
References: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
In-Reply-To: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoG1romT94x+9s2lh2RYe9Ocfw4Nc1aLmVxrSUN
 rXoQf9aKvWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBta6AAKCRAADmhBGVaC
 Fb84D/wOjfHPc5gHAQ/7h1qVfBFNVqycI54AUE1Vf/WBTylPf9L6Pa3PpwgmyGIZTKzQZOlIjHV
 RzEUjGEaAiP4kTn0Tzu0kscqRdwr/RG6415tl8CZpxVpBHmWopfdw0zAgiIasADAf6pTal+m2nF
 Pxf6+4LLIUaNUeQatJAiKh2SXM8gwgt/IVCpfHQH9i8D9KhZFprhV0QLSAsWBbo7fY5dQ29YtRw
 wlaHQLH5VfW0bEgs65ewNBMFLa1X4KSUXwi4/1AKh4vhmXpRsfYOOa26Q55Xx70/NXbjyfmAV0G
 1ZDKeCbFjc612OVWZm4b1yhh6U92EBUjj0NIPeQswHUwoauupqt5aNDGVC6PEM/pVpOpZHVJ9J6
 PTn2pSDlPGyHOcHEUmwPayLXzBftT6QPi0eJuJtXRjVa599kD2Hynej4f/tydqEJn5UZ6BccyDm
 8sWgkTqf7Wrjxm4ubVM2+5MuyRjTND77av0/7BGcmbLwp64s9ujPLp4kn63H9ohA8kDKHf6eWvw
 F7jzh18oVONnr6vIVeZSAjbdqewC8F3tg8GC2MZMPaLgj68rRtuU1Ae49jvxqXmNZiV3YgOLSBC
 agczFCWYrJYX7dbAtRAZR2cxm7SoXDHGpPK62IberS9Y6haPUaQelCNV6vAMJyddzvMohcz/NXa
 THjbozUj2omVxRg==
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


