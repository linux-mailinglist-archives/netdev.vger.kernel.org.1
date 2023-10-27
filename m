Return-Path: <netdev+bounces-44820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB27D9F39
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF4EB282443
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 18:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F143C681;
	Fri, 27 Oct 2023 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO4Dr28W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B53B792
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:59:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFE61A7
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698429594; x=1729965594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bG9N7452IZvXmdqMkgWGoNqE8MGmKDpbJvIF3iN5LTg=;
  b=lO4Dr28Wv2IbALnlHV0IXhWeaXH71xJ4LfDOqhSzP5tEVD9lAkiif3B5
   LZaILvy4dTRSjMOh65hdnyiUOED6XSO+xYjwMSI6L6T09YrH1Tl2qVNp/
   Joer2wvYbzU25r8JLBPesm7F63p7inwAqnW/dP+UGE//XDI/Y5Czgnsyn
   Ag1hbzVy0AH9XvXUIuSPFs3Yt1m6NAwLxyTYzS/UcYiN37v0GuKQ1J5JO
   yrDLnkXHU3R75ZYDLGEc363kyGhKtZWxWKgRSYx7snpQMIuus9OrhfDwV
   Um1zwc2pBjtAJn9gPWNSgX23U0W2//OaNtwB/G3QFVdKE7zqFUUT/O2o2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="391695527"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="391695527"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="830064634"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="830064634"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 10:59:48 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v2 6/8] iavf: use unregister_netdev
Date: Fri, 27 Oct 2023 10:59:39 -0700
Message-ID: <20231027175941.1340255-7-jacob.e.keller@intel.com>
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

Use unregister_netdev, which takes rtnl_lock for us. We don't have to
check the reg_state under rtnl_lock. There's nothing to race with. We
have just cancelled the finish_config work.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
No changes since v1.

 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index b6fe42547cc3..8a7edeb8f12c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5167,10 +5167,8 @@ static void iavf_remove(struct pci_dev *pdev)
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


