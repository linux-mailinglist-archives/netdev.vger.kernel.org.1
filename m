Return-Path: <netdev+bounces-269781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMONAqTVvGkk3gIAu9opvQ
	(envelope-from <netdev+bounces-269781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD832D5E0E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38B023046013
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C72E6CA6;
	Fri, 20 Mar 2026 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cp8XB1B/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD942F4A15
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983125; cv=none; b=cL838QzLj2YUV2FTG4dBm1uEh3ER1iC90O6+xTq3QRARBLVgeiPCcGrif4davLLLchwFT21Q0PM4H4fRQSdtls/HPgFRNgq04XVqd7jh1YFfSg4JpCVbKT4GN1Ro4S8jiA6VVijtCsEBPYuUe0FYf4zCPKxVD3FTNuCqum7XKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983125; c=relaxed/simple;
	bh=8ZWGNDi1aSVI1IuxFKpsRXwy8mPHZadPbWAw94yJHdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pme5rm586J2yL548XeWgtFTOsO38U6tMeiYusiMBrDojHA7yNgHw6HZi0cxoVRn5Jj7OdxIK8lxOw1jV2tboJW7DW0h5FfU14oZmX7vqfDOYM61nKRpImNNdb8AYeldn/++MPSIfhzFiQBtinL1teX/TvfMi84AlG2ogzlITGuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cp8XB1B/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773983124; x=1805519124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8ZWGNDi1aSVI1IuxFKpsRXwy8mPHZadPbWAw94yJHdg=;
  b=cp8XB1B/5fdUy3INeXM/BwtJgX5ixxMw0b30nGzn/3VWzn3z1vx9+tG0
   5qygAuUHMHV3862rh3+QERC0hL/NAEEeVGpXQq8+onEn+ru2lqKdqNgpu
   Cn1/Eo3I3MNRAz6j+33508J0TDQVVrkPdy7OOSk/j41947HGFwP+ATU3b
   EBCAd73kKrcpFsboCmS4wXnZap51J+DBCVN+CLinLObNY0cB5R6AM3XPy
   5Rxdeh3Svo2qgD9GM4AlrdirjxCl6RbMZYWaTgCrn6N7dvZbkMlzSp14z
   TGk+n1k+e0fNHvlIUPCQ8OlnF31dEXW42rwKKsMOJWyTlEoqV8I2X4BrO
   Q==;
X-CSE-ConnectionGUID: BCN9EPv8S5ShpuVvibPq9g==
X-CSE-MsgGUID: G2bwW9oVQOmawFLz8m/Npw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522672"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="100522672"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:05:24 -0700
X-CSE-ConnectionGUID: 69ID/x0OQ7qB4JF8LbFeeg==
X-CSE-MsgGUID: CDiNqmjpQcCprYMaXOC/fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227307237"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:23 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Subject: [PATCH iwl-next] ice: call mutex_lock() before mutex_unlock() in ice_dcb_rebuild()
Date: Fri, 20 Mar 2026 06:05:22 +0100
Message-ID: <20260320050522.422355-1-aleksandr.loktionov@intel.com>
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
	TAGGED_FROM(0.00)[bounces-269781-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6BD832D5E0E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>

In ice_dcb_rebuild(), the first call to ice_query_port_ets() is checked
for error, and on failure jumps to the 'dcb_error' label. The error path
always calls mutex_unlock(&pf->tc_mutex), but at this point in the code
the mutex has never been locked -- mutex_lock() came after the check.

Releasing a mutex that was not locked is undefined behaviour and can
cause a deadlock or crash. Fix this by moving mutex_lock() to before
the error check, so that 'dcb_error' always pairs with a prior lock.

Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..d516734 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -538,12 +538,11 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	int ret;
 
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
+	mutex_lock(&pf->tc_mutex);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 
-- 
2.52.0

