Return-Path: <netdev+bounces-272403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBB6Hp0yxmnzHQUAu9opvQ
	(envelope-from <netdev+bounces-272403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:32:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FAF340757
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19BE031A444D
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6D3CA4A1;
	Fri, 27 Mar 2026 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5vk7n78"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397753C3C07
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774596227; cv=none; b=tEoMCV+ZJLPabwDirVYCOG6f7gXHdhWMb6mSVQAGS16Rf/KATDsFwqHqlPwtz8MYLkY+cQDyuvcRwN9u4Fj3kkntj9BDjq3ngk4k45NpMlrt6Qs5piFIL8vwfueXBOy3h8rpw+MdnK21WS17KS1ItA8VZQ8rD6NpS206rwRoEhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774596227; c=relaxed/simple;
	bh=9uSQCaHx5lz2p4ZhV7LAX2lFsh0FH2XjuNQNioItOcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ok60DhjfX7lPCwtBvEQ5+bDh4Iemhm8thqTK0OQzmd9c11E3OBVJr1lOCMP4aleqydM2abzYe1aqSAhbHgl+tcOqOuUtWc/T6Unt1Qd1r5mO80zryKAozL2g9LH6oRfStwRdfoaL/UdbkS3GhexZLInCbEWVGOrnONx0bmDqw44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5vk7n78; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774596221; x=1806132221;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9uSQCaHx5lz2p4ZhV7LAX2lFsh0FH2XjuNQNioItOcE=;
  b=D5vk7n78cigzxOPh1plmPtdWVTHqvtcSMvAk0JcTZZ7B5KwCOdWRP6+h
   ypyQN9ZRHbuKMl4Awzp57RtBE5tC/vS+AC/BqUkkzkSAbePT5RM9WGKRS
   m09KKcuh2+st8fe4DkGvhtBuC6mcZ187+r/yVuRnjPlDYsfivKbU/s6lQ
   YTdyZIdMau/8lzBqe8Wp4/3CX+IRk/1M5WvqL4lHKRRVq8pdP46sz4zxk
   20mzunuKUNSaUgsanxBVPNI2qOE/DQp0+RhjYs7c8bjGeUR1D34jRIffD
   y2fF9kwwSdRBzjt8xoox35WDJDSqZUNcXzSJ1t9vjDECxH9aXXAkYKfOn
   g==;
X-CSE-ConnectionGUID: SrU6ZSmwRBO3/R8Wn4U9Mg==
X-CSE-MsgGUID: N7qG+h5OQdi/VP6noMx/ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75733971"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="75733971"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:23:40 -0700
X-CSE-ConnectionGUID: M4FA3blTQYOh29AetnDgSQ==
X-CSE-MsgGUID: VgGcfBsoTQO8SD+/k05pRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="255739093"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:23:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH net] ice: fix PTP hang for E825C devices
Date: Fri, 27 Mar 2026 08:23:27 +0100
Message-ID: <20260327072332.130320-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272403-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E9FAF340757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Change the order of PTP reconfiguration when port goes down or up
(ice_down and ice_up calls) to be more graceful and consistent from
timestamp interrupts processing perspective.

For both calls (ice_up and ice_down), accompanying ice_ptp_link_change
is called which starts/stops PTP timer. This patch changes the order:
- while link goes down: disable net device Tx first (netif_carrier_off,
  netif_tx_disable), then call ice_ptp_link_change
- while link goes up: ice_ptp_link_change called first, then re-enable
  net device Tx (netif_tx_start_all_queues)

Otherwise, there is a narrow window in which PTP timestamp request has
been triggered and timestamp processing occurs when PTP timer is not
enabled yet (up case) or already disabled (down case). This may lead to
undefined behavior and receiving invalid timestamps. This case was
observed on E825C devices only.

Fixes: 6b1ff5d39228 ("ice: always call ice_ptp_link_change and make it void")
Cc: stable@vger.kernel.org
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---

 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e7308e3..8896805 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6797,10 +6797,10 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    ((vsi->netdev && (vsi->type == ICE_VSI_PF ||
 			      vsi->type == ICE_VSI_SF)))) {
+		ice_ptp_link_change(pf, true);
 		ice_print_link_msg(vsi, true);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
-		ice_ptp_link_change(pf, true);
 	}
 
 	/* Perform an initial read of the statistics registers now to
@@ -7328,9 +7328,9 @@ int ice_down(struct ice_vsi *vsi)
 
 	if (vsi->netdev) {
 		vlan_err = ice_vsi_del_vlan_zero(vsi);
-		ice_ptp_link_change(vsi->back, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
+		ice_ptp_link_change(vsi->back, false);
 	}
 
 	ice_vsi_dis_irq(vsi);
-- 
2.52.0


