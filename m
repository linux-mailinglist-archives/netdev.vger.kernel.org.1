Return-Path: <netdev+bounces-185633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6892CA9B2EF
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AEF16324C
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB77284B52;
	Thu, 24 Apr 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcErRcRY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A4F284681
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509684; cv=none; b=gutIHo/TXOih3V7bhtIeAJKwP6vQ1+m6EoC70VJFzcPpWfASwGTdGRCrwk7jN9NJM0tEWOkJX9bzl0hsn/WWFtnMCGrj9XTiDayE0Jr4E95FealZ6kCOxZNnkVndr9m/8Y0tlel3tn9w9CYL1zlOecq9gGryvNDQkbBgXyqP94c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509684; c=relaxed/simple;
	bh=pGCJNjFX43DOIZcHYmxMg8MB5H1sM+AcLGk4aaCjZSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMUrLBumCekG0vem7PdnwcIrQCiapWRJOqbmkPWwNEA3MZETXxXQ7JnFLH9DW8JgdPHdSg5G2ilme87Bv16Go7MDeoSQq6FlTlyhWxu1lCtR3l/CGdsrylSDyIE8gLXAkGjGfEMGG2uRvzky7AYzowdfXwwlaILYVUA4Kl7BKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcErRcRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745509681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AeZAuaUbsEZsEighUA+i235fIzMNwZ6c32yrokrquO0=;
	b=XcErRcRYaP2Zmb1AHYIYF4bhilSxuOIsfC7FqLeeq/DfJnNaNjPGEfgHA46JSxwJObwrF1
	zJcA8UPNFuz5woldafErdDuRKFOSRE6Qp/Z1UhOPMsW2nt9a/2XX6UW7XLtDtTEO7XG2V/
	1drijgLtZnMd/pUkOw9P3KHlRbEXKYI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-FXaAvGhUOd-c2zxzPM-F-Q-1; Thu,
 24 Apr 2025 11:47:58 -0400
X-MC-Unique: FXaAvGhUOd-c2zxzPM-F-Q-1
X-Mimecast-MFC-AGG-ID: FXaAvGhUOd-c2zxzPM-F-Q_1745509675
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0AEB1956089;
	Thu, 24 Apr 2025 15:47:55 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.28])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB67A19560A3;
	Thu, 24 Apr 2025 15:47:50 +0000 (UTC)
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
Subject: [PATCH net-next v4 5/8] mfd: zl3073x: Add functions to work with register mailboxes
Date: Thu, 24 Apr 2025 17:47:19 +0200
Message-ID: <20250424154722.534284-6-ivecera@redhat.com>
In-Reply-To: <20250424154722.534284-1-ivecera@redhat.com>
References: <20250424154722.534284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Registers located on page 10 and above are called mailbox-type
registers. Each page represents a mailbox and is used to read from
and write to configuration of a specific object (DPLL, output,
reference or synth).

Each mailbox page contains a mask register, which selects an index of
the target object to interact with and a semaphore register, which
indicates the requested operation.

The remaining registers within the page are latch registers, which are
populated by the firmware during read operations or by the driver prior
to write operations.

Define structures for sending and receiving mailbox content for each
supported object types, along with functions to handle reading and
writing.

Currently, no locking is required, as only MFD driver accesses these
registers. This will change in future.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v3->v4:
* completely reworked mailbox access

v1->v3:
* dropped ZL3073X_MB_OP macro usage
---
 drivers/mfd/zl3073x-core.c  | 420 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/zl3073x-regs.h  |  64 ++++++
 include/linux/mfd/zl3073x.h | 141 ++++++++++++
 3 files changed, 625 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 28cc25b7412e9..4f7c915f17980 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -170,6 +170,426 @@ zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg, void *val)
 	return rc;
 }
 
