Return-Path: <netdev+bounces-43651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7F07D41A3
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92301C20862
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75791BDCF;
	Mon, 23 Oct 2023 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTb8X8oz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBE12B61
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 21:27:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E853BD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698096443; x=1729632443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DP+kkocMxKT0UMbkiQI+qDDP4ovly/AV2nGGT4tDRhA=;
  b=LTb8X8ozgczbcnW23yYR1AY0uxi8G6cphyUiPkDPMD8uKb58ZzLCDcfz
   YGe+WoSnzuWAfj9TH2MWUJe8IY//5Ss3jRKO0ZqrTiVzC3834//s3blzD
   UQPS6V1fL6tlB+HuBfPM5jGAt+b7rXlFGje3/nNj+tDpQz/Nc2b/LWRgM
   /W86m3c2IusQcuCY89OdjfA+8q6t6RkaqPBdUaoKJK0AHxL3P+ugFZp0y
   2E1q55qIeE4zIe3VQPcP41M2MJXvX2GmLuZAKCURga3n06sq2gEP8qyWy
   yIHqtCN91nIinYiiCogsrWETOLGoR4ndIWN+WojWU3ZqZfD7MUw3P2Hjr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386742183"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386742183"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 14:27:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758256140"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758256140"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 14:27:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] i40e: Fix wrong check for I40E_TXR_FLAGS_WB_ON_ITR
Date: Mon, 23 Oct 2023 14:27:14 -0700
Message-ID: <20231023212714.178032-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

The I40E_TXR_FLAGS_WB_ON_ITR is i40e_ring flag and not i40e_pf one.

Fixes: 8e0764b4d6be42 ("i40e/i40evf: Add support for writeback on ITR feature for X722")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 50c70a8e470a..b047c587629b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2854,7 +2854,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return budget;
 	}
 
-	if (vsi->back->flags & I40E_TXR_FLAGS_WB_ON_ITR)
+	if (q_vector->tx.ring[0].flags & I40E_TXR_FLAGS_WB_ON_ITR)
 		q_vector->arm_wb_state = false;
 
 	/* Exit the polling mode, but don't re-enable interrupts if stack might

base-commit: 7798b59409c345d4a6034a4326bceb9f7e2e8b58
-- 
2.41.0


