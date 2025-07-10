Return-Path: <netdev+bounces-205858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91408B00772
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76763484E6D
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 15:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C504527A92B;
	Thu, 10 Jul 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+j+w/7G"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899C27A452
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161963; cv=none; b=cRpVbEcNSque+bZTL0gcoQBs55tPm+lURnESKtkYKAhg5tSTH0UPXLQ0YG/VuGHCTsUfiqBSIcGZNDE4LRH9+sRJ/WiOObUMZfksamnNKifLCGSBK0KetHDMKo6Z/fycbK3h0VCPkWbpJJXOuuRNliz2AoVgfXW5m0qIJKIjjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161963; c=relaxed/simple;
	bh=lYsTQwvbPjwo9SKP6F9ST1FEjgraIzAPkXnbaN9aFcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K85zGArwop1bG34IqPyAgpafaUzyl/nurRFjUer4+9JCrDsdgii4v3XbLhLjRwkKSVLi8Z+WFbw1Qg/OvZX78fig94gyALcd41JiOQ6+6b6Xy5gkc5Os/ubnxfYaaHVd/oYsWViy7m1zbX1+wxdwNFte0zr3drmBxTg9mulfd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+j+w/7G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752161961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/uB4sVuQ3rkZtaIdq9OKeV9DklUJLkLAq+Vft4pdXlc=;
	b=P+j+w/7GxJ5EKT6bOd1OzgGT7ZSiA077rAUqFYoBJyAbj1iFlHvXr0iqv31KXzWx7DV8DT
	yExc6tpf+iwtDkeD+8TCIC287C+8+o3iBI1VQucwsnQrCunpmRvsmM9LIXRiKMGzPb11C3
	vUOI8sOVrqo8dhkRTMBn5pquddwXRZA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-ltjtO8f_P8i-jIahXqTWcg-1; Thu,
 10 Jul 2025 11:39:16 -0400
X-MC-Unique: ltjtO8f_P8i-jIahXqTWcg-1
X-Mimecast-MFC-AGG-ID: ltjtO8f_P8i-jIahXqTWcg_1752161952
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0071618011FB;
	Thu, 10 Jul 2025 15:39:10 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.211])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9CDB51956094;
	Thu, 10 Jul 2025 15:39:06 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next 4/5] dpll: zl3073x: Add support to adjust phase
Date: Thu, 10 Jul 2025 17:38:47 +0200
Message-ID: <20250710153848.928531-5-ivecera@redhat.com>
In-Reply-To: <20250710153848.928531-1-ivecera@redhat.com>
References: <20250710153848.928531-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add support to get/set phase adjustment for both input and output pins.
The phase adjustment is implemented using reference and output phase
offset compensation registers. For input pins the adjustment value can
be arbitrary number but for outputs the value has to be a multiple
of half synthesizer clock cycles.

Co-developed-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Prathosh Satish <Prathosh.Satish@microchip.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 184 ++++++++++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |   3 +
 2 files changed, 187 insertions(+)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 198e19f6fb152..4e05120c30b9a 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -575,6 +575,85 @@ zl3073x_dpll_input_pin_phase_offset_get(const struct dpll_pin *dpll_pin,
 	return rc;
 }
 
