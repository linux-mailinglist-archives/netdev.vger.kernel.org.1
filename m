Return-Path: <netdev+bounces-183752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C27AA91D64
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED0F3A94E9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1FF248863;
	Thu, 17 Apr 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdXr6BWt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF52475E8;
	Thu, 17 Apr 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895482; cv=none; b=FuyNCp1sWz40bTXCQnixKSlzoOQN49Ljn4MVLVpM+7Ro7nCe29ZfWJdI0CYptL/iWb5g1K803W6ZgYerjuShC1W8lJIxpFec+GTxsNyr7p5DLAYfZjJm6HgXhu+O6/pMh+qu0OURRSshqc6hmPTxw7nXCBzKqjDKKrSBrPgq93U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895482; c=relaxed/simple;
	bh=20xUNOV/1f6OQhBvCvol1tdYpv6GVoR6PFFok+tmwQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I19aHKRNhcVnZC51Kjr19tjTbsgfwSmusv+LoUZ8ow1IrOSqI9IDpIaBChuMnuvcx6RsyoedrjinVHcYj7Zc3MFXybX1MA6Lvlbz5D9QTeRxXPVxgMuAAKqCPRwPcSljMxrwms0tkPHZeF/R1xo+xsSkaTblhKxkiRGAqeHHvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdXr6BWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA931C4CEED;
	Thu, 17 Apr 2025 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895481;
	bh=20xUNOV/1f6OQhBvCvol1tdYpv6GVoR6PFFok+tmwQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cdXr6BWtLIcEe77YtGzv0Itty185uWz03FMj1RPPlvtjzqeha04gWsXBHdq25jkSq
	 mcOvdHtxfjA7+6/N1Cl3eirNYB8q1Zko7JyqhwTAcAWZtQGlAFPX/N7JAfKNBqoVw8
	 fmZRAkc0FpbgMz+F4/yGR89T49JvDy+SL9FIxxg02DWGf28mq6oJS1itnyE/ctxpIO
	 Z1p7P3b2IbAIP1K6XzZSAzhhG04p9lzWsgufRD0zymf1MCQ42KtTH93nbgiLCds51k
	 6wbkcUoeUUfa3Q5wwHRAfC/PyUUMxeRK7bcjD4YCYs2FC9xhaxPCkOxV3f7gkOFCSd
	 sewltmkJbK8PA==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:04 -0400
Subject: [PATCH v3 1/8] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250417-reftrack-dbgfs-v3-1-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=20xUNOV/1f6OQhBvCvol1tdYpv6GVoR6PFFok+tmwQk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP31s6P/RrZc8O04lUYQAwdOvxsYoH9JJPd4j
 GYVdgvCiRSJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99QAKCRAADmhBGVaC
 FZiSD/4tr5hbBZh+e40PK990MVzHUg4wxVI1U8HoLbCRadsb5C9pcxWotEVVxFjeSA2y8apUhew
 L8IDtx6Q/jyzYaHF0NnaryScmxNsTitIih3ptoXozVGpms/wVGo2fHQ3wT0jTHCNkWtkvKCa0V9
 kVGmpPMhHmI4QFzIHdzTcv435jt+KzjJ9znhpFRlRL5hHINLQmbJuK93IZJkpBGcEW/djPtts3j
 PZnvuS6eGrMhFDqzLVKmbn7Ih0ugs28UNfZgnljHr2U7S1ELL7/rdEWJyOBrKFChjmrixIQEYSd
 6jKUsmRbMBLiET7uDXZF3tJFkQoqyfn5UqfBUezpfchTJrPexvLpE+9YaRHRxSqmSA8SJ5qqG2b
 O3Vz3NH6cM5m1cTalH0lkNfFjI7Rq2W6pfP+aZKvW1X6hhdQvjIzw6mDg4L03S3/SK+Ju+hdA29
 /YbI3sIlgATbzUBBTv+7HQ+TF2X5lt97H/c0EVAh9DUIV3Ih1/xFWHPbe0ujEkdql2KdhVYV40u
 sSgtMcQ4sJnpa6BtW9tk0j7jcjbwh75BXh/QjnZALOa7vo0806i4/DjTADd+f7BwW9SNHk+7+jp
 +ZCMqBqCLJPvSUz4KCG7es1/InvwfJSIBpH/NveIdUAdPKCqkVupCueqck3rX3MLugXHksyVLED
 cKO12cEQnlUJC+g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Thomas Weißschuh points out [1], it is now preferable to use %p
instead of hashed pointers with printk(), since raw pointers should no
longer be leaked into the kernel log. Change the ref_tracker
infrastructure to use %p instead of %pK in its formats.

[1]: https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79361763abe5a3a98484a3ee591ff2..de71439e12a3bab6456910986fa611dfbdd97980 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -96,7 +96,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
-		pr_ostream(s, "%s@%pK: couldn't get stats, error %pe\n",
+		pr_ostream(s, "%s@%p: couldn't get stats, error %pe\n",
 			   dir->name, dir, stats);
 		return;
 	}
@@ -107,13 +107,13 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		stack = stats->stacks[i].stack_handle;
 		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
 			sbuf[0] = 0;
-		pr_ostream(s, "%s@%pK has %d/%d users at\n%s\n", dir->name, dir,
+		pr_ostream(s, "%s@%p has %d/%d users at\n%s\n", dir->name, dir,
 			   stats->stacks[i].count, stats->total, sbuf);
 		skipped -= stats->stacks[i].count;
 	}
 
 	if (skipped)
-		pr_ostream(s, "%s@%pK skipped reports about %d/%d users.\n",
+		pr_ostream(s, "%s@%p skipped reports about %d/%d users.\n",
 			   dir->name, dir, skipped, stats->total);
 
 	kfree(sbuf);

-- 
2.49.0


