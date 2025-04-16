Return-Path: <netdev+bounces-183386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748F5A908B3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F753A8A82
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 16:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C06E215063;
	Wed, 16 Apr 2025 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyiER6c7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22ECF212B13
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820548; cv=none; b=bfUQHXtFEvYpvRw1kItSCe52VI56i5j10fdMHojKo1QuBIjlM2phvlvaifCHLlvT257J8+SKlGf+eMq/iwwA3oh9lRonK8WChr+Bztf+gxPI4cj/V90yWe/o9YhfZX5BglQVXKn4X52hzxEZz/kDzrWS8dHXt4+p9qvrH4Lm3j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820548; c=relaxed/simple;
	bh=AlVk1jARPDtF+JXxxt8g+SSWreLxNZwTAeaiMpuL/DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjHm2mXDCLHv82VSolHAowCGE8hxkiJbu//EYU852udDmrmaSmLzVXZqi00Gor9uQGCPNXSzVw1XjeTIztjcZc8TBTyhcDvt0VnG2q1OzYQNBKJhojyPGotAdHljyFTJdQ/83KldAiqUA2sACy59mif3N+JmMnl8J4MRl+sKrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyiER6c7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744820544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QZOMbzNzCnYqOD/Fg32EUBdQRRFhbTfULTEXRMpBSck=;
	b=LyiER6c7RKJbg11ZfFk9Jo3th+x4/kMjW719ZUdcFuL10aIEX8DZsv+RNdTmDyqRnxNR3Y
	wHEzyJfgALpVKxhQ+XN32vaAWNTl6nCIFjaDB8fzFymCOUxHm6faaDGjP8idsgX+pe9X4n
	ZFns7jvZVoDW8RPp+uXjt5jkysMaw6Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-0oA8FA39NWii0mJVFvkF1w-1; Wed,
 16 Apr 2025 12:22:20 -0400
X-MC-Unique: 0oA8FA39NWii0mJVFvkF1w-1
X-Mimecast-MFC-AGG-ID: 0oA8FA39NWii0mJVFvkF1w_1744820538
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C32219560A7;
	Wed, 16 Apr 2025 16:22:18 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7DBF71801765;
	Wed, 16 Apr 2025 16:22:13 +0000 (UTC)
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
Subject: [PATCH v3 net-next 5/8] mfd: zl3073x: Add functions to work with register mailboxes
Date: Wed, 16 Apr 2025 18:21:41 +0200
Message-ID: <20250416162144.670760-6-ivecera@redhat.com>
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

Registers present in page 10 and higher are called mailbox type
registers. Each page represents a mailbox and is used to read and write
configuration of particular object (dpll, output, reference & synth).

The mailbox page contains mask register that is used to select an index of
requested object to work with and semaphore register to indicate what
operation is requested.

The rest of registers in the particular register page are latch
registers that are filled by the firmware during read operation or by
the driver prior write operation.

For read operation the driver...
1) ... updates the mailbox mask register with index of particular object
2) ... sets the mailbox semaphore register read bit
3) ... waits for the semaphore register read bit to be cleared by FW
4) ... reads the configuration from latch registers

For write operation the driver...
1) ... writes the requested configuration to latch registers
2) ... sets the mailbox mask register for the DPLL to be updated
3) ... sets the mailbox semaphore register bit for the write operation
4) ... waits for the semaphore register bit to be cleared by FW

Add functions to read and write mailboxes for all supported object types.

All these functions as well as functions accessing mailbox latch registers
(zl3073x_mb_* functions) have to be called with zl3073x_dev->mailbox_lock
held and a caller is responsible to take this lock.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
v1->v3:
* dropped ZL3073X_MB_OP macro usage
---
 drivers/mfd/zl3073x-core.c       | 232 +++++++++++++++++++++++
 include/linux/mfd/zl3073x.h      |  12 ++
 include/linux/mfd/zl3073x_regs.h | 304 +++++++++++++++++++++++++++++++
 3 files changed, 548 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 8a15237e0f731..3d18786c769d2 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -115,6 +115,238 @@ static const struct regmap_config zl3073x_regmap_config = {
 	.volatile_reg	= zl3073x_is_volatile_reg,
 };
 
