Return-Path: <netdev+bounces-187792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B0AA9AB7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72307189EBF7
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDF26E161;
	Mon,  5 May 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZMZfYL0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492F26E146;
	Mon,  5 May 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466412; cv=none; b=h1o6FWD0zLdkBiQXYVhKuaqgSgc77EnHonMjmtSfcny1v4lLzaowN03P3wGO/CRhGZlp2Pg7cfMzGsODZrHTOsHD4QTRL+jq1hwvkW3uf/fye8iNA83lVIw8DLWnvNnLyCa2HxdoT9VIVMt+lPLHs+OXirYsh/IHf8fOg5rcymA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466412; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+/HaEGYkhOw+OQTHrq01u4TDrKpwAy/di736IpwqYwFqeb33VnT6GayL4NxvVFtwmBkekGefK0ANiUCd08RVsd3F8TVh8RA9Iv7XafUXo2C3ItoY8gu3PP+amqlwUcmwl6yV2qSaiBRtLDPI6ONQkNBp9Yj7gc81u+/XwUQwR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZMZfYL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791C8C4CEF3;
	Mon,  5 May 2025 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466411;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZZMZfYL0wg3jKpcHxGkRonNwBweQMAfERjDC08g++ALJOaVgi9sNb43/6F4hnKOuQ
	 WZ8W0iI0f+qyUKBTHraI8gKWCyXxA6jlOF4YEZt+AuiWtKGQLqYKvT/0agjBNjRtHV
	 FO3KLKroOYedv5L+iLWbOHEsJaoz9BXL59s1YqDc1yolQ5pbleBDHvrZMcqugwFIZF
	 z8gSzK8w1nfauiv1dxr9uW30rt1H8buV2diGxLJS/mrZb4DLAIzLyA98+YMPwDad3T
	 m8LwlF6MEi756piFCw+tEGZFRDJX66zCN+pRGGqKsZRN+hMXVLWybmXukpqBEmVJKn
	 boZQm7F/CclAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 05 May 2025 13:33:15 -0400
Subject: [PATCH v7 01/10] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250505-reftrack-dbgfs-v7-1-f78c5d97bcca@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoGPZlA649+0ym6Pjl0o9ekDaT+BzlE7le9pLYh
 wydcbe0okGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBj2ZQAKCRAADmhBGVaC
 FdrnD/9pIPVYXvlrXdIoQMCxtxeUFjNCIpZhdiPu/DomgQZ8WFpITeRxommwq8UbYqqzGXNM0e1
 0Rr99g2iDjQ6zfXvIvUScZtdNfbhFp3wjRFF+y/V64gMOOQu03lor+W3XUfgyyaOpfA2rz7/fLP
 68VekzluRXfptoUgSIX1yUaC5JTjfyIGswyoDs6hHq1D3wDQqV5vMFDnrKNEtFga0IOc8CHohL0
 /nsWvn+xsUv+2NJLkzcmIhhyEFTn2Qxra9JCdheoADiVOiZWMIZvSgTHZ0vx0MLGD1zPBq/u5fc
 Ou33WNh/mgeorkpeYIrZjUbyMmdj97WW3JY+gFZIrkwL1TuJBXBn11LUUR+uTIzw6nCAUvcb8gA
 xD7xYwBXq0gHFSOHF7S6QH8EOPtoSiOzYSrAtBTuwL5cabNMkevN/56AoCxEgkgPQyJAibMYWk/
 slW4CGwFqYwoKoj8sPCZqrZI9pPMjVS8B/7UY3BOEb2YQu2mqppZ/h2bassaK0dJv3XGxviJ1Gs
 Kylk3isk//1fTw/TGSaJw18f3hmC1IeqsQWoMTbOXWFLl62zy1/jq0TBnS7H3euop3wUKbpjc+I
 t+SeFrSWQoTsNeJGtbq3G7Qsd6GUHJmLlcFpVqT9w5R74Isp4M6tPtB1qK3gGv1TrlR0T7YptU8
 dDDhekYX6+5r8lw==
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


