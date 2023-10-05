Return-Path: <netdev+bounces-38327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9058F7BA681
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 577D21C20A61
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589CF3588C;
	Thu,  5 Oct 2023 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGA4MBvY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C530CE1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:35:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8672526BE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523602; x=1728059602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ja/M69XH5VmZW+Tq2JI2Ox2AYRPdZbI9otToeg1t8QA=;
  b=BGA4MBvYx4Lc/AXlSmB1pF8whD3NOs09+R41NfpZnn7A0dcLCEUOVwfK
   oyw0mW2h4T5AZQljacr7QYRmHGnyiX7eXBZHBX3BcQasJ9WhqJzEm9I6d
   gFEA/WoRspoPmTjxp+bpS6oEbqPwaTOLWeDkiF67rL0M3wraH6v/Bi+sg
   1boQc0KCwHdN/0sIOW8c6FWF16kPJ2qjTOeFcbNgj0OfsrCV9saYPvCsB
   BDlZr1HcwSr+OOaio7jtsBs75D111hxiv9/wI4PvOf3H8koXM00ERr8UT
   FWE7jeG6B1mJp+SBG8XfDdxnu8XbvTaQqw7muVWLf6wydZQEOed1qwBZ5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152661"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152661"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607738"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607738"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:54 -0700
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
Subject: [PATCH net-next 3/9] i40e: Refactor I40E_MDIO_CLAUSE* macros
Date: Thu,  5 Oct 2023 09:28:44 -0700
Message-Id: <20231005162850.3218594-4-anthony.l.nguyen@intel.com>
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

The macros I40E_MDIO_CLAUSE22* and I40E_MDIO_CLAUSE45* are using I40E_MASK
together with the same values I40E_GLGEN_MSCA_STCODE_SHIFT and
I40E_GLGEN_MSCA_OPCODE_SHIFT to define masks.
Introduce I40E_GLGEN_MSCA_OPCODE_MASK and I40E_GLGEN_MSCA_STCODE_MASK
for both shifts in i40e_register.h and use them to refactor the macros
mentioned above.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_register.h   |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 23 +++++++------------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index eebb5735772b..f408fcf23ce8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -205,7 +205,9 @@
 #define I40E_GLGEN_MSCA_DEVADD_SHIFT 16
 #define I40E_GLGEN_MSCA_PHYADD_SHIFT 21
 #define I40E_GLGEN_MSCA_OPCODE_SHIFT 26
+#define I40E_GLGEN_MSCA_OPCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_OPCODE_SHIFT)
 #define I40E_GLGEN_MSCA_STCODE_SHIFT 28
+#define I40E_GLGEN_MSCA_STCODE_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_STCODE_SHIFT)
 #define I40E_GLGEN_MSCA_MDICMD_SHIFT 30
 #define I40E_GLGEN_MSCA_MDICMD_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_MDICMD_SHIFT)
 #define I40E_GLGEN_MSCA_MDIINPROGEN_SHIFT 31
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 60b55d66d648..63cbf7669827 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -67,21 +67,14 @@ enum i40e_debug_mask {
 	I40E_DEBUG_ALL			= 0xFFFFFFFF
 };
 
-#define I40E_MDIO_CLAUSE22_STCODE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_STCODE_SHIFT)
-#define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_MASK(2, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-
-#define I40E_MDIO_CLAUSE45_STCODE_MASK	I40E_MASK(0, \
-						  I40E_GLGEN_MSCA_STCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_MASK(0, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_MASK(1, \
-						  I40E_GLGEN_MSCA_OPCODE_SHIFT)
-#define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_MASK(3, \
-						I40E_GLGEN_MSCA_OPCODE_SHIFT)
+#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
+#define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(2)
+
+#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(0)
+#define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
+#define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(3)
 
 #define I40E_PHY_COM_REG_PAGE                   0x1E
 #define I40E_PHY_LED_LINK_MODE_MASK             0xF0
-- 
2.38.1