+static int
+zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg, const void *val)
+{
+	unsigned int len;
+	u8 buf[6];
+	int rc;
+
+	/* Offset of the last item in the indexed register or offset of
+	 * the non-indexed register itself.
+	 */
+	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
+		dev_err(zldev->dev, "Index of out range for reg 0x%04lx\n",
+			ZL_REG_ADDR(reg));
+		return -EINVAL;
+	}
+
+	len = ZL_REG_SIZE(reg);
+	switch (len) {
+	case 1:
+		buf[0] = *(u8 *)val;
+		break;
+	case 2:
+		put_unaligned_be16(*(u16 *)val, buf);
+		break;
+	case 4:
+		put_unaligned_be32(*(u32 *)val, buf);
+		break;
+	case 6:
+		put_unaligned_be48(*(u64 *)val, buf);
+		break;
+	default:
+		dev_err(zldev->dev, "Invalid reg-width %u for reg 0x%04lx\n",
+			len, ZL_REG_ADDR(reg));
+		return -EINVAL;
+	}
+
+	/* Map the register address to virtual range */
+	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
+
+	rc = regmap_bulk_write(zldev->regmap, reg, buf, len);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to write reg 0x%04x: %pe\n", reg,
+			ERR_PTR(rc));
+		return rc;
+	}
+
+	return rc;
+}
+
+static int
+zl3073x_wait_reg_zero_bits(struct zl3073x_dev *zldev, unsigned int reg, u8 mask)
+{
+	/* Register polling sleep & timeout */
+#define ZL_POLL_SLEEP_US   10
+#define ZL_POLL_TIMEOUT_US 2000000
+	unsigned int val;
+
+	/* Only 8bit registers are supported */
+	BUILD_BUG_ON(ZL_REG_SIZE(reg) != 1);
+
+	/* Map the register address to virtual range for polling */
+	reg = ZL_REG_ADDR(reg) + ZL_RANGE_OFFSET;
+
+	return regmap_read_poll_timeout(zldev->regmap, reg, val, !(val & mask),
+					ZL_POLL_SLEEP_US, ZL_POLL_TIMEOUT_US);
+}
+
+static int
+zl3073x_mb_cmd_do(struct zl3073x_dev *zldev, unsigned int cmd_reg, u8 cmd,
+		  unsigned int mask_reg, u16 mask)
+{
+	int rc;
+
+	rc = zl3073x_write_reg(zldev, mask_reg, &mask);
+	if (rc)
+		return rc;
+
+	rc = zl3073x_write_reg(zldev, cmd_reg, &cmd);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to finish */
+	return zl3073x_wait_reg_zero_bits(zldev, cmd_reg, cmd);
+}
+
+/**
+ * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ * @fields: mask of the mailbox fields to be filled
+ * @mb: DPLL mailbox
+ *
+ * Reads selected configuration of given reference into output mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			 struct zl3073x_mb_dpll *mb)
+{
+	int i, rc;
+
+	rc = zl3073x_mb_cmd_do(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
+			       ZL_REG_DPLL_MB_MASK, BIT(index));
+	if (rc)
+		return rc;
+
+	for (i = 0; i < ARRAY_SIZE(mb->ref_prio); i++) {
+		if (fields & BIT(i)) {
+			rc = zl3073x_read_reg(zldev, ZL_REG_DPLL_REF_PRIO(i),
+					      &mb->ref_prio[i]);
+			if (rc)
+				break;
+		}
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_dpll_read, "ZL3073X");
+
+/**
+ * zl3073x_mb_dpll_write - write given DPLL configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ * @fields: mask of the mailbox fields to be written
+ * @mb: DPLL channel mailbox
+ *
+ * Writes selected fields from the mailbox into device.
+  *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			  struct zl3073x_mb_dpll *mb)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(mb->ref_prio); i++) {
+		if (fields & BIT(i)) {
+			rc = zl3073x_write_reg(zldev, ZL_REG_DPLL_REF_PRIO(i),
+					       &mb->ref_prio[i]);
+			if (rc)
+				break;
+		}
+	}
+
+	return zl3073x_mb_cmd_do(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
+				 ZL_REG_DPLL_MB_MASK, BIT(index));
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_dpll_write, "ZL3073X");
+
+/**
+ * zl3073x_mb_output_read - read given output configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: output index
+ * @fields: mask of the mailbox fields to be filled
+ * @mb: output mailbox
+ *
+ * Reads selected configuration of given reference into output mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			   struct zl3073x_mb_output *mb)
+{
+	int rc;
+
+	rc = zl3073x_mb_cmd_do(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			       ZL_REG_OUTPUT_MB_MASK, BIT(index));
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_MODE))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_MODE, &mb->mode);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_DIV))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_DIV, &mb->div);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_WIDTH))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_WIDTH, &mb->width);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_ESYNC_PERIOD))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
+				      &mb->esync_period);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_ESYNC_WIDTH))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH,
+				      &mb->esync_width);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_PHASE_COMP))
+		rc = zl3073x_read_reg(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+				      &mb->phase_comp);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_output_read, "ZL3073X");
+
+/**
+ * zl3073x_mb_output_write - write given output configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: output index
+ * @fields: mask of the mailbox fields to be written
+ * @mb: output mailbox
+ *
+ * Writes selected fields from the mailbox into device.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			    const struct zl3073x_mb_output *mb)
+{
+	int rc = 0;
+
+	if (fields & ZL3073X_MB_OUTPUT_MODE)
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_MODE, &mb->mode);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_DIV))
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_DIV, &mb->div);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_WIDTH))
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_WIDTH, &mb->width);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_ESYNC_PERIOD))
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_ESYNC_PERIOD,
+				       &mb->esync_period);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_ESYNC_WIDTH))
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_ESYNC_WIDTH,
+				       &mb->esync_width);
+
+	if (!rc && (fields & ZL3073X_MB_OUTPUT_PHASE_COMP))
+		rc = zl3073x_write_reg(zldev, ZL_REG_OUTPUT_PHASE_COMP,
+				       &mb->phase_comp);
+	if (rc)
+		return rc;
+
+	return zl3073x_mb_cmd_do(zldev,
+				 ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+				 ZL_REG_OUTPUT_MB_MASK, BIT(index));
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_output_write, "ZL3073X");
+
+/**
+ * zl3073x_mb_ref_read - read given reference configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ * @fields: mask of the mailbox fields to be filled
+ * @mb: reference mailbox
+ *
+ * Reads selected configuration of given reference into ref mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			struct zl3073x_mb_ref *mb)
+{
+	int rc;
+
+	rc = zl3073x_mb_cmd_do(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			       ZL_REG_REF_MB_MASK, BIT(index));
+
+	if (!rc && (fields & ZL3073X_MB_REF_FREQ_BASE))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_FREQ_BASE,
+				      &mb->freq_base);
+
+	if (!rc && (fields & ZL3073X_MB_REF_FREQ_MULT))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_FREQ_MULT,
+				      &mb->freq_mult);
+
+	if (!rc && (fields & ZL3073X_MB_REF_RATIO_M))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_RATIO_M, &mb->ratio_m);
+
+	if (!rc && (fields & ZL3073X_MB_REF_RATIO_N))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_RATIO_N, &mb->ratio_n);
+
+	if (!rc && (fields & ZL3073X_MB_REF_CONFIG))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_CONFIG, &mb->config);
+
+	if (!rc && (fields & ZL3073X_MB_REF_PHASE_OFFSET_COMP))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+				      &mb->phase_offset_comp);
+
+	if (!rc && (fields & ZL3073X_MB_REF_SYNC_CTRL))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_SYNC_CTRL,
+				      &mb->sync_ctrl);
+
+	if (!rc && (fields & ZL3073X_MB_REF_ESYNC_DIV))
+		rc = zl3073x_read_reg(zldev, ZL_REG_REF_ESYNC_DIV,
+				      &mb->esync_div);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_ref_read, "ZL3073X");
+
+/**
+ * zl3073x_mb_ref_write - write given reference configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ * @fields: mask of the mailbox fields to be written
+ * @mb: reference mailbox
+ *
+ * Writes selected fields from the mailbox into device.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			 const struct zl3073x_mb_ref *mb)
+{
+	int rc = 0;
+
+	if (fields & ZL3073X_MB_REF_FREQ_BASE)
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_FREQ_BASE,
+				       &mb->freq_base);
+
+	if (!rc && (fields & ZL3073X_MB_REF_FREQ_MULT))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_FREQ_MULT,
+				       &mb->freq_mult);
+
+	if (!rc && (fields & ZL3073X_MB_REF_RATIO_M))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_RATIO_M,
+				       &mb->ratio_m);
+
+	if (!rc && (fields & ZL3073X_MB_REF_RATIO_N))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_RATIO_N,
+				       &mb->ratio_n);
+
+	if (!rc && (fields & ZL3073X_MB_REF_CONFIG))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_CONFIG, &mb->config);
+
+	if (!rc && (fields & ZL3073X_MB_REF_PHASE_OFFSET_COMP))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+				       &mb->phase_offset_comp);
+
+	if (!rc && (fields & ZL3073X_MB_REF_SYNC_CTRL))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_SYNC_CTRL,
+				       &mb->sync_ctrl);
+
+	if (!rc && (fields & ZL3073X_MB_REF_ESYNC_DIV))
+		rc = zl3073x_write_reg(zldev, ZL_REG_REF_ESYNC_DIV,
+				       &mb->esync_div);
+
+	if (rc)
+		return rc;
+
+	return zl3073x_mb_cmd_do(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+				 ZL_REG_REF_MB_MASK, BIT(index));
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_ref_write, "ZL3073X");
+
+/**
+ * zl3073x_mb_synth_read - read given synth configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ * @fields: mask of the mailbox fields to be filled
+ * @mb: synth mailbox
+ *
+ * Reads selected configuration of given reference into synth mailbox.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			  struct zl3073x_mb_synth *mb)
+{
+	int rc;
+
+	rc = zl3073x_mb_cmd_do(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_RD,
+			       ZL_REG_SYNTH_MB_MASK, BIT(index));
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_BASE))
+		rc = zl3073x_read_reg(zldev, ZL_REG_SYNTH_FREQ_BASE,
+				      &mb->freq_base);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_MULT))
+		rc = zl3073x_read_reg(zldev, ZL_REG_SYNTH_FREQ_MULT,
+				      &mb->freq_mult);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_M))
+		rc = zl3073x_read_reg(zldev, ZL_REG_SYNTH_FREQ_M, &mb->freq_m);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_N))
+		rc = zl3073x_read_reg(zldev, ZL_REG_SYNTH_FREQ_N, &mb->freq_n);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_synth_read, "ZL3073X");
+
+/**
+ * zl3073x_mb_synth_write - write given synth configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ * @fields: mask of the mailbox fields to be written
+ * @mb: synth mailbox
+ *
+ * Writes selected fields from the mailbox into device.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			   struct zl3073x_mb_synth *mb)
+{
+	int rc = 0;
+
+	if (fields & ZL3073X_MB_SYNTH_FREQ_BASE)
+		rc = zl3073x_write_reg(zldev, ZL_REG_SYNTH_FREQ_BASE,
+				       &mb->freq_base);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_MULT))
+		rc = zl3073x_write_reg(zldev, ZL_REG_SYNTH_FREQ_MULT,
+				       &mb->freq_mult);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_M))
+		rc = zl3073x_write_reg(zldev, ZL_REG_SYNTH_FREQ_M, &mb->freq_m);
+
+	if (!rc && (fields & ZL3073X_MB_SYNTH_FREQ_N))
+		rc = zl3073x_write_reg(zldev, ZL_REG_SYNTH_FREQ_N, &mb->freq_n);
+
+	if (rc)
+		return rc;
+
+	return zl3073x_mb_cmd_do(zldev, ZL_REG_SYNTH_MB_SEM, ZL_SYNTH_MB_SEM_WR,
+				 ZL_REG_SYNTH_MB_MASK, BIT(index));
+}
+EXPORT_SYMBOL_NS_GPL(zl3073x_mb_synth_write, "ZL3073X");
+
 /**
  * zl3073x_devlink_info_get - Devlink device info callback
  * @devlink: devlink structure pointer
diff --git a/drivers/mfd/zl3073x-regs.h b/drivers/mfd/zl3073x-regs.h
index 3a8fcc860a6ea..a19f04c813cc6 100644
--- a/drivers/mfd/zl3073x-regs.h
+++ b/drivers/mfd/zl3073x-regs.h
@@ -71,4 +71,68 @@
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
 #define ZL_REG_CUSTOM_CONFIG_VER		ZL_REG(0, 0x07, 4)
 
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
+#define ZL_REG_REF_FREQ_BASE			ZL_REG(10, 0x05, 2)
+#define ZL_REG_REF_FREQ_MULT			ZL_REG(10, 0x07, 2)
+#define ZL_REG_REF_RATIO_M			ZL_REG(10, 0x09, 2)
+#define ZL_REG_REF_RATIO_N			ZL_REG(10, 0x0b, 2)
+#define ZL_REG_REF_CONFIG			ZL_REG(10, 0x0d, 1)
+#define ZL_REG_REF_PHASE_OFFSET_COMP		ZL_REG(10, 0x28, 6)
+#define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
+#define ZL_REG_REF_ESYNC_DIV			ZL_REG(10, 0x30, 4)
+
+/********************************
+ * Register Page 12, DPLL Mailbox
+ ********************************/
+
+#define ZL_REG_DPLL_MB_MASK			ZL_REG(12, 0x02, 2)
+
+#define ZL_REG_DPLL_MB_SEM			ZL_REG(12, 0x04, 1)
+#define ZL_DPLL_MB_SEM_WR			BIT(0)
+#define ZL_DPLL_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_DPLL_REF_PRIO(_idx)					\
+	ZL_REG_IDX(_idx, 12, 0x52, 1, ZL3073X_NUM_INPUTS / 2, 1)
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
+
+#define ZL_REG_OUTPUT_MB_MASK			ZL_REG(14, 0x02, 2)
+
+#define ZL_REG_OUTPUT_MB_SEM			ZL_REG(14, 0x04, 1)
+#define ZL_OUTPUT_MB_SEM_WR			BIT(0)
+#define ZL_OUTPUT_MB_SEM_RD			BIT(1)
+
+#define ZL_REG_OUTPUT_MODE			ZL_REG(14, 0x05, 1)
+#define ZL_REG_OUTPUT_DIV			ZL_REG(14, 0x0c, 4)
+#define ZL_REG_OUTPUT_WIDTH			ZL_REG(14, 0x10, 4)
+#define ZL_REG_OUTPUT_ESYNC_PERIOD		ZL_REG(14, 0x14, 4)
+#define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
+#define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
+
 #endif /* __ZL3073X_REGS_H */
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index ad5344a84b320..352cd0f2f64a4 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -8,6 +8,13 @@
 struct device;
 struct regmap;
 
