Return-Path: <netdev+bounces-268935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLMgEnhtumnRWQIAu9opvQ
	(envelope-from <netdev+bounces-268935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:16:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF592B8C52
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F10963182670
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956203A0B31;
	Wed, 18 Mar 2026 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jDbY4aLp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3EF3A1E9E;
	Wed, 18 Mar 2026 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773825065; cv=none; b=rGjFTJ4/MF7E4We7CbzO3znQfMKFr6RvvKsMGk82Y2qHGvdhLZWOKBaK+DHqOVt34aWWYnuU48lNTa100oOsK8I+2jgq3ErlJNvyys5ETtvryUjYaFNqatwo/RqgaGlKnqRZe32Jqb98Su38z+0OpLtBfJgebp6JoqgL0R12p0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773825065; c=relaxed/simple;
	bh=QOtrBOkXwl8PL4bPKYG5M+IcyZy4UU77WTkHdU3jJZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpkDVWdWCKh/vcdEkmkVPP9F2k+WisCn0Ld5xbclQAt/J/7KED7gfpCUbzT+FjXvMrE59o9zAjfrmeIGBD27Qf7t1SOD9drnfs5LYUK0sneye8W5AP3lC+SAixvSmQ/E3PXHT4eyXyPuW+4sspS0PYSLHokwbCt35YUHTD5+R1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jDbY4aLp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773825064; x=1805361064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOtrBOkXwl8PL4bPKYG5M+IcyZy4UU77WTkHdU3jJZQ=;
  b=jDbY4aLpXkDUzIBAkVC7Qki8fvIOod2lloZkN86LfDBvwaDXjqmvMjde
   Q4qbeD/zRyZe4MtKTyDtx9DAPaowcUg7JIlHITBRgkYoWT9+sUueiNWyS
   lJxkwYRdvbQ+JXHzu5rDGyZNed98E+csPwqEb4Q2y9v6qke6rHMNB8AZU
   lZ9oh98ptD4PCW3cevuVotzV0z1rcecznW677jdKq/7F/vBzPEkl2KGWk
   qHSpDMN519OyEeA6GlpnffyKqPlExgAaOBxWhP/vC+noJDbAGFahW62Qn
   v/6eOsJcj5u+N7a+A8acTL3ZBtw1SGa5bj5wOWp9uNQDFjJO5OXDq6TlK
   g==;
X-CSE-ConnectionGUID: 7u2Z+stwRd2zpNWcf3Fm0w==
X-CSE-MsgGUID: +6MWPsIkSb2O5bIyrKw1EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="77484413"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="77484413"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 02:11:03 -0700
X-CSE-ConnectionGUID: zyQ3BB0eQTKcH5A73+u3mw==
X-CSE-MsgGUID: ljC4B5yqTR6VxT3Lns938w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="226699949"
Received: from gklab-003-001.igk.intel.com ([10.91.173.48])
  by orviesa003.jf.intel.com with ESMTP; 18 Mar 2026 02:10:59 -0700
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
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 3/8] dpll: extend pin notifier and netlink events with notification source ID
Date: Wed, 18 Mar 2026 10:06:49 +0100
Message-Id: <20260318090654.611349-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260318090654.611349-1-grzegorz.nitka@intel.com>
References: <20260318090654.611349-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.osuosl.org,redhat.com,gmail.com,lunn.ch,intel.com,microchip.com,resnulli.us,linux.dev,kernel.org,davemloft.net];
	TAGGED_FROM(0.00)[bounces-268935-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[grzegorz.nitka@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EF592B8C52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extend the DPLL pin notification API to include a source identifier
indicating where the notification originates. This allows notifier
consumers and netlink listeners to distinguish between notifications
coming from an associated DPLL instance, a parent pin, or the pin
itself.

A new field, src_id, is added to struct dpll_pin_notifier_info and is
passed through all pin-related notification paths. Callers of
dpll_pin_notify() are updated to provide a meaningful source identifier
based on their context:
  - pin registration/unregistration use the DPLL's clock_id,
  - pin-on-pin operations use the parent pin's clock_id,
  - pin changes use the pin's own clock_id.

This enables richer event routing and more accurate state handling in
user space and in-kernel consumers.

The current DPLL pin notification infrastructure does not provide any
way to identify where a pin-related notification originates. Both the
in-kernel notifier chain and the netlink notification path only carry
information about the pin itself, not about the component that triggered
the event.

This becomes problematic on platforms where multiple DPLL devices or
drivers share the same physical pin via firmware description (fwnode).
In such setups pin creation, deletion, or state changes can be triggered
from several independent contexts:

  - from the DPLL device that owns the pin,
  - from another DPLL device that re-registers or rebinds the same
    fwnode-described pin,
  - or from a pin-on-pin relationship (parent pin registering child
    pins).

Without a source identifier all these notifications look identical to
listeners. Drivers cannot reliably determine whether a received event
is a result of their own registration/unregistration actions or
originated from a different DPLL instance. This leads to several types
of problems:

  * risk of duplicate pin registration when a driver reacts to its own
    event,
  * difficulty suppressing notifications that are merely internal
    bookkeeping side effects,
  * inability to implement correct pin‑multiplexing or cross‑device
    synchronization logic when pins are shared across fwnode domains.

To address this, extend `struct dpll_pin_notifier_info` with a new
`src_id` field that identifies the originator of the event. The DPLL
core sets this field for all pin notifications:

  - pin registration/unregistration: the source is the clock_id of the
    DPLL initiating the operation,
  - pin-on-pin relationships: the source is the parent pin's clock_id,
  - pin property/state updates: the source is the pin's own clock_id.

Netlink notifications now also carry this additional field.

With this information notifier consumers can differentiate true external
events from internal ones and ignore the latter when appropriate.
As shown later in this series, ICE/E825 devices rely on this to avoid
reacting to the events that their own registration logic triggers
when a shared-fwnode pin appears.

This change only extends the notification metadata and does not alter
existing semantics for drivers that do not use the new field.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/dpll/dpll_core.c    | 14 ++++++++------
 drivers/dpll/dpll_core.h    |  2 +-
 drivers/dpll/dpll_netlink.c | 10 +++++-----
 drivers/dpll/dpll_netlink.h |  4 ++--
 include/linux/dpll.h        |  1 +
 5 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 0d25c23bd850..424f70857ece 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -71,7 +71,8 @@ void dpll_device_notify(struct dpll_device *dpll, unsigned long action)
 	call_dpll_notifiers(action, &info);
 }
 
-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
+void dpll_pin_notify(struct dpll_pin *pin, u64 ntfy_src,
+		     unsigned long action)
 {
 	struct dpll_pin_notifier_info info = {
 		.pin = pin,
@@ -80,6 +81,7 @@ void dpll_pin_notify(struct dpll_pin *pin, unsigned long action)
 		.clock_id = pin->clock_id,
 		.fwnode = pin->fwnode,
 		.prop = &pin->prop,
+		.src_id = ntfy_src,
 	};
 
 	call_dpll_notifiers(action, &info);
@@ -847,7 +849,7 @@ __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
 	if (ret)
 		goto ref_pin_del;
 	xa_set_mark(&dpll_pin_xa, pin->id, DPLL_REGISTERED);
-	dpll_pin_create_ntf(pin);
+	dpll_pin_create_ntf(pin, dpll->clock_id);
 
 	return ret;
 
@@ -946,7 +948,7 @@ void dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
 		return;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
+	dpll_pin_delete_ntf(pin, dpll->clock_id);
 	__dpll_pin_unregister(dpll, pin, ops, priv, NULL);
 	mutex_unlock(&dpll_lock);
 }
@@ -992,7 +994,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 			stop = i;
 			goto dpll_unregister;
 		}
