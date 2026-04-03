Return-Path: <netdev+bounces-274884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHQ3O+NSz2nqvAYAu9opvQ
	(envelope-from <netdev+bounces-274884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:40:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 696AB39121E
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 07:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACC733049537
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7689E3191BA;
	Fri,  3 Apr 2026 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n22A4tTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAE9359A9B
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775194836; cv=none; b=Qoqb+Zb0w/huPhkgE0WRYPA2TQ31Z0Utz6AueTKAz46tGRO0vvUtmnJAehvlSYhWgi1wnO+0+gG5Xd+UWm+xdm8Lb+J++oHBgSjygqbDG2uiLlunVYBsFrXpu9lJP+tAqIIWlBpI/Mckg0XxFCqggqYtfmswoatScOjYHYFLSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775194836; c=relaxed/simple;
	bh=4SetMd8mZKvQCSRcPieNR/Q4dweJ+wEjZtdoJ2n6YU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgXRI4HxoiOc0fbDIeR624N9Kk0asp6OhkOfC5BvCG9S87EEAQadYt3+UuirCsjSzj/RDbCbykBdhQjZUvCbeJabNoJ79QS846zuKoSMGLeZhpQjyY/Jg7I3rPUH3XJdheM8CnSVXQgiaF05bOl5zy9WX8qsbNuU0MQYw5Dflv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n22A4tTA; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775194835; x=1806730835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4SetMd8mZKvQCSRcPieNR/Q4dweJ+wEjZtdoJ2n6YU4=;
  b=n22A4tTAgqKVzAGMKF4oMoyIznUdvfIY0grrhBaR+zqucrfNtu5YzZNy
   glgUTCQLt4THJXYljb/JZdt7f6UMvYrsc2dy47hkN9Q6LuwqlR2h4ocBF
   dK4USWVYUrq91kr/AdhUa5DKdzhzD+cMK3dEQYeNVszThBIB4CG1/hajx
   zktwqvijR7tFYAY+a5tG7keK/GPOqp9krGuX6U4OWfWPl5BNfBLsMLwCE
   jtP19AY+4qRM6EihvDyphimomE7mf8824VZGPVDuYFwwHprLnXDP4cll1
   Zn3uaFpT3zuoVhqqRhXuCeDfs13WL9adpIhNf2OmAxycZ7sB+zhjB13/Z
   g==;
X-CSE-ConnectionGUID: JZwnrXSERpeVH5eL6XOW8A==
X-CSE-MsgGUID: Tp0Sf9grTkyPMCHlPTc1SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="75981741"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="75981741"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:40:34 -0700
X-CSE-ConnectionGUID: dJvPbdxvRq6eXaDMyo6WoQ==
X-CSE-MsgGUID: W/ZDutBATP2QJMcCCfXdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="223904917"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 02 Apr 2026 22:40:33 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Dave Ertman <david.m.ertman@intel.com>
Subject: [PATCH iwl-net 2/10] ice: update FW on all DCB changes
Date: Fri,  3 Apr 2026 07:40:20 +0200
Message-ID: <20260403054029.3789616-3-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274884-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 696AB39121E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dave Ertman <david.m.ertman@intel.com>

Currently, in SW DCB mode, if a new DCB configuration comes in that
only changes the TCBW table or the TSA table, the driver does not treat
that as enough of a change to reconfigure the FW settings.

Change the check for reconfiguration needed to include these singular
changes as significant.

Fixes: a17a5ff6812c ("ice: Refactor the LLDP MIB change event handling")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 0b194c8..43978d8 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -481,13 +481,17 @@ ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
 
 		if (memcmp(&new_cfg->etscfg.tcbwtable,
 			   &old_cfg->etscfg.tcbwtable,
-			   sizeof(new_cfg->etscfg.tcbwtable)))
+			   sizeof(new_cfg->etscfg.tcbwtable))) {
+			need_reconfig = true;
 			dev_dbg(dev, "ETS TC BW Table changed.\n");
+		}
 
 		if (memcmp(&new_cfg->etscfg.tsatable,
 			   &old_cfg->etscfg.tsatable,
-			   sizeof(new_cfg->etscfg.tsatable)))
+			   sizeof(new_cfg->etscfg.tsatable))) {
+			need_reconfig = true;
 			dev_dbg(dev, "ETS TSA Table changed.\n");
+		}
 	}
 
 	/* Check if PFC configuration has changed */
-- 
2.52.0

