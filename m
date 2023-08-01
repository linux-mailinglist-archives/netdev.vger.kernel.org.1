Return-Path: <netdev+bounces-23153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61D76B2F5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17A171C20E00
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70C020FB3;
	Tue,  1 Aug 2023 11:19:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE81ED3C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:19:53 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9505B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690888792; x=1722424792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WtT6XgSWlnrDQ68ZvjZ28IvPo6s0OiqVJdElDVPQXhc=;
  b=NpMFhqeKuGG3DqZcOViGYB/8v8nslc5RWwj0Esa6r+pvPE2/0PoC+/AX
   9W7ReYrApxbrYLAZ8Ty7OZxwWa0CkkR6b652Ta2nXELwg9ZjMiF4nXwso
   pB7KXNjD1W7+MLnaUNuLB+UNS0p6DXDfxnfm1M/CVTPp1UuksdHJtG5b9
   CtdquZRbTr/T3JRZS3nmd+FrhPYnYtr4G8QbqkNwMfE/Recck/3t4POwA
   Zgnr0NaOfV3KxlAGZZTjSg5BZgqlhC87Kq7wCzdP2NpD4J+w5QBV+Snzw
   2zCi+fKGofMEmk4tEJlAWR67DgKLkMQFmM65Ma7PHngnHCSHM/q7ZgAec
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455644610"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="455644610"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 04:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852415995"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="852415995"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2023 04:19:50 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.255.193.236])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 813B233BFE;
	Tue,  1 Aug 2023 12:19:48 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack allocs
Date: Tue,  1 Aug 2023 13:19:22 +0200
Message-Id: <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DECLARE_FLEX() macro for on-stack allocations of structs with
flexible array member.

Using underlying array for on-stack storage lets us to declare known
on compile-time structures without kzalloc().

Actual usage for ice driver is in next patch of the series.

Note that "struct" kw and "*" char is moved to the caller, to both:
have shorter macro name, and have more natural type specification
in the driver code (IOW not hiding an actual type of var).

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 include/linux/overflow.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea..403b7ec120a2 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -309,4 +309,18 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * DECLARE_FLEX() - Declare an on-stack instance of structure with trailing
+ * flexible array.
+ * @type: Pointer to structure type, including "struct" keyword and "*" char.
+ * @name: Name for a (pointer) variable to create.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ *
+ * Declare an instance of structure *@type with trailing flexible array.
+ */
+#define DECLARE_FLEX(type, name, member, count)					\
+	u8 name##_buf[struct_size((type)NULL, member, count)] __aligned(8) = {};\
+	type name = (type)&name##_buf
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.38.1


