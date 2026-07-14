Return-Path: <netdev+bounces-307457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 23blAgI0Vmpp1QAAu9opvQ
	(envelope-from <netdev+bounces-307457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:05:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE1E754D4F
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 15:05:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=eytIbY63;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307457-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307457-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9CF130AB961
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A14534A8;
	Tue, 14 Jul 2026 13:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936203BA253
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034003; cv=none; b=T04BkmJMkBanSGznu3VO9thLVOTGS2qKHgXoBCr35lXGR0W/kJg0dmXVQYgCcfdG9iDghv0Aye7mbIiNgvVqeZjymZF5LemXx+UTn2KC8PWphXlLV4SnxuLod+UcbIRul6zKS7XSZqmf9ips8G+bstQFSR0B0osJ0Qlmj34RV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034003; c=relaxed/simple;
	bh=edGerEJ2K5myu6qiGTaeBTVDgr0lKCq+OdaQF1FfJOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kcwTzCHi4cbld3nxt4AF8sYrwhgVGJpTeDY+NSwSP4WZHyJr9+KUhsNmUXJ6r/uLPE83UbJkxw/+ddItR+/lOS1FT8wmEoCye39xtR1K/0RFRsYcNBSlTP5W0KGoIiNDWPH4D4I8mcHwJwoW3SM+VQGe/h/694/NBbV6w1G3YqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eytIbY63; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784034000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KdoVF3uvyBF3nIIOAV85VbQPsvy+M+muvRTvMX/JvCk=;
	b=eytIbY63z2F1Zuvqfwt3PZZLTHDE1dsgl52lgMsdcIQQowa/IqY7CT3vL38H41gip9OCeC
	8unipnBU+cVxI89u+s2fKS5KC77L21MGw6cauGHZI8grbn9+5eYd7yjb8xZ1M5NYmcVa3E
	TlNn38+QLZ82r5EKwZ7jgswzLaeJZBY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-RxiK1hhaMkC9i9zSBNT7rg-1; Tue,
 14 Jul 2026 08:59:58 -0400
X-MC-Unique: RxiK1hhaMkC9i9zSBNT7rg-1
X-Mimecast-MFC-AGG-ID: RxiK1hhaMkC9i9zSBNT7rg_1784033997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBCEF195605A;
	Tue, 14 Jul 2026 12:59:56 +0000 (UTC)
Received: from p16v (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F2065180049F;
	Tue, 14 Jul 2026 12:59:53 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: use pin owner's dpll ref for pin-level attribute reporting
Date: Tue, 14 Jul 2026 14:59:44 +0200
Message-ID: <20260714125945.1823269-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:vadim.fedorenko@linux.dev,m:arkadiusz.kubalewski@intel.com,m:jiri@resnulli.us,m:aleksandr.loktionov@intel.com,m:grzegorz.nitka@intel.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CE1E754D4F

Commit c191b319f208 ("dpll: allow registering FW-identified pin with a
different DPLL") relaxed dpll_pin_register() to let fwnode-identified pins
register with DPLLs from a different driver. This allows, for example, the
ICE driver to register a zl3073x-created pin with its TXC DPLL using
ice_dpll_txclk_ops, which lack frequency_get and phase_adjust_get
callbacks.

After such cross-driver registration, the pin's dpll_refs xarray contains
refs from both drivers. dpll_cmd_pin_get_one() calls
dpll_xa_ref_dpll_first() which returns the ref with the lowest DPLL id.
When the foreign DPLL (e.g. ICE TXC) has a lower id than the owner DPLL
(e.g. zl3073x), the foreign ops are used for reporting. Since those ops
lack callbacks like frequency_get, pin-level attributes are silently
omitted from the netlink response.

For example, a zl3073x output pin that should report frequency and
phase-adjust shows neither:

Before:
  # dpll pin show id 45
  pin id 45:
    module-name: zl3073x
    clock-id: 3427468959636104019
    board-label: 156M25_NAC0_CLKREF_SYNC
    package-label: OUT3
    type: synce-eth-port
    capabilities: 0x0
    phase-adjust-min: -2147483648
    phase-adjust-max: 2147483647
    phase-adjust-gran: 800
    parent-device:
      ...

After:
  # dpll pin show id 19
  pin id 19:
    module-name: zl3073x
    clock-id: 15964355450360090479
    board-label: 156M25_NAC0_CLKREF_SYNC
    package-label: OUT3
    type: synce-eth-port
    frequency: 156250000 Hz
    frequency-supported:
      156250000 Hz
    capabilities: 0x0
    phase-adjust-min: -2147483648
    phase-adjust-max: 2147483647
    phase-adjust-gran: 800
    phase-adjust: 0
    parent-device:
      ...

Fix this by:

1. Adding dpll_pin_own_dpll_ref_first() helper that returns the first ref
   whose DPLL matches the pin's (module, clock_id) tuple — i.e. the DPLL
   from the driver that created the pin and has the complete set of ops.
   Return NULL if no owner ref is found.

2. Using dpll_pin_own_dpll_ref_first() in dpll_cmd_pin_get_one() with a
   fallback to dpll_xa_ref_dpll_first() for pin-on-pin child pins whose
   dpll_refs all point to a different driver's DPLLs.

3. Using dpll_pin_own_dpll_ref_first() in SET operations
   (dpll_pin_freq_set, dpll_pin_esync_set, dpll_pin_ref_sync_state_set,
   dpll_pin_phase_adj_set) returning -ENODEV if no owner ref exists.
   Replacing the validation loops that rejected the entire operation when
   any ref's ops lacked the required callback — instead validate only the
   owner refs so that foreign DPLLs with incomplete ops no longer block
   SET operations.

4. Guarding all SET and rollback xa_for_each loops against NULL set
   callbacks so that foreign refs without the operation are safely skipped
   instead of causing a NULL pointer dereference.

Fixes: c191b319f208 ("dpll: allow registering FW-identified pin with a different DPLL")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_core.c    | 27 +++++++++++++++++
 drivers/dpll/dpll_core.h    |  1 +
 drivers/dpll/dpll_netlink.c | 60 ++++++++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index bb1e8650c9d59..245f625f4b3b4 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -1146,6 +1146,33 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent,
 	return reg->priv;
 }
 
+/**
+ * dpll_pin_own_dpll_ref_first - find the first owner dpll ref of a pin
+ * @pin: pointer to a dpll pin
+ *
+ * Search pin's dpll_refs for a ref whose dpll matches the pin's
+ * (module, clock_id) tuple, i.e. the dpll registered by the driver
+ * that created the pin. This ensures pin-level attributes are
+ * reported and modified using the owner's ops even when the pin is
+ * also registered with dplls from other drivers.
+ *
+ * Return: pointer to the owner's dpll_pin_ref, or NULL if no
+ * owner ref is found.
+ */
+struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin)
+{
+	struct dpll_pin_ref *ref;
+	unsigned long i;
+
+	xa_for_each(&pin->dpll_refs, i, ref) {
+		if (ref->dpll->module == pin->module &&
+		    ref->dpll->clock_id == pin->clock_id)
+			return ref;
+	}
+
+	return NULL;
+}
+
 const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref)
 {
 	struct dpll_pin_registration *reg;
diff --git a/drivers/dpll/dpll_core.h b/drivers/dpll/dpll_core.h
index e245771134317..da8a369556ed1 100644
--- a/drivers/dpll/dpll_core.h
+++ b/drivers/dpll/dpll_core.h
@@ -93,6 +93,7 @@ void *dpll_pin_on_pin_priv(struct dpll_pin *parent, struct dpll_pin *pin);
 
 const struct dpll_device_ops *dpll_device_ops(struct dpll_device *dpll);
 struct dpll_device *dpll_device_get_by_id(int id);
+struct dpll_pin_ref *dpll_pin_own_dpll_ref_first(struct dpll_pin *pin);
 const struct dpll_pin_ops *dpll_pin_ops(struct dpll_pin_ref *ref);
 struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs);
 extern struct xarray dpll_device_xa;
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index bf729cde796a7..b3f0cb7d3d349 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -696,7 +696,9 @@ dpll_cmd_pin_get_one(struct sk_buff *msg, struct dpll_pin *pin,
 	struct dpll_pin_ref *ref;
 	int ret;
 
-	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref)
+		ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
 	ASSERT_NOT_NULL(ref);
 
 	ret = dpll_msg_add_pin_handle(msg, pin);
