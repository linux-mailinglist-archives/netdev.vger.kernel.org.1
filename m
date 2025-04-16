Return-Path: <netdev+bounces-183388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F67A908BA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118375A0C06
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECB2217736;
	Wed, 16 Apr 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIKJboab"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54D21129D
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820559; cv=none; b=F4Ok59td+Lk9mNoZBsGfb3jhMsu2BuP6KUTm4UL59+jrKa994BC9h2fhLYUimULJkgZfhkV6NwcJ9tqZoGr9Y3wc1IJSM1Yi1+v61D0AKMbZwfEXY5oYbQ03bejRaIa+tlBvja9gTqYREM+ZpEzAVI4Nma1zNYL8ukB4exUq62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820559; c=relaxed/simple;
	bh=2xHx+yz3yF8J2zXfHdbMO51YcjlDcHVhF/eIBh1KogU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIvzal4g3iXgYIXbo8yJdUz5GTqI8UdcU8asn+k59jouos52NwF8jDCzVAWmGIA1/daTi784liaV/k9JobvugFvcMsxDtg462Z6Rd9khrOE/uIqJnX4QCBU9+UA3dld3nhNYX2wcUTIJepqvCDU6LinWW78Fj8LpCwnM6f0nE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIKJboab; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V0aQVfkk9JI5FdD9Vn4JrLbdLxth97WWpb7cgDFoJ9w=;
	b=YIKJboabgzvr10E14aICJUd1SIHBT5+4JMWKsCecbLpDFLYXsAEhAsKQ8+EYCXN8m9B3tY
	1lYjqj5/vMF33Hbon8BgHX31iUw/7ngbM2h/H4kvMHFAg79rxbnLxIUvHn+WqbL78VSieK
	dk4Bjdnf02iplBu5cV74wzZwPoVDbD0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-MTJgngZWP1Ghd5-pcDVCpA-1; Wed,
 16 Apr 2025 12:22:30 -0400
X-MC-Unique: MTJgngZWP1Ghd5-pcDVCpA-1
X-Mimecast-MFC-AGG-ID: MTJgngZWP1Ghd5-pcDVCpA_1744820548
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DFB619560A0;
	Wed, 16 Apr 2025 16:22:28 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE9481800352;
	Wed, 16 Apr 2025 16:22:23 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 net-next 7/8] mfd: zl3073x: Fetch invariants during probe
Date: Wed, 16 Apr 2025 18:21:43 +0200
Message-ID: <20250416162144.670760-8-ivecera@redhat.com>
In-Reply-To: <20250416162144.670760-1-ivecera@redhat.com>
References: <20250416162144.670760-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Several configuration parameters will not be changed in runtime so we
can load them during probe to avoid excessive reads from the hardware.

These parameters will be frequently read by the DPLL driver from this
series and later by PHC/PTP sub-device driver.

Read the following parameters from the device during probe and store
them for later use:

* synthesizers' frequencies and driving DPLL channel
* input pins' enablement and type (single-ended or differential)
* outputs'associated synths, signal format and enablement

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v2->v3:
* dropped usage of macros for generating helper functions
v1->v2:
* fixed and added inline documentation
---
 drivers/mfd/zl3073x-core.c       | 237 +++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h      | 161 +++++++++++++++++++++
 include/linux/mfd/zl3073x_regs.h | 184 ++++++++++++++++++++++++
 3 files changed, 582 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 5a0e2bb1a969f..0bd31591245a2 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -5,6 +5,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/mfd/zl3073x_regs.h>
 #include <linux/module.h>
@@ -481,6 +482,237 @@ static void zl3073x_devlink_unregister(void *ptr)
 	devlink_unregister(ptr);
 }
 
