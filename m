Return-Path: <netdev+bounces-43673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEE67D4310
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39EBC2817B9
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36D624A0B;
	Mon, 23 Oct 2023 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0iY/ZPu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E092420B
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9EEBD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102515; x=1729638515;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ta2z2ahggaWqZCORTwNduUK1b4LdFXFa3CJpHPpWmnY=;
  b=O0iY/ZPu4eNxzihBuERyIpHQXX54mu9VeOLTMuY8WLqIF8lo1+KLDCl2
   dtS24NehFiKTGeGwnwOlj+W0l0gRu4bdqo8HNyBs/Fbx/FSpF+DWVo/sd
   u4jwS9dLZ59jBN1xYKYX3C4AtEyEsn28i9FZzAe3oK8izkycn/9FQDfN3
   NgkV5+176u8HnjQmWwsbMmkG4bnYUOKSO4pAPwbPq+Nih6IC2fJpWlT27
   mTrteR/B1IW6jmpLtlMkEe+dHZ3pzblh2uad5pDqrb6wTHAxyhyl1x95R
   i2AeYl9+Z/87Gr4TjFZU/HfDBRaKjt1ACJHZQ7QsSB2oMdCSvEIQe2Kzl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573715"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573715"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288332"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288332"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 5/9] iavf: fix the waiting time for initial reset
Date: Mon, 23 Oct 2023 16:08:22 -0700
Message-ID: <20231023230826.531858-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023230826.531858-1-jacob.e.keller@intel.com>
References: <20231023230826.531858-1-jacob.e.keller@intel.com>
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
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 7ca19dfea109..36d72f30ffce 100644
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


