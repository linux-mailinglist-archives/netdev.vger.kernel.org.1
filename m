Return-Path: <netdev+bounces-105312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFC9106F2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD561F21EA9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F010A1AE09D;
	Thu, 20 Jun 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M53U+qiu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBE1AE088;
	Thu, 20 Jun 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891790; cv=none; b=mJHIR529ade6+mVKxqWEdf/CJO2WIWkp/Z3IIZyNAc1x+Dg/8O5dt0EUrMhCNJAf8cYIvYYMZhup6RijTYJ0O6IJjGgAKYwJXn5th2n3C7Jwv5xXWK50LmAsEsyIR661AcL6O8DVRRXazKHlBKlsO49MxGyGYdTRDbfNaaq9/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891790; c=relaxed/simple;
	bh=cHwF/P7XUZiFJ49XfuTkhTme0SbTcgI0ml3mi4yZUIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DMEFiC+mvVq3zcSF3Xva0lLtW2xLUfHQC91wR84Lp7XxWIriYvIvQHWAIRGwsMKAOpx6yiBBR9oGPpwgNCc2Kk4fpyE+IxexOTq6aKFINY4y5EFGr6BFdyVftuWQhykAJeTCfcU8QCcW3chlkklkSBVvzL/osZvz0/bFHgM+HIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M53U+qiu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718891790; x=1750427790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHwF/P7XUZiFJ49XfuTkhTme0SbTcgI0ml3mi4yZUIM=;
  b=M53U+qiugSuVVZxZA2yoPfOXdhYm2AzmpFMll6AL0/psWZ5HYpSgkeeD
   4KNA5YGl8frAUAxFmgysefc/TuC2SzvglJXBWs5NwpAZhPsKX95RCqbLM
   j3BjL3wSqTaEF2WLVac0OEySkT9EUCaDtB1DnmRHkKAU6p+BkvsmRgfC6
   Ai6Kfiw/j8CwCWux7DRFLslESI5pOUQhlj41ZxlKoH+K1rwZRtH6lEA8F
   +7CvXih7s5ZVEUeXOiJDn8EiubF2AzAYnrqe9qWBSUyGLVwQqNl39jzJS
   0r2EmIxdG4K/u8OxKDoBeOtW745fAxunrEtKyNSQfAGvjl9zwBEJdXXxz
   A==;
X-CSE-ConnectionGUID: yWAQhAjzQj6AK5x7HTxQ4A==
X-CSE-MsgGUID: Ow6ITokZR+25aX1kFqJYeg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15987803"
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="15987803"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 06:56:29 -0700
X-CSE-ConnectionGUID: cEGE8mnfS1WFhqcE0kDdow==
X-CSE-MsgGUID: 3AFJMse/Qsy9fIofQ+VGpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,252,1712646000"; 
   d="scan'208";a="46772042"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jun 2024 06:56:24 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next v2 02/14] page_pool: use __cacheline_group_{begin,end}_aligned()
Date: Thu, 20 Jun 2024 15:53:35 +0200
Message-ID: <20240620135347.3006818-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
References: <20240620135347.3006818-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of doing __cacheline_group_begin() __aligned(), use the new
__cacheline_group_{begin,end}_aligned(), so that it will take care
of the group alignment itself.
Also replace open-coded `4 * sizeof(long)` in two places with
a definition.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool/types.h | 22 ++++++++++++----------
 net/core/page_pool.c          |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7e8477057f3d..29420f3fee8f 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -128,6 +128,16 @@ struct page_pool_stats {
 };
 #endif
 
+/* The whole frag API block must stay within one cacheline. On 32-bit systems,
+ * sizeof(long) == sizeof(int), so that the block size is ``3 * sizeof(long)``.
+ * On 64-bit systems, the actual size is ``2 * sizeof(long) + sizeof(int)``.
+ * The closest pow-2 to both of them is ``4 * sizeof(long)``, so just use that
+ * one for simplicity.
+ * Having it aligned to a cacheline boundary may be excessive and doesn't bring
+ * any good.
+ */
+#define PAGE_POOL_FRAG_GROUP_ALIGN	(4 * sizeof(long))
+
 struct page_pool {
 	struct page_pool_params_fast p;
 
@@ -141,19 +151,11 @@ struct page_pool {
 	bool system:1;			/* This is a global percpu pool */
 #endif
 
-	/* The following block must stay within one cacheline. On 32-bit
-	 * systems, sizeof(long) == sizeof(int), so that the block size is
-	 * ``3 * sizeof(long)``. On 64-bit systems, the actual size is
-	 * ``2 * sizeof(long) + sizeof(int)``. The closest pow-2 to both of
-	 * them is ``4 * sizeof(long)``, so just use that one for simplicity.
-	 * Having it aligned to a cacheline boundary may be excessive and
-	 * doesn't bring any good.
-	 */
-	__cacheline_group_begin(frag) __aligned(4 * sizeof(long));
+	__cacheline_group_begin_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 	long frag_users;
 	struct page *frag_page;
 	unsigned int frag_offset;
-	__cacheline_group_end(frag);
+	__cacheline_group_end_aligned(frag, PAGE_POOL_FRAG_GROUP_ALIGN);
 
 	struct delayed_work release_dw;
 	void (*disconnect)(void *pool);
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 3927a0a7fa9a..93d92efa7777 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -178,7 +178,8 @@ static void page_pool_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_users);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_page);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct page_pool, frag, frag_offset);
-	CACHELINE_ASSERT_GROUP_SIZE(struct page_pool, frag, 4 * sizeof(long));
+	CACHELINE_ASSERT_GROUP_SIZE(struct page_pool, frag,
+				    PAGE_POOL_FRAG_GROUP_ALIGN);
 }
 
 static int page_pool_init(struct page_pool *pool,
-- 
2.45.2