-		dpll_pin_create_ntf(pin);
+		dpll_pin_create_ntf(pin, parent->clock_id);
 	}
 	mutex_unlock(&dpll_lock);
 
@@ -1003,7 +1005,7 @@ int dpll_pin_on_pin_register(struct dpll_pin *parent, struct dpll_pin *pin,
 		if (i < stop) {
 			__dpll_pin_unregister(ref->dpll, pin, ops, priv,
 					      parent);
-			dpll_pin_delete_ntf(pin);
+			dpll_pin_delete_ntf(pin, parent->clock_id);
 		}
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 unlock:
@@ -1029,7 +1031,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 	unsigned long i;
 
 	mutex_lock(&dpll_lock);
-	dpll_pin_delete_ntf(pin);
+	dpll_pin_delete_ntf(pin, parent->clock_id);
 	dpll_xa_ref_pin_del(&pin->parent_refs, parent, ops, priv, pin);
 	xa_for_each(&pin->dpll_refs, i, ref)
 		__dpll_pin_unregister(ref->dpll, pin, ops, priv, parent);
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index 71ac88ef2017..f684d9d4c4da 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -98,6 +98,6 @@ extern struct xarray dpll_pin_xa;
 extern struct mutex dpll_lock;
 
 void dpll_device_notify(struct dpll_device *dpll, unsigned long action);
-void dpll_pin_notify(struct dpll_pin *pin, unsigned long action);
+void dpll_pin_notify(struct dpll_pin *pin, u64 ntfy_src, unsigned long action);
 
 #endif
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 83cbd64abf5a..afb778420b93 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -830,21 +830,21 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpll_pin *pin)
 	return ret;
 }
 
-int dpll_pin_create_ntf(struct dpll_pin *pin)
+int dpll_pin_create_ntf(struct dpll_pin *pin, u64 ntfy_src)
 {
-	dpll_pin_notify(pin, DPLL_PIN_CREATED);
+	dpll_pin_notify(pin, ntfy_src, DPLL_PIN_CREATED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
 }
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin)
+int dpll_pin_delete_ntf(struct dpll_pin *pin,  u64 ntfy_src)
 {
-	dpll_pin_notify(pin, DPLL_PIN_DELETED);
+	dpll_pin_notify(pin, ntfy_src, DPLL_PIN_DELETED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
-	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
+	dpll_pin_notify(pin, pin->clock_id, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
 
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index dd28b56d27c5..082c2aea6d1a 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -8,8 +8,8 @@ int dpll_device_create_ntf(struct dpll_device *dpll);
 
 int dpll_device_delete_ntf(struct dpll_device *dpll);
 
-int dpll_pin_create_ntf(struct dpll_pin *pin);
+int dpll_pin_create_ntf(struct dpll_pin *pin, u64 ntfy_src);
 
-int dpll_pin_delete_ntf(struct dpll_pin *pin);
+int dpll_pin_delete_ntf(struct dpll_pin *pin, u64 ntfy_src);
 
 int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 2ce295b46b8c..ae4b146d7243 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -202,6 +202,7 @@ struct dpll_pin_notifier_info {
 	u64 clock_id;
 	const struct fwnode_handle *fwnode;
 	const struct dpll_pin_properties *prop;
+	u64 src_id;
 };
 
 #if IS_ENABLED(CONFIG_DPLL)
-- 
2.39.3