+/**
+ * zl3073x_mb_dpll_read - read given DPLL configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ *
+ * Reads configuration of given DPLL into DPLL mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_dpll_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_dpll_mb_sem(zldev, ZL_DPLL_MB_SEM_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_dpll_mb_sem(zldev, ZL_DPLL_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_dpll_read);
+
+/**
+ * zl3073x_mb_dpll_write - write given DPLL configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: DPLL index
+ *
+ * Writes (commits) configuration of given DPLL from DPLL mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_dpll_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_dpll_mb_sem(zldev, ZL_DPLL_MB_SEM_WR);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_dpll_mb_sem(zldev, ZL_DPLL_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_dpll_write);
+
+/**
+ * zl3073x_mb_output_read - read given output configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: output index
+ *
+ * Reads configuration of given output into output mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_output_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_output_mb_sem(zldev, ZL_OUTPUT_MB_SEM_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_output_mb_sem(zldev, ZL_OUTPUT_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_output_read);
+
+/**
+ * zl3073x_mb_output_write - write given output configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: output index
+ *
+ * Writes (commits) configuration of given output from output mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_output_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_output_mb_sem(zldev, ZL_OUTPUT_MB_SEM_WR);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_output_mb_sem(zldev, ZL_OUTPUT_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_output_write);
+
+/**
+ * zl3073x_mb_ref_read - read given reference configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ *
+ * Reads configuration of given reference into ref mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_ref_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_ref_mb_sem(zldev, ZL_REF_MB_SEM_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_ref_mb_sem(zldev, ZL_REF_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_ref_read);
+
+/**
+ * zl3073x_mb_ref_write - write given reference configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: reference index
+ *
+ * Writes (commits) configuration of given reference from ref mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_ref_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_ref_mb_sem(zldev, ZL_REF_MB_SEM_WR);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_ref_mb_sem(zldev, ZL_REF_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_ref_write);
+
+/**
+ * zl3073x_mb_synth_read - read given synth configuration to mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ *
+ * Reads configuration of given synth into synth mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_synth_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_synth_mb_sem(zldev, ZL_SYNTH_MB_SEM_RD);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_synth_mb_sem(zldev, ZL_SYNTH_MB_SEM_RD);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_synth_read);
+
+/**
+ * zl3073x_mb_synth_write - write given synth configuration from mailbox
+ * @zldev: pointer to device structure
+ * @index: synth index
+ *
+ * Writes (commits) configuration of given synth from synth mailbox.
+ *
+ * Context: Process context. Expects zldev->regmap_lock to be held by caller.
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index)
+{
+	int rc;
+
+	/* Select requested index in mask register */
+	rc = zl3073x_mb_write_synth_mb_mask(zldev, BIT(index));
+	if (rc)
+		return rc;
+
+	/* Perform read operation */
+	rc = zl3073x_mb_write_synth_mb_sem(zldev, ZL_SYNTH_MB_SEM_WR);
+	if (rc)
+		return rc;
+
+	/* Wait for the command to actually finish */
+	return zl3073x_mb_poll_synth_mb_sem(zldev, ZL_SYNTH_MB_SEM_WR);
+}
+EXPORT_SYMBOL_GPL(zl3073x_mb_synth_write);
+
 /**
  * zl3073x_devlink_info_get - Devlink device info callback
  * @devlink: devlink structure pointer
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index b68481dcf77a5..53813a8c39660 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -47,4 +47,16 @@ static inline void zl3073x_mailbox_unlock(struct zl3073x_dev *zldev)
 DEFINE_GUARD(zl3073x_mailbox, struct zl3073x_dev *, zl3073x_mailbox_lock(_T),
 	     zl3073x_mailbox_unlock(_T));
 
+/*
+ * Mailbox operations
+ */
+int zl3073x_mb_dpll_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_dpll_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_output_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_output_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_ref_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_ref_write(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_synth_read(struct zl3073x_dev *zldev, u8 index);
+int zl3073x_mb_synth_write(struct zl3073x_dev *zldev, u8 index);
+
 #endif /* __LINUX_MFD_ZL3073X_H */
diff --git a/include/linux/mfd/zl3073x_regs.h b/include/linux/mfd/zl3073x_regs.h
index 453a5da8ac63f..d155650349c97 100644
--- a/include/linux/mfd/zl3073x_regs.h
+++ b/include/linux/mfd/zl3073x_regs.h
@@ -15,6 +15,10 @@
 #define ZL_PAGE_SIZE	       0x80
 #define ZL_REG_ADDR(_pg, _off) (ZL_RANGE_OFF + (_pg) * ZL_PAGE_SIZE + (_off))
 
+/* Register polling sleep & timeout */
+#define ZL_POLL_SLEEP_US   10
+#define ZL_POLL_TIMEOUT_US 2000000
+
 /**************************
  * Register Page 0, General
  **************************/
@@ -102,4 +106,304 @@ zl3073x_read_custom_config_ver(struct zl3073x_dev *zldev, u32 *value)
 	return rc;
 }
 
