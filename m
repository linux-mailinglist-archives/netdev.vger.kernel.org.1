Return-Path: <netdev+bounces-286865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAPTDg9oAmr5sQEAu9opvQ
	(envelope-from <netdev+bounces-286865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:36:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D00DF51752D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5152301AF4B
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58689361666;
	Mon, 11 May 2026 23:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbLdsaFP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED6234EF07;
	Mon, 11 May 2026 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542604; cv=none; b=hbEV5s3PeKJeLuz8F5G8AB8jrt93/RFztP3IvxZYLSwd1p4N6rOMYEr62jnFMk8ANtsHa19fIbiM4nyYxzukty5NRTYGfZutWqFyn5+Pr+fyln7TRSNCFvofoS7ugtI62cwhL8i2RINU/Xv1gdXHPqMCW3ZbPc0NYoKxiTrVWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542604; c=relaxed/simple;
	bh=vbbZq1hrf06NrmT4kCRwMGZ/sXfkisXd+yu/4ftUCUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h0II/BpUCXljbBR8CHnzQ5i2VRE6rDD8g7UIZNsFLL4jfFAmPFPPD5qlgtvvPztkwsr+A0GXxuiKiLX6W86zyBj4l25eKP89x4n5YS9yGtdUdQjUrY3K70wkRx5/Nxv9kN50Yu7gswSH/gp93vcP1QFgtUAP3wIS6CQXcjMRFy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbLdsaFP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542602; x=1810078602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbbZq1hrf06NrmT4kCRwMGZ/sXfkisXd+yu/4ftUCUA=;
  b=NbLdsaFPnGjScOosi0oGcdy+horzYYs/l0U7ajEIzIAxge7/wg3cSqEL
   2AovXhf53x3m07wVRl9wCQOE4DV09jtyFFF9VXg2LfVkYyQM55R3+v7mf
   w1A/1FjAv1wouSYLKjVI9Ti/e7GccsotDnEqh5ADn4S3FxDALzXreaSTh
   2q5HfKPfDOHBExmwmm7U34JKZFlSiytC+zXHCMHPPD2gT0Fm0atVXkWFh
   GPmOKifKY86fZNWD5174Z05Wd8Jv2YeoeddjB8aG2P7je4bjq6oczAy2j
   SU36LQEiEj4AwNEFa163/JcZJkODt6h6ahUp+ENMMhtm1O6ll8/rlPwgv
   A==;
X-CSE-ConnectionGUID: ePJ9RJ8uQrePT2LxrvdeHQ==
X-CSE-MsgGUID: rhGBg63NTj2VzyarwPz0lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027406"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90027406"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:36:42 -0700
X-CSE-ConnectionGUID: rk2utmTsS5mtCme2bt2PRA==
X-CSE-MsgGUID: ht8ebcvZSOK4iTjGgFd81w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237687278"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:37 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH v8 net-next 4/8] dpll: allow fwnode pins to attempt state change without capability bit
Date: Tue, 12 May 2026 01:31:55 +0200
Message-Id: <20260511233159.2558165-5-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
References: <20260511233159.2558165-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D00DF51752D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286865-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index b2c099990017..4f461d39ecf9 100644
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


