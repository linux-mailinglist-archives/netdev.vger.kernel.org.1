Return-Path: <netdev+bounces-47513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E33C7EA6C1
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44CD2B20976
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29953FB0A;
	Mon, 13 Nov 2023 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bftxoSYt"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EC3E48A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:11:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A707D6C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917062; x=1731453062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tw6Ob2of83LXs0CWw17PK+oUsBf693DgUdgSp+qHPak=;
  b=bftxoSYtlzIaM8vxDILZlviA6w+g2Dt/7L4dd7qLIVEjtHTJDXjWVOjG
   DJFoy25xkcpw3+i/bnb03i50TqVOQPP1TkfEQ5j+GoIRBI++a2EpFU8I0
   Ve/lqvTrSsnXWfEssQbjTEFZ2uRtJmI+HtL1hlvgwyQ9xCbiN2bmqGyiT
   NTeSucq8CraD0yEHp9T5SU4KFlaOmKR4FkfDcLk/p/xgCmXg7MJsFYbk2
   1NDHeQ6NPgUJi8im8cDXsSWAKvlf5KylP8aagSPcptz/hMkH4cuSN4DvY
   QBeK+pm+3XrzwIZBh/YT/5Q+9V+ahSxtZaBIvmKOySQSoulZ6Ytf7/DFN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562663"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051433"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051433"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 13/15] i40e: Remove VF MAC types
Date: Mon, 13 Nov 2023 15:10:32 -0800
Message-ID: <20231113231047.548659-14-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
References: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
i40e_adminq_init_regs() and remove enums for these VF MAC types.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
 2 files changed, 10 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 29fc46abf690..896c43905309 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
 static void i40e_adminq_init_regs(struct i40e_hw *hw)
 {
 	/* set head and tail registers in our local struct */
-	if (i40e_is_vf(hw)) {
-		hw->aq.asq.tail = I40E_VF_ATQT1;
-		hw->aq.asq.head = I40E_VF_ATQH1;
-		hw->aq.asq.len  = I40E_VF_ATQLEN1;
-		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
-		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
-		hw->aq.arq.tail = I40E_VF_ARQT1;
-		hw->aq.arq.head = I40E_VF_ARQH1;
-		hw->aq.arq.len  = I40E_VF_ARQLEN1;
-		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
-		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
-	} else {
-		hw->aq.asq.tail = I40E_PF_ATQT;
-		hw->aq.asq.head = I40E_PF_ATQH;
-		hw->aq.asq.len  = I40E_PF_ATQLEN;
-		hw->aq.asq.bal  = I40E_PF_ATQBAL;
-		hw->aq.asq.bah  = I40E_PF_ATQBAH;
-		hw->aq.arq.tail = I40E_PF_ARQT;
-		hw->aq.arq.head = I40E_PF_ARQH;
-		hw->aq.arq.len  = I40E_PF_ARQLEN;
-		hw->aq.arq.bal  = I40E_PF_ARQBAL;
-		hw->aq.arq.bah  = I40E_PF_ARQBAH;
-	}
+	hw->aq.asq.tail = I40E_PF_ATQT;
+	hw->aq.asq.head = I40E_PF_ATQH;
+	hw->aq.asq.len  = I40E_PF_ATQLEN;
+	hw->aq.asq.bal  = I40E_PF_ATQBAL;
+	hw->aq.asq.bah  = I40E_PF_ATQBAH;
+	hw->aq.arq.tail = I40E_PF_ARQT;
+	hw->aq.arq.head = I40E_PF_ARQH;
+	hw->aq.arq.len  = I40E_PF_ARQLEN;
+	hw->aq.arq.bal  = I40E_PF_ARQBAL;
+	hw->aq.arq.bah  = I40E_PF_ARQBAH;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 9752d145939c..e21a8e06f6b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
 enum i40e_mac_type {
 	I40E_MAC_UNKNOWN = 0,
 	I40E_MAC_XL710,
-	I40E_MAC_VF,
 	I40E_MAC_X722,
-	I40E_MAC_X722_VF,
 	I40E_MAC_GENERIC,
 };
 
@@ -588,12 +586,6 @@ struct i40e_hw {
 	char err_str[16];
 };
 
-static inline bool i40e_is_vf(struct i40e_hw *hw)
-{
-	return (hw->mac.type == I40E_MAC_VF ||
-		hw->mac.type == I40E_MAC_X722_VF);
-}
-
 /**
  * i40e_is_aq_api_ver_ge
  * @hw: pointer to i40e_hw structure
-- 
2.41.0


