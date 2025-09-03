Return-Path: <netdev+bounces-219521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D00B41B3A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2901BA5A60
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 10:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468AB2E9EA9;
	Wed,  3 Sep 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZWwrFiI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DBF2E92AB
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894160; cv=none; b=C+UBesMNbbEerFxaEp6mDFjrcU+ABPVsWHHK5DWZao4RKW0PpiOE0dSOWLqCmj5kkgL6ubYJByUKXbeNOOn/Bs8Qv/G+QvThO3jXZkN5Q/TmGBwphm7WddXYQOW5Q4Bxrp4cnGhMyyVsZH9kE67Z3y9yD3k5ag+JuQlByRjDC5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894160; c=relaxed/simple;
	bh=b82ajDop05IdDbcUMKm9fN2TJvEEDM0ySOGZFWzB/4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ng9vA3P9JhoOKKbrsvHqMI44CNCWJd2epQaxkgUFuT0K07z7yvi8ufnT8+02GhmVX4oIRNiDwk6wUG2jryGTM/fK6GpBBlHbGLonNpAHVCv5E4AV8oU/jcw6cJwLweijzbciqGa9myNKN4RATvwQmDUuzY+TYWLdFkNZJ0gK/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZWwrFiI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756894158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXuxoWe3GrTooKshAErrnfULyFsxqRpLqh5wpT+IGQ=;
	b=GZWwrFiIO0EYkImh3YV7UY5wsCBBQ2ojb6WxZ62usPaMy6TkvrEYaDJQDo8wupQbafIVjY
	3DJ97Pw9sLY5BGyE+fSQ1ttbhiYhgnq+cAlrZ1t4vcdLg22vkqVHfxjpAphwiFYbexfKgU
	HsnSkO93Qy6tLvjbZPcFCS5nETFNlt0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-6F-ftcZBMzWb0W0KGaQRbw-1; Wed,
 03 Sep 2025 06:09:14 -0400
X-MC-Unique: 6F-ftcZBMzWb0W0KGaQRbw-1
X-Mimecast-MFC-AGG-ID: 6F-ftcZBMzWb0W0KGaQRbw_1756894153
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0892419560BE;
	Wed,  3 Sep 2025 10:09:13 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.85])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E8FF1800576;
	Wed,  3 Sep 2025 10:09:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v4 1/5] dpll: zl3073x: Add functions to access hardware registers
Date: Wed,  3 Sep 2025 12:08:56 +0200
Message-ID: <20250903100900.8470-2-ivecera@redhat.com>
In-Reply-To: <20250903100900.8470-1-ivecera@redhat.com>
References: <20250903100900.8470-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Besides the device host registers that are directly accessible, there
are also hardware registers that can be accessed indirectly via specific
host registers.

Add register definitions for accessing hardware registers and provide
helper functions for working with them. Additionally, extend the number
of pages in the regmap configuration to 256, as the host registers used
for accessing hardware registers are located on page 255.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 155 +++++++++++++++++++++++++++++++++++-
 drivers/dpll/zl3073x/core.h |  30 +++++++
 drivers/dpll/zl3073x/regs.h |  12 +++
 3 files changed, 193 insertions(+), 4 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 7ebcfc5ec1f09..86c26edc90462 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -95,9 +95,9 @@ EXPORT_SYMBOL_NS_GPL(zl30735_chip_info, "ZL3073X");
 
 #define ZL_RANGE_OFFSET		0x80
 #define ZL_PAGE_SIZE		0x80
-#define ZL_NUM_PAGES		15
+#define ZL_NUM_PAGES		256
 #define ZL_PAGE_SEL		0x7F
-#define ZL_PAGE_SEL_MASK	GENMASK(3, 0)
+#define ZL_PAGE_SEL_MASK	GENMASK(7, 0)
 #define ZL_NUM_REGS		(ZL_NUM_PAGES * ZL_PAGE_SIZE)
 
 /* Regmap range configuration */
