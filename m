Return-Path: <netdev+bounces-148696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40D9E2E84
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E32166C06
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416320C03F;
	Tue,  3 Dec 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7rsvM6e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772520B809
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262934; cv=none; b=bKbIjuJLXEzImLX4WR9rN8FAXJYzTwZEKAwoj/PT+ozki/f7M/sTkmh7CRLYimYM8qsbWGgsJfouineBk0CAuOob9K5+VVE4THkuer5N6XM4pOUPyI4qR071Os6DmVtZLRfANT5zPKws0/2f7JKyzlxEGcMFpsT8W1zL3RNra+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262934; c=relaxed/simple;
	bh=GOwloZZiQDXi74olsCPHhrNLamregpnqg/ecAoF3+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jsr5U85ibT6NtrcgduUpYKKiu4kaUOSThHYsIzZcNZRSN/0SqMAKtVuRnHGXGE/Uy/D0i4jYG1dk1/VYJSG1c94+YGj9tBBPw5aHhGqT2j/RtYCpIfVTm6Zi7l0eRXci6+4g0md82FxjGIjia2q1D5D62cFyuELuAZKwP27RIwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7rsvM6e; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262933; x=1764798933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GOwloZZiQDXi74olsCPHhrNLamregpnqg/ecAoF3+gg=;
  b=S7rsvM6eYGjRhnycUe1qAs8f+WebVx5qYMVDnkgyhOx0sGJ82A7KvHt7
   c5eRVZq9YwuPVHE1lS9xosm8Fp2bcQlUs5oczbWEudtmJ7vTQbPYqbNoI
   QAU/Msx9+2g6xwDRf4+zK6gydgv5BbzmXUSagOF8cvgbuYpCdIWJj/Nys
   ppeBC9Dq2+cPlS0Sl/2QK9dZREMWw+TIPJJdFnTJrC/xiN5yaVHPMvxVV
   MbYQiSN1HO0vfGhYiYgVXUhNTrL6IYhI+vhAy/NUS7BTkYTHhmcrW+0YZ
   82fSnDgqKOfV9BDCE9PSL1Gu0DON6lSW58dXLpCatW3OOH0TFKODce0Mq
   Q==;
X-CSE-ConnectionGUID: XleZtI6NQOS8ZzeynV0oEQ==
X-CSE-MsgGUID: HwsggqpYS3GEw/DiMJtjjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087132"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087132"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: IUQTCRLcT2aqNusFC38LfQ==
X-CSE-MsgGUID: k21yMxrkQUu5Y4BGCBhpvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578877"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Priya Singh <priyax.singh@intel.com>
Subject: [PATCH net 4/9] ice: Fix VLAN pruning in switchdev mode
Date: Tue,  3 Dec 2024 13:55:13 -0800
Message-ID: <20241203215521.1646668-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

In switchdev mode the uplink VSI should receive all unmatched packets,
including VLANs. Therefore, VLAN pruning should be disabled if uplink is
in switchdev mode. It is already being done in ice_eswitch_setup_env(),
however the addition of ice_up() in commit 44ba608db509 ("ice: do
switchdev slow-path Rx using PF VSI") caused VLAN pruning to be
re-enabled after disabling it.

Add a check to ice_set_vlan_filtering_features() to ensure VLAN
filtering will not be enabled if uplink is in switchdev mode. Note that
ice_is_eswitch_mode_switchdev() is being used instead of
ice_is_switchdev_running(), as the latter would only return true after
the whole switchdev setup completes.

Fixes: 44ba608db509 ("ice: do switchdev slow-path Rx using PF VSI")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Tested-by: Priya Singh <priyax.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1eaa4428fd24..187856d4c79a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6408,10 +6408,12 @@ ice_set_vlan_filtering_features(struct ice_vsi *vsi, netdev_features_t features)
 	int err = 0;
 
 	/* support Single VLAN Mode (SVM) and Double VLAN Mode (DVM) by checking
-	 * if either bit is set
+	 * if either bit is set. In switchdev mode Rx filtering should never be
+	 * enabled.
 	 */
-	if (features &
-	    (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER))
+	if ((features &
+	     (NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_HW_VLAN_STAG_FILTER)) &&
+	     !ice_is_eswitch_mode_switchdev(vsi->back))
 		err = vlan_ops->ena_rx_filtering(vsi);
 	else
 		err = vlan_ops->dis_rx_filtering(vsi);
-- 
2.42.0


