Return-Path: <netdev+bounces-188712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAAAAE4E1
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E40918852A0
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791F28AAF9;
	Wed,  7 May 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ws+R85N6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B841028A417
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 15:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746631895; cv=none; b=sy157E9xjvDrhTJ/KE6fdBLlsfMmFgiq9xYF3EzR7PekAHHcwwe+/Io9rw7ew6H59nABDN32ASBbCsVvJmDuJAJE769tlY9BiTrKPC4Yo7hYLyAUZXZw+4lOG+gERBzuLbKUaa7UDBY+Qq25BN2CNH8oJhQyvmm29sdCEjPUkzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746631895; c=relaxed/simple;
	bh=P+p77vaVQNYnmbrBRlIyvDcqqxfBJkttL5DXvAYjtSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/+ebr1OOXaNXqNmVUqc1UUYr+1GzVRK9F4YIk6p2oD6H0dj2JBfU1/JzlSAEU+VHayotaN7IJ9uSXwmhaLDtKkJ5iYzs6aZyULdSm/ffl07TpUu1a/2hHo/K25kDXobRfURRzeNz7j4AHDMHF7GFCdH8vkKLIH3qJ4+DrJqAjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ws+R85N6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746631892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLxj2QygD6Gp9hDwO+6b7JcKsILEBaEBEmsGWzQFDcw=;
	b=Ws+R85N6w85/+ut50lnSsIK4Hc3JfiedMFe5CzNPy0olaEDGD3Mfp/8zp0w7ruc2ztW0ON
	gklAmqj+//J7p8gDTCEkgs0/2N2sDfjROCLvdr5D10A3pDT0tfJacD9nMrLfWae237KaiQ
	B87IKzFjjr2601gwHPxZBcX56cBzr4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-6cXqvFlsMSWckMsePYzUDg-1; Wed,
 07 May 2025 11:31:29 -0400
X-MC-Unique: 6cXqvFlsMSWckMsePYzUDg-1
X-Mimecast-MFC-AGG-ID: 6cXqvFlsMSWckMsePYzUDg_1746631886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63C12180035C;
	Wed,  7 May 2025 15:25:42 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.33.91])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 279BE30001AA;
	Wed,  7 May 2025 15:25:36 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v8 5/8] mfd: zl3073x: Protect operations requiring multiple register accesses
Date: Wed,  7 May 2025 17:25:01 +0200
Message-ID: <20250507152504.85341-6-ivecera@redhat.com>
In-Reply-To: <20250507152504.85341-1-ivecera@redhat.com>
References: <20250507152504.85341-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Registers located on page 10 and above are called mailbox-type
registers. Each page represents a mailbox and is used to read from
and write to configuration of a specific object (DPLL, output,
reference or synth).

Each mailbox page contains a mask register, which selects an index of
the target object to interact with and a semaphore register, which
indicates the requested operation.

The remaining registers within the page are latch registers, which are
populated by the firmware during read operations or by the driver prior
to write operations.

Operations with these registers requires multiple register reads, writes
and polls and all of them need to be done atomically.

So add multiop_lock mutex to protect such operations and check the mutex
is held by the caller when it's accessing registers from page 10 and
above.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
v7->v8:
* no change
v6->v7:
* no change
v5->v6:
* no change
v4->v5:
* dropped mailbox API and replaced by an ability to protect multi-op
  accesses
v3->v4:
* completely reworked mailbox access
v1->v3:
* dropped ZL3073X_MB_OP macro usage
---
 drivers/mfd/zl3073x-core.c  | 14 ++++++++++++++
 include/linux/mfd/zl3073x.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mfd/zl3073x-core.c b/drivers/mfd/zl3073x-core.c
index 079550682510..a12cfc7eb6ff 100644
--- a/drivers/mfd/zl3073x-core.c
+++ b/drivers/mfd/zl3073x-core.c
@@ -121,6 +121,12 @@ static const struct regmap_config zl3073x_regmap_config = {
 static bool
 zl3073x_check_reg(struct zl3073x_dev *zldev, unsigned int reg, size_t size)
 {
+	/* Check that multiop lock is held when accessing registers
+	 * from page 10 and above.
+	 */
+	if (ZL_REG_PAGE(reg) >= 10)
+		lockdep_assert_held(&zldev->multiop_lock);
+
 	/* Check the index is in valid range for indexed register */
 	if (ZL_REG_OFFSET(reg) > ZL_REG_MAX_OFFSET(reg)) {
 		dev_err(zldev->dev, "Index out of range for reg 0x%04lx\n",
@@ -557,6 +563,14 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 		FIELD_GET(GENMASK(15, 8), cfg_ver),
 		FIELD_GET(GENMASK(7, 0), cfg_ver));
 
+	/* Initialize mutex for operations where multiple reads, writes
+	 * and/or polls are required to be done atomically.
+	 */
+	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
+	if (rc)
+		return dev_err_probe(zldev->dev, rc,
+				     "Failed to initialize mutex\n");
+
 	/* Register the device as devlink device */
 	devlink = priv_to_devlink(zldev);
 	devlink_register(devlink);
diff --git a/include/linux/mfd/zl3073x.h b/include/linux/mfd/zl3073x.h
index 8df10b82e3c2..a42a275577c4 100644
--- a/include/linux/mfd/zl3073x.h
+++ b/include/linux/mfd/zl3073x.h
@@ -3,6 +3,7 @@
 #ifndef __LINUX_MFD_ZL3073X_H
 #define __LINUX_MFD_ZL3073X_H
 
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 struct device;
@@ -12,10 +13,12 @@ struct regmap;
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
+ * @multiop_lock: to serialize multiple register operations
  */
 struct zl3073x_dev {
 	struct device		*dev;
 	struct regmap		*regmap;
+	struct mutex		multiop_lock;
 };
 
 /**********************
-- 
2.49.0


