Return-Path: <netdev+bounces-186530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11DDA9F875
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CD31A80330
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395EC2951DF;
	Mon, 28 Apr 2025 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV1eg0Uq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8429293A;
	Mon, 28 Apr 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864825; cv=none; b=IJv8Ge4KcVRRZW6qIJqzvp2qllMNneaIMV2JQQEZ+/uFVj5gLevtcw7LSwtFRoV4xUkNYNGJmXwBmu58zyYvg4sQQDDIJAzBH6mb7JkSwZfYggfkqosMckiNKghQd/W7SuySjbaOhH6v1TEYpRllZS6cLnzF6zPPc/iU+M2bS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864825; c=relaxed/simple;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWPtHWYCxDe8nsibMp5XJm0uZlgjzckR5HKPaHlkgb/XBBbBPgumPFZ9CArIlfTZRN+ZakXOVyIBNtrhmvxLaM6SitvPwjMduWvPp4HSoHaOvdERIdiyqSYS6SEwAnZHir9pUS7KTgf61mt20MIWLLXm552KIapStmnpnOvKOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV1eg0Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3793C4CEF0;
	Mon, 28 Apr 2025 18:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864824;
	bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hV1eg0Uq/DZQX8A0KlSx+gVYNKjrpskt86+XZbdmPc7E83wxD4EUaVvD2mOfRGGNN
	 VMqTSA53kRBBPKbR+UqysP4R3IjqW0DqUYvzdjIZBzo7/Xd1b96uWc2iAPcwRN3AF4
	 kqnJ3t8qcmESHR0ZuckaeCKN4jOrFo/T/Kba4Cibtm7s9ncBNTjfv+6eypkdFSsu95
	 OdQXwygkOy6w+hzJ5M4IlNjhM/sRBHgPBcK6w6kVjSpMz9shrYaPZVSreEL+qyLsUO
	 rELZ1Uz8+HHE0L4X5RQ1SeE2lPLMQ4dWKq9khflInEAL7cXT9eY0oQYs3sB/J6exUI
	 B3xEQlihqY9RA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 11:26:24 -0700
Subject: [PATCH v5 01/10] ref_tracker: don't use %pK in pr_ostream() output
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-reftrack-dbgfs-v5-1-1cbbdf2038bd@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=qdjjg9250uAChp/B6CMoiJw5KiM08dmL8XUQ0eA5f48=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD8h02NwYy4QXxJrP67+BDY0VaVkg4r1pRn5qS
 ThHlMbXUlmJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/IdAAKCRAADmhBGVaC
 FWLKD/9kwVxWvoaZkkWJH23eYL0p1SJDJCllNlPCiwOjfKYfWGGVvcN0dCzywhl8diyAwhsgEt4
 81UPbDdDwoMKs+shn2AoycZZqRrXAFqqi2MpuX6orpIsoKXJzHe0p+ABKW7eJ9wKVPqsiMUCxCD
 /zL/x6SZTgtGokEdHsec9vkmhRmbRFtHKb0FSZXMbjVkg7xgH6SWi6KVZxl0ewhbsjKd/uHx2Eq
 r4IhWfVcHtTS4pSXLDQB/kHRo26twmEVDHw5B86+bBjF9M8fr2fiLvgxAmp4em6OoeUsxFPaqSo
 6wMUeiY7ArzcUHiLc04LYIP4BdFi7v17GdW21Wd9I/Q7/Pn3Ha5nd3DXDip4zK68lM4A6Vd6OA5
 VNOinpxLz6BcuYQsKV5n5ewHoFoiDCTspmeOLTYI5Pq8aTVZzvgF4l7JzSYedQ6TxWP0q4nephy
 56jlt9AFPFkrNS+81MODB1rjFhuZTj+QK3Lb+RbgDDq6D2e6DGEAcUdtHgMFQwQ8RLDRbRcnvcC
 NA/VtukaNKktRpEZK+iVvZEEW9JLzEMvA1X4WVZQ1D+I9Q2o40CPXb2uTa862pGx0w9VUsBvtOj
 Skk92/jT1GfDAfRZGr+9uHN2gg4mJFxSBBBgWPpLlTcTHI00YCeQfkd2TG9tSZrypSYrDQkEewy
 WSZ6/w+jw7nmTeA==
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


