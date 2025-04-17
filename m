Return-Path: <netdev+bounces-183753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00D9A91D6B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5403AA4A7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58CB24A06F;
	Thu, 17 Apr 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVGF9Uc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978724A05D;
	Thu, 17 Apr 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895483; cv=none; b=p1TojUKlaPdjlS9GvjiaQRVwjuPjiZLRQL4IhBeJ2ZXaFWZRyVSKzQeYYTPaGLusYu7TggkW+pWBphbgIFgeVsg9fUJtQJ8urf02OCnghMMrvNpdcXcoPt0M1q+YIkqwsIsMrj4SVDiBJ1Ezt+hQ4RCEvwlPfMJM/2+z0fJXA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895483; c=relaxed/simple;
	bh=MA1ST7Czc/ip+INtw6W9MrUsjUJdfeZf5VeF8KgVYZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n9wV6FDC6jlRV8MSnZa2r/pfVNcBAQH8KBuyYvRfqXfM+9MkJOmbSv8ZrenH2hL3IocznXHTbziNMPzn8qAX94ndlIqU1k/JpLjxxpADZ/2QCWU/DFzOvukSnoKJTFsCCwLONO6Vj3YuvYwiLuoTt70VMN2rh/cUEdCy6NPzg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVGF9Uc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162B8C4CEE4;
	Thu, 17 Apr 2025 13:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895483;
	bh=MA1ST7Czc/ip+INtw6W9MrUsjUJdfeZf5VeF8KgVYZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YVGF9Uc4aASJ0t1wIn1n167MNZ+5CdFgaBLUVXw7vU+FLkCt/oTM/bV1TFLQkus8O
	 x0J2TGoNEK/FjwRX9DVanYldzGNgy5m0MR5GO+0AeNUiISDb553RK4V1ijUUqxIl+X
	 EzGu0at1fiLYlE8lrdrK6H1azKgICLwaurNOhnu+1lGLVmn3FklFomJOkj0u+5bpKp
	 zM7ziiTTb2UFeCxHTa5j9x6zA3IzQStyRhqbtGooie66/OPtJv+sc004qcSpV6lkOe
	 A1zdKMpH2XAMHGrBuybP+fx9IFmb47apvDv30FR4pb6kzAj3u4hDYYNliZiIr06W8o
	 GnMY9Xp687gNw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 17 Apr 2025 09:11:05 -0400
Subject: [PATCH v3 2/8] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-reftrack-dbgfs-v3-2-c3159428c8fb@kernel.org>
References: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
In-Reply-To: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=MA1ST7Czc/ip+INtw6W9MrUsjUJdfeZf5VeF8KgVYZs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAP31BOU35O+0H96hYXXcvUtYe1UwEgTSmo/zC
 5RUsvWApR+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAD99QAKCRAADmhBGVaC
 FYKDEACwadYYxoR2TNpJwAY4mqCZcG2KT9+QGvS5iXE0e8zPcKCuTJSqbOdKbUeepXWNuwVy4fp
 g4YIEYJU2IIb6ocG4XedOR1v0kAT5m6yoOi4CmVTrmyOuq4bDo5T0E5jgSgngeC9IKQ2AeMOELu
 bg7/6f372wo2C1e8SyFgjEAFvJj2PaHxXcYvUtOPp8+xm0hvVpaND8vHmsKAenSJLYIiLeBtL9O
 or+KP2BImnTbutaYjPx7hBoy9WaWMCoWydlGFyLroqfepUYfDGPdGAf7Bi7aA1N9LVrwJLViHgh
 +UjQw3yHbqmiWR0uvzT7QwZKh/NoRpwYBc+kCrVljRIWteHyyDW3s74/Mr/D9koClL+kSXnCC3g
 8sSrzIxVWDmSeRaLBOTRBBghTjnnzKTLyHt/TUjmarzapi0ywJo2adw2OfZ72XevxtINwX/672a
 7+96wvVPjcaEunXV4c21TlQnAnpFllWVK0r81E92RcB8NemkDdObadQglQG4eAjRxNSK3O8KJKc
 q6WI6LLnb2U4BDJimmlCn0sAuL04txSqmc1oLDD5ak/UTLs1JQ00irDMx6gV3ACL6CoJWsbR09+
 2NUGMK4lCzdMBJ/hSk9ZR5y2Ms0muplWNVK7igeFrwaQMoaXqiaco518dH8A6pbx7UJxCR/CkA0
 Rr1gQWsz7YMH/Vg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index de71439e12a3bab6456910986fa611dfbdd97980..a66cde325920780cfe7529ea9d827d0ee943318d 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -12,6 +12,8 @@
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
 
+static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
+
 struct ref_tracker {
 	struct list_head	head;   /* anchor into dir->list or dir->quarantine */
 	bool			dead;
@@ -273,3 +275,17 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int __init ref_tracker_debugfs_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	if (IS_ERR(ref_tracker_debug_dir))
+		pr_warn("ref_tracker: unable to create debugfs ref_tracker directory: %pe\n",
+			ref_tracker_debug_dir);
+	return 0;
+}
+late_initcall(ref_tracker_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


