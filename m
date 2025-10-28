Return-Path: <netdev+bounces-233640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD25C16C30
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DF4E37E7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5092D2499;
	Tue, 28 Oct 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYyt7JTg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5502C21D5B0
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683127; cv=none; b=mS42098B+O7i6xani/SoVdaw1mDoLdYbquP4yeGQPuqUGSLquluuoaC3ldT2le3lMflbBvZUi3IaQnCm2sjv0IPhZ7Le/Hck0jde6jd9Sy3uUyWP9YvrNcjv9BilKfQ1eCl315sbBhjcXq5iqr3hcAu7dOYePmWFoUQTlthAzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683127; c=relaxed/simple;
	bh=ICGJyQi8i86kcqEeFdX+NOAD7pp0eIW5mujZI4PNZWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5vSXYeIGixPR1Hd2mTIGg6vzj32NhqsRgk74Bf9ya8ktgeOz3OTMHjjOMkUGAIUf6ua0HHsFsCZAnSRmNUyNv5Ke6RskIfE78V5rncVACytPW/PlyTcxWejUiZ986/6LTBHMXpk08zs10ca7yUbrl8eGjMZLIaGpVMZYF79B48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYyt7JTg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761683126; x=1793219126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ICGJyQi8i86kcqEeFdX+NOAD7pp0eIW5mujZI4PNZWU=;
  b=OYyt7JTgurH1jxNqecOwRFPwQVeDnmyGUnUjTJuEiKdDj8seOsn+rUOE
   9ZkhxlXV/lrfixGgUsHQp0GOlyBPCN9/Jd4EKT+jpjXf0TdIAnsgMnEKh
   JY98JZFhpKykMxSDjT+uFgEdclkUe5vSmKpXIgqv08AHwKPNg91QF68Ga
   JoTEW3C2XPBIGkqd2NexTjCiUJw4zpa0w/rpi4/xS0r4TCNWzxUkGXAK3
   +TxKpSOmG6Kc8lMCDmmBF/N4pvCbYHyIkaU/qG9hleHdCc2b/WQC4YXjU
   I4a6HnKIYAhw3gYpyXjnfwRWk4KDbZd/Qc21Fav9kHAbY7dFgR2hsUKIg
   w==;
X-CSE-ConnectionGUID: 7I0uVmk0S2aIXAmTI64ysg==
X-CSE-MsgGUID: 2sghykWqRNS19x3lQKPSDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62825149"
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="62825149"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 13:25:24 -0700
X-CSE-ConnectionGUID: rrl9ukh8QRWjQXDGv8vdyg==
X-CSE-MsgGUID: LFdo5y1rRh+ZXYYYEHW0AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,262,1754982000"; 
   d="scan'208";a="185790163"
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
	den@valinux.co.jp,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/8] ixgbe: fix memory leak and use-after-free in ixgbe_recovery_probe()
Date: Tue, 28 Oct 2025 13:25:09 -0700
Message-ID: <20251028202515.675129-5-anthony.l.nguyen@intel.com>
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

The error path of ixgbe_recovery_probe() has two memory bugs.

For non-E610 adapters, the function jumps to clean_up_probe without
calling devlink_free(), leaking the devlink instance and its embedded
adapter structure.

For E610 adapters, devlink_free() is called at shutdown_aci, but
clean_up_probe then accesses adapter->state, sometimes triggering
use-after-free because adapter is embedded in devlink. This UAF is
similar to the one recently reported in ixgbe_remove(). (Link)

Fix both issues by moving devlink_free() after adapter->state access,
aligning with the cleanup order in ixgbe_probe().

Link: https://lore.kernel.org/intel-wired-lan/20250828020558.1450422-1-den@valinux.co.jp/
Fixes: 29cb3b8d95c7 ("ixgbe: add E610 implementation of FW recovery mode")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ca1ccc630001..3190ce7e44c7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -11507,10 +11507,10 @@ static int ixgbe_recovery_probe(struct ixgbe_adapter *adapter)
 shutdown_aci:
 	mutex_destroy(&adapter->hw.aci.lock);
 	ixgbe_release_hw_control(adapter);
-	devlink_free(adapter->devlink);
 clean_up_probe:
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
+	devlink_free(adapter->devlink);
 	pci_release_mem_regions(pdev);
 	if (disable_dev)
 		pci_disable_device(pdev);
-- 
2.47.1


