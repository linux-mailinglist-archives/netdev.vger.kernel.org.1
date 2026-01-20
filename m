Return-Path: <netdev+bounces-251446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iM64LHFYcWkNEwAAu9opvQ
	(envelope-from <netdev+bounces-251446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:51:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D65F13F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D687752A006
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026FA410D08;
	Tue, 20 Jan 2026 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2VZe6kN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F040FD93;
	Tue, 20 Jan 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905290; cv=none; b=QJZ2WHpWi4t47wMiNfld+Y/vpVJMt4FrnpXWV9ZBUStCTRnazDJVhXqSzaLW+gkQ+AkaRUJufU926NMc2SJ2/rwC0f4H1BiNrp+o9AKteDb0ByImyAqnRgjwA2QG5sQgrtNwzrJbBWAP6a3Xx66wwjnEUT/u73MWTG42xb1CPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905290; c=relaxed/simple;
	bh=aDADJULyrOXAsvln2yMJyhXY1pU5VH5XFxcMbCSZkys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kVlroVf1w235hsLpQ5e5LFLlZ+K44fa5ynTKc+IfhFxLlSm6ODoo+kf/LZ8hwKiLOWGOh8D1xlhayT7xK+CBu4AbncXyGv4zcJZMKxS3gePdk+IX0wwYKKrfL5HNauBxwjH82Ig8nLq1RkPARKSzHjEPAb7TJgNI9OCuOD2P99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2VZe6kN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768905289; x=1800441289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aDADJULyrOXAsvln2yMJyhXY1pU5VH5XFxcMbCSZkys=;
  b=L2VZe6kNCM3mJ5p2XUQYmtvbF113TMRABVW4SztMA2iipDstGV9BCu3v
   ZeXpvUzu5ojQwSgV8yvqtaDpdz1HNUZYaXnnTXmLRTTQoBVm+xjxggJH+
   lY3BOJxnX+GU1MRkYaJe3iYlJL88+wWaA4olK5HakOUxlCiLVfTNDpyHC
   yNzh//oTEzv9C5Uet77aNJLM27oTuI3gkzeGMcG1hh4ra0WpRGYOqq85L
   oruSY7VweHb45MKeCOw9Jegl8YO+qBqL5FRW65QGrjXDAAIWRzjRS/5vT
   x4b32FCGeGcaBC6fxGXdY4fSI9rQowrEdKM2D1iHjQsqHGqWbm1H6h2Ub
   A==;
X-CSE-ConnectionGUID: nEmRUv3TRMCqFe9v7pFLHA==
X-CSE-MsgGUID: UKNwLt+JQwWnbAYwjCuRGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70161741"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70161741"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 02:34:48 -0800
X-CSE-ConnectionGUID: NvYLKDxGQyWBfxmtwkNDqA==
X-CSE-MsgGUID: fapk4ngNSNiiB7Fsj00qqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210935853"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 02:34:47 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v3 3/8] ice: do not check for zero mac when creating mac filters
Date: Tue, 20 Jan 2026 11:34:34 +0100
Message-ID: <20260120103440.892326-4-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120103440.892326-1-jakub.slepecki@intel.com>
References: <20260120103440.892326-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	DATE_IN_PAST(1.00)[36];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251446-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 333D65F13F
X-Rspamd-Action: no action

A zero MAC address was considered a special case while creating a new
MAC filter.  There is no particular reason for that other than the fact
that the union containing it was assumed to be zeroed out.  Now, address
is pulled out of the union by ice_fltr_mac_address which checks all of
the previously assumed zero-address cases and returns an error if they
are hit.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v3.
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 0275e2910c6b..04e5d653efce 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3648,7 +3648,7 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		u16 hw_vsi_id;
 
 		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
-		if (err || is_zero_ether_addr(addr))
+		if (err)
 			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
-- 
2.43.0