+/*
+ * Hardware limits for ZL3073x chip family
+ */
+#define ZL3073X_NUM_INPUTS	10
+#define ZL3073X_NUM_OUTPUTS	10
+#define ZL3073X_NUM_SYNTHS	5
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
@@ -18,4 +25,138 @@ struct zl3073x_dev {
 	struct regmap		*regmap;
 };
 
+/*************************
+ * DPLL mailbox operations
+ *************************/
+
+/**
+ * struct zl3073x_mb_dpll - DPLL channel mailbox
+ * @ref_prio: array of input reference priorities
+ */
+struct zl3073x_mb_dpll {
+	u8	ref_prio[ZL3073X_NUM_INPUTS / 2]; /* 4bits per ref */
+#define ZL_DPLL_REF_PRIO_REF_P			GENMASK(3, 0)
+#define ZL_DPLL_REF_PRIO_REF_N			GENMASK(7, 4)
+#define ZL_DPLL_REF_PRIO_MAX			14
+#define ZL_DPLL_REF_PRIO_NONE			15
+};
+#define ZL3073X_MB_DPLL_REF_PRIO(_ref_pair)	BIT(_ref_pair)
+
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			 struct zl3073x_mb_dpll *mb);
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			  struct zl3073x_mb_dpll *mb);
+
+/***************************
+ * Output mailbox operations
+ ***************************/
+
+/**
+ * struct zl3073x_mb_output - output mailbox
+ * @mode: output mode
+ * @div: output divisor
+ * @width: output width
+ * @esync_period: embedded sync period
+ * @esync_width: embedded sync width
+ * @phase_comp: phase compensation
+ */
+struct zl3073x_mb_output {
+	u8	mode;				/* page 14, offset 0x05 */
+#define ZL_OUTPUT_MODE_CLOCK_TYPE		GENMASK(2, 0)
+#define ZL_OUTPUT_MODE_CLOCK_TYPE_NORMAL	0
+#define ZL_OUTPUT_MODE_CLOCK_TYPE_ESYNC		1
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
+	u32	div;				/* page 14, offset 0x0c */
+	u32	width;				/* page 14, offset 0x10 */
+	u32	esync_period;			/* page 14, offset 0x14 */
+	u32	esync_width;			/* page 14, offset 0x18 */
+	u32	phase_comp;			/* page 14, offset 0x20 */
+};
+#define ZL3073X_MB_OUTPUT_MODE			BIT(0)
+#define ZL3073X_MB_OUTPUT_DIV			BIT(1)
+#define ZL3073X_MB_OUTPUT_WIDTH			BIT(2)
+#define ZL3073X_MB_OUTPUT_ESYNC_PERIOD		BIT(3)
+#define ZL3073X_MB_OUTPUT_ESYNC_WIDTH		BIT(4)
+#define ZL3073X_MB_OUTPUT_PHASE_COMP		BIT(5)
+
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			   struct zl3073x_mb_output *output);
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			    const struct zl3073x_mb_output *output);
+
+/************************************
+ * Input reference mailbox operations
+ ************************************/
+
+/**
+ * struct zl3073x_mb_ref - input reference mailbox
+ * @freq_base: frequency base
+ * @freq_mult: frequency multiplier
+ * @ratio_m: FEC ratio numerator
+ * @ratio_n: FEC ratio denominator
+ * @config: reference configuration
+ * @phase_offset_comp: phase offset compensation
+ * @sync_ctrl: synchronization control
+ * @esync_div: embedded sync divisor
+ */
+struct zl3073x_mb_ref {
+	u16	freq_base;			/* page 10, offset 0x05 */
+	u16	freq_mult;			/* page 10, offset 0x07 */
+	u16	ratio_m;			/* page 10, offset 0x09 */
+	u16	ratio_n;			/* page 10, offset 0x0b */
+	u8	config;				/* page 10, offset 0x0d */
+#define ZL_REF_CONFIG_ENABLE			BIT(0)
+#define ZL_REF_CONFIG_DIFF_EN			BIT(2)
+	u64	phase_offset_comp;		/* page 10, offset 0x28 */
+	u8	sync_ctrl;			/* page 10, offset 0x2e */
+#define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
+#define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
+#define ZL_REF_SYNC_CTRL_MODE_50_50_ESYNC_25_75	2
+	u32	esync_div;			/* page 10, offset 0x30 */
+#define ZL_REF_ESYNC_DIV_1HZ			0
+};
+#define ZL3073X_MB_REF_FREQ_BASE		BIT(0)
+#define ZL3073X_MB_REF_FREQ_MULT		BIT(1)
+#define ZL3073X_MB_REF_RATIO_M			BIT(2)
+#define ZL3073X_MB_REF_RATIO_N			BIT(3)
+#define ZL3073X_MB_REF_CONFIG			BIT(4)
+#define ZL3073X_MB_REF_PHASE_OFFSET_COMP	BIT(5)
+#define ZL3073X_MB_REF_SYNC_CTRL		BIT(6)
+#define ZL3073X_MB_REF_ESYNC_DIV		BIT(7)
+
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			struct zl3073x_mb_ref *ref);
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			 const struct zl3073x_mb_ref *ref);
+
+/**************************
+ * Synth mailbox operations
+ **************************/
+
+struct zl3073x_mb_synth {
+	u16	freq_base;			/* page 13, offset 0x06 */
+	u32	freq_mult;			/* page 13, offset 0x08 */
+	u16	freq_m;				/* page 13, offset 0x0c */
+	u16	freq_n;				/* page 13, offset 0x0e */
+};
+#define ZL3073X_MB_SYNTH_FREQ_BASE		BIT(0)
+#define ZL3073X_MB_SYNTH_FREQ_MULT		BIT(1)
+#define ZL3073X_MB_SYNTH_FREQ_M			BIT(2)
+#define ZL3073X_MB_SYNTH_FREQ_N			BIT(3)
+
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			   struct zl3073x_mb_synth *mb);
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index, u32 fields,
+			   struct zl3073x_mb_synth *mb);
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.49.0


