Return-Path: <netdev+bounces-188708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD3EAAE4BE
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65E59A7A0D
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7928A419;
	Wed,  7 May 2025 15:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2kkOoWA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A14028A1DC
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631556; cv=none; b=AnHPJ8p9CPpiH6R6iZ778lU/aUMM9xHjRZh+1TMz8aNonfMjgytZMuamI/H5yCqYMmszIzUIaf33kAabkXRuces+jOgU2CBZT57krlQiVvFbszX5JN4/H9iAuBLDmJbslTAY8CKers1elQWgRzJqfXjupuxEPbVqR3CpC6YuEZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631556; c=relaxed/simple;
	bh=05j3rnNnaQtknkQcd/6BxBdEJS3YkvdrNwpoSamEykM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQR5INkpB5JcAnQQmmTb0aX13bYyp37TaH9y8Y+eFQlz5t5ePMsaAAje2xowsFXNInMMitzFfCtFGcw2PgVXgvsmcwU52kPsOomrgJl56JBOaQ+Tl12TPAiEIMy6LLzbrtgPyAJal1P9pGAqErAwfIBdgTvQXWjrGDb8m/pupQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b2kkOoWA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qf1fWmH745XBlmTfkfSWZnCtWRlXXIQIlIzRkqIh+OQ=;
	b=b2kkOoWAiTAWyv0gKalkutCagj15C2jYgcp6SSR9cV0EKmF3RuoHXJ42t7/G2A8gVfYVOx
	rPO4MNZPesQviL3j7HDOoDww6Tslj3BKiWgoH9oiqDLi8a8M2/MwZBwmFe+UDb4bWv2jfU
	iieatMa6oHVep+XGA/on0+NVC75izmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-WklEf2PIMWKungHOP-21jA-1; Wed,
 07 May 2025 11:25:50 -0400
X-MC-Unique: WklEf2PIMWKungHOP-21jA-1
X-Mimecast-MFC-AGG-ID: WklEf2PIMWKungHOP-21jA_1746631548
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F393E1800DA2;
	Wed,  7 May 2025 15:25:47 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D459F30001A1;
	Wed,  7 May 2025 15:25:42 +0000 (UTC)
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
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v8 6/8] mfd: zl3073x: Fetch invariants during probe
Date: Wed,  7 May 2025 17:25:02 +0200
Message-ID: <20250507152504.85341-7-ivecera@redhat.com>
In-Reply-To: <20250507152504.85341-1-ivecera@redhat.com>
References: <20250507152504.85341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Several configuration parameters will remain constant at runtime,
so we can load them during probe to avoid excessive reads from
the hardware.

These parameters will be frequently accessed by the DPLL sub-device
driver (in follow-up series), and later by the PHC/PTP sub-device
driver.

Read the following parameters from the device during probe and store
them for later use:

