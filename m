Return-Path: <netdev+bounces-197182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68DAD7BD5
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6516B163E47
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 20:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7272D6629;
	Thu, 12 Jun 2025 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWZr8tBQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8192D8DCD
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758623; cv=none; b=PsZ1gke/qeTQW8CZ0t9IGvz8I5lDcIu4t8EwXV46TV7ZtaexZFZmySl1oaWaeAbz5ugnrTrhAyG0w8Z+N3vBghXNc/VQ1Ec4q11GCXh5obnPV80HhgY3UWWPQBtwLxyv1Tlg0ACLSH8w2iEFRylIZuY8gquCAuHooZCupMRocsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758623; c=relaxed/simple;
	bh=9zblmUgJtWIkKos6+zpNQ9d4+qjoBrYkzw8znx9DyTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8m32eDYLpoHw5KVT6ddGgc51O9rxB8ipHiAgzbJo1i/Mlcvg6Jj9i7ZMcDBeyE/qESmkv8RVkiVdoRIJzuRdV1egTmI+rhrmujosl41+klzBK1ZyX//H0A+M9liPBah0eIrnwLDECoVYi+nHauk7+kNNAEuxuNzg5O8NkSRtO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NWZr8tBQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749758619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BkHZHBWuBTB8Pv5EbGd/otlclSLolWJa7Gh+KIrTNFo=;
	b=NWZr8tBQSM1sMzoVe6kBJWuTPcjoeDS5JMQMOLnC/IzNQBVUE+L4bUhSjiGorVDpqpBNgj
	AzqPdeZYsS2X8oz7gO9xaNvyzK3ARMZWH3Vbc6BMH2SYuGBJFB4EUW6kf4r0dGizUtVez+
	E7AYeuvgRQ5Id0dZvFOuWIH2D7cAlsc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-2s7XAF63NoGMVM-pJdq-eA-1; Thu,
 12 Jun 2025 16:03:31 -0400
X-MC-Unique: 2s7XAF63NoGMVM-pJdq-eA-1
X-Mimecast-MFC-AGG-ID: 2s7XAF63NoGMVM-pJdq-eA_1749758608
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9139419560B2;
	Thu, 12 Jun 2025 20:03:28 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.224.169])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21B5C180045B;
	Thu, 12 Jun 2025 20:03:21 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v9 13/14] dpll: zl3073x: Add support to get/set frequency on input pins
Date: Thu, 12 Jun 2025 22:01:44 +0200
Message-ID: <20250612200145.774195-14-ivecera@redhat.com>
In-Reply-To: <20250612200145.774195-1-ivecera@redhat.com>
References: <20250612200145.774195-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add support to get/set frequency on input pins. The frequency for input
pins (references) is computed in the device according this formula:

 freq = base_freq * multiplier * (nominator / denominator)

where the base_freq comes from the list of supported base frequencies
and other parameters are arbitrary numbers. All these parameters are
16-bit unsigned integers.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 124 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |   5 ++
 2 files changed, 129 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 1f44910958781..8bd0e3e66e7f1 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -8,6 +8,7 @@
 #include <linux/dpll.h>
 #include <linux/err.h>
 #include <linux/kthread.h>
+#include <linux/math64.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
@@ -84,6 +85,127 @@ zl3073x_dpll_pin_direction_get(const struct dpll_pin *dpll_pin, void *pin_priv,
 	return 0;
 }
 
+/**
+ * zl3073x_dpll_input_ref_frequency_get - get input reference frequency
+ * @zldpll: pointer to zl3073x_dpll
+ * @ref_id: reference id
+ * @frequency: pointer to variable to store frequency
+ *
+ * Reads frequency of given input reference.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_input_ref_frequency_get(struct zl3073x_dpll *zldpll, u8 ref_id,
+				     u32 *frequency)
+{
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u16 base, mult, num, denom;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref_id));
+	if (rc)
+		return rc;
+
+	/* Read registers to compute resulting frequency */
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_BASE, &base);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_FREQ_MULT, &mult);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_M, &num);
+	if (rc)
+		return rc;
+	rc = zl3073x_read_u16(zldev, ZL_REG_REF_RATIO_N, &denom);
+	if (rc)
+		return rc;
+
+	/* Sanity check that HW has not returned zero denominator */
+	if (!denom) {
+		dev_err(zldev->dev,
+			"Zero divisor for ref %u frequency got from device\n",
+			ref_id);
+		return -EINVAL;
+	}
+
+	/* Compute the frequency */
+	*frequency = base * mult * num / denom;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_frequency_get(const struct dpll_pin *dpll_pin,
+				     void *pin_priv,
+				     const struct dpll_device *dpll,
+				     void *dpll_priv, u64 *frequency,
+				     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 ref_freq;
+	u8 ref;
+	int rc;
+
+	/* Read and return ref frequency */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_dpll_input_ref_frequency_get(zldpll, ref, &ref_freq);
+	if (!rc)
+		*frequency = ref_freq;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
+				     void *pin_priv,
+				     const struct dpll_device *dpll,
+				     void *dpll_priv, u64 frequency,
+				     struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u16 base, mult;
+	u8 ref;
+	int rc;
+
+	/* Get base frequency and multiplier for the requested frequency */
+	rc = zl3073x_ref_freq_factorize(frequency, &base, &mult);
+	if (rc)
+		return rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Load reference configuration */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+
+	/* Update base frequency, multiplier, numerator & denominator */
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_BASE, base);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_FREQ_MULT, mult);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_M, 1);
+	if (rc)
+		return rc;
+	rc = zl3073x_write_u16(zldev, ZL_REG_REF_RATIO_N, 1);
+	if (rc)
+		return rc;
+
+	/* Commit reference configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+			     ZL_REG_REF_MB_MASK, BIT(ref));
+}
+
 /**
  * zl3073x_dpll_selected_ref_get - get currently selected reference
  * @zldpll: pointer to zl3073x_dpll
@@ -592,6 +714,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
+	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 34e905053a1ef..09dd314663dff 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -135,6 +135,11 @@
 #define ZL_REF_MB_SEM_WR			BIT(0)
 #define ZL_REF_MB_SEM_RD			BIT(1)
 
+#define ZL_REG_REF_FREQ_BASE			ZL_REG(10, 0x05, 2)
+#define ZL_REG_REF_FREQ_MULT			ZL_REG(10, 0x07, 2)
+#define ZL_REG_REF_RATIO_M			ZL_REG(10, 0x09, 2)
+#define ZL_REG_REF_RATIO_N			ZL_REG(10, 0x0b, 2)
+
 #define ZL_REG_REF_CONFIG			ZL_REG(10, 0x0d, 1)
 #define ZL_REF_CONFIG_ENABLE			BIT(0)
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
-- 
2.49.0


