Return-Path: <netdev+bounces-182165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41DA88107
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A0343B7C75
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584171EB36;
	Mon, 14 Apr 2025 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YO2PweWx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9775227
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635741; cv=none; b=fiVyLsaWs7H7SwunbQiS3iAy2jvri/BAgWzGI7OW60CK7N23BqrgrIQtm7FFr8pCWPdQYsFFb3TApHCOzPBQoWr6XAdUbeZqMHtqZsnT+IoKUfGpbwIXVJZ4H8kAtOPVN8nKn5z+K1Qh/PwgtJHbcN64nXp2IKX4dgh6srVUbvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635741; c=relaxed/simple;
	bh=W7Z5xn5IPV8gDmNqoXJBFdpf5pRGqNSmYd8MjnkwpK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FnaTF1OHpV4qjtZQxSO4NVh15X7yen8waB8WRX+dgeATVrdEgo2FKalF9sWeOEdkxWgAjXkoweAhXEOenRdNHVBISszBTrJZy6Obg5+phdtaKjTxlxHqTBJ7GAFMZAedkV8lsjqz5NvkwO2f+57HwTYO+MkfhDcq+bwbMjRBWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YO2PweWx; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744635739; x=1776171739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W7Z5xn5IPV8gDmNqoXJBFdpf5pRGqNSmYd8MjnkwpK4=;
  b=YO2PweWxyb7thYmucNXYV/KAGoRJvStOhMS5XcRrMdLuuNv6gDN5xR0r
   tyNFcJ4vZJBXVhF0KT3rF6LO0fFus7YA8Y/C2qARoLbnF4kczJcb+B19S
   WG6aLfieG+S0OuhiRIBIjR/5mAZcce9ClDgXtf+pdrQquIg2HiERls8eG
   sQRsS2uaV0HcP9q2Qp8wpxyUGv5lplEY2e+w7+gTpbcvOJds396YTZkgg
   YLLCz+qhDf94g1UytMVXLgaSUwGuZD0xsInlR2ciw69BAegiR3x2WHKRh
   Y8UAsQAZfyvGv30Z3TKehxCYcx7oFalzMFZt6+zPpiqohAmtQUPDeUIBP
   Q==;
X-CSE-ConnectionGUID: Q2eThHlXQUGKKzaoD8fFlQ==
X-CSE-MsgGUID: HMuJ6XNVTS+u2gPBLNk8MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57469132"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="57469132"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 06:01:33 -0700
X-CSE-ConnectionGUID: pM6vjnfZTimu5us0Ooj86Q==
X-CSE-MsgGUID: 6hviZSSKQg2aYustRr5MjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="134967202"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa005.jf.intel.com with ESMTP; 14 Apr 2025 06:01:32 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-next v2 1/2] ice: add link_down_events statistic
Date: Mon, 14 Apr 2025 15:00:09 +0200
Message-ID: <20250414130007.366132-5-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a link_down_events counter to the ice driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 7200d6042590..6304104d1900 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -621,6 +621,7 @@ struct ice_pf {
 	u16 globr_count;	/* Global reset count */
 	u16 empr_count;		/* EMP reset count */
 	u16 pfr_count;		/* PF reset count */
+	u32 link_down_events;
 
 	u8 wol_ena : 1;		/* software state of WoL */
 	u32 wakeup_reason;	/* last wakeup reason */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index b0805704834d..5738f3069efa 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -836,6 +836,15 @@ static void ice_set_msglevel(struct net_device *netdev, u32 data)
 #endif /* !CONFIG_DYNAMIC_DEBUG */
 }
 
+static void ice_get_link_ext_stats(struct net_device *netdev,
+				   struct ethtool_link_ext_stats *stats)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_pf *pf = np->vsi->back;
+
+	stats->link_down_events = pf->link_down_events;
+}
+
 static int ice_get_eeprom_len(struct net_device *netdev)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
@@ -4784,6 +4793,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_msglevel		= ice_set_msglevel,
 	.self_test		= ice_self_test,
 	.get_link		= ethtool_op_get_link,
+	.get_link_ext_stats	= ice_get_link_ext_stats,
 	.get_eeprom_len		= ice_get_eeprom_len,
 	.get_eeprom		= ice_get_eeprom,
 	.get_coalesce		= ice_get_coalesce,
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a03e1819e6d5..d68dd2a3f4a6 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1144,6 +1144,9 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 	if (link_up == old_link && link_speed == old_link_speed)
 		return 0;
 
+	if (!link_up && old_link)
+		pf->link_down_events++;
+
 	ice_ptp_link_change(pf, link_up);
 
 	if (ice_is_dcb_active(pf)) {
-- 
2.47.0


