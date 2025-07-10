Return-Path: <netdev+bounces-205859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803B3B00776
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB504487049
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF0F27B4EE;
	Thu, 10 Jul 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AF2pMhzU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1CF275B18
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161977; cv=none; b=awBQdt79PcpmgBnwLjiiiSK/QkW/0v1PAQEVt9p88pMTPjcxKiWTBgzw3VF+sTnY6wlVOzIY2fmRny6XANke6SGJyalH8Bs7B6v6V+LBNwuT//q59PCVZZfE/weCOh8iXWDoX7wfMCQxe2wGlBd5piqagcI65lrJdnhs07uccrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161977; c=relaxed/simple;
	bh=OpL2FDt9RCQRjb5xtdvRP249v/kqaDhGqSWlRUDnUJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=na/uPnL7Qe5DtfK9tXt+PQqQC/WH37wGyq7p+FN6b5Q2Z3IgAyNXbwYFuxvDHD+/XfN9mltiskSmCZ+rv7jPBekPi5VYl/SaWmNX+vCcoBPjkcYl5wFn+q39f0ybopiQXGk46izfQB5PllJ464pllAR1brF0JaOVUijAojM5Pv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AF2pMhzU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752161974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw0GvPhTqoaGSG8Ri24kcD2QAy/l1QmTinEC6MhnSoM=;
	b=AF2pMhzUdUZfuyYANm0PEHIlMLQ7VvM4VWhgq0CFe5uMr78YPV1kf+eaD/EebjC/TaAr9v
	jkxPNgw+RMrvXAZ9FXd/5g2KoZLZ8NzLNIUJX1xOb8Qr00H202+MYSgH3QTRXPP3823OeD
	5y67VBHbxnVHF+K+cniJ2M4P0/WPbr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-Qg4uvgukNdyQun6pGf3JJQ-1; Thu,
 10 Jul 2025 11:39:15 -0400
X-MC-Unique: Qg4uvgukNdyQun6pGf3JJQ-1
X-Mimecast-MFC-AGG-ID: Qg4uvgukNdyQun6pGf3JJQ_1752161953
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6C941956095;
	Thu, 10 Jul 2025 15:39:13 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7133C1956094;
	Thu, 10 Jul 2025 15:39:10 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 5/5] dpll: zl3073x: Add support to get fractional frequency offset
