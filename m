Return-Path: <netdev+bounces-38322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799E7BA66E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AB7BA281A87
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6280A2E65A;
	Thu,  5 Oct 2023 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjeMS8r8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028A93715E
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:34:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9D1FFD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523609; x=1728059609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A34UIhOEeYDkulHKK85KKG8IcHYCF0Db4HQzltSa750=;
  b=FjeMS8r8VolotDz/v4A+MVMIjQVG6Ram9ZMDnGq2OcODIZ37q0dFxxJV
   XXlHEBjZQ04FEAWGTuUNdzulGb0fnvS9cDPxTsZ4NLpkOOA+KqsaJBAyd
   rvodVUv0Fma7U2CSHWpnseYS7cnxghJ+tEs69Cg3yfnvKFilEyrhX++oE
   4jWvUuapcQuIQznmg5lg0Z35zCx9DnOTFv9hNjnZ6HZdXdki0C82d22Fd
   uP+H1cDFYUE3MbTfdP5CMeLJXVVYnHUVwt6udlgDktbP7VcAjyYQWSFBQ
   pQUYJBOThwuh8WhDddQcKPAf8LmeuSAeLHzhNw55vpyYdBk8G11tKtaQA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152678"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152678"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607751"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607751"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:55 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 6/9] i40e: Move memory allocation structures to i40e_alloc.h
Date: Thu,  5 Oct 2023 09:28:47 -0700
Message-Id: <20231005162850.3218594-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

Structures i40e_dma_mem & i40e_virt_mem are defined i40e_osdep.h while
memory allocation functions that use them are declared in i40e_alloc.h
Move them there.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  1 +
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 14 ++++++++++++++
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  | 12 ------------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index 267f2e0a21ce..1c3d2bc5c3f7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_ADMINQ_H_
 #define _I40E_ADMINQ_H_
 
+#include "i40e_alloc.h"
 #include "i40e_osdep.h"
 #include "i40e_adminq_cmd.h"
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index 4b2d8da048c6..e0dde326255d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -4,8 +4,22 @@
 #ifndef _I40E_ALLOC_H_
 #define _I40E_ALLOC_H_
 
+#include <linux/types.h>
+
 struct i40e_hw;
 
+/* memory allocation tracking */
+struct i40e_dma_mem {
+	void *va;
+	dma_addr_t pa;
+	u32 size;
+};
+
+struct i40e_virt_mem {
+	void *va;
+	u32 size;
+};
+
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 70cac3bb31ec..fd18895cfb56 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -29,18 +29,6 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw);
 #define rd64(a, reg)		readq((a)->hw_addr + (reg))
 #define i40e_flush(a)		readl((a)->hw_addr + I40E_GLGEN_STAT)
 
-/* memory allocation tracking */
-struct i40e_dma_mem {
-	void *va;
-	dma_addr_t pa;
-	u32 size;
-};
-
-struct i40e_virt_mem {
-	void *va;
-	u32 size;
-};
-
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-- 
2.38.1


