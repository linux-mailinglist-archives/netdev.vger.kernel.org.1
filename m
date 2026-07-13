Return-Path: <netdev+bounces-307121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pt8gOUnAVGrjqgMAu9opvQ
	(envelope-from <netdev+bounces-307121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:39:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3738C749E41
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:39:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=KDZzSSid;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307121-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307121-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A68F302A50D
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 10:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E67305695;
	Mon, 13 Jul 2026 10:38:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F837A85E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 10:38:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939085; cv=none; b=EYIh/1T2d+bWpad2O7L8YQA/qgOGerQLu6e8Hz8bQGXo4Oa3drbqMk7jToRJSN18hZbAXCXH3zPxaKvtrq/liWICz4FN3x4/pQdXz++bFNlf78aFcs2gAHW23ktI7n6flbir3spLLRWx9QxeGs9a/SFet768GSIE1KKqUoJjAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939085; c=relaxed/simple;
	bh=7yUZNJ0pIhtSH39IcGaiKtDJ7kovrMY1ZZinqv/Sp+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STKuYjskvUtmrWwXWi4rdleUE5/mYqiduZSvdlEd/7sJLHcdF6kQi1Y8PM/wcu+oLcqyWrlkoZ2r+HIq2PjRM9jj09GDnDtQ/A+hIY7+ZpliVcIsurKc+Qs100+5Ql+i7JwIRtNf8FhZKiQ5o+TgP+jH7Qk+bsUh3ERv5FghoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDZzSSid; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783939082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h38j6WamaKlW8fuY8AxqPnJqcqYj9/PfHX+duEtTvgs=;
	b=KDZzSSidByd/GqzdIxg0piDL2QEaBzdug4rz55jNutfCb4UUDHlLF0F6PwAuZuB9Q8Q9Dm
	epCS+XEjhApWmi98SZ4vH3OmnCUDeLz1ncs8T0gsd3JhQvg55e5Z0/A83+7UmZyWqeipeC
	4mkUMGDVUTWu06wW/FofjC1VJMai9oA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-Cpqhjf-HM3uB0FMLVxIcdw-1; Mon,
 13 Jul 2026 06:37:57 -0400
X-MC-Unique: Cpqhjf-HM3uB0FMLVxIcdw-1
X-Mimecast-MFC-AGG-ID: Cpqhjf-HM3uB0FMLVxIcdw_1783939075
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 340981955D5F;
	Mon, 13 Jul 2026 10:37:55 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8608D1953951;
	Mon, 13 Jul 2026 10:37:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] dpll: zl3073x: add PTP clock support