+/**
+ * zl3073x_input_state_fetch - get input state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: input pin index to fetch state for
+ *
+ * Function fetches information for the given input reference that are
+ * invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_input_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_input *input;
+	u8 ref_config;
+	int rc;
+
+	if (index >= ZL3073X_NUM_INPUTS)
+		return -EINVAL;
+
+	input = &zldev->input[index];
+
+	/* If the input is differential then the configuration for N-pin
+	 * reference is ignored and P-pin config is used for both.
+	 */
+	if (zl3073x_is_n_pin(index) &&
+	    zl3073x_input_is_diff(zldev, index - 1)) {
+		input->enabled = zl3073x_input_is_enabled(zldev, index - 1);
+		input->diff = true;
+
+		return 0;
+	}
+
+	guard(zl3073x_mailbox)(zldev);
+
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_ref_read(zldev, index);
+	if (rc)
+		return rc;
+
+	/* Read reference config register */
+	rc = zl3073x_mb_read_ref_config(zldev, &ref_config);
+	if (rc)
+		return rc;
+
+	/* Store info about input reference enablement and if it is
+	 * configured in differential mode or not.
+	 */
+	input->enabled = FIELD_GET(ZL_REF_CONFIG_ENABLE, ref_config);
+	input->diff = FIELD_GET(ZL_REF_CONFIG_DIFF_EN, ref_config);
+
+	dev_dbg(zldev->dev, "INPUT%u is %sabled and configured as %s\n", index,
+		input->enabled ? "en" : "dis",
+		input->diff ? "differential" : "single-ended");
+
+	return rc;
+}
+
+/**
+ * zl3073x_output_state_fetch - get output state
+ * @zldev: pointer to zl3073x_dev structure
+ * @index: output index to fetch state for
+ *
+ * Function fetches information for the given output (not output pin)
+ * that are invariant and stores them for later use.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_output_state_fetch(struct zl3073x_dev *zldev, u8 index)
+{
+	struct zl3073x_output *output;
+	u8 output_ctrl, output_mode;
+	int rc;
+
+	if (index >= ZL3073X_NUM_OUTPUTS)
+		return -EINVAL;
+
+	output = &zldev->output[index];
+
+	/* Read output control register */
+	rc = zl3073x_read_output_ctrl(zldev, index, &output_ctrl);
+	if (rc)
+		return rc;
+
+	/* Store info about output enablement and synthesizer the output
+	 * is connected to.
+	 */
+	output->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
+	output->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
+
+	dev_dbg(zldev->dev, "OUTPUT%u is %sabled, connected to SYNTH%u\n",
+		index, output->enabled ? "en" : "dis", output->synth);
+
+	guard(zl3073x_mailbox)(zldev);
+
+	/* Load given output config into mailbox */
+	rc = zl3073x_mb_output_read(zldev, index);
+	if (rc)
+		return rc;
+
+	/* Read output mode from mailbox */
+	rc = zl3073x_mb_read_output_mode(zldev, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Extract and store output signal format */
+	output->signal_format = FIELD_GET(ZL_OUTPUT_MODE_SIGNAL_FORMAT,
+					  output_mode);
+
+	dev_dbg(zldev->dev, "OUTPUT%u has signal format 0x%02x\n", index,
+		output->signal_format);
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
+	u16 base, numerator, denominator;
+	u8 synth_ctrl;
+	u32 mult;
+	int rc;
+
+	/* Read synth control register */
+	rc = zl3073x_read_synth_ctrl(zldev, index, &synth_ctrl);
+	if (rc)
+		return rc;
+
+	/* Extract and store DPLL channel the synth is driven by */
+	zldev->synth[index].dpll = FIELD_GET(ZL_SYNTH_CTRL_DPLL_SEL,
+					     synth_ctrl);
+
+	dev_dbg(zldev->dev, "SYNTH%u is connected to DPLL%u\n", index,
+		zldev->synth[index].dpll);
+
+	guard(zl3073x_mailbox)(zldev);
+
+	/* Read synth configuration into mailbox */
+	rc = zl3073x_mb_synth_read(zldev, index);
+	if (rc)
+		return rc;
+
+	/* The output frequency is determined by the following formula:
+	 * base * multiplier * numerator / denominator
+	 *
+	 * Therefore get all this number and calculate the output frequency
+	 */
+	rc = zl3073x_mb_read_synth_freq_base(zldev, &base);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_mb_read_synth_freq_mult(zldev, &mult);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_mb_read_synth_freq_m(zldev, &numerator);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_mb_read_synth_freq_n(zldev, &denominator);
+	if (rc)
+		return rc;
+
+	/* Check denominator for zero to avoid div by 0 */
+	if (!denominator) {
+		dev_err(zldev->dev,
+			"Zero divisor for SYNTH%u retrieved from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	/* Compute and store synth frequency */
+	zldev->synth[index].freq = mul_u64_u32_div(mul_u32_u32(base, mult),
+						   numerator, denominator);
+
+	dev_dbg(zldev->dev, "SYNTH%u frequency: %llu Hz\n", index,
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
+	for (i = 0; i < ZL3073X_NUM_INPUTS; i++) {
+		rc = zl3073x_input_state_fetch(zldev, i);
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
+	for (i = 0; i < ZL3073X_NUM_OUTPUTS; i++) {
+		rc = zl3073x_output_state_fetch(zldev, i);
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
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -537,6 +769,11 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	/* Use chip ID and given dev ID as clock ID */
 	zldev->clock_id = ((u64)id << 8) | dev_id;
 
+	/* Fetch device state */
+	rc = zl3073x_dev_state_fetch(zldev);
+	if (rc)
+		return rc;
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 5074f64a70137..c77d0815b4dfd 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -8,18 +8,75 @@
 struct device;
 struct regmap;
 
+/*
+ * Hardware limits for ZL3073x chip family
+ */
+#define ZL3073X_NUM_INPUTS	10
+#define ZL3073X_NUM_OUTPUTS	10
+#define ZL3073X_NUM_SYNTHS	5
+
+/**
+ * struct zl3073x_input - input invariant info
+ * @enabled: input is enabled or disabled
+ * @diff: true if input is differential
+ */
+struct zl3073x_input {
+	bool	enabled;
+	bool	diff;
+};
+
+/**
+ * struct zl3073x_output - output invariant info
+ * @enabled: output is enabled or disabled
+ * @synth: synthesizer the output is connected to
+ * @signal_format: output signal format
+ */
+struct zl3073x_output {
+	bool	enabled;
+	u8	synth;
+	u8	signal_format;
+#define ZL_OUTPUT_SIGNAL_FORMAT_DISABLED	0
+#define ZL_OUTPUT_SIGNAL_FORMAT_LVDS		1
+#define ZL_OUTPUT_SIGNAL_FORMAT_DIFFERENTIAL	2
+#define ZL_OUTPUT_SIGNAL_FORMAT_LOWVCM		3
+#define ZL_OUTPUT_SIGNAL_FORMAT_TWO		4
+#define ZL_OUTPUT_SIGNAL_FORMAT_ONE_P		5
+#define ZL_OUTPUT_SIGNAL_FORMAT_ONE_N		6
+#define ZL_OUTPUT_SIGNAL_FORMAT_TWO_INV		7
+#define ZL_OUTPUT_SIGNAL_FORMAT_TWO_N_DIV	12
+#define ZL_OUTPUT_SIGNAL_FORMAT_TWO_N_DIV_INV	15
+};
+
+/**
+ * struct zl3073x_synth - synthesizer invariant info
+ * @freq: synthesizer frequency
+ * @dpll: ID of DPLL the synthesizer is driven by
+ */
+struct zl3073x_synth {
+	u64	freq;
+	u8	dpll;
+};
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @mailbox_lock: mutex protecting an access to mailbox registers
  * @clock_id: clock id of the device
+ * @input: array of inputs' invariants
+ * @output: array of outputs' invariants
+ * @synth: array of synthesizers' invariants
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		mailbox_lock;
 	u64			clock_id;
+
+	/* Invariants */
+	struct zl3073x_input	input[ZL3073X_NUM_INPUTS];
+	struct zl3073x_output	output[ZL3073X_NUM_OUTPUTS];
+	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
 };
 
 /**
@@ -61,4 +118,108 @@ int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
 int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
 int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
 
+static inline
+bool zl3073x_is_n_pin(u8 index)
+{
+	/* P-pins indices are even while N-pins are odd */
+	return index & 1;
+}
+
+static inline
+bool zl3073x_is_p_pin(u8 index)
+{
+	return !zl3073x_is_n_pin(index);
+}
+
+/**
+ * zl3073x_input_is_diff - check if the given input ref is differential
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if input is differential, false if input is single-ended
+ */
+static inline
+bool zl3073x_input_is_diff(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].diff;
+}
+
+/**
+ * zl3073x_input_is_enabled - check if the given input ref is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: input index
+ *
+ * Return: true if input is enabled, false if input is disabled
+ */
+static inline
+bool zl3073x_input_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].enabled;
+}
+
+/**
+ * zl3073x_output_is_enabled - check if the given output is enabled
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: true if output is enabled, false if output is disabled
+ */
+static inline
+u8 zl3073x_output_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].enabled;
+}
+
+/**
+ * zl3073x_output_signal_format_get - get output signal format
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: signal format of given output
+ */
+static inline
+u8 zl3073x_output_signal_format_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].signal_format;
+}
+
+/**
+ * zl3073x_output_synth_get - get synth connected to given output
+ * @zldev: pointer to zl3073x device
+ * @index: output index
+ *
+ * Return: index of synth connected to given output.
+ */
+static inline
+u8 zl3073x_output_synth_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].synth;
+}
+
+/**
+ * zl3073x_synth_dpll_get - get DPLL ID the synth is driven by
+ * @zldev: pointer to zl3073x device
+ * @index: synth index
+ *
+ * Return: ID of DPLL the given synthetizer is driven by
+ */
+static inline
+u64 zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
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
+static inline
+u64 zl3073x_synth_freq_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].freq;
+}
+
 #endif /* __LINUX_MFD_ZL3073X_H */
