Return-Path: <netdev+bounces-180802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9C6A828BF
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5F28C526F
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD79269825;
	Wed,  9 Apr 2025 14:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PpmakOyk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6398269806
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 14:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209814; cv=none; b=c2g19GvfcOygYGFh2jDX7T6hKkMfd/hq7mvWrkI0VOpsfBul2q/O8/hanY4i5agPsM43CzAQEq2KGwcpM8+dkiQUcFqhTYmLj06LSdRDpuVHE7VbYXneSSSsWOA6lXmT4OJA2FOLsCU+LIXBh/ygvGLQubU7LrXXpSTJnMJuqLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209814; c=relaxed/simple;
	bh=DfAET7jhcBW6N8PdXpG1Kmkl/JoBkhmbtQRFfdL7RuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZF0zWtReZU5sJnsmo876PORgujV5/l5IKo6tKgaRw1w0fJD09WWuz1BL7TfYJHjkUobyrkvFPYqPIv7Gm2k/rMvZMi/dSolpv8fZvZeABFPukvr7KgKlQmN3OvZ8vcVS6iwxmUnAfMP3GMws5532izXtArnmTuZn6NvIIQM1I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PpmakOyk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744209811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QsqtwLh0/EsvyJRseyAyykMgGD9f8bdjnDSkTDZJdEA=;
	b=PpmakOyk80N1o5p5kKyyty1ssK0gd1jY7L257mQ1AO/Nx2n9ItumiHTFMElwAxXE3pHuQB
	vHxqxAAXUV/e8r643D61Lm3J4gZIGpWuNDVeZbu3gyLw56qrQQJPnEPZf35gPeWmwPEh1c
	bYaT8C2Lmn3pECyokrI7XrYSHK7hAl8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-1z22zYYcM_eaO7uaGBbB5A-1; Wed,
 09 Apr 2025 10:43:28 -0400
X-MC-Unique: 1z22zYYcM_eaO7uaGBbB5A-1
X-Mimecast-MFC-AGG-ID: 1z22zYYcM_eaO7uaGBbB5A_1744209806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A85D19560AB;
	Wed,  9 Apr 2025 14:43:26 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.72])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03BC01801747;
	Wed,  9 Apr 2025 14:43:21 +0000 (UTC)
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
Subject: [PATCH v2 06/14] mfd: zl3073x: Add macros for device registers access
Date: Wed,  9 Apr 2025 16:42:42 +0200
Message-ID: <20250409144250.206590-7-ivecera@redhat.com>
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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 include/linux/mfd/zl3073x.h | 100 ++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 00dcc73aeeb34..405a66a7b3e78 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_MFD_ZL3073X_H
 #define __LINUX_MFD_ZL3073X_H
 
+#include <linux/bug.h>
 #include <linux/cleanup.h>
 #include <linux/mutex.h>
 
@@ -53,4 +54,103 @@ int zl3073x_read_reg(struct zl3073x_dev *zldev, unsigned int reg,
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
+static inline __maybe_unused						\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, _type * value)	\
+{									\
+	return zl3073x_read_reg(zldev, _addr, _len, value);		\
+}									\
+static inline __maybe_unused						\
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
+static inline __maybe_unused						\
+int zl3073x_read_##_name(struct zl3073x_dev *zldev, unsigned int idx,	\
+			 _type * value)					\
+{									\
+	WARN_ON(idx >= (_num));						\
+	return zl3073x_read_reg(zldev, (_addr) + idx * (_stride), _len,	\
+				value);					\
+}									\
+static inline __maybe_unused						\
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


