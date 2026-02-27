Return-Path: <netdev+bounces-261822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDJgCLx3oWnJtQQAu9opvQ
	(envelope-from <netdev+bounces-261822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:53:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D441B63CE
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0073304B987
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CA63ED11F;
	Fri, 27 Feb 2026 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4Bzi2uQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7E3E95A0
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189598; cv=none; b=p+2hBmRXGPqW/EQHF6xMXiQme/rOyQUEwdgCiJ3GVVpLlBTFKyVEpFTB33yfLajM2L4Uhb5JtJVDX88qOVGfaCj9GeOSukwhgubXWdgTJFrLNsxLk7c0l7lKKNxT/uud57JVv0fNdH1EkOJ5TvwkoEMbUGNHTvV8f1wH7ChCpmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189598; c=relaxed/simple;
	bh=YJVMfKcFD2DOse7R6k7zrEui38OeVR0ebzpDfwFPCdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tezYoLGqkN/otEc4xzaMU21iXJVzvIrHsGMyHWocwZWjQrG8gf1Mp19eb/MjqzeVkUeflayxc8t8bPR0dgmeDB2O8awcnAz98XZXtD2NkPKU4Y9K5blS5eH2Q5xS4OhjnbytNUci36e+iziTUrj39xoeoUmGY7fA7LaOif43lVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d4Bzi2uQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772189595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YwgOpzTpe2TkS2zfPoM0arhsXAZNdWUcxtABiJVFVjU=;
	b=d4Bzi2uQkRESJ9de/rk3hHWixPMLLxilp4Rl1EvAM9KwOJ4XLUehq6qvj4VoA2UJG/iPc4
	hb6n2cEIOa5KdjzWcneFhgnPyFIAlAlcrtzyJE3PXoVN4ojQk48iIKuTkACRZ3kvTlYRdP
	C95+j82/ORCNJjdprKz2q+llprchCBE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-A4HbHgKONFm0XT1Qm-tweA-1; Fri,
 27 Feb 2026 05:53:12 -0500
X-MC-Unique: A4HbHgKONFm0XT1Qm-tweA-1
X-Mimecast-MFC-AGG-ID: A4HbHgKONFm0XT1Qm-tweA_1772189591
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7A501956055;
	Fri, 27 Feb 2026 10:53:10 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7634F19560B7;
	Fri, 27 Feb 2026 10:53:08 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] dpll: zl3073x: add die temperature reporting for supported chips
Date: Fri, 27 Feb 2026 11:53:00 +0100
Message-ID: <20260227105300.710272-3-ivecera@redhat.com>
In-Reply-To: <20260227105300.710272-1-ivecera@redhat.com>
References: <20260227105300.710272-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261822-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8D441B63CE
X-Rspamd-Action: no action

Some zl3073x chip variants (0x1Exx, 0x2Exx and 0x3FC4) provide a die
temperature status register with 0.1 C resolution.

Add a ZL3073X_FLAG_DIE_TEMP chip flag to identify these variants and
implement zl3073x_dpll_temp_get() as the dpll_device_ops.temp_get
callback. The register value is converted from 0.1 C units to
millidegrees as expected by the DPLL subsystem.

To support per-instance ops selection, copy the base dpll_device_ops
into struct zl3073x_dpll and conditionally set .temp_get during device
registration based on the chip flag.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 22 +++++++++++-----------
 drivers/dpll/zl3073x/core.h |  2 ++
 drivers/dpll/zl3073x/dpll.c | 28 +++++++++++++++++++++++++---
 drivers/dpll/zl3073x/dpll.h |  2 ++
 drivers/dpll/zl3073x/regs.h |  2 ++
 5 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index c8af343010450..10e036ccf08f0 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -30,18 +30,18 @@ static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
 	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32),
 	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x1E93, 1, 0),
-	ZL_CHIP_INFO(0x1E94, 2, 0),
-	ZL_CHIP_INFO(0x1E95, 3, 0),
-	ZL_CHIP_INFO(0x1E96, 4, 0),
-	ZL_CHIP_INFO(0x1E97, 5, 0),
+	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP),
 	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
-	ZL_CHIP_INFO(0x2E93, 1, 0),
-	ZL_CHIP_INFO(0x2E94, 2, 0),
-	ZL_CHIP_INFO(0x2E95, 3, 0),
-	ZL_CHIP_INFO(0x2E96, 4, 0),
-	ZL_CHIP_INFO(0x2E97, 5, 0),
-	ZL_CHIP_INFO(0x3FC4, 2, 0),
+	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
 };
 
 #define ZL_RANGE_OFFSET		0x80
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fde5c8371fbd2..b6f22ee1c0bd1 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -32,11 +32,13 @@ struct zl3073x_dpll;
 
 enum zl3073x_flags {
 	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
+	ZL3073X_FLAG_DIE_TEMP_BIT,
 	ZL3073X_FLAGS_NBITS /* must be last */
 };
 
 #define __ZL3073X_FLAG(name)	BIT(ZL3073X_FLAG_ ## name ## _BIT)
 #define ZL3073X_FLAG_REF_PHASE_COMP_32	__ZL3073X_FLAG(REF_PHASE_COMP_32)
+#define ZL3073X_FLAG_DIE_TEMP		__ZL3073X_FLAG(DIE_TEMP)
 
 /**
  * struct zl3073x_chip_info - chip variant identification
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index aaa14ea5e670f..c201c974a7f9a 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1065,6 +1065,25 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+static int
+zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
+		      s32 *temp, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u16 val;
+	int rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_DIE_TEMP_STATUS, &val);
+	if (rc)
+		return rc;
+
+	/* Register value is in units of 0.1 C, convert to millidegrees */
+	*temp = (s16)val * 100;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 			     enum dpll_lock_status *status,
@@ -1671,6 +1690,10 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
 				       dpll_mode_refsel);
 
+	zldpll->ops = zl3073x_dpll_device_ops;
+	if (zldev->info->flags & ZL3073X_FLAG_DIE_TEMP)
+		zldpll->ops.temp_get = zl3073x_dpll_temp_get;
+
 	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
 					   THIS_MODULE, &zldpll->tracker);
 	if (IS_ERR(zldpll->dpll_dev)) {
@@ -1682,7 +1705,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 
 	rc = dpll_device_register(zldpll->dpll_dev,
 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
-				  &zl3073x_dpll_device_ops, zldpll);
+				  &zldpll->ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 		zldpll->dpll_dev = NULL;
@@ -1705,8 +1728,7 @@ zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 
 	cancel_work_sync(&zldpll->change_work);
 
-	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
-			       zldpll);
+	dpll_device_unregister(zldpll->dpll_dev, &zldpll->ops, zldpll);
 	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 	zldpll->dpll_dev = NULL;
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index c65c798c37927..278a24f357c9b 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -17,6 +17,7 @@
  * @forced_ref: selected reference in forced reference lock mode
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
+ * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
  * @lock_status: last saved DPLL lock status
@@ -31,6 +32,7 @@ struct zl3073x_dpll {
 	u8				forced_ref;
 	u8				check_count;
 	bool				phase_monitor;
+	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 5573d7188406b..19c598daa784c 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -78,6 +78,8 @@
 #define ZL_REG_RESET_STATUS			ZL_REG(0, 0x18, 1)
 #define ZL_REG_RESET_STATUS_RESET		BIT(0)
 
+#define ZL_REG_DIE_TEMP_STATUS			ZL_REG(0, 0x44, 2)
+
 /*************************
  * Register Page 2, Status
  *************************/
-- 
2.52.0


