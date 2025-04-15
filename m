Return-Path: <netdev+bounces-182960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60EA8A733
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9963E3BF91B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E4236A8E;
	Tue, 15 Apr 2025 18:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrJSEu4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D51236A6B;
	Tue, 15 Apr 2025 18:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743024; cv=none; b=fhdXDAVS8wlzuYzHmVGsDlaBQOqlBAAHItppAX55dtnjOtcNta95cv/iIn5oR/7Xo/ELNOwcFX+1brfWHUtzMPFlBv059SBF70Z8Wlu+pLKzpXOExslnuJBz1N6o4k8wqlnBs1G8lVGZcB0QsqSTMSQ9moGkWV8ljTfU6eIinkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743024; c=relaxed/simple;
	bh=hJcBuOT2Wi8dUrGdHbQ64LKjsIpqJcmHANQQSzrErKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHJ1gKGbvwF4MtdbK654j4IWCK1xOWheIEVeC5dxQ+LlUMMfx6+PJJ6CZiz/kjrE+1SaWATfNjoNgd2Y0hThZfv936ZN87W/Mn3vxCgZHIl/yUDEoY9v7X8YzvJPN1nPG1uqq6e53BV/Q1L1NK3qaZCI2xyFr2C3RUEgYYPKDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrJSEu4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D36AC4CEE9;
	Tue, 15 Apr 2025 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743023;
	bh=hJcBuOT2Wi8dUrGdHbQ64LKjsIpqJcmHANQQSzrErKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DrJSEu4Suk92cOjkiHFZaWFC0vdz3EaU1Vuf+OpRPZCB9ZwFrH/8BYJEF1adD4xBm
	 +dXwAk/waT6AHk+LmBV0pJvdPViG4Jj1ZrEExxpLJsEdEG1hhEqzmzCRE9yGOj08+C
	 BI2bR4UxrSdKpfFw6BxT3/+Fpr/VzBui1u3ZGlVEW242DCfUTSlHZks5BHMFF4uU+z
	 awfzQGG/IAhGbnqBft0mgUYXasymuLrd6zAxa0cJN+Zljha9FHAgBIFlKf/7oqGoPS
	 P+hq/SHfxedaoA7gy+MUOeSfI7cYBrR8USVl3PvuWjd4Hc0RVq2ZoXNm5EpoQHh7tG
	 PnLDi9n6kEfzg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:41 -0400
Subject: [PATCH v2 3/8] ref_tracker: have callers pass output function to
 pr_ostream()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-3-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qppLr5POxEIzZM1ulisGL2CeHNL6Uh7JNYnn
 pXH0h9jqtOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaQAKCRAADmhBGVaC
 FcU+D/9uY5yFVPWODlskE08HiQ8RuQ1lnEQ/YOmdl9zHcoXdIdv83EwdWpC86Xus0pvsJI5Z8vh
 IpZmB/xqBMtITbM9TJ8rNznjBqS7L1TmzmdzOR2bCamVqHhXj7eyvRGpl7uYG27Iw0bDwgwrtrS
 xlOm9rdYbSibNblRt8kAl5Ag0cu7E2X6+TGcbAdykIzG019dch2gQcInPyjxElz8mg5oo7pkOe7
 +FS4QMSGoQiFwRsR1fCjdiPKmAQODY4cyUbVzhPf7sd54KuqoI8uwbJER8ClRrtz+/thgcYo6wD
 Kg6oHapy8OJZtVopejS6YSlJ4dnOT8qHJDaHpEwGmKdf4hC20ucB/fBdjL8QcpTocIFkC8pcsyJ
 FGskmJyKyFS3cjPAiTP9hKnDAloyUbUUbQ7brAE2p9pMjpLRDkHbCn5JcETmRxW2ePTaOgvohmm
 BQbHMg9jKoLYIskNZo0F9UFdMpTu3e0mamDk/Xy+XaRyH/j/11i1y93X4nOLAU4SessYDo65t8V
 K63QCzKBOiqAWvbnjYKDIyM1uB6lO2Rz+j0MzLo/zyygCptfeTnywc+ADsUBJfQ2/5fyiCQ76Ft
 hM5fRvDTTAjPzKqGadPwIKUHkjpjJrhjIS8v3d265RMTeQ9ehi/qQmZo0qJ5mqOVLLgdQ7CWqO1
 dBPVKjIMyTetYiw==
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


