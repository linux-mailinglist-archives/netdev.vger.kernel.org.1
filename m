Return-Path: <netdev+bounces-99891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C490E8D6DFC
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 07:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C9328379B
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1B0D2FA;
	Sat,  1 Jun 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXN08pqL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52703A94B
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717218368; cv=none; b=FplOJmVLEzZVdHgpdhNhsZoWXdFobwb8pnzdqtRJRI+XImc/sol07ipG3XE2yarlXEKlVxDcCBzjkm9fvg4wG7RIFDjB4srG7HVGqvFWvyqi/0hue0NNpIXJxSGcrXRiSkYatuAfkHatz/4Hn2G6I/GI0Ei6FWsosbHSgn0yXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717218368; c=relaxed/simple;
	bh=5gAAu0+ANjZ2f3aNfH2MIaQStoz7OJBOTF/8vijLQjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPwBHyj0QsrmEPqWx6g2rX2ETkTAmvX5vUyYJb0bCkLemLGeZCMqjc3gAufqbcNDmanAldi59W0z0qlEUUFew29wtg4eE288NWERj+f6wmFxllfP2XkjjC/6TObiSuPf5U6Tnk8uJLq0jOC38k5ONSLKy6mQpUCu7fceXAcGtk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXN08pqL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717218367; x=1748754367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5gAAu0+ANjZ2f3aNfH2MIaQStoz7OJBOTF/8vijLQjk=;
  b=kXN08pqL0iuZ7uQGnz6Rr03ZhFfycuLyOWZ7zlLmjfh76uYtK1mQN/2D
   oGnjH7Tvcx1TyxNhdACUCAOStQsUTMQbECSxEAvUgmmcl+efZJV399aia
   pLZvgWdVXiwicChnkSLt76XyTMTNlob3gVmsqhZGUGjBbQUqvknkUmhDY
   u/V2EZYw3iP3YRXNTzBaDBoo37AjBn6kiV/+4QbM1G2q6NTqNjAWUBT+k
   H+AZo5xBx2kdCyozZ0vYIpuMIbIjvkZjh2E+uOw4mbF8AZc1V0JPK5VR6
   8xxnwOCT/8WjYxig+hOXrqzDUfDUBqQ6OSqM4kjFwhWE8r5OO2Gm0XUsf
   g==;
X-CSE-ConnectionGUID: jkL7FUyfRoeMhbj0wRfA2Q==
X-CSE-MsgGUID: cOaN8WxnTvmGnCwn5sTaKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11089"; a="13617877"
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="13617877"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 22:06:06 -0700
X-CSE-ConnectionGUID: UaZoHNPfQl+7hO4Bkyu/HA==
X-CSE-MsgGUID: lCa6v8GkRrS6YR6RZ4ehKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,206,1712646000"; 
   d="scan'208";a="41286990"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2024 22:06:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CC3CBA1; Sat, 01 Jun 2024 08:06:01 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Corinna Vinschen <vinschen@redhat.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	netdev@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] Revert "igc: fix a log entry using uninitialized netdev"
Date: Sat,  1 Jun 2024 08:06:00 +0300
Message-ID: <20240601050601.1782063-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
References: <20240601050601.1782063-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 86167183a17e03ec77198897975e9fdfbd53cb0b.

The commit in question moved call to igc_ptp_init() to happen after
igc_reset() which calls igc_ptp_reset() with the spinlock not yet
initialized so we get following splat:

 BUG: spinlock bad magic on CPU#4, udevd/249
  lock: 0xffff98f317e6d4b0, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
 CPU: 4 PID: 249 Comm: udevd Not tainted 6.10.0-rc1+ #1312
 Call Trace:
  <TASK>
  dump_stack_lvl+0x6c/0x90
  dump_stack+0x10/0x20
  spin_bug+0x8c/0xc0
  do_raw_spin_lock+0x6c/0xc0
  _raw_spin_lock_irqsave+0x30/0x40
  igc_ptp_clear_tx_tstamp+0x2e/0xc0 [igc]
  igc_ptp_set_timestamp_mode+0x191/0x280 [igc]
  igc_ptp_reset+0x33/0x230 [igc]
  igc_reset+0xba/0x100 [igc]
  igc_probe+0x7d1/0xa10 [igc]

It is likely that there are other things igc_ptp_init() does that are
required by igc_ptp_reset(), so for this reason revert the commit in
question.

Fixes: 86167183a17e ("igc: fix a log entry using uninitialized netdev")
Cc: Corinna Vinschen <vinschen@redhat.com>
Cc: Hariprasad Kelam <hkelam@marvell.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 12f004f46082..ace2fbfd87d6 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7028,6 +7028,8 @@ static int igc_probe(struct pci_dev *pdev,
 	device_set_wakeup_enable(&adapter->pdev->dev,
 				 adapter->flags & IGC_FLAG_WOL_SUPPORTED);
 
+	igc_ptp_init(adapter);
+
 	igc_tsn_clear_schedule(adapter);
 
 	/* reset the hardware with the new settings */
@@ -7049,9 +7051,6 @@ static int igc_probe(struct pci_dev *pdev,
 	/* Check if Media Autosense is enabled */
 	adapter->ei = *ei;
 
-	/* do hw tstamp init after resetting */
-	igc_ptp_init(adapter);
-
 	/* print pcie link status and MAC address */
 	pcie_print_link_status(pdev);
 	netdev_info(netdev, "MAC: %pM\n", netdev->dev_addr);
-- 
2.43.0


