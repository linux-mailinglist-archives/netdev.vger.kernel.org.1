Return-Path: <netdev+bounces-259740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHGpAp+EmGnKJQMAu9opvQ
	(envelope-from <netdev+bounces-259740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:58:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E31691E6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2066A3087060
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0034EEE5;
	Fri, 20 Feb 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZcbDMwY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BC533D4E2
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603087; cv=none; b=R0IDXcgbuUPpWFI3ww7ca5owYU1Ktnjih2ZfPTR3u/BLDkfEFMLGqI7Eglz8di9dGL1ApImzvzcLyn8I/hdDJqZ+yy5kV89dOjc8eka6uchMZ3K2dXd++3Nff2GqiwDpOltW26m+ydK0gewV+iLr7LsqPiy/nCjTiaOTEWm41Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603087; c=relaxed/simple;
	bh=DMROmRcmuSi/jAtx181rdWhMjlSe0BVRcmuGdh5LfVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LW3UmQbvi1QvF0cASVTmzE4LQKwtalpHWlDzHv9J92NQlydjlM0pYdFOb69zfnkY5tayqCvdaB/NjTh96IEdl7T1UsFstgIAteaDPAiDeYBpcWL7fwGH5QBjdNTtfKKJxpsSV+W/m2BXKqpCGk7mj88eHaoAMF9duThrjiqomDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZcbDMwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771603085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQtw/HMpeljbItVu0sciky/D3GXjuVGVU/wdWn3u4z0=;
	b=XZcbDMwYRcvW5swgLbTZh7FpDdWQ9sfkdIwQjZMVMXxDXgSHogLBWw9ykxyGMCSWt/EaOR
	bz4JORbrKAJkJlSn+VVnhqmZuY5MZ27l4dfJH4Pfa4/qmJjjO9PZZGy/odqfsClUqeKQcB
	QzyQwFIGhRPp5sfX2fB7u4Yy4rr2fVA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-Zk1fYWf1OtWTPqxcnqv3EQ-1; Fri,
 20 Feb 2026 10:58:02 -0500
X-MC-Unique: Zk1fYWf1OtWTPqxcnqv3EQ-1
X-Mimecast-MFC-AGG-ID: Zk1fYWf1OtWTPqxcnqv3EQ_1771603080
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 122C31956096;
	Fri, 20 Feb 2026 15:58:00 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA70E1800349;
	Fri, 20 Feb 2026 15:57:56 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: fix REF_PHASE_OFFSET_COMP register width for some chip IDs
Date: Fri, 20 Feb 2026 16:57:54 +0100
Message-ID: <20260220155755.448185-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259740-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 990E31691E6
X-Rspamd-Action: no action

The REF_PHASE_OFFSET_COMP register is 48-bit wide on most zl3073x chip
variants, but only 32-bit wide on chip IDs 0x0E30, 0x0E93..0x0E97 and
0x1F60. The driver unconditionally uses 48-bit read/write operations,
which on 32-bit variants causes reading 2 bytes past the register
boundary (corrupting the value) and writing 2 bytes into the adjacent
register.

Fix this by storing the chip ID in the device structure during probe
and adding a helper to detect the affected variants. Use the correct
register width for read/write operations and the matching sign extension
bit (31 vs 47) when interpreting the phase compensation value.

Fixes: 6287262f761e ("dpll: zl3073x: Add support to adjust phase")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c |  1 +
 drivers/dpll/zl3073x/core.h | 28 ++++++++++++++++++++++++++++
 drivers/dpll/zl3073x/dpll.c |  7 +++++--
 drivers/dpll/zl3073x/ref.c  | 25 ++++++++++++++++++++-----
 drivers/dpll/zl3073x/regs.h |  1 +
 5 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 63bd97181b9e..8c5ee28e02f4 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1026,6 +1026,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 				     "Unknown or non-match chip ID: 0x%0x\n",
 				     id);
 	}
+	zldev->chip_id = id;
 
 	/* Read revision, firmware version and custom config version */
 	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index dddfcacea5c0..fd2af3c62a7d 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -35,6 +35,7 @@ struct zl3073x_dpll;
  * @dev: pointer to device
  * @regmap: regmap to access device registers
  * @multiop_lock: to serialize multiple register operations
+ * @chip_id: chip ID read from hardware
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -48,6 +49,7 @@ struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
 	struct mutex		multiop_lock;
