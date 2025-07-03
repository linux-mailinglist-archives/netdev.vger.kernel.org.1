Return-Path: <netdev+bounces-203898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AFAF7F4F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E16D4E7CB9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9EB2F2C4C;
	Thu,  3 Jul 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuZ1ZzAb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EAE2F272C
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564575; cv=none; b=Gss/McuE1SbXVUKqt9jgGwo6tddzEHhB31TigDDfCGSi+WGEl8Bg7xU87j0zI2+PNI8Eop82RDGV4lbaIeenjXWmIQnrg9q98kUvvbyX8x66wb3j7Tn7UfJLdSFFiOIr+3oDPJsPxM2yTktqmNEiKXCEf8BzIEzR95Icryfbdc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564575; c=relaxed/simple;
	bh=xjK2LT68NYxgJdLeYstzsBd7nEcNvAR3WTZWKfhi6PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSuJ4V/mZvUOc6DQk0Kar5krYIZhSn4w+K/7pd9hD7s8VMXBsREP5G04bXjwvZPF8IBEIr6ZPCsH5RPYLekB691+imP1Md1onM3v0hNbWVE761ml9BRiY2BvqZ04aIl0wEvnmqwcuaSjhD+7EKMoU5ILV7Wb7qVY8bxWVNXTBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cuZ1ZzAb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564574; x=1783100574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xjK2LT68NYxgJdLeYstzsBd7nEcNvAR3WTZWKfhi6PM=;
  b=cuZ1ZzAbDdFFpAm2mPW30zBFyavjjuDqNlr25egSbQ+4ZWJImlhkZe1n
   B8iz6jhVg5mtTwB34TJgwEsA442XGICcKlIynMSNj+uQ1JpGL/PBL7NSi
   h7SJd64Sn8S38KuqR20GQxiiwwbDjpQEj50gmW6JGIeF+1np8x1WeWIUr
   ArYpIiEPjvPp4OgLhvu11a9wxPBxVJD9ikhOp+ob3ftEtuQI/l6ppDBz9
   zo7RwBvpmz/NBX2XeseHZhHxhtQc1CcwIIAmsyKrL/rksNqP0pERgljrS
   xDEvX/ucpzHFChotODR/rRKWmEVLxBetcTW5oV74g1KBqX44yK3pn17Vo
   w==;
X-CSE-ConnectionGUID: e707m0fsTVmp4KI2LBddQw==
X-CSE-MsgGUID: ruBr/yZeT0CqelMdIaWGww==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767957"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:52 -0700
X-CSE-ConnectionGUID: RxBi76aYRo+94ftIXXIYIw==
X-CSE-MsgGUID: IKnyhHZ/Tc+jQeLTyZkZ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997921"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Radoslaw Tyl <radoslawx.tyl@intel.com>,
	anthony.l.nguyen@intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@intel.com,
	piotr.kwapulinski@intel.com,
	marcin.szycik@linux.intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 09/12] ixgbe: turn off MDD while modifying SRRCTL
Date: Thu,  3 Jul 2025 10:42:36 -0700
Message-ID: <20250703174242.3829277-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
References: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

Modifying SRRCTL register can generate MDD event.

Turn MDD off during SRRCTL register write to prevent generating MDD.

Fix RCT in ixgbe_set_rx_drop_en().

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index f1c51ddbaf9e..4f2d7f6e3faa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4104,8 +4104,12 @@ void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 #endif
 {
-	int i;
 	bool pfc_en = adapter->dcb_cfg.pfc_mode_enable;
+	struct ixgbe_hw *hw = &adapter->hw;
+	int i;
+
+	if (hw->mac.ops.disable_mdd)
+		hw->mac.ops.disable_mdd(hw);
 
 	if (adapter->ixgbe_ieee_pfc)
 		pfc_en |= !!(adapter->ixgbe_ieee_pfc->pfc_en);
@@ -4127,6 +4131,9 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
+
+	if (hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
 }
 
 #define IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT 2
-- 
2.47.1


