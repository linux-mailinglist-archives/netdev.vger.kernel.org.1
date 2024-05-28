Return-Path: <netdev+bounces-98564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE68D1C81
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4381C21FFE
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808AC17107A;
	Tue, 28 May 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBEJjydp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA9B16FF4B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902134; cv=none; b=R4+WW5+OyPI2lZZD5HpnEYfHJ5nZ6Zgz3/w8Jtveh/u0DZKnemwRok/ixlXuQGKVpY8HSo/n8dGonMSrosPurMNBEtfqJjXzN0/twTXh4oHSK7jIPTHFBfT4/gq6AK8y68BiMgsbvPuk3/ZwjSPLUUssAT9L/ZXwwDPQkSzzpI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902134; c=relaxed/simple;
	bh=89ItfMvWVLYERCZU8akE0pKSpXDzCfiBwTBt6Ag8CQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISkThMEI/I2HQNmJIsvAVhTk5g88ZAXVNf4rT64yxx3sfkmsrD9CBjTXChtZ2a404ievE8ESOf+MMzSan9mIULTIgal+5GSSHyt8yCGFZGJia8g27dN0J85w4AqF+NjjsekShBLYtADwuLTGBdo2FDdMW/lfOi6e2xZZy3PFtN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBEJjydp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716902133; x=1748438133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=89ItfMvWVLYERCZU8akE0pKSpXDzCfiBwTBt6Ag8CQc=;
  b=JBEJjydpatHQM9nsO2r6zQeOI8SqFRkOIeIeM0ndqQrGOUN49TrcDtgx
   vzeIfi36a5SkNRZTsWlwTmuf60fAgdzd2pewaS7w+6HfHN8h4sRX6kPQQ
   8dFqmC84vRXyzhQRiwIK+1ad+bP3LdOQvAXJKd6cm/U1jAzt0PuCKQbv6
   4O78Y377CiS0Aq1EHT372PN801nI5C0F1rrblQZjWNrEfPeLAeZ3FjBmu
   TVIwhmJdSPZGPcMe2SP/CX6yFjKs4aJ5DM9CuWDRVSjv2wqq3w/yB1E1T
   vH4QHtKybK+Qt7hXdDPSTvpswSl8jEy0kxcWztHMsB2h1ztxWMgmZiVbz
   g==;
X-CSE-ConnectionGUID: 6f/z3vc9QiOxoQhz3M1vFw==
X-CSE-MsgGUID: oZ04emfMSX2Vkbyc3Kweow==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13193527"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13193527"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:15:33 -0700
X-CSE-ConnectionGUID: P23Lx7zwSCiMPJNsaDIpfA==
X-CSE-MsgGUID: k41in13cSAmLmizpZxBY9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39891109"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa003.jf.intel.com with ESMTP; 28 May 2024 06:15:31 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 02/11] ice: don't busy wait for Rx queue disable in ice_qp_dis()
Date: Tue, 28 May 2024 15:14:20 +0200
Message-Id: <20240528131429.3012910-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
References: <20240528131429.3012910-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ice driver is spammed with multiple xdpsock instances and flow
control is enabled, there are cases when Rx queue gets stuck and unable
to reflect the disable state in QRX_CTRL register. Similar issue has
previously been addressed in commit 13a6233b033f ("ice: Add support to
enable/disable all Rx queues before waiting").

To workaround this, let us simply not wait for a disabled state as later
patch will make sure that regardless of the encountered error in the
process of disabling a queue pair, the Rx queue will be enabled.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 1bd4b054dd80..4f606a1055b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -199,10 +199,8 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
-	if (err)
-		return err;
 
+	ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
-- 
2.34.1


