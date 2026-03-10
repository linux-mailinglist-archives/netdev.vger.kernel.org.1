Return-Path: <netdev+bounces-266327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBqBDqiFsGk5kQIAu9opvQ
	(envelope-from <netdev+bounces-266327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6132580C4
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BA1D303B97F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A4C3A6405;
	Tue, 10 Mar 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBDXaQfx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320123AEF3E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176224; cv=none; b=sjJtY6krWstWlIMWrMN1Azz/8PzozPfyHgqAqgSjo2oXWmK3BsM52OYvt7ExqdWZzem4KebjaZmaCdX00EBB+M9Mh7zY0E3ox/opi+TnDKTINwa1Dqyn4RgUotGnKHL0olcmG2Td/T4qLumSX2Q6qjIVYAc+j6fRh4dITkBIkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176224; c=relaxed/simple;
	bh=G9We/wPzo827nW1X6oZOAt35Aqjdotrs6Hbkk9tgj+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC9fCvhSyAMaHJIXfAgnnSb31bVM+j1tz+uaA+ixZsYbLUMUZsI2U8pRp0T1boU3Xyl9HtYaofPTSJoN+LteeEEfhvB916Ors9orKD6CSBpLnccv/AOOYJkWgICgquxFqtbYeSU8hwf6IEVu42QyAKRNZx65Ez134OY4Uo0RveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBDXaQfx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176223; x=1804712223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9We/wPzo827nW1X6oZOAt35Aqjdotrs6Hbkk9tgj+4=;
  b=CBDXaQfxCk2pBlkaTkXABmHSz8wSVsglh2bvzplPoo+T8Bromt2f9h7R
   4HklFnK6NzJPRRg7tQdE87PXwS1fMKBBjOFj6Hiq7XGODBqkxoAwoF0dy
   0RcWIPr5Sh3vFExtAFgd5wQ0azQk3ex0wm3xqJod9/M8M1LHo/cibSHsF
   Cohm1MGA5MuK5F1GPHEAbLYOcw0geoqnE2RWlMX8NtJ3bR3AUG9g4EgUO
   8D3FqRpiJEcS/JIy1nEVMCnsKZDQhnXL2SvUahcg7cVRuHVB00hSxwms6
   vlW2rscQRBMjciIRm9hNY8KRQPQEBss4duQDSddYbSkBKn9fvy4vdNVsD
   Q==;
X-CSE-ConnectionGUID: I+/cWBuUTlSl+eVnydijQw==
X-CSE-MsgGUID: xA5pIK3jREWEayteq/PDWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85326051"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85326051"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:57:01 -0700
X-CSE-ConnectionGUID: v8+z3lYnQPOekHYOy7Q/9w==
X-CSE-MsgGUID: fE7sn5spSnKZky4F8oywZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258162876"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 13:56:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	ivecera@redhat.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 2/5] iavf: fix PTP use-after-free during reset
Date: Tue, 10 Mar 2026 13:56:50 -0700
Message-ID: <20260310205654.4109072-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
References: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F6132580C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,gmail.com,kernel.org,linux.dev,molgen.mpg.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266327-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,linux.dev:email]
X-Rspamd-Action: no action

From: Petr Oros <poros@redhat.com>

Commit 7c01dbfc8a1c5f ("iavf: periodically cache PHC time") introduced a
worker to cache PHC time, but failed to stop it during reset or disable.

This creates a race condition where `iavf_reset_task()` or
`iavf_disable_vf()` free adapter resources (AQ) while the worker is still
running. If the worker triggers `iavf_queue_ptp_cmd()` during teardown, it
accesses freed memory/locks, leading to a crash.

Fix this by calling `iavf_ptp_release()` before tearing down the adapter.
This ensures `ptp_clock_unregister()` synchronously cancels the worker and
cleans up the chardev before the backing resources are destroyed.

Fixes: 7c01dbfc8a1c5f ("iavf: periodically cache PHC time")
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 86c1964f42e1..c7abd3331e03 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -3036,6 +3036,8 @@ static void iavf_disable_vf(struct iavf_adapter *adapter)
 
 	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
 
+	iavf_ptp_release(adapter);
+
 	/* We don't use netif_running() because it may be true prior to
 	 * ndo_open() returning, so we can't assume it means all our open
 	 * tasks have finished, since we're not holding the rtnl_lock here.
@@ -3211,6 +3213,8 @@ static void iavf_reset_task(struct work_struct *work)
 	iavf_change_state(adapter, __IAVF_RESETTING);
 	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
 
+	iavf_ptp_release(adapter);
+
 	/* free the Tx/Rx rings and descriptors, might be better to just
 	 * re-use them sometime in the future
 	 */
-- 
2.47.1


