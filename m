Return-Path: <netdev+bounces-245362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB050CCC45D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45BDD30521CD
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A88296BC2;
	Thu, 18 Dec 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="N+Z5RQsS"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB20288525;
	Thu, 18 Dec 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067900; cv=none; b=h2vu02x8DTtvVnqYmaCb3Pn/RHZ2Lz69b/Rt8/7oZouUc1CzbhZ2FqnQ7G+rYMPrI7v4G7W1hcDa+oWkerWL8cqkguW1KBd6d2fC7QEaiQmWokMqTl0If9bKQW5Rr50Gyzoa7jed+//ALXaCsOBr3RfUdiLa4cxwx+HPuiLY1Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067900; c=relaxed/simple;
	bh=ZM8Mh6XKcsp85XAh9FBxfHZ8zVIs/Lxiy8Bb1gYMLjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcRIZrOXvWPr6pn1cBUBGOUq5cxnBQ0RBlG5anlx+6vHKmnXGimDmgUavBP/P3ZvuGwAKuEz0ZUSNuOX1My+UoyJVKZEAf0vGaHxncKM2b5KMyLRg/uCJCVibtGXYaUdYHgr80YUmcTImwWQ+IWZR8EStOIlGRFjk7Z0AITleAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=N+Z5RQsS; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067899; x=1797603899;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4EMiDSjVmu6In/15EIdW1ZCQ9T5sq65f9TosluRSB3o=;
  b=N+Z5RQsSR8fizOQWkSc37bV4JNuzWquIcS0ykF+cMOjCAuIMiV7hrvD/
   j6ttRJA1EtIEywabmI69MDnD9DVRVZifLJz5Ia5JSG/F9Z0wJJ0qeLZ5N
   2zP/8KggVm4Vp4yYGFYH8SEOGJ1hI8eRbY6F+tzFF9V4F1lWDnhAUET+E
   vrD1LmzcmEinDORfjZFTSFVDeUJlZkLM/gk8N2H2/vA9QOCv/r4NBz2eh
   gZgpco0fgd37rXiFW9IYIrvH82zi4BYLovFkwIFPsAYAoCsARsiGg+oai
   7ccTz14aFw9y2sThqDj8Q2d6pi3Y3q5+i5AtKarFOupuHaqKBb0bZabUE
   A==;
X-CSE-ConnectionGUID: JvH0Y+z8ROKVVzxNkI8f2w==
X-CSE-MsgGUID: O0y7q97IQHOjYe8TbSGq0A==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6788051"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:24:56 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:21201]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.13.110:2525] with esmtp (Farcaster)
 id e04a56a0-8669-4218-8405-6a88111be484; Thu, 18 Dec 2025 14:24:56 +0000 (UTC)
X-Farcaster-Flow-ID: e04a56a0-8669-4218-8405-6a88111be484
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:24:56 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:24:55 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:24:55 +0000
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
Subject: [PATCH v4 4/7] ptp: ptp_vmclock: Add device tree support
Thread-Topic: [PATCH v4 4/7] ptp: ptp_vmclock: Add device tree support
Thread-Index: AQHccCoUx7x4E5wAHEOFKrzcDiL5jA==
Date: Thu, 18 Dec 2025 14:24:55 +0000
Message-ID: <20251218142408.8395-5-bchalios@amazon.es>
References: <20251218142408.8395-1-bchalios@amazon.es>
In-Reply-To: <20251218142408.8395-1-bchalios@amazon.es>
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
 drivers/ptp/ptp_vmclock.c | 71 ++++++++++++++++++++++++++++++++++-----=0A=
 1 file changed, 63 insertions(+), 8 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index a203386c4b09..831668efabf9 100644=0A=
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
@@ -587,6 +585,57 @@ static int vmclock_probe_acpi(struct device *dev, stru=
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
@@ -607,7 +656,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 	if (has_acpi_companion(dev))=0A=
 		ret =3D vmclock_probe_acpi(dev, st);=0A=
 	else=0A=
-		ret =3D -EINVAL; /* Only ACPI for now */=0A=
+		ret =3D vmclock_probe_dt(dev, st);=0A=
 =0A=
 	if (ret) {=0A=
 		dev_info(dev, "Failed to obtain physical address: %d\n", ret);=0A=
@@ -655,6 +704,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 		return ret;=0A=
 =0A=
 	init_waitqueue_head(&st->disrupt_wait);=0A=
+	dev->driver_data =3D st;=0A=
 	ret =3D vmclock_setup_notification(dev, st);=0A=
 	if (ret)=0A=
 		return ret;=0A=
@@ -691,8 +741,6 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 		return -ENODEV;=0A=
 	}=0A=
 =0A=
-	dev->driver_data =3D st;=0A=
-=0A=
 	dev_info(dev, "%s: registered %s%s%s\n", st->name,=0A=
 		 st->miscdev.minor ? "miscdev" : "",=0A=
 		 (st->miscdev.minor && st->ptp_clock) ? ", " : "",=0A=
@@ -707,11 +755,18 @@ static const struct acpi_device_id vmclock_acpi_ids[]=
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

