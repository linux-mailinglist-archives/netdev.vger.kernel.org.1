Return-Path: <netdev+bounces-26517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E267A777FDD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A938281BFA
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC321D2E;
	Thu, 10 Aug 2023 18:01:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBB22EE2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:01:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3616E2705
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691690485; x=1723226485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4ZdNfU93g0EXNgckXLlVb8CSrIRG7/TfnXRQvNW1K5U=;
  b=DvEmG/boF4OFfV9aPm8gVyjRIA+K7s7Dgom2UTt71EG5i+uvTrolwdw6
   qJGrw26jiUkwMV5wCyDROf0x1ETR1jq7vGhVrPfm4dmkY7CfTt0tVXYto
   dMByvXMf6Z0BxD3OP6BsEu699+p1aVLGAkXLGkLd/WorvPYm1B23pXxYq
   VPm1ExzRvIV7YjvRSc1fVKdWF/i2yliSYPUeP3q7C/1BMRmkd06msUlJU
   rQrueallkhnznymJUboJCFWCUK6/r1vMXvKevDFkARxcEkaDAeBuTPwc3
   GAJQAkV1joepywbrid3rkOB2F0ma+YAxS7PPoIyy4W6LWfjG0Qo9uRggL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361618466"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361618466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 11:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709253385"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="709253385"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 11:01:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alessio Igor Bogani <alessio.bogani@elettra.eu>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/2] igb: Stop PTP related workqueues if aren't necessary
Date: Thu, 10 Aug 2023 10:54:09 -0700
Message-Id: <20230810175410.1964221-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
References: <20230810175410.1964221-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alessio Igor Bogani <alessio.bogani@elettra.eu>

The workqueues ptp_tx_work and ptp_overflow_work are unconditionally allocated
by igb_ptp_init(). Stop them if aren't necessary (ptp_clock_register() fails
and CONFIG_PTP is disabled).

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 405886ee5261..02276c922ac0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1406,7 +1406,13 @@ void igb_ptp_init(struct igb_adapter *adapter)
 		dev_info(&adapter->pdev->dev, "added PHC on %s\n",
 			 adapter->netdev->name);
 		adapter->ptp_flags |= IGB_PTP_ENABLED;
+		return;
 	}
+
+	if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)
+		cancel_delayed_work_sync(&adapter->ptp_overflow_work);
+
+	cancel_work_sync(&adapter->ptp_tx_work);
 }
 
 /**
-- 
2.38.1


