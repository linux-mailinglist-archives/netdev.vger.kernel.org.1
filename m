Return-Path: <netdev+bounces-274888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEBSFQ5Tz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6C39125F
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC3FB30628C0
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C6344040;
	Fri,  3 Apr 2026 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/kKrThw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BBE3542F8
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194841; cv=none; b=oL15zEuaaYXAluzRaIRR2Y4dNQcySY5f4zKSjtqXoEhdarX/EIBQ2L1PMyojVmK7tpqHeZFb2PCEKv+QZsAolaRrYIDTIyYA68S7Xbbg4g1j5GbayYOtcSzw8QWUzzxfhCoFH8+PmM+0qOBpyjieeDn4iMwJTFu1xc1hUUBdEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194841; c=relaxed/simple;
	bh=jK3wjtpXszUhk9dYiDSEL6WygtA0YLoAGsaq2N23/UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRoBbkZKkkGSnwHn4aDJmBZ4GprtCNya2wbthWOt2RGHQgxEoInUBj6dpCsFE/0WwVHVpZ14JBLxw2S0UAbMPB7M7UJ3i10PdDNpVp9cQ2OzTw3lltlMH8sAlBvpBZF5s6sQiF1GDq3GP4YNQnzgNFH+wOPGytpF8JFleramnLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/kKrThw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194840; x=1806730840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jK3wjtpXszUhk9dYiDSEL6WygtA0YLoAGsaq2N23/UE=;
  b=V/kKrThwPaavvtanlMOPFGyiSdKjSZcrZP32slYXN+/AqrZ5ARwv1Jbg
   XtPkzUtG4qO54Tesyioh7Y04KNXGSN/zXDHBM6+Ud46H8VjtWTnyF/Sy7
   f0MwHaE6zsMcOar4ixRpmj5G1DptQl9MK3QxlKf/5ls+TxIfOGZO1w40l
   LSnhiz/GLNJuqAdDqX+UY4Lq5KKRzgY1nHYMXLg5bhUgbo+NboZSTfHgA
   vQ0NxCTwUlyHNBBC7AZUslOaxon+lw2dOSdeiX5msaaDGiij1YvHJW7Bj
   j+lcJBA9LEw9hOUQ8Vcv5E7VMIz1HaBx+8aWuYolOSN02sGsvLgF/GExd
   A==;
X-CSE-ConnectionGUID: 5QiHUNlzTeConxus3X/aaQ==
X-CSE-MsgGUID: N/c34LMTTbGNeFA8rkbn1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981750"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:40 -0700
X-CSE-ConnectionGUID: 2HBAAWu1T9GmzwNZScerbQ==
X-CSE-MsgGUID: e+GfxgQrTcmdfKlqDKVJug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904939"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>
Subject: [PATCH iwl-net 6/10] ice: check PHY autoneg capability before rejecting ethtool autoneg setting
Date: Fri,  3 Apr 2026 07:40:24 +0200
Message-ID: <20260403054029.3789616-7-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
References: <20260403054029.3789616-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274888-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B3E6C39125F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_set_link_ksettings() rejects autoneg requests by comparing
user settings against safe_ks which is populated by
ice_phy_type_to_ethtool(). The Autoneg bit in safe_ks is set
only if the current PHY configuration reports it supported,
but this misses PHYs that support autoneg and have it available
through PHY capabilities. Pull the autoneg flag from the actual
PHY capabilities (already fetched earlier in the function) to
ensure the user can toggle autoneg on any capable PHY.

Fixes: 5cd349c349d6 ("ice: report supported and advertised autoneg using PHY capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 49b9376..44483bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -2654,6 +2654,14 @@ ice_set_link_ksettings(struct net_device *netdev,
 	/* Get link modes supported by hardware.*/
 	ice_phy_type_to_ethtool(netdev, &safe_ks);
 
+	/* Pull the value of autoneg from phy caps to ensure we allow
+	 * toggling it on all PHYs that support it.
+	 */
+	if (ice_is_phy_caps_an_enabled(phy_caps)) {
+		ethtool_link_ksettings_add_link_mode(&safe_ks, supported, Autoneg);
+		set_bit(ETHTOOL_LINK_MODE_FEC_NONE_BIT, safe_ks.link_modes.supported);
+	}
+
 	/* and check against modes requested by user.
 	 * Return an error if unsupported mode was set.
 	 */
-- 
2.52.0


