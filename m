Return-Path: <netdev+bounces-84614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AFF8979B1
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5F4E28D627
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F6155A37;
	Wed,  3 Apr 2024 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9Q+8Tyj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F246155736
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712175580; cv=none; b=HBz61ZgRiwAdFir137e9PJt5EKHzqDLrUuIqFXBeo5kEQT2Aail/+Y1e7VWI64VtMZD5a/0iNiXjcXtXzZ6l8unGA4CKcdWDPFVErcwnAZckLKlS4ay8n+Shxe1pMapGFV2gP22SO4oabrA3rjcJVaG6IkcuUeHdqDkpxhj1luc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712175580; c=relaxed/simple;
	bh=bS7rex4W7tlbbeK1bDoaJcv/idXY63ZTKx6KFRI0KvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkOfP1lv65/iE+Omg2E1VMoys9TxF7BytAIrxd9UTKg5zmk7oDnQvUEWnq8SAlTvhLdxUNObt/Zu5b//tDkwx+Vh8ixax1CY8151WCva1nIt7+cGbXer0zxhJWhsjI8NJrCVabPTSVyqvRyjrMaX6vmRRkg9harvNSDaEAFC66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9Q+8Tyj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712175579; x=1743711579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bS7rex4W7tlbbeK1bDoaJcv/idXY63ZTKx6KFRI0KvA=;
  b=h9Q+8TyjAyHx4p0zpqHEQkLmpP2ib0rmCmzGD/pNzh2P3K5SseNBBuxQ
   +kW5zDfPA3Ls4/POfdx7N20vAv9ruWZ+ZxjM/qTPckf5lQOh4FMcCCGC1
   fjCt+ul1EdNH7sI8kw9TmU0fVUg6xoZ5hDrNPdrh/SOJF3GgLJ3xzkwf1
   nMzO6evjjgAhMw2lGjkoUBVzWPw1+CSotQhBKeegd1UDxmBJfL/CnLQKM
   IWbKcMKm8b64uQ4S6+NKt++RbfvvJk0RC92/gXyFiKsDWsw+j4/v3Pxni
   1u+hiYFDAK+7SnCf5xIj+nrqibqdwwG8z5pZVxBtZHaqrbpAF1GmHBtw9
   g==;
X-CSE-ConnectionGUID: 5bugoiZEQ0il510pfJGZJw==
X-CSE-MsgGUID: 0opeHxvKSPG697ruNATLYQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="18165800"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18165800"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 13:19:37 -0700
X-CSE-ConnectionGUID: Wlx5iEguQDiWTHJ+ap12SQ==
X-CSE-MsgGUID: 9AdsrIOdR6WHiKASHfR1kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18662691"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Apr 2024 13:19:36 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	anthony.l.nguyen@intel.com,
	Jiri Pirko <jiri@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/3] ice: Fix freeing uninitialized pointers
Date: Wed,  3 Apr 2024 13:19:26 -0700
Message-ID: <20240403201929.1945116-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
References: <20240403201929.1945116-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

Automatically cleaned up pointers need to be initialized before exiting
their scope.  In this case, they need to be initialized to NULL before
any return statement.

Fixes: 90f821d72e11 ("ice: avoid unnecessary devm_ usage")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  | 10 +++++-----
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index db4b2844e1f7..d9f6cc71d900 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1002,8 +1002,8 @@ static void ice_get_itr_intrl_gran(struct ice_hw *hw)
  */
 int ice_init_hw(struct ice_hw *hw)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
-	void *mac_buf __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
+	void *mac_buf __free(kfree) = NULL;
 	u16 mac_buf_len;
 	int status;
 
@@ -3272,7 +3272,7 @@ int ice_update_link_info(struct ice_port_info *pi)
 		return status;
 
 	if (li->link_info & ICE_AQ_MEDIA_AVAILABLE) {
-		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+		struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 
 		pcaps = kzalloc(sizeof(*pcaps), GFP_KERNEL);
 		if (!pcaps)
@@ -3420,7 +3420,7 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 int
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
 	struct ice_hw *hw;
 	int status;
@@ -3561,7 +3561,7 @@ int
 ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 		enum ice_fec_mode fec)
 {
-	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree);
+	struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL;
 	struct ice_hw *hw;
 	int status;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 255a9c8151b4..78b833b3e1d7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -941,11 +941,11 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *orig_vsi = np->vsi, *test_vsi;
 	struct ice_pf *pf = orig_vsi->back;
+	u8 *tx_frame __free(kfree) = NULL;
 	u8 broadcast[ETH_ALEN], ret = 0;
 	int num_frames, valid_frames;
 	struct ice_tx_ring *tx_ring;
 	struct ice_rx_ring *rx_ring;
-	u8 *tx_frame __free(kfree);
 	int i;
 
 	netdev_info(netdev, "loopback test\n");
-- 
2.41.0