+/*******************************
+ * Register Page 10, Ref Mailbox
+ *******************************/
+
+/*
+ * Register 'ref_mb_mask'
+ * Page: 10, Offset: 0x02, Size: 16 bits
+ */
+#define ZL_REG_REF_MB_MASK ZL_REG_ADDR(10, 0x02)
+
+static inline __maybe_unused int
+zl3073x_mb_read_ref_mb_mask(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_ref_mb_mask(struct zl3073x_dev *zldev, u16 value)
+{
+	__be16 temp;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	temp = cpu_to_be16(value);
+	return regmap_bulk_write(zldev->regmap, ZL_REG_REF_MB_MASK, &temp,
+				 sizeof(temp));
+}
+
+/*
+ * Register 'ref_mb_sem'
+ * Page: 10, Offset: 0x04, Size: 8 bits
+ */
+#define ZL_REG_REF_MB_SEM ZL_REG_ADDR(10, 0x04)
+#define ZL_REF_MB_SEM_WR  BIT(0)
+#define ZL_REF_MB_SEM_RD  BIT(1)
+
+static inline __maybe_unused int
+zl3073x_mb_read_ref_mb_sem(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_REF_MB_SEM, &v);
+	*value = v;
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_ref_mb_sem(struct zl3073x_dev *zldev, u8 value)
+{
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_write(zldev->regmap, ZL_REG_REF_MB_SEM, value);
+}
+
+static inline __maybe_unused int
+zl3073x_mb_poll_ref_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
+{
+	unsigned int v;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_read_poll_timeout(zldev->regmap, ZL_REG_REF_MB_SEM, v,
+					!(v & bitmask), ZL_POLL_SLEEP_US,
+					ZL_POLL_TIMEOUT_US);
+}
+
+/********************************
+ * Register Page 12, DPLL Mailbox
+ ********************************/
+
+/*
+ * Register 'dpll_mb_mask'
+ * Page: 12, Offset: 0x02, Size: 16 bits
+ */
+#define ZL_REG_DPLL_MB_MASK ZL_REG_ADDR(12, 0x02)
+
+static inline __maybe_unused int
+zl3073x_mb_read_dpll_mb_mask(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_DPLL_MB_MASK, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_dpll_mb_mask(struct zl3073x_dev *zldev, u16 value)
+{
+	__be16 temp;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	temp = cpu_to_be16(value);
+	return regmap_bulk_write(zldev->regmap, ZL_REG_DPLL_MB_MASK, &temp,
+				 sizeof(temp));
+}
+
+/*
+ * Register 'dpll_mb_sem'
+ * Page: 12, Offset: 0x04, Size: 8 bits
+ */
+#define ZL_REG_DPLL_MB_SEM ZL_REG_ADDR(12, 0x04)
+#define ZL_DPLL_MB_SEM_WR  BIT(0)
+#define ZL_DPLL_MB_SEM_RD  BIT(1)
+
+static inline __maybe_unused int
+zl3073x_mb_read_dpll_mb_sem(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_DPLL_MB_SEM, &v);
+	*value = v;
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_dpll_mb_sem(struct zl3073x_dev *zldev, u8 value)
+{
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_write(zldev->regmap, ZL_REG_DPLL_MB_SEM, value);
+}
+
+static inline __maybe_unused int
+zl3073x_mb_poll_dpll_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
+{
+	unsigned int v;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_read_poll_timeout(zldev->regmap, ZL_REG_DPLL_MB_SEM, v,
+					!(v & bitmask), ZL_POLL_SLEEP_US,
+					ZL_POLL_TIMEOUT_US);
+}
+
+/*********************************
+ * Register Page 13, Synth Mailbox
+ *********************************/
+
+/*
+ * Register 'synth_mb_mask'
+ * Page: 13, Offset: 0x02, Size: 16 bits
+ */
+#define ZL_REG_SYNTH_MB_MASK ZL_REG_ADDR(13, 0x02)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_mb_mask(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_SYNTH_MB_MASK, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_synth_mb_mask(struct zl3073x_dev *zldev, u16 value)
+{
+	__be16 temp;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	temp = cpu_to_be16(value);
+	return regmap_bulk_write(zldev->regmap, ZL_REG_SYNTH_MB_MASK, &temp,
+				 sizeof(temp));
+}
+
+/*
+ * Register 'synth_mb_sem'
+ * Page: 13, Offset: 0x04, Size: 8 bits
+ */
+#define ZL_REG_SYNTH_MB_SEM ZL_REG_ADDR(13, 0x04)
+#define ZL_SYNTH_MB_SEM_WR  BIT(0)
+#define ZL_SYNTH_MB_SEM_RD  BIT(1)
+
+static inline __maybe_unused int
+zl3073x_mb_read_synth_mb_sem(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_SYNTH_MB_SEM, &v);
+	*value = v;
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_synth_mb_sem(struct zl3073x_dev *zldev, u8 value)
+{
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_write(zldev->regmap, ZL_REG_SYNTH_MB_SEM, value);
+}
+
+static inline __maybe_unused int
+zl3073x_mb_poll_synth_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
+{
+	unsigned int v;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_read_poll_timeout(zldev->regmap, ZL_REG_SYNTH_MB_SEM, v,
+					!(v & bitmask), ZL_POLL_SLEEP_US,
+					ZL_POLL_TIMEOUT_US);
+}
+
+/**********************************
+ * Register Page 14, Output Mailbox
+ **********************************/
+
+/*
+ * Register 'output_mb_mask'
+ * Page: 14, Offset: 0x02, Size: 16 bits
+ */
+#define ZL_REG_OUTPUT_MB_MASK ZL_REG_ADDR(14, 0x02)
+
+static inline __maybe_unused int
+zl3073x_mb_read_output_mb_mask(struct zl3073x_dev *zldev, u16 *value)
+{
+	__be16 temp;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_bulk_read(zldev->regmap, ZL_REG_OUTPUT_MB_MASK, &temp,
+			      sizeof(temp));
+	if (rc)
+		return rc;
+
+	*value = be16_to_cpu(temp);
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_output_mb_mask(struct zl3073x_dev *zldev, u16 value)
+{
+	__be16 temp;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	temp = cpu_to_be16(value);
+	return regmap_bulk_write(zldev->regmap, ZL_REG_OUTPUT_MB_MASK, &temp,
+				 sizeof(temp));
+}
+
+/*
+ * Register 'output_mb_sem'
+ * Page: 14, Offset: 0x04, Size: 8 bits
+ */
+#define ZL_REG_OUTPUT_MB_SEM ZL_REG_ADDR(14, 0x04)
+#define ZL_OUTPUT_MB_SEM_WR  BIT(0)
+#define ZL_OUTPUT_MB_SEM_RD  BIT(1)
+
+static inline __maybe_unused int
+zl3073x_mb_read_output_mb_sem(struct zl3073x_dev *zldev, u8 *value)
+{
+	unsigned int v;
+	int rc;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	rc = regmap_read(zldev->regmap, ZL_REG_OUTPUT_MB_SEM, &v);
+	*value = v;
+	return rc;
+}
+
+static inline __maybe_unused int
+zl3073x_mb_write_output_mb_sem(struct zl3073x_dev *zldev, u8 value)
+{
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_write(zldev->regmap, ZL_REG_OUTPUT_MB_SEM, value);
+}
+
+static inline __maybe_unused int
+zl3073x_mb_poll_output_mb_sem(struct zl3073x_dev *zldev, u8 bitmask)
+{
+	unsigned int v;
+
+	lockdep_assert_held(&zldev->mailbox_lock);
+	return regmap_read_poll_timeout(zldev->regmap, ZL_REG_OUTPUT_MB_SEM, v,
+					!(v & bitmask), ZL_POLL_SLEEP_US,
+					ZL_POLL_TIMEOUT_US);
+}
+
 #endif /* __LINUX_MFD_ZL3073X_REGS_H */
-- 
2.48.1


