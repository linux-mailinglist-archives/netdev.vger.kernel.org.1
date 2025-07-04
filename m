Return-Path: <netdev+bounces-204241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2877AF9AA8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 20:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57AD61C834B0
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278E72E5B21;
	Fri,  4 Jul 2025 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS9r6DZm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9C3196AA
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653419; cv=none; b=rFek+XamjVBGFQ14KGrRLjpff/Q9gWXzDZBTVTcPbhLzJdRUzbjSFPgI3qnDoZfq1qwKME9fqA7T4fWuhd+Egn+ZOXxpCr2/t1jACk39Poii/Y+WD1ewyvKau+YS3nVjO7DNkzcc9shPXsY5eJwkhZ5PIIN2/vRX0g5pa8K6qoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653419; c=relaxed/simple;
	bh=QDnDb76IB5cOO7Oj5BeJE57yrKBAbkTyH3I1FS1TFms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swlaPYvIpqYSpMtOwGY4B7xTm/ASwN0HnOAZotNWZOvb28oCbh7MIVcrcikHGt1aTpsy+Wf0lrOULVpQ05JJcYm0ROr/5A9YkBpQC3xpjNJbARm/eyLtTizIqWcVhcXpy2yaluHNqSOgPu5odArNdnbQce276noEmMkLz6k+kyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eS9r6DZm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751653416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UsJURyjjbtHkbrtJZhJxshTMpqcubkZSbmM3PovDAa8=;
	b=eS9r6DZmTc4RDFjXLyOZUdC6sw5oWJAfCy8NqQ/9qiP5Yf9ausj+i6QUjwEGwhVZM2FAo0
	FPOYVDLAL+fsTo/FrO1+4Y92H2/sQLFyonZ1waESZwhRy45hJ9xy1C2MbqZu+nwaGaKNvp
	zD38Dpbl9hUmqjeXYIT7cgaYS9ZMWBg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-Z43aqMSxNAqY29FMbpkLSA-1; Fri,
 04 Jul 2025 14:23:33 -0400
X-MC-Unique: Z43aqMSxNAqY29FMbpkLSA-1
X-Mimecast-MFC-AGG-ID: Z43aqMSxNAqY29FMbpkLSA_1751653410
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9473E1955EC6;
	Fri,  4 Jul 2025 18:23:30 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.37])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EB9219560A7;
	Fri,  4 Jul 2025 18:23:23 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
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
Subject: [PATCH net-next v13 10/12] dpll: zl3073x: Add support to get/set priority on input pins
Date: Fri,  4 Jul 2025 20:22:00 +0200
Message-ID: <20250704182202.1641943-11-ivecera@redhat.com>
In-Reply-To: <20250704182202.1641943-1-ivecera@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add support for getting and setting input pin priority. Implement
required callbacks and set appropriate capability for input pins.
Although the pin priority make sense only if the DPLL is running in
automatic mode we have to expose this capability unconditionally because
input pins (references) are shared between all DPLLs where one of them
can run in automatic mode while the other one not.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 88 +++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/prop.c |  1 +
 2 files changed, 89 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 70c452a877ef4..406b3e48f2518 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -287,6 +287,56 @@ zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
 	return rc;
 }
 
+/**
+ * zl3073x_dpll_ref_prio_set - set priority for given input pin
+ * @pin: pointer to pin
+ * @prio: place to store priority
+ *
+ * Sets priority for the given input pin.
+ *
+ * Return: 0 on success, <0 on error
+ */
+static int
+zl3073x_dpll_ref_prio_set(struct zl3073x_dpll_pin *pin, u8 prio)
+{
+	struct zl3073x_dpll *zldpll = pin->dpll;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u8 ref, ref_prio;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read DPLL configuration into mailbox */
+	rc = zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_RD,
+			   ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
+	if (rc)
+		return rc;
+
+	/* Read reference priority - one value shared between P&N pins */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2), &ref_prio);
+	if (rc)
+		return rc;
+
+	/* Update nibble according pin type */
+	if (zl3073x_dpll_is_p_pin(pin)) {
+		ref_prio &= ~ZL_DPLL_REF_PRIO_REF_P;
+		ref_prio |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_P, prio);
+	} else {
+		ref_prio &= ~ZL_DPLL_REF_PRIO_REF_N;
+		ref_prio |= FIELD_PREP(ZL_DPLL_REF_PRIO_REF_N, prio);
+	}
+
+	/* Update reference priority */
+	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_REF_PRIO(ref / 2), ref_prio);
+	if (rc)
+		return rc;
+
+	/* Commit configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_DPLL_MB_SEM, ZL_DPLL_MB_SEM_WR,
+			     ZL_REG_DPLL_MB_MASK, BIT(zldpll->id));
+}
+
 /**
  * zl3073x_dpll_ref_state_get - get status for given input pin
  * @pin: pointer to pin
@@ -400,6 +450,42 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
 	return rc;
 }
 
+static int
+zl3073x_dpll_input_pin_prio_get(const struct dpll_pin *dpll_pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				u32 *prio, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+
+	*prio = pin->prio;
+
+	return 0;
+}
+
+static int
+zl3073x_dpll_input_pin_prio_set(const struct dpll_pin *dpll_pin, void *pin_priv,
+				const struct dpll_device *dpll, void *dpll_priv,
+				u32 prio, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	int rc;
+
+	if (prio > ZL_DPLL_REF_PRIO_MAX)
+		return -EINVAL;
+
+	/* If the pin is selectable then update HW registers */
+	if (pin->selectable) {
+		rc = zl3073x_dpll_ref_prio_set(pin, prio);
+		if (rc)
+			return rc;
+	}
+
+	/* Save priority */
+	pin->prio = prio;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -493,6 +579,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.prio_get = zl3073x_dpll_input_pin_prio_get,
+	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
 	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
 };
diff --git a/drivers/dpll/zl3073x/prop.c b/drivers/dpll/zl3073x/prop.c
index c3224e78cbf01..4cf7e8aefcb37 100644
--- a/drivers/dpll/zl3073x/prop.c
+++ b/drivers/dpll/zl3073x/prop.c
@@ -205,6 +205,7 @@ struct zl3073x_pin_props *zl3073x_pin_props_get(struct zl3073x_dev *zldev,
 	if (dir == DPLL_PIN_DIRECTION_INPUT) {
 		props->dpll_props.type = DPLL_PIN_TYPE_EXT;
 		props->dpll_props.capabilities =
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 	} else {
 		props->dpll_props.type = DPLL_PIN_TYPE_GNSS;
-- 
2.49.0


