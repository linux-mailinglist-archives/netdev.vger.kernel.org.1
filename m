Return-Path: <netdev+bounces-196165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51629AD3C10
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DB8F17BD72
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A28236421;
	Tue, 10 Jun 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRVyUSQi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1311922E3FF;
	Tue, 10 Jun 2025 14:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567588; cv=none; b=o3BomRl7ZGC2Q0ElakBgLV9RfbTT/npNTcO+FfD0vF4614SjQPgD+pNA01PhqQ15UYjrHt4r6t2TWSkik49dAXGZEDSERWhDTp+cF3rANl0aSFEKltY7OKXUc1ku+fENJJ0Ec3Gmq5CFW8O65GI4fnQslMLHs/19kpPEIVbzEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567588; c=relaxed/simple;
	bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=shS+voSAY3QOOCleZXh6Xdqe3i3XJGAuwDXX43Sh9gNnscHmvzMrKdGWt/Ow4h7RxNMC2pVMKIoHmabB3YWWGaBrJMe7GYlCGC//WN8SUugTIdwFspuBzIjK3XPFTi4ZjWYDJG6ADn23vHZj3zAHBMt8zAlEBw+nGgyQdUL+Xrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRVyUSQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED83C4CEF3;
	Tue, 10 Jun 2025 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749567587;
	bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jRVyUSQi5NSA/8G51s+61XcdJIiDrwXTSB5z9QhQftdni3LWaPEYBOAb87eSGyLm/
	 zFuXvaJ7Qx6GuvC1jjYNIKV7/G/FqLxZqOAyqr6diaqRU5V7ou2yxF1sVeo88CmhgQ
	 9yS4xnxq+KWDRap4WpGfmMRJk/NWj7YMrHNsy0iX9Mm8VdQd4rdB9qJkA11n0HLxf0
	 zfXgXcZIJzWfE/JpW+GkRqyWOXPuo/MjNQA42S2GwdMubVaYboz0sIhB7APoj+nCaT
	 yeM6QIAWOU/MRoEj9f+2kvtZ4Q4ecqayPQ74Wn1EHiIXXlqLkT+U5jFDT+GaljGWmV
	 R3Vtf5pFNdiBA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Jun 2025 10:59:22 -0400
Subject: [PATCH v14 2/9] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-reftrack-dbgfs-v14-2-efb532861428@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Cf9EAXyNK0VxD7speigkvYTyuNOgS7Co5M1zyvhQst0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoSEhb0Bhnkc9PAOi30w9auebrSUuXyd5qHc8q0
 c2ofUayTW6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaEhIWwAKCRAADmhBGVaC
 FY9mD/92bM8abh1wNsArTm5QPT2mp6uHBRpU3d3q0Wqx5NX2sBpp4i976a2dlVesF4LwlD+NHTV
 UkAf43I1gMudrDtCUFEXfF7WqkA8WqvmE46VjC0efWLpF8wkHwiT7J3Xg6c9nQE2OyKd4xFnaU2
 blAVVty1u9bJY8hDOs2WjVWzMLIqE2h793JS1uORilNVdc4BCMzHvV/+919AqURdh3vWH22hAfx
 IZM03cJlqnFvR9HC4re6RoR9k7oUSzOZI+ZoqRMc01k8JMfFCQQHvfRi+beVOfH0gZLUNPE4zit
 osn3+oqXWDI6zpGM/0fd1NiS7Y4/fdbr/vZwg+N6ymtkZfj8uaTIrSqebUSM5yIz7is6Ji6t1Qu
 Bnz6j1i83JTu+0IMzCdIOMHwwov/oVJd5pnJLtP7vSQkQGh8TlXyL+epG1b9Tzr+U0z9aMVyjJX
 vIFlgl3i4z8J6yi8oosD1kUsB9qPeVBiJL6t2EejGvlBFUSaL9/r5y2rbOtgIw+KPuCX282eCF9
 skkGXCf36tra4DYscKf7OYWgHw6DP9hNV6jRzbgW1arSgPefy9fvLdZ1mG2cxWPJWyQXIh3Zt1k
 Mlh2O70jeMKs7KUN8Id2IeHU2BVd4yD0f7b/TubZKMoAt4XPhSALWOX4d25Hsst1BtNaZZdtWIt
 zf7fAEPcO0h1feg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/ref_tracker.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index de71439e12a3bab6456910986fa611dfbdd97980..d374e5273e1497cac0d70c02c282baa2c3ab63fe 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -273,3 +273,16 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static struct dentry *ref_tracker_debug_dir = (struct dentry *)-ENOENT;
+
+static int __init ref_tracker_debugfs_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	return 0;
+}
+late_initcall(ref_tracker_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


