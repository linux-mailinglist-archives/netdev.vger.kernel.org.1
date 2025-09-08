Return-Path: <netdev+bounces-220763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD618B488B8
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 11:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD5188B85E
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37CF2F5485;
	Mon,  8 Sep 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b09KME4s"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83612F28E0
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324382; cv=none; b=OUm01CAYQy4kX3bDTRo1ILZ3V3wPeHxDwpi4tYOx7bHyaXF5S6ldAOUzoEmsMaYNofHphtvHiN0kqBWufHhURsAGrVIVYxGG2pI9VTXQUUCzwrRpyXw2KSgKsaC+Hd/9zU5lz0sY1tPFmeLrN19smxBu7KeC05QUJgj8j8Y1v9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324382; c=relaxed/simple;
	bh=n3YPv+oYDZZIdXzu+wyT67oJqYkMcpblrHmfvOruekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+j1F3w3i3YUKd4C8atuvSqSP08O3eRcppUlO0Q/Jgy231JAO5NiEcgr0zPF+Ya9kABlwSMBOvDXrNJdUpoUJ1MRyalibOjbA2C4um0TCtxBSzjEId2eScmskU1WVTwTx0VYkWsDNJ8jSvnom0qFrPZlf65SHIKMInKPEhncTbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b09KME4s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757324379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1tiVp78x5covZnU7YFK4xGYliLhhtlLPs5SUPtmJk=;
	b=b09KME4sWVE2bDYESWjOH7oJ11wEcy2QHrCeFRPShL7UnMVQb/eO2q6dH6SwV4smrgJvVD
	MJby1G951S9s/4b++2KqiW/vUgABZHs3EDc/wxEgz2LvKQzUbl3nLZcGnKsWcV82+Pzokq
	eEMB/NgzJ8V37sd5kRrSpiea5FEccYk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-XgSk6HNpOK-zLjZ3GPpQJg-1; Mon,
 08 Sep 2025 05:39:37 -0400
X-MC-Unique: XgSk6HNpOK-zLjZ3GPpQJg-1
X-Mimecast-MFC-AGG-ID: XgSk6HNpOK-zLjZ3GPpQJg_1757324375
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E4D61956089;
	Mon,  8 Sep 2025 09:39:35 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.31])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2ABDB18003FC;
	Mon,  8 Sep 2025 09:39:30 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
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
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v5 1/5] dpll: zl3073x: Add functions to access hardware registers
Date: Mon,  8 Sep 2025 11:39:20 +0200
Message-ID: <20250908093924.1952317-2-ivecera@redhat.com>
In-Reply-To: <20250908093924.1952317-1-ivecera@redhat.com>
References: <20250908093924.1952317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Besides the device host registers that are directly accessible, there
are also hardware registers that can be accessed indirectly via specific
host registers.

Add register definitions for accessing hardware registers and provide
helper functions for working with them. Additionally, extend the number
of pages in the regmap configuration to 256, as the host registers used
for accessing hardware registers are located on page 255.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
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


