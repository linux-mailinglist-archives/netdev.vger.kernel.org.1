Return-Path: <netdev+bounces-281963-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJakKK/n8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-281963-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C24CA48982B
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EDA93086D52
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5D3C3C01;
	Tue, 28 Apr 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgsOjAxq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DD3FE64D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391375; cv=none; b=Sh5z/eqpYcqS75EOSNh/4lgS2Wx6B7gnyygXSSE0gfkUV/cOxrLGC6Pv7SjWA5SXASEGt/VKduygZwzhr46o5ssYxxOiad4GEgZjr6YVRs49rrXR9RaexJKLNxsfja7xu93Bp4Biad5jpfxKZvxNWP3wtloQ6kkJmUUwbxaCOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391375; c=relaxed/simple;
	bh=x3RO6V/kHu8H1CKsrGLhR3Bb4YgxOOQit0LWvUQwr2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXCdX2fRTQebUYjsiaq3r9sXL4ycL5ECs2z/uYAThZZqPJ/kGQowQ+uDYZ6rc4Zi8vlQPp8tP8zjf+cbQBbDvk2yErfawXdYsLdIkToTO99KO3dc+aAbVu/dCohmdLvJDLAO6/HfOJG9TUB1VWBS+CJ2DjXWxHDycfC5ZnumI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgsOjAxq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777391372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1OkNnCiwBkSZQuPMZVTXv9vN6Q5bxCiT4HYJFpbNv8=;
	b=DgsOjAxqdXts6iQwPIFy2y+yZd1J1uKVaighyU+hvtP7+DiA+d9DVWFPdChA/UIsUnEnVm
	HCv3Jht+NCRFchKm15AiAEEZwv1iK8nTulpuaL+K9MIcQ7KRUZCnoI7t3q0Vlh3FfMOwOv
	WdP0cc1zN+inZZSeKQohKyJfpZLeYck=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-2CvlZjdhMJ-wpOuFy791Eg-1; Tue,
 28 Apr 2026 11:49:29 -0400
X-MC-Unique: 2CvlZjdhMJ-wpOuFy791Eg-1
X-Mimecast-MFC-AGG-ID: 2CvlZjdhMJ-wpOuFy791Eg_1777391367
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE1061800578;
	Tue, 28 Apr 2026 15:49:26 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66A09300756E;
	Tue, 28 Apr 2026 15:49:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] dpll: zl3073x: implement pin operational state reporting
Date: Tue, 28 Apr 2026 17:49:07 +0200
Message-ID: <20260428154907.2820654-3-ivecera@redhat.com>
In-Reply-To: <20260428154907.2820654-1-ivecera@redhat.com>
References: <20260428154907.2820654-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: C24CA48982B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,lwn.net,redhat.com,microchip.com,linuxfoundation.org,linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281963-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Implement operstate_on_dpll_get callback for input pins to report
the actual hardware status:

  - active: pin is the currently locked reference
  - standby: signal is valid but pin is not actively used
  - no-signal: reference monitor reports Loss of Signal (LOS)
  - qual-failed: reference monitor reports a qualification failure
    (SCM, CFM, GST, PFM, eSync or Split-XO)

Separate administrative state (state_on_dpll_get) from operational
state: admin state now reports purely the user-requested intent
(connected in reflock mode, selectable in auto mode).

Switch periodic monitoring to track operstate changes instead of
the mixed admin/oper state that was previously reported.

Add ref_mon_status bit definitions to regs.h.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 108 ++++++++++++++++++++++++------------
 drivers/dpll/zl3073x/regs.h |   9 ++-
 2 files changed, 79 insertions(+), 38 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index c95e93ef3ab04..6fd718696de0d 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -38,7 +38,7 @@
  * @prio: pin priority <0, 14>
  * @esync_control: embedded sync is controllable
  * @phase_gran: phase adjustment granularity
- * @pin_state: last saved pin state
+ * @operstate: last saved operational state
  * @phase_offset: last saved pin phase offset
  * @freq_offset: last saved fractional frequency offset
  * @measured_freq: last saved measured frequency
