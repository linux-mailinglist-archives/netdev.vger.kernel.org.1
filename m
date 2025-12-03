Return-Path: <netdev+bounces-243401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA005C9F028
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796B43A8249
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52302ED860;
	Wed,  3 Dec 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="giw2136O"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3808F29D287;
	Wed,  3 Dec 2025 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765396; cv=none; b=lYZeZFvvbxOesguTvSx/L8fd+KO8zYwprf/5aB0Vci4Unmvz5+SXvjkXxS1JimgycYirm+A09kAuLIMVfUMLJPcaKET3g8AHAJ/O0vjL+y6wz8I5Q4LfWSxe440uf4eLRN0zeoh+/QAyXHld4tDozSXNJNk/SLygBPen6+3MExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765396; c=relaxed/simple;
	bh=gHUNVDU3N1hEjFbJLl4sHasCN7YFQFOtwcoxGOdXA6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYJZu4CuxricyJW11EQWOf3HTgLqlmvbVVUbe6/jK04cm6wFpmtPnBLJAKq+TSE5y2oDiCNx2/eWt/ucJcHOXxRpygl205FLmtL9xmB8ydml09Q9L3AgnVLVLBhUgaHrAjsZKN6SXnw8N7oGN2/YhVI374sxhKb7Zq/LlfT+zvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=giw2136O; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764765394; x=1796301394;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TLNYESu6GxWmK0LY4k7boZAKOI2Fl9y7qskg7D2ck0s=;
  b=giw2136OBY8Zi4U4KIbX7IX0EDtTLFeihQDCrFCcaWqxRqXH1iRJCFZK
   ssujsSRBNXT2diznH1YU8/tbp89yPaVrw7vvZuLLcVuhjgEVVzYudlBAD
   3xHNP+2i5lUXIuh0fuWf7W42Q1dbraU6QMPBebRrWb/Cn+kiBMpisbRa3
   IZLp5YtcScjc9bJ1Srepk79fHXeRAH0XRuLzOgyTsuJbU7i3Xi1bDT794
   EVChRSn9vPrrrx44wsmezV9eAFvQKzI4SpCgus1Vo4lDV6mZ/xz4Fkfoz
   v7zuk6IlmJa+y/tYNDF5bPGAMa3NYK2Rp2f911uxQRSPiST/5g4Qg7zF5
   Q==;
X-CSE-ConnectionGUID: 79aF+VrxS3yksHB4L66Cjw==
X-CSE-MsgGUID: uXHPD/aXRvy5Vo3SYPU4+w==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="6055418"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 12:36:27 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:23790]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.9.5:2525] with esmtp (Farcaster)
 id 827ca981-2f1d-4aa5-911c-173414c3de91; Wed, 3 Dec 2025 12:36:27 +0000 (UTC)
