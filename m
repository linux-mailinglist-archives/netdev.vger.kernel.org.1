Return-Path: <netdev+bounces-249050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3BAD13133
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45891300A934
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5188266581;
	Mon, 12 Jan 2026 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lxP4tlmv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE225B1D2
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227529; cv=none; b=ntv6x33fh1GRRfGjU3ehCjEscSOVqZbSNPBsK9L861ml/zPyNWx04JVzl/5lwcIcFme/e5XjNolDYcnGLeM9z/KBUCagGtZ6St0ya1ekJFLqf9cNJkO/UqY/O1LBPwbb9N2zeaOffssserHbn/3Q+Inmh4xHRPdJggyAYFmIniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227529; c=relaxed/simple;
	bh=dVvvYrj79xK+qLiOmCoLFSe9MUazobjKGxWIwIwTUms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkJQJAZprko7exH+tV+vpHzAkrSas67qSEjUJnj2LPd4ag0UM5zdzGRf+Cicp8BnaUube4swe7AS6L4s/RSJmB3YbBcfq8KqJ7nr/tGRmLjRvpo5KnEy519FSMbXQpHLoyACtVVHhmIiKouvZMe25e5w9StaxPIM3/lTMbgZ9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lxP4tlmv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768227527; x=1799763527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dVvvYrj79xK+qLiOmCoLFSe9MUazobjKGxWIwIwTUms=;
  b=lxP4tlmvTAKpdG3MkJjogiiyoV8JGIjPxqbcHKTj6gBks4cE5tNRUtx5
   JxXIfWAAPz/9ykSvxivp+Nz/FvU8T9qVuu8p0KuI/ot9kC7kjZZAxutmZ
   PvbzRebgNkPAlfINTDVzvhsH1MaZHaf3vHjvC69066DWwN8Rny+N76xqu
   j+2YBO/TCtPEAodYiT7qH5RUanZNInoO1aLavROTVz+5rJQntM1cL1BbV
   Cf/4MbUMwgahtYWxg4kaNkWTlAfxMmap9RybaBNEm2sHqjouP7zN52+DE
   HHCm6peLfoa9c3hKigQ+YhUjeKqYHnIQLMqbkrJOzsISkCl9W2hAouwE+
   g==;
X-CSE-ConnectionGUID: mH8UoYd1RcGZqcvF/imaLw==
X-CSE-MsgGUID: QgGzoWryTeqoHq13+/qWDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352295"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="73352295"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 06:18:46 -0800
X-CSE-ConnectionGUID: STld3o2fTBmfTl22aDzyBg==
X-CSE-MsgGUID: 3suDrD0wQ3OUzIoB5x8e/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; 
   d="scan'208";a="227355650"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:45 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v1 6/7] ixgbe: replace EEE enable flag with state enum
Date: Mon, 12 Jan 2026 15:01:07 +0100
Message-Id: <20260112140108.1173835-7-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change approach from using EEE enabled flag to using newly introduced
enum dedicated to reflect state of the EEE feature.

New enum is required to extend on/off state with new forced off state,
which is set when EEE must be temporarily disabled due to unsupported
conditions, but should be enabled back when possible.

Such scenario happens eg when link comes up with newly negotiated
speed which is not one of the EEE supported link speeds.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 11 ++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  4 ++--
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 14d275270123..9f52da4ec711 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -324,6 +324,14 @@ enum ixgbe_ring_state_t {
 	__IXGBE_TX_DISABLED,
 };
 
+enum ixgbe_eee_state_t {
+	IXGBE_EEE_DISABLED,	/* EEE explicitly disabled by user */
+	IXGBE_EEE_ENABLED,	/* EEE enabled; for E610 it's default state */
+	IXGBE_EEE_FORCED_DOWN,	/* EEE disabled by link conditions, try to
+				 * restore when possible
+				 */
+};
+
 #define ring_uses_build_skb(ring) \
 	test_bit(__IXGBE_RX_BUILD_SKB_ENABLED, &(ring)->state)
 
@@ -671,7 +679,6 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_FW_ASYNC_EVENT		BIT(12)
 #define IXGBE_FLAG2_VLAN_PROMISC		BIT(13)
 #define IXGBE_FLAG2_EEE_CAPABLE			BIT(14)
-#define IXGBE_FLAG2_EEE_ENABLED			BIT(15)
 #define IXGBE_FLAG2_RX_LEGACY			BIT(16)
 #define IXGBE_FLAG2_IPSEC_ENABLED		BIT(17)
 #define IXGBE_FLAG2_VF_IPSEC_ENABLED		BIT(18)
@@ -682,6 +689,8 @@ struct ixgbe_adapter {
 #define IXGBE_FLAG2_API_MISMATCH		BIT(23)
 #define IXGBE_FLAG2_FW_ROLLBACK			BIT(24)
 
+	enum ixgbe_eee_state_t eee_state;
+
 	/* Tx fast path data */
 	int num_tx_queues;
 	u16 tx_itr_setting;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 7a7a58fd065d..24781bbbcf46 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3656,11 +3656,11 @@ static int ixgbe_set_eee(struct net_device *netdev, struct ethtool_keee *edata)
 		return ret_val;
 
 	if (edata->eee_enabled) {
-		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+		adapter->eee_state = IXGBE_EEE_ENABLED;
 		hw->phy.eee_speeds_advertised =
 					   hw->phy.eee_speeds_supported;
 	} else {
-		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+		adapter->eee_state = IXGBE_EEE_DISABLED;
 		hw->phy.eee_speeds_advertised = 0;
 	}
 
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 692b095b5c16..b87d553413cd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6763,11 +6763,11 @@ static void ixgbe_set_eee_capable(struct ixgbe_adapter *adapter)
 		adapter->flags2 |= IXGBE_FLAG2_EEE_CAPABLE;
 		if (!hw->phy.eee_speeds_advertised)
 			break;
-		adapter->flags2 |= IXGBE_FLAG2_EEE_ENABLED;
+		adapter->eee_state = IXGBE_EEE_ENABLED;
 		break;
 	default:
 		adapter->flags2 &= ~IXGBE_FLAG2_EEE_CAPABLE;
-		adapter->flags2 &= ~IXGBE_FLAG2_EEE_ENABLED;
+		adapter->eee_state = IXGBE_EEE_DISABLED;
 		break;
 	}
 }
-- 
2.31.1


