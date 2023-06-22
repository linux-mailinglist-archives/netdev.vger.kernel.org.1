Return-Path: <netdev+bounces-13162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF4373A869
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3811A28180D
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38C221064;
	Thu, 22 Jun 2023 18:41:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F312106E
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 18:41:11 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB810A3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687459270; x=1718995270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mSO/44M8e31NUVR5eKQLK/pRa8cpuxrujTg+CTD3Sqk=;
  b=O/ltX2ZCf7G3pul1+EvJ7455KKuYHzgJRmG7FvWHvca+i37Df2atRSRq
   6payN2M4av877vrY+e4qzl7jZ24QHTl4GtZVgo9x3+3zfkWPXaTH7DYDh
   SRA87e6qNKlHj0MXXyGuTj2bkO97E/CLkmc5sPgBhR9Jqv8NXoENfsgFY
   tjFOOWNDdF/0lG4p4QQ9qVK9b8Ujwm3JmDR0FuGGOX0XaX6TaDs2+2Mcz
   wB5zU6XPdSNzgR3XsHeIUP4uHfqy2SGwQ8nZY17bzWqED9YfXIxMFtas2
   pFAaqcckoB7GVE2aHJMmSriDUQ0jW3sIclBa2RpJtMk2YvjKKhtG0xG8a
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="340917809"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="340917809"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 11:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="961687046"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="961687046"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2023 11:41:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	anthony.l.nguyen@intel.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 5/6] ice: Remove managed memory usage in ice_get_fw_log_cfg()
Date: Thu, 22 Jun 2023 11:36:00 -0700
Message-Id: <20230622183601.2406499-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to use managed memory allocation here. The memory is
released at the end of the function.

Use kzalloc()/kfree() to simplify the code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 6acb40f3c202..e16d4c83ed5f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -833,7 +833,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 	u16 size;
 
 	size = sizeof(*config) * ICE_AQC_FW_LOG_ID_MAX;
-	config = devm_kzalloc(ice_hw_to_dev(hw), size, GFP_KERNEL);
+	config = kzalloc(size, GFP_KERNEL);
 	if (!config)
 		return -ENOMEM;
 
@@ -856,7 +856,7 @@ static int ice_get_fw_log_cfg(struct ice_hw *hw)
 		}
 	}
 
-	devm_kfree(ice_hw_to_dev(hw), config);
+	kfree(config);
 
 	return status;
 }
-- 
2.38.1