@@ -1087,12 +1089,19 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
-		if (!ops->frequency_set || !ops->frequency_get) {
-			NL_SET_ERR_MSG(extack, "frequency set not supported by the device");
+		if ((!ops->frequency_set || !ops->frequency_get) &&
+		    ref->dpll->module == pin->module &&
+		    ref->dpll->clock_id == pin->clock_id) {
+			NL_SET_ERR_MSG(extack,
+				       "frequency set not supported by the device");
 			return -EOPNOTSUPP;
 		}
 	}
-	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref) {
+		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
+		return -ENODEV;
+	}
 	ops = dpll_pin_ops(ref);
 	dpll = ref->dpll;
 	ret = ops->frequency_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
@@ -1106,6 +1115,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
+		if (!ops->frequency_set)
+			continue;
 		dpll = ref->dpll;
 		ret = ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 					 dpll, dpll_priv(dpll), freq, extack);
@@ -1125,6 +1136,8 @@ dpll_pin_freq_set(struct dpll_pin *pin, struct nlattr *a,
 		if (ref == failed)
 			break;
 		ops = dpll_pin_ops(ref);
+		if (!ops->frequency_set)
+			continue;
 		dpll = ref->dpll;
 		if (ops->frequency_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 				       dpll, dpll_priv(dpll), old_freq, extack))
