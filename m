Return-Path: <netdev+bounces-247756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB44CFDECD
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B941B30049FC
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3959533F8BE;
	Wed,  7 Jan 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="HLVVXl3q"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.199.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC433F39A;
	Wed,  7 Jan 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.199.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792436; cv=none; b=Bp5802bhZAyWeXe0uHHAUceItD2FiiLh9tgBrBvo4EGPCXagBy38B+iZHjBgR5RMhNbofWhi0mtXtoDPXHgXg1s5wxhJup9xi9mGgG3xL4g8i4AzZGSxe6wiJwQ2coxh161x1DiWViSyQlZXk/AwJqHiHsHMkKIq7J1vocH55s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792436; c=relaxed/simple;
	bh=Gmj9IBI+t/VW0oik5zPH7gkOEWiT4SWSyQDx1QVMrFY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lURxARfipGE1oZBMcslETic9aeI+Vpz/rF06fVfAdJSTl55sqPnAi+r1ew3kMP7AQU2Xj5EGcQkpcnABXBRS6GB9iuHamJt7DoljUPUbN8wsTRDrn9U6Et52h8CpF/r2fYBCO9wvRSlhm3GqbzRJwm8Z5F7S0AkQyK7/wHGRPAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=HLVVXl3q; arc=none smtp.client-ip=18.199.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792434; x=1799328434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zAXY52N8gXlIv3/t+EXjSdtsrE1TaG1NoRSb+1+uVkM=;
  b=HLVVXl3q3DUvrugHv5i9XA1H349j9g1tNE4RoDYjWuNWZ9p7gmUD/OL/
   aVnzHAiOgZTiSCUDvOIK9+DYAzyILM3/zMG6asij67n8hJRcSPObR57Ub
   DVUqPT1aCNkYGEC1m+U2lP1sQCRTlcedaMmM6JFb8muIlDf5COHRmIpRP
   yWQfmf926QNawaNay8wYKkuUL4AIP//oegAghmfGfsDnQI3aDrtXXHrBj
   HY37SFitGgD5KBhfq3cwPmhOrS9Obp12MAx9xim3e4UdCGUHYLw5iLj5h
   QhC/Bsx7h9Ub6jEUOTlAJTvWFG1Jdf6kgkaATvWyksDU8nFWJBACjf9L5
   Q==;
X-CSE-ConnectionGUID: gcg0zxIKQIKm74NTMMnsUQ==
X-CSE-MsgGUID: 1iQNDammTF2HNm0SOIoCww==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7486104"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-014.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:26:03 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:30606]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.35.222:2525] with esmtp (Farcaster)
 id 53d8d61f-0453-4ecf-9d89-1d64c54a7498; Wed, 7 Jan 2026 13:26:03 +0000 (UTC)
X-Farcaster-Flow-ID: 53d8d61f-0453-4ecf-9d89-1d64c54a7498
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:01 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:01 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:26:01 +0000
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
Subject: [PATCH v5 4/7] ptp: ptp_vmclock: Add device tree support
Thread-Topic: [PATCH v5 4/7] ptp: ptp_vmclock: Add device tree support
Thread-Index: AQHcf9kqLkJgPArGVUiIcSiHYNwkwQ==
Date: Wed, 7 Jan 2026 13:26:01 +0000
Message-ID: <20260107132514.437-5-bchalios@amazon.es>
References: <20260107132514.437-1-bchalios@amazon.es>
In-Reply-To: <20260107132514.437-1-bchalios@amazon.es>
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
the ACPI notification behaviour.=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 drivers/ptp/ptp_vmclock.c | 72 ++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 64 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index 38b2bacb755e..801e14cc4799 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -14,10 +14,13 @@=0A=
 #include <linux/file.h>=0A=
 #include <linux/fs.h>=0A=
 #include <linux/init.h>=0A=
+#include <linux/io.h>=0A=
+#include <linux/interrupt.h>=0A=
 #include <linux/kernel.h>=0A=
 #include <linux/miscdevice.h>=0A=
 #include <linux/mm.h>=0A=
 #include <linux/module.h>=0A=
+#include <linux/of.h>=0A=
 #include <linux/platform_device.h>=0A=
 #include <linux/slab.h>=0A=
 =0A=
@@ -535,7 +538,7 @@ vmclock_acpi_notification_handler(acpi_handle __always_=
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
@@ -548,10 +551,6 @@ static int vmclock_setup_notification(struct device *d=
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
@@ -586,6 +585,57 @@ static int vmclock_probe_acpi(struct device *dev, stru=
ct vmclock_state *st)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_=
st)=0A=
+{=0A=
+	struct vmclock_state *st =3D _st;=0A=
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
+				"vmclock", dev->driver_data);=0A=
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
@@ -606,7 +656,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 	if (has_acpi_companion(dev))=0A=
 		ret =3D vmclock_probe_acpi(dev, st);=0A=
 	else=0A=
-		ret =3D -EINVAL; /* Only ACPI for now */=0A=
+		ret =3D vmclock_probe_dt(dev, st);=0A=
 =0A=
 	if (ret) {=0A=
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);=0A=
@@ -654,6 +704,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 		return ret;=0A=
 =0A=
 	init_waitqueue_head(&st->disrupt_wait);=0A=
+	dev->driver_data =3D st;=0A=
 	ret =3D vmclock_setup_notification(dev, st);=0A=
 	if (ret)=0A=
 		return ret;=0A=
@@ -690,8 +741,6 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 		return -ENODEV;=0A=
 	}=0A=
 =0A=
-	dev->driver_data =3D st;=0A=
-=0A=
 	dev_info(dev, "%s: registered %s%s%s\n", st->name,=0A=
 		 st->miscdev.minor ? "miscdev" : "",=0A=
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",=0A=
@@ -706,11 +755,18 @@ static const struct acpi_device_id vmclock_acpi_ids[]=
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

