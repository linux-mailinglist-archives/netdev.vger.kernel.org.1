Return-Path: <netdev+bounces-291612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FSwCelqFWrgUwcAu9opvQ
	(envelope-from <netdev+bounces-291612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166E5D3863
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D5E2304F401
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9473D8903;
	Tue, 26 May 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZhXPXzc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6763D6CC5;
	Tue, 26 May 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788380; cv=none; b=ls7br1k70wU147dRU05+wK6hGTtfHJ/lIiFCUJXWmJd8/Omp2cUn5o/j1NhYOuhWplQ5Rs67R/fWX6BAb8zBKViMFPgY6PEeY+B6H17698ByqYE17z8bLIyzUbY+r9Ed9kIRAnl5dFl6sd/2Anr9ppAlvMjM4asVRwp1NfxPvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788380; c=relaxed/simple;
	bh=f4CVBYvBZXYPMriPrpN7kde+f4AJB2joLIhMcwxsOdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u81Vq5isajrXgihpL1Nygtt9nxJiYSvD3tcTsPlVVnVPUAx8mL5AlbKXqkS5ibZmptH2RVr7S2OlDnONb3ZT7I/du7y4tZ6PAD6Fx3JmoaMAYSfFmC2tE5/38cxKoohm48/h2cc3P8lpXl5DHWWeGrwL1zQ1pvCdrMEm7MkOuZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZhXPXzc; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779788378; x=1811324378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f4CVBYvBZXYPMriPrpN7kde+f4AJB2joLIhMcwxsOdU=;
  b=AZhXPXzcEidnY7pzTNx9q9aUrh1FPxGd8Bz1gWsWhDbdOB20Fj1qJH83
   kW+wqulBZaK0T47a5MJwWsb4E19uEyczD1JnhWSx0bmAzFZ4eu3coJKH8
   CbFl/mumH3HIPu0CVIKHPHFv53NQDQ/oGlAfxYdRPrETDyl74mSe6Cn8l
   XCBUfzQVKr0S5jV9zyfmGBc8aFVW1nD1jods1YyqYNx05/M78bGzzuZYF
   ewEBAqVNdqDMw5gKCsDPLbHKTlaHeFEYSdbU4dBJpDpNV9PBcGo4JfAlu
   HiW2SH/KlaMcIxBHp1moj2tUFxj/Da/7ahRuMi1mxtCziFutbq9QPoi10
   Q==;
X-CSE-ConnectionGUID: 43TsFgWXSwuPB1VPO5BiXw==
X-CSE-MsgGUID: FdVS2oQCQc+1izzbD4B0JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="90897260"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="90897260"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:39:38 -0700
X-CSE-ConnectionGUID: D0EnGxW4T7WD2qnfEWI6lQ==
X-CSE-MsgGUID: 3hmPycacQFKthEakuI0wqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="241027295"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa010.jf.intel.com with ESMTP; 26 May 2026 02:39:30 -0700
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
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v11 net-next 4/8] dpll: allow fwnode pins to attempt state change without capability bit
Date: Tue, 26 May 2026 11:34:15 +0200
Message-Id: <20260526093419.639220-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260526093419.639220-1-grzegorz.nitka@intel.com>
References: <20260526093419.639220-1-grzegorz.nitka@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-291612-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9166E5D3863
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
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index f81ed1071dba..162c2a8cffca 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -1316,8 +1316,11 @@ dpll_pin_on_pin_state_set(struct dpll_pin *pin, u32 parent_idx,
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
@@ -1352,8 +1355,11 @@ dpll_pin_state_set(struct dpll_device *dpll, struct dpll_pin *pin,
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


