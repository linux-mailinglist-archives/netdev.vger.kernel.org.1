Return-Path: <netdev+bounces-26270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E2C7775F8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC99E282053
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4C1ED36;
	Thu, 10 Aug 2023 10:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071411ED34
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:38:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D66E10DA;
	Thu, 10 Aug 2023 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691663924; x=1723199924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whD5FVxA9A5hKboWwZaDxzNXpacfLK96uA3KJdXm3Us=;
  b=FCulkeuKGYoeFwjZyCJyiLZ8YT9pmHVseL854uOeknFYbh2aHIAd60lG
   s7GiNEH2aqMEARfSNcTyj02zTTqt/ON1rz9M45btgrO3VlQFr4KPaTQCf
   DT5PHfSZNUMIgjuFq6fNoAp5nITXgWyZhixLayTbwY2DyjgPWMKWsQbKg
   0gbYKz7amv+Xn9CEoXv4iB3J7yweQo9Mn23RugeAO2JmPO7ITd1hgq5Xp
   OtWS5EDP9SrAv5f2rquqRjF+CxIE9wEkuQDca6tg7SticnzVJqvb7tVeX
   RHWxdnFlMRc4nnHg8ilEetNofHmFKNMyV9syxlY45qPu6QoACDVef76O4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="370260806"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="370260806"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 03:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="767237167"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="767237167"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2023 03:38:41 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3886A332BB;
	Thu, 10 Aug 2023 11:38:40 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 1/7] overflow: add DEFINE_FLEX() for on-stack allocs
Date: Thu, 10 Aug 2023 06:35:03 -0400
Message-Id: <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add DEFINE_FLEX() macro for on-stack allocations of structs with
flexible array member.

Add also const_flex_size() macro, that reads size of structs
allocated by DEFINE_FLEX().

Using underlying array for on-stack storage lets us to declare
known-at-compile-time structures without kzalloc().

Actual usage for ice driver is in following patches of the series.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v1: change macro name; add macro for size read;
    accept struct type instead of ptr to it; change alignment;
---
 include/linux/overflow.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index f9b60313eaea..21a4410799eb 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
 #define struct_size_t(type, member, count)					\
 	struct_size((type *)NULL, member, count)
 
+/**
+ * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
+ * a trailing flexible array member.
+ *
+ * @type: structure type name, including "struct" keyword.
+ * @name: Name for a variable to define.
+ * @member: Name of the array member.
+ * @count: Number of elements in the array; must be compile-time const.
+ */
+#define DEFINE_FLEX(type, name, member, count)					\
+	union {									\
+		u8 bytes[struct_size_t(type, member, count)];			\
+		type obj;							\
+	} name##_u __aligned(_Alignof(type)) = {};				\
+	type *name = (type *)&name##_u
+
+/**
+ * const_flex_size() - Get size of on-stack instance of structure with
+ * a trailing flexible array member.
+ *
+ * @name: Name of the variable, the one defined by DEFINE_FLEX() macro above.
+ *
+ * Get size of @name, which is equivalent to struct_size(name, array, count),
+ * but does not require (repeating) last two arguments.
+ */
+#define const_flex_size(name)	__builtin_object_size(name, 1)
+
 #endif /* __LINUX_OVERFLOW_H */
-- 
2.40.1


