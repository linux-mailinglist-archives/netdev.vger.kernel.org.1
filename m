Return-Path: <netdev+bounces-248952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F8D11C8A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C08930D5A20
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 10:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0352BCF6C;
	Mon, 12 Jan 2026 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYm4Sw3q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D029D289
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212877; cv=none; b=ar/3G5+M6XWePcZhFJFuNzWTMCEmQ3jVM494K23j1XxHcZauFoWJhD3f4R12gbXAjIGghFS56/yyRfM1nRVW8jI2BbzYfYvGyXbqCNAu+KxessWmO1mWpbkuBQDs/Ksy3zJcOvSWgRB0MnImWoM57Ona2VxQOGOBy2iPLMt/9bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212877; c=relaxed/simple;
	bh=+JAHVeoqmWz9ifSX179xCU8Xhlht/F22cdn5Mshqxf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLmeXxAeW/W/IezUo1OA854gwy3rY3MxKGkWAmKGXt5Ne4Hr/77F3xE/Dewz4yd/fcvOK/ml0OG0EENcH6H3Ir68pNTEGLwffh1FrcYqWB5XnpbEwxWvxgxJGkc7fhtgZHxvHT8roHifdcNCiI2qS0GoHrhImYpMtoEgqFb2vGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYm4Sw3q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768212874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DWpWwB9ZaWybdX8ghH1Z/TMT+vka5vFYv9PdyEOVGc=;
	b=hYm4Sw3qG83ZaH+ZhgB1RRDEwbKZaCINkaPtzttb4WvxXTnLJxJGKnQqQrvuhBuk7hssL1
	QPD63flzn2pX0qFhRqjSFroeAU0mA0+iFk5BIQoQc6ubcESYaOX7PQfKztHeFvt6N5eP99
	2MhjUhNZ2fsIiKaC1HiBDUjxldxr6cQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-QMhuIiMdOcOhwU1UZsb23Q-1; Mon,
 12 Jan 2026 05:14:32 -0500
X-MC-Unique: QMhuIiMdOcOhwU1UZsb23Q-1
X-Mimecast-MFC-AGG-ID: QMhuIiMdOcOhwU1UZsb23Q_1768212871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA8C3180035D;
	Mon, 12 Jan 2026 10:14:30 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.44.32.158])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 12E4418004D8;
	Mon, 12 Jan 2026 10:14:25 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>
Subject: [PATCH net-next 3/3] dpll: zl3073x: Implement device mode setting support
Date: Mon, 12 Jan 2026 11:14:09 +0100
Message-ID: <20260112101409.804206-4-ivecera@redhat.com>
In-Reply-To: <20260112101409.804206-1-ivecera@redhat.com>
References: <20260112101409.804206-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add support for .supported_modes_get() and .mode_set() callbacks
to enable switching between manual and automatic modes via netlink.

Implement .supported_modes_get() to report available modes based
on the current hardware configuration:

* manual mode is always supported
* automatic mode is supported unless the dpll channel is configured
  in NCO (Numerically Controlled Oscillator) mode

Implement .mode_set() to handle the specific logic required when
transitioning between modes:

1) Transition to manual:
* If a valid reference is currently active, switch the hardware
  to ref-lock mode (force lock to that reference).
* If no reference is valid and the DPLL is unlocked, switch to freerun.
* Otherwise, switch to Holdover.

2) Transition to automatic:
* If the currently selected reference pin was previously marked
  as non-selectable (likely during a previous manual forcing
  operation), restore its priority and selectability in the hardware.
