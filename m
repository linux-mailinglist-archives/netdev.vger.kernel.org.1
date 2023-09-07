Return-Path: <netdev+bounces-32352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EEA796E01
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 02:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAB91C20A9C
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 00:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52E63A;
	Thu,  7 Sep 2023 00:30:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6C61100
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 00:30:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9561AE9;
	Wed,  6 Sep 2023 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694046623; x=1725582623;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZBbr3uJJ8GvXoyhicrV/I194s5KUyoTJx2VEg0uWzZc=;
  b=GOWhU8hz+82bTTM4br3B3mBGZhgXN2vWVm1b5YfAEdoS9cBC+2fJanBf
   YQKUZcVoWi7xonag6AheBrwZUa4WL4fjNRE0ZHcsg5Ftulyiy4kPwDv/7
   IjQYsSseqqGpnbgxv7TwwD2xZpe+snd1v3I96cQAO7fOJA2jTT1JGBDlg
   Or6Tn/Uvb/geyhuMgcoETBFUG8dP4L6fF7ia+S1Ghac8um1iP0yMEr4Jx
   JOs1XIpUgQy8gTFsDndZo2PCjCK44OazM4ClDQF4oromiE7LDKso/OcKj
   v7SXobX93B2s6jvoC/gAocgJs409DoDitqW5ihDhBeP/55XIgT30m7rkB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="367443777"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="367443777"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 17:30:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="691539433"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="691539433"
Received: from mcewe-mobl1.amr.corp.intel.com (HELO vcostago-mobl3.intel.com) ([10.251.10.12])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 17:30:22 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: sasha.neftin@intel.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Ferenc Fejes <ferenc.fejes@ericsson.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vedang Patel <vedang.patel@intel.com>,
	Andre Guedes <andre.guedes@intel.com>,
	Jithu Joseph <jithu.joseph@intel.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net v2] igc: Fix infinite initialization loop with early XDP redirect
Date: Wed,  6 Sep 2023 17:30:05 -0700
Message-ID: <20230907003005.99481-1-vinicius.gomes@intel.com>
X-Mailer: git-send-email 2.41.0
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

When a XDP redirect happens before the link is ready, that
transmission will not finish and will timeout, causing an adapter
reset. If the redirects do not stop, the adapter will not stop
resetting.

Wait for the driver to signal that there's a carrier before allowing
transmissions to proceed.

Previous code was relying that when __IGC_DOWN is cleared, the NIC is
ready to transmit as all the queues are ready, what happens is that
the carrier presence will only be signaled later, after the watchdog
workqueue has a chance to run. And during this interval (between
clearing __IGC_DOWN and the watchdog running) if any transmission
happens the timeout is emitted (detected by igc_tx_timeout()) which
causes the reset, with the potential for the inifite loop.

Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
Reported-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
Closes: https://lore.kernel.org/netdev/0caf33cf6adb3a5bf137eeaa20e89b167c9986d5.camel@ericsson.com/
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Ferenc Fejes <ferenc.fejes@ericsson.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
v1 -> v2:
 - Added more information to the commit message (Maciej Fijalkowski)


 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 293b45717683..98de34d0ce07 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6491,7 +6491,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	struct igc_ring *ring;
 	int i, drops;
 
-	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
-- 
2.41.0


