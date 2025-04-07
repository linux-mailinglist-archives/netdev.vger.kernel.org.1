Return-Path: <netdev+bounces-179794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368DEA7E86D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5453BAAE0
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226621B9CE;
	Mon,  7 Apr 2025 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaUE6jLu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA95121B8E0
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047141; cv=none; b=jXox8nSfSjjuXA7SYBIOfma9tokOT8VhfqIHhnlko/o00eteCyvgeoFzZxHDvkUKkoDPQiF0vPcorVLVcJvp9WglAqfDacv6b+CYLW7XApXWIL6mFF3biE7dkPcr9slPvLR3R4UKPu8XJpv5vLRaNAiox5BdzHgeSU+WP6RwNvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047141; c=relaxed/simple;
	bh=e0vMF5XBbEvwyL68baY4pvsuRtPw//ZbXskekj6bNaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eH0pH2uOgoT3iJ4y5RQLFq1Iy2ZFrpt0Xo5gaEEEOPchdqR6MYphncC9zWjSNXHdOxsHN95OZsm0CV4wnM1j61rmeN0O0nkOkxxpnVhTtlXFCRoDCCMR9LqJOmFpWxQyNlRFAtRUUNc6GtDjhy3GIHqSE2FMF5sgXRBSaEhIvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaUE6jLu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwwDNQaG9gg5NtaHn8oXyPn+lCzMmbq2wq4r/S5IuwQ=;
	b=OaUE6jLup67E5ys5HVt9Y9DBTX5S6doXfFlASfSfGqV+qBL2GkvaC6iIHDgWIL2Xx4w5Xz
	zbk/0aZn/TtM7mNqJFHpqB5C38yJtDSCoJtAU2I32vBf1q1U2yuGQnktaZV+J+4D6R+KRh
	3p0iIuRMx/QpJrvvy3ZJ2QiBRCap1n0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-FgmN3PJ5Mc2yt08UUIltVg-1; Mon,
 07 Apr 2025 13:32:11 -0400
X-MC-Unique: FgmN3PJ5Mc2yt08UUIltVg-1
X-Mimecast-MFC-AGG-ID: FgmN3PJ5Mc2yt08UUIltVg_1744047128
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B220F19560B0;
	Mon,  7 Apr 2025 17:32:08 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CCD01955BC0;
	Mon,  7 Apr 2025 17:32:02 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 12/28] mfd: zl3073x: Fetch invariants during probe
Date: Mon,  7 Apr 2025 19:31:42 +0200
Message-ID: <20250407173149.1010216-3-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Several configuration parameters will not be changed in runtime so we
can load them during probe to avoid excessive reads from the hardware.

The following parameters are read and stored for later use:

* synthesizers' frequencies and associated DPLL channel
* input pins' enablement and type (single-ended or differential)
* outputs'associated synths, signal format and enablement

These parameters will be frequently read by the DPLL driver from this
series and later by PHC/PTP sub-device driver.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/mfd/zl3073x-core.c  | 241 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/zl3073x.h | 142 +++++++++++++++++++++
 2 files changed, 383 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 9920c5329d50f..9ed405a62fa86 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -14,6 +14,20 @@ ZL3073X_REG16_DEF(revision,		0x0003);
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
@@ -24,6 +38,10 @@ ZL3073X_REG8_DEF(ref_mb_sem,			0x504);
 #define REF_MB_SEM_WR				BIT(0)
 #define REF_MB_SEM_RD				BIT(1)
 
+ZL3073X_REG8_DEF(ref_config,			0x50d);
+#define REF_CONFIG_ENABLE			BIT(0)
+#define REF_CONFIG_DIFF_EN			BIT(2)
+
 /*
  * Register Map Page 12, DPLL Mailbox
  */
@@ -55,6 +73,9 @@ ZL3073X_REG8_DEF(output_mb_sem,			0x704);
 #define OUTPUT_MB_SEM_WR			BIT(0)
 #define OUTPUT_MB_SEM_RD			BIT(1)
 
+ZL3073X_REG8_DEF(output_mode,			0x705);
+#define OUTPUT_MODE_SIGNAL_FORMAT		GENMASK(7, 4)
+
 /*
  * Regmap ranges
  */
@@ -526,6 +547,219 @@ static void zl3073x_fw_load(struct zl3073x_dev *zldev)
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
+ * Returns 0 in case of success or negative value in error case.
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
+	if (zl3073x_is_n_pin(index) && zl3073x_input_is_diff(zldev, index-1)) {
+		input->enabled = zl3073x_input_is_enabled(zldev, index-1);
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
+ * Returns 0 in case of success or negative value in error case.
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
+ * Returns 0 in case of success or negative value in error case.
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
 int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
 {
 	u16 id, revision, fw_ver;
@@ -556,6 +790,13 @@ int zl3073x_dev_init(struct zl3073x_dev *zldev, u8 dev_id)
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
index a18eddbc03709..825e6706dc974 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -6,11 +6,49 @@
 #include <linux/device.h>
 #include <linux/regmap.h>
 
+/*
+ * Hardware limits for ZL3073x chip family
+ */
+#define ZL3073X_NUM_INPUTS	10
+#define ZL3073X_NUM_OUTPUTS	10
+#define ZL3073X_NUM_SYNTHS	5
+
+struct zl3073x_input {
+	bool	enabled;
+	bool	diff;
+};
+
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
+struct zl3073x_synth {
+	u64	freq;
+	u8	dpll;
+};
+
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
@@ -185,4 +223,108 @@ int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
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
+ * @zldev: device structure pointer
+ * @index: output index
+ *
+ * Returns true if the given input ref is differential
+ */
+static inline
+bool zl3073x_input_is_diff(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].diff;
+}
+
+/**
+ * zl3073x_input_is_enabled - check if the given input ref is enabled
+ * @zldev: device structure pointer
+ * @index: output index
+ *
+ * Returns true if the given input ref is enabled
+ */
+static inline
+bool zl3073x_input_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->input[index].enabled;
+}
+
+/**
+ * zl3073x_output_is_enabled - check if the given output is enabled
+ * @zldev: device structure pointer
+ * @index: output index
+ *
+ * Returns true if the given output is enabled
+ */
+static inline
+u8 zl3073x_output_is_enabled(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].enabled;
+}
+
+/**
+ * zl3073x_output_signal_format_get - get output signal format
+ * @zldev: device structure pointer
+ * @index: output index
+ *
+ * Returns signal format of given output
+ */
+static inline
+u8 zl3073x_output_signal_format_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].signal_format;
+}
+
+/**
+ * zl3073x_output_synth_get - get synth connected to given output
+ * @zldev: device structure pointer
+ * @index: output index
+ *
+ * Returns index of synth connected to given output.
+ */
+static inline
+u8 zl3073x_output_synth_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->output[index].synth;
+}
+
+/**
+ * zl3073x_synth_dpll_get - get dpll id where the synth is connected to
+ * @zldev: device structure pointer
+ * @index: synth order number
+ *
+ * Returns frequency of given synthetizer
+ */
+static inline
+u64 zl3073x_synth_dpll_get(struct zl3073x_dev *zldev, u8 index)
+{
+	return zldev->synth[index].dpll;
+}
+
+/**
+ * zl3073x_synth_freq_get - get synth current freq
+ * @zldev: device structure pointer
+ * @index: synth order number
+ *
+ * Returns frequency of given synthetizer
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