X-Farcaster-Flow-ID: 827ca981-2f1d-4aa5-911c-173414c3de91
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:36:26 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:36:26 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Wed, 3 Dec 2025 12:36:26 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chalios,
 Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: [PATCH v3 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Topic: [PATCH v3 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Index: AQHcZFFw3kvyjXEKIk25GTIOzzoF6A==
Date: Wed, 3 Dec 2025 12:36:26 +0000
Message-ID: <20251203123539.7292-5-bchalios@amazon.es>
References: <20251203123539.7292-1-bchalios@amazon.es>
In-Reply-To: <20251203123539.7292-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: David Woodhouse <dwmw@amazon.co.uk>=0A=
=0A=
Add device tree support to the ptp_vmclock driver, allowing it to probe=0A=
via device tree in addition to ACPI.=0A=
=0A=
Handle optional interrupt for clock disruption notifications, mirroring=0A=
the ACPI notification behavior.=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 drivers/ptp/ptp_vmclock.c | 69 +++++++++++++++++++++++++++++++++++----=0A=
 1 file changed, 63 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index 49a17435bd35..349582f1ccc3 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -14,10 +14,12 @@=0A=
 #include <linux/file.h>=0A=
 #include <linux/fs.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/interrupt.h>=0A=
 #include <linux/kernel.h>=0A=
 #include <linux/miscdevice.h>=0A=
 #include <linux/mm.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/of.h>=0A=
 #include <linux/platform_device.h>=0A=
 #include <linux/slab.h>=0A=
 =0A=
@@ -536,7 +538,7 @@ vmclock_acpi_notification_handler(acpi_handle __always_=
unused handle,=0A=
 	wake_up_interruptible(&st->disrupt_wait);=0A=
 }=0A=
 =0A=
-static int vmclock_setup_notification(struct device *dev, struct vmclock_s=
tate *st)=0A=
+static int vmclock_setup_acpi_notification(struct device *dev)=0A=
 {=0A=
 	struct acpi_device *adev =3D ACPI_COMPANION(dev);=0A=
 	acpi_status status;=0A=
@@ -549,10 +551,6 @@ static int vmclock_setup_notification(struct device *d=
ev, struct vmclock_state *=0A=
 	if (!adev)=0A=
 		return -ENODEV;=0A=
 =0A=
-	/* The device does not support notifications. Nothing else to do */=0A=
-	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))=
=0A=
-		return 0;=0A=
-=0A=
 	status =3D acpi_install_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,=
=0A=
 					     vmclock_acpi_notification_handler,=0A=
 					     dev);=0A=
@@ -587,6 +585,58 @@ static int vmclock_probe_acpi(struct device *dev, stru=
ct vmclock_state *st)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *d=
ev)=0A=
+{=0A=
+	struct device *device =3D dev;=0A=
+	struct vmclock_state *st =3D device->driver_data;=0A=
+=0A=
+	wake_up_interruptible(&st->disrupt_wait);=0A=
+	return IRQ_HANDLED;=0A=
+}=0A=
+=0A=
+static int vmclock_probe_dt(struct device *dev, struct vmclock_state *st)=
=0A=
+{=0A=
+	struct platform_device *pdev =3D to_platform_device(dev);=0A=
+	struct resource *res;=0A=
+=0A=
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);=0A=
+	if (!res)=0A=
+		return -ENODEV;=0A=
+=0A=
+	st->res =3D *res;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int vmclock_setup_of_notification(struct device *dev)=0A=
+{=0A=
+	struct platform_device *pdev =3D to_platform_device(dev);=0A=
+	int irq;=0A=
+=0A=
+	irq =3D platform_get_irq(pdev, 0);=0A=
+	if (irq < 0)=0A=
+		return irq;=0A=
+=0A=
+	return devm_request_irq(dev, irq, vmclock_of_irq_handler, IRQF_SHARED,=0A=
+				"vmclock", dev);=0A=
+}=0A=
+=0A=
+static int vmclock_setup_notification(struct device *dev,=0A=
+				      struct vmclock_state *st)=0A=
+{=0A=
+	/* The device does not support notifications. Nothing else to do */=0A=
+	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))=
=0A=
+		return 0;=0A=
+=0A=
+	if (has_acpi_companion(dev)) {=0A=
+		return vmclock_setup_acpi_notification(dev);=0A=
+	} else {=0A=
+		return vmclock_setup_of_notification(dev);=0A=
+	}=0A=
+=0A=
+}=0A=
+=0A=
+=0A=
 static void vmclock_put_idx(void *data)=0A=
 {=0A=
 	struct vmclock_state *st =3D data;=0A=
@@ -607,7 +657,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 	if (has_acpi_companion(dev))=0A=
 		ret =3D vmclock_probe_acpi(dev, st);=0A=
 	else=0A=
-		ret =3D -EINVAL; /* Only ACPI for now */=0A=
+		ret =3D vmclock_probe_dt(dev, st);=0A=
 =0A=
 	if (ret) {=0A=
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);=0A=
@@ -707,11 +757,18 @@ static const struct acpi_device_id vmclock_acpi_ids[]=
 =3D {=0A=
 };=0A=
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);=0A=
 =0A=
+static const struct of_device_id vmclock_of_ids[] =3D {=0A=
+	{ .compatible =3D "amazon,vmclock", },=0A=
+	{ },=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, vmclock_of_ids);=0A=
+=0A=
 static struct platform_driver vmclock_platform_driver =3D {=0A=
 	.probe		=3D vmclock_probe,=0A=
 	.driver	=3D {=0A=
 		.name	=3D "vmclock",=0A=
 		.acpi_match_table =3D vmclock_acpi_ids,=0A=
+		.of_match_table =3D vmclock_of_ids,=0A=
 	},=0A=
 };=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

