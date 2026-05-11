Return-Path: <netdev+bounces-286864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +gSwNZBoAmoxsgEAu9opvQ
	(envelope-from <netdev+bounces-286864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:38:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57882517589
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15CEE3024148
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9031D331A78;
	Mon, 11 May 2026 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bfgpIJwX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9286534EF05;
	Mon, 11 May 2026 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778542597; cv=none; b=KXAC1C/V5gbJRx10aFNQkfv19zV69YI2C8I5/++k0C8Y/JYd+VOrlDidRQdf7bk3V8FOZZSBBsSqWJSS75IKVrPMQxU9xwZAmEESMaJgcoCTxedfZw08Pj2jga651i3yaRlwU4uXkiCXjVVYb11gwDVZtJiXfaA2024sClkGD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778542597; c=relaxed/simple;
	bh=pnMtGkxYowwiBfiZ3WCAj/kXYs4NX4fkC5Yz9tVG328=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E9RlIn1Nuuf96XzXmI7GZ4uoMsITr6VpV5OmOV0A2JwjtwfrzQICnrPn0fB9V3WlvRTAp0CMbyeiJPv1pz5IFl2semhnECW2KeJ2JT1NsdTd65NXXu2oKaWrVgZdPDlQogIGchT93ZsUn3lad+/PAWDet2tvTBoWskoFFYvV6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bfgpIJwX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778542596; x=1810078596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pnMtGkxYowwiBfiZ3WCAj/kXYs4NX4fkC5Yz9tVG328=;
  b=bfgpIJwXuv0yeErZTCL/Uvm3w1qS8gzuQa7Y4csCd94MlY3iG6IFl5AT
   iSWycf/aK5k9oCYKVmjjY+0kitd2qZZz/aQRXctwf2PaIgEscTSGDFDnk
   N8tfFtW3G3xpzz6C/+a9lvfJpbXiVDMJ16BUX7TAEjyEe4Rfz0KRomn6p
   aiRKUnJKp3dIuufQYgLdeEEU4q2l/TOgEndo4UHeIMR49nYWCe4O+lEEa
   fmjkc5pj58vnR67oM/QxQkv2yjKyPXO8z/M8ZmrkQICGHKw+2SCXtUFBh
   RwlU+WFsvl7Api6swup1LJB6Dz5OWHYfOLjPTFzAnoT0nqQgyvfKhpwsG
   A==;
X-CSE-ConnectionGUID: 7VlXkZ0kTluyVnE2fnDuHw==
X-CSE-MsgGUID: PR4UMSvfTYKqBO/r9FFnRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90027386"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="90027386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 16:36:35 -0700
X-CSE-ConnectionGUID: K6fQwkxNTpCJaBPUrJ7NLQ==
X-CSE-MsgGUID: zn7fiPLTQeWbMK8vOHP+2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237687253"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa009.jf.intel.com with ESMTP; 11 May 2026 16:36:30 -0700
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
Subject: [PATCH v8 net-next 3/8] dpll: extend pin notifier with notification source ID
Date: Tue, 12 May 2026 01:31:54 +0200
Message-Id: <20260511233159.2558165-4-grzegorz.nitka@intel.com>
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
X-Rspamd-Queue-Id: 57882517589
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net,google.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286864-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Extend the DPLL pin notification API to include a source identifier
indicating where the notification originates. This allows notifier
consumers to distinguish between notifications coming from
an associated DPLL instance, a parent pin, or the pin itself.

A new field, src_id, is added to struct dpll_pin_notifier_info and is
passed through all pin-related notification paths. Callers of
dpll_pin_notify() are updated to provide a meaningful source identifier
based on their context:
  - pin registration/unregistration uses the DPLL's clock_id,
  - pin-on-pin operations use the parent pin's clock_id,
  - pin changes use the pin's own clock_id.

As introduced in the commit ("dpll: allow registering FW-identified pin
with a different DPLL"), it is possible to share the same physical pin
via firmware description (fwnode) with DPLL objects from different
kernel modules. This means that a given pin can be registered multiple
times.

Driver such as ICE (E825 devices) rely on this mechanism when listening
for the event where a shared-fwnode pin appears, while avoiding reacting
to events triggered by their own registration logic.

This change only extends the notification metadata and does not alter
existing semantics for drivers that do not use the new field.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c    | 14 ++++++++------
 drivers/dpll/dpll_core.h    |  3 ++-
 drivers/dpll/dpll_netlink.c | 10 +++++-----
 drivers/dpll/dpll_netlink.h |  4 ++--
 include/linux/dpll.h        |  1 +
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 3f5a822e44fb..8096dd810bc0 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -72,7 +72,8 @@ void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
 	call_dpll_notifiers(action, &info);
 }
 
-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
+void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
+		     unsigned long action)
 {
 	struct dpll_pin_notifier_info info = {
 		.pin = pin,
@@ -81,6 +82,7 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 		.clock_id = pin->clock_id,
 		.fwnode = pin->fwnode,
 		.prop = &pin->prop,
+		.src_clock_id = src_clock_id,
 	};
 
 	call_dpll_notifiers(action, &info);
@@ -849,7 +851,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (ret)
 		goto ref_pin_del;
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
-	dpll_pin_create_ntf(pin);
+	dpll_pin_create_ntf(pin, dpll->clock_id);
 
 	return ret;
 
@@ -951,7 +953,7 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		return;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
+	dpll_pin_delete_ntf(pin, dpll->clock_id);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 }
@@ -997,7 +999,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			stop = i;
 			goto dpll_unregister;
 		}
-		dpll_pin_create_ntf(pin);
+		dpll_pin_create_ntf(pin, parent->clock_id);
 	}
 	mutex_unlock(&dpll_lock);
 
@@ -1008,7 +1010,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		if (i < stop) {
 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
 					      parent);
-			dpll_pin_delete_ntf(pin);
+			dpll_pin_delete_ntf(pin, parent->clock_id);
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
@@ -1034,7 +1036,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
+	dpll_pin_delete_ntf(pin, parent->clock_id);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	xa_for_each(&pin->dpll_refs, i, ref)
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 5b7db39a2dd0..5787f29525a5 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -99,6 +99,7 @@ extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
+void dpll_pin_notify(struct dpll_pin *pin, u64 src_clock_id,
+		     unsigned long action);
 
 #endif
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 0af6b0cf3965..b2c099990017 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -915,15 +915,15 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	return ret;
 }
 
-int dpll_pin_create_ntf(struct dpll_pin *pin)
+int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
 {
-	dpll_pin_notify(pin, DPLL_PIN_CREATED);
+	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
 }
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin)
+int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id)
 {
-	dpll_pin_notify(pin, DPLL_PIN_DELETED);
+	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_DELETED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
@@ -938,7 +938,7 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin)
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
 	lockdep_assert_held(&dpll_lock);
-	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
+	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
 EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index a9cfd55f57fc..4f63aa58789a 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -8,6 +8,6 @@ int dpll_device_create_ntf(struct dpll_device *dpll);
 
 int dpll_device_delete_ntf(struct dpll_device *dpll);
 
-int dpll_pin_create_ntf(struct dpll_pin *pin);
+int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id);
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin);
+int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 src_clock_id);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 193abfb6ce66..28442ec83e22 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -218,6 +218,7 @@ struct dpll_pin_notifier_info {
 	u64 clock_id;
 	const struct fwnode_handle *fwnode;
 	const struct dpll_pin_properties *prop;
+	u64 src_clock_id;
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-- 
2.39.3


