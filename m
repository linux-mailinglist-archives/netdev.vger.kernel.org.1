Return-Path: <netdev+bounces-293141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ1fFq+mGWptyAgAu9opvQ
	(envelope-from <netdev+bounces-293141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:46:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB612603DE0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8464318A550
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE8E3EAC90;
	Fri, 29 May 2026 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frzbq1XF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFEF3EB816;
	Fri, 29 May 2026 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065115; cv=none; b=UgKcwZrtWAfUSRMZHWPCMO8mVge8K7EfobX+IZ8mB99ETTJM9ChO6lysHrpuCsfRix9LQxsu+G49Ldlp7sM8QBngPNraeeLzEUnBjkBnVG1f+mVrGBecgDOaTSA6d2Zc41K79X3neGZQzckBHrmmKdHOBHyki8aDkMA/tv2a0IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065115; c=relaxed/simple;
	bh=n3LTctmLiarUDFk7jU/nt7slraWWbdw+71Ep9d7Y+t8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZUJZKj1tkewlT+JbD+w0Dcf6OriQWkmWi4rfjIR69vFWfcStqDKUY7btv99T/Dp8QCmZiYPMcJQxiW3ORRQjuzakby3akGLtbgx8sRbETYuYjg6tQvIi3dmjg5rX6SWpcQfe63u9/uk9IeBCdTcmWGRXrFdm1CYeStN6V53wik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frzbq1XF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780065114; x=1811601114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n3LTctmLiarUDFk7jU/nt7slraWWbdw+71Ep9d7Y+t8=;
  b=frzbq1XF7sqwxhh6b4k7GJcgQ7r/J8aAJU1i76/6dAkAKWJkQb9SP9CC
   5M13V5bupCP9uYWthKpf1Vvnt+H+4LeL1TtiCbqu3zOXzrL3sXSBdDz2C
   ix0pemVjBQ2OQuew1xRfjMwdoMYcCvfPAKE32FrDak/v9BXjyPvFMpUg3
   S5klU67Ok04DEgirdsLeFncMoM9KR/n3s5HH1qDY3GVEIB3Cujhd8lcJ2
   zSnzRUBI/XXLDDLXuVoL3QLq0tBZ4Dp/rhEJ+nlnbSzeOBKjvd3yCboyq
   xgBUFMTIq45H03SME8Jf6Dt8OP8a0bn5iSZrou/YiAR5zaQLBHHZRI8TI
   w==;
X-CSE-ConnectionGUID: mfEgcBTqT+qg4IkeHeuhFw==
X-CSE-MsgGUID: glfxPfKgRhSkN1zjR+T3XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80817564"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="80817564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 07:31:54 -0700
X-CSE-ConnectionGUID: 5yuQBZGFRsmuekRQ+erdAg==
X-CSE-MsgGUID: jLIOhNK6TmaIxhew/vdIYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="238677411"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by fmviesa010.fm.intel.com with ESMTP; 29 May 2026 07:31:49 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	poros@redhat.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	Prathosh.Satish@microchip.com,
	ivecera@redhat.com,
	jiri@resnulli.us,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	donald.hunter@gmail.com,
	horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH v12 net-next 4/8] dpll: allow fwnode pins to attempt state change without capability bit
Date: Fri, 29 May 2026 16:26:24 +0200
Message-Id: <20260529142628.1678955-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293141-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AB612603DE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pins registered with an fwnode may have .state_on_dpll_set implemented
without advertising DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE upfront.
Requiring the bit for fwnode pins ties firmware description to driver
implementation details unnecessarily.

Relax the capability check in dpll_pin_state_set() and
dpll_pin_on_pin_state_set(): when a pin has an associated fwnode, bypass
the capability gate and let the ops layer decide, returning -EOPNOTSUPP
if .state_on_dpll_set is absent. Non-fwnode pins retain the original
strict behavior.

This is used later in the series by the SyncE_Ref output pin, which
relies on the fwnode path for state control.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 8232d4543c7d..bf729cde796a 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1325,8 +1325,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
 	unsigned long i;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -1361,8 +1364,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
+	/* fwnode pins may not set the capability bit upfront; let the ops
+	 * layer return -EOPNOTSUPP if the operation is unsupported.
+	 */
 	if (!(DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE &
-	      pin->prop.capabilities)) {
+	      pin->prop.capabilities) && !pin->fwnode) {
 		NL_SET_ERR_MSG(extack, "state changing is not allowed");
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3


