Return-Path: <netdev+bounces-245365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33884CCC502
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464A730D9E5C
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1101B2DF125;
	Thu, 18 Dec 2025 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="d9JrvEcO"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.74.81.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172342DC32B;
	Thu, 18 Dec 2025 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.74.81.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067951; cv=none; b=ct4JgHvnTxVfQvkpvG2Ur6D8dOowZR0cVTsoRuAxWeUSa8ILvHo3nJWoKd3RdUmBe1AsPvKwxoAUmHv8CSqVz0aWxzVyhClJofytZhuTkk4uyCG6ZwF0G3xdTH3kWnWrrLBoV4F+tGcDcCP2ktypsyvIzS9JHhWpEVWceunFvww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067951; c=relaxed/simple;
	bh=T2ggPKYPQPRgI74dDuIowfmH1GVhGWrmf+5GD2Vzkww=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MXFLpgNZVQwQNA8O5dedgDW6zwyux2TTgr6HJ2w1aaJ05Cc7woCrhPAj43C2qqxqeuih0KAhcSIWC3O3/thEibBDs+VGG8HQ9slPWVLbkrrdBZFmLHhfwP+U0/vyLRK3r9dB2crLeremd94slzaIAGqyzRu03Ty3Mp44iVKdEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=d9JrvEcO; arc=none smtp.client-ip=3.74.81.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067937; x=1797603937;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eX1BlzBZcpcq5UCX3he8NfSe96USHRMlSLSkgG/gw8c=;
  b=d9JrvEcOMeoVZ5f1eBBS6QHy+BfjFMwz807ap/6Nkg3BO3Y1KybB7r2r
   yptq2prjNQ3CeOSAZuC4sBsSIcRF54FJUF5XQsd8DIO0SqOp9hQkg+FYU
   U9aMNYzc+W8vnvWxBl5FxcIEXf2GT83L4LaET6xNuS1qOYsiMAOQSmJmM
   nL5LMBSItarNfGCjmLEG/TFRdY+UAl2lO6v74LCmDwrgW8Y9wwBcjh1Ay
   R8valW7UFokqHE4LrHVh5TWMuj4ZTlWU8p2vMJ+5bfva/5i29JEAt60tY
   KnpoCxVDFpzDq7bUtwV66qYYkfyM4NiUoaS8N5Yh4jvQwtStIsNUSUrxP
   g==;
X-CSE-ConnectionGUID: OBFXa7PWTtKfiKhmAEm5HA==
X-CSE-MsgGUID: YGQfgYgtTJWUWeU9AYno4A==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6900376"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-004.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:25:19 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:16366]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.34.225:2525] with esmtp (Farcaster)
 id 1c7f2c05-75bd-4440-af85-932141dcb152; Thu, 18 Dec 2025 14:25:19 +0000 (UTC)
X-Farcaster-Flow-ID: 1c7f2c05-75bd-4440-af85-932141dcb152
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:25:18 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:25:18 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:25:18 +0000
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
Subject: [PATCH v4 6/7] ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
Thread-Topic: [PATCH v4 6/7] ptp: ptp_vmclock: remove dependency on
 CONFIG_ACPI
Thread-Index: AQHccCoi/1qVrFTZe0SEBwT77yHXiw==
Date: Thu, 18 Dec 2025 14:25:18 +0000
Message-ID: <20251218142408.8395-7-bchalios@amazon.es>
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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 drivers/ptp/Kconfig       |  2 +-=0A=
 drivers/ptp/ptp_vmclock.c | 13 ++++++++-----=0A=
 2 files changed, 9 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig=0A=
index 5f8ea34d11d6..b93640ca08b7 100644=0A=
--- a/drivers/ptp/Kconfig=0A=
+++ b/drivers/ptp/Kconfig=0A=
@@ -134,7 +134,7 @@ config PTP_1588_CLOCK_KVM=0A=
 config PTP_1588_CLOCK_VMCLOCK=0A=
 	tristate "Virtual machine PTP clock"=0A=
 	depends on X86_TSC || ARM_ARCH_TIMER=0A=
-	depends on PTP_1588_CLOCK && ACPI && ARCH_SUPPORTS_INT128=0A=
+	depends on PTP_1588_CLOCK && ARCH_SUPPORTS_INT128=0A=
 	default PTP_1588_CLOCK_KVM=0A=
 	help=0A=
 	  This driver adds support for using a virtual precision clock=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index ef945e8248ee..7f342e5a6a92 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -501,6 +501,7 @@ static void vmclock_remove(void *data)=0A=
 		misc_deregister(&st->miscdev);=0A=
 }=0A=
 =0A=
+#ifdef CONFIG_ACPI=0A=
 static acpi_status vmclock_acpi_resources(struct acpi_resource *ares, void=
 *data)=0A=
 {=0A=
 	struct vmclock_state *st =3D data;=0A=
@@ -584,6 +585,7 @@ static int vmclock_probe_acpi(struct device *dev, struc=
t vmclock_state *st)=0A=
 =0A=
 	return 0;=0A=
 }=0A=
+#endif /* CONFIG_ACPI */=0A=
 =0A=
 static irqreturn_t vmclock_of_irq_handler(int __always_unused irq, void *_=
st)=0A=
 {=0A=
@@ -627,12 +629,11 @@ static int vmclock_setup_notification(struct device *=
dev,=0A=
 	if (!(le64_to_cpu(st->clk->flags) & VMCLOCK_FLAG_NOTIFICATION_PRESENT))=
=0A=
 		return 0;=0A=
 =0A=
-	if (has_acpi_companion(dev)) {=0A=
+#ifdef CONFIG_ACPI=0A=
+	if (has_acpi_companion(dev))=0A=
 		return vmclock_setup_acpi_notification(dev);=0A=
-	} else {=0A=
-		return vmclock_setup_of_notification(dev);=0A=
-	}=0A=
-=0A=
+#endif=0A=
+	return vmclock_setup_of_notification(dev);=0A=
 }=0A=
 =0A=
 =0A=
@@ -653,9 +654,11 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 	if (!st)=0A=
 		return -ENOMEM;=0A=
 =0A=
+#ifdef CONFIG_ACPI=0A=
 	if (has_acpi_companion(dev))=0A=
 		ret =3D vmclock_probe_acpi(dev, st);=0A=
 	else=0A=
+#endif=0A=
 		ret =3D vmclock_probe_dt(dev, st);=0A=
 =0A=
 	if (ret) {=0A=
-- =0A=
2.34.1=0A=
=0A=

