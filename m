Return-Path: <netdev+bounces-42755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A953B7D009D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93BF1C20FCB
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C790438BA9;
	Thu, 19 Oct 2023 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lTJhh63+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509C835500
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA4131
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736759; x=1729272759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=huk1XdXaNRLScYQ+i5QuJ4KedRaHYM3Ab4N8g2xl4A0=;
  b=lTJhh63+d1fty9kH/lz4zUiY4owfKJe0Ki8RJivzjDTVMcutuXWZy7Jq
   WH6qxpkoXjiBItNg+NjYm4o4mlSJrY2QnNLay+7gJg2nt60kap2EF7zAV
   GylhX4rcSHZm1SSkCV0mgr2QxMJaYbCcw6q9gMci82t6IVYEf4K/vTwf3
   rPjjJ21n5DjqKHLF7IHeJFVsng+ffW65LLqhSnZxrOXkp0Pnc8j5aAgmO
   XH2NZpTafHq+4ZYVfz9eth3YmS/el7SkiTrLfqDY35zaLz1o67bnX8wX/
   rCDL3vqNSyEGkjM4HyhaqyxQVmNyteWu7uup0isWevMggHXDNEU+Widqg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183720"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183720"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722706"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722706"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 10/11] igb: Fix an end of loop test
Date: Thu, 19 Oct 2023 10:32:26 -0700
Message-ID: <20231019173227.3175575-11-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

When we exit a list_for_each_entry() without hitting a break statement,
the list iterator isn't NULL, it just point to an offset off the
list_head.  In that situation, it wouldn't be too surprising for
entry->free to be true and we end up corrupting memory.

The way to test for these is to just set a flag.

Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index db54453e1946..b2295caa2f0a 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7856,7 +7856,8 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 {
 	struct pci_dev *pdev = adapter->pdev;
 	struct vf_data_storage *vf_data = &adapter->vf_data[vf];
-	struct vf_mac_filter *entry = NULL;
+	struct vf_mac_filter *entry;
+	bool found = false;
 	int ret = 0;
 
 	if ((vf_data->flags & IGB_VF_FLAG_PF_SET_MAC) &&
@@ -7887,11 +7888,13 @@ static int igb_set_vf_mac_filter(struct igb_adapter *adapter, const int vf,
 	case E1000_VF_MAC_FILTER_ADD:
 		/* try to find empty slot in the list */
 		list_for_each_entry(entry, &adapter->vf_macs.l, l) {
-			if (entry->free)
+			if (entry->free) {
+				found = true;
 				break;
+			}
 		}
 
-		if (entry && entry->free) {
+		if (found) {
 			entry->free = false;
 			entry->vf = vf;
 			ether_addr_copy(entry->vf_mac, addr);
-- 
2.41.0