+	u16			chip_id;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -144,6 +146,32 @@ int zl3073x_write_hwreg_seq(struct zl3073x_dev *zldev,
 
 int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
 
+/**
+ * zl3073x_dev_is_ref_phase_comp_32bit - check ref phase comp register size
+ * @zldev: pointer to zl3073x device
+ *
+ * Some chip IDs have a 32-bit wide ref_phase_offset_comp register instead
+ * of the default 48-bit.
+ *
+ * Return: true if the register is 32-bit, false if 48-bit
+ */
+static inline bool
+zl3073x_dev_is_ref_phase_comp_32bit(struct zl3073x_dev *zldev)
+{
+	switch (zldev->chip_id) {
+	case 0x0E30:
+	case 0x0E93:
+	case 0x0E94:
+	case 0x0E95:
+	case 0x0E96:
+	case 0x0E97:
+	case 0x1F60:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static inline bool
 zl3073x_is_n_pin(u8 id)
 {
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 78edc36b17fb..8ffbede117c6 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -475,8 +475,11 @@ zl3073x_dpll_input_pin_phase_adjust_get(const struct dpll_pin *dpll_pin,
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	ref = zl3073x_ref_state_get(zldev, ref_id);
 
-	/* Perform sign extension for 48bit signed value */
-	phase_comp = sign_extend64(ref->phase_comp, 47);
+	/* Perform sign extension based on register width */
+	if (zl3073x_dev_is_ref_phase_comp_32bit(zldev))
+		phase_comp = sign_extend64(ref->phase_comp, 31);
+	else
+		phase_comp = sign_extend64(ref->phase_comp, 47);
 
 	/* Reverse two's complement negation applied during set and convert
 	 * to 32bit signed int
diff --git a/drivers/dpll/zl3073x/ref.c b/drivers/dpll/zl3073x/ref.c
index aa2de13effa8..6b65e6103999 100644
--- a/drivers/dpll/zl3073x/ref.c
+++ b/drivers/dpll/zl3073x/ref.c
@@ -121,8 +121,16 @@ int zl3073x_ref_state_fetch(struct zl3073x_dev *zldev, u8 index)
 		return rc;
 
 	/* Read phase compensation register */
-	rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
-			      &ref->phase_comp);
+	if (zl3073x_dev_is_ref_phase_comp_32bit(zldev)) {
+		u32 val;
+
+		rc = zl3073x_read_u32(zldev, ZL_REG_REF_PHASE_OFFSET_COMP_32,
+				      &val);
+		ref->phase_comp = val;
+	} else {
+		rc = zl3073x_read_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
+				      &ref->phase_comp);
+	}
 	if (rc)
 		return rc;
 
@@ -179,9 +187,16 @@ int zl3073x_ref_state_set(struct zl3073x_dev *zldev, u8 index,
 	if (!rc && dref->sync_ctrl != ref->sync_ctrl)
 		rc = zl3073x_write_u8(zldev, ZL_REG_REF_SYNC_CTRL,
 				      ref->sync_ctrl);
-	if (!rc && dref->phase_comp != ref->phase_comp)
-		rc = zl3073x_write_u48(zldev, ZL_REG_REF_PHASE_OFFSET_COMP,
-				       ref->phase_comp);
+	if (!rc && dref->phase_comp != ref->phase_comp) {
+		if (zl3073x_dev_is_ref_phase_comp_32bit(zldev))
+			rc = zl3073x_write_u32(zldev,
+					       ZL_REG_REF_PHASE_OFFSET_COMP_32,
+					       ref->phase_comp);
+		else
+			rc = zl3073x_write_u48(zldev,
+					       ZL_REG_REF_PHASE_OFFSET_COMP,
+					       ref->phase_comp);
+	}
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index d837bee72b17..5573d7188406 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -194,6 +194,7 @@
 #define ZL_REF_CONFIG_DIFF_EN			BIT(2)
 
 #define ZL_REG_REF_PHASE_OFFSET_COMP		ZL_REG(10, 0x28, 6)
+#define ZL_REG_REF_PHASE_OFFSET_COMP_32	ZL_REG(10, 0x28, 4)
 
 #define ZL_REG_REF_SYNC_CTRL			ZL_REG(10, 0x2e, 1)
 #define ZL_REF_SYNC_CTRL_MODE			GENMASK(2, 0)
-- 
2.52.0


