Return-Path: <netdev+bounces-286863-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DKDFgBoAmr5sQEAu9opvQ
	(envelope-from <netdev+bounces-286863-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F751750E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7420B3019D31
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9281F3624A9;
	Mon, 11 May 2026 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGBqvWxd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A5934EF05;
	Mon, 11 May 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542590; cv=none; b=tHPC3h7Zjs/eX7BIdJIxVbb9iEVH/okmIh5HB0P0v6Bo7xRKQ0ype5kR3evgypxQd732zY85XrKITL1F1YPCh+Oloiw8YJLWZRg2s9v3K3BJyAQk33B3NzO6dlxf5HROCg1ltBFZRXT9ClEf9EV1gUGzEBApt9ujX14xWbzNHw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542590; c=relaxed/simple;
	bh=n4N5Ob6QR7mJlARN689ZneO04c/IOYdur8sBgBL3wNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRQDCEEw5M/ktH8k+wutdjyJ3mfHZx5y6zx5KSbuflyRHMFsGOb8vSfy3OsTboaDICImNEoFxq37rdTtwstoViowO2onXAiFGtfq3MR0SxUANQQPjc6bC7KkbNjWfbEhy5urjECOzTX44/wALV1XbLvcuE2VDnB/2o7Nr9NYfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGBqvWxd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542589; x=1810078589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4N5Ob6QR7mJlARN689ZneO04c/IOYdur8sBgBL3wNE=;
  b=VGBqvWxdQxS30XaQu/RkmXQfybOyAU9/7vOqn7RS+SVbJ2ZAgMPMQXUC
   WXYJXX5zTUzzYedhwVTfGGj2nhaJwBi1YiatexEq3AjraJbRdCeXkb83r
   uuG1ciSJYF1twP+tcJTEg8BRXaFeByCWe4eEY8r4m6le4joZ73NV8ngmU
   TnuEqZbzGD2DOXEeDmNE/o4pxnClvpvUnlCAFJZsjXuc+tMWDPNvqcR9O
   1c9RikKLOzF5xS9B7yN59bUlCIo7tYdfLdl3iiFJti+01YKLWug7GVgBN
   WoFmcNDBnRbReqCcgIGlrCRJJjL3KpZa4h6IRIbqLNPjMeZ13qk2uhVUb
   A==;
X-CSE-ConnectionGUID: 3GVxs96bReG1u0JZtKO8hw==
X-CSE-MsgGUID: sGu+dDDbTEe7zoiwowkNEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027382"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90027382"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:36:28 -0700
X-CSE-ConnectionGUID: 0Ayccf8MRIW+Q4IfXVTs9g==
X-CSE-MsgGUID: eRsC1kIPQdSMc1sapujlJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237687248"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:23 -0700
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
	Jiri Pirko <jiri@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH v8 net-next 2/8] dpll: allow registering FW-identified pin with a different DPLL
Date: Tue, 12 May 2026 01:31:53 +0200
Message-Id: <20260511233159.2558165-3-grzegorz.nitka@intel.com>
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
X-Rspamd-Queue-Id: 061F751750E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286863-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

Relax the (module, clock_id) equality requirement when registering a
pin identified by firmware (pin->fwnode). Some platforms associate a
FW-described pin with a DPLL instance that differs from the pin's
(module, clock_id) tuple. For such pins, permit registration without
requiring the strict match. Non-FW pins still require equality.

Keep netlink pin module reporting/filtering safe for this relaxed
registration model by caching the module name in the pin object at
allocation time and using the cached string in netlink paths.
This avoids dereferencing pin->module after provider module teardown.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c    | 20 ++++++++++++++++----
 drivers/dpll/dpll_core.h    |  1 +
 drivers/dpll/dpll_netlink.c |  6 +++---
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index cbb635db4321..3f5a822e44fb 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/idr.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -652,6 +653,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	pin->pin_idx = pin_idx;
 	pin->clock_id = clock_id;
 	pin->module = module;
+	strscpy(pin->module_name, module_name(module));
 	if (WARN_ON(prop->type < DPLL_PIN_TYPE_MUX ||
 		    prop->type > DPLL_PIN_TYPE_MAX)) {
 		ret = -EINVAL;
@@ -883,11 +885,21 @@ dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 		return -EINVAL;
 
 	mutex_lock(&dpll_lock);
-	if (WARN_ON(!(dpll->module == pin->module &&
-		      dpll->clock_id == pin->clock_id)))
+
+	/*
+	 * For pins identified via firmware (pin->fwnode), allow registration
+	 * even if the pin's (module, clock_id) differs from the target DPLL.
+	 * For non-fwnode pins, require a strict (module, clock_id) match.
+	 */
+	if (!pin->fwnode &&
+	    WARN_ON_ONCE(dpll->module != pin->module ||
+			 dpll->clock_id != pin->clock_id)) {
 		ret = -EINVAL;
-	else
-		ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+		goto out_unlock;
+	}
+
+	ret = __dpll_pin_register(dpll, pin, ops, priv, NULL);
+out_unlock:
 	mutex_unlock(&dpll_lock);
 
 	return ret;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 71ac88ef2017..5b7db39a2dd0 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -59,6 +59,7 @@ struct dpll_pin {
 	u32 pin_idx;
 	u64 clock_id;
 	struct module *module;
+	char module_name[MODULE_NAME_LEN];
 	struct fwnode_handle *fwnode;
 	struct xarray dpll_refs;
 	struct xarray parent_refs;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index ea6360263786..0af6b0cf3965 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -713,7 +713,7 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	if (ret)
 		return ret;
 	if (nla_put_string(msg, DPLL_A_PIN_MODULE_NAME,
-			   module_name(pin->module)))
+			   pin->module_name))
 		return -EMSGSIZE;
 	if (nla_put_64bit(msg, DPLL_A_PIN_CLOCK_ID, sizeof(pin->clock_id),
 			  &pin->clock_id, DPLL_A_PIN_PAD))
@@ -1650,9 +1650,9 @@ dpll_pin_find(u64 clock_id, struct nlattr *mod_name_attr,
 	xa_for_each_marked(&dpll_pin_xa, i, pin, DPLL_REGISTERED) {
 		prop = &pin->prop;
 		cid_match = clock_id ? pin->clock_id == clock_id : true;
-		mod_match = mod_name_attr && module_name(pin->module) ?
+		mod_match = mod_name_attr && pin->module_name[0] ?
 			!nla_strcmp(mod_name_attr,
-				    module_name(pin->module)) : true;
+				    pin->module_name) : true;
 		type_match = type ? prop->type == type : true;
 		board_match = board_label ? (prop->board_label ?
 			!nla_strcmp(board_label, prop->board_label) : false) :
-- 
2.39.3