@@ -1148,13 +1161,19 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
-		if (!ops->esync_set || !ops->esync_get) {
+		if ((!ops->esync_set || !ops->esync_get) &&
+		    ref->dpll->module == pin->module &&
+		    ref->dpll->clock_id == pin->clock_id) {
 			NL_SET_ERR_MSG(extack,
 				       "embedded sync feature is not supported by this device");
 			return -EOPNOTSUPP;
 		}
 	}
-	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref) {
+		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
+		return -ENODEV;
+	}
 	ops = dpll_pin_ops(ref);
 	dpll = ref->dpll;
 	ret = ops->esync_get(pin, dpll_pin_on_dpll_priv(dpll, pin), dpll,
@@ -1178,6 +1197,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 		void *pin_dpll_priv;
 
 		ops = dpll_pin_ops(ref);
+		if (!ops->esync_set)
+			continue;
 		dpll = ref->dpll;
 		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
 		ret = ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
@@ -1201,6 +1222,8 @@ dpll_pin_esync_set(struct dpll_pin *pin, struct nlattr *a,
 		if (ref == failed)
 			break;
 		ops = dpll_pin_ops(ref);
+		if (!ops->esync_set)
+			continue;
 		dpll = ref->dpll;
 		pin_dpll_priv = dpll_pin_on_dpll_priv(dpll, pin);
 		if (ops->esync_set(pin, pin_dpll_priv, dpll, dpll_priv(dpll),
@@ -1235,8 +1258,11 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 		NL_SET_ERR_MSG(extack, "reference sync pin not available");
 		return -EINVAL;
 	}
-	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
-	ASSERT_NOT_NULL(ref);
+	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref) {
+		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
+		return -ENODEV;
+	}
 	ops = dpll_pin_ops(ref);
 	if (!ops->ref_sync_set || !ops->ref_sync_get) {
 		NL_SET_ERR_MSG(extack, "reference sync not supported by this pin");
@@ -1255,6 +1281,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 		return 0;
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
+		if (!ops->ref_sync_set)
+			continue;
 		dpll = ref->dpll;
 		ret = ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 					ref_sync_pin,
@@ -1277,6 +1305,8 @@ dpll_pin_ref_sync_state_set(struct dpll_pin *pin,
 		if (ref == failed)
 			break;
 		ops = dpll_pin_ops(ref);
+		if (!ops->ref_sync_set)
+			continue;
 		dpll = ref->dpll;
 		if (ops->ref_sync_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 				      ref_sync_pin,
@@ -1468,12 +1498,18 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
-		if (!ops->phase_adjust_set || !ops->phase_adjust_get) {
+		if ((!ops->phase_adjust_set || !ops->phase_adjust_get) &&
+		    ref->dpll->module == pin->module &&
+		    ref->dpll->clock_id == pin->clock_id) {
 			NL_SET_ERR_MSG(extack, "phase adjust not supported");
 			return -EOPNOTSUPP;
 		}
 	}
-	ref = dpll_xa_ref_dpll_first(&pin->dpll_refs);
+	ref = dpll_pin_own_dpll_ref_first(pin);
+	if (!ref) {
+		NL_SET_ERR_MSG(extack, "pin owner dpll not found");
+		return -ENODEV;
+	}
 	ops = dpll_pin_ops(ref);
 	dpll = ref->dpll;
 	ret = ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
@@ -1488,6 +1524,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 
 	xa_for_each(&pin->dpll_refs, i, ref) {
 		ops = dpll_pin_ops(ref);
+		if (!ops->phase_adjust_set)
+			continue;
 		dpll = ref->dpll;
 		ret = ops->phase_adjust_set(pin,
 					    dpll_pin_on_dpll_priv(dpll, pin),
@@ -1510,6 +1548,8 @@ dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr *phase_adj_attr,
 		if (ref == failed)
 			break;
 		ops = dpll_pin_ops(ref);
+		if (!ops->phase_adjust_set)
+			continue;
 		dpll = ref->dpll;
 		if (ops->phase_adjust_set(pin, dpll_pin_on_dpll_priv(dpll, pin),
 					  dpll, dpll_priv(dpll), old_phase_adj,
-- 
2.53.0


