Return-Path: <netdev+bounces-192315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A71ABF7C0
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46843A6FE8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AAF1A0BE0;
	Wed, 21 May 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSbehpNa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A4194A59
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837435; cv=none; b=siPepBLLGHLo1yv7HbQLNnNWjnQdj8WIpBpniKK6JYA7pIo3mFYi2ph21RwYUboivgfUMlPdNBcyyLlmGN4actnu1CeUvbb1vP1psogjl2sWkUFe93/mzQ/p+XbIB2rai+oxuxPzDIUmIF6NykOzI+9WAr+Njz1sdw0Mjzuj0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837435; c=relaxed/simple;
	bh=1NlA7Lajb+p5gKLZ4hdgRlVo+SU6VX1Ll7WgBh1g5DE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwDeLnBexBDga7WjitUc0EEO4BNiYLeLDOAzgb9W3F7Fpm4fmewM8h77Z4ddKnraLc7pWVjl6JGMU9pwy6ftKZQK/eCiYQNj9jcoFGeSD7hn0U1GUlVMy4/ufOrEN4kbZwziK2TZO07RWYyB0YVY57uEDkw/iC3iBcGJ+vmhsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSbehpNa; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747837434; x=1779373434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1NlA7Lajb+p5gKLZ4hdgRlVo+SU6VX1Ll7WgBh1g5DE=;
  b=kSbehpNahOgGjqUew/hGXbVTySLqxRMxxEntGg3p8QtJfEy1wRWe4klS
   1ZSS6FlVJ0MPW7b7M2TOgcNAOhC7EntU9ku1xgekXWm9zaSdrMfEu5vLD
   WSidsujrC+mY45ONLr4RXvV5cqmfXKlMxyeM9PhFTg4Kc1BvSDvlPxi32
   OnC4WMVKJftNYtcIn/MiwWnQvmrzUNVbD/yEIUYVLZFN+P6URo6GynoGo
   5saYQMJnsdfaA5Qzcv30ofcWUaZtKmtPRbyBN+Ny0nix0xBN0pMO0vHIK
   Wvn1f1VqNcV7MuahpIq/B6/+wbsxkuu19N2e76kvfOngGZhvXMxWw8PSO
   g==;
X-CSE-ConnectionGUID: vUg8DAM4QZqUYQdJ/Ej9Cw==
X-CSE-MsgGUID: WkWFmkvzQjCEN7tL/CNPiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="53627261"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="53627261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 07:23:54 -0700
X-CSE-ConnectionGUID: tsejvJ3ZQz2SyGRCTkvlyA==
X-CSE-MsgGUID: 5VUxIBPFQHmxZ+YtD1+DmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="139943813"
Received: from pae-dbg-x10sri-f_n1_f_263.igk.intel.com (HELO localhost.igk.intel.com) ([172.28.191.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 07:23:52 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next] i40e: add link_down_events statistic
Date: Wed, 21 May 2025 16:23:32 +0200
Message-ID: <20250521142332.449045-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a link_down_events counter to the i40e driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
Based on series [1] from Martyna where this was implemented for ixgbe
and ice drivers.

[1] https://lore.kernel.org/netdev/20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com/
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index c67963bfe14e..54d5fdc303ca 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -548,6 +548,7 @@ struct i40e_pf {
 	u16 empr_count; /* EMP reset count */
 	u16 pfr_count; /* PF reset count */
 	u16 sw_int_count; /* SW interrupt count */
+	u32 link_down_events;
 
 	struct mutex switch_mutex;
 	u16 lan_vsi;       /* our default LAN VSI */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 21dd70125a16..adcf068202b0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -2749,6 +2749,15 @@ static void i40e_diag_test(struct net_device *netdev,
 	netif_info(pf, drv, netdev, "testing failed\n");
 }
 
+static void i40e_get_link_ext_stats(struct net_device *netdev,
+				    struct ethtool_link_ext_stats *stats)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_pf *pf = np->vsi->back;
+
+	stats->link_down_events = pf->link_down_events;
+}
+
 static void i40e_get_wol(struct net_device *netdev,
 			 struct ethtool_wolinfo *wol)
 {
@@ -5807,6 +5816,7 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.get_regs		= i40e_get_regs,
 	.nway_reset		= i40e_nway_reset,
 	.get_link		= ethtool_op_get_link,
+	.get_link_ext_stats	= i40e_get_link_ext_stats,
 	.get_wol		= i40e_get_wol,
 	.set_wol		= i40e_set_wol,
 	.set_eeprom		= i40e_set_eeprom,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e421156717a4..d7368fa31ec8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9933,6 +9933,9 @@ static void i40e_link_event(struct i40e_pf *pf)
 	     new_link == netif_carrier_ok(vsi->netdev)))
 		return;
 
+	if (!new_link && old_link)
+		pf->link_down_events++;
+
 	i40e_print_link_message(vsi, new_link);
 
 	/* Notify the base of the switch tree connected to
-- 
2.47.0