diff --git a/include/linux/mfd/zl3073x_regs.h b/include/linux/mfd/zl3073x_regs.h
index d155650349c97..ff5b2e6fae9d0 100644
--- a/include/linux/mfd/zl3073x_regs.h
+++ b/include/linux/mfd/zl3073x_regs.h
@@ -106,6 +106,63 @@ zl3073x_read_custom_config_ver(struct zl3073x_dev *zldev, u32 *value)
 	return rc;
 }
 
+/***********************************
+ * Register Page 9, Synth and Output
+ ***********************************/
+
+/*
+ * Register array 'synth_ctrl'
+ * Page: 9, Offset: 0x00, Size: 8 bits, Items: 5, Stride: 1
+ */
+#define ZL_REG_SYNTH_CTRL	 ZL_REG_ADDR(9, 0x00)
+#define ZL_REG_SYNTH_CTRL_ITEMS	 5
+#define ZL_REG_SYNTH_CTRL_STRIDE 1
+#define ZL_SYNTH_CTRL_EN	 BIT(0)
+#define ZL_SYNTH_CTRL_DPLL_SEL	 GENMASK(6, 4)
+
+static inline __maybe_unused int
+zl3073x_read_synth_ctrl(struct zl3073x_dev *zldev, unsigned int idx, u8 *value)
+{
+	unsigned int addr, v;
+	int rc;
+
+	if (idx >= ZL_REG_SYNTH_CTRL_ITEMS)
+		return -EINVAL;
+
+	addr = ZL_REG_SYNTH_CTRL + idx * ZL_REG_SYNTH_CTRL_STRIDE;
+	rc = regmap_read(zldev->regmap, addr, &v);
+	*value = v;
+	return rc;
+}
+
+/*
+ * Register array 'output_ctrl'
+ * Page: 9, Offset: 0x28, Size: 8 bits, Items: 10, Stride: 1
+ */
+#define ZL_REG_OUTPUT_CTRL	  ZL_REG_ADDR(9, 0x28)
+#define ZL_REG_OUTPUT_CTRL_ITEMS  10
+#define ZL_REG_OUTPUT_CTRL_STRIDE 1
+#define ZL_OUTPUT_CTRL_EN	  BIT(0)
+#define ZL_OUTPUT_CTRL_STOP	  BIT(1)
+#define ZL_OUTPUT_CTRL_STOP_HIGH  BIT(2)
+#define ZL_OUTPUT_CTRL_STOP_HZ	  BIT(3)
+#define ZL_OUTPUT_CTRL_SYNTH_SEL  GENMASK(6, 4)
+
+static inline __maybe_unused int
+zl3073x_read_output_ctrl(struct zl3073x_dev *zldev, unsigned int idx, u8 *value)
+{
+	unsigned int addr, v;
+	int rc;
+
+	if (idx >= ZL_REG_OUTPUT_CTRL_ITEMS)
+		return -EINVAL;
+
+	addr = ZL_REG_OUTPUT_CTRL + idx * ZL_REG_OUTPUT_CTRL_STRIDE;
+	rc = regmap_read(zldev->regmap, addr, &v);
+	*value = v;
+	return rc;
+}
+
 /*******************************
  * Register Page 10, Ref Mailbox
  *******************************/
