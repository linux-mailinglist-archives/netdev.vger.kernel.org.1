Return-Path: <netdev+bounces-193623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CDAC4D90
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC54189E359
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F465262FD2;
	Tue, 27 May 2025 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/1Vjf2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273612620C1;
	Tue, 27 May 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345630; cv=none; b=BtcCTIar07/cqBvvkE/Eme/+QL6579wPzavpmDw9WaidgXsriqcpiFLZbuTuyNTHRVOeKz4LC0T+86JJHUUHvQ7ndRjq+mwYj7fk5D4jiWywCzXqkxfIDah43mHcm6jM9KDO9Ws3KYRtYP9+oyOk9O+MCaCe6kwjEv/+Ev6i3CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345630; c=relaxed/simple;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5Wb51p+uCoFJR8mKWT1Swk4u/4ZzSyxD/jsp9i5QbjtFJriyLJWXk6MRiQUuWF4Hb/PExgOocltWKFAvlEfqpbnbrWeDGLP/D6jga7OlF6ff2kW+d7wOxSb2IxpyX9ArRIbzbzjW2FxLxT7uknTE1jDNfg/Y4l+75PbWsv7Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/1Vjf2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FB6C4CEF2;
	Tue, 27 May 2025 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345629;
	bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H/1Vjf2sPX5KsrcOHk+12wXlOtPzI8Iukxuhbz6YGMxCk/wg193jaEboTR7JMwqjR
	 A9zcY+aMWg5Whhb838580SWhl32lJTyaeXjR7+5s637gghgbo1dvemnPZdTZrSWUBg
	 eFyNfk7oW4yRp5BNydPJwKtTcBXHsiuIZS1Gq+MBQbqs6g8uu0grCCoQgL6kUlHhNA
	 jCZe7msdNHpPl5KFH4eZ6Yd4nxfpwvBo4vMklqgi0G8kbl5odQJDplygC/J1HNTtPx
	 yH4l8Ebd8L9mRqgRrnCXKDeG5G5WqJaZnmJVXAInZ26JwNcWMBK1VzT01uYWQ6n8Q2
	 BVwX1wFQUw7jA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 07:33:33 -0400
Subject: [PATCH v10 2/9] ref_tracker: add a top level debugfs directory for
 ref_tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-reftrack-dbgfs-v10-2-dc55f7705691@kernel.org>
References: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
In-Reply-To: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LxLVRB8GvDbWgwRUBMxy60vYqqNKxSuBn+6jZzlFCL8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNaMVUlqezMYH1mChIIL5u6XBGAgfwmyhmxpLN
 5wWe7G0X5CJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDWjFQAKCRAADmhBGVaC
 FcTlEAC7BuBEddZnQjUlkz5zSm4otOItDTjUhGMXZTeBxwZ3rNVydEEUQpBLVk+WDdZyiMlhHwt
 75DORyJfHzYdSpf0e/WnyqVbJj4ByPcSQRFSj5rcaKmNWHEltD274lcgSWy0Zl1YYpiSYFWGVJE
 2P2R5iZlsXboEsudbSNlwcs7+LqEUN2MorNhS1WWMQK0TpDBTuuBRi3CAWPv5ZdF+MsECg/vD7U
 BvwqFHL0hXJc0I/si0gzjXIdW+GpyEcrVcfIy6iq2TCfiFEXBH7KSnt0g8usF80u5EsEiyQP32V
 zNNvMqpDouDHwT/jvnzGYV9XYq8lPmxWfUcL1/LmOEiTbRNnmHA7wwiu5Ps/9ohtgyGlQNKIi4v
 RWaHQqF+txZ4CKdwrrmp1yflqz/+TMxC0moyxYq0lPnCHCwmgKoJabsH0P9nvwruD3GUnAh35hI
 LMPi8vUD0Al5my93UERGLE72U8+3gRMLqnu0TmfHgdxdkvUoArxgvsZKbesv9wqI4PeXBb57J7J
 jTFSWhLLq9BA/rO3HI/juKsV92jV3ID0scnnOoaoj21LeVitpINSdxDeh3//d5yCJ+WqHNCCzGS
 VgJHp6RpKevoKCI/KYcm2CYf2hAFLWNYszqo6g9CdygWkfk2Tk98iba2JQAcirKqrFEFXF33V6P
 llhWX9B9xmZxYBg==
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
index de71439e12a3bab6456910986fa611dfbdd97980..34ac37db209077d6771d5f4367e53d19ba3169c6 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -273,3 +273,19 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
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
+	if (IS_ERR(ref_tracker_debug_dir))
+		pr_warn("ref_tracker: unable to create debugfs ref_tracker directory: %pe\n",
+			ref_tracker_debug_dir);
+	return 0;
+}
+late_initcall(ref_tracker_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

-- 
2.49.0


