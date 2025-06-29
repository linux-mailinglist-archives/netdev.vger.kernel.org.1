Return-Path: <netdev+bounces-202276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A4AED007
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC0E3B732C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308A244676;
	Sun, 29 Jun 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqisaRX8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489E6244688
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751224345; cv=none; b=NQkj8mnRGl7HH4k5mXPEc9XEThgHN59qZDXJs3+I/flBp8g6LXhr9qVK3A+cxY+uOCIY2F9W6uz76e5hnyitAL/LO6bQ5kUazqnzSpDKkV8n+j9zf5DDmQlhljKe9HAMzQ1HAYz4xJKJc6RhtlJjCh5aRRP+jgOO+lNt6ToSp8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751224345; c=relaxed/simple;
	bh=gvFlxcFtzyBUDDOMREWUtXBfCFunJy5FTlfD6HzbhQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnAo8Zzh6Yb1C1xpzao7jLcjHp4hc8TwqQfXl9QrO/QFNeAArp1gL8XwSDF1Ezc7JlmNSjUuNQXBIeA8VHJaxFnr/t5DWjxw/f58YrTOPq44LWroU4STUbk0toSUsZ1L2qutcyISGEib+qZfBjy++gZPOn79tuNPKDS+FKIfg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cqisaRX8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751224343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QKv0PnDhV0wNFfVbM7vA/OmMJ7dFD+u1OrtyTP7l5fA=;
	b=cqisaRX8kNAJ8LWVoUGUMwCqfM7QfGr2BMt3kOmSqZ1rokHnVDLBjETO0wGSMptz1xdOge
	d02pnSV5Q6GkrZA3QzVquY1MYCWFmtuUj3qYUtdyPevoYN7w94CdM2tM5AT5gz9kXE2I32
	vB7vJAqa/msnaTekW0JxZsNiPpyWW0c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-McBv4Z9wMiS0SD9-mwW6dA-1; Sun,
 29 Jun 2025 15:12:19 -0400
X-MC-Unique: McBv4Z9wMiS0SD9-mwW6dA-1
X-Mimecast-MFC-AGG-ID: McBv4Z9wMiS0SD9-mwW6dA_1751224337
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D2A11978F63;
	Sun, 29 Jun 2025 19:12:17 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.45.224.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D33F6180045B;
	Sun, 29 Jun 2025 19:12:10 +0000 (UTC)
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
Subject: [PATCH net-next v12 11/14] dpll: zl3073x: Add support to get/set priority on input pins
Date: Sun, 29 Jun 2025 21:10:46 +0200
Message-ID: <20250629191049.64398-12-ivecera@redhat.com>
In-Reply-To: <20250629191049.64398-1-ivecera@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
index 89da2c34609eb..e67ef37479910 100644
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
@@ -474,6 +560,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
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


