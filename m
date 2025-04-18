Return-Path: <netdev+bounces-184161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44EAA9389A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C956F19E474B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893471AF0C8;
	Fri, 18 Apr 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="un2kzyb3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C761ACED2;
	Fri, 18 Apr 2025 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986279; cv=none; b=Bs+pye8KW809KP913DdR1qngTAXnOU+jxC1ShbaiuIyVR8H2X1RMacLB5ZTPpFl3OYCSSOCGiCmy5n4pymKSKkwI4oeVmpPcICpbVYNWax9LuY0akQO6/X2ifFShtQ+ZoXO4SmqKkTOGmqkBvvxT1B6zYqTA/YxP8sz0P9tKbJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986279; c=relaxed/simple;
	bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XCbEj1I1WEd0hLd7n4MHqJLE1CyQf8qhSVUpedYR9y8daeU5gNLzGuyEBehbTxoj/ZRHwgKxVEZSWgu13B+eDixPsMPSJlELlrIEHUFWS4YgNosafLRskNtje/ni+gYbEvDr0lspmEHxzECfMiXIcY3ZbTNM044H40eV9HXMCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=un2kzyb3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7E4C4CEF4;
	Fri, 18 Apr 2025 14:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986278;
	bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=un2kzyb3Jw5a/WGU7JhYO6HNh0+xXefSMmsB6B4+konGaaxnkDbToOx3+9/yADdkm
	 aw4r0D+h2mXlRkZLS0c8WQVoOHNEhvOqiXNlumo3wN4QmlVtypdlklvGkwPOuStSq0
	 Igzn8GB7WxEqsqS3bPfHRToof+E5gFwGMChY205g9LmFpcpvNiJC5+igYMzpId3DCt
	 UOj/yTi1orS84jLCJldUi9kPUyYnQ/NYe3cRlOb00cchG1QfFhhbU8vA69GbOz80Sa
	 71kJqor6t0HRnKLc4ymVgHRLUGZoUo+rJBLOmK3Yd1vXz/lQkFyzoCc/qKJda1kZh9
	 xeScjy+RFRzhQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:26 -0400
Subject: [PATCH v4 2/7] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-2-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1387; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=h02vtg+uo9MQLcJqO0oaAc8ETCkA4CEZoiZkSocwMrw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmChj0j6vUf8B5bNul8O2TxbCZBTtvMU/Q6Nx
 ZAl3cka4feJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgoQAKCRAADmhBGVaC
 FbuTEACmmnkYke/tsMFojYkHwz19RJIkrW6WhN54fGH+wClmIkUS6FR3EPYNXgzK5/cjoTWaLtt
 qNdTVhMzFBy0L2BvBMISnz7bhrWdOIc5W6cVOr+U1xdLZn/NHLcYy4q4uG8qiWqGEjivgr/qHc1
 WkiOh8VCZUH7fgDtLo5YvbRMwBu8j/BCAsGM1cqFXHSY422TgQClNOSSBGifE3oOpSRyQl5kQUr
 2r+DqCG6bY0cOnJ1Cgp20KG8rQoPCYd5SqL+cXp4E685SLjJDFDvZFmZk+Zx/j7/7yGJz6/j/a6
 iegQt398aDjriMNRR+gkIHxbi2imEhI6sTiwhJO/ByHYLiO09rd1pUzGa8RNokFe+WqkLtv1Th9
 xiH0Yr/+XaF8J1PL/mkvWTU/8h7bPJo6huT/D9iIwOr51bZXhQ441TSaPstz1OkFEEdv4bhn2xy
 KVz7rBnGj0nbSjk8GZGQOp/5Hd9yK3AzApEjmqGGEsfsldeUcCvxlMi48I1JDMOXG9+YmblFdcR
 FJhpg/Q3iQDGb4lTwo4F6icpQ2Xdua4gQomjruLLgJP/8rqR7X+YKEX3Pa1jBO7tx1HF1ZYTbVJ
 4U+G5ae78/FP2LNS6pMnol0Mwk5la+37QtAjWAF40P26PnExgvcOm6CGd5FlREGnWvq+kCOul/c
 0cxhtmw2hJWjWYw==
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


