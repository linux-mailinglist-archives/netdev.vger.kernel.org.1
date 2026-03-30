Return-Path: <netdev+bounces-273376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EviNd0By2k2CgYAu9opvQ
	(envelope-from <netdev+bounces-273376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4D362401
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 01:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C7C330234F4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30AC3EAC98;
	Mon, 30 Mar 2026 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0I1o6X5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FE3E95B2
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774911783; cv=none; b=XPMjuIPJfRdrEMEOMSiziChWGZ0AvCwOdeRP6PJ8MYiwZpTbw99zp7RZABTvnLa+xSHx1zn0p4Ca7IBHAVzWG0Ne/9IX3ia+jd5V0hqs4cW9z4gaMVMvuFzfJdLpf2R6zoRHEv8XVzQ4hxvnEnCMZ9Z5gZ5Bcyh+ppeSPDZIqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774911783; c=relaxed/simple;
	bh=9pCMpD+YA8wpMzolgyvPE/KVKKFkxcpNtIB4zfAJmR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+0wHV1uayLY1GUP2LlyMu7elmrKL7FB0FTX4pGUtdQTjEwpk2nEg6cEejc9Ib/KnSJJkUbC7PAiHDKgjjWH8rfe+vAQsIDKqRWyrlW7JhMhI0r99hxYydUKmxzDFPQ4bn/ycSHS2ISWeY8ivy/APqMdZjFbpmtb/Vs715Hy2ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D0I1o6X5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774911782; x=1806447782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pCMpD+YA8wpMzolgyvPE/KVKKFkxcpNtIB4zfAJmR0=;
  b=D0I1o6X5GDu+3v81s36RjS6p/9IIloTcCOlxwmxz54ha4wtw2wHt/5Sw
   1Ik+ukD3w5cpD5rJ3piGJG0xXZqJ3VCROhr3js5dJCHa7CrIMxEflOoxX
   /wXXSJmkrUcCVuK7xsUmYkLiOKec4Ps+WyF2xtfhPpyAlCyqUF0Lj0fo3
   v0cAR/hEyMrSDcGzQrqLMcMuAYYCbSL/NzrWh4c1DWhy9T/Mk7abGwBX8
   GmZY7NmgdHDaFZSz2LVa/NVMUBA7HmvmLL7XWoU8kdRL5X4mJsbni2Rtr
   nxS12o5YAkRcw7lqY6+chPi7fY5onOll/vqwdWfFO+tbR23W8z9x5SNtu
   Q==;
X-CSE-ConnectionGUID: dvn8Z1E7Tfm81VK1nU6YSA==
X-CSE-MsgGUID: sfNT+LTiTDSLlAW+/cVmJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="93297663"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="93297663"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:02:54 -0700
X-CSE-ConnectionGUID: 885/+H+ATK+8aTeaRBOyvw==
X-CSE-MsgGUID: UxkdnJZ9TjKyuhjJ6XOwGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="256687753"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 30 Mar 2026 16:02:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemyslaw Korba <przemyslaw.korba@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 15/15] ice: dpll: Fix compilation warning
Date: Mon, 30 Mar 2026 16:02:44 -0700
Message-ID: <20260330230248.646900-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273376-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CE4D362401
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Przemyslaw Korba <przemyslaw.korba@intel.com>

Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
dynamic pin discovery"):

ice_dpll.c: In function 'ice_dpll_init':
ice_dpll.c:3588:59: error: '%u' directive output may be truncated
writing between 1 and 10 bytes into a region of size 4
[-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
"rclk%u", i);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 2a9eb233dbf4..deb05976d687 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -3571,7 +3571,7 @@ static int
 ice_dpll_init_fwnode_pins(struct ice_pf *pf, struct ice_dpll_pin *pins,
 			  int start_idx)
 {
-	char pin_name[8];
+	char pin_name[16];
 	int i, ret;
 
 	pf->dplls.wq = create_singlethread_workqueue("ice_dpll_wq");
-- 
2.47.1


