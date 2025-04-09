Return-Path: <netdev+bounces-180810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20074A828FF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D323B7132
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F4D26F473;
	Wed,  9 Apr 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwFA1gFQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42474267AFC
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209855; cv=none; b=h1XmPkdIAdCRPxg18c226s0EFHo3ZQcgATcB0DZ93RYKrK5vAINiAl0A0V8ys9WbECFPxa1lXbX815cn1Hse0HC23DlJkNMO0T4xg0wGp6s85bZKzpBB78wj2vOm5UzBb1R+a/uW/SDU3Cwb9xY2tIl9dMKMcEX5JTtoj3wkas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209855; c=relaxed/simple;
	bh=r4tEhs3plnKYcKDhvXEA+K3gyKULKlZx/3IR/BGLFcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ4W26OGP5JZrDDGHGCejsdg8p2ueFNGd6WTQjTpUKXoJY1Nm5e8DEPpyI6wbz5eAWbOQeBYk39ZJEg2D9fXu/zrp71voqAb9zjbVuDB8dk4k69kls5DpdUjyX2krTFXAcr35nJrxyWAy/gdxJx991DDXeW5eLbIN62ue1QhvQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwFA1gFQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvqkpfjDT+NgiYPOSw0pvxSQmjnc3C6o8MNs2VobJgk=;
	b=dwFA1gFQWyG/gc/P36d9vPTmKuiNlGjq6PF4gx2uqoX/TH1SnrMAOin14GFYRkV4SPl76L
	tAW0xxEgqMw66N2Gb0mDgq+E/wFNuaLsq8RfFsilxcIHoXG35UOx+FS9RLEcpubsGazqSb
	n7NVX+CTnznGumobvQwzdFYTiJ1DHqY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-EbAQfhTYPIu0bApdNW2vzQ-1; Wed,
 09 Apr 2025 10:44:06 -0400
X-MC-Unique: EbAQfhTYPIu0bApdNW2vzQ-1
X-Mimecast-MFC-AGG-ID: EbAQfhTYPIu0bApdNW2vzQ_1744209844
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70F4818001E3;
	Wed,  9 Apr 2025 14:44:04 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 388A01801747;
	Wed,  9 Apr 2025 14:44:00 +0000 (UTC)
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
Subject: [PATCH v2 14/14] mfd: zl3073x: Fetch invariants during probe
Date: Wed,  9 Apr 2025 16:42:50 +0200
Message-ID: <20250409144250.206590-15-ivecera@redhat.com>
In-Reply-To: <20250409144250.206590-1-ivecera@redhat.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
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

* synthesizers' frequencies and associated DPLL channel
* input pins' enablement and type (single-ended or differential)
* outputs'associated synths, signal format and enablement

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v1->v2:
* fixed and added inline documentation
---
 drivers/mfd/zl3073x-core.c  | 243 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h | 161 ++++++++++++++++++++++++
 2 files changed, 404 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 110071b28cab9..70fd7a76c6478 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -11,6 +11,7 @@
 #include <linux/firmware.h>
 #include <linux/kstrtox.h>
 #include <linux/lockdep.h>
+#include <linux/math64.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -29,6 +30,20 @@ ZL3073X_REG16_DEF(revision,		0x0003);
 ZL3073X_REG16_DEF(fw_ver,		0x0005);
 ZL3073X_REG32_DEF(custom_config_ver,	0x0007);
 
+/*
+ * Register Map Page 9, Synth and Output
+ */
+ZL3073X_REG8_IDX_DEF(synth_ctrl,		0x480, ZL3073X_NUM_SYNTHS, 1);
+#define SYNTH_CTRL_EN				BIT(0)
+#define SYNTH_CTRL_DPLL_SEL			GENMASK(6, 4)
+
+ZL3073X_REG8_IDX_DEF(output_ctrl,		0x4a8, ZL3073X_NUM_OUTPUTS, 1);
+#define OUTPUT_CTRL_EN				BIT(0)
+#define OUTPUT_CTRL_STOP			BIT(1)
+#define OUTPUT_CTRL_STOP_HIGH			BIT(2)
+#define OUTPUT_CTRL_STOP_HZ			BIT(3)
+#define OUTPUT_CTRL_SYNTH_SEL			GENMASK(6, 4)
+
 /*
  * Register Map Page 10, Ref Mailbox
  */
@@ -39,6 +54,10 @@ ZL3073X_REG8_DEF(ref_mb_sem,			0x504);
 #define REF_MB_SEM_WR				BIT(0)
 #define REF_MB_SEM_RD				BIT(1)
 
+ZL3073X_REG8_DEF(ref_config,			0x50d);
+#define REF_CONFIG_ENABLE			BIT(0)
+#define REF_CONFIG_DIFF_EN			BIT(2)
+
 /*
  * Register Map Page 12, DPLL Mailbox
  */