Date: Mon, 13 Jul 2026 12:37:39 +0200
Message-ID: <20260713103739.1553284-3-ivecera@redhat.com>
In-Reply-To: <20260713103739.1553284-1-ivecera@redhat.com>
References: <20260713103739.1553284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[microchip.com,intel.com,davemloft.net,kernel.org,resnulli.us,redhat.com,gmail.com,linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307121-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:Chris.duQuesnay@microchip.com,m:arkadiusz.kubalewski@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:jiri@resnulli.us,m:mschmidt@redhat.com,m:pabeni@redhat.com,m:pvaanane@redhat.com,m:poros@redhat.com,m:Prathosh.Satish@microchip.com,m:richardcochran@gmail.com,m:horms@kernel.org,m:vadim.fedorenko@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3738C749E41

Add PTP clock support for the ZL3073x DPLL driver. A PTP clock device
is registered for each DPLL channel regardless of the initial channel
state, providing gettimex64, settime64, adjtime, adjfine, adjphase,
getmaxphase and perout callbacks.

Callback availability depends on the current channel state:
- adjfine: when NCO pin is connected (returns -EOPNOTSUPP otherwise)
- adjphase: available when tracking a reference, uses TIE write
- adjtime: always available and uses
  * phase step for sub-second deltas when NCO pin is connected
  * TIE write when tracking a reference
  * plain ToD read-modify-write otherwise
- gettime/settime: always available

The adjtime callback splits multi-second adjustments into a ToD
read-modify-write for the seconds part and a sub-second mechanism
(phase step or TIE write) for the remainder. On partial failure
where seconds were already committed, success is returned to
prevent the PTP servo from retrying and applying seconds again.

Output pins eligible for periodic output (single-ended, marked in
output_step_time_mask, supporting 1 Hz) are registered as PTP perout
channels. Enabling perout sets the output frequency to 1 Hz via the
existing DPLL frequency_set path.

All PTP callbacks are serialized by the existing per-DPLL zldpll->lock
mutex, which is also used by DPLL pin and device callbacks.

Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   6 +
 3 files changed, 551 insertions(+), 36 deletions(-)

diff --git a/drivers/dpll/zl3073x/Kconfig b/drivers/dpll/zl3073x/Kconfig
index 5bbca14005813..d0574ad571d3f 100644
--- a/drivers/dpll/zl3073x/Kconfig
+++ b/drivers/dpll/zl3073x/Kconfig
@@ -2,7 +2,7 @@
 
 config ZL3073X
 	tristate "Microchip Azurite DPLL/PTP/SyncE devices" if COMPILE_TEST
-	depends on NET
+	depends on NET && PTP_1588_CLOCK_OPTIONAL
 	select DPLL
 	select NET_DEVLINK
 	select REGMAP
@@ -16,7 +16,7 @@ config ZL3073X
 
 config ZL3073X_I2C
 	tristate "I2C bus implementation for Microchip Azurite devices"
-	depends on I2C && NET
+	depends on I2C && NET && PTP_1588_CLOCK_OPTIONAL
 	select REGMAP_I2C
 	select ZL3073X
 	help
@@ -28,7 +28,7 @@ config ZL3073X_I2C
 
 config ZL3073X_SPI
 	tristate "SPI bus implementation for Microchip Azurite devices"
-	depends on NET && SPI
+	depends on NET && SPI && PTP_1588_CLOCK_OPTIONAL
 	select REGMAP_SPI
 	select ZL3073X
 	help
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index d91f52b58eae3..7c11de35821ae 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -2,6 +2,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/bug.h>
 #include <linux/container_of.h>
 #include <linux/dev_printk.h>
@@ -14,6 +15,7 @@
 #include <linux/netlink.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/ptp_clock_kernel.h>
 #include <linux/slab.h>
 #include <linux/sprintf.h>
 
@@ -42,6 +44,7 @@
  * @phase_offset: last saved pin phase offset
  * @freq_offset: last saved fractional frequency offset
  * @measured_freq: last saved measured frequency
+ * @perout_idx: PTP perout channel index, or -1 if not perout-eligible
  */
 struct zl3073x_dpll_pin {
 	struct list_head	list;
@@ -59,6 +62,7 @@ struct zl3073x_dpll_pin {
 	s64			phase_offset;
 	s64			freq_offset;
 	u32			measured_freq;
+	s8			perout_idx;
 };
 
 /*
@@ -936,21 +940,17 @@ zl3073x_dpll_output_pin_frequency_get(const struct dpll_pin *dpll_pin,
 }
 
 static int
-zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
-				      void *pin_priv,
-				      const struct dpll_device *dpll,
-				      void *dpll_priv, u64 frequency,
-				      struct netlink_ext_ack *extack)
+__zl3073x_dpll_output_pin_frequency_set(struct zl3073x_dpll *zldpll,
+					struct zl3073x_dpll_pin *pin,
+					u64 frequency)
 {
-	struct zl3073x_dpll *zldpll = dpll_priv;
 	struct zl3073x_dev *zldev = zldpll->dev;
-	struct zl3073x_dpll_pin *pin = pin_priv;
 	const struct zl3073x_synth *synth;
 	u32 new_div, synth_freq;
 	struct zl3073x_out out;
 	u8 out_id;
 
-	guard(mutex)(&zldpll->lock);
+	lockdep_assert_held(&zldpll->lock);
 
 	out_id = zl3073x_output_pin_out_get(pin->id);
 	out = *zl3073x_out_state_get(zldev, out_id);
@@ -1011,6 +1011,21 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 	return zl3073x_out_state_set(zldev, out_id, &out);
 }
 
+static int
+zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				      void *pin_priv,
+				      const struct dpll_device *dpll,
+				      void *dpll_priv, u64 frequency,
+				      struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+
+	guard(mutex)(&zldpll->lock);
+
+	return __zl3073x_dpll_output_pin_frequency_set(zldpll, pin_priv,
+						       frequency);
+}
+
 static int
 zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 					 void *pin_priv,
@@ -1608,6 +1623,7 @@ zl3073x_dpll_pin_alloc(struct zl3073x_dpll *zldpll, enum dpll_pin_direction dir,
 	pin->dpll = zldpll;
 	pin->dir = dir;
 	pin->id = id;
+	pin->perout_idx = -1;
 
 	return pin;
 }
@@ -1626,6 +1642,44 @@ zl3073x_dpll_pin_free(struct zl3073x_dpll_pin *pin)
 	kfree(pin);
 }
 
+/**
+ * zl3073x_dpll_pin_is_perout - check if output pin is perout-eligible
+ * @pin: DPLL pin to check
+ * @props: pin properties (already fetched by caller)
+ *
+ * An output pin is eligible for PTP periodic output if it is single-ended
+ * (not differential) and supports 1 Hz in its frequency list.
+ *
+ * Return: true if eligible, false otherwise
+ */
+static bool
+zl3073x_dpll_pin_is_perout(struct zl3073x_dpll_pin *pin,
+			   const struct zl3073x_pin_props *props)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	const struct zl3073x_chan *chan;
+	u8 out_id;
+	int i;
+
+	if (zl3073x_dpll_is_input_pin(pin))
+		return false;
+
+	out_id = zl3073x_output_pin_out_get(pin->id);
+	if (zl3073x_dev_out_is_diff(zldpll->dev, out_id))
+		return false;
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_is_out_stepped(chan, out_id))
+		return false;
+
+	for (i = 0; i < props->dpll_props.freq_supported_num; i++) {
+		if (props->dpll_props.freq_supported[i].min == 1)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * zl3073x_dpll_pin_register - register DPLL pin
  * @pin: pointer to DPLL pin
@@ -1667,6 +1721,8 @@ zl3073x_dpll_pin_register(struct zl3073x_dpll_pin *pin, u32 index)
 		if (pin->prio == ZL_DPLL_REF_PRIO_NONE)
 			/* Clamp prio to max value */
 			pin->prio = ZL_DPLL_REF_PRIO_MAX;
+	} else if (zl3073x_dpll_pin_is_perout(pin, props)) {
+		pin->perout_idx = zldpll->ptp_info.n_per_out++;
 	}
 
 	/* Create or get existing DPLL pin */
@@ -1897,6 +1953,8 @@ zl3073x_dpll_pins_register(struct zl3073x_dpll *zldpll)
 	u8 id, index;
 	int rc;
 
+	zldpll->ptp_info.n_per_out = 0;
+
 	/* Process input pins */
 	for (index = 0; index < ZL3073X_NUM_PINS; index++) {
 		/* First input pins and then output pins */
@@ -2280,45 +2338,447 @@ zl3073x_dpll_init_fine_phase_adjust(struct zl3073x_dev *zldev)
 	return rc;
 }
 
+/* Maximum frequency adjustment: +-1% of nominal in ppb */
+#define ZL3073X_DPLL_PTP_MAX_ADJ	10000000
+
 /**
- * zl3073x_dpll_alloc - allocate DPLL device
- * @zldev: pointer to zl3073x device
- * @ch: DPLL channel number
+ * zl3073x_dpll_ptp_gettimex64 - read current time from ToD counters
+ * @info: PTP clock info
+ * @ts: timespec to store current time
+ * @sts: optional system timestamp pair for cross-timestamping
  *
- * Allocates DPLL device structure for given DPLL channel.
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_dpll_ptp_gettimex64(struct ptp_clock_info *info,
+				       struct timespec64 *ts,
+				       struct ptp_system_timestamp *sts)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+
+	guard(mutex)(&zldpll->lock);
+
+	return zl3073x_chan_tod_read(zldpll->dev, zldpll->id, false, ts, sts);
+}
+
+/**
+ * zl3073x_dpll_ptp_settime64 - set ToD counters to given time
+ * @info: PTP clock info
+ * @ts: timespec with time to set
  *
- * Return: pointer to DPLL device on success, error pointer on error
+ * Return: 0 on success, <0 on error
  */
-struct zl3073x_dpll *
-zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
+static int zl3073x_dpll_ptp_settime64(struct ptp_clock_info *info,
+				      const struct timespec64 *ts)
 {
-	struct zl3073x_dpll *zldpll;
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
 
-	zldpll = kzalloc_obj(*zldpll);
-	if (!zldpll)
-		return ERR_PTR(-ENOMEM);
+	guard(mutex)(&zldpll->lock);
 
-	zldpll->dev = zldev;
-	zldpll->id = ch;
-	mutex_init(&zldpll->lock);
-	INIT_LIST_HEAD(&zldpll->pins);
+	return zl3073x_chan_tod_write(zldpll->dev, zldpll->id, *ts);
+}
 
-	return zldpll;
+/**
+ * zl3073x_dpll_ptp_adjtime_phase_step - adjust sub-second time via phase step
+ * @zldpll: DPLL channel
+ * @delta: time adjustment in nanoseconds (must be within (-NSEC_PER_SEC,
+ *         NSEC_PER_SEC))
+ *
+ * Uses the output phase step mechanism with tod_step=1 to adjust both
+ * the output clock phase and the ToD counter simultaneously. This keeps
+ * outputs and ToD coherent. Only valid for NCO.
+ *
+ * Outputs are grouped by synthesizer since the phase step value is in
+ * synthesizer clock cycles. The first synth group with enabled outputs
+ * uses tod_step to adjust both outputs and the ToD counter. Remaining
+ * groups step outputs only. If no synth has enabled outputs, the ToD
+ * counter is stepped alone using an empty output mask (the FW uses the
+ * lowest-ID synth's period for the conversion).
+ *
+ * Return: 0 on success, -EOPNOTSUPP if no synths available, <0 on error
+ */
+static int zl3073x_dpll_ptp_adjtime_phase_step(struct zl3073x_dpll *zldpll,
+					       s64 delta)
+{
+	u16 synth_mask[ZL3073X_NUM_SYNTHS] = {};
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_synth *synth;
+	const struct zl3073x_chan *chan;
+	struct zl3073x_dpll_pin *pin;
+	u32 first_synth_freq = 0;
+	bool tod_stepped = false;
+	s32 step_cycles;
+	u32 synth_freq;
+	int rc;
+	u8 i;
+
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	/* Build per-synth output masks from registered output pins */
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		u8 out_id, synth_id;
+
+		if (zl3073x_dpll_is_input_pin(pin))
+			continue;
+
+		out_id = zl3073x_output_pin_out_get(pin->id);
+
+		if (!zl3073x_chan_is_out_stepped(chan, out_id))
+			continue;
+
+		synth_id = zl3073x_dev_out_synth_get(zldev, out_id);
+		if (synth_id >= ZL3073X_NUM_SYNTHS) {
+			dev_warn(zldev->dev, "Unexpected synth id for OUT%u\n",
+				 out_id);
+			continue;
+		}
+		synth_mask[synth_id] |= BIT(out_id);
+	}
+
+	/* Process each synth group */
+	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {
+		synth = zl3073x_synth_state_get(zldev, i);
+		if (!zl3073x_synth_is_enabled(synth) ||
+		    zl3073x_synth_dpll_get(synth) != zldpll->id)
+			continue;
+
+		synth_freq = zl3073x_synth_freq_get(synth);
+
+		/* Remember lowest-ID synth freq for ToD-only fallback */
+		if (!first_synth_freq)
+			first_synth_freq = synth_freq;
+
+		if (!synth_mask[i])
+			continue;
+
+		/* Safe for s32: max synth freq is 750 MHz */
+		step_cycles = div_s64(delta * synth_freq, NSEC_PER_SEC);
+
+		rc = zl3073x_chan_phase_step(zldev, zldpll->id,
+					     synth_mask[i], step_cycles,
+					     !tod_stepped);
+		if (rc) {
+			if (tod_stepped) {
+				dev_warn(zldev->dev,
+					 "Partial phase step failure\n");
+				return 0;
+			}
+			return rc;
+		}
+		tod_stepped = true;
+	}
+
+	if (!first_synth_freq)
+		return -EOPNOTSUPP;
+
+	/* No enabled outputs found; step ToD counter only using the
+	 * lowest-ID synth's period (empty output mask).
+	 */
+	if (!tod_stepped) {
+		step_cycles = div_s64(delta * first_synth_freq, NSEC_PER_SEC);
+		return zl3073x_chan_phase_step(zldev, zldpll->id, 0,
+					       step_cycles, true);
+	}
+
+	return 0;
 }
 
 /**
- * zl3073x_dpll_free - free DPLL device
- * @zldpll: pointer to zl3073x_dpll structure
+ * zl3073x_dpll_ptp_adjtime - adjust PTP clock time
+ * @info: PTP clock info
+ * @delta: time adjustment in nanoseconds
  *
- * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
+ * For NCO, large deltas (>= 1 second) are split into a ToD
+ * read-modify-write for the seconds part and an output phase step for
+ * the sub-second remainder. Sub-second deltas use phase step directly,
+ * falling back to ToD read-modify-write if phase step is unavailable.
+ * In AUTO/REFLOCK modes, large deltas are split into ToD
+ * read-modify-write for seconds and TIE write for the sub-second
+ * remainder. Sub-second deltas use TIE write directly.
+ *
+ * Return: 0 on success, <0 on error
  */
