Return-Path: <netdev+bounces-197169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64CAD7BA7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF28F3B67F6
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F6A2D663A;
	Thu, 12 Jun 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOLaYpVv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026652DCBF5
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758568; cv=none; b=cU5mFeZCU41ElY+EY8VlP3oqOljMMXHHJuHOwDmq3MFpI1x0rzIiMae9tWjyFQ4VceTcZNbt9SN39bI87lj3esGnQQZn7yEkhNnfbn/mMULFGzeBt50aZf1flIZ/KPqK9ZdJtZKeqOL4Vb7ec+Fd4hxcEDzxV3WifxsQHPPLS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758568; c=relaxed/simple;
	bh=XxAYYB96YxOn4/BL8P/jndOi4rC87RotCV/rMQ6NLrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQvmCI6ckgpsU0wWP0yHgfqSEGG5FqGIexbSI687svCrYJcCUAFFHMPYgBVUZvbuTQjlQo8tjyZQl9UKVHlwTu+2lDtlTHIJxnrEfu/K6squFl/aEOmIIsv6RsNcR6GObqAaGxrUVNt968Enfd9aQLqgiUT99d8hP/Tee4p6Xsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOLaYpVv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749758564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TfDFMf77Ygw4t6fZv6Hnu7GiVei+ASCWU5RmygMPXkU=;
	b=WOLaYpVvbDhFcEgDEUbiMUiy1ojO6UgAK2HFgWN9peD6Syvv1e5evAvxeoJYSRMMijZWX2
	uoBF/PZs4m67NynX8wPFdvpNqLrd3THCWdg9rEBN8H4QvDn2/f03hmEyB9z+eeCDAOjuYD
	9S/oVvFo1Zq1kN7fxUpZzsfaKii+SS0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-JMNCMQGiMn-V_-mkSx0sdg-1; Thu,
 12 Jun 2025 16:02:41 -0400
X-MC-Unique: JMNCMQGiMn-V_-mkSx0sdg-1
X-Mimecast-MFC-AGG-ID: JMNCMQGiMn-V_-mkSx0sdg_1749758559
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F444180AE07;
	Thu, 12 Jun 2025 20:02:39 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5C2A1800284;
	Thu, 12 Jun 2025 20:02:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v9 06/14] dpll: zl3073x: Fetch invariants during probe
Date: Thu, 12 Jun 2025 22:01:37 +0200
Message-ID: <20250612200145.774195-7-ivecera@redhat.com>
In-Reply-To: <20250612200145.774195-1-ivecera@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Several configuration parameters will remain constant at runtime,
so we can load them during probe to avoid excessive reads from
the hardware.

Read the following parameters from the device during probe and store
them for later use:

* enablement status and frequencies of the synthesizers and their
  associated DPLL channels
* enablement status and type (single-ended or differential) of input pins
* associated synthesizers, signal format, and enablement status of
  outputs

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 248 +++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/core.h | 286 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  65 ++++++++
 3 files changed, 599 insertions(+)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 60344761545d8..3a57c85f902c4 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -6,6 +6,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
 #include <linux/regmap.h>
@@ -376,6 +377,25 @@ int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
 					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
 }
 
