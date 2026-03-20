Return-Path: <netdev+bounces-269782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMYuLJvVvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB62D5DEA
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B20303012D1A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB22ECEA5;
	Fri, 20 Mar 2026 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbJpkX8g"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316AB2E6CA6
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983129; cv=none; b=cwSCOG+mkDRePdpkmCxdh4A/QBeEJmRUfFGYEYLdu/1v8tU1MiMY/qALvNvQPSh4R4ggwasXZTt1DFT99zQ5klBGZ/mjk/GoCMpdSusg06OmdiWhOsscT29/o7sjxtYNX75mmf00uLIZ4fAEhh+XiWdaywrrpriVvdPGBUEtOJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983129; c=relaxed/simple;
	bh=sMYN8X7qNO1iGxn2GsYKDoTb5BxCksdCw6mKKX/zlyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpkLysu11TYRjo5WK5Cl/8JOP2y7xZUslBEPuM8Z9oqaFKRR8zBm64s8fihdhMOIvA0EnbBv7T7h2ROWm4yvX92qKJwV78vEYY7gTIz3bix1iEdYrLHjqIetsaHPEejK1Q2lgUVpF5rIwpGlbOPsOEAPj7/CDkhgXzBRtmi+t0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbJpkX8g; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983128; x=1805519128;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sMYN8X7qNO1iGxn2GsYKDoTb5BxCksdCw6mKKX/zlyY=;
  b=GbJpkX8gGI7s5x9we9rAiGCec5fzjAcxhMtvjbZzZyE2gC+9v8u/nN02
   A99fWuLTfMRe1jBixtil7o+yjwJ3oU1hcknXm72peDzHBWqFhZRmIk2hd
   X44032LOyVqIMJ5KUhGEncx27IGQS0tQz/CJiy5pZijtirgyy76GYDmAi
   IeRNxuPQud7py4/3OozUojvBDpQeOoHgQEBHLwWEvKsTesgRjOo7KorOx
   70FzC2oKFAeM3T3gyvEz8uPk29EZGuXsN2CUBlvYs1IJrkLAv+z/JOWKS
   GbRXoa7IjV7B9HEs5i+CaryudXrESXZEigT7JR2yeMwNo/5OckA2JVX7t
   A==;
X-CSE-ConnectionGUID: OKPzIW/aSqeAzYnfcU8V6g==
X-CSE-MsgGUID: Bb3Q+dbCQnqnRvJs9so+DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522690"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522690"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:28 -0700
X-CSE-ConnectionGUID: jbAqDc0eQBGK9cU52IbpUg==
X-CSE-MsgGUID: AUNUR6oSQEmoov9sxsTYQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307249"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:27 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next] ice: do not carry link status over to link event data
Date: Fri, 20 Mar 2026 06:05:25 +0100
Message-ID: <20260320050525.422403-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269782-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4ECB62D5DEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tony Nguyen <anthony.l.nguyen@intel.com>

Since we now report changes from the link event and changes that
occurred from update link info, there is no need to carry the latter
info over as it will be handled appropriately by itself.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e7308e3..348c86b 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1127,12 +1127,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
 
 	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
 
-	/* Check if the link state is up after updating link info, and treat
-	 * this event as an UP event since the link is actually UP now.
-	 */
-	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
-		link_up = true;
-
 	vsi = ice_get_main_vsi(pf);
 	if (!vsi || !vsi->port_info)
 		return -EINVAL;
-- 
2.52.0


