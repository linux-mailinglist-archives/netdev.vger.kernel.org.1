Return-Path: <netdev+bounces-189682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D62AB32B8
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE4817A7FB
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75A24E4CE;
	Mon, 12 May 2025 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vd4uadX/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7736433A0
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040770; cv=none; b=K7yK2i+uGyA5ykGhZtLTq+GqTKQX+c//wQb83bGQ6sGMMC+HKGEvuq6zhYRzHhR/CrXla/kIhNJHV/mbwZXBPUztOaAXwUOqpuD0h6l8sR+FmLaor35krx9m4+7kLykMz5MtvCqglO36YeSVuEOT2u+TK/TOhPIiGh8OmJ5LtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040770; c=relaxed/simple;
	bh=fnKe0Y9oLUlJLRR2AxHq3OTfP7glGHmX2LeMJdSBU0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAEsrjSCvv4V5Kuusdm4h7hyE3XZHWb4MwB/ZOk8c8ob8s8c957peoFLQdh1euwrDJELi0O7R0nftn9RUux2acmqdD8wDnE07SG+8HxzziwFD1y7o6LA1FGjCh/8WgcA5roNiwAu8BYZQGJYKECodmtn2mEw2cmUAFZfyzM/x0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vd4uadX/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747040769; x=1778576769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fnKe0Y9oLUlJLRR2AxHq3OTfP7glGHmX2LeMJdSBU0E=;
  b=Vd4uadX/Rwb8Mmhn5q4dY3aONP61AjSYE69wNWtEG2J7UJ+0dLSmGagb
   ivJ44uFJktlnhamTkmu0JXOhGl2VL0wdrtLxy8M/04JCxwETqMWMvcxhC
   8v4abU0UAvrymPFxRqISzyEV1R7tZ4fu+iMzCat0eOELLZjAeZrjDE6nQ
   PQI1pf4MpbefmC94b8e3rnSRTHyUoUxWtqELYKHUd3JPhiYONXPJ/qowK
   PF7vUxCxK1XHpHq1OtauZfA26JcNllF8QKhR8+5pnxXVtoqF7EHyQXFWm
   FNKe+D3OkeMlRdBaw95HwFhASVlehbc9htXfmv1GwaMrBnqC2XnqVNaKi
   w==;
X-CSE-ConnectionGUID: bttp++nZR7qHMI1XKe25Qg==
X-CSE-MsgGUID: 4gCdhbEiTIiSpq4ak9MDvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59459738"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="59459738"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:06:05 -0700
X-CSE-ConnectionGUID: 2gNb04n2RWORyRbzauz3Jw==
X-CSE-MsgGUID: fQ5tHO48RLWtLhaspQPgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142263045"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa004.jf.intel.com with ESMTP; 12 May 2025 02:06:03 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3 2/2] ixgbe: add link_down_events statistic
Date: Mon, 12 May 2025 11:05:18 +0200
Message-ID: <20250512090515.1244601-6-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250512090515.1244601-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a link_down_events counter to the ixgbe driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
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
2.47.0


