Return-Path: <netdev+bounces-179790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E25A7E85F
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47223BB72D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F02376EA;
	Mon,  7 Apr 2025 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eeXnWYbs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E79216E01
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744046994; cv=none; b=CzltE9qeFLJgmxHSnxvsWqDAiJyp7jKvNQP97FDSsch52fttPeOg9Z6uHmdzb227Dotb2Y2c0nrxQFw5sa++rBp1QsGrCcESO8IfxldNIoH/KGSil/Dda9/eodUMZIPRGLcjL21rdSohcEGODWZ/HguHY9DyG3pIOGq2feK6OhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744046994; c=relaxed/simple;
	bh=NWd2OapoEvDMUrXT+lsTD9tEGOgeTdX0z2/0E0iGGEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FktCxNUZHHkvpkZn913GtFU2g6s1ib0Rga8u4cW9Rz4a+bx/2X9X/UdRQrkeQjzLRzPrzKBonUy/xUPVtvp6TL5roYo0IiV/dDxSryG0SG1DtQU8l/PyTzr/aa6Mypx9y4+ELWwGsZ68h3qMYTOCkdAVcFHYppvVoxMWgro/xLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eeXnWYbs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744046991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nJdQzKKxcevh2Oe2aNeMatSmfz2Nc+4P0kNC4x5l3HU=;
	b=eeXnWYbsPeZ7ThNDkaOskQtp78yD0y7laPz8RwPbgaPmPRkcvgtFXebTAmwyv0lvq62YbY
	lgOMGSFRVIAMf20c95g22385veX3qpP7zuRA5JdqqV/yBCY2cYIa8i3KR6N7FoIWtM3ymE
	2J97Ri1/3Il9tzPBwApzj0wuAO0OWoA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-a73XDGXGMz2M0mSaS5c-tw-1; Mon,
 07 Apr 2025 13:29:11 -0400
X-MC-Unique: a73XDGXGMz2M0mSaS5c-tw-1
X-Mimecast-MFC-AGG-ID: a73XDGXGMz2M0mSaS5c-tw_1744046949
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5858119560B0;
	Mon,  7 Apr 2025 17:29:09 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 62736180A803;
	Mon,  7 Apr 2025 17:29:03 +0000 (UTC)
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
Subject: [PATCH 04/28] mfd: zl3073x: Add macros for device registers access
Date: Mon,  7 Apr 2025 19:28:31 +0200
Message-ID: <20250407172836.1009461-5-ivecera@redhat.com>
In-Reply-To: <20250407172836.1009461-1-ivecera@redhat.com>
References: <20250407172836.1009461-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add several macros to access device registers. These macros
defines a couple of static inline functions to ease an access
device registers. There are two types of registers, the 1st type
is a simple one that is defined by an address and size and the 2nd
type is indexed register that is defined by base address, type,
number of register instances and address stride between instances.

Examples:
__ZL3073X_REG_DEF(reg1, 0x1234, 4, u32);
__ZL3073X_REG_IDX_DEF(idx_reg2, 0x1234, 2, u16, 4, 0x10);

this defines the following functions:
int zl3073x_read_reg1(struct zl3073x_dev *dev, u32 *value);
int zl3073x_write_reg1(struct zl3073x_dev *dev, u32 value);
int zl3073x_read_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
                          u32 *value);
int zl3073x_write_idx_reg2(struct zl3073x_dev *dev, unsigned int idx,
                           u32 value);

There are also several shortcut macros to define registers with
certain bit widths: 8, 16, 32 and 48 bits.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/mfd/zl3073x.h | 99 +++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 0156f9044d79d..3524426f0e3ba 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -44,4 +44,103 @@ int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
 int zl3073x_write_reg(struct zl3073x_dev *zldev, unsigned int reg,
 		      unsigned int len, const void *value);
 
+/**
+ * __ZL3073X_REG_DEF - Define a device register helpers
+ * @_name: register name
+ * @_addr: register address
+ * @_len: size of register value in bytes
+ * @_type: type of register value
+ *
+ * The macro defines helper functions for particular device register
+ * to access it.
+ *
+ * Example:
+ * __ZL3073X_REG_DEF(sample_reg, 0x1234, 4, u32)
+ *
+ * generates static inline functions:
+ * int zl3073x_read_sample_reg(struct zl3073x_dev *dev, u32 *value);
+ * int zl3073x_write_sample_reg(struct zl3073x_dev *dev, u32 value);
+ *
+ * Note that these functions have to be called with the device lock
+ * taken.
+ */
+#define __ZL3073X_REG_DEF(_name, _addr, _len, _type)			\
+typedef _type zl3073x_##_name##_t;					\
+static inline								\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, _type * value)	\
+{									\
+	return zl3073x_read_reg(zldev, _addr, _len, value);		\
+}									\
+static inline								\
+int zl3073x_write_##_name(struct zl3073x_dev *zldev, _type value)	\
+{									\
+	return zl3073x_write_reg(zldev, _addr, _len, &value);		\
+}
+
+/**
+ * __ZL3073X_REG_IDX_DEF - Define an indexed device register helpers
+ * @_name: register name
+ * @_addr: register address
+ * @_len: size of register value in bytes
+ * @_type: type of register value
+ * @_num: number of register instances
+ * @_stride: address stride between instances
+ *
+ * The macro defines helper functions for particular indexed device
+ * register to access it.
+ *
+ * Example:
+ * __ZL3073X_REG_IDX_DEF(sample_reg, 0x1234, 2, u16, 4, 0x10)
+ *
+ * generates static inline functions:
+ * int zl3073x_read_sample_reg(struct zl3073x_dev *dev, unsigned int idx,
+ *			       u32 *value);
+ * int zl3073x_write_sample_reg(struct zl3073x_dev *dev, unsigned int idx,
+ *				u32 value);
+ *
+ * Note that these functions have to be called with the device lock
+ * taken.
+ */
+#define __ZL3073X_REG_IDX_DEF(_name, _addr, _len, _type, _num, _stride)	\
+typedef _type zl3073x_##_name##_t;					\
+static inline								\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
+			 _type * value)					\
+{									\
+	WARN_ON(idx >= (_num));						\
+	return zl3073x_read_reg(zldev, (_addr) + idx * (_stride), _len,	\
+				value);					\
+}									\
+static inline								\
+int zl3073x_write_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
+			  _type value)					\
+{									\
+	WARN_ON(idx >= (_num));						\
+	return zl3073x_write_reg(zldev, (_addr) + idx * (_stride),	\
+				 _len, &value);				\
+}
+
+/*
+ * Add register definition shortcuts for 8, 16, 32 and 48 bits
+ */
+#define ZL3073X_REG8_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 1, u8)
+#define ZL3073X_REG16_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 2, u16)
+#define ZL3073X_REG32_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 4, u32)
+#define ZL3073X_REG48_DEF(_name, _addr)	__ZL3073X_REG_DEF(_name, _addr, 6, u64)
+
+/*
+ * Add indexed register definition shortcuts for 8, 16, 32 and 48 bits
+ */
+#define ZL3073X_REG8_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 1, u8, _num, _stride)
+
+#define ZL3073X_REG16_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 2, u16, _num, _stride)
+
+#define ZL3073X_REG32_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 4, u32, _num, _stride)
+
+#define ZL3073X_REG48_IDX_DEF(_name, _addr, _num, _stride)		\
+	__ZL3073X_REG_IDX_DEF(_name, _addr, 6, u64, _num, _stride)
+
 #endif /* __LINUX_MFD_ZL3073X_H */
-- 
2.48.1