@@ -181,6 +238,26 @@ zl3073x_mb_poll_ref_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
 					ZL_POLL_TIMEOUT_US);
 }
 
+/*
+ * Register 'ref_config'
+ * Page: 10, Offset: 0x0d, Size: 8 bits
+ */
+#define ZL_REG_REF_CONFIG     ZL_REG_ADDR(10, 0x0d)
+#define ZL_REF_CONFIG_ENABLE  BIT(0)
+#define ZL_REF_CONFIG_DIFF_EN BIT(2)
+
+static inline __maybe_unused int
+zl3073x_mb_read_ref_config(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_REF_CONFIG, &v);
+	*value = v;
+	return rc;
+}
+
 /********************************
  * Register Page 12, DPLL Mailbox
  ********************************/
@@ -331,6 +408,94 @@ zl3073x_mb_poll_synth_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
 					ZL_POLL_TIMEOUT_US);
 }
 
+/*
+ * Register 'synth_freq_base'
+ * Page: 13, Offset: 0x06, Size: 16 bits
+ */
+#define ZL_REG_SYNTH_FREQ_BASE ZL_REG_ADDR(13, 0x06)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_freq_base(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_SYNTH_FREQ_BASE, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'synth_freq_mult'
+ * Page: 13, Offset: 0x08, Size: 32 bits
+ */
+#define ZL_REG_SYNTH_FREQ_MULT ZL_REG_ADDR(13, 0x08)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_freq_mult(struct zl3073x_dev *zldev, u32 *value)
+{
+	__be32 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_SYNTH_FREQ_MULT, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be32_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'synth_freq_m'
+ * Page: 13, Offset: 0x0c, Size: 16 bits
+ */
+#define ZL_REG_SYNTH_FREQ_M ZL_REG_ADDR(13, 0x0c)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_freq_m(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_SYNTH_FREQ_M, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+/*
+ * Register 'synth_freq_n'
+ * Page: 13, Offset: 0x0e, Size: 16 bits
+ */
+#define ZL_REG_SYNTH_FREQ_N ZL_REG_ADDR(13, 0x0e)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_freq_n(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_SYNTH_FREQ_N, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
 /**********************************
  * Register Page 14, Output Mailbox
  **********************************/
@@ -406,4 +571,23 @@ zl3073x_mb_poll_output_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
 					ZL_POLL_TIMEOUT_US);
 }
 
+/*
+ * Register 'output_mode'
+ * Page: 14, Offset: 0x05, Size: 8 bits
+ */
+#define ZL_REG_OUTPUT_MODE	     ZL_REG_ADDR(14, 0x05)
+#define ZL_OUTPUT_MODE_SIGNAL_FORMAT GENMASK(7, 4)
+
+static inline __maybe_unused int
+zl3073x_mb_read_output_mode(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_OUTPUT_MODE, &v);
+	*value = v;
+	return rc;
+}
+
 #endif /* __LINUX_MFD_ZL3073X_REGS_H */
-- 
2.48.1


