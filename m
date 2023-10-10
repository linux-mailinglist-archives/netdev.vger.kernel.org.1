Return-Path: <netdev+bounces-39693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D47C4142
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7112280D9B
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADB731597;
	Tue, 10 Oct 2023 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Er/HXTzC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0920225D0
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 20:31:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1C8E;
	Tue, 10 Oct 2023 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696969871; x=1728505871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q0gBOkzDsq/gQYzu51R39rST/HZysRsPFQA+3BD9Ztk=;
  b=Er/HXTzCb+nemcU13NpA33/dERp29XIecWktvV3oTBbLtVawgr7CYt/X
   dfYnaf2RBmAPJkhDH1Xg2puydJLpCDz6RGVfFPDTN11s31QIibyCYHFi6
   HNEFj0GPFeJd2foezH/58qwxvxGRd5MzVLuVY5vmZRhgwmWQCZjSiK7+Y
   bDRPlYrodKoKqL+c9wKyFzPRfddG3mEoaCouz6Beo4DBc5e9b4E6AYp1w
   dF7zPQ9a1Cba3dzZKJpFFFYynf0PUSZ/pYwMeFHfn1s+qtfnmkmDKc4e4
   UlsYxo92lVTeW+/RLhw7lu1x1KLHafAGNcCDrzH6ycKWrm0+qQqtxRet8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3088339"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="3088339"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753533599"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="753533599"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 13:31:08 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] ice: fix over-shifted variable
Date: Tue, 10 Oct 2023 13:30:59 -0700
Message-ID: <20231010203101.406248-1-jacob.e.keller@intel.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Since the introduction of the ice driver the code has been
double-shifting the RSS enabling field, because the define already has
shifts in it and can't have the regular pattern of "a << shiftval &
mask" applied.

Most places in the code got it right, but one line was still wrong. Fix
this one location for easy backports to stable. An in-progress patch
fixes the defines to "standard" and will be applied as part of the
regular -next process sometime after this one.

Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: stable@vger.kernel.org
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7bf9b7069754..73bbf06a76db 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1201,8 +1201,7 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 
 	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
 				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+				(hash_type & ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
 }
 
 static void
-- 
2.41.0


