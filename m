Return-Path: <netdev+bounces-44235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4857D7348
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 20:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C3EB20CF5
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587CA28DD5;
	Wed, 25 Oct 2023 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuyygaAI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE72731A76
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 18:32:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D16E5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 11:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698258740; x=1729794740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QPYtpHswWzDCnJT5vU+9kqca8hSkMJ9H9raf+g6KIHw=;
  b=fuyygaAIi15gWpx3zAQxsNPfqxd16zB90XzkVROdbs3RigSz6oOF5zms
   MAZjtme0HEQmw5YRmmjNlEm1F8nBqA2ogD7P1j/PuKf0GSv3o68B9J9Nu
   7ZI5sK0duPPYjdExbMKsMr4DgG14S4P3r3fLBviVCwABVeFfXaZhWQLMD
   xPHlZf5OclNnLd3AnzH20IJ64CV8QUNlvREgZjHGoEc1i/FxGsOW5oThA
   uShAQuHi8UQDC5Bhg8jTgtNwPdWWq2iC4rzPMfmoLxHE7uazL9IFe6qa6
   P9MdqIza5Oelbpi4uQ/xXIMQe/NWddn+P7b6Jhba07jKXIgsud4fYM5jS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451608759"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="451608759"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882523573"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="882523573"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 11:32:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] iavf: in iavf_down, disable queues when removing the driver
Date: Wed, 25 Oct 2023 11:32:13 -0700
Message-ID: <20231025183213.874283-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

In iavf_down, we're skipping the scheduling of certain operations if
the driver is being removed. However, the IAVF_FLAG_AQ_DISABLE_QUEUES
request must not be skipped in this case, because iavf_close waits
for the transition to the __IAVF_DOWN state, which happens in
iavf_virtchnl_completion after the queues are released.

Without this fix, "rmmod iavf" takes half a second per interface that's
up and prints the "Device resources not yet released" warning.

Fixes: c8de44b577eb ("iavf: do not process adminq tasks when __IAVF_IN_REMOVE_TASK is set")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Tested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 5b5c0525aa13..b3434dbc90d6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1437,9 +1437,9 @@ void iavf_down(struct iavf_adapter *adapter)
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_FDIR_FILTER;
 		if (!list_empty(&adapter->adv_rss_list_head))
 			adapter->aq_required |= IAVF_FLAG_AQ_DEL_ADV_RSS_CFG;
-		adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	}
 
+	adapter->aq_required |= IAVF_FLAG_AQ_DISABLE_QUEUES;
 	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
 }
 

base-commit: 1711435e3e67e079d6a2bce54d96d1af21c7ef2c
-- 
2.41.0


