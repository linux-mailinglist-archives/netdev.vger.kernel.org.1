Return-Path: <netdev+bounces-179803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F221AA7E882
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C2B17F3A6
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A229F21ABB2;
	Mon,  7 Apr 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJua3T7K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3A21A458
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047199; cv=none; b=YMFJMEMjw9gTxru7Gv6IijT3boRuVvJnBdeeheMr1Qwde1ZJZ+5csX5nuCic32V9sHm/WogKT/+Hf6BKo0swBAvw1or0OH1bwshEs76T/OFoQoQ7tu8F6/LA38HA8JAsv+S9uOIltivWMlA96NlWCfWQrB/4sRruB4YJ6lyeWNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047199; c=relaxed/simple;
	bh=MC4Rn9hwRMi8qupvH99rESMEC382s5ckUG9bARpwXMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8rIWLQZll1yfJYLEYFgV7O3g8godf1D6me7a0aPE1Brh+qolPMOmwwYQ8p5zTwKcryxhwAt2ygshsLVBu5vhYVCN1bkQ7O7XybZpZiUg55+7K7D0sLbfxCePG8xDheQcyb9+LZg1iGEq/rTBfC4F/blAfa7B99nw5ae8sguvZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJua3T7K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744047197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fnu8pPESdTdvc3PutAnC7EsKpV2Up/lzUFesp7gWUMs=;
	b=XJua3T7KazZqradjBCgEALxXSMpK0h0ZAEs+aMIeNBo2bF9by5QWOrgwDkDg45Potoo0DZ
	I+CWHVS0XHP0Sy1xtAoBTz3jGqq8+APt3FqFb7Pz3lh2g13FqsfYhmqwcoL124kLiHfhuN
	HkCKIuKi9hy9SFDt+3BAS6HlEcjfX5A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-pOKLM6iQMW-9Y3KmmKF-3A-1; Mon,
 07 Apr 2025 13:33:12 -0400
X-MC-Unique: pOKLM6iQMW-9Y3KmmKF-3A-1
X-Mimecast-MFC-AGG-ID: pOKLM6iQMW-9Y3KmmKF-3A_1744047189
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BF651800258;
	Mon,  7 Apr 2025 17:33:09 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9882180B488;
	Mon,  7 Apr 2025 17:33:03 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 20/28] dpll: zl3073x: Add support to get/set priority on input pins
Date: Mon,  7 Apr 2025 19:32:53 +0200
Message-ID: <20250407173301.1010462-1-ivecera@redhat.com>
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

This adds support for getting and setting input pin priority. Implement
required callbacks and set appropriate capability for input pins.
Although the pin priority make sense only if the DPLL is running in
automatic mode we have to expose this capability unconditionally because
input pins (references) are shared between both DPLLs where on of them
can run in automatic mode while the other one not.

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>
Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/dpll_zl3073x.c | 82 +++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/dpll/dpll_zl3073x.c b/drivers/dpll/dpll_zl3073x.c
index ad2a8d383daaf..072a33ec12399 100644
--- a/drivers/dpll/dpll_zl3073x.c
+++ b/drivers/dpll/dpll_zl3073x.c
@@ -403,6 +403,45 @@ zl3073x_dpll_ref_prio_get(struct zl3073x_dpll_pin *pin, u8 *prio)
 	return rc;
 }
 
+static int
+zl3073x_dpll_ref_prio_set(struct zl3073x_dpll_pin *pin, u8 prio)
+{
+	struct zl3073x_dpll *zldpll = pin_to_dpll(pin);
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	u8 idx, ref_prio;
+	int rc;
+
+	/* Read DPLL configuration into mailbox */
+	rc = zl3073x_mb_dpll_read(zldev, zldpll->id);
+	if (rc)
+		return rc;
+
+	/* Get index of the pin */
+	idx = zl3073x_dpll_pin_index_get(pin);
+
+	/* Read ref prio nibble */
+	rc = zl3073x_read_dpll_ref_prio(zldev, idx / 2, &ref_prio);
+	if (rc)
+		return rc;
+
+	/* Update nibble according pin type */
+	if (zl3073x_dpll_is_p_pin(pin)) {
+		ref_prio &= ~DPLL_REF_PRIO_REF_P;
+		ref_prio |= FIELD_PREP(DPLL_REF_PRIO_REF_P, prio);
+	} else {
+		ref_prio &= ~DPLL_REF_PRIO_REF_N;
+		ref_prio |= FIELD_PREP(DPLL_REF_PRIO_REF_N, prio);
+	}
+
+	/* Write the updated priority value */
+	rc = zl3073x_write_dpll_ref_prio(zldev, idx / 2, ref_prio);
+	if (rc)
+		return rc;
+
+	/* Update channel configuration from mailbox */
+	return zl3073x_mb_dpll_write(zldev, zldpll->id);
+}
+
 static int
 zl3073x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					 void *pin_priv,
@@ -500,6 +539,46 @@ zl3073x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *dpll_pin,
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
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->mfd;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	int rc;
+
+	if (prio > DPLL_REF_PRIO_MAX)
+		return -EINVAL;
+
+	/* If the pin is selectable then update HW registers */
+	if (pin->selectable) {
+		guard(zl3073x)(zldev);
+
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
@@ -575,6 +654,8 @@ zl3073x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
 
 static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.direction_get = zl3073x_dpll_pin_direction_get,
+	.prio_get = zl3073x_dpll_input_pin_prio_get,
+	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
 	.state_on_dpll_set = zl3073x_dpll_input_pin_state_on_dpll_set,
 };
@@ -736,6 +817,7 @@ zl3073x_dpll_pin_info_get(struct zl3073x_dpll_pin *pin)
 	if (zl3073x_dpll_is_input_pin(pin)) {
 		pin_info->props.type = DPLL_PIN_TYPE_EXT;
 		pin_info->props.capabilities =
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;
 	} else {
 		pin_info->props.type = DPLL_PIN_TYPE_GNSS;
-- 
2.48.1


