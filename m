Return-Path: <netdev+bounces-189681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2A1AB32B7
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 11:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324FC7A536A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 09:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2585253949;
	Mon, 12 May 2025 09:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MojXBAQR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D6813212A
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040756; cv=none; b=mSU+4SY7yLtCqJZzijEIKH6i//7b3dwF/EugxV8YuJ8CemphCgLQyUVlrFFkND0GGqGSpKfmtbgXG9EgKhpyaHur0oXhzbV4eMO3LbhxTf8wmKc7vNqu+SrX89AAVyH61rPLTWe1SjilCiCRitIockrFxYOZIpSMjNHG2z0N0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040756; c=relaxed/simple;
	bh=ObAIrTH9pBRbOQjts3ltZG3qaATJ5eM9weRE4fL6Mco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Npj3aHpTSc+o+EiCvy9vmqrybuPmCyeN6x7Yi2+8Qs2NkKmEeudNmNvoYHhKfHRHtUMGyUCdaUT37NPR5pIejb8lJoTcksPdmxpi9f5Uhj7Os1TaBcXJ/szu6qvnr9FZ/kf5rhQ8NAWISczFMNK05n4XFVFh6QCxEJw2TV3u6W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MojXBAQR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747040755; x=1778576755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ObAIrTH9pBRbOQjts3ltZG3qaATJ5eM9weRE4fL6Mco=;
  b=MojXBAQRti5cw8cEJzT2bRD/c1wjogfWDit8f+n2R1Lax2pWsIo614mP
   hfmpxFFXL9M+eTRVbPZ+MDqzt+54e0XzeP/n3UiP9abCqsQyV1z0WvVus
   945Mfep19P4anXRV4l4tweAKf+nXbrjSsqLREiw6J24C5yX4qNVE1GyVF
   4cNma6haUUwLVC9YU6lrWl0M6mikRRYijjchwwp9lZw38vAUGZ6E5thjx
   G61KQwhexTiZf9GOYkH1fWLEdDYxHUVNAOwxNr9VvacVLdQ5n6Ji+Dmpf
   86tSMYVzm7ousMHAP8wS7eoVnZdp3Nz0BpHZxSCcPMztB3zaKIxQOSE5U
   g==;
X-CSE-ConnectionGUID: p0jCckEBQt6USFHC8ZmAiw==
X-CSE-MsgGUID: N0SAA5u5T1KzCQnsGp/V9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="59459720"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="59459720"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 02:05:54 -0700
X-CSE-ConnectionGUID: qTiES2tJQymahWYIOLi88Q==
X-CSE-MsgGUID: +wP3fQADQ/utD54qjkqmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="142263004"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa004.jf.intel.com with ESMTP; 12 May 2025 02:05:53 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH iwl-next v3 1/2] ice: add link_down_events statistic
Date: Mon, 12 May 2025 11:05:16 +0200
Message-ID: <20250512090515.1244601-4-martyna.szapar-mudlaw@linux.intel.com>
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

Introduce a link_down_events counter to the ice driver, incremented
each time the link transitions from up to down.
This counter can help diagnose issues related to link stability,
such as port flapping or unexpected link drops.

The value is exposed via ethtool's get_link_ext_stats() interface.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  3 +++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index e42572ae7631..eac0f95d20f1 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -617,6 +617,7 @@ struct ice_pf {
 	u16 globr_count;	/* Global reset count */
 	u16 empr_count;		/* EMP reset count */
 	u16 pfr_count;		/* PF reset count */
+	u32 link_down_events;
 
 	u8 wol_ena : 1;		/* software state of WoL */
 	u32 wakeup_reason;	/* last wakeup reason */
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 648815170477..db7ae817b127 100644
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
index 1fbe13ee93a8..2d1361b68b14 100644
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


