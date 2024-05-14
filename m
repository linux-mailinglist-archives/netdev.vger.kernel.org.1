Return-Path: <netdev+bounces-96421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B329D8C5B60
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 20:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5C71F2207B
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622A180A96;
	Tue, 14 May 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4V6O5u0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B3853E15
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715712696; cv=none; b=B9kuKOzsgwcP9UUm73NOIum8DEMnARXtfimyDX/I71ZG/66b7NccCQgmCk+0oj1WMN/iqYmSMmYy8Q6iP8GvvjYAZ3q4qv48R8vJSzvEIUeXqVTXWhNXERRlP2jISk5SSODJypkHspLhxuSqo1cTWSz0JNMw/aT4AqKfMMG7Hl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715712696; c=relaxed/simple;
	bh=D5/zN8YLi/PiY6kbQzt+q34RY+Y+SbRocUFYYp2QhhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GT/StVMe/ceqVph+e/rt22HRMv4j6YnOL5bKDYQ77nfYr3A/nXZaJMFAi96oX3OWaCqM3DCQ4XXidSCeaeXOdLbxN9LcBYPKPzVGfjWLLb3DAQnzWFNlTeI5B8k2J/jFHBMX37Mc46wIiPD5ZRKi1ok7ugTPfyJeamsus5AtWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4V6O5u0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715712695; x=1747248695;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=D5/zN8YLi/PiY6kbQzt+q34RY+Y+SbRocUFYYp2QhhE=;
  b=F4V6O5u0DhkKT9mim/sO+ovre0iIJ/OOQCK9I/uSDFSJzA/2/tmwvd2G
   wGGdu+wRuUL9/Hz+8ITweWE8ZEOsbWmkyWbn8aizDsgzZbJWFhq4MENAB
   kbONChQ+mIfa+es3jRj8ya56Eu/tLc2RsFKquid/XumklBAXClY+oDt72
   nR8WYwaWGJQ91GBcerwGo7wP/knSt8P9UoUVhZLsi84egfF7sQDqcsSw2
   I/PIq36maFUb5e5uZiBlfzG5kC7ug5aDCphQutuIR22v1rZg6ZHnZUSpz
   AkyOEdaOicYzx2pzeJPO4/4L6WHHQoEL4nHTm5Lc0x/qyhodV5eEeKNGM
   A==;
X-CSE-ConnectionGUID: tY2aSN8BQeeif+8KO7d1Bw==
X-CSE-MsgGUID: /KpU/4YKR4qro8UBhWw6rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29240326"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="29240326"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:31 -0700
X-CSE-ConnectionGUID: K43hFJwJRL6P6u0E4m0B3A==
X-CSE-MsgGUID: Kf9/71fgTKCkprem4SyTbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30789937"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 11:51:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 May 2024 11:51:12 -0700
Subject: [PATCH net 1/2] ice: Interpret .set_channels() input differently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-1-eb18d88e30c3@intel.com>
References: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
In-Reply-To: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
To: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

A bug occurs because a safety check guarding AF_XDP-related queues in
ethnl_set_channels(), does not trigger. This happens, because kernel and
ice driver interpret the ethtool command differently.

How the bug occurs:
1. ethtool -l <IFNAME> -> combined: 40
2. Attach AF_XDP to queue 30
3. ethtool -L <IFNAME> rx 15 tx 15
   combined number is not specified, so command becomes {rx_count = 15,
   tx_count = 15, combined_count = 40}.
4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
   new (combined_count + rx_count) to the old one, so from 55 to 40, check
   does not trigger.
5. ice interprets `rx 15 tx 15` as 15 combined channels and deletes the
   queue that AF_XDP is attached to.

Interpret the command in a way that is more consistent with ethtool
manual [0] (--show-channels and --set-channels).

Considering that in the ice driver only the difference between RX and TX
queues forms dedicated channels, change the correct way to set number of
channels to:

ethtool -L <IFNAME> combined 10 /* For symmetric queues */
ethtool -L <IFNAME> combined 8 tx 2 rx 0 /* For asymmetric queues */

[0] https://man7.org/linux/man-pages/man8/ethtool.8.html

Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..d91f41f61bce 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3593,7 +3593,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3615,22 +3614,13 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EOPNOTSUPP;
 	}
 
-	curr_combined = ice_get_combined_cnt(vsi);
+	if (!ch->combined_count) {
+		netdev_err(dev, "Please specify at least 1 combined channel\n");
+		return -EINVAL;
+	}
 
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->rx_count == vsi->num_rxq - curr_combined)
-		ch->rx_count = 0;
-	if (ch->tx_count == vsi->num_txq - curr_combined)
-		ch->tx_count = 0;
-	if (ch->combined_count == curr_combined)
-		ch->combined_count = 0;
-
-	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
-		netdev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(dev, "Dedicated RX or TX channels cannot be used simultaneously\n");
 		return -EINVAL;
 	}
 

-- 
2.44.0.53.g0f9d4d28b7e6


