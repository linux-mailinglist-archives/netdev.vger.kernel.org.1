Return-Path: <netdev+bounces-187105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D4AA4FCC
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F721897A76
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7125E473;
	Wed, 30 Apr 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGPgPdJx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CA25DCFD;
	Wed, 30 Apr 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025625; cv=none; b=hEgogf7MlF5L1w3p+0/d7gMNYLtlQm8wQt5nLR2aXtyJHv3rRp+sf8OAznHXARdIm3MznZVAjRX5DkGBVvieUwsZhaTZUaGu4lcpuOyUjb/UnECqRCT5SW1xcZqRR6m9WX0Tf2IXhz5wohv0YrsG1Tk9wVXoFwyIVyOxixQksIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025625; c=relaxed/simple;
	bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pXHQEt6pVu8S4ABqyT+FX2mXETbZvKX9k37zm3WDzlqBn4gcBPLwU7CKF7iDsTQDH0U0jbYuglz+5ehrWijy9fzhzQTMJujn25jDouEjMVb0mpPQV0Edx+8RkDuUQxdEgmQe73dwNYaH/JOXi9su6zLWZdk7BvpV8f+rllzCFBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGPgPdJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E924BC4CEF0;
	Wed, 30 Apr 2025 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746025624;
	bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jGPgPdJx6HlGTYWP06HKysNQ/Hx6S9M5qGOui5IiQyzX8JuYB0i0QZ0M1rigxrMvj
	 3z7Lx6N7/+aLRPQcXTUSyHk15Ow51rz8ajeBMPUSBCExcf6LcnBB6N1Bn9RhMHGDiM
	 tY+n5y7x7CmFRKsUsGLqNckcxqf6eDgGXfNzk+jmTOtkz4xcvqsYEHL3tmIKNvundr
	 OJ3j2hcAWFJ2ZUQxN0CVpiijSo1zO5yJqrsoC1MkNd5Fl4PxThKmh/70k6WfRUW8c+
	 hsafL4Vqk+EXlrn4pRzlTVJxCYM91R3YeI56mD2VQe13zssMqTAGqWaM2OPhw0HTFO
	 rhHw0yfNcQojQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:48 -0700
Subject: [PATCH v6 02/10] ref_tracker: add a top level debugfs directory
 for ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-reftrack-dbgfs-v6-2-867c29aff03a@kernel.org>
References: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
In-Reply-To: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoEjyTZic4mSRdvadMvmskl/R23v/69+pdAJIj8
 mP7Ppdt3HGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBI8kwAKCRAADmhBGVaC
 FdiEEACpnvN0dEI1q2tZxnGw8SjA7iZBndKYTOyvozPDnH9qZ5nJms0ukmkEKIc4/ZBjAI+gvbW
 ZS4eP3JRLOH2cZ2dy+OBMZrnqaogzEN80E6RhJwiARyzUjoBZJi0qkH7Z/uuU2zrK0km9OxUHgq
 Ferw1BFBjyTWDAj2wswW4oNCc/hhehV+H36x60OnzA9BnYnYbcBIShS6uPiG6wi6iRohQlcf39B
 jc5G+iOeKSddLmSo2zUwnxhP4T9WEfbZIyHV3dZjS2TxkC9KsA78OuV/19riDeGEjA62Yc/dOAM
 DcEBdOcZFa/OVh3gQbnSXlNg8C1N8COP5TUCssDVXYbVv5AlTWpjcJVOvYH2uZrCFBiESotZcMZ
 /anzSL0s6/7r6txzNdQmGDlac24G9x8TeBVRJ7V4NznUo9gQT/9zYCH86FBd5CWWURllA61wKw7
 WjHg13Af+lFq3bSN/dLFWeqxUKu6UJdZTagO3UFKQzoznKC/yBP/zfltjqnzucRswWup/LSoImV
 Fh9wMYLYHsLjoiMMYxN+jWRYXspwFuGJMgkmZw02ZVRlmeVsljECSP8+88LpUUO4frTuO++Jezl
 gbW1z/CgrWYfiIT41Ez4/rXzNWZ3EJOkFTLG8Ni47qKcydNk9xPc156skr6apUn5x901pNT/Lkf
 Id7YhaTSJm3HixQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