Date: Thu, 10 Jul 2025 17:38:48 +0200
Message-ID: <20250710153848.928531-6-ivecera@redhat.com>
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Adds support to get fractional frequency offset for input pins. Implement
the appropriate callback and function that periodicaly performs reference
frequency measurement and notifies DPLL core about changes.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 67 +++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.h | 15 ++++++++
 drivers/dpll/zl3073x/dpll.c | 69 +++++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/regs.h | 19 ++++++++++
 4 files changed, 168 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index eb62a492b1727..7ebcfc5ec1f09 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -720,6 +720,66 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel)
 				    ZL_REF_PHASE_ERR_READ_RQST_RD);
 }
 
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
+	/* Per datasheet we have to wait for 'ref_freq_meas_ctrl' to be zero
+	 * to ensure that the measured data are coherent.
+	 */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
+				  ZL_REF_FREQ_MEAS_CTRL);
+	if (rc)
+		return rc;
+
+	/* Select all references for measurement */
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_FREQ_MEAS_MASK_3_0,
+			      GENMASK(7, 0)); /* REF0P..REF3N */
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_FREQ_MEAS_MASK_4,
+			      GENMASK(1, 0)); /* REF4P..REF4N */
+	if (rc)
+		return rc;
+
+	/* Request frequency offset measurement */
+	rc = zl3073x_write_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
+			      ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF);
+	if (rc)
+		return rc;
+
+	/* Wait for finish */
+	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_REF_FREQ_MEAS_CTRL,
+				  ZL_REF_FREQ_MEAS_CTRL);
+	if (rc)
+		return rc;
+
+	/* Read DPLL-to-REFx frequency offset measurements */
+	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
+		s32 value;
+
+		/* Read value stored in units of 2^-32 signed */
+		rc = zl3073x_read_u32(zldev, ZL_REG_REF_FREQ(i), &value);
+		if (rc)
+			return rc;
+
+		/* Convert to ppm -> ffo = (10^6 * value) / 2^32 */
+		zldev->ref[i].ffo = mul_s64_u64_shr(value, 1000000, 32);
+	}
+
+	return 0;
+}
+
 static void
 zl3073x_dev_periodic_work(struct kthread_work *work)
 {
@@ -734,6 +794,13 @@ zl3073x_dev_periodic_work(struct kthread_work *work)
 		dev_warn(zldev->dev, "Failed to update phase offsets: %pe\n",
 			 ERR_PTR(rc));
 
+	/* Update references' fractional frequency offsets */
+	rc = zl3073x_ref_ffo_update(zldev);
+	if (rc)
+		dev_warn(zldev->dev,
+			 "Failed to update fractional frequency offsets: %pe\n",
+			 ERR_PTR(rc));
+
 	list_for_each_entry(zldpll, &zldev->dplls, list)
 		zl3073x_dpll_changes_check(zldpll);
 
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 1a5edc4975735..71af2c8001109 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -30,10 +30,12 @@ struct zl3073x_dpll;
  * struct zl3073x_ref - input reference invariant info
  * @enabled: input reference is enabled or disabled
  * @diff: true if input reference is differential
+ * @ffo: current fractional frequency offset
  */
 struct zl3073x_ref {
 	bool	enabled;
 	bool	diff;
+	s64	ffo;
 };
 
 /**
@@ -170,6 +172,19 @@ zl3073x_output_pin_out_get(u8 id)
 	return id / 2;
 }
 
+/**
+ * zl3073x_ref_ffo_get - get current fractional frequency offset
+ * @zldev: pointer to zl3073x device
+ * @index: input reference index
+ *
+ * Return: the latest measured fractional frequency offset
+ */
+static inline s64
+zl3073x_ref_ffo_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->ref[index].ffo;
+}
+
 /**
  * zl3073x_ref_is_diff - check if the given input reference is differential
  * @zldev: pointer to zl3073x device
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 4e05120c30b9a..b061a75aad1a7 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -37,6 +37,7 @@
  * @esync_control: embedded sync is controllable
  * @pin_state: last saved pin state
  * @phase_offset: last saved pin phase offset
+ * @freq_offset: last saved fractional frequency offset
  */
 struct zl3073x_dpll_pin {
 	struct list_head	list;
@@ -50,6 +51,7 @@ struct zl3073x_dpll_pin {
 	bool			esync_control;
 	enum dpll_pin_state	pin_state;
 	s64			phase_offset;
+	s64			freq_offset;
 };
 
 /*
@@ -270,6 +272,18 @@ zl3073x_dpll_input_pin_esync_set(const struct dpll_pin *dpll_pin,
 			     ZL_REG_REF_MB_MASK, BIT(ref));
 }
 
+static int
+zl3073x_dpll_input_pin_ffo_get(const struct dpll_pin *dpll_pin, void *pin_priv,
+			       const struct dpll_device *dpll, void *dpll_priv,
+			       s64 *ffo, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	*ffo = pin->freq_offset;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
 				     void *pin_priv,
@@ -1582,6 +1596,7 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
 	.esync_get = zl3073x_dpll_input_pin_esync_get,
 	.esync_set = zl3073x_dpll_input_pin_esync_set,
+	.ffo_get = zl3073x_dpll_input_pin_ffo_get,
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
@@ -2037,6 +2052,52 @@ zl3073x_dpll_pin_phase_offset_check(struct zl3073x_dpll_pin *pin)
 	return false;
 }
 
+/**
+ * zl3073x_dpll_pin_ffo_check - check for pin fractional frequency offset change
+ * @pin: pin to check
+ *
+ * Check for the given pin's fractional frequency change.
+ *
+ * Return: true on fractional frequency offset change, false otherwise
+ */
+static bool
+zl3073x_dpll_pin_ffo_check(struct zl3073x_dpll_pin *pin)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 ref, status;
+	s64 ffo;
+	int rc;
+
+	/* Get reference monitor status */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_MON_STATUS(ref), &status);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to read %s refmon status: %pe\n",
+			pin->label, ERR_PTR(rc));
+
+		return false;
+	}
+
+	/* Do not report ffo changes if the reference monitor report errors */
+	if (status != ZL_REF_MON_STATUS_OK)
+		return false;
+
+	/* Get the latest measured ref's ffo */
+	ffo = zl3073x_ref_ffo_get(zldev, ref);
+
+	/* Compare with previous value */
+	if (pin->freq_offset != ffo) {
+		dev_dbg(zldev->dev, "%s freq offset changed: %lld -> %lld\n",
+			pin->label, pin->freq_offset, ffo);
+		pin->freq_offset = ffo;
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
@@ -2117,11 +2178,15 @@ zl3073x_dpll_changes_check(struct zl3073x_dpll *zldpll)
 			pin_changed = true;
 		}
 
