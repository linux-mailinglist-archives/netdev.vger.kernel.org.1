Return-Path: <netdev+bounces-97398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 267538CB453
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D31781F22C0A
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF6614901B;
	Tue, 21 May 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1J26NTp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344C4DA0C
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320400; cv=none; b=iHswCWdjP7+PCgOORUqKEHWLFHPOBbi+YRYrspCMOYmlD8R5P09/JVaSNOo9qb8Tz2KxCDOeWDoZDZwgZeT5S0Sr7RozDCGVFQnjth0eiwBNL/FoKs6ROlKQdgvsKaMQGwY8hPWsil0As12QBlznzP4NBzcwA3ScdCfnq/I9WIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320400; c=relaxed/simple;
	bh=WLcFovuUYrlRPU5G5ejcHssvsTh1bsZFa3pLbqJw4XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X3xfS1Ymoj25YYa1ztk03tZ2IzDWASHpGMjct4xk0ALoz2Ezk7dsSkbFsXop558yN1NqBbzrVVFqO1KI4Rv5lmLHsTfSowkx3uEoFtgPkW+T5NdxsxKFhtBJhFzEpq/0qJu/+rIqpAVC+cOk3Xr2en1NPoJAVk0FRIDF8F5dad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1J26NTp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716320399; x=1747856399;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WLcFovuUYrlRPU5G5ejcHssvsTh1bsZFa3pLbqJw4XQ=;
  b=U1J26NTpuaAs00l4R6PPzwfyUsqU7WnCHuP5TAwBnYKrAyMzqmpuGWfO
   jBP4WzHBfmMw4dv4Dg+AxtK1AfMT75sc0ImQu2+i/jTLcLpMzQzHdk7gq
   OiKwKiMcIFvD+g7/yVG0A16bXCF+WR8+QN+tO9Mxu9Id16ORochPNNqje
   XGo+utfRckB0If+TNRpjW7H9v02yjKsMY5Jz6uEN0F/oFZpDYmGGA6Er6
   eOG5IWCEvgIB1J50g4H1hIJJfM3S/Mt5LM7CuDvi/3Sp6s7NEC6+ftxEQ
   SpH/zE8k4hvO0Lom/qV5HjSYRmUQmyebofU8Cly8xs4d/ymXe6JWi8nnF
   A==;
X-CSE-ConnectionGUID: k9Y2Zc4nRRWbn1UgEIzFxQ==
X-CSE-MsgGUID: gf86ttIlQyaNPCc4hwYgMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="35049757"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="35049757"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:56 -0700
X-CSE-ConnectionGUID: dVNvaOhyQP+8ai8q2lSK4g==
X-CSE-MsgGUID: Ubx05yYPSCCu1m/szvGjAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33462478"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 21 May 2024 12:39:53 -0700
Subject: [PATCH net v2 1/2] ice: Interpret .set_channels() input
 differently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-1-7aa39e2e99f1@intel.com>
References: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
In-Reply-To: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
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
Changes since V2
- Remove the unnecessary check for combined_count.
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..62c8205fceba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3593,7 +3593,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3615,22 +3614,8 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EOPNOTSUPP;
 	}
 
-	curr_combined = ice_get_combined_cnt(vsi);
-
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