@@ -55,7 +55,7 @@ struct zl3073x_dpll_pin {
 	u8			prio;
 	bool			esync_control;
 	s32			phase_gran;
-	enum dpll_pin_state	pin_state;
+	enum dpll_pin_operstate	operstate;
 	s64			phase_offset;
 	s64			freq_offset;
 	u32			measured_freq;
@@ -500,46 +500,41 @@ zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
 }
 
 /**
- * zl3073x_dpll_ref_state_get - get status for given input pin
+ * zl3073x_dpll_ref_operstate_get - get operational state for input pin
  * @pin: pointer to pin
- * @state: place to store status
+ * @operstate: place to store operational state
  *
- * Checks current status for the given input pin and stores the value
- * to @state.
+ * Returns the actual hardware state of the pin: whether it is actively
+ * used by the DPLL, has no signal, failed qualification, or is simply
+ * not in use.
  *
  * Return: 0 on success, <0 on error
  */
 static int
-zl3073x_dpll_ref_state_get(struct zl3073x_dpll_pin *pin,
-			   enum dpll_pin_state *state)
+zl3073x_dpll_ref_operstate_get(struct zl3073x_dpll_pin *pin,
+			       enum dpll_pin_operstate *operstate)
 {
 	struct zl3073x_dpll *zldpll = pin->dpll;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	const struct zl3073x_chan *chan;
-	u8 ref;
-
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
-	ref = zl3073x_input_pin_ref_get(pin->id);
+	const struct zl3073x_ref *ref;
+	u8 ref_id;
 
-	/* Check if the pin reference is connected */
-	if (ref == zl3073x_dpll_connected_ref_get(zldpll)) {
-		*state = DPLL_PIN_STATE_CONNECTED;
-		return 0;
-	}
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
 
-	/* If the DPLL is running in automatic mode and the reference is
-	 * selectable and its monitor does not report any error then report
-	 * pin as selectable.
-	 */
-	if (zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    zl3073x_dev_ref_is_status_ok(zldev, ref) &&
-	    zl3073x_chan_ref_is_selectable(chan, ref)) {
-		*state = DPLL_PIN_STATE_SELECTABLE;
+	/* Check if this pin is the currently locked reference */
+	if (ref_id == zl3073x_dpll_connected_ref_get(zldpll)) {
+		*operstate = DPLL_PIN_OPERSTATE_ACTIVE;
 		return 0;
 	}
 
-	/* Otherwise report the pin as disconnected */
-	*state = DPLL_PIN_STATE_DISCONNECTED;
+	/* Check reference monitor status */
+	ref = zl3073x_ref_state_get(zldev, ref_id);
+	if (ref->mon_status & ZL_REF_MON_STATUS_LOS)
+		*operstate = DPLL_PIN_OPERSTATE_NO_SIGNAL;
+	else if (!zl3073x_ref_is_status_ok(ref))
+		*operstate = DPLL_PIN_OPERSTATE_QUAL_FAILED;
+	else
+		*operstate = DPLL_PIN_OPERSTATE_STANDBY;
 
 	return 0;
 }
@@ -551,10 +546,48 @@ zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					 void *dpll_priv,
 					 enum dpll_pin_state *state,
 					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	const struct zl3073x_chan *chan;
+	u8 mode, ref;
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	mode = zl3073x_chan_mode_get(chan);
+
+	switch (mode) {
+	case ZL_DPLL_MODE_REFSEL_MODE_REFLOCK:
+		if (ref == zl3073x_chan_ref_get(chan))
+			*state = DPLL_PIN_STATE_CONNECTED;
+		else
+			*state = DPLL_PIN_STATE_DISCONNECTED;
+		break;
+	case ZL_DPLL_MODE_REFSEL_MODE_AUTO:
+		if (zl3073x_chan_ref_is_selectable(chan, ref))
+			*state = DPLL_PIN_STATE_SELECTABLE;
+		else
+			*state = DPLL_PIN_STATE_DISCONNECTED;
+		break;
+	default:
+		*state = DPLL_PIN_STATE_DISCONNECTED;
+		break;
+	}
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_input_pin_operstate_on_dpll_get(const struct dpll_pin *dpll_pin,
+					     void *pin_priv,
+					     const struct dpll_device *dpll,
+					     void *dpll_priv,
+					     enum dpll_pin_operstate *operstate,
+					     struct netlink_ext_ack *extack)
 {
 	struct zl3073x_dpll_pin *pin = pin_priv;
 
-	return zl3073x_dpll_ref_state_get(pin, state);
+	return zl3073x_dpll_ref_operstate_get(pin, operstate);
 }
 
 static int
@@ -1248,6 +1281,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.measured_freq_get = zl3073x_dpll_input_pin_measured_freq_get,
+	.operstate_on_dpll_get = zl3073x_dpll_input_pin_operstate_on_dpll_get,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
 	.phase_adjust_get = zl3073x_dpll_input_pin_phase_adjust_get,
 	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
@@ -1663,7 +1697,7 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	 * 2) For other pins use appropriate ref_phase register if the phase
 	 *    monitor feature is enabled.
 	 */
