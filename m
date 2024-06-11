Return-Path: <netdev+bounces-102651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0622C90413A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B741C235BC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70833D556;
	Tue, 11 Jun 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hhWVrtk+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3307B50276
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123108; cv=none; b=Dgz/epE1UP5ZMBNWjvo/RMuLzlIw1A0Gs8O0mpLrn+LPqXMZLRN4cj1iikPjmo4fS/hK9HBUclqw/4H4SDP9A4LC7yEic84d+F5MtdIwNrGRzyB4RPZZjw2n2vl/dEry0gmn8mat62iAAWQBrmfbCloLKSpp1UEmQ4Vq4LoCPBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123108; c=relaxed/simple;
	bh=PmopmNKaA3zDnT8FnUSeCEe8S2rvk5gsVimxp5Tt66Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FL0sz5ajl+bjnzWQjrOgwPlBWhWzHsADGzU/ymgbkf6ON84k+5ITkwskjLasH7mOnCdCLUxSw4hjRMMQjDeuprlC6R5uLayWVtlH4as7CKZm2uH3dkO5P6PZT2qXmJQ9O9bHVzhz/OXsIDJxgp5eG5IAseoWEiF6V3qVN6VLs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hhWVrtk+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718123108; x=1749659108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PmopmNKaA3zDnT8FnUSeCEe8S2rvk5gsVimxp5Tt66Q=;
  b=hhWVrtk+5wwCkZhWXH1O90vmGvZjGddj0yAL4Y0YT7D7ccg/8Ga81f8X
   Z4aKT6yVFJGiCEzsRSAgR9st11KXOnX39qvZA92HGvtAGrvXgQcJyfyfR
   ESrtOYRE15OCI25GnLMj9GwZXx3UimaotJwSYIIrFbBsuaW07Tfmevfym
   74rpf+AX9G6w5EuSS1L1bt2q1EyuafQtyaEPAjVJYNvn44gT5Sr84M9d7
   rhh589jODLUl53PGNlW64c0uHYwIuJ15nMI5OXuisZQMGzWxZL2Gy3gGr
   lt3pWt2OAuMLzdQN9qwpT6JZJ7Qj5OLDYaLBXSlv+aWn2iy2DxHnConl3
   g==;
X-CSE-ConnectionGUID: m96jFs8GQ6KG8F2fUuoBgQ==
X-CSE-MsgGUID: B1o8lixJQNmRoQxVW8rhRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="14803767"
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="14803767"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 09:25:00 -0700
X-CSE-ConnectionGUID: eM1YHYkQQMq78e4yoTHWbw==
X-CSE-MsgGUID: 6dZdt5PvQkykMSbXeDlrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,230,1712646000"; 
   d="scan'208";a="39413615"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Jun 2024 09:24:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	vinschen@redhat.com,
	vinicius.gomes@intel.com,
	hkelam@marvell.com,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net] Revert "igc: fix a log entry using uninitialized netdev"
Date: Tue, 11 Jun 2024 09:24:55 -0700
Message-ID: <20240611162456.961631-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

This reverts commit 86167183a17e03ec77198897975e9fdfbd53cb0b.

igc_ptp_init() needs to be called before igc_reset(), otherwise kernel
crash could be observed. Following the corresponding discussion [1] and
[2] revert this commit.

Link: https://lore.kernel.org/all/8fb634f8-7330-4cf4-a8ce-485af9c0a61a@intel.com/ [1]
Link: https://lore.kernel.org/all/87o78rmkhu.fsf@intel.com/ [2]
Fixes: 86167183a17e ("igc: fix a log entry using uninitialized netdev")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 305e05294a26..87b655b839c1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7032,6 +7032,8 @@ static int igc_probe(struct pci_dev *pdev,
 	device_set_wakeup_enable(&adapter->pdev->dev,
 				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
 
+	igc_ptp_init(adapter);
+
 	igc_tsn_clear_schedule(adapter);
 
 	/* reset the hardware with the new settings */
@@ -7053,9 +7055,6 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Check if Media Autosense is enabled */
 	adapter->ei = *ei;
 
-	/* do hw tstamp init after resetting */
-	igc_ptp_init(adapter);
-
 	/* print pcie link status and MAC address */
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
-- 
2.41.0


