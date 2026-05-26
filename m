Return-Path: <netdev+bounces-291570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD0uA8hPFWpMUQcAu9opvQ
	(envelope-from <netdev+bounces-291570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:46:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8101F5D1DD1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47BE6302BBDE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A43CC7CA;
	Tue, 26 May 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgzPZUAl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4949C3CC338
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781547; cv=none; b=BMsZNynRCt1mAkTg47H/v3WcF0rALEk09mOMAcJP59FsAYp1DjNyYffgHlZ4t2KDbYy3s64nD3yL5onCe6pY2LJQ/w9MRhBu2qRE9FvgrSUlsMBH6G6Dk1tGhurFTulUiVbGoniGOp8hkfDSAwgICFIkHGEfc3UBoPTrSR4Yfzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781547; c=relaxed/simple;
	bh=ygXd+5zAiuT0OPbl2WhlAJJvLUB6id7WDPFZaGehUio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mynP6pNakuh23e5dzsf13crno/jlX2s8aKNxWehhl5WNkXitYAfHpS6mGU4++HX1kZA9v+6j7v7tK+iv8qAUBtN8BlmAFjmHU6N3dvuTEWa+S+0QQMiD/LWxQ7knOvQ9WVIGutUSAqtUWgwzTTOkJXHmQc13c5g7NJ0NVa0nsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgzPZUAl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779781545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iz3MlEfb0H6qdVr9/ytwIUo1zGOfV+YQvCMvxpC2NyE=;
	b=UgzPZUAlDy1xUH64vmiYe6BlJ+BZ0mxZe8S4lTDgbnQoKMJh1JN0H2ib4Mnhnkz+Kn2s+Y
	xvUGNHVpL1skhv1q2XvzlGT54EG5Rc/AboqLIKTIMZYdaCsKfDP6VayzTe9XzWPwfQ5R23
	XaOOXYMH6CFDtsSryJpEZTuA0xBg0cQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-8x15vvB_M5iaG8N-l8agww-1; Tue,
 26 May 2026 03:45:40 -0400
X-MC-Unique: 8x15vvB_M5iaG8N-l8agww-1
X-Mimecast-MFC-AGG-ID: 8x15vvB_M5iaG8N-l8agww_1779781538
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C34C1956096;
	Tue, 26 May 2026 07:45:38 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.138])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAB141800465;
	Tue, 26 May 2026 07:45:35 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Petr Oros <poros@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] dpll: zl3073x: make frequency monitor a per-device attribute
Date: Tue, 26 May 2026 09:45:25 +0200
Message-ID: <20260526074525.1451008-4-ivecera@redhat.com>
In-Reply-To: <20260526074525.1451008-1-ivecera@redhat.com>
References: <20260526074525.1451008-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291570-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8101F5D1DD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The frequency monitoring feature uses shared hardware registers
that measure input reference frequencies independently of
individual DPLL channels. However, the freq_monitor flag was
incorrectly placed in the per-DPLL structure, causing each
channel to track its own enable/disable state independently.

Since the DPLL core calls measured_freq_get() only for the first
pin registration, the measured_freq_check() in the periodic worker
was gated by the per-DPLL freq_monitor flag of whichever channel
happens to be checked. If the first DPLL channel had frequency
monitoring disabled while another had it enabled, measurements
were never reported.

Move freq_monitor from struct zl3073x_dpll to struct zl3073x_dev
so all DPLL channels share a single flag, matching the hardware
behavior. Update freq_monitor_set() to notify other DPLL devices
about the change (like phase_offset_avg_factor_set() already does)
and remove the mode-dependent guard in zl3073x_dpll_changes_check()
since all input pin monitoring (pin state, phase offset, FFO, and
measured frequency) works correctly in all DPLL modes.

Fixes: bfc923b642874 ("dpll: zl3073x: implement frequency monitoring")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 19 ++++++++-----------
 drivers/dpll/zl3073x/core.h |  4 +++-
 drivers/dpll/zl3073x/dpll.c | 29 ++++++++++++++---------------
 drivers/dpll/zl3073x/dpll.h |  2 --
 4 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 5f1e70f3e40a..0a133b0f2d97 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -762,18 +762,15 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 		dev_warn(zldev->dev, "Failed to update phase offsets: %pe\n",
 			 ERR_PTR(rc));
 
-	/* Update measured input reference frequencies if any DPLL has
-	 * frequency monitoring enabled.
+	/* Update measured input reference frequencies if frequency
+	 * monitoring is enabled.
 	 */