-void
-zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
+static int zl3073x_dpll_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 {
-	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
+	bool sec_adjusted = false;
+	struct timespec64 ts;
+	int rc;
 
-	mutex_destroy(&zldpll->lock);
-	kfree(zldpll);
+	if (!delta)
+		return 0;
+
+	guard(mutex)(&zldpll->lock);
+
+	/* Modes without phase step or TIE use plain ToD adjust */
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan) &&
+	    !zl3073x_chan_mode_supports_tie(chan))
+		return zl3073x_chan_tod_adjust(zldev, zldpll->id,
+					       ns_to_timespec64(delta));
+
+	/* Split off seconds via ToD read-modify-write so the sub-second
+	 * remainder can be applied through the output-coherent mechanism
+	 * (phase step or TIE write).
+	 */
+	if (abs(delta) >= NSEC_PER_SEC) {
+		s32 remainder;
+
+		ts.tv_sec = div_s64_rem(delta, NSEC_PER_SEC, &remainder);
+		ts.tv_nsec = 0;
+		delta = remainder;
+
+		rc = zl3073x_chan_tod_adjust(zldev, zldpll->id, ts);
+		if (rc)
+			return rc;
+
+		sec_adjusted = true;
+
+		/* No sub-second remainder, done */
+		if (!delta)
+			return 0;
+	}
+
+	/* Apply sub-second delta via phase step (NCO) or TIE write */
+	if (zl3073x_chan_mode_is_nco(chan)) {
+		rc = zl3073x_dpll_ptp_adjtime_phase_step(zldpll, delta);
+		if (!rc)
+			return 0;
+	} else {
+		rc = zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+		if (!rc)
+			return 0;
+	}
+
+	/* Phase step or TIE write failed, fall back to ToD adjust */
+	rc = zl3073x_chan_tod_adjust(zldev, zldpll->id,
+				     ns_to_timespec64(delta));
+
+	/* In the unlikely event that both phase step/TIE write and fallback
+	 * ToD adjust fail after seconds were already committed, return
+	 * success to prevent the PTP servo from retrying the full delta and
+	 * applying seconds again. The sub-second residual will self-correct
+	 * in the next servo cycle.
+	 */
+	if (rc && sec_adjusted) {
+		dev_warn(zldev->dev,
+			 "Sub-second adjustment failed after seconds applied\n");
+		return 0;
+	}
+
+	return rc;
+}
+
+/**
+ * zl3073x_dpll_ptp_adjfine - adjust PTP clock frequency
+ * @info: PTP clock info
+ * @scaled_ppm: frequency adjustment in scaled ppm (ppm * 2^16)
+ *
+ * Only supported for NCO. Writes the delta frequency offset register.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if NCO pin is not connected, <0 on error
+ */
+static int
+zl3073x_dpll_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	const struct zl3073x_chan *chan;
+	s64 offset;
+
+	/* Convert scaled_ppm to df_offset in 2^-48 steps:
+	 *   df_offset = -(scaled_ppm * 2^32) / 10^6
+	 *
+	 * Simplify to avoid overflow:
+	 *   df_offset = -(scaled_ppm * 2^26) / 5^6
+	 *   df_offset = -(scaled_ppm * 67108864) / 15625
+	 */
+	offset = -div_s64((s64)scaled_ppm * 67108864LL, 15625);
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldpll->dev, zldpll->id);
+	if (!zl3073x_chan_mode_is_nco(chan))
+		return scaled_ppm ? -EOPNOTSUPP : 0;
+	if (offset == chan->df_offset)
+		return 0;
+
+	return zl3073x_chan_df_offset_set(zldpll->dev, zldpll->id, offset);
+}
+
+/**
+ * zl3073x_dpll_ptp_adjphase - adjust PTP clock phase
+ * @info: PTP clock info
+ * @delta: phase adjustment in nanoseconds
+ *
+ * Only supported in AUTO and REFLOCK modes. Uses TIE write for
+ * nanosecond resolution phase adjustment.
+ *
+ * Return: 0 on success, -EOPNOTSUPP if mode doesn't support TIE, <0 on error
+ */
+static int zl3073x_dpll_ptp_adjphase(struct ptp_clock_info *info, s32 delta)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dev *zldev = zldpll->dev;
+	const struct zl3073x_chan *chan;
+
+	if (!delta)
+		return 0;
+
+	guard(mutex)(&zldpll->lock);
+
+	chan = zl3073x_chan_state_get(zldev, zldpll->id);
+
+	if (!zl3073x_chan_mode_supports_tie(chan))
+		return -EOPNOTSUPP;
+
+	return zl3073x_chan_tie_write(zldev, zldpll->id, delta);
+}
+
+static s32
+zl3073x_dpll_ptp_getmaxphase(struct ptp_clock_info *info __always_unused)
+{
+	/* HW limits TIE write to +-1 second. Return the constant HW
+	 * limit and let adjphase handle mode-specific checks.
+	 */
+	return NSEC_PER_SEC - 1;
+}
+
+/**
+ * zl3073x_dpll_ptp_perout_find_pin - find pin by perout channel index
+ * @zldpll: DPLL channel
+ * @idx: perout channel index to find
+ *
+ * Return: pointer to the pin, or NULL if not found
+ */
+static struct zl3073x_dpll_pin *
+zl3073x_dpll_ptp_perout_find_pin(struct zl3073x_dpll *zldpll, int idx)
+{
+	struct zl3073x_dpll_pin *pin;
+
+	list_for_each_entry(pin, &zldpll->pins, list) {
+		if (pin->perout_idx == idx)
+			return pin;
+	}
+
+	return NULL;
+}
+
+/**
+ * zl3073x_dpll_ptp_enable - enable/disable PTP clock functions
+ * @info: PTP clock info
+ * @rq: the requested clock function and parameters
+ * @on: true to enable, false to disable
+ *
+ * Handles PTP_CLK_REQ_PEROUT requests. Only 1PPS (period = 1s) is supported.
+ * On enable, configures the output divider for 1 Hz. On disable, does nothing
+ * as the signal is not disabled.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_dpll_ptp_enable(struct ptp_clock_info *info,
+				   struct ptp_clock_request *rq, int on)
+{
+	struct zl3073x_dpll *zldpll = container_of(info, struct zl3073x_dpll,
+						   ptp_info);
+	struct zl3073x_dpll_pin *pin;
+	unsigned int idx;
+	int rc;
+
+	if (rq->type != PTP_CLK_REQ_PEROUT)
+		return -EOPNOTSUPP;
+
+	idx = rq->perout.index;
+	if (idx >= info->n_per_out)
+		return -EINVAL;
+
+	/* Toggling output pins can produce runt pulses, so disable
+	 * is a no-op.
+	 */
+	if (!on)
+		return 0;
+
+	/* Only accept exactly 1PPS (period.sec == 1, nsec == 0) */
+	if (rq->perout.period.sec != 1 || rq->perout.period.nsec != 0)
+		return -EINVAL;
+
+	mutex_lock(&zldpll->lock);
+
+	pin = zl3073x_dpll_ptp_perout_find_pin(zldpll, idx);
+	if (!pin) {
+		mutex_unlock(&zldpll->lock);
+		return -EINVAL;
+	}
+
+	/* Already at 1 Hz, nothing to do */
+	if (zl3073x_dev_output_pin_freq_get(zldpll->dev, pin->id) == 1) {
+		mutex_unlock(&zldpll->lock);
+		return 0;
+	}
+
+	rc = __zl3073x_dpll_output_pin_frequency_set(zldpll, pin, 1);
+
+	mutex_unlock(&zldpll->lock);
+
+	if (!rc)
+		dpll_pin_change_ntf(pin->dpll_pin);
+
+	return rc;
+}
+
+static const struct ptp_clock_info zl3073x_dpll_ptp_clock_info = {
+	.owner		= THIS_MODULE,
+	.max_adj	= ZL3073X_DPLL_PTP_MAX_ADJ,
+	.gettimex64	= zl3073x_dpll_ptp_gettimex64,
+	.settime64	= zl3073x_dpll_ptp_settime64,
+	.adjtime	= zl3073x_dpll_ptp_adjtime,
+	.adjfine	= zl3073x_dpll_ptp_adjfine,
+	.adjphase	= zl3073x_dpll_ptp_adjphase,
+	.getmaxphase	= zl3073x_dpll_ptp_getmaxphase,
+	.enable		= zl3073x_dpll_ptp_enable,
+};
+
+/**
+ * zl3073x_dpll_ptp_register - register PTP clock for a DPLL channel
+ * @zldpll: DPLL channel to register PTP clock for
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int zl3073x_dpll_ptp_register(struct zl3073x_dpll *zldpll)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct ptp_clock *ptp_clock;
+
+	snprintf(zldpll->ptp_info.name, sizeof(zldpll->ptp_info.name),
+		 "zl3073x-dpll%u", zldpll->id);
+
+	ptp_clock = ptp_clock_register(&zldpll->ptp_info, zldev->dev);
+	if (IS_ERR(ptp_clock)) {
+		dev_err(zldev->dev, "Failed to register PTP clock for DPLL%u\n",
+			zldpll->id);
+		return PTR_ERR(ptp_clock);
+	}
+
+	zldpll->ptp_clock = ptp_clock;
+
+	return 0;
+}
+
+/**
+ * zl3073x_dpll_ptp_unregister - unregister PTP clock for a DPLL channel
+ * @zldpll: DPLL channel to unregister PTP clock for
+ */
+static void zl3073x_dpll_ptp_unregister(struct zl3073x_dpll *zldpll)
+{
+	if (!IS_ERR_OR_NULL(zldpll->ptp_clock)) {
+		ptp_clock_unregister(zldpll->ptp_clock);
+		zldpll->ptp_clock = NULL;
+	}
 }
 
 /**
@@ -2403,6 +2863,48 @@ zl3073x_dpll_ref_sync_pairs_register(struct zl3073x_dpll *zldpll)
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_alloc - allocate DPLL device
+ * @zldev: pointer to zl3073x device
+ * @ch: DPLL channel number
+ *
+ * Allocates DPLL device structure for given DPLL channel.
+ *
+ * Return: pointer to DPLL device on success, error pointer on error
+ */
+struct zl3073x_dpll *
+zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
+{
+	struct zl3073x_dpll *zldpll;
+
+	zldpll = kzalloc_obj(*zldpll);
+	if (!zldpll)
+		return ERR_PTR(-ENOMEM);
+
+	zldpll->dev = zldev;
+	zldpll->id = ch;
+	zldpll->ptp_info = zl3073x_dpll_ptp_clock_info;
+	mutex_init(&zldpll->lock);
+	INIT_LIST_HEAD(&zldpll->pins);
+
+	return zldpll;
+}
+
+/**
+ * zl3073x_dpll_free - free DPLL device
+ * @zldpll: pointer to zl3073x_dpll structure
+ *
+ * Deallocates given DPLL device previously allocated by @zl3073x_dpll_alloc.
+ */
+void
+zl3073x_dpll_free(struct zl3073x_dpll *zldpll)
+{
+	WARN(zldpll->dpll_dev, "DPLL device is still registered\n");
+
+	mutex_destroy(&zldpll->lock);
+	kfree(zldpll);
+}
+
 /**
  * zl3073x_dpll_register - register DPLL device and all its pins
  * @zldpll: pointer to zl3073x_dpll structure
@@ -2433,6 +2935,13 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 		return rc;
 	}
 
+	rc = zl3073x_dpll_ptp_register(zldpll);
+	if (rc) {
+		zl3073x_dpll_pins_unregister(zldpll);
+		zl3073x_dpll_device_unregister(zldpll);
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -2446,7 +2955,7 @@ zl3073x_dpll_register(struct zl3073x_dpll *zldpll)
 void
 zl3073x_dpll_unregister(struct zl3073x_dpll *zldpll)
 {
-	/* Unregister all pins and dpll */
+	zl3073x_dpll_ptp_unregister(zldpll);
 	zl3073x_dpll_pins_unregister(zldpll);
 	zl3073x_dpll_device_unregister(zldpll);
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index faebc402ba1b7..9b5f72c33849c 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -5,6 +5,8 @@
 
 #include <linux/dpll.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/ptp_clock_kernel.h>
 
 #include "core.h"
 
@@ -22,6 +24,8 @@
  * @type: DPLL type (PPS or EEC)
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
+ * @ptp_info: PTP clock info
+ * @ptp_clock: registered PTP clock (or NULL)
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -36,6 +40,8 @@ struct zl3073x_dpll {
 	enum dpll_type			type;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
+	struct ptp_clock_info		ptp_info;
+	struct ptp_clock		*ptp_clock;
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
-- 
2.53.0