+int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
+		  unsigned int mask_reg, u16 mask_val)
+{
+	int rc;
+
+	/* Set mask for the operation */
+	rc = zl3073x_write_u16(zldev, mask_reg, mask_val);
+	if (rc)
+		return rc;
+
+	/* Trigger the operation */
+	rc = zl3073x_write_u8(zldev, op_reg, op_val);
+	if (rc)
+		return rc;
+
+	/* Wait for the operation to actually finish */
+	return zl3073x_poll_zero_u8(zldev, op_reg, op_val);
+}
+
 /**
  * zl3073x_devlink_info_get - Devlink device info callback
  * @devlink: devlink structure pointer
@@ -484,6 +504,229 @@ struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_devm_alloc, "ZL3073X");
 
+/**
+ * zl3073x_ref_state_fetch - get input reference state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: input reference index to fetch state for
+ *
+ * Function fetches information for the given input reference that are
+ * invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_ref *input = &zldev->ref[index];
+	u8 ref_config;
+	int rc;
+
+	/* If the input is differential then the configuration for N-pin
+	 * reference is ignored and P-pin config is used for both.
+	 */
+	if (zl3073x_is_n_pin(index) &&
+	    zl3073x_ref_is_diff(zldev, index - 1)) {
+		input->enabled = zl3073x_ref_is_enabled(zldev, index - 1);
+		input->diff = true;
+
+		return 0;
+	}
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Read ref_config register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_REF_CONFIG, &ref_config);
+	if (rc)
+		return rc;
+
+	input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref_config);
+	input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref_config);
+
+	dev_dbg(zldev->dev, "REF%u is %s and configured as %s\n", index,
+		input->enabled ? "enabled" : "disabled",
+		input->diff ? "differential" : "single-ended");
+
+	return rc;
+}
+
+/**
+ * zl3073x_out_state_fetch - get output state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: output index to fetch state for
+ *
+ * Function fetches information for the given output (not output pin)
+ * that are invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_out_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_out *out = &zldev->out[index];
+	u8 output_ctrl, output_mode;
+	int rc;
+
+	/* Read output configuration */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
+	if (rc)
+		return rc;
+
+	/* Store info about output enablement and synthesizer the output
+	 * is connected to.
+	 */
+	out->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
+	out->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
+
+	dev_dbg(zldev->dev, "OUT%u is %s and connected to SYNTH%u\n", index,
+		out->enabled ? "enabled" : "disabled", out->synth);
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Read output_mode */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_MODE, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Extract and store output signal format */
+	out->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
+				       output_mode);
+
+	dev_dbg(zldev->dev, "OUT%u has signal format 0x%02x\n", index,
+		out->signal_format);
+
+	return rc;
+}
+
+/**
+ * zl3073x_synth_state_fetch - get synth state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: synth index to fetch state for
+ *
+ * Function fetches information for the given synthesizer that are
+ * invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_synth_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_synth *synth = &zldev->synth[index];
+	u16 base, m, n;
+	u8 synth_ctrl;
+	u32 mult;
+	int rc;
+
+	/* Read synth control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
+	if (rc)
+		return rc;
+
+	/* Store info about synth enablement and DPLL channel the synth is
+	 * driven by.
+	 */
+	synth->enabled = FIELD_GET(ZL_SYNTH_CTRL_EN, synth_ctrl);
+	synth->dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL, synth_ctrl);
+
+	dev_dbg(zldev->dev, "SYNTH%u is %s and driven by DPLL%u\n", index,
+		synth->enabled ? "enabled" : "disabled", synth->dpll);
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read synth configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_RD,
+			   ZL_REG_SYNTH_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	/* The output frequency is determined by the following formula:
+	 * base * multiplier * numerator / denominator
+	 *
+	 * Read registers with these values
+	 */
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_BASE, &base);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u32(zldev, ZL_REG_SYNTH_FREQ_MULT, &mult);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &m);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &n);
+	if (rc)
+		return rc;
+
+	/* Check denominator for zero to avoid div by 0 */
+	if (!n) {
+		dev_err(zldev->dev,
+			"Zero divisor for SYNTH%u retrieved from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	/* Compute and store synth frequency */
+	zldev->synth[index].freq = div_u64(mul_u32_u32(base * m, mult), n);
+
+	dev_dbg(zldev->dev, "SYNTH%u frequency: %u Hz\n", index,
+		zldev->synth[index].freq);
+
+	return rc;
+}
+
+static int
+zl3073x_dev_state_fetch(struct zl3073x_dev *zldev)
+{
+	int rc;
+	u8 i;
+
+	for (i = 0; i < ZL3073X_NUM_REFS; i++) {
+		rc = zl3073x_ref_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch input state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < ZL3073X_NUM_SYNTHS; i++) {
+		rc = zl3073x_synth_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch synth state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	for (i = 0; i < ZL3073X_NUM_OUTS; i++) {
+		rc = zl3073x_out_state_fetch(zldev, i);
+		if (rc) {
+			dev_err(zldev->dev,
+				"Failed to fetch output state: %pe\n",
+				ERR_PTR(rc));
+			return rc;
+		}
+	}
+
+	return rc;
+}
+
 static void zl3073x_devlink_unregister(void *ptr)
 {
 	devlink_unregister(ptr);
@@ -551,6 +794,11 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		return dev_err_probe(zldev->dev, rc,
 				     "Failed to initialize mutex\n");
 
+	/* Fetch device state */
+	rc = zl3073x_dev_state_fetch(zldev);
+	if (rc)
+		return rc;
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 1a77a69f85a26..0d052c02065e5 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -6,19 +6,70 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
+#include "regs.h"
+
 struct device;
 struct regmap;
 
+/*
+ * Hardware limits for ZL3073x chip family
+ */
+#define ZL3073X_NUM_REFS	10
+#define ZL3073X_NUM_OUTS	10
+#define ZL3073X_NUM_SYNTHS	5
+
+/**
+ * struct zl3073x_ref - input reference invariant info
+ * @enabled: input reference is enabled or disabled
+ * @diff: true if input reference is differential
+ */
+struct zl3073x_ref {
+	bool	enabled;
+	bool	diff;
+};
+
+/**
+ * struct zl3073x_out - output invariant info
+ * @enabled: out is enabled or disabled
+ * @synth: synthesizer the out is connected to
+ * @signal_format: out signal format
+ */
+struct zl3073x_out {
+	bool	enabled;
+	u8	synth;
+	u8	signal_format;
+};
+
+/**
+ * struct zl3073x_synth - synthesizer invariant info
+ * @freq: synthesizer frequency
+ * @dpll: ID of DPLL the synthesizer is driven by
+ * @enabled: synth is enabled or disabled
+ */
+struct zl3073x_synth {
+	u32	freq;
+	u8	dpll;
+	bool	enabled;
+};
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
+ * @ref: array of input references' invariants
+ * @out: array of outs' invariants
+ * @synth: array of synths' invariants
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
+
+	/* Invariants */
+	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
+	struct zl3073x_out	out[ZL3073X_NUM_OUTS];
+	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
 };
 
 enum zl3073x_chip_type {
@@ -46,6 +97,8 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
  * Registers operations
  **********************/
 
+int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
+		  unsigned int mask_reg, u16 mask_val);
 int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
 int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val);
 int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val);
