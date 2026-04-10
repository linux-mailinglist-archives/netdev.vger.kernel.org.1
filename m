Return-Path: <netdev+bounces-277287-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIxSE8Gr2GkmgwgAu9opvQ
	(envelope-from <netdev+bounces-277287-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:50:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C63A43D3969
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CED130247D8
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54933263B;
	Fri, 10 Apr 2026 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRcXG1al"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF93A168B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775807367; cv=none; b=g4uWemSyoz3hwEnlhMWMLkvu2nalJsTUdDIwKL6oQ0wYdPvVI2NwUqdeQUQxPMzqbueZj7opydYiDkUW2up1zSPu1fju2ptk7kVi/hFgVAjCDhIMrR+Pr9LodwxZKCgoJwyBLc22uAgt5HXCQ1WVag3EygyiT2MoOmgj2iKZUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775807367; c=relaxed/simple;
	bh=8mVlqUSKhLghunpKta0EtGrvQtVkNh/RcZcNL/hOjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s84N2uIMdaa2qtJVlqwafl/Z9Jif+dTYwyUhwx6EQBq2pySWxjYfKz5yjXvAFrUpW0PAZUei9I7pdu8ZvaGfaS9se52uzlfbHKKHR4OOjo4/Blq9/TX2ws89s3coPDUF24UM8bmTpGoo+xerJ/r8jCE+BPgZqEnTOnQx1N9Zs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRcXG1al; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775807366; x=1807343366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mVlqUSKhLghunpKta0EtGrvQtVkNh/RcZcNL/hOjQ0=;
  b=CRcXG1al264lCIo3yohwbM/8Oe21Cko/wCzX+EPsDR2HW9LKIMOg5Hoc
   IK4P1GGHE+YCN6EAN14aTkJAzNgHy+FEVbItnchvJvdDrPhN5Nd0hlaWJ
   El7Kezv8XQ2cJAqgErg5ZIZOWL8HnOd2ct2aDU46XH3uOOVlDPfPElpwr
   Z2Iz7V2MLpqQzsNj68cS+H0w7SXiFm5lzY1PLFPTwLTFAtXTveAR6pbGE
   YgDAv9b1GvRhcamyF6mHiCv6cyPiSfMeX5ngYW36WgHHQ9DBRT/B/gxC2
   /fOw0VDKRXYz6xikF67VpN/HP00QFj0gQLg0L2vjTwv4DUMrtRfIGrZnR
   g==;
X-CSE-ConnectionGUID: cvVhvUvNT4C1KMGkF5lqBg==
X-CSE-MsgGUID: cQHfOLzAQpO2rsd8UQ9Now==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007920"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77007920"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 00:49:26 -0700
X-CSE-ConnectionGUID: NXkxgQrHRIWOeCDQHAq+QA==
X-CSE-MsgGUID: /rvw9uVTS4i3Q+0nyNpQbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228941849"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:24 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH iwl-next 1/10] ice: translate FW to SW for max num TCs encoding
Date: Fri, 10 Apr 2026 09:49:12 +0200
Message-ID: <20260410074921.1254213-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-277287-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C63A43D3969
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dave Ertman <david.m.ertman@intel.com>

The FW uses a 3-bit field in a TLV to represent the maximum number of
Traffic Classes supported per interface. Since the maximum value is 8,
and at least one TC must be supported, the encoding uses bit values of
000 to represent 8 TCs.

The driver currently does not translate this value and reports 0 max TCs
to the DCBNL interface instead of 8.

Add a translation when interfacing with the FW to use 0x0 as the value
for 8 max TCs.

Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb.c | 2 ++
 drivers/net/ethernet/intel/ice/ice_dcb.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.c b/drivers/net/ethernet/intel/ice/ice_dcb.c
index 7be1fa7..f15c6fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.c
@@ -221,6 +221,8 @@ ice_parse_ieee_etscfg_tlv(struct ice_lldp_org_tlv *tlv,
 	etscfg->willing = FIELD_GET(ICE_IEEE_ETS_WILLING_M, buf[0]);
 	etscfg->cbs = FIELD_GET(ICE_IEEE_ETS_CBS_M, buf[0]);
 	etscfg->maxtcs = FIELD_GET(ICE_IEEE_ETS_MAXTC_M, buf[0]);
+	if (etscfg->maxtcs == ICE_DCB_MAXTC_ENCODE)
+		etscfg->maxtcs = ICE_DCB_MAXTC;
 
 	/* Begin parsing at Priority Assignment Table (offset 1 in buf) */
 	ice_parse_ieee_ets_common_tlv(&buf[1], etscfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb.h b/drivers/net/ethernet/intel/ice/ice_dcb.h
index da57497..285c5f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb.h
@@ -109,6 +109,9 @@
 #define ICE_DSCP_TC_BW_TLV_LEN		25
 #define ICE_DSCP_PFC_TLV_LEN		6
 
+#define ICE_DCB_MAXTC			8
+#define ICE_DCB_MAXTC_ENCODE		0x0
+
 /* IEEE 802.1AB LLDP Organization specific TLV */
 struct ice_lldp_org_tlv {
 	__be16 typelen;
-- 
2.52.0

