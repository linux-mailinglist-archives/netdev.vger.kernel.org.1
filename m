Return-Path: <netdev+bounces-228235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C05BC5683
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAEC54E10CD
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442C1298CA2;
	Wed,  8 Oct 2025 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpEfhpHf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F719F115
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932897; cv=none; b=D42x5/HJYfmokntN1khRgdD6Ql8INZOB+d0EqpUZISK40V428qdGpaxerRsG89IQ1NN4DaKamg6S75iHykQwF2kJZpjPS3P0kPl/4JJ5m6t8h3tb/pMHiy+0V/DvfOCxPVAb6ogDUCeu7mY15/Y0rZmPBjon+MdmgLGLXDgipsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932897; c=relaxed/simple;
	bh=HUTvihCmklt+sstzIY6HzW565nJhZcYT4rJEtEIVljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sd9lPF4MnSfGpfQKwr8KFz0M77Jpdd0NakZkb8b9hWolyoEFbreB3w5ikJWZXEO1gWC1WT4qFHjSGxK9JF9bfkSzduzyO5OKQzkqUZ7r06E1zLotuqsLd/6pFMOk2NzSrF5YX4KqUZf4N3htz7tGUlyQQmTf8zkYs21sZ2aTguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpEfhpHf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759932894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4UESpQ82rYG/usUfnOSQIXuNtS6mZs6hqNHW1t9lVjY=;
	b=UpEfhpHfpUFKbnC2tu0azt8i1aSegqgXGi7uGoecCMh+Fg+403TtXXS4yf4iPOdXrcDkZ+
	VadpK2Fz2DHo82X7voAX6xKRiJnKVpSTw8PkOmhH1linyP9h++WC3MRcns4IdJzPukhxH4
	TvAjJjGpUZQutB/6NlFWS8rwQoOPXx4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-OuodJBr5Nz6hAodBQ1RP5A-1; Wed,
 08 Oct 2025 10:14:51 -0400
X-MC-Unique: OuodJBr5Nz6hAodBQ1RP5A-1
X-Mimecast-MFC-AGG-ID: OuodJBr5Nz6hAodBQ1RP5A_1759932890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CE771800357;
	Wed,  8 Oct 2025 14:14:49 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8E5A1800446;
	Wed,  8 Oct 2025 14:14:46 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Prathosh Satish <Prathosh.Satish@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] dpll: zl3073x: Handle missing or corrupted flash configuration
Date: Wed,  8 Oct 2025 16:14:45 +0200
Message-ID: <20251008141445.841113-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If the internal flash contains missing or corrupted configuration,
basic communication over the bus still functions, but the device
is not capable of normal operation (for example, using mailboxes).

This condition is indicated in the info register by the ready bit.
If this bit is cleared, the probe procedure times out while fetching
the device state.

Handle this case by checking the ready bit value in zl3073x_dev_start()
and skipping DPLL device and pin registration if it is cleared.
Do not report this condition as an error, allowing the devlink device
to be registered and enabling the user to flash the correct configuration.

Prior this patch:
[   31.112299] zl3073x-i2c 1-0070: Failed to fetch input state: -ETIMEDOUT
[   31.116332] zl3073x-i2c 1-0070: error -ETIMEDOUT: Failed to start device
[   31.136881] zl3073x-i2c 1-0070: probe with driver zl3073x-i2c failed with error -110

After this patch:
[   41.011438] zl3073x-i2c 1-0070: FW not fully ready - missing or corrupted config

Fixes: 75a71ecc24125 ("dpll: zl3073x: Register DPLL devices and pins")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/core.c | 21 +++++++++++++++++++++
 drivers/dpll/zl3073x/regs.h |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 092e7027948a..e42e527813cf 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -1038,8 +1038,29 @@ zl3073x_dev_phase_meas_setup(struct zl3073x_dev *zldev)
 int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full)
 {
 	struct zl3073x_dpll *zldpll;
+	u8 info;
 	int rc;
 
+	rc = zl3073x_read_u8(zldev, ZL_REG_INFO, &info);
+	if (rc) {
+		dev_err(zldev->dev, "Failed to read device status info\n");
+		return rc;
+	}
+
+	if (!FIELD_GET(ZL_INFO_READY, info)) {
+		/* The ready bit indicates that the firmware was successfully
+		 * configured and is ready for normal operation. If it is
+		 * cleared then the configuration stored in flash is wrong
+		 * or missing. In this situation the driver will expose
+		 * only devlink interface to give an opportunity to flash
+		 * the correct config.
+		 */
+		dev_info(zldev->dev,
+			 "FW not fully ready - missing or corrupted config\n");
+
+		return 0;
+	}
+
 	if (full) {
 		/* Fetch device state */
 		rc = zl3073x_dev_state_fetch(zldev);
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 19a25325bd9c..d837bee72b17 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -67,6 +67,9 @@
  * Register Page 0, General
  **************************/
 
+#define ZL_REG_INFO				ZL_REG(0, 0x00, 1)
+#define ZL_INFO_READY				BIT(7)
+
 #define ZL_REG_ID				ZL_REG(0, 0x01, 2)
 #define ZL_REG_REVISION				ZL_REG(0, 0x03, 2)
 #define ZL_REG_FW_VER				ZL_REG(0, 0x05, 2)
-- 
2.49.1