* frequencies of the synthesizers and their associated DPLL channels
* enablement and type (single-ended or differential) of input pins
* associated synthesizers, signal format, and enablement status of
  outputs

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v7->v8:
* no change
v6->v7:
* export zl3073x_mb_op() - will be used immediatelly in part2
v5->v6:
* no change
v4->v5:
* updated to use new register API
v3->v4:
* adjusted for new mailbox API
v2->v3:
* dropped usage of macros for generating helper functions
v1->v2:
* fixed and added inline documentation
---
 drivers/mfd/zl3073x-core.c       | 251 +++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-regs.h       |  37 +++++
 include/linux/mfd/zl3073x-regs.h |  22 +++
 include/linux/mfd/zl3073x.h      | 153 +++++++++++++++++++
 4 files changed, 463 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index a12cfc7eb6ff..127e240a143d 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -6,6 +6,7 @@
 #include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/math64.h>
 #include <linux/mfd/zl3073x.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -504,6 +505,251 @@ void zl3073x_dev_init_regmap_config(struct regmap_config *regmap_cfg)
 }
 EXPORT_SYMBOL_NS_GPL(zl3073x_dev_init_regmap_config, "ZL3073X");
 
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
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_op, "ZL3073X");
+
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
+	dev_dbg(zldev->dev, "INPUT%u is %s and configured as %s\n", index,
+		input->enabled ? "enabled" : "disabled",
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
+	output = &zldev->output[index];
+
+	/* Read output configuration */
+	rc = zl3073x_read_u8(zldev, ZL_REG_OUTPUT_CTRL(index), &output_ctrl);
+	if (rc)
+		return rc;
+
+	/* Store info about output enablement and synthesizer the output
+	 * is connected to.
+	 */
+	output->enabled = FIELD_GET(ZL_OUTPUT_CTRL_EN, output_ctrl);
+	output->synth = FIELD_GET(ZL_OUTPUT_CTRL_SYNTH_SEL, output_ctrl);
+
+	dev_dbg(zldev->dev, "OUTPUT%u is %s, connected to SYNTH%u\n",
+		index, output->enabled ? "enabled" : "disabled", output->synth);
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
+	u16 base, num, denom;
+	u8 synth_ctrl;
+	u32 mult;
+	int rc;
+
+	/* Read synth control register */
+	rc = zl3073x_read_u8(zldev, ZL_REG_SYNTH_CTRL(index), &synth_ctrl);
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
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_M, &num);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_SYNTH_FREQ_N, &denom);
+	if (rc)
+		return rc;
+
+	/* Check denominator for zero to avoid div by 0 */
+	if (!denom) {
+		dev_err(zldev->dev,
+			"Zero divisor for SYNTH%u retrieved from device\n",
+			index);
+		return -EINVAL;
+	}
+
+	/* Compute and store synth frequency */
+	zldev->synth[index].freq = mul_u64_u32_div(mul_u32_u32(base, mult),
+						   num, denom);
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
 static void zl3073x_devlink_unregister(void *ptr)
 {
 	devlink_unregister(ptr);
@@ -571,6 +817,11 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
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
diff --git a/drivers/mfd/zl3073x-regs.h b/drivers/mfd/zl3073x-regs.h
index 6bb7ea1ef0b5..dcd278acab4b 100644
--- a/drivers/mfd/zl3073x-regs.h
+++ b/drivers/mfd/zl3073x-regs.h
@@ -14,4 +14,41 @@
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
+	ZL_REG_IDX(_idx, 9, 0x28, 1, ZL3073X_NUM_OUTPUTS, 1)
+#define ZL_OUTPUT_CTRL_EN			BIT(0)
+#define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
+
+/*******************************
+ * Register Page 10, Ref Mailbox
+ *******************************/
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
 #endif /* __ZL3073X_REGS_H */
diff --git a/include/linux/mfd/zl3073x-regs.h b/include/linux/mfd/zl3073x-regs.h
index cd2baed244eb..d94bd389f9a7 100644
--- a/include/linux/mfd/zl3073x-regs.h
+++ b/include/linux/mfd/zl3073x-regs.h
@@ -63,4 +63,26 @@
 #define ZL_REG(_page, _offset, _size)					\
 	ZL_REG_IDX(0, _page, _offset, _size, 1, 0)
 
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
+
 #endif /* __LINUX_MFD_ZL3073X_REGS_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index a42a275577c4..ca78ab6600f6 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -9,22 +9,71 @@
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
  * @multiop_lock: to serialize multiple register operations
+ * @input: array of inputs' invariants
+ * @output: array of outputs' invariants
+ * @synth: array of synthesizers' invariants
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
+
+	/* Invariants */
+	struct zl3073x_input	input[ZL3073X_NUM_INPUTS];
+	struct zl3073x_output	output[ZL3073X_NUM_OUTPUTS];
+	struct zl3073x_synth	synth[ZL3073X_NUM_SYNTHS];
 };
 
 /**********************
  * Registers operations
  **********************/
 
+int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
+		  unsigned int mask_reg, u16 mask_val);
 int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
 int zl3073x_read_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 *val);
 int zl3073x_read_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 *val);
@@ -35,4 +84,108 @@ int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val);
 int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val);
 int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
 
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
2.49.0


