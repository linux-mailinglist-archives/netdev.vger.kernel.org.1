Return-Path: <netdev+bounces-255225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PdDKGb+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB7FBE021
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DDA0302295D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CD385EFF;
	Fri, 30 Jan 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6I+BDiE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1373803D1
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799249; cv=none; b=SwpUG05ilrskQz4DPOFHDyFNnC2XDaK9UD0BH/4xTfIX4DaHaQlRN1pVCeNXAQHm2Br5PpvtYT9kCLWPLnRUmJHzPtoEdQOM5AvWHr9tlBkrTxvUzA6UwVdsl90AqhVIBs/S6RXSBo0XnMXyYjHphaZqtfDaI5P4bPLMjc89I0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799249; c=relaxed/simple;
	bh=QiPGWXLNtkw+nuEKvcpmVFINTkulPUYzjN0N9rib4ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZtOUaJFfiRqziRK6qdbdcbNT3BMYhrHdCxb4cmkdQhpSRRto0hhCIyoua2y2HZtZmooJ+4tG+v3q+N/jv2GYqr0WIwn0doz8+djkfbW/lf1Pwaug2EQnybR3V4sFwugjwt0VoNnM0E8ksduMdMcaBLvNcYjt2umo2r94scGYO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6I+BDiE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799247; x=1801335247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QiPGWXLNtkw+nuEKvcpmVFINTkulPUYzjN0N9rib4ec=;
  b=K6I+BDiESfoG+2RmMj1xLSndDTEO5A3aWoxQfnpQb/SRDjI+Jjl/awCl
   MtyJrEwdGRSJ6geynfY8WtLLacPJe4dnv5GfJQRms5E1QeKQi1v+RHViz
   I5g1KtzUND+ZdnBfTo7AOhHLghfGbew2qa/pZ1ZRDGkPEekdo/X8hUF4g
   U8IcyQ/xtOiOX4jqAyEdMtOcqyO6jDI9LBy03ILBHc2tinOUCRr7v73Xm
   wfXXPUZ8GNkOkiacgAb40J/EAOQVke5Q5wgFaug9a4ZMQjrzHwDynK+i5
   2ya3vGKmg86LSZjGgoPX3gdfxlgx/TtRRU0nZIWaEL2t3jm6A0otcCw6F
   Q==;
X-CSE-ConnectionGUID: sfZTKkLVRTqm5q9Xq01yRQ==
X-CSE-MsgGUID: 9WruXdR8RN6+lIk1OIJtsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091270"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091270"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:06 -0800
X-CSE-ConnectionGUID: RvczcAM/QdimjUNrpwifPQ==
X-CSE-MsgGUID: 4xmx8kH4TeSJWnUw39S2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231841001"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:05 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/5] ice: fix missing TX timestamps interrupts on E825 devices
Date: Fri, 30 Jan 2026 10:53:54 -0800
Message-ID: <20260130185401.1091523-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255225-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FB7FBE021
X-Rspamd-Action: no action

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Modify PTP (Precision Time Protocol) configuration on link down flow.
Previously, PHY_REG_TX_OFFSET_READY register was cleared in such case.
This register is used to determine if the timestamp is valid or not on
the hardware side.
However, there is a possibility that there is still the packet in the
HW queue which originally was supposed to be timestamped but the link
is already down and given register is cleared.
This potentially might lead to the situation in which that 'delayed'
packet's timestamp is treated as invalid one when the link is up
again.
This in turn leads to the situation in which the driver is not able to
effectively clean timestamp memory and interrupt configuration.
From the hardware perspective, that 'old' interrupt was not handled
properly and even if new timestamp packets are processed, no new
interrupts is generated. As a result, providing timestamps to the user
applications (like ptp4l) is not possible.
The solution for this problem is implemented at the driver level rather
than the firmware, and maintains the tx_ready bit high, even during
link down events. This avoids entering a potential inconsistent state
between the driver and the timestamp hardware.

Testing hints:
- run PTP traffic at higher rate (like 16 PTP messages per second)
- observe ptp4l behaviour at the client side in the following
  conditions:
	a) trigger link toggle events. It needs to be physiscal
           link down/up events
	b) link speed change
In all above cases, PTP processing at ptp4l application should resume
always. In failure case, the following permanent error message in ptp4l
log was observed:
controller-0 ptp4l: err [6175.116] ptp4l-legacy timed out while polling
	for tx timestamp

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4c8d20f2d2c0..0b7c2a13ab04 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1347,9 +1347,12 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 		/* Do not reconfigure E810 or E830 PHY */
 		return;
 	case ICE_MAC_GENERIC:
-	case ICE_MAC_GENERIC_3K_E825:
 		ice_ptp_port_phy_restart(ptp_port);
 		return;
+	case ICE_MAC_GENERIC_3K_E825:
+		if (linkup)
+			ice_ptp_port_phy_restart(ptp_port);
+		return;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "%s: Unknown PHY type\n", __func__);
 	}
-- 
2.47.1


