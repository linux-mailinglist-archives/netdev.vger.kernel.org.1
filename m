Return-Path: <netdev+bounces-243316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2523BC9CE15
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB5A94E48F7
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD72F12CC;
	Tue,  2 Dec 2025 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="c17NsUMO"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8CB2F12C5;
	Tue,  2 Dec 2025 20:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706353; cv=none; b=cUzyX522ILxwwdALKtBW61siHeY5IySD6PEXYIdRBb56EZ4JVdoRLblHzcvm+61zSVyu7Eg8CpofDxD7g0KrJamIe4GXzEniDlnSN9Vos5I+HVaOb9eH4c2ck+SgLZ6ziaOJIj0aGeVBx7cCVTsycNy2cIS5LHx0phmH0rCLNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706353; c=relaxed/simple;
	bh=AOaiu2tMawVBD0mZxdxa9p7svFZnda8T89m0tVUD3LE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KH9A3wlEkh/yZCthXDNhzmlU6inJNisKOPnM/JdXeXUTAEway4D5ULf6RWmzYNPZayG4Dko/2PioQ9h96aLF26EzPJ9tYEG8R7W2iRcxIwTUWS8y2ywaIWg1jecMk9nbjaFI1r18R5iZzGHOML2OPOO5wJqVGmsZtCQJTfHJz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=c17NsUMO; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764706352; x=1796242352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zbbsCUZvcc0HWMG+iqOrpHdbOsL0drXWWmqWxPz+iJA=;
  b=c17NsUMOQvKz/md4dZssIphquJmBlP5aYQHauZ7ynbyh1lIbx10ZYDsj
   q8thTDhvLgGKTwdvJxgxdqFy6Jw+AaJUZZEujY0Gsc0oXRIXpTV3dFDaD
   APsAvbKxnoHc8IbkegkKHzB83woZYS24Vd1tI9ollX8vOdeOgPupUU4sl
   Gh1Da9cg7jTcz3t3S+2X/IBbh4m5xqN9ndkr+/t8W1ABQkLe48a0k0FHW
   Ki1VaiKg+g+eDWxrS3eLj6No/MP32dHuMpv8FEsL2BCFmXKRoEImsBBL8
   P5/ZrE20jSZdtNtvLUuMKvm2Xkn/xpLlSBG3Vz0O1hdB+luC1A9KyK7f1
   g==;
X-CSE-ConnectionGUID: VS4+5G4ySkqrHmdcSGjltw==
X-CSE-MsgGUID: 3GSuVhiAS52a+oO6o4FY7A==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6035275"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:12:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:24061]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.9.5:2525] with esmtp (Farcaster)
 id da84706e-e464-4186-9cc2-e593722a54cd; Tue, 2 Dec 2025 20:12:08 +0000 (UTC)
X-Farcaster-Flow-ID: da84706e-e464-4186-9cc2-e593722a54cd
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:12:08 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:12:07 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 20:12:07 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Subject: [PATCH v2 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Topic: [PATCH v2 4/4] ptp: ptp_vmclock: Add device tree support
Thread-Index: AQHcY8fv2rka6hdwsk+0SPLJdAw4NA==
Date: Tue, 2 Dec 2025 20:12:07 +0000
Message-ID: <20251202201118.20209-5-bchalios@amazon.es>
References: <20251202201118.20209-1-bchalios@amazon.es>
In-Reply-To: <20251202201118.20209-1-bchalios@amazon.es>
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
index 49a17435bd35..1af50e06e212 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -18,6 +18,7 @@=0A=
 #include <linux/miscdevice.h>=0A=
 #include <linux/mm.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/of.h>=0A=
 #include <linux/platform_device.h>=0A=
 #include <linux/slab.h>=0A=
 =0A=
@@ -536,7 +537,7 @@ vmclock_acpi_notification_handler(acpi_handle __always_=
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
@@ -549,10 +550,6 @@ static int vmclock_setup_notification(struct device *d=
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
@@ -587,6 +584,59 @@ static int vmclock_probe_acpi(struct device *dev, stru=
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
+	int irq, ret;=0A=
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

