Return-Path: <netdev+bounces-279240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOXfMi/U4WnQyQAAu9opvQ
	(envelope-from <netdev+bounces-279240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:33:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5738F41772A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F13913156EA8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B28235C1A0;
	Fri, 17 Apr 2026 06:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNcr1uSX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E7305E32
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407404; cv=none; b=kroV8cfoRWc4doy0eGkkYQJfJewlSOht+Nj25LnSi+XFsqVKsfDHX/HdqKBs94pAYtKuUICiHk1LMLXsLh1KxM9TB+tbgfmPd34eg2noa94Fqw+1u590t/ahiUsPOYyRuyMFpDxOMbeDXDHlPohxmDaSBNPjL2+2PQ19ZrescjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407404; c=relaxed/simple;
	bh=7L6VA3PZUKux3AxTYEpm8UYEmpwXMNVpW+4meJHVd6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZmkYWwJ+9jhYARQQeY6i6A/AuasEH6XRlfJ6yOL780P4s2tWXLhjnO7uLC19PjiES/OY9iVW/LE0Q1Qs8zgf94mlara8LUnvA+3Plpd2Qabry8N17rIUBvZ8739Z8YAwh/ojZsUuWzd1ni5qGR+Te59Gge5hTF/yq0F482KKSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNcr1uSX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776407402; x=1807943402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7L6VA3PZUKux3AxTYEpm8UYEmpwXMNVpW+4meJHVd6M=;
  b=FNcr1uSXoIUZmfMSaf28RHEIuPp7hz7mEE3qhro+Q+0PiiPp+5iwhz2D
   1j59ykuSZQIXKI0+1TL8jRg5ApJL8z0aqogqnUAXghD2Y3dT0Twgp2BUj
   0QPRIRv+HLCaN64VB1tf2TnloLFOM6q3MHeEnd2IdsoSY53dBRVNzpqlz
   gnLld1fSMwXP3NexaaHY2c6m2StagUmSPwqL724NzFJQRQ87Hewq77oSy
   10kpkojK1nen2/mV8U4AWaO1w80N8AVX8FuGeFOg7GBKtzmEkVTiNpaj0
   Rpnxfhd8LCLn6jROcmZWzXGPGRyuBGctGRajGQFdULiyDnUW7eik1E1Sq
   A==;
X-CSE-ConnectionGUID: +IYlz5BlS+ylOusjvRmpUA==
X-CSE-MsgGUID: E4flkkcFTTWLWnLYkDkAhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="94987404"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="94987404"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 23:30:01 -0700
X-CSE-ConnectionGUID: +zhchXy6S4KgNHpBceHZRw==
X-CSE-MsgGUID: UrsdLreaQ8y9jqY/oj9ehw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235329575"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 23:30:01 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: [PATCH iwl-net 3/4] ice: support RDMA on 4+-port E830 devices
Date: Fri, 17 Apr 2026 08:29:53 +0200
Message-ID: <20260417062954.1241900-4-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
References: <20260417062954.1241900-1-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279240-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5738F41772A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

E810 and E82X devices do not support RDMA on configurations with more
than 4 ports. This limitation does not apply to E830 devices, which
have a different hardware design and support RDMA regardless of the
port count.

Narrow the RDMA capability disable condition to skip E830 devices.

Fixes: ba1124f58afd ("ice: Add E830 device IDs, MAC type and registers")
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index ce11fea..0e40011 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2509,7 +2509,7 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %d (based on #ports)\n",
 			  caps->maxtc);
-		if (caps->rdma) {
+		if (caps->rdma && hw->mac_type != ICE_MAC_E830) {
 			ice_debug(hw, ICE_DBG_INIT, "forcing RDMA off\n");
 			caps->rdma = 0;
 		}
--
2.52.0