@@ -174,9 +174,10 @@ static bool
 zl3073x_check_reg(struct zl3073x_dev *zldev, unsigned int reg, size_t size)
 {
 	/* Check that multiop lock is held when accessing registers
-	 * from page 10 and above.
+	 * from page 10 and above except the page 255 that does not
+	 * need this protection.
 	 */
-	if (ZL_REG_PAGE(reg) >= 10)
+	if (ZL_REG_PAGE(reg) >= 10 && ZL_REG_PAGE(reg) < 255)
 		lockdep_assert_held(&zldev->multiop_lock);
 
 	/* Check the index is in valid range for indexed register */
@@ -446,6 +447,152 @@ int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
 	return zl3073x_poll_zero_u8(zldev, op_reg, op_val);
 }
 
+/**
+ * zl3073x_do_hwreg_op - Perform HW register read/write operation
+ * @zldev: zl3073x device pointer
+ * @op: operation to perform
+ *
+ * Performs requested operation and waits for its completion.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_do_hwreg_op(struct zl3073x_dev *zldev, u8 op)
+{
+	int rc;
+
+	/* Set requested operation and set pending bit */
+	rc = zl3073x_write_u8(zldev, ZL_REG_HWREG_OP, op | ZL_HWREG_OP_PENDING);
+	if (rc)
+		return rc;
+
+	/* Poll for completion - pending bit cleared */
+	return zl3073x_poll_zero_u8(zldev, ZL_REG_HWREG_OP,
+				    ZL_HWREG_OP_PENDING);
+}
+
+/**
+ * zl3073x_read_hwreg - Read HW register
+ * @zldev: zl3073x device pointer
+ * @addr: HW register address
+ * @value: Value of the HW register
+ *
+ * Reads HW register value and stores it into @value.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_read_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 *value)
+{
+	int rc;
+
+	/* Set address to read data from */
+	rc = zl3073x_write_u32(zldev, ZL_REG_HWREG_ADDR, addr);
+	if (rc)
+		return rc;
+
+	/* Perform the read operation */
+	rc = zl3073x_do_hwreg_op(zldev, ZL_HWREG_OP_READ);
+	if (rc)
+		return rc;
+
+	/* Read the received data */
+	return zl3073x_read_u32(zldev, ZL_REG_HWREG_READ_DATA, value);
+}
+
+/**
+ * zl3073x_write_hwreg - Write value to HW register
+ * @zldev: zl3073x device pointer
+ * @addr: HW registers address
+ * @value: Value to be written to HW register
+ *
+ * Stores the requested value into HW register.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_write_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 value)
+{
+	int rc;
+
+	/* Set address to write data to */
+	rc = zl3073x_write_u32(zldev, ZL_REG_HWREG_ADDR, addr);
+	if (rc)
+		return rc;
+
+	/* Set data to be written */
+	rc = zl3073x_write_u32(zldev, ZL_REG_HWREG_WRITE_DATA, value);
+	if (rc)
+		return rc;
+
+	/* Perform the write operation */
+	return zl3073x_do_hwreg_op(zldev, ZL_HWREG_OP_WRITE);
+}
+
+/**
+ * zl3073x_update_hwreg - Update certain bits in HW register
+ * @zldev: zl3073x device pointer
+ * @addr: HW register address
+ * @value: Value to be written into HW register
+ * @mask: Bitmask indicating bits to be updated
+ *
+ * Reads given HW register, updates requested bits specified by value and
+ * mask and writes result back to HW register.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_update_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 value,
+			 u32 mask)
+{
+	u32 tmp;
+	int rc;
+
+	rc = zl3073x_read_hwreg(zldev, addr, &tmp);
+	if (rc)
+		return rc;
+
+	tmp &= ~mask;
+	tmp |= value & mask;
+
+	return zl3073x_write_hwreg(zldev, addr, tmp);
+}
+
+/**
+ * zl3073x_write_hwreg_seq - Write HW registers sequence
+ * @zldev: pointer to device structure
+ * @seq: pointer to first sequence item
+ * @num_items: number of items in sequence
+ *
+ * Writes given HW registers sequence.
+ *
+ * Return: 0 on success, <0 on error
+ */
+int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
+			    const struct zl3073x_hwreg_seq_item *seq,
+			    size_t num_items)
+{
+	int i, rc = 0;
+
+	for (i = 0; i < num_items; i++) {
+		dev_dbg(zldev->dev, "Write 0x%0x [0x%0x] to 0x%0x",
+			seq[i].value, seq[i].mask, seq[i].addr);
+
+		if (seq[i].mask == U32_MAX)
+			/* Write value directly */
+			rc = zl3073x_write_hwreg(zldev, seq[i].addr,
+						 seq[i].value);
+		else
+			/* Update only bits specified by the mask */
+			rc = zl3073x_update_hwreg(zldev, seq[i].addr,
+						  seq[i].value, seq[i].mask);
+		if (rc)
+			return rc;
+
+		if (seq->wait)
+			msleep(seq->wait);
+	}
+
+	return rc;
+}
+
 /**
  * zl3073x_ref_state_fetch - get input reference state
  * @zldev: pointer to zl3073x_dev structure
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index 71af2c8001109..16e750d77e1dd 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -3,6 +3,7 @@
 #ifndef _ZL3073X_CORE_H
 #define _ZL3073X_CORE_H
 
+#include <linux/bitfield.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -115,6 +116,28 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
  * Registers operations
  **********************/
 