@@ -56,4 +109,237 @@ int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val);
 int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val);
 int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
 
+static inline bool
+zl3073x_is_n_pin(u8 id)
+{
+	/* P-pins ids are even while N-pins are odd */
+	return id & 1;
+}
+
+static inline bool
+zl3073x_is_p_pin(u8 id)
+{
+	return !zl3073x_is_n_pin(id);
+}
+
+/**
+ * zl3073x_input_pin_ref_get - get reference for given input pin
+ * @id: input pin id
+ *
+ * Return: reference id for the given input pin
+ */
+static inline u8
+zl3073x_input_pin_ref_get(u8 id)
+{
+	return id;
+}
+
+/**
+ * zl3073x_output_pin_out_get - get output for the given output pin
+ * @id: output pin id
+ *
+ * Return: output id for the given output pin
+ */
+static inline u8
+zl3073x_output_pin_out_get(u8 id)
+{
+	/* Output pin pair shares the single output */
+	return id / 2;
+}
+
+/**
+ * zl3073x_ref_is_diff - check if the given input reference is differential
+ * @zldev: pointer to zl3073x device
+ * @index: input reference index
+ *
+ * Return: true if reference is differential, false if reference is single-ended
+ */
+static inline bool
+zl3073x_ref_is_diff(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->ref[index].diff;
+}
+
+/**
+ * zl3073x_ref_is_enabled - check if the given input reference is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: input reference index
+ *
+ * Return: true if input refernce is enabled, false otherwise
+ */
+static inline bool
+zl3073x_ref_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->ref[index].enabled;
+}
+
+/**
+ * zl3073x_synth_dpll_get - get DPLL ID the synth is driven by
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: ID of DPLL the given synthetizer is driven by
+ */
+static inline u8
+zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].dpll;
+}
+
+/**
+ * zl3073x_synth_freq_get - get synth current freq
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: frequency of given synthetizer
+ */
+static inline u32
+zl3073x_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].freq;
+}
+
+/**
+ * zl3073x_synth_is_enabled - check if the given synth is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: true if synth is enabled, false otherwise
+ */
+static inline bool
+zl3073x_synth_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].enabled;
+}
+
+/**
+ * zl3073x_out_synth_get - get synth connected to given output
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: index of synth connected to given output.
+ */
+static inline u8
+zl3073x_out_synth_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->out[index].synth;
+}
+
+/**
+ * zl3073x_out_is_enabled - check if the given output is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if the output is enabled, false otherwise
+ */
+static inline bool
+zl3073x_out_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	u8 synth;
+
+	/* Output is enabled only if associated synth is enabled */
+	synth = zl3073x_out_synth_get(zldev, index);
+	if (zl3073x_synth_is_enabled(zldev, synth))
+		return zldev->out[index].enabled;
+
+	return false;
+}
+
+/**
+ * zl3073x_out_signal_format_get - get output signal format
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: signal format of given output
+ */
+static inline u8
+zl3073x_out_signal_format_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->out[index].signal_format;
+}
+
+/**
+ * zl3073x_out_dpll_get - get DPLL ID the output is driven by
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: ID of DPLL the given output is driven by
+ */
+static inline
+u8 zl3073x_out_dpll_get(struct zl3073x_dev *zldev, u8 index)
+{
+	u8 synth;
+
+	/* Get synthesizer connected to given output */
+	synth = zl3073x_out_synth_get(zldev, index);
+
+	/* Return DPLL that drives the synth */
+	return zl3073x_synth_dpll_get(zldev, synth);
+}
+
+/**
+ * zl3073x_out_is_diff - check if the given output is differential
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if output is differential, false if output is single-ended
+ */
+static inline bool
+zl3073x_out_is_diff(struct zl3073x_dev *zldev, u8 index)
+{
+	switch (zl3073x_out_signal_format_get(zldev, index)) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_LVDS:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_DIFF:
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_LOWVCM:
+		return true;
+	default:
+		break;
+	}
+
+	return false;
+}
+
+/**
+ * zl3073x_output_pin_is_enabled - check if the given output pin is enabled
+ * @zldev: pointer to zl3073x device
+ * @id: output pin id
+ *
+ * Checks if the output of the given output pin is enabled and also that
+ * its signal format also enables the given pin.
+ *
+ * Return: true if output pin is enabled, false if output pin is disabled
+ */
+static inline bool
+zl3073x_output_pin_is_enabled(struct zl3073x_dev *zldev, u8 id)
+{
+	u8 output = zl3073x_output_pin_out_get(id);
+
+	/* Check if the whole output is enabled */
+	if (!zl3073x_out_is_enabled(zldev, output))
+		return false;
+
+	/* Check signal format */
+	switch (zl3073x_out_signal_format_get(zldev, output)) {
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_DISABLED:
+		/* Both output pins are disabled by signal format */
+		return false;
+
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_1P:
+		/* Output is one single ended P-pin output */
+		if (zl3073x_is_n_pin(id))
+			return false;
+		break;
+	case ZL_OUTPUT_MODE_SIGNAL_FORMAT_1N:
+		/* Output is one single ended N-pin output */
+		if (zl3073x_is_p_pin(id))
+			return false;
+		break;
+	default:
+		/* For other format both pins are enabled */
+		break;
+	}
+
+	return true;
+}
+
 #endif /* _ZL3073X_H */
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 08bf595935ea1..753b42d8b2093 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -72,4 +72,69 @@
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
 #define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
 
