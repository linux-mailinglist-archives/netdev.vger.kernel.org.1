Return-Path: <netdev+bounces-233641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B059C16C28
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B11401A1E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A622D3EC1;
	Tue, 28 Oct 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABsZ7K51"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E252C1587
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683128; cv=none; b=Tk8eyyusJrxiMEmClXb7dKFKirqFEm8TPpRdoVIGmFfRus8kYXTXOJk3f1+sTvdM/Brgr8OfFOGWOcdI9mSGreFouVOPNng6abU3m9H7ou5frc5RBqZ/Impw0/9xDZ+LFRdjuQ83sUKokOclWet7zUjtOwIEIng6xk7afq1iEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683128; c=relaxed/simple;
	bh=myDdPJX7mGmUumuRfdhH5xeyOpdVx2rVvMAQuopZihw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJT7xt2KTTQR5LchKEoYCkCghdXtqsNfAGRoFw+tBbT/fJ0VY9IXVIWz/V5otm1ddCSA5uwQqv5NQA7Pk3CKUGRgbA1J9sDvbiay+TisytNWKfidm787WfH9z2x7NXUww55klduorH3ethJqXyHnw9pw6TtvTUzCCA86flC91/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABsZ7K51; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683126; x=1793219126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=myDdPJX7mGmUumuRfdhH5xeyOpdVx2rVvMAQuopZihw=;
  b=ABsZ7K515iZ1JFxhwYvYFsEEo7A7Slpj9lBwCRpbVf7uj+ewKVNmnoZq
   yazSBsRz4eE4FlrIGh6+GZbaOy42fTY5gh//Lf3Ekzq6DMLpV6+h85jMV
   plkUaGxcf14IDV5PQkg9vHTe1WsIKc7xIcy/UAp9TtrTW48Oic2gO2mGM
   hK4PsbPtW7/CA4uysNtXExI6PywrseVkEL4mjO+PZYoudLUr1KuDyr3FN
   HR6x8PpQbsVlAPHPvZO7r0NZpEGtXf1zH+yHqP2o5HIjnH2UdRKRWTqqT
   r8u8Luzj9Z0j1yDM+/zepdoEkZaRQ/cdbN8xDt773UGLyfqkAHPALiSaU
   g==;
X-CSE-ConnectionGUID: NewTeVgORcm/KFFKKDtKOA==
X-CSE-MsgGUID: wNr4knTlQve3qGBcBssVYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825150"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825150"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:25 -0700
X-CSE-ConnectionGUID: c28FJIFRSLKFY2d5ivBNqQ==
X-CSE-MsgGUID: ry9cyPtAStmTbaV22lQNvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790168"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 28 Oct 2025 13:25:24 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 5/8] igc: power up the PHY before the link test
Date: Tue, 28 Oct 2025 13:25:10 -0700
Message-ID: <20251028202515.675129-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
References: <20251028202515.675129-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

The current implementation of the igc driver doesn't power up the PHY
before the link test in igc_ethtool_diag_test(), causing the link test
to always report FAIL when admin state is down and the PHY is
consequently powered down.

To test the link state regardless of admin state, power up the PHY
before the link test in the offline test path. After the link test, the
original PHY state is restored by igc_reset(), so additional code which
explicitly restores the original state is not necessary.

Note that this change is applied only for the offline test path. This is
because in the online path we shouldn't interrupt normal networking
operation and powering up the PHY and restoring the original state would
interrupt that.

This implementation also uses igc_power_up_phy_copper() without checking
the media type, since igc devices are currently only copper devices and
the function is called in other places without checking the media type.

Furthermore, the powering up is on a best-effort basis, that is, we
don't handle failures of powering up (e.g. bus error) and just let the
test report FAIL.

Tested on Intel Corporation Ethernet Controller I226-V (rev 04) with
cable connected and link available.

Set device down and do ethtool test.
  # ip link set dev enp0s5 down

Without patch:
  # ethtool --test enp0s5
  The test result is FAIL
  The test extra info:
  Register test  (offline)         0
  Eeprom test    (offline)         0
  Interrupt test (offline)         0
  Loopback test  (offline)         0
  Link test   (on/offline)         1

With patch:
  # ethtool --test enp0s5
  The test result is PASS
  The test extra info:
  Register test  (offline)         0
  Eeprom test    (offline)         0
  Interrupt test (offline)         0
  Loopback test  (offline)         0
  Link test   (on/offline)         0

Fixes: f026d8ca2904 ("igc: add support to eeprom, registers and link self-tests")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index f3e7218ba6f3..ca93629b1d3a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2094,6 +2094,9 @@ static void igc_ethtool_diag_test(struct net_device *netdev,
 		netdev_info(adapter->netdev, "Offline testing starting");
 		set_bit(__IGC_TESTING, &adapter->state);
 
+		/* power up PHY for link test */
+		igc_power_up_phy_copper(&adapter->hw);
+
 		/* Link test performed before hardware reset so autoneg doesn't
 		 * interfere with test result
 		 */
-- 
2.47.1


