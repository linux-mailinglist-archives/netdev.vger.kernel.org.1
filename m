Return-Path: <netdev+bounces-190675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB9AB8456
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E3419E47C4
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D132298251;
	Thu, 15 May 2025 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTzjvhGO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EBB1E9B2F
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306242; cv=none; b=WXwPSnWFg06cTJ6djh4rC4nvEmJmWaa+TsEn46GconVM6jKdKXoB0Tyum4vwkNtv3X5mD8pbit5+WmZ9Uxlprj61sg4wAlypIElXdz+1Zul45lW/9iX+Mgn8OoiOShlOWK94JhdhiBJpqy/jE5XoTHoafQrevjJj5309l3cP2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306242; c=relaxed/simple;
	bh=ObAIrTH9pBRbOQjts3ltZG3qaATJ5eM9weRE4fL6Mco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSyXwOnTrRJX8XGW+ukdlWA/mGuc5H9aUWxqOij5s0sS1SJJlH4DwbpEw6yMbaGdo9XJGdtC4GffjuPtgEFbipb8K1EF1VobQXadipjUBMMg5l/6rilCiNxk4cQwrfyLgjzy5Z+mscz8Ekp4x4SoJJj2ejCs07tpMe2pt3dTPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTzjvhGO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747306241; x=1778842241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ObAIrTH9pBRbOQjts3ltZG3qaATJ5eM9weRE4fL6Mco=;
  b=KTzjvhGOwS8vZUCLvbRgll+8ZqQJjozx6IwKj7HFWxgUCItPaRfA8t9r
   MEBHDzC/tRP3Al/Bl/pqYJkSMO5PRJi1+7EZegNQ95j0idvEqi3DHRw4C
   /DIvGopBqR2kelQq+FW8Movee9mwvVihZT3s5+/1ipP/JJ8bGWe0JrA7A
   CYgfGhZWIG+fiE1OUdF7IOTg2tkAmeqUc3ygbiVbbcFhlRALLOPwxQ1tA
   v8f87HfMHysBN2OD5JZ4vfEOVTfr7l0d36/1S5yaTLQxqH80Fd4ZJ7WF0
   CX0kcNpIrws5dpBJWgwfKorXaA89d5ruUyjdyeL43LoG85iMt2SclqSa9
   g==;
X-CSE-ConnectionGUID: 9yHKOcmiTyGz9HiL08cFHw==
X-CSE-MsgGUID: sveA4GLYTO292syWo+rTnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="66786963"
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="66786963"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:50:41 -0700
X-CSE-ConnectionGUID: FdOZtzFqQRSSFbRnIebXhg==
X-CSE-MsgGUID: wViUpew+R3OZr9hyFGhWHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,290,1739865600"; 
   d="scan'208";a="138873942"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa007.jf.intel.com with ESMTP; 15 May 2025 03:50:38 -0700
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	kuba@kernel.org,
	dawid.osuchowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH iwl-next v4 1/2] ice: add link_down_events statistic
Date: Thu, 15 May 2025 12:50:09 +0200
Message-ID: <20250515105011.1310692-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
References: <20250515105011.1310692-1-martyna.szapar-mudlaw@linux.intel.com>
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


