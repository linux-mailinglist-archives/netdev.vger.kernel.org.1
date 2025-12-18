Return-Path: <netdev+bounces-245364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1E5CCC48B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72BD830C9AF9
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6412F2D5416;
	Thu, 18 Dec 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="X56JXGMc"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317629C327;
	Thu, 18 Dec 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067912; cv=none; b=Rc7aJCErVnSTmpMMsMD25xBu+wiBNsZxb9JlUrqTjelzxgo2JNp7U/gD08EnlcvntizslaZmwgaPOo3EcTr6wsY9lAUAx/yhhnapyhY++rROsDs2foiNid48pktBnPBXala9NzStGqv7GmzQ+/y7Q4L3GCez+jEcGGdLgKtFiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067912; c=relaxed/simple;
	bh=rZbLgidIM3+HrebdCV2ZR5lmgjX6NxwxhzppiQE+BTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KnIN3TIFqobQvNGUZQRLF5chydkqdcOC18k7Va8G/tEQ5NMbJSuT1Lyod3kXg1v1WXwkHVZ1BJWTy0zSf04XQElk0NfI5USB/uoePISQ/vZNOjh9udwUF/Qzm+xnBMkT+nxOVMOO7L5bjkekYD+Jss+ko32nJJ2HVCKntjqdk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=X56JXGMc; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067910; x=1797603910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eQVcPXCVTyfQJrZ5j9C7RBuxBjEPEvuy4/PnTzMRykU=;
  b=X56JXGMcRb8NZ1mpgtHHoWD3cyrFHAD1OB4hN/rNIlIaR3ju4PNySDCy
   tLRtvcF7CcGtsU9JUY6m2aKJ/S+gIKVqbllnhckQHJABeam6LKx3lKvVu
   SuEl8ARUDNKFk1YaATIqSUcZ0bh8p8Mu+53pwa6EV3akhS+oLRNRJDtfR
   syO/Kl+Rsq4L0IAR+MqoysogrPWyUtbwSTtgQNw9zgWAORBYp7N1A8PYJ
   QT33ijXQwOXfsmu740IN36rQpSmrAUZrULJQqHRErUwecTdHSx1SfNJ5r
   fOAVvwpCeOoXJ38wcpIDJEm/SfVU6cwUFBQ6I5eJBgYbSpwA01+hGBAHI
   w==;
X-CSE-ConnectionGUID: qEm9jclsSFa1/LnObgnADQ==
X-CSE-MsgGUID: NgMdOnTnQWangsL0NMcZFw==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6788069"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:25:08 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:18791]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.30.66:2525] with esmtp (Farcaster)
 id ecd63384-cc56-4ac0-9ea6-ebd6a2affd1e; Thu, 18 Dec 2025 14:25:08 +0000 (UTC)
X-Farcaster-Flow-ID: ecd63384-cc56-4ac0-9ea6-ebd6a2affd1e
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:25:07 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:25:07 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:25:07 +0000
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
Subject: [PATCH v4 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
Thread-Topic: [PATCH v4 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device
 match
Thread-Index: AQHccCobWUl/1dNwk0mSqnawk23WYA==
Date: Thu, 18 Dec 2025 14:25:07 +0000
Message-ID: <20251218142408.8395-6-bchalios@amazon.es>
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
As we finalised the spec, we spotted that vmgenid actually says that the=0A=
_HID is supposed to be hypervisor-specific. Although in the 13 years=0A=
since the original vmgenid doc was published, nobody seems to have cared=0A=
about using _HID to distinguish between implementations on different=0A=
hypervisors, and we only ever use the _CID.=0A=
=0A=
For consistency, match the _CID of "VMCLOCK" too.=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 drivers/ptp/ptp_vmclock.c | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index 831668efabf9..ef945e8248ee 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -751,6 +751,7 @@ static int vmclock_probe(struct platform_device *pdev)=
=0A=
 =0A=
 static const struct acpi_device_id vmclock_acpi_ids[] =3D {=0A=
 	{ "AMZNC10C", 0 },=0A=
+	{ "VMCLOCK", 0 },=0A=
 	{}=0A=
 };=0A=
 MODULE_DEVICE_TABLE(acpi, vmclock_acpi_ids);=0A=
-- =0A=
2.34.1=0A=
=0A=

