Return-Path: <netdev+bounces-43675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392507D4311
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD481C20B14
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C2C24204;
	Mon, 23 Oct 2023 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pui0YzXD"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8D2421E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 23:08:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666F8D6E
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698102516; x=1729638516;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+IvLBFTx9Y10ungrNTaCdjXfIxUUYLLNr/rY0oOA0k=;
  b=Pui0YzXDqP+2Wr7hdDNGgOX4ZyxJ0uxs0nM79NHXdzPu9/lDDBBxrSYG
   OsTRafYdNv5WJrCfMBbam8SCVk52ZKRNdV7DTaO7yEkeaPl31gnuMy/Ne
   4LXRSnoQF132tg3MXucv/8em6a29bP7REem+KYAy3OrlD3A6juCIqeUuU
   oeGwJTGdJmtoxTZNNWUhhuHzKBNbTVk3HpZOxarTCYrwOxu8rEruaoSmO
   Zm2Fe/4aIBUtWup9SxH8E5eLSJKVUvzftaoP24kcQM1JtxTvLv8BJTFAK
   KmSYqqh+AJsuW6n35vi+rj30o+1n6qGooVNAlAonfxAFO7esah3Jf6CkL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5573723"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="5573723"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793288338"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="793288338"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 16:08:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 7/9] iavf: use unregister_netdev
Date: Mon, 23 Oct 2023 16:08:24 -0700
Message-ID: <20231023230826.531858-9-jacob.e.keller@intel.com>
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

Use unregister_netdev, which takes rtnl_lock for us. We don't have to
check the reg_state under rtnl_lock. There's nothing to race with. We
have just cancelled the finish_config work.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 6e93e73385b3..85252b9dce50 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5166,10 +5166,8 @@ static void iavf_remove(struct pci_dev *pdev)
 	cancel_delayed_work_sync(&adapter->watchdog_task);
 	cancel_work_sync(&adapter->finish_config);
 
-	rtnl_lock();
 	if (netdev->reg_state == NETREG_REGISTERED)
-		unregister_netdevice(netdev);
-	rtnl_unlock();
+		unregister_netdev(netdev);
 
 	if (CLIENT_ALLOWED(adapter)) {
 		err = iavf_lan_del_device(adapter);
-- 
2.41.0