+static int
+zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv,
+					s32 *phase_adjust,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	s64 phase_comp;
+	u8 ref;
+	int rc;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+	if (rc)
+		return rc;
+
+	/* Read current phase offset compensation */
+	rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP, &phase_comp);
+	if (rc)
+		return rc;
+
+	/* Perform sign extension for 48bit signed value */
+	phase_comp = sign_extend64(phase_comp, 47);
+
+	/* Reverse two's complement negation applied during set and convert
+	 * to 32bit signed int
+	 */
+	*phase_adjust = (s32) -phase_comp;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_input_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
+					void *pin_priv,
+					const struct dpll_device *dpll,
+					void *dpll_priv,
+					s32 phase_adjust,
+					struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	s64 phase_comp;
+	u8 ref;
+	int rc;
+
+	/* The value in the register is stored as two's complement negation
+	 * of requested value.
+	 */
+	phase_comp = (s64) -phase_adjust;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read reference configuration */
+	ref = zl3073x_input_pin_ref_get(pin->id);
+	rc = zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_RD,
+			   ZL_REG_REF_MB_MASK, BIT(ref));
+	if (rc)
+		return rc;
+
+	/* Write the requested value into the compensation register */
+	rc = zl3073x_write_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP, phase_comp);
+	if (rc)
+		return rc;
+
+	/* Commit reference configuration */
+	return zl3073x_mb_op(zldev, ZL_REG_REF_MB_SEM, ZL_REF_MB_SEM_WR,
+			     ZL_REG_REF_MB_MASK, BIT(ref));
+}
+
 /**
  * zl3073x_dpll_ref_prio_get - get priority for given input pin
  * @pin: pointer to pin
@@ -1278,6 +1357,107 @@ zl3073x_dpll_output_pin_frequency_set(const struct dpll_pin *dpll_pin,
 			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
 }
 
+static int
+zl3073x_dpll_output_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 s32 *phase_adjust,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	u32 synth_freq;
+	s32 phase_comp;
+	u8 out, synth;
+	int rc;
+
+	out = zl3073x_output_pin_out_get(pin->id);
+	synth = zl3073x_out_synth_get(zldev, out);
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	/* Read current output phase compensation */
+	rc = zl3073x_read_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, &phase_comp);
+	if (rc)
+		return rc;
+
+	/* Value in register is expressed in half synth clock cycles */
+	phase_comp *= (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
+
+	/* Reverse two's complement negation applied during 'set' */
+	*phase_adjust = -phase_comp;
+
+	return rc;
+}
+
+static int
+zl3073x_dpll_output_pin_phase_adjust_set(const struct dpll_pin *dpll_pin,
+					 void *pin_priv,
+					 const struct dpll_device *dpll,
+					 void *dpll_priv,
+					 s32 phase_adjust,
+					 struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	struct zl3073x_dpll_pin *pin = pin_priv;
+	int half_synth_cycle;
+	u32 synth_freq;
+	u8 out, synth;
+	int rc;
+
+	/* Get attached synth */
+	out = zl3073x_output_pin_out_get(pin->id);
+	synth = zl3073x_out_synth_get(zldev, out);
+
+	/* Get synth's frequency */
+	synth_freq = zl3073x_synth_freq_get(zldev, synth);
+
+	/* Value in register is expressed in half synth clock cycles so
+	 * the given phase adjustment a multiple of half synth clock.
+	 */
+	half_synth_cycle = (int)div_u64(PSEC_PER_SEC, 2 * synth_freq);
+
+	if ((phase_adjust % half_synth_cycle) != 0) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Phase adjustment value has to be multiple of %d",
+				   half_synth_cycle);
+		return -EINVAL;
+	}
+	phase_adjust /= half_synth_cycle;
+
+	/* The value in the register is stored as two's complement negation
+	 * of requested value.
+	 */
+	phase_adjust = -phase_adjust;
+
+	guard(mutex)(&zldev->multiop_lock);
+
+	/* Read output configuration */
+	rc = zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_RD,
+			   ZL_REG_OUTPUT_MB_MASK, BIT(out));
+	if (rc)
+		return rc;
+
+	/* Write the requested value into the compensation register */
+	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_COMP, phase_adjust);
+	if (rc)
+		return rc;
+
+	/* Update output configuration from mailbox */
+	return zl3073x_mb_op(zldev, ZL_REG_OUTPUT_MB_SEM, ZL_OUTPUT_MB_SEM_WR,
+			     ZL_REG_OUTPUT_MB_MASK, BIT(out));
+}
+
 static int
 zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 					  void *pin_priv,
@@ -1405,6 +1585,8 @@ static const struct dpll_pin_ops zl3073x_dpll_input_pin_ops = {
 	.frequency_get = zl3073x_dpll_input_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_input_pin_frequency_set,
 	.phase_offset_get = zl3073x_dpll_input_pin_phase_offset_get,
+	.phase_adjust_get = zl3073x_dpll_input_pin_phase_adjust_get,
+	.phase_adjust_set = zl3073x_dpll_input_pin_phase_adjust_set,
 	.prio_get = zl3073x_dpll_input_pin_prio_get,
 	.prio_set = zl3073x_dpll_input_pin_prio_set,
 	.state_on_dpll_get = zl3073x_dpll_input_pin_state_on_dpll_get,
@@ -1417,6 +1599,8 @@ static const struct dpll_pin_ops zl3073x_dpll_output_pin_ops = {
 	.esync_set = zl3073x_dpll_output_pin_esync_set,
 	.frequency_get = zl3073x_dpll_output_pin_frequency_get,
 	.frequency_set = zl3073x_dpll_output_pin_frequency_set,
+	.phase_adjust_get = zl3073x_dpll_output_pin_phase_adjust_get,
+	.phase_adjust_set = zl3073x_dpll_output_pin_phase_adjust_set,
 	.state_on_dpll_get = zl3073x_dpll_output_pin_state_on_dpll_get,
 };
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 9ee2f44a2eec7..a382cd4a109f5 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -168,6 +168,8 @@
 #define ZL_REF_CONFIG_ENABLE			BIT(0)
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
 
+#define ZL_REG_REF_PHASE_OFFSET_COMP		ZL_REG(10, 0x28, 6)
+
 #define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
 #define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
 #define ZL_REF_SYNC_CTRL_MODE_REFSYNC_PAIR_OFF	0
@@ -237,5 +239,6 @@
 #define ZL_REG_OUTPUT_WIDTH			ZL_REG(14, 0x10, 4)
 #define ZL_REG_OUTPUT_ESYNC_PERIOD		ZL_REG(14, 0x14, 4)
 #define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
+#define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
 
 #endif /* _ZL3073X_REGS_H */
-- 
2.49.0


