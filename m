Return-Path: <netdev+bounces-16529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4376874DB54
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7309F1C20966
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8211426F;
	Mon, 10 Jul 2023 16:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000C71426A
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 16:40:46 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE818120
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689007245; x=1720543245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52YjinahsPwb9xw2aTACKTYvKQqoJIfxpdK32fUgECc=;
  b=VA7f6L9tlcH4WFCUX1a8G/Y/8uLBP+sdH1dGwXSNYlWxWhOPPaz3JE1E
   NuSQgtmjuUv4SqXgErGCfmFNXsVb4Q7GdECYH81n7PumvBc/Aqhn/4Ak4
   6gK11rNDrK4aIWtlrtI891Ly7jeLuPsxflyy+p2rE7dIoUhaydZeJKGD8
   PuBPlqu/y6DAzorglbWgVqQORsC1st2Av7UDYhqxZBiIm7pNLOL/XLTal
   dNWMYNGdUEr903quD2+Le6VYiAT3kxUAuhRnmpUW/g0giwFFfAwPOrcsM
   kiBILbrhAiYNIhgyPujPQ4GfJagkvCB8Uq+w+OCJfzB+bhDLQ0agDdQW6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="364431400"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="364431400"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 09:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="810867161"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="810867161"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2023 09:40:44 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Florian Kauer <florian.kauer@linutronix.de>,
	anthony.l.nguyen@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	muhammad.husaini.zulkifli@intel.com,
	tee.min.tan@linux.intel.com,
	aravindhan.gunasekaran@intel.com,
	sasha.neftin@intel.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 5/6] igc: Fix launchtime before start of cycle
Date: Mon, 10 Jul 2023 09:35:02 -0700
Message-Id: <20230710163503.2821068-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Florian Kauer <florian.kauer@linutronix.de>

It is possible (verified on a running system) that frames are processed
by igc_tx_launchtime with a txtime before the start of the cycle
(baset_est).

However, the result of txtime - baset_est is written into a u32,
leading to a wrap around to a positive number. The following
launchtime > 0 check will only branch to executing launchtime = 0
if launchtime is already 0.

Fix it by using a s32 before checking launchtime > 0.

Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5d24930fed8f..4855caa3bae4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1016,7 +1016,7 @@ static __le32 igc_tx_launchtime(struct igc_ring *ring, ktime_t txtime,
 	ktime_t base_time = adapter->base_time;
 	ktime_t now = ktime_get_clocktai();
 	ktime_t baset_est, end_of_cycle;
-	u32 launchtime;
+	s32 launchtime;
 	s64 n;
 
 	n = div64_s64(ktime_sub_ns(now, base_time), cycle_time);
-- 
2.38.1


