Return-Path: <netdev+bounces-247752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF1ECFE214
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1E2D3009877
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D5833CE91;
	Wed,  7 Jan 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="dCT/ih94"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.65.3.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A820E33CE8F;
	Wed,  7 Jan 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.65.3.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792378; cv=none; b=EPfkLL5GnIng2tlozifw918CzUTxMb29OhiNxznaum32VvvTcbc1XYA/oHdZfeBpPF10751A+Sk/iPOyU4TGZMLT21pb6ULMAw11PGY/cSzYjbk4mO4CKupEdbZBF6pxM3pW5HBnI2tkEH1tdidpbsaUu8wRdggdyfhUA2OqBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792378; c=relaxed/simple;
	bh=Vnx+w4tO6WZI7Vv/gWZsCtVnlCSNknXc7E4iblxx30g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh960ewbBlWAyx6BvEPlfELGoEWigfCAW80EIWqI5fKDZBqSQrv/bNLYj5/un3/pSaEy0Jw0nRkGRZSLvu377KQHJ1VJlWzk2HuOSuxX5YwXLUwzWKQfiYYdULXrlnu78PIqMWnsNGPlDFJNTxnLSiui0IRjN5IX9CSIYtWblw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=dCT/ih94; arc=none smtp.client-ip=3.65.3.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792376; x=1799328376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Bx3MMmyxlhAy6Y+INEFT1pqhPUhnmaRC1X9Vcuoifc=;
  b=dCT/ih94ktITGlHpO2JcFPWCTcRPYe34vVtqlrWgCGiYASDb6bwdPFMH
   IYw5gronAPwux3BPb0zqwwBtY4RjRdF2ZJKYV80DhRYfHIcLLz30ndkcQ
   6GHkH760X7P5MxS851yQyR0Rt7Nl1vKCdBQpGPcIESgcbMQbLK8bsrqoW
   rEkImBGPpu0e0DAEBaXSWHFZJU+C21gPugFQ3ec9SwjNd+98cyaT1UQ7q
   N8i6u8ZSnve4X16J4sbxUxLu44kDU9My9/jfcVol3tz57BwSUsGQ550xn
   eeeZVzNwrFpb8F0BG3grc21ThllxoiI2Wvgi6+YkKmgv+gvwRKk/s1ect
   A==;
X-CSE-ConnectionGUID: zTw2wVGVQHuOvAtuQjj2mA==
X-CSE-MsgGUID: Uc/8kYgxST+X+OjzoZmBkA==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7583031"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-002.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:26:13 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:14879]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.14:2525] with esmtp (Farcaster)
 id 63cc3061-c995-4d65-9a13-ba3c17942ac4; Wed, 7 Jan 2026 13:26:13 +0000 (UTC)
X-Farcaster-Flow-ID: 63cc3061-c995-4d65-9a13-ba3c17942ac4
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:13 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:12 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:26:12 +0000
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
Subject: [PATCH v5 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device match
Thread-Topic: [PATCH v5 5/7] ptp: ptp_vmclock: add 'VMCLOCK' to ACPI device
 match
Thread-Index: AQHcf9kx/P0RVRKYqEe/wKI+SdlVww==
Date: Wed, 7 Jan 2026 13:26:12 +0000
Message-ID: <20260107132514.437-6-bchalios@amazon.es>
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
index 801e14cc4799..80fc7c9e062e 100644=0A=
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

