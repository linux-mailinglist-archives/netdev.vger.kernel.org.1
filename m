Return-Path: <netdev+bounces-40186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A587C6125
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925362828B5
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288822B76F;
	Wed, 11 Oct 2023 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nISzVozb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793722B751
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:33:50 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1D9B6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697067229; x=1728603229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XxddgiUZYaLGKapb24U7IedxHY+YMZo8RACpD0zdQY0=;
  b=nISzVozbrFstEDWxj2ACM3aGE7rL4OzScBpDh4CWQwxm4Zv69kkV5hzr
   NUR6AI6OTuXlO2Mb1hMlWh4AhfytY0tO5ULlTiuyQaldmgBaa+/5D/U5x
   kP7+gaV1vG35rUg6/wEzPBPgOvCUc2Dvx6mAYTqlhPZwpt0oj9d43tix2
   Q+98Ng46ZKxrrKI3zdmp3gl9cBbQKxCNEeBprY2KWV5AlrjBJg+FD2TTw
   RFefmgVYgJmRiSmLa6HqNmr5tq7N+mqvgSTv4qfyX7QcumLSGfbMRltOQ
   hfem86tHnoZniGgIYp+AGTreLHe1fMaplkEDilt/3LJBKfxSsFEkHLsi2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="388652591"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="388652591"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="824359295"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="824359295"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:33:46 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/3] ice: Fix safe mode when DDP is missing
Date: Wed, 11 Oct 2023 16:33:34 -0700
Message-ID: <20231011233334.336092-4-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011233334.336092-1-jacob.e.keller@intel.com>
References: <20231011233334.336092-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>

One thing is broken in the safe mode, that is
ice_deinit_features() is being executed even
that ice_init_features() was not causing stack
trace during pci_unregister_driver().

Add check on the top of the function.

Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
Signed-off-by: Mateusz Pacuszka <mateuszx.pacuszka@intel.com>
Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6550c46e4e36..7784135160fd 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4684,6 +4684,9 @@ static void ice_init_features(struct ice_pf *pf)
 
 static void ice_deinit_features(struct ice_pf *pf)
 {
+	if (ice_is_safe_mode(pf))
+		return;
+
 	ice_deinit_lag(pf);
 	if (test_bit(ICE_FLAG_DCB_CAPABLE, pf->flags))
 		ice_cfg_lldp_mib_change(&pf->hw, false);
-- 
2.41.0


