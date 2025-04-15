Return-Path: <netdev+bounces-182958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE76FA8A72C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F3D7AE306
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57F8233D89;
	Tue, 15 Apr 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oX++q8Ri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C4233738;
	Tue, 15 Apr 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743021; cv=none; b=NwTfqcE0eKPH41R9it3twAPZmNsN231SBht8Ez4NxioCBw6suqe5hglmqVggkfCYVzXH60FNBDpZrAqiqw5fsdihe0ZRmf+wVGd7sJJ/KIenX//qKhEATcI3LtpLgVc9jAO4uAEJOigir4oIpMO8sozqs0EuU5as9cCg8N2XMg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743021; c=relaxed/simple;
	bh=20xUNOV/1f6OQhBvCvol1tdYpv6GVoR6PFFok+tmwQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RotiYjgnfQinUOzpeSwJFE+/k9wogmNghs2yKO29r7ZFxEM7PM5VuZmmCLVkvZlQwZyYuzYKNZ+9Hs7GHWExIHEmLnNhzalVLcWTMWFaaUdRwyIQX3TYZid6G0iWEx3FPQYZWtDYTC39KcYcVhhx76/ylyNy3fofDXpEz0cry6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oX++q8Ri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3709C4CEEF;
	Tue, 15 Apr 2025 18:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743021;
	bh=20xUNOV/1f6OQhBvCvol1tdYpv6GVoR6PFFok+tmwQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oX++q8Ri3hoHtUkjKnckJEwjxtTLDpLSKKGd5hZx56pf3sDPRhzkaroJkQ9pnB+/Q
	 f0XbrsmGJprHZJyA0PR5I7YtMZPcnG+0FKMFwzFYIVpqtEHmRqainpaWz5J9S2dCm+
	 5EbKDTVy5cQftQj3iFHBjC3UNeRTuKFRS3SQoOZn/yrWbrwIewglj0JmTN/S2BfLZ9
	 9w6BY1BV0ESjqG0CmHu91KrpAvvIKWXEXEjh+xoZb9fvm72+6tqNDrFuA/s1K1EyhK
	 ANc19wSaf4fCt5EXPZ8OKFlWloQd2lVW1nIcKYCiMFtgLmIbu6FY/CK1ZMw6mC8056
	 39+EaGYVCLCBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:39 -0400
Subject: [PATCH v2 1/8] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-reftrack-dbgfs-v2-1-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qpo3GV0Y0O2aJiaOU5Zt7LC+YOSB76CFxCK0
 5ZyAe9z6/KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaAAKCRAADmhBGVaC
 FR2fD/9ErPUaK0rwWSLjH2ZKkYNp7JT7h6pCiXgWzh6zhltZu6J7VRSEvQ0u1oHbx7B9zhHk+se
 WKhYSkMiLn8EnuAsIYPXjmUfofZ9Z8FntcBFWqrMQC0wSGXGAbqHDMD/A+CZaVY3Jo04f8JoyW9
 xDt68felHKzGZjpVxc1MqIozZbMBytt9z12rg3yR1+iNYMsT9/erfekBc3n3ZNlgH6af2s9u20n
 x8ducRmnYAqJs51oCKFI9CIVpGFy8bRVGvH3Yq71KZoW3FIkvTDQQcexMfIm1YZ+o2vbOGgOfav
 ogQ5hZE2aSZ82z0eiJuRkmYkzelBhDNTF/cPJCerYcdCVe4DQn22D36tot7/UO8KdOJWbUC7kGq
 ABkNqtCa9tRwb62jnfH8gBsHIZLZZJvG+JBakB7a6Q41QT0UPtMpyOViaYIF/yyAOaaLckJeyMq
 97iSXpuKThCQ6bQg2C8UPezwfyL4q4GF0h6xWfExCOnE8bbGe3vUdxrb/p3fclYXxq9YwSv0egY
 1SAKWoDqaou881HEGGT7P5dEhDB0Zax6r/5Kfo1O/642ud1u5vJFSYULOnRgU59ZmvWnywCeGcb
 U+D4UKWfqQQIiSVSPEY/cIVTGDa5/0RSd+He7VSuUmZvWuoPQ0ljjNUHNMUqjd826A5Wfq5F4u1
 PCAUh2CPzRc7VVQ==
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


