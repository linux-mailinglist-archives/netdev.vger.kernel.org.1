Return-Path: <netdev+bounces-180244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF723A80CB6
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF873462E03
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234C188CDB;
	Tue,  8 Apr 2025 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bY/vcnvP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098D1185B67;
	Tue,  8 Apr 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119414; cv=none; b=NohDnOCoDYkG3OiWPd1I03wZDcyBJ1dLCe1OtG7DxnbZoANuSs7i/5un5klTKRG551SiN9WWuD5E03EBWteyfnROcWQsNn30i1YmMDHr9gGujZ70HjJ48gT89oPnRYTJjhGGarXMAJt/cD9DJIDhgFp+uaWJHNWCsUzttZQFDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119414; c=relaxed/simple;
	bh=wQsp5J1EcuFFHif+tsylNm3FhK76SHt9wXjFj+wEf3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PE04QvpRRPxkoNDZ5xBU9HNpgLrDt7dlXANvscWJHGgY6gOMV5NYmUr64HrCW4Wsb/tA/nJNEAWAbUViOprRz5E8lu0LKaV/J1ml+wCL8HW/3XyMhp0FZZqlUu/CXljdE6/DihHYha27qEzzMtWbgshNMwu1G9hMxPZBGEmGuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bY/vcnvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A8C4CEEB;
	Tue,  8 Apr 2025 13:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119413;
	bh=wQsp5J1EcuFFHif+tsylNm3FhK76SHt9wXjFj+wEf3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bY/vcnvPUYmNxnsol2gqaDUPwaaY27Fb3J5fGGtDsQUOxGojbiIKBQlkeie8//XSL
	 wtqpMDnHsl5C93rO32/7Fl8FCFPr69UVjFxaryuocQETZLhcPvwLvRwlzO5HeR8lZb
	 6xwDfNLN0vrHpDLchUxt6UjcC96fh04PAiD9OOthGWOVnulo2VUVtfrPVj4qgivgdB
	 bINyXgVP22XdjQpT33SNlIO/19IlQjMgEwjhuGmuRaGHEvPerbyNc4MwH5ncAs95NS
	 3zUlt/6oSu3peDQrEFIYo1fZSfQF5b1qSRpajKOMo94w4jxVxn9+L+K27cjI4yryRa
	 qZgc+w7r4h1ig==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Apr 2025 09:36:37 -0400
Subject: [PATCH v2 1/2] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-netns-debugfs-v2-1-ca267f51461e@kernel.org>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
In-Reply-To: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1831; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=wQsp5J1EcuFFHif+tsylNm3FhK76SHt9wXjFj+wEf3M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9SZybrEoQjvql5c5cYD8ycI1vabhPh0yMJTgW
 hRRetxqTWWJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/UmcgAKCRAADmhBGVaC
 FSrVD/4oywdR9mRHgb74ldsKYET0Fksc+td7NwMPwTYzsfkn4GJNv7v19nhIeIqcTBhcnL5qqtO
 eShxNkeMViFZrBk8LxtcRnZG2CxaEoKNWK8jk8jABMooJq+Oy/7Rnphq3HA3ZEPpxD/HbNBJyUv
 S1yH6Tp0EojbMZ+mPQ241OLSSwsGQdRHYmofRuuO3OeTVacltwA3uVhSV9BwNoqEI5a8Y+6Khw0
 xggAddEfR+5zfgvJJv7smocMChkI47pBAT4Vy8tBTvAdniOgDl9UWbxU9qCh9wQLO2Cnaf7rOjD
 HJ4X5/N2neywf93tk0xniE+wRSEosQuQppFgzbz0/KnR5YCdrj5EX8VM1j1Q1PzjydktuiBW3eT
 YZ6qz1mzfHpAMqw5NzRdLPap3XPXD7hxSx54emdhznZ0/xPKfbR4Rh0V97E5kiu8UFfzN8xKTwo
 5k1T9wF+RwCeICm9dfr5i48ETdDU5pVU4D6JIFYXwZEHX617Avm+JgWkdjneDosWRaMXX4QqaQH
 rTVDOxabEOygFwqzW2TBTzGU+0s/z5GKlbAXx+nGLln020SfSbeLdHpwD7fG19ddYGaiyEi2RmR
 3oQ/KWGKBenOWZP6NltALXV7Q4WiPCuH1VRivo/H1j3IB/nMeIKXOMRTgIjere1ydw2Xd5e56hx
 AKxLijxDi74FDkQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can add a directory or files under there to display info about
currently-held references.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h |  3 +++
 lib/ref_tracker.c           | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 8eac4f3d52547ccbaf9dcd09962ce80d26fbdff8..16fb6ec0cc7adc24457cfab13ee3994d85c15b39 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -22,6 +22,9 @@ struct ref_tracker_dir {
 };
 
 #ifdef CONFIG_REF_TRACKER
+#ifdef CONFIG_DEBUG_FS
+extern struct dentry *ref_tracker_debug_dir;
+#endif /* CONFIG_DEBUG_FS */
 
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79361763abe5a3a98484a3ee591ff2..136723eab6b17ae07132c659fd1d8b0690d8c2d9 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -12,6 +12,8 @@
 #define REF_TRACKER_STACK_ENTRIES 16
 #define STACK_BUF_SIZE 1024
 
+struct dentry *ref_tracker_debug_dir;
+
 struct ref_tracker {
 	struct list_head	head;   /* anchor into dir->list or dir->quarantine */
 	bool			dead;
@@ -273,3 +275,16 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_tracker_free);
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+
+static int __init ref_tracker_debug_init(void)
+{
+	ref_tracker_debug_dir = debugfs_create_dir("ref_tracker", NULL);
+	if (IS_ERR(ref_tracker_debug_dir))
+		return PTR_ERR(ref_tracker_debug_dir);
+	return 0;
+}
+late_initcall(ref_tracker_debug_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