-	list_for_each_entry(zldpll, &zldev->dplls, list) {
-		if (zldpll->freq_monitor) {
-			rc = zl3073x_ref_freq_meas_update(zldev);
-			if (rc)
-				dev_warn(zldev->dev,
-					 "Failed to update measured frequencies: %pe\n",
-					 ERR_PTR(rc));
-			break;
-		}
+	if (zldev->freq_monitor) {
+		rc = zl3073x_ref_freq_meas_update(zldev);
+		if (rc)
+			dev_warn(zldev->dev,
+				 "Failed to update measured frequencies: %pe\n",
+				 ERR_PTR(rc));
 	}
 
 	/* Update references' fractional frequency offsets */
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 99440620407d..addba378b0df 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -57,6 +57,7 @@ struct zl3073x_chip_info {
  * @work: periodic work
  * @clock_id: clock id of the device
  * @phase_avg_factor: phase offset measurement averaging factor
+ * @freq_monitor: is frequency monitor enabled
  */
 struct zl3073x_dev {
 	struct device			*dev;
@@ -77,9 +78,10 @@ struct zl3073x_dev {
 	struct kthread_worker		*kworker;
 	struct kthread_delayed_work	work;
 
-	/* Devlink parameters */
+	/* Per-chip parameters */
 	u64			clock_id;
 	u8			phase_avg_factor;
+	bool			freq_monitor;
 };
 
 extern const struct regmap_config zl3073x_regmap_config;
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 0770bd895de9..0bfcbae2109f 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1212,7 +1212,7 @@ zl3073x_dpll_freq_monitor_get(const struct dpll_device *dpll,
 {
 	struct zl3073x_dpll *zldpll = dpll_priv;
 
-	if (zldpll->freq_monitor)
+	if (zldpll->dev->freq_monitor)
 		*state = DPLL_FEATURE_STATE_ENABLE;
 	else
 		*state = DPLL_FEATURE_STATE_DISABLE;
@@ -1226,9 +1226,19 @@ zl3073x_dpll_freq_monitor_set(const struct dpll_device *dpll,
 			      enum dpll_feature_state state,
 			      struct netlink_ext_ack *extack)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll *item, *zldpll = dpll_priv;
 
-	zldpll->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
+	zldpll->dev->freq_monitor = (state == DPLL_FEATURE_STATE_ENABLE);
+
+	/* The frequency monitoring is common for all DPLL channels so after
+	 * change we have to send a notification for other DPLL devices.
+	 */
+	list_for_each_entry(item, &zldpll->dev->dplls, list) {
+		struct dpll_device *dpll_dev = READ_ONCE(item->dpll_dev);
+
+		if (item != zldpll && dpll_dev)
+			__dpll_device_change_ntf(dpll_dev);
+	}
 
 	return 0;
 }
@@ -1745,7 +1755,7 @@ zl3073x_dpll_pin_measured_freq_check(struct zl3073x_dpll_pin *pin)
 	u8 ref_id;
 	u32 freq;
 
-	if (!zldpll->freq_monitor)
+	if (!zldpll->dev->freq_monitor)
 		return false;
 
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
@@ -1778,10 +1788,8 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 	struct zl3073x_dev *zldev = zldpll->dev;
 	enum dpll_lock_status lock_status;
 	struct device *dev = zldev->dev;
-	const struct zl3073x_chan *chan;
 	struct zl3073x_dpll_pin *pin;
 	int rc;
-	u8 mode;
 
 	zldpll->check_count++;
 
@@ -1800,15 +1808,6 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 		dpll_device_change_ntf(zldpll->dpll_dev);
 	}
 
-	/* Input pin monitoring does make sense only in automatic
-	 * or forced reference modes.
-	 */
-	chan = zl3073x_chan_state_get(zldev, zldpll->id);
-	mode = zl3073x_chan_mode_get(chan);
-	if (mode != ZL_DPLL_MODE_REFSEL_MODE_AUTO &&
-	    mode != ZL_DPLL_MODE_REFSEL_MODE_REFLOCK)
-		return;
-
 	/* Update phase offset latch registers for this DPLL if the phase
 	 * offset monitor feature is enabled.
 	 */
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index c8bc8437a709..21adcc18e45e 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -15,7 +15,6 @@
  * @id: DPLL index
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
- * @freq_monitor: is frequency monitor enabled
  * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
@@ -28,7 +27,6 @@ struct zl3073x_dpll {
 	u8				id;
 	u8				check_count;
 	bool				phase_monitor;
-	bool				freq_monitor;
 	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
-- 
2.53.0


