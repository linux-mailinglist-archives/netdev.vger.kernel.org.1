Return-Path: <netdev+bounces-274891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Co7C5pTz2kCvQYAu9opvQ
	(envelope-from <netdev+bounces-274891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:43:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7E33912BC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6669306B1B4
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB0235A3BF;
	Fri,  3 Apr 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbEFtxZW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144FF30C632
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194845; cv=none; b=Z9ijsUyq2ev5mjObjJWVwJUeb8Axxdg661mMfkG1dgNpqA0D8aaqCb5smzodjyCQzff4rpNeQy2XigRXShHc+6RMWOUZFiPNmAkQW3wtbI10xLUsDlk5uWcXRibsAwHGZhqSeHsKA1F0HY/Dkj317D47N95O+lGIweDqS+czC5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194845; c=relaxed/simple;
	bh=F7RgWTesnS6mroPwa/SCLsP5F6li6P4/GknCZnn6Uf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkcPC3In2eq1RTm+110Vtk0GCLMCMM2eZz8sT8ynzU/lscz9Ne9tUuoY3XvK2dklsu2K5p6hpNTXjntmXcA0k1UiC5LbZg8Y0CI5vL+TX9CvK8vbmvqr9Ik4EbJrbAEKGchAXJq+pHiH5RA9HUshziUNC+ZDXbklBXAyWYUqTNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbEFtxZW; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194844; x=1806730844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F7RgWTesnS6mroPwa/SCLsP5F6li6P4/GknCZnn6Uf4=;
  b=cbEFtxZWWjlNrkURGvQJAD/LHD1GsY0/Tk6vtRqGRClErg2fcxWrTe9P
   /B4m4GYTl68PItQu2kZQ9v6aSw4UL7WExDb9m+AH3ISP76hCrTTAtcoql
   IMeKzJgd2Doc/5ojLSf1BXjgE/Vyen0FOjaxqboxhCccX9BYXJ0ny8Nsb
   duoXq7gAcWd0mIqJMTYI4bEYUTc7EVM9RiKnMcAALXU9TMapzxn5iSLI6
   i8XwjcZ1+lnoch/mMSrmntYMDKju4YBrOr61LRWnfOZwGUL0RE/G42vaT
   saYIqTpieVO69J/SxMzaMwR9JafYXwUyfD0UIZlbzkfIHvXQPRkOcSh1m
   Q==;
X-CSE-ConnectionGUID: ixT7NZgiQo6uVn8vrG3Rrw==
X-CSE-MsgGUID: VAvjEElgQeiI5SFHv0w/QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981757"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981757"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:44 -0700
X-CSE-ConnectionGUID: qzKWIIJ5RJmmQg5Xc7kKVg==
X-CSE-MsgGUID: sioIDpPGTyOwgpU8b/YsFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904948"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:42 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@intel.com>
Subject: [PATCH iwl-net 9/10] ice: select inner TCP dummy packet when matching on ip_proto TCP without explicit L4 field
Date: Fri,  3 Apr 2026 07:40:27 +0200
Message-ID: <20260403054029.3789616-10-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274891-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E7E33912BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When building an advanced switch rule, ice_find_dummy_packet()
selects the template packet type based on the lookup element
list. It currently checks for ICE_TCP_IL to select the inner
TCP template, but ignores the case where the user matches on
ICE_IPV4_IL with protocol == IPPROTO_TCP without specifying a
TCP L4 field. In that case the default UDP template is chosen,
causing the rule to fail.

Extend the check to also match ICE_IPV4_IL with TCP protocol
field fully masked, fixing tc-flower rules such as:
  tc filter add dev vxlan100 ingress protocol ip prio 0 \\
    flower ip_proto tcp action mirred egress redirect dev eth0

Fixes: e33163a40d1a ("ice: switch: convert packet template match code to rodata")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index bb0f990..c2ac870 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -5587,7 +5587,10 @@ ice_find_dummy_packet(struct ice_adv_lkup_elem *lkups, u16 lkups_cnt,
 	for (i = 0; i < lkups_cnt; i++) {
 		if (lkups[i].type == ICE_UDP_ILOS)
 			match |= ICE_PKT_INNER_UDP;
-		else if (lkups[i].type == ICE_TCP_IL)
+		else if (lkups[i].type == ICE_TCP_IL ||
+			 (lkups[i].type == ICE_IPV4_IL &&
+			  lkups[i].h_u.ipv4_hdr.protocol == IPPROTO_TCP &&
+			  lkups[i].m_u.ipv4_hdr.protocol == 0xFF))
 			match |= ICE_PKT_INNER_TCP;
 		else if (lkups[i].type == ICE_IPV6_OFOS)
 			match |= ICE_PKT_OUTER_IPV6;
-- 
2.52.0


