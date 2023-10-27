Return-Path: <netdev+bounces-44817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1B17D9F34
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD17282536
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12B03C061;
	Fri, 27 Oct 2023 17:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St3P2fOL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06693B785
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15F01A5
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429593; x=1729965593;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ir08uo9SW9kokMcyTho84WTzk/Ia10XKTggy3D9IBVE=;
  b=St3P2fOL2Fvtb8jDuk6GgArguBiMjRujhCpDR/ujZGtoyn7arsqWbgSz
   JrDrvt8r+xCLUX0td6WROVYJCmGoY71U2gkF2z1d3Ku1+YnXOeBKip9nc
   imfylob97ko1Nau/M9wGZY/vulwg6OhHq7lpRbwiXDokNgymLNShMlV1e
   4PpzrHtYrBBeaNo5sWeKAsklCpDYL9i72pYZkQzFaoXBPHcH2Rh7FxpIU
   iqzrZ3ihgsC9l5fPG0W5nSXOvdl8dJTA4rjAtxdSnWMVhroYusNf2mCFS
   r3UknTOKHHYMsW7dMDeF2dxORabNAJMLR3VTp/NHFf8thBa8yPtdRwiEo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695517"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695517"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064627"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064627"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:48 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 4/8] iavf: fix the waiting time for initial reset
Date: Fri, 27 Oct 2023 10:59:37 -0700
Message-ID: <20231027175941.1340255-5-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231027175941.1340255-1-jacob.e.keller@intel.com>
References: <20231027175941.1340255-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

Every time I create VFs on ice, I receive at least one "Device is still
in reset (-16), retrying" message per VF. It recovers fine, but typical
usecases should not trigger scary-looking messages.

The waiting for reset is too short. It makes no sense to check every 10
microseconds. Typical reset waiting times are at least tens of
milliseconds and can be several seconds. I suspect the polling interval
was meant to be 10 milliseconds all along.

IAVF_RESET_WAIT_COMPLETE_COUNT is defined as 2000, so the total waiting
time could be over 20 seconds. I have seen resets take 5 seconds (with
128 VFs on ice).

The added benefit of not triggering the "Device is still in reset" path
is that we avoid going through the __IAVF_INIT_FAILED state, which would
take a full second before retrying.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 38432455fe9e..e87213687027 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4786,7 +4786,7 @@ static int iavf_check_reset_complete(struct iavf_hw *hw)
 		if ((rstat == VIRTCHNL_VFR_VFACTIVE) ||
 		    (rstat == VIRTCHNL_VFR_COMPLETED))
 			return 0;
-		usleep_range(10, 20);
+		msleep(IAVF_RESET_WAIT_MS);
 	}
 	return -EBUSY;
 }
-- 
2.41.0


