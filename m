Return-Path: <netdev+bounces-26108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A9776D03
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925AA281E6B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3C436F;
	Thu, 10 Aug 2023 00:23:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC0366
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 00:23:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117271AA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 17:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691627004; x=1723163004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x13+hl34vBPVCPEfpwk1nYGCHVVQhHx3+doEaSVBKy4=;
  b=S1HrMODt/YHbuL31YOU25+mV63Ynq58iNqVoAOwzt+vpmp2ajiSryQI7
   Tr8IDJCviwms9U35zlPHREUAefgcQHM347XnyIMNVmI8aPAyMN1+0H491
   Jo0C2iGBGT4mlbIEHXoMFiov+Ehq9twY+OGXmL7nTqpH0bz9FWqbQanNg
   bDFr/ATPm8/SvDOfXoZYH84c0don5J+JUxJcCJJGdrPLOKxwpE2dXmYsH
   knqhY8YYyMxg4MOOqHjLA5gKKXqNRHJDV38ciU6qrreWIJNQvnHc8GdaT
   sojR1EmHMYrcGa9t4qtGs1SHcJyOt9NpmCLD+gBfPAxQ3h6qqvJYnhmwQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="368720842"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="368720842"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 17:23:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797396125"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="797396125"
Received: from jbrandeb-saw1.jf.intel.com ([10.166.28.102])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 17:23:23 -0700
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-net v1] ice: fix receive buffer size miscalculation
Date: Wed,  9 Aug 2023 17:23:13 -0700
Message-ID: <20230810002313.421684-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.41.0
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

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
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


