Return-Path: <netdev+bounces-188635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D33EDAAE031
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AF224C88E1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57C28981F;
	Wed,  7 May 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPWjIqBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E918F28981C;
	Wed,  7 May 2025 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623223; cv=none; b=nNo7+6hgHzjZze+FAEPpfRnuHFqVOQ9RaWcE6fzAcOkAF0zc6BMOq7CIK7h7gADDfd40yKfvTYa9L9SL1SLB5uY/IKjIV8qn7niUgnBKnFu3Ml9jdMmjayDIjNspWyrEC2ZNRbmlzb4DuIzPe59KcXjqVOzdJOqwDoD/Eb2AHP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623223; c=relaxed/simple;
	bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xwx9QYdC+Zkh8CRw25G2iBq4m6B++vOuBedVty0VtDYxw6LTSuKUOohB9ISQQGY0hHw2oSJT97qFtsmp0ocx0LzbiF7Rhw4x+qiPlw1/bhIzgQg7t9RGfah8uYicXw8QCgonHhYMEKL08yZRaFww7BpQNTQR5EjqJFvqc0usaFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPWjIqBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8A9C4CEE7;
	Wed,  7 May 2025 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623222;
	bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPWjIqBgm18COPGkhkvnoNP5OQEcqxFmHHACaXFLibDTmOQEp7+a9G1roDU2KHJIz
	 UK7EVbtG4J3FURABIQkc+LGJ2cQivI3ZimLvTIfzebXbLhqmm3Z+7T73tBTmHJahM1
	 rvIztaMyh/+gaTlAaPuwKM8eJee4smFyFCmuas8nupgzscmk8k+cSYxad2Ca90Q6U9
	 +N4HTgzrF09EQ31r3/+sAhVQ31Fix1c9nJmktU7eyU7OcUrNiPdM+S+KgQ3GPCmL0k
	 A++/LsizCt4Js+hpXqfHkvnXBJjRZkMiEMqJc817m94gvQYv3ZT3k+NELYktq3QWZg
	 F4umwDXeM/wWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 May 2025 09:06:30 -0400
Subject: [PATCH v8 05/10] ref_tracker: allow pr_ostream() to print directly
 to a seq_file
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-reftrack-dbgfs-v8-5-607717d3bb98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sWMiF3Jp8psrx0vXllDtK7/+QK0kGDwaFLz+zCQWWb4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoG1rp5usXP5XgJKw9T/gfib/bf2BnPOewnHgke
 lh+AS/uB1aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBta6QAKCRAADmhBGVaC
 Fe/DD/49hv4ZtdTkKa+MGD8AR7sJ7Fxu1qo9LkUDBvq3dgnrZxHJSsJkvGim12PnHyDTDHy6qOo
 PMJtfo+/EWuSLrunWRyAh77cShp6+LMnhCIUhBxk5FbnHQMlJt360cqlVqJtdrjCciW1uLiY9x1
 hZvXEf1J3/HC9G3NX6NqitZa6DbDUKn/svEzFe3kTYn7xwquSWMwRMXKiL8kNbHxZp1V6UWU5NP
 UurWuyhoNX/7mQvL3CQpEKDqdyVkq0/jq3h3WaLdrtBSq91PUloxBEbu36U4pBPibLAjp8DZ3MF
 v5cRXBEdNXQhO+RPt671I+peCJG5Qv/vQP64+dNkvGSvWAZo4xhH4mvlbxeaquhP5om4Zu7yND8
 yr+5YNDgB9G3KI7+gmgXkRZdZJc8movOpx+YDvgUPnZ5HFfn1/UxgN9V1EQgAKGZa/A/EELs3uw
 UKMpdJTMe9BdErAjheLJtXIX6GBM6ehIYYlUXjzHNb+X46Hg2GGzHTwVhRUpKvFQOr7ltDC3N05
 ItJQHy9c4H094ZwYvp7jjXbui4UKhc7yL9TQiG97aMNnX3OwJrqwXV48XRwgMBoULiJgovyIbb6
 btjvZ+pfC/dOZo/KakQ3Yaz2hJVmVd6aDhloqJO8b2mjguGAMswfPJyRfRrvU2hIcFVQFJAB26m
 +AYJTz6OiRKzXrg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Allow pr_ostream to also output directly to a seq_file without an
intermediate buffer. The first caller of +ref_tracker_dir_seq_print()
will come in a later patch, so mark that __maybe_unused for now. That
designation will be removed once it is used.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 607718d00ffa74bd6d9abf97e913abcfd56dd1c8..6e85e7eb347d86775ba38a72dad7159f9ac41ed9 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
 #include <linux/stackdepot.h>
+#include <linux/seq_file.h>
 
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
@@ -66,6 +67,7 @@ struct ostream {
 	void __ostream_printf (*func)(struct ostream *stream, char *fmt, ...);
 	char *prefix;
 	char *buf;
+	struct seq_file *seq;
 	int size, used;
 };
 
@@ -300,6 +302,30 @@ EXPORT_SYMBOL_GPL(ref_tracker_free);
 
 static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
 
+static void __ostream_printf pr_ostream_seq(struct ostream *stream, char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	seq_vprintf(stream->seq, fmt, args);
+	va_end(args);
+}
+
+static __maybe_unused int
+ref_tracker_dir_seq_print(struct ref_tracker_dir *dir, struct seq_file *seq)
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


