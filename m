Return-Path: <netdev+bounces-195873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D43AD28B9
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82417189210D
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A72248B9;
	Mon,  9 Jun 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exm+TH5H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0522370F
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504427; cv=none; b=aeqBMEGVmoDlu9Apph+butfjtpc9tSSRUrRM8V90OJRm5/bCqOydIFJKMKDaNsdGZaeiw0aiPwmHRUMcxZyWVZATjGAgGRnYApeH2xm6TVZrbryP5Tylkl4o71cs8yv/F3NKk2lRmwHW6nsKiQGN19TRPXrHp8GDssyHlWAXBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504427; c=relaxed/simple;
	bh=a1XtimrAar35m6/k9eqvg/TSGHsAjqn6IU6ZS4gk9z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m588bP6SwFqf1l6qPseCz/1IiJm/QK3iJaKEan1qbUGV88Al/GK51Gd7uAKkqowtdtrndfsLFWfzJOFrDWQQ3RMcSIOUQADrFNL0k7yFHKYuhWFHiomzg2MDiOdR3lMnfQsgPl9ydqL15esbzocJHZNAOhuXElaEPH+b2pePOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exm+TH5H; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504426; x=1781040426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a1XtimrAar35m6/k9eqvg/TSGHsAjqn6IU6ZS4gk9z0=;
  b=exm+TH5HkQSADxPlcWJu4ypduXLV4Rq2+zps3GiSGCpLejoFgJmYiUoc
   HUULqQnxGbHaoa/5e+Ns88SEzzJRvm8Ps2iYFtRSidvlOEZddmkg0jeQi
   P61C3MllYEinutREwl2kshs8238xFsPuW/5ioHKNJQ3k6Ep6CvUtH4Kn/
   u4O6amC068cv3uzop1YQuX3bmjY63Xqr2j+8gvMlCw9l7pozhAVr1uZvf
   YvKA3K/8SDMYghphBnXI6noB56/ZyUZFVb9zJA3YZgn8/5TH6Zct1kori
   b3zw8zv3+b+VezgmOUjdfnmiAdv6Tn8+fviJEv7ikguLhfbR6ZRe2Odoa
   g==;
X-CSE-ConnectionGUID: tIHmBQhVQ1Oa6U1fvzZVLw==
X-CSE-MsgGUID: 7j2bc9P3Tx2Lt5cTUEN2uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864197"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:03 -0700
X-CSE-ConnectionGUID: RpUvQcGoQpujoX0b3dw9Gg==
X-CSE-MsgGUID: Itxqrdf7Qb2SK/Y7wMm/Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150469034"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	dawid.osuchowski@linux.intel.com,
	Kory Maincent <kory.maincent@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 05/11] ixgbe: add link_down_events statistic
Date: Mon,  9 Jun 2025 14:26:44 -0700
Message-ID: <20250609212652.1138933-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
References: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Introduce a link_down_events counter to the ixgbe driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 ++
 3 files changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 47311b134a7a..c6772cd2d802 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -752,6 +752,7 @@ struct ixgbe_adapter {
 	bool link_up;
 	unsigned long sfp_poll_time;
 	unsigned long link_check_timeout;
+	u32 link_down_events;
 
 	struct timer_list service_timer;
 	struct work_struct service_task;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index d8a919ab7027..1dc1c6e611a4 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1033,6 +1033,14 @@ static void ixgbe_get_regs(struct net_device *netdev,
 	regs_buff[1144] = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT);
 }
 
+static void ixgbe_get_link_ext_stats(struct net_device *netdev,
+				     struct ethtool_link_ext_stats *stats)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
+
+	stats->link_down_events = adapter->link_down_events;
+}
+
 static int ixgbe_get_eeprom_len(struct net_device *netdev)
 {
 	struct ixgbe_adapter *adapter = ixgbe_from_netdev(netdev);
@@ -3719,6 +3727,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.set_wol                = ixgbe_set_wol,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
+	.get_link_ext_stats	= ixgbe_get_link_ext_stats,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
 	.get_eeprom             = ixgbe_get_eeprom,
 	.set_eeprom             = ixgbe_set_eeprom,
@@ -3764,6 +3773,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.set_wol                = ixgbe_set_wol_e610,
 	.nway_reset             = ixgbe_nway_reset,
 	.get_link               = ethtool_op_get_link,
+	.get_link_ext_stats	= ixgbe_get_link_ext_stats,
 	.get_eeprom_len         = ixgbe_get_eeprom_len,
 	.get_eeprom             = ixgbe_get_eeprom,
 	.set_eeprom             = ixgbe_set_eeprom,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 03d31e5b131d..1982314aaf3c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7991,6 +7991,8 @@ static void ixgbe_watchdog_link_is_down(struct ixgbe_adapter *adapter)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	adapter->link_down_events++;
+
 	/* poll for SFP+ cable when link is down */
 	if (ixgbe_is_sfp(hw) && hw->mac.type == ixgbe_mac_82598EB)
 		adapter->flags2 |= IXGBE_FLAG2_SEARCH_FOR_SFP;
-- 
2.47.1


