Return-Path: <netdev+bounces-57085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9543E812135
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8781C20924
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 22:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A4181825;
	Wed, 13 Dec 2023 22:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhcZykh8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4036AF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702505313; x=1734041313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WuWaBx5zepSkN51/ojQo0N71fl3iQkAmsKiqOeK5esk=;
  b=NhcZykh8bAoKB7yxCK5tuGKTfMbicNXwjqb/b/qvxCSficOwMeQ/EY3v
   bUjX+AdPUyVP9s+iwEei/wMbJGjgLKXRmRFjogE9t1X4+YWNlFfuevFBi
   7SdGFbgyadKSTAkoteFLawYTR/R20WoFvoHTjUb1NpvtLg1gmpEyiOZca
   TvQI/Drqo5FAVHiaNoxdaUvC3rhl0Lm6aYZN8Fpo9YNw2iUysURGgxt9A
   dNY06Y6Z1rPwMP91RPbSbU/gBQKPAMCGTX71RGZEVnzgIajg5Gk7wEZZw
   UZy3Jj7xQC6zfwZ1S/d60x9ZEGDoJt/+9w7vnZhDoZvRtjkpy0QU9xStI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392209637"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="392209637"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 14:08:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="803034132"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="803034132"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 13 Dec 2023 14:08:32 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/2] i40e: Fix ST code value for Clause 45
Date: Wed, 13 Dec 2023 14:08:26 -0800
Message-ID: <20231213220827.1311772-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
References: <20231213220827.1311772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

ST code value for clause 45 that has been changed by
commit 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
is currently wrong.

The mentioned commit refactored ..MDIO_CLAUSE??_STCODE_MASK so
their value is the same for both clauses. The value is correct
for clause 22 but not for clause 45.

Fix the issue by adding a parameter to I40E_GLGEN_MSCA_STCODE_MASK
macro that specifies required value.

Fixes: 8196b5fd6c73 ("i40e: Refactor I40E_MDIO_CLAUSE* macros")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index f408fcf23ce8..f6671ac79735 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -207,7 +207,7 @@
 #define I40E_GLGEN_MSCA_OPCODE_SHIFT 26
 #define I40E_GLGEN_MSCA_OPCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_OPCODE_SHIFT)
 #define I40E_GLGEN_MSCA_STCODE_SHIFT 28
-#define I40E_GLGEN_MSCA_STCODE_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_STCODE_SHIFT)
+#define I40E_GLGEN_MSCA_STCODE_MASK(_i) I40E_MASK(_i, I40E_GLGEN_MSCA_STCODE_SHIFT)
 #define I40E_GLGEN_MSCA_MDICMD_SHIFT 30
 #define I40E_GLGEN_MSCA_MDICMD_MASK I40E_MASK(0x1, I40E_GLGEN_MSCA_MDICMD_SHIFT)
 #define I40E_GLGEN_MSCA_MDIINPROGEN_SHIFT 31
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index aff6dc6afbe2..f95bc2a4a838 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -37,11 +37,11 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
 #define I40E_QTX_CTL_VM_QUEUE	0x1
 #define I40E_QTX_CTL_PF_QUEUE	0x2
 
-#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE22_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK(1)
 #define I40E_MDIO_CLAUSE22_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
 #define I40E_MDIO_CLAUSE22_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(2)
 
-#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK
+#define I40E_MDIO_CLAUSE45_STCODE_MASK		I40E_GLGEN_MSCA_STCODE_MASK(0)
 #define I40E_MDIO_CLAUSE45_OPCODE_ADDRESS_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(0)
 #define I40E_MDIO_CLAUSE45_OPCODE_WRITE_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(1)
 #define I40E_MDIO_CLAUSE45_OPCODE_READ_MASK	I40E_GLGEN_MSCA_OPCODE_MASK(3)
-- 
2.41.0