+/**
+ * struct zl3073x_hwreg_seq_item - HW register write sequence item
+ * @addr: HW register to be written
+ * @value: value to be written to HW register
+ * @mask: bitmask indicating bits to be updated
+ * @wait: number of ms to wait after register write
+ */
+struct zl3073x_hwreg_seq_item {
+	u32	addr;
+	u32	value;
+	u32	mask;
+	u32	wait;
+};
+
+#define HWREG_SEQ_ITEM(_addr, _value, _mask, _wait)	\
+{							\
+	.addr	= _addr,				\
+	.value	= FIELD_PREP_CONST(_mask, _value),	\
+	.mask	= _mask,				\
+	.wait	= _wait,				\
+}
+
 int zl3073x_mb_op(struct zl3073x_dev *zldev, unsigned int op_reg, u8 op_val,
 		  unsigned int mask_reg, u16 mask_val);
 int zl3073x_poll_zero_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 mask);
@@ -126,6 +149,13 @@ int zl3073x_write_u8(struct zl3073x_dev *zldev, unsigned int reg, u8 val);
 int zl3073x_write_u16(struct zl3073x_dev *zldev, unsigned int reg, u16 val);
 int zl3073x_write_u32(struct zl3073x_dev *zldev, unsigned int reg, u32 val);
 int zl3073x_write_u48(struct zl3073x_dev *zldev, unsigned int reg, u64 val);
+int zl3073x_read_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 *value);
+int zl3073x_write_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 value);
+int zl3073x_update_hwreg(struct zl3073x_dev *zldev, u32 addr, u32 value,
+			 u32 mask);
+int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
+			    const struct zl3073x_hwreg_seq_item *seq,
+			    size_t num_items);
 
 /*****************
  * Misc operations
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 614e33128a5c9..80922987add34 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -260,4 +260,16 @@
 #define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
 #define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
 
+/*
+ * Register Page 255 - HW registers access
+ */
+#define ZL_REG_HWREG_OP				ZL_REG(0xff, 0x00, 1)
+#define ZL_HWREG_OP_WRITE			0x28
+#define ZL_HWREG_OP_READ			0x29
+#define ZL_HWREG_OP_PENDING			BIT(1)
+
+#define ZL_REG_HWREG_ADDR			ZL_REG(0xff, 0x04, 4)
+#define ZL_REG_HWREG_WRITE_DATA			ZL_REG(0xff, 0x08, 4)
+#define ZL_REG_HWREG_READ_DATA			ZL_REG(0xff, 0x0c, 4)
+
 #endif /* _ZL3073X_REGS_H */
-- 
2.49.1