@@ -70,6 +89,9 @@ ZL3073X_REG8_DEF(output_mb_sem,			0x704);
 #define OUTPUT_MB_SEM_WR			BIT(0)
 #define OUTPUT_MB_SEM_RD			BIT(1)
 
+ZL3073X_REG8_DEF(output_mode,			0x705);
+#define OUTPUT_MODE_SIGNAL_FORMAT		GENMASK(7, 4)
+
 /*
  * Regmap ranges
  */
@@ -570,6 +592,220 @@ static void zl3073x_fw_load(struct zl3073x_dev *zldev)
 	release_firmware(fw);
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
+	/* Read reference configuration into mailbox */
+	rc = zl3073x_mb_ref_read(zldev, index);
+	if (rc)
+		return rc;
+
+	/* Read reference config register */
+	rc = zl3073x_read_ref_config(zldev, &ref_config);
+	if (rc)
+		return rc;
+
+	/* Store info about input reference enablement and if it is
+	 * configured in differential mode or not.
+	 */
+	input->enabled = FIELD_GET(REF_CONFIG_ENABLE, ref_config);
+	input->diff = FIELD_GET(REF_CONFIG_DIFF_EN, ref_config);
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
+	output->enabled = FIELD_GET(OUTPUT_CTRL_EN, output_ctrl);
+	output->synth = FIELD_GET(OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
+
+	/* Load given output config into mailbox */
+	rc = zl3073x_mb_output_read(zldev, index);
+	if (rc)
+		return rc;
+
+	/* Read output mode from mailbox */
+	rc = zl3073x_read_output_mode(zldev, &output_mode);
+	if (rc)
+		return rc;
+
+	/* Extract and store output signal format */
+	output->signal_format = FIELD_GET(OUTPUT_MODE_SIGNAL_FORMAT,
+					  output_mode);
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
+	zldev->synth[index].dpll = FIELD_GET(SYNTH_CTRL_DPLL_SEL, synth_ctrl);
+
+	dev_dbg(zldev->dev, "SYNTH%u is connected to DPLL%u\n", index,
+		zldev->synth[index].dpll);
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
+	rc = zl3073x_read_synth_freq_base(zldev, &base);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_synth_freq_mult(zldev, &mult);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_synth_freq_m(zldev, &numerator);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_synth_freq_n(zldev, &denominator);
+	if (rc)
+		return rc;
+
+	/* Check denominator for zero to avoid div by 0 */
+	if (!denominator) {
+		dev_err(zldev->dev,
+			"Zero divisor for SYNTH%u retrieved from device\n",
+			index);
+		return -ENODEV;
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
  * zl3073x_dev_init - initialize zl3073x device
  * @zldev: pointer to zl3073x device
@@ -614,6 +850,13 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 	/* Load mfg file if present */
 	zl3073x_fw_load(zldev);
 
+	/* Fetch device state */
+	scoped_guard(zl3073x, zldev) {
+		rc = zl3073x_dev_state_fetch(zldev);
+		if (rc)
+			return rc;
+	}
+
 	dev_info(zldev->dev, "ChipID(%X), ChipRev(%X), FwVer(%u)\n",
 		 id, revision, fw_ver);
 	dev_info(zldev->dev, "Custom config version: %lu.%lu.%lu.%lu\n",
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 50befd7f03b24..ec265d2e935bb 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -12,18 +12,75 @@
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
+#define OUTPUT_MODE_SIGNAL_FORMAT_DISABLED	0
+#define OUTPUT_MODE_SIGNAL_FORMAT_LVDS		1
+#define OUTPUT_MODE_SIGNAL_FORMAT_DIFFERENTIAL	2
+#define OUTPUT_MODE_SIGNAL_FORMAT_LOWVCM	3
+#define OUTPUT_MODE_SIGNAL_FORMAT_TWO		4
+#define OUTPUT_MODE_SIGNAL_FORMAT_ONE_P		5
+#define OUTPUT_MODE_SIGNAL_FORMAT_ONE_N		6
+#define OUTPUT_MODE_SIGNAL_FORMAT_TWO_INV	7
+#define OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV	12
+#define OUTPUT_MODE_SIGNAL_FORMAT_TWO_N_DIV_INV	15
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
  * @regmap: regmap to access HW registers
  * @clock_id: clock id of the device
  * @lock: lock to be held during access to HW registers
+ * @input: array of inputs
+ * @output: array of outputs
+ * @synth: array of synthesizers
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	u64			clock_id;
 	struct mutex		lock;
+
+	/* Invariants */
+	struct zl3073x_input	input[ZL3073X_NUM_INPUTS];
+	struct zl3073x_output	output[ZL3073X_NUM_OUTPUTS];
+	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
 };
 
 /**
@@ -199,4 +256,108 @@ int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
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
-- 
2.48.1


