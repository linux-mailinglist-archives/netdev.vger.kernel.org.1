Return-Path: <netdev+bounces-273129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHGoG6BYymn27gUAu9opvQ
	(envelope-from <netdev+bounces-273129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:04:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F23EA359E36
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 13:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE28930939D4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CE3C3453;
	Mon, 30 Mar 2026 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPvmypM3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC93C1417
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868135; cv=none; b=MVLXFxsgh+7E68LeirETdivBpR0jdqqVgmpi3omrI/8XgefbuvcwQrjqaeS38h4chsdRWTqhQHjDEBTfNR4bvGuGVAWWdIKPClDKNV/ZxtxlenRc5qLFHcpdVEmrTe48nZs4/oVrCsZryUCPYyEvBz0DzLD3CMwYhSzr5Qpoyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868135; c=relaxed/simple;
	bh=yjBpcI9N0GnIr6wfTe3zSUr7UJWSW7bx13VlTx4KLi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gtw3S/i7JixU+kOMbYlvc2qtz8rHx7y8vjcZLOCejTvWbwsObQMAoqlQpoSQMW1TM0R4DWnwdZDGM3ukK0/vDvsIXUrW0IawGv/qcR02IlnziYJbc9tQ8lE0PPLpG5GOW41Z7F4++Wqjpw30YLYy8Q5qGjuH5a2jHYfbK0g5uT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPvmypM3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774868133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jPMYItvFpUhlWpNSE8o3uSb2x7kHbFCK0KOsdtjXZ4Q=;
	b=HPvmypM3VHabGGfh0Pigg3f8nbTEdYX1a31EQiRd4ix7h5QEd2/7/UGUk/ISXUnsi4aNYn
	W2GL9oAKg5aEXAQrCsjC3m0bIMLnVWxVYRBFGzXRMQc14C8gogrtHB77IbEaBv1dWdIhZt
	UUThhHdMz6QMzq31ZDrXaLo+TI93uWM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-H0_1IofUNw-9AZ2odr4FMg-1; Mon,
 30 Mar 2026 06:55:29 -0400
X-MC-Unique: H0_1IofUNw-9AZ2odr4FMg-1
X-Mimecast-MFC-AGG-ID: H0_1IofUNw-9AZ2odr4FMg_1774868128
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A24A195609E;
	Mon, 30 Mar 2026 10:55:28 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.70])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8426430001A1;
	Mon, 30 Mar 2026 10:55:23 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Petr Oros <poros@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] dpll: zl3073x: implement frequency monitoring
Date: Mon, 30 Mar 2026 12:55:05 +0200
Message-ID: <20260330105505.715099-4-ivecera@redhat.com>
In-Reply-To: <20260330105505.715099-1-ivecera@redhat.com>
References: <20260330105505.715099-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273129-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F23EA359E36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract common measurement latch logic from zl3073x_ref_ffo_update()
into a new zl3073x_ref_freq_meas_latch() helper and add
zl3073x_ref_freq_meas_update() that uses it to latch and read absolute
input reference frequencies in Hz.

Add meas_freq field to struct zl3073x_ref and the corresponding
zl3073x_ref_meas_freq_get() accessor. The measured frequencies are
updated periodically alongside the existing FFO measurements.

Add freq_monitor boolean to struct zl3073x_dpll and implement the
freq_monitor_set/get device callbacks to enable/disable frequency
monitoring via the DPLL netlink interface.

Implement measured_freq_get pin callback for input pins that returns the
measured input frequency in Hz.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 88 +++++++++++++++++++++++++++++++------
 drivers/dpll/zl3073x/dpll.c | 88 ++++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/dpll.h |  2 +
 drivers/dpll/zl3073x/ref.h  | 14 ++++++
 4 files changed, 178 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 6363002d48d46..320c199637efa 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -632,22 +632,21 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 }
 
 /**
- * zl3073x_ref_ffo_update - update reference fractional frequency offsets
+ * zl3073x_ref_freq_meas_latch - latch reference frequency measurements
  * @zldev: pointer to zl3073x_dev structure
+ * @type: measurement type (ZL_REF_FREQ_MEAS_CTRL_*)
  *
- * The function asks device to update fractional frequency offsets latch
- * registers the latest measured values, reads and stores them into
+ * The function waits for the previous measurement to finish, selects all
+ * references and requests a new measurement of the given type.
  *
  * Return: 0 on success, <0 on error
  */
 static int
-zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
+zl3073x_ref_freq_meas_latch(struct zl3073x_dev *zldev, u8 type)
 {
-	int i, rc;
+	int rc;
 
-	/* Per datasheet we have to wait for 'ref_freq_meas_ctrl' to be zero
-	 * to ensure that the measured data are coherent.
-	 */
+	/* Wait for previous measurement to finish */
 	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
 				  ZL_REF_FREQ_MEAS_CTRL);
 	if (rc)
@@ -663,15 +662,64 @@ zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
 	if (rc)
 		return rc;
 
-	/* Request frequency offset measurement */
-	rc = zl3073x_write_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
-			      ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF);
+	/* Request measurement */
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL, type);
 	if (rc)
 		return rc;
 
 	/* Wait for finish */
-	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
-				  ZL_REF_FREQ_MEAS_CTRL);
+	return zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
+				    ZL_REF_FREQ_MEAS_CTRL);
+}
+
+/**
+ * zl3073x_ref_freq_meas_update - update measured input reference frequencies
+ * @zldev: pointer to zl3073x_dev structure
+ *
+ * The function asks device to latch measured input reference frequencies
+ * and stores the results in the ref state.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_ref_freq_meas_update(struct zl3073x_dev *zldev)
+{
+	int i, rc;
+
+	rc = zl3073x_ref_freq_meas_latch(zldev, ZL_REF_FREQ_MEAS_CTRL_REF_FREQ);
+	if (rc)
+		return rc;
+
+	/* Read measured frequencies in Hz (unsigned 32-bit, LSB = 1 Hz) */
+	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
+		u32 value;
+
+		rc = zl3073x_read_u32(zldev, ZL_REG_REF_FREQ(i), &value);
+		if (rc)
+			return rc;
+
+		zldev->ref[i].meas_freq = value;
+	}
+
+	return 0;
+}
+
+/**
+ * zl3073x_ref_ffo_update - update reference fractional frequency offsets
+ * @zldev: pointer to zl3073x_dev structure
+ *
+ * The function asks device to update fractional frequency offsets latch
+ * registers the latest measured values, reads and stores them into
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_ref_ffo_update(struct zl3073x_dev *zldev)
+{
+	int i, rc;
+
+	rc = zl3073x_ref_freq_meas_latch(zldev,
+					 ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF);
 	if (rc)
 		return rc;
 
@@ -714,6 +762,20 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 		dev_warn(zldev->dev, "Failed to update phase offsets: %pe\n",
 			 ERR_PTR(rc));
 
+	/* Update measured input reference frequencies if any DPLL has
+	 * frequency monitoring enabled.
+	 */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		if (zldpll->freq_monitor) {
+			rc = zl3073x_ref_freq_meas_update(zldev);
+			if (rc)
+				dev_warn(zldev->dev,
+					 "Failed to update measured frequencies: %pe\n",
+					 ERR_PTR(rc));
+			break;
+		}
+	}
+
 	/* Update references' fractional frequency offsets */
 	rc = zl3073x_ref_ffo_update(zldev);
 	if (rc)
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index a29f606318f6d..c44bfecf2c265 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -39,6 +39,7 @@
  * @pin_state: last saved pin state
  * @phase_offset: last saved pin phase offset
  * @freq_offset: last saved fractional frequency offset
