Return-Path: <netdev+bounces-194237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5E9AC802A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8C89E109A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FB722DF87;
	Thu, 29 May 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+9N8cB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9E22DA1B;
	Thu, 29 May 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532080; cv=none; b=qL1saXnZX7Z/x7ZtpTpptZNFACfsNcsZsrP9GMNZbJDm3TVgfCLJoxWpl6bw5G7Dw2ahPiDmWEgJpwVFkOMYE1JDgyth+RVr1Pn8reolMnYG08tbu8D3204MC4fSnrGem2l+yxZuE/JcxEKxOtT1AqQM8K01Y6m+5YUqEUqeJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532080; c=relaxed/simple;
	bh=RlWXgxm38Aq29CBqdh8MUpS/8kHUwdh5uqxg8ACpYpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iabeIQEDxOXhs5cWPo1+ZjKIoP/kSnrhKfAq/3QPkimFSbABk4CwmWEDmdQC54z3u7T24ODkWtFcDO5JxFpCJUSMJpC3SkeJyGi80tBimOQsbcunM1tH8oDWRjmYUTWzIxD1V7TdhYxMj7VyNjnLxXguswhuLiJtouIiow4jwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+9N8cB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F284C4CEE7;
	Thu, 29 May 2025 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748532079;
	bh=RlWXgxm38Aq29CBqdh8MUpS/8kHUwdh5uqxg8ACpYpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O+9N8cB+GwpoqfvPiHGKa90TiTPoMCVbpSLT7KFPtXKlgIPg1rVh03lTjuc4+BYkA
	 TJqwQpmW0uqKhP/YAIKlWWzF4hWKgyh+9ylWdxxxDqTOuD71peN42inzqIky70vYeD
	 MC4BVmbOu1oNLAM7NdiOTrXIYIkAEum7DW2i7STNHFidxVwfm6mAuDf/Dr1p3PEDHi
	 sKpiX6qE3HHbm5VnTUAJ8eS36vV0WL2/+G7JenWbacVRPhSINCLSG5x9EP+EaLbctI
	 WKs6zL9DzIr6L7d9+G/4gMN+wB2kf7yWNP2pg9qHIkfUeKZ4dgxp4l3fjz3NfSkw5M
	 JmGCcPIaCLEUw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 May 2025 11:20:39 -0400
Subject: [PATCH v12 03/10] ref_tracker: add a top level debugfs directory
 for ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-reftrack-dbgfs-v12-3-11b93c0c0b6e@kernel.org>
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
In-Reply-To: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RlWXgxm38Aq29CBqdh8MUpS/8kHUwdh5uqxg8ACpYpI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoOHtl1UPDVJTvPvJNRc98rtdX0aJUeTHv9FEu0
 Ma0CvYIM+mJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDh7ZQAKCRAADmhBGVaC
 FSU5EACD3kw01IXG9X38wceHpPcVWw0grbOSu3GeJo+/T0YgHoFNyUvQ8qpkeNzxzlLgL3oLG0e
 Jhr+xQXngdKI1kdPGHFIzkTyfv8YMRivcMddsIaq6atTsonLPH1Bv95G8RMC8JJOElxyX2wAcND
 n2gb/0ooYNI1NuAh2XRw68KsvcF5J2Fv4yJkqoy+c1iemfDLf/C3oyl8WxuFmKzXkwRTGs7xW9P
 NYpOvf4DGWjj0J5iewO0fH75PD0QQeAhqQAnXLJkrakNhFvU/aWGng7tgNJCbGX7glsygZ7wUBg
 nXhexqtdpL6p3Rpy9nadviXOX+Y7pjW59Ys+DkS2iawi02V/Xf3iYXRfyPdCQjBRBS9zdw/Fk/p
 qp89wtBNIAdAuvbNgqsG1bHJXkpUDE15eTp1lWJO3/2WVw5SCLAJYrLjw5vUnTI67hgDCN1e1kE
 ds3oM0+9K1PaftZRS9IfnfraUWpfYJTB1kxVsUTZW69w/kMvhVw+GoPtx56esDrly/gx9Ia+xQJ
 6llOxwBhAnWnhrkmTyyM8FZMI7K8qU7L+m9z3EyrE6m3iHMTU5bUK8kORA81439KrQaUepzBM60
 wieDuaGS+fYwgfnn3NGD0gvxANZAr0KDm2+ggdFI/TjRrGBOqFEhOG3yLVnNo/Wzb9TxGeSXyx+
 MkZQKh8/mr3MasQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Add a new "ref_tracker" directory in debugfs. Each individual refcount
tracker can register files under there to display info about
currently-held references.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