-	if (pin->pin_state == DPLL_PIN_STATE_CONNECTED)
+	if (pin->operstate == DPLL_PIN_OPERSTATE_ACTIVE)
 		reg = ZL_REG_DPLL_PHASE_ERR_DATA(zldpll->id);
 	else if (zldpll->phase_monitor)
 		reg = ZL_REG_REF_PHASE(ref_id);
@@ -1828,7 +1862,7 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	}
 
 	list_for_each_entry(pin, &zldpll->pins, list) {
-		enum dpll_pin_state state;
+		enum dpll_pin_operstate operstate;
 		bool pin_changed = false;
 
 		/* Output pins change checks are not necessary because output
@@ -1837,18 +1871,18 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 		if (!zl3073x_dpll_is_input_pin(pin))
 			continue;
 
-		rc = zl3073x_dpll_ref_state_get(pin, &state);
+		rc = zl3073x_dpll_ref_operstate_get(pin, &operstate);
 		if (rc) {
 			dev_err(dev,
-				"Failed to get %s on DPLL%u state: %pe\n",
+				"Failed to get %s on DPLL%u oper state: %pe\n",
 				pin->label, zldpll->id, ERR_PTR(rc));
 			return;
 		}
 
-		if (state != pin->pin_state) {
-			dev_dbg(dev, "%s state changed: %u->%u\n", pin->label,
-				pin->pin_state, state);
-			pin->pin_state = state;
+		if (operstate != pin->operstate) {
+			dev_dbg(dev, "%s oper state changed: %u->%u\n",
+				pin->label, pin->operstate, operstate);
+			pin->operstate = operstate;
 			pin_changed = true;
 		}
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index d425dc67250fe..8015808bdf548 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -98,7 +98,14 @@
 
 #define ZL_REG_REF_MON_STATUS(_idx)					\
 	ZL_REG_IDX(_idx, 2, 0x02, 1, ZL3073X_NUM_REFS, 1)
-#define ZL_REF_MON_STATUS_OK			0 /* all bits zeroed */
+#define ZL_REF_MON_STATUS_OK			0
+#define ZL_REF_MON_STATUS_LOS			BIT(0)
+#define ZL_REF_MON_STATUS_SCM			BIT(1)
+#define ZL_REF_MON_STATUS_CFM			BIT(2)
+#define ZL_REF_MON_STATUS_GST			BIT(3)
+#define ZL_REF_MON_STATUS_PFM			BIT(4)
+#define ZL_REF_MON_STATUS_ESYNC			BIT(6)
+#define ZL_REF_MON_STATUS_SPLIT_XO		BIT(7)
 
 #define ZL_REG_DPLL_MON_STATUS(_idx)					\
 	ZL_REG_IDX(_idx, 2, 0x10, 1, ZL3073X_MAX_CHANNELS, 1)
-- 
2.53.0


