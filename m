Return-Path: <netdev+bounces-247758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFBCFDF89
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E6983043230
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453A733A9CF;
	Wed,  7 Jan 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="E9L3e1/8"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B2332A3C8;
	Wed,  7 Jan 2026 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792474; cv=none; b=q5LR1HlDnsJyATl0N4IYmGQBfzqVFe9PdpNWqzDLjP0Wa1WhZmpLuOpBQzeU/1HMdzpRL1nThovtkovYX0Wf5SA1/D7Q3b5/llieC3vAtfFCbzoeVWFcvvkfFvNkGlLQ0QQkpCgIx053t7H6zZ7o8YrshKWoZcWa1l7bv0My+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792474; c=relaxed/simple;
	bh=Ti6DVNKmg5qGrzR6Izr3vZmPUKusU/KUZQ1En+vsk1Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Epx4tDgCYWGe/MQrvIiGzRe5ruh356riVL90V146IjpY1W/4FJRKZ0lbSxbfQwrkendSOOCIvXhQxjo+jzGq8AW8MF4/ekrrnxNn1/o6+4rItm6WV0Xh6lXWIrTVthUf8TQ84TqnN+8zDnb4EdgyJHzrx65Zr/voKndeU+/jFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=E9L3e1/8; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792472; x=1799328472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H3uGUXvOCuNhUduxo8F66wZPo+9zml7uMCM9YxnLfJc=;
  b=E9L3e1/8TEB1VzHxFrM+/LRCGG8QuGK7mVFQhnXRGpn6wXXQi2lfe5/s
   WuG7YakxmBwubEpftrCm28pDiAaOW3SBoqFiehrVlB9I0dzzYCCv961uU
   7OSBMmOMPTsXJ9bqj6DW+Tih1XvjVD0Nlw1HpVQfqkZiKmJvZQuJjbuYT
   32EcyhHYCbTbUsFoakypdgk/si5wGzjV2Tnydyrxnykv2ZHnIDiGHZLOE
   jFuxdwUiIMpLH2C6maBlk0FFlWazvF6o2LqOTjrdWYxYPP4YDagspDM6A
   4jajyHnlsSIlZo/C4bmmK8S8r1Z9rXK6VJONOxQ4XPlQYJewGZ5gJ9I5Q
   g==;
X-CSE-ConnectionGUID: znsjwAptRtSAZ/0fqfDxBQ==
X-CSE-MsgGUID: W1/19W8PS22GIPIm7R2qjw==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7583657"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:26:25 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:26786]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.4.21:2525] with esmtp (Farcaster)
 id 0b9a8df3-f540-4b78-b044-f04545756402; Wed, 7 Jan 2026 13:26:25 +0000 (UTC)
X-Farcaster-Flow-ID: 0b9a8df3-f540-4b78-b044-f04545756402
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:24 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:24 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:26:24 +0000
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
Subject: [PATCH v5 6/7] ptp: ptp_vmclock: remove dependency on CONFIG_ACPI
Thread-Topic: [PATCH v5 6/7] ptp: ptp_vmclock: remove dependency on
 CONFIG_ACPI
Thread-Index: AQHcf9k4ohKUWhGLDU2lPfhktO8/2Q==
Date: Wed, 7 Jan 2026 13:26:24 +0000
Message-ID: <20260107132514.437-7-bchalios@amazon.es>
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
Now that we added device tree support we can remove dependency on=0A=
CONFIG_ACPI.=0A=
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
index 80fc7c9e062e..9f17f4a1b2be 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -501,6 +501,7 @@ static void vmclock_remove(void *data)=0A=
 		misc_deregister(&st->miscdev);=0A=
 }=0A=
 =0A=
+#if IS_ENABLED(CONFIG_ACPI)=0A=
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
+#if IS_ENABLED(CONFIG_ACPI)=0A=
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
+#if IS_ENABLED(CONFIG_ACPI)=0A=
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

