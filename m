Return-Path: <netdev+bounces-274892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HPsG6pTz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:44:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC443912C3
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1435D3074E2C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986CC35A95A;
	Fri,  3 Apr 2026 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXvB8Tok"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1E359A91
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194846; cv=none; b=jjmRHYy4qPZEtcBxz8CQvV5HoAyZkr/wJJV3ZleXKvL3dSWBIHFifzRMKhUVLR5QF91gNs416OwWy+K7FajvMHawxUplvIkj6vLnWClmNxHGVnRIetK84YQW7XAm0xQcGO8mpaRC6mDx/rZscrYUw+LLYsYEVa0fjdyZVGkx63M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194846; c=relaxed/simple;
	bh=nFD8pkeZbVN+oILrj3B+/KCNeAfTezohFmcf1myKIyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKsfDiTTFjxhhXa74iPiV08jvCAAuCrfmQ3kTaI2BU5Ed/W4D9nDCer610l/k/woZFCfRKQKZB/mYIyRPTzm07ByklZwFW/sHrn42RcsMAYt6kZMyXp93gwIjkyr9y6xtv++Lm2G1wS2SOgKUeSRpj1h3thkQ5ZP06RtyKS2sRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXvB8Tok; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194846; x=1806730846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nFD8pkeZbVN+oILrj3B+/KCNeAfTezohFmcf1myKIyA=;
  b=IXvB8TokZmpmzlZoE6usHYl1XajSpfttSpplSDPltYEEDQz23+sTXxPt
   Ecgs4VJxY6jYruIpsdohPuVxmujLiS2nDdMn1xjMEFpVgWSoTbFvFyPMw
   OuaaQhFI+jUkk5rWoTjIqSV5p2ldNGPXEaBtsBR2eEbOzS9tW7meb+KtH
   hrufGo5s14S+lHFiaz0+WiX59wl8vFI53Fon1EpAOSKPgpDWvB9v3sChM
   BnTH+BXKlFBbubqrfq6WJ/3JmyBxWZaVlRlDbT54ZYf8BhUMuG4yS9XSK
   CaYrPPWYfjbnTfosRknEOVxtoFrqyecG9iNpBID/Fdsx5e3Kk3gp4JnSV
   w==;
X-CSE-ConnectionGUID: G1tCX+i/TOq/tAFYJcOw0A==
X-CSE-MsgGUID: WXU5q42aS0mGv1sUXCzAnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981761"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981761"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:45 -0700
X-CSE-ConnectionGUID: DHKv9Q/bSWOapH5+nk6vsw==
X-CSE-MsgGUID: F7TH3JMjRbyWiRLV0GQgwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904951"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:44 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net 10/10] ice: allow setting min_tx_rate to 0 to resolve VF bandwidth oversubscription
Date: Fri,  3 Apr 2026 07:40:28 +0200
Message-ID: <20260403054029.3789616-11-aleksandr.loktionov@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274892-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDC443912C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_set_vf_bw() refuses to accept any min_tx_rate value when the
total guaranteed bandwidth is already oversubscribed, even when the
requested value is 0. This makes it impossible to recover from an
oversubscribed state via "ip link set <pf> vf <id> min_tx_rate 0".

Allow a zero min_tx_rate to bypass the oversubscription check so
users can always clear the guaranteed rate. Additionally print an
informational message when the oversubscription guard fires to help
diagnose why a non-zero request was rejected.

Fixes: 4ecc8633056b ("ice: Add support for VF rate limiting")
Cc: stable@vger.kernel.org
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 7e00e09..6e3bec7 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -1507,6 +1507,12 @@ ice_min_tx_rate_oversubscribed(struct ice_vf *vf, int min_tx_rate)
 	all_vfs_min_tx_rate -= vf->min_tx_rate;
 
 	if (all_vfs_min_tx_rate + min_tx_rate > link_speed_mbps) {
+		if (ice_calc_all_vfs_min_tx_rate(vf->pf) > link_speed_mbps) {
+			dev_info(ice_pf_to_dev(vf->pf),
+				 "The sum of min_tx_rate for all VFs is greater than the link speed\n");
+			dev_info(ice_pf_to_dev(vf->pf),
+				 "Set min_tx_rate to 0 on VFs to resolve oversubscription\n");
+		}
 		dev_err(ice_pf_to_dev(vf->pf), "min_tx_rate of %d Mbps on VF %u would cause oversubscription of %d Mbps based on the current link speed %d Mbps\n",
 			min_tx_rate, vf->vf_id,
 			all_vfs_min_tx_rate + min_tx_rate - link_speed_mbps,
@@ -1556,7 +1562,7 @@ ice_set_vf_bw(struct net_device *netdev, int vf_id, int min_tx_rate,
 		goto out_put_vf;
 	}
 
-	if (ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
+	if (min_tx_rate && ice_min_tx_rate_oversubscribed(vf, min_tx_rate)) {
 		ret = -EINVAL;
 		goto out_put_vf;
 	}
-- 
2.52.0


