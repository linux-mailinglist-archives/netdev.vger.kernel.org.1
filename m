Return-Path: <netdev+bounces-42807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2D37D033D
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 22:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2F1282297
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464A89472;
	Thu, 19 Oct 2023 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUNzOfuX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED706AB3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 20:40:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A76AA3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697748044; x=1729284044;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kluU1UeCwhjpqbdTJq/CRzLxP2XtfihuKrUmoGqgbf4=;
  b=MUNzOfuXv+VcrTzZOgzZhS1fXpN/o+KaV0mMXmRSUibtWUF+Xb8VXDDG
   4EFF5XHZDV8NYDeFB8Z8AXYxddBWrejES372TbwI5m+FKzpvu4bz7/FPJ
   FVOAes+vx7GzuSSlsjLUmc+UH+aFYvDV5rv6XM3jM+4J6Ly+/uC2WnpAY
   6DHJ28auScxz6wKq0GtKvAoAEQKzBt8KGbslWR73cWIizWOqyXD7nHmkl
   4I6krN6ygN/sDmv0uuIH0eLFyRA9rSPpN9aB8Fzif9jhneOMj6/zJQsO1
   rbW7qlXD5eofs0FWgrV6qTrPHD+TSYWVg7D+3vK1EfnekT8gVYUA1Bn0P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="4970325"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="4970325"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:40:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="822972471"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="822972471"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 13:40:43 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net] igb: Fix potential memory leak in igb_add_ethtool_nfc_entry
Date: Thu, 19 Oct 2023 13:40:35 -0700
Message-ID: <20231019204035.3665021-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Palczewski <mateusz.palczewski@intel.com>

Add check for return of igb_update_ethtool_nfc_entry so that in case
of any potential errors the memory alocated for input will be freed.

Fixes: 0e71def25281 ("igb: add support of RX network flow classification")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index 319ed601eaa1..4ee849985e2b 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2978,11 +2978,15 @@ static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
 	if (err)
 		goto err_out_w_lock;
 
-	igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	err = igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
+	if (err)
+		goto err_out_input_filter;
 
 	spin_unlock(&adapter->nfc_lock);
 	return 0;
 
+err_out_input_filter:
+	igb_erase_filter(adapter, input);
 err_out_w_lock:
 	spin_unlock(&adapter->nfc_lock);
 err_out:

base-commit: ce55c22ec8b223a90ff3e084d842f73cfba35588
-- 
2.41.0


