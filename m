Return-Path: <netdev+bounces-193984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C343AC6BD8
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2133189F408
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D6289E00;
	Wed, 28 May 2025 14:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbjB/Ymh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61928983C;
	Wed, 28 May 2025 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442893; cv=none; b=P3I0NwyDghPMCojm3VJBzgTJQhPxd4OK+3HmcW0POywSKM+uHtPi1s7OgXzXzXGhxFvdPAC1Pt/633MVPtlB+jHIiT0yMWyIo5aMLOgPIJ44K3En69RwM++KLnj+4Ex/U9blNIozgVV06aJwYkiwM+PqLh/cfqB2CbnSbvIBm0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442893; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKcDHtpvVYnhNXvot1Z2KuOaIDX/353ESAENgfpUGjkM5adq+Vl/Lp1h7V/cDaK+MBOEgqzZXSqXc6Rr88xhaRdGWSD7RWQyPkfF5GRU9t8A3T3KLkeJewlrfCc3Vci59xpQ3Shgtak3JEZUdcDCFnidKQUIcO2nq0+THPS7UA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbjB/Ymh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72D2C4CEF2;
	Wed, 28 May 2025 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442892;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KbjB/YmhiCt6CS/s2sK7gorqgj0pgctI/gklL+W77Nt7oqgNFRj311zEg0ZZu3Day
	 j0yF03Nsy4SnoUuPkglrrnUcIey9LO02w7vLxP7USdjT7SFiNU0B0fT8dNWiqTE+40
	 2qIsr8LpWSbbZzgI1tUECZyyy6KRGTODRZVrYMKEqOa7jLSm8R6rPzlZ/vIfRQYsSb
	 +WzWSMQkXQl7sem+IkQXhXZIHVDHBWp4ckbDJ2kzQe8rAsNQaCsG2gpLi5K9QtHsdh
	 5TZd5ThwyBvkWsFDZe9RHQe9GlnnJxgy9FQz8pCoRb8eutSFIX/65jVw2pjVdmuheF
	 TX8Mzn/RpDDpA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:34 -0400
Subject: [PATCH v11 02/10] ref_tracker: don't use %pK in pr_ostream()
 output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250528-reftrack-dbgfs-v11-2-94ae0b165841@kernel.org>
References: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
In-Reply-To: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8E+Fg7R+6kQ+LbHF70JI1PJ65oWGl4hND0Z
 u2iXxq+6vqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBAAKCRAADmhBGVaC
 FSRWEACXlmsKIOth5AjxZbIwAfkmicqVRAiisExNrivGXUhDCG+uXWcuRNuR5/+c/7HF2Hp1OY8
 dDdVPC0nzT4Ri8kDMvwBmobP60bRP4WtQkouO9kNbYEiJ3P6s7sBTv45/MEjSkcK8I0I+oPEABR
 NQaAL89bznuKcpInKUDP+UGBBtUfH8Lgli4pTi9TTlkd8iKSXW7APJpiuiI/rqTbBIOxnwo8Q7r
 vNis4lkbwuVhNmRpYbEgybI1WY/J1ZHmNX+pJ2aC0q9XaoVOBl5xuvahfa977noGK15DXOZNTm1
 3Khy1vZXABLDfdxB8zOKucJn2me+wV3sEDG1J1St2D15bfxvKE4WqURr8uOdypBXgXuS5po/l6O
 FXpTa0IOEM9jzoaLyy0mw+rPR4hlTaYuHuuphOgJsUJQs6Rk1qYYq/8vLHaKiLL734xv+u4IQ/i
 hvcpUy/F1sbja6qNLhTYuEisY9M2oG4zD/+085cDVx1n/qlKUAnfEGvyj4Z0VQKBwfY8EqeLBpA
 U5oXt4Cc+yJsUZvp+Lrkb6cv1MVAgitUleAvzktux4WvNUu/nly/7sjzh7bfeLdq1nTNrvaFwDw
 j+sCn4Ehcm3txItPnY29/nLdvMATAZQQhE5/xqRkpQ9wclk8gj9fCcwzdsg4Y28DEaujNWnLeZp
 q4BTqGF7DVXoqEQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Thomas Weißschuh points out [1], it is now preferable to use %p
instead of hashed pointers with printk(), since raw pointers should no
longer be leaked into the kernel log. Change the ref_tracker
infrastructure to use %p instead of %pK in its formats.

[1]: https://lore.kernel.org/netdev/20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de/

Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
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