+ * @measured_freq: last saved measured frequency
  */
 struct zl3073x_dpll_pin {
 	struct list_head	list;
@@ -54,6 +55,7 @@ struct zl3073x_dpll_pin {
 	enum dpll_pin_state	pin_state;
 	s64			phase_offset;
 	s64			freq_offset;
+	u32			measured_freq;
 };
 
 /*
@@ -202,6 +204,20 @@ zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+static int
+zl3073x_dpll_input_pin_measured_freq_get(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv, u64 *measured_freq,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	*measured_freq = pin->measured_freq;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				     void *pin_priv,
@@ -1116,6 +1132,35 @@ zl3073x_dpll_phase_offset_monitor_set(const struct dpll_device *dpll,
 	return 0;
 }
 
+static int
+zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll,
+			      void *dpll_priv,
+			      enum dpll_feature_state *state,
+			      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	if (zldpll->freq_monitor)
+		*state = DPLL_FEATURE_STATE_ENABLE;
+	else
+		*state = DPLL_FEATURE_STATE_DISABLE;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
+			      void *dpll_priv,
+			      enum dpll_feature_state state,
+			      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	zldpll->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
+
+	return 0;
+}
+
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
@@ -1123,6 +1168,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.ffo_get = zl3073x_dpll_input_pin_ffo_get,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
+	.measured_freq_get = zl3073x_dpll_input_pin_measured_freq_get,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
 	.phase_adjust_get = zl3073x_dpll_input_pin_phase_adjust_get,
 	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
@@ -1151,6 +1197,8 @@ static const struct dpll_device_ops zl3073x_dpll_device_ops = {
 	.phase_offset_avg_factor_set = zl3073x_dpll_phase_offset_avg_factor_set,
 	.phase_offset_monitor_get = zl3073x_dpll_phase_offset_monitor_get,
 	.phase_offset_monitor_set = zl3073x_dpll_phase_offset_monitor_set,
+	.freq_monitor_get = zl3073x_dpll_freq_monitor_get,
+	.freq_monitor_set = zl3073x_dpll_freq_monitor_set,
 	.supported_modes_get = zl3073x_dpll_supported_modes_get,
 };
 
@@ -1593,6 +1641,39 @@ zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
 	return false;
 }
 
+/**
+ * zl3073x_dpll_pin_measured_freq_check - check for pin measured frequency change
+ * @pin: pin to check
+ *
+ * Check for the given pin's measured frequency change.
+ *
+ * Return: true on measured frequency change, false otherwise
+ */
+static bool
+zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_ref *ref;
+	u8 ref_id;
+
+	if (!zldpll->freq_monitor)
+		return false;
+
+	ref_id = zl3073x_input_pin_ref_get(pin->id);
+	ref = zl3073x_ref_state_get(zldev, ref_id);
+
+	if (pin->measured_freq != ref->meas_freq) {
+		dev_dbg(zldev->dev, "%s measured freq changed: %u -> %u\n",
+			pin->label, pin->measured_freq, ref->meas_freq);
+		pin->measured_freq = ref->meas_freq;
+
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * zl3073x_dpll_changes_check - check for changes and send notifications
  * @zldpll: pointer to zl3073x_dpll structure
@@ -1677,13 +1758,18 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 			pin_changed = true;
 		}
 
-		/* Check for phase offset and ffo change once per second */
+		/* Check for phase offset, ffo, and measured freq change
+		 * once per second.
+		 */
 		if (zldpll->check_count % 2 == 0) {
 			if (zl3073x_dpll_pin_phase_offset_check(pin))
 				pin_changed = true;
 
 			if (zl3073x_dpll_pin_ffo_check(pin))
 				pin_changed = true;
+
+			if (zl3073x_dpll_pin_measured_freq_check(pin))
+				pin_changed = true;
 		}
 
 		if (pin_changed)
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index 115ee4f67e7ab..434c32a7db123 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -15,6 +15,7 @@
  * @id: DPLL index
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
+ * @freq_monitor: is frequency monitor enabled
  * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
@@ -28,6 +29,7 @@ struct zl3073x_dpll {
 	u8				id;
 	u8				check_count;
 	bool				phase_monitor;
+	bool				freq_monitor;
 	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
diff --git a/drivers/dpll/zl3073x/ref.h b/drivers/dpll/zl3073x/ref.h
index 06d8d4d97ea26..be16be20dbc7e 100644
--- a/drivers/dpll/zl3073x/ref.h
+++ b/drivers/dpll/zl3073x/ref.h
@@ -23,6 +23,7 @@ struct zl3073x_dev;
  * @sync_ctrl: reference sync control
  * @config: reference config
  * @ffo: current fractional frequency offset
+ * @meas_freq: measured input frequency in Hz
  * @mon_status: reference monitor status
  */
 struct zl3073x_ref {
@@ -40,6 +41,7 @@ struct zl3073x_ref {
 	);
 	struct_group(stat, /* Status */
 		s64	ffo;
+		u32	meas_freq;
 		u8	mon_status;
 	);
 };
@@ -68,6 +70,18 @@ zl3073x_ref_ffo_get(const struct zl3073x_ref *ref)
 	return ref->ffo;
 }
 
+/**
+ * zl3073x_ref_meas_freq_get - get measured input frequency
+ * @ref: pointer to ref state
+ *
+ * Return: measured input frequency in Hz
+ */
+static inline u32
+zl3073x_ref_meas_freq_get(const struct zl3073x_ref *ref)
+{
+	return ref->meas_freq;
+}
+
 /**
  * zl3073x_ref_freq_get - get given input reference frequency
  * @ref: pointer to ref state
-- 
2.52.0