-		/* Check for phase offset change once per second */
-		if (zldpll->check_count % 2 == 0)
+		/* Check for phase offset and ffo change once per second */
+		if (zldpll->check_count % 2 == 0) {
 			if (zl3073x_dpll_pin_phase_offset_check(pin))
 				pin_changed = true;
 
+			if (zl3073x_dpll_pin_ffo_check(pin))
+				pin_changed = true;
+		}
+
 		if (pin_changed)
 			dpll_pin_change_ntf(pin->dpll_pin);
 	}
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index a382cd4a109f5..614e33128a5c9 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -94,6 +94,9 @@
 #define ZL_DPLL_REFSEL_STATUS_STATE		GENMASK(6, 4)
 #define ZL_DPLL_REFSEL_STATUS_STATE_LOCK	4
 
+#define ZL_REG_REF_FREQ(_idx)						\
+	ZL_REG_IDX(_idx, 2, 0x44, 4, ZL3073X_NUM_REFS, 4)
+
 /**********************
  * Register Page 4, Ref
  **********************/
@@ -101,6 +104,22 @@
 #define ZL_REG_REF_PHASE_ERR_READ_RQST		ZL_REG(4, 0x0f, 1)
 #define ZL_REF_PHASE_ERR_READ_RQST_RD		BIT(0)
 
+#define ZL_REG_REF_FREQ_MEAS_CTRL		ZL_REG(4, 0x1c, 1)
+#define ZL_REF_FREQ_MEAS_CTRL			GENMASK(1, 0)
+#define ZL_REF_FREQ_MEAS_CTRL_REF_FREQ		1
+#define ZL_REF_FREQ_MEAS_CTRL_REF_FREQ_OFF	2
+#define ZL_REF_FREQ_MEAS_CTRL_DPLL_FREQ_OFF	3
+
+#define ZL_REG_REF_FREQ_MEAS_MASK_3_0		ZL_REG(4, 0x1d, 1)
+#define ZL_REF_FREQ_MEAS_MASK_3_0(_ref)		BIT(_ref)
+
+#define ZL_REG_REF_FREQ_MEAS_MASK_4		ZL_REG(4, 0x1e, 1)
+#define ZL_REF_FREQ_MEAS_MASK_4(_ref)		BIT((_ref) - 8)
+
+#define ZL_REG_DPLL_MEAS_REF_FREQ_CTRL		ZL_REG(4, 0x1f, 1)
+#define ZL_DPLL_MEAS_REF_FREQ_CTRL_EN		BIT(0)
+#define ZL_DPLL_MEAS_REF_FREQ_CTRL_IDX		GENMASK(6, 4)
+
 #define ZL_REG_REF_PHASE(_idx)						\
 	ZL_REG_IDX(_idx, 4, 0x20, 6, ZL3073X_NUM_REFS, 6)
 
-- 
2.49.0