+/***********************************
+ * Register Page 9, Synth and Output
+ ***********************************/
+
+#define ZL_REG_SYNTH_CTRL(_idx)						\
+	ZL_REG_IDX(_idx, 9, 0x00, 1, ZL3073X_NUM_SYNTHS, 1)
+#define ZL_SYNTH_CTRL_EN			BIT(0)
+#define ZL_SYNTH_CTRL_DPLL_SEL			GENMASK(6, 4)
+
+#define ZL_REG_OUTPUT_CTRL(_idx)					\
+	ZL_REG_IDX(_idx, 9, 0x28, 1, ZL3073X_NUM_OUTS, 1)
+#define ZL_OUTPUT_CTRL_EN			BIT(0)
+#define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
+
+/*******************************
+ * Register Page 10, Ref Mailbox
+ *******************************/
+
+#define ZL_REG_REF_MB_MASK			ZL_REG(10, 0x02, 2)
+
+#define ZL_REG_REF_MB_SEM			ZL_REG(10, 0x04, 1)
+#define ZL_REF_MB_SEM_WR			BIT(0)
+#define ZL_REF_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_REF_CONFIG			ZL_REG(10, 0x0d, 1)
+#define ZL_REF_CONFIG_ENABLE			BIT(0)
+#define ZL_REF_CONFIG_DIFF_EN			BIT(2)
+
+/*********************************
+ * Register Page 13, Synth Mailbox
+ *********************************/
+
+#define ZL_REG_SYNTH_MB_MASK			ZL_REG(13, 0x02, 2)
+
+#define ZL_REG_SYNTH_MB_SEM			ZL_REG(13, 0x04, 1)
+#define ZL_SYNTH_MB_SEM_WR			BIT(0)
+#define ZL_SYNTH_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_SYNTH_FREQ_BASE			ZL_REG(13, 0x06, 2)
+#define ZL_REG_SYNTH_FREQ_MULT			ZL_REG(13, 0x08, 4)
+#define ZL_REG_SYNTH_FREQ_M			ZL_REG(13, 0x0c, 2)
+#define ZL_REG_SYNTH_FREQ_N			ZL_REG(13, 0x0e, 2)
+
+/**********************************
+ * Register Page 14, Output Mailbox
+ **********************************/
+#define ZL_REG_OUTPUT_MB_MASK			ZL_REG(14, 0x02, 2)
+
+#define ZL_REG_OUTPUT_MB_SEM			ZL_REG(14, 0x04, 1)
+#define ZL_OUTPUT_MB_SEM_WR			BIT(0)
+#define ZL_OUTPUT_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_OUTPUT_MODE			ZL_REG(14, 0x05, 1)
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT		GENMASK(7, 4)
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_DISABLED	0
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_LVDS	1
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_DIFF	2
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_LOWVCM	3
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2		4
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_1P		5
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_1N		6
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_INV	7
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV	12
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT_2_NDIV_INV	15
+
 #endif /* _ZL3073X_REGS_H */
-- 
2.49.0


