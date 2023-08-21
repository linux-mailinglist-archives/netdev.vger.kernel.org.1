Return-Path: <netdev+bounces-29376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA9E782F58
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EAE31C20902
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D688C15;
	Mon, 21 Aug 2023 17:24:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C28C09
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:24:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D033EE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692638674; x=1724174674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=94T9CNztaYFGk9Zv81DoPZC+Xe+2g3fOgoMdTA1Quz0=;
  b=Q1kP64+GEfc2YrxncBsBF6w3jSDUxXpBvCauvV6CMzJweNz7sfHbKN74
   ur9L3TDtKVOAh0zS+/b3E4NTOwY68lWy8yxjnp1ylvH/5ihrSZ63M921y
   Hi3Lgzbc/Duo+dyPznfWn7WwkzfQPpr5hpA8/fKGYXOFGcTn91hE1hg/k
   uXAsJXW6inuDj7uiiDl+iSSz6Bc5GB1D5kgkcREZXNZ8BtXbwBLvmht0Z
   BRI6jUM0Ngc/UFHcT2pK+ai09Yz8NxUM2u7EDmWOf8cCaV7l7mORf/+Pn
   pVqBStjZCRdmhx7Fi7tt6TCnl9PBgfca9ufWHTLuUXvhBbdKUhQ2ch5dT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358642517"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="358642517"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 10:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="801348335"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="801348335"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2023 10:24:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] igc: Fix the typo in the PTM Control macro
Date: Mon, 21 Aug 2023 10:17:21 -0700
Message-Id: <20230821171721.2203572-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sasha Neftin <sasha.neftin@intel.com>

The IGC_PTM_CTRL_SHRT_CYC defines the time between two consecutive PTM
requests. The bit resolution of this field is six bits. That bit five was
missing in the mask. This patch comes to correct the typo in the
IGC_PTM_CTRL_SHRT_CYC macro.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 44a507029946..2f780cc90883 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -546,7 +546,7 @@
 #define IGC_PTM_CTRL_START_NOW	BIT(29) /* Start PTM Now */
 #define IGC_PTM_CTRL_EN		BIT(30) /* Enable PTM */
 #define IGC_PTM_CTRL_TRIG	BIT(31) /* PTM Cycle trigger */
-#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x2f) << 2)
+#define IGC_PTM_CTRL_SHRT_CYC(usec)	(((usec) & 0x3f) << 2)
 #define IGC_PTM_CTRL_PTM_TO(usec)	(((usec) & 0xff) << 8)
 
 #define IGC_PTM_SHORT_CYC_DEFAULT	10  /* Default Short/interrupted cycle interval */
-- 
2.38.1


