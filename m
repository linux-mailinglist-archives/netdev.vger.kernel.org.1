Return-Path: <netdev+bounces-251635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNnSFl4HcGlyUwAAu9opvQ
	(envelope-from <netdev+bounces-251635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:53:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2E94D4F8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 23:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B7B46860
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DF53E95A0;
	Tue, 20 Jan 2026 22:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5ARKekj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544483D4101
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949100; cv=none; b=XjLQ4ULaIadRo9Hfk6+66Svf9amahxUCo21xcFYGexgMtE0Ut8taTTRPKSgEPcO0F7X8hIuISrFhLuOdbp/AQO8RhxrxAobOHX0qthQOTjRAQkstoGwvbhMC4bngJNLvLDUmgr2p8O/YiOGCDBeocVMhrDL4bF9U9zCZT/tQ574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949100; c=relaxed/simple;
	bh=TJXdRqR4/ykobX7D3hdfIsfzCbD1JmxH/Q5NyTXCyOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nj9xth+eVZV0fPPwUW1KnIPl5hbpWJ9wtD/iKEBd0HBN156daWslZ6A7mvLmM4Ya1v+hG53r1NVQ6IcnXA9LCYd8cqjSUg457hmxFx6RTu7i1Hz1frPd1f+RnJ36jVI+lHvYvOKfzyHcof7801juR365bWElv3EQjR/3KywUYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5ARKekj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768949095; x=1800485095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJXdRqR4/ykobX7D3hdfIsfzCbD1JmxH/Q5NyTXCyOg=;
  b=T5ARKekjANbIdeJPfNDTagamsAleubyepRGPrNwIMppqFXZeOf/vgzcT
   wFLNyr7emB6PD2XW0Y7GRLn22gdoXn5vLAw/eoGE7g31lhqjNg6xATl2c
   wkhLCG+uXNBGwIOTPlI5f18eZreQLNmeBrBlVMRr9mHyy8hU2xID0kOFg
   MqfdGGWHuwY/KUmAWwYGQXGZLyHMA7Sol1o2bDALIN0+1v0zmHJJklcUi
   okE8Xlgel7ZL2M3U8iM/Spr+6asgqWWxXtIwzayxNF8QvzfjOLKdwCB7C
   QPAsoW9r+XTAzUupirKr1xvxh3xu4Nq5jLgVREyfM97FhbWwqG3kdALKE
   w==;
X-CSE-ConnectionGUID: 1+4GRrNrRTClrnbAwLbvPw==
X-CSE-MsgGUID: eRJzSFOoSaCXce6rD/nhjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="81548804"
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="81548804"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 14:44:38 -0800
X-CSE-ConnectionGUID: Ke9WWnBzRWaMUC2KP9JByA==
X-CSE-MsgGUID: 2gJCmoq1Rm2s9t9QoeEEQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,241,1763452800"; 
   d="scan'208";a="236920159"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 20 Jan 2026 14:44:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/4] ice: fix devlink reload call trace
Date: Tue, 20 Jan 2026 14:44:27 -0800
Message-ID: <20260120224430.410377-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
References: <20260120224430.410377-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-251635-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: DB2E94D4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 4da71a77fc3b ("ice: read internal temperature sensor") introduced
internal temperature sensor reading via HWMON. ice_hwmon_init() was added
to ice_init_feature() and ice_hwmon_exit() was added to ice_remove(). As a
result if devlink reload is used to reinit the device and then the driver
is removed, a call trace can occur.

BUG: unable to handle page fault for address: ffffffffc0fd4b5d
Call Trace:
 string+0x48/0xe0
 vsnprintf+0x1f9/0x650
 sprintf+0x62/0x80
 name_show+0x1f/0x30
 dev_attr_show+0x19/0x60

The call trace repeats approximately every 10 minutes when system
monitoring tools (e.g., sadc) attempt to read the orphaned hwmon sysfs
attributes that reference freed module memory.

The sequence is:
1. Driver load, ice_hwmon_init() gets called from ice_init_feature()
2. Devlink reload down, flow does not call ice_remove()
3. Devlink reload up, ice_hwmon_init() gets called from
   ice_init_feature() resulting in a second instance
4. Driver unload, ice_hwmon_exit() called from ice_remove() leaving the
   first hwmon instance orphaned with dangling pointer

Fix this by moving ice_hwmon_exit() from ice_remove() to
ice_deinit_features() to ensure proper cleanup symmetry with
ice_hwmon_init().

Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6a9278487ccb..de488185cd4a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4836,6 +4836,7 @@ static void ice_deinit_features(struct ice_pf *pf)
 		ice_dpll_deinit(pf);
 	if (pf->eswitch_mode == DEVLINK_ESWITCH_MODE_SWITCHDEV)
 		xa_destroy(&pf->eswitch.reprs);
+	ice_hwmon_exit(pf);
 }
 
 static void ice_init_wakeup(struct ice_pf *pf)
@@ -5437,8 +5438,6 @@ static void ice_remove(struct pci_dev *pdev)
 		ice_free_vfs(pf);
 	}
 
-	ice_hwmon_exit(pf);
-
 	if (!ice_is_safe_mode(pf))
 		ice_remove_arfs(pf);
 
-- 
2.47.1


