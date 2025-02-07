Return-Path: <netdev+bounces-163928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C4A2C0D4
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369843A5D8D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A361DED48;
	Fri,  7 Feb 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OaI5XUL9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90641DE4CC
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925037; cv=none; b=DHGDuwBF2W+Mu16h9x7eCwMXsoAegwWZZbZHhbtsJ+OEEkhfMhdpfEpf602bD1tpeRQnf8Jv2Bc9FM1HiPgCxcbCfhnJ5UF00Ri3M3qhL65dkhGmWYFo/A3XDLpXVdcPFZUJq4slw3PcECq82oSXrXRF6vr4vaJaxKvgyGYvf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925037; c=relaxed/simple;
	bh=pHIZhOnQWDaCXWMrQoRrd//50wLkIlZSPyndib5X0CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfCltmC/BzWop2GaxgkCTlszGqX6Rhgile3y5eUY2NMu6gMC7n7z2bSOp4mmIKgyS/gAGAND+W/04Zw9IOu3hdDo+MjTUF7ANdlK/A4iQRUYICIenwgShJ33OPNm6G7PbI6Qjqjl/1Kp7qDEDD2cmWhDiTtzDhLlQZd6ognqu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OaI5XUL9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738925036; x=1770461036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pHIZhOnQWDaCXWMrQoRrd//50wLkIlZSPyndib5X0CA=;
  b=OaI5XUL98TZh0A8+CISjCxQvGIg4FURZZkSCTXN2KQzTm6OO6Y0qa+qf
   tNoOwRvaxTJbRAGPgAG7vxYrrqnP2wkJl88xAiS2e94zmLYbRzdJC6hrE
   26QBkng/iuU8fG3SSKNHR68w+joVgnbTvaHxw5xIGXzmmDUYKpO/wP9q/
   +NLh7jtMVUtOfR2kHIvA9sBsGuFCLMQ9pNBCSW9fKbZXm8t+SVI7yfj6y
   6mS7d4xxysupk7cmnMP9LNzhr4Eg7MgXBXvJq1mjH8Yd4WifWtReXbJ81
   PoUVxeTSCH7wmkpYIXjmMhSZ2MYv2jkop0/YpfZtY0Nn9hp2BA0vCmN8W
   w==;
X-CSE-ConnectionGUID: ZknGus1qQsiiS8wysEzb8Q==
X-CSE-MsgGUID: 207UMEjIQ1qEfyAkCLauMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="62039837"
X-IronPort-AV: E=Sophos;i="6.13,266,1732608000"; 
   d="scan'208";a="62039837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 02:43:55 -0800
X-CSE-ConnectionGUID: TXUMPOXhRJe7TjHzjln/DA==
X-CSE-MsgGUID: NhDAWSaoRFmSFYHEnbpdGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116429797"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 07 Feb 2025 02:43:53 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@intel.com
Subject: [iwl-next v1 4/4] ixgbe: turn off MDD while modifying SRRCTL
Date: Fri,  7 Feb 2025 11:43:43 +0100
Message-ID: <20250207104343.2791001-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
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
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 5c1c067ffb7c..6bb2a0edf2ea 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -4100,8 +4100,12 @@ void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
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
@@ -4123,6 +4127,9 @@ static void ixgbe_set_rx_drop_en(struct ixgbe_adapter *adapter)
 		for (i = 0; i < adapter->num_rx_queues; i++)
 			ixgbe_disable_rx_drop(adapter, adapter->rx_ring[i]);
 	}
+
+	if (hw->mac.ops.enable_mdd)
+		hw->mac.ops.enable_mdd(hw);
 }
 
 #define IXGBE_SRRCTL_BSIZEHDRSIZE_SHIFT 2
-- 
2.42.0