* Switch the hardware to Automatic selection mode.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 106 ++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 9879d85d29af0..d0a9c361dc1d8 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -100,6 +100,20 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_pin_get_by_ref(struct zl3073x_dpll *zldpll, u8 ref_id)
+{
+	struct zl3073x_dpll_pin *pin;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (zl3073x_dpll_is_input_pin(pin) &&
+		    zl3073x_input_pin_ref_get(pin->id) == ref_id)
+			return pin;
+	}
+
+	return NULL;
+}
+
 static int
 zl3073x_dpll_input_pin_esync_get(const struct dpll_pin *dpll_pin,
 				 void *pin_priv,
@@ -1137,6 +1151,26 @@ zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_supported_modes_get(const struct dpll_device *dpll,
+				 void *dpll_priv, unsigned long *modes,
+				 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	/* We support switching between automatic and manual mode, except in
+	 * a case where the DPLL channel is configured to run in NCO mode.
+	 * In this case, report only the manual mode to which the NCO is mapped
+	 * as the only supported one.
+	 */
+	if (zldpll->refsel_mode != ZL_DPLL_MODE_REFSEL_MODE_NCO)
+		__set_bit(DPLL_MODE_AUTOMATIC, modes);
+
+	__set_bit(DPLL_MODE_MANUAL, modes);
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 		      enum dpll_mode *mode, struct netlink_ext_ack *extack)
@@ -1217,6 +1251,76 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+zl3073x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
+		      enum dpll_mode mode, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	u8 hw_mode, mode_refsel, ref;
+	int rc;
+
+	rc = zl3073x_dpll_selected_ref_get(zldpll, &ref);
+	if (rc) {
+		NL_SET_ERR_MSG_MOD(extack, "failed to get selected reference");
+		return rc;
+	}
+
+	if (mode == DPLL_MODE_MANUAL) {
+		/* We are switching from automatic to manual mode:
+		 * - if we have a valid reference selected during auto mode then
+		 *   we will switch to forced reference lock mode and use this
+		 *   reference for selection
+		 * - if NO valid reference is selected, we will switch to forced
+		 *   holdover mode or freerun mode, depending on the current
+		 *   lock status
+		 */
+		if (ZL3073X_DPLL_REF_IS_VALID(ref))
+			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
+		else if (zldpll->lock_status == DPLL_LOCK_STATUS_UNLOCKED)
+			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_FREERUN;
+		else
+			hw_mode = ZL_DPLL_MODE_REFSEL_MODE_HOLDOVER;
+	} else {
+		/* We are switching from manual to automatic mode:
+		 * - if there is a valid reference selected then ensure that
+		 *   it is selectable after switch to automatic mode
+		 * - switch to automatic mode
+		 */
+		struct zl3073x_dpll_pin *pin;
+
+		pin = zl3073x_dpll_pin_get_by_ref(zldpll, ref);
+		if (pin && !pin->selectable) {
+			/* Restore pin priority in HW */
+			rc = zl3073x_dpll_ref_prio_set(pin, pin->prio);
+			if (rc)
+				return rc;
+
+			pin->selectable = true;
+		}
+
+		hw_mode = ZL_DPLL_MODE_REFSEL_MODE_AUTO;
+	}
+
+	/* Build mode_refsel value */
+	mode_refsel = FIELD_PREP(ZL_DPLL_MODE_REFSEL_MODE, hw_mode);
+
+	if (ZL3073X_DPLL_REF_IS_VALID(ref))
+		mode_refsel |= FIELD_PREP(ZL_DPLL_MODE_REFSEL_REF, ref);
+
+	/* Update dpll_mode_refsel register */
+	rc = zl3073x_write_u8(zldpll->dev, ZL_REG_DPLL_MODE_REFSEL(zldpll->id),
+			      mode_refsel);
+	if (rc)
+		return rc;
+
+	zldpll->refsel_mode = hw_mode;
+
+	if (ZL3073X_DPLL_REF_IS_VALID(ref))
+		zldpll->forced_ref = ref;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_phase_offset_monitor_get(const struct dpll_device *dpll,
 				      void *dpll_priv,
@@ -1276,10 +1380,12 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.lock_status_get = zl3073x_dpll_lock_status_get,
 	.mode_get = zl3073x_dpll_mode_get,
+	.mode_set = zl3073x_dpll_mode_set,
 	.phase_offset_avg_factor_get = zl3073x_dpll_phase_offset_avg_factor_get,
 	.phase_offset_avg_factor_set = zl3073x_dpll_phase_offset_avg_factor_set,
 	.phase_offset_monitor_get = zl3073x_dpll_phase_offset_monitor_get,
 	.phase_offset_monitor_set = zl3073x_dpll_phase_offset_monitor_set,
+	.supported_modes_get = zl3073x_dpll_supported_modes_get,
 };
 
 /**
-- 
2.52.0


