Return-Path: <netdev+bounces-26588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DD778456
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10AB21C20BEF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91781134BE;
	Thu, 10 Aug 2023 23:51:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772C6FB3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:51:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B82D52
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691711478; x=1723247478;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+FebJGVtOU0ozNN9ME2PO2RSeW7ryCgG5maaWtlALcM=;
  b=VOO3SrpywJkS0kfvWkewQSW1IJP9qDOWaObOPN8+50spi8DZEBMOKHVp
   DZ4NaYSJNrXRo5pSaLCxiisSAIFy0Ly+wzyf1+FDh/ZINJH+yCiQQH4XJ
   A+f8DANEsA+lYOxpEb11tEZoTmYI5Q/bRiM7nsRvWHPub7nvRhpx+yAU1
   BESZW4S4uhRXw6qnz8FaLOejoMRYAotq4tH7x8Q7YRge1UPrP8IZnhEl2
   gSdOMD7AY7zv+O9e7daLqgYMmaiRqyf4dbBgNVNbC/pPT73eVu1SuiK1P
   Hct+q8UtlnPA/ICh96eGZHub/BhzczNLgdt7e21ZyINufysqtlh+Zu3yJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="402521338"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="402521338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:51:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709331876"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="709331876"
Received: from jbrandeb-saw1.jf.intel.com ([10.166.28.102])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:51:18 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v2] ice: fix receive buffer size miscalculation
Date: Thu, 10 Aug 2023 16:51:10 -0700
Message-ID: <20230810235110.440553-1-jesse.brandeburg@intel.com>
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

The driver is misconfiguring the hardware for some values of MTU such that
it could use multiple descriptors to receive a packet when it could have
simply used one.

Change the driver to use a round-up instead of the result of a shift, as
the shift can truncate the lower bits of the size, and result in the
problem noted above. It also aligns this driver with similar code in i40e.

The insidiousness of this problem is that everything works with the wrong
size, it's just not working as well as it could, as some MTU sizes end up
using two or more descriptors, and there is no way to tell that is
happening without looking at ice_trace or a bus analyzer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: added fixes tag pointing to the last time this line was modified in
v5.5 instead of pointing back to the introduction of the driver.
---
 drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index b678bdf96f3a..074bf9403cd1 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -435,7 +435,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
+	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
-- 
2.41.0


