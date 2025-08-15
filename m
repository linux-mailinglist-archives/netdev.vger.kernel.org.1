Return-Path: <netdev+bounces-214203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1D6B2874E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5187B5E25FE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174730BF6E;
	Fri, 15 Aug 2025 20:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2gcGGTC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDA12C21D7
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 20:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755290536; cv=none; b=Szc0xob6k03VOt1jaOez63AeI0634B4UPmhSG31kdudGnghgpQX9tJqqGHwuuGXg1JoIE+DomvYdHC6ECV5YPiqcJpg/WBGG3Pn9o4EznKCByBGuycRevRyie/cljRQZ4k59xzRw+OuFrNZPl5199YutMgnI1H4elfdSoqwpH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755290536; c=relaxed/simple;
	bh=XrCiYaEJPP6fVnU4aWJs+xfl+SJ7HjJ/AQb4oHnU9Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq57KroohO30rffPNY1E2AsoB5cZCT6xoZOHs8l0hTwCjrxTJgc9mEqMAg7lPz9X1L8HkoCvgYpNghV0vcUnfikMDgpn7osXR1WZwIgJHOHW/EqJFRFnowAXt8Mr1pcCtYfVCwiWZDDrkJG9mBhnHNcVCOL0ONfuFy7OLBH1I8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2gcGGTC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755290535; x=1786826535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XrCiYaEJPP6fVnU4aWJs+xfl+SJ7HjJ/AQb4oHnU9Zs=;
  b=B2gcGGTC87NrN2JvoEQI0G6w/e/GJK7s95Hf6GEZrTpPH7jWqQY3zgsy
   RhUl64xA9xRxshby4IIvrXELRvNz/CDa/LRHqRXfwvtQzmzORKZSWWgb1
   +tl7bRwAYbtzn9BoSeOnA6/mdP6/yMWu6swDr+9kFAxT84Hng2xS7cFVt
   x/4OS9Nfkx+O+LDrNWjWy25svrnjL4MyorDmScOMfvUaHqvPnKmnSDltY
   R+Xf0SJmLILjRxAHeKlJEmDCCE9VkUGgpODIhzpjWTh2+5M/awuE/kBr3
   5H4TckdfrU7KgFt3H8N+Lu98mC4UFdec0sqZEHRUhFQ6tX61vRyrgrAEp
   A==;
X-CSE-ConnectionGUID: T5nM/CY+QkGae7kw82Ws0Q==
X-CSE-MsgGUID: zT3C9KT1T76Pjd2XMxyOJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="68320341"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="68320341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:42:11 -0700
X-CSE-ConnectionGUID: mNaYuJ93RqiJTVQkPEiiDw==
X-CSE-MsgGUID: ZrQZ4OUDQluTdSe7QxwjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="198084329"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 15 Aug 2025 13:42:11 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: ValdikSS <iam@valdikss.org.ru>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 6/6] igc: fix disabling L1.2 PCI-E link substate on I226 on init
Date: Fri, 15 Aug 2025 13:42:02 -0700
Message-ID: <20250815204205.1407768-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
References: <20250815204205.1407768-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ValdikSS <iam@valdikss.org.ru>

Device ID comparison in igc_is_device_id_i226 is performed before
the ID is set, resulting in always failing check on init.

Before the patch:
* L1.2 is not disabled on init
* L1.2 is properly disabled after suspend-resume cycle

With the patch:
* L1.2 is properly disabled both on init and after suspend-resume

How to test:
Connect to the 1G link with 300+ mbit/s Internet speed, and run
the download speed test, such as:

    curl -o /dev/null http://speedtest.selectel.ru/1GB

Without L1.2 disabled, the speed would be no more than ~200 mbit/s.
With L1.2 disabled, the speed would reach 1 gbit/s.
Note: it's required that the latency between your host and the remote
be around 3-5 ms, the test inside LAN (<1 ms latency) won't trigger the
issue.

Link: https://lore.kernel.org/intel-wired-lan/15248b4f-3271-42dd-8e35-02bfc92b25e1@intel.com
Fixes: 0325143b59c6 ("igc: disable L1.2 PCI-E link substate to avoid performance issue")
Signed-off-by: ValdikSS <iam@valdikss.org.ru>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 458e5eaa92e5..e79b14d50b24 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7149,6 +7149,13 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->port_num = hw->bus.func;
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
+	/* PCI config space info */
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->revision_id = pdev->revision;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_device_id = pdev->subsystem_device;
+
 	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
@@ -7175,13 +7182,6 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);
 
-	/* PCI config space info */
-	hw->vendor_id = pdev->vendor;
-	hw->device_id = pdev->device;
-	hw->revision_id = pdev->revision;
-	hw->subsystem_vendor_id = pdev->subsystem_vendor;
-	hw->subsystem_device_id = pdev->subsystem_device;
-
 	/* Copy the default MAC and PHY function pointers */
 	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
 	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
-- 
2.47.1


