Return-Path: <netdev+bounces-289442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9JI6tWDGqUfgUAu9opvQ
	(envelope-from <netdev+bounces-289442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:25:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96A57EA0A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D052E30D0D09
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123F4DB56C;
	Tue, 19 May 2026 12:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9feTK7S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10980352000
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193280; cv=none; b=Okuqi64DZX1Vi5mnX/Aaf1dHqAZSfC1T8ARUUDQZEg71/3thHTjZGb9wI2w0yZFpcFpK98nk9FNW3iNU12Qy2bsh1fKUNmbNsJOH28zYxQb4oPbf7KQSLAu9ZL2DeDgEM6wTCTqDacj5JLTtGWz8+uEPm6Y7m2Z37rLIzlVm1u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193280; c=relaxed/simple;
	bh=4YPC6McjepweewladknEsCxM3GMex0C/sNPCjbzCacw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/J3Id1ZUKDGNbYk0Ha1zHPdJNW07irUq8drQwLMcPk+ocdYQmWcj+eSW49uzsZu/08rfi+r93yL3hTJohYN56xxPbZ4ZvlbZyTkxwq1SJCLPb0vTa9FnzuyxPZup5ElVTB/5yfUqjhFhHGbrLkP5nEzDST5+Wm62agtNQMU8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9feTK7S; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779193279; x=1810729279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4YPC6McjepweewladknEsCxM3GMex0C/sNPCjbzCacw=;
  b=Z9feTK7Si78cfu6srkcKLjZvWpDWDDfU7IxRM4Av6EY5JJUZ1xhSi1af
   p5BtNMRcjXoLnGiW5sDiqc0P+XGtdhHZtogAev9XArPlxCVzpdrdS4Eqm
   TAov/0hXJTJlgrls7wTZCz0tYfMp1fNPs2//il+XWIM9Ou+wAI4Iuov0S
   PgP+Gw5rb8jrt24aInlqM5iU1AnlWud7Q9fxTT5wHVqjiSsOXDhwMNMqO
   Bsis5nYnw0DaS8IIumCfaJEgHlD39ELujK7TsJAhtjiHE0V9s2x+7SP42
   cBWL3alA1wqi9jOJ2w1EnN6ETsQNnNbtmf3sLutgFieDj5M59/R3Q4axA
   g==;
X-CSE-ConnectionGUID: gY9ECYGQThagJBW6bAgmjA==
X-CSE-MsgGUID: kkQRqxx5QT2P8jueaKygoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80048317"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80048317"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 05:21:18 -0700
X-CSE-ConnectionGUID: kGmWhDvgRDGtKOqOmV/IZA==
X-CSE-MsgGUID: C7TeWnBBQkazB3t5dD/MtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263533568"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa001.fm.intel.com with ESMTP; 19 May 2026 05:21:17 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5B18528765;
	Tue, 19 May 2026 13:21:16 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH iwl-net] ice: fix LAG recipe to profile association
Date: Tue, 19 May 2026 13:20:41 +0200
Message-ID: <20260519112041.125907-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289442-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0D96A57EA0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ice_init_lag() associates recipes to profiles, assuming that Link
Aggregation-related profiles will always have profile ID lower than 70
(ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER). This value seems arbitrary and
might not always be valid for some versions of DDP package, i.e. LAG
profiles may have profile ID greater than 70. This would lead to
misconfigured switch and LAG not working properly.

Fix it by checking up to maximum profile ID.

Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 310e8fe2925c..08a17ded0ad5 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -2623,7 +2623,7 @@ int ice_init_lag(struct ice_pf *pf)
 		goto  free_lport_res;
 
 	/* associate recipes to profiles */
-	for (n = 0; n < ICE_PROFID_IPV6_GTPU_IPV6_TCP_INNER; n++) {
+	for (n = 0; n < ICE_MAX_NUM_PROFILES; n++) {
 		err = ice_aq_get_recipe_to_profile(&pf->hw, n,
 						   &recipe_bits, NULL);
 		if (err)
-- 
2.49.0


