Return-Path: <netdev+bounces-245366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B53FCCC511
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98B5A3029C4D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A052E2850;
	Thu, 18 Dec 2025 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="DIcv+qqq"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.75.33.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392F2D5C76;
	Thu, 18 Dec 2025 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.75.33.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067958; cv=none; b=fMhfJpqI/CXIWE5C2dNwL6Vj7tThdGN897Ty8+y2r+YU6OoS8f1VRtOoj4DqoLSW/N0xzhDSv/Xf6nKznKRoW+LaRscAWpHDHzlcwlVYAwL8CKvte4YGk2cYSdUlphqKCCjUTF1rQsWO7BanTwAbwal+rOm8Gk5RpGcxYBjnLlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067958; c=relaxed/simple;
	bh=aO7Tjufb11f1PRoAcbnABTZ6OyV5Uo9litZK8tNvmQU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1gPFd4VAHPLyV9rqDoe7K5TV6FoQ8rzmDoOwfNhustnOJ1FUasaKNYgOV4bdMSxFhv/VUqpLJ/JiToI8ODNwimgBOaWGDwUMOxQmsN7PBBhctBHqvRg/kDTF29HTRqmQ60+NXBIax4WMr4zhRIS6RHTWAJT018EIzTQwAVdrjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=DIcv+qqq; arc=none smtp.client-ip=3.75.33.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067953; x=1797603953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=j5lreQ2PPRNioC4Ff/bYXCd9XELkpenySvD+fVUVl7A=;
  b=DIcv+qqqgtH7N1IBbV5qF45xq0EEIHMnCG0uB27WTFrv4EaLpP4ec46P
   K7JUtS2heI3a5JnySqL/pXcPQyTZYHEpjWlwtoUG93de965eFe1dHgRsg
   4vBKLwNKjD9/dcrW6BD3/h390zYYeOFeYN8YmzYBs8C4dYtVWsmLPhCEf
   CLu7RFkQ+rkmimsQ+XbsKoe98SZf5Mg9ZH77abl0YUjFyXzCQOcAzpBZh
   4vSsgAnary1uLD17F2jsNsBb3o1KqyZMAFI0uGyUJ0KXkSf6bo4y8n+3i
   CIZ2xMC2tr1yjWYYK2XsOuIo0StBE+AgnXhtP29LKC/SUc7+AIyOwRv4M
   A==;
X-CSE-ConnectionGUID: +241mf1WQw2VURsOcYEdcg==
X-CSE-MsgGUID: h7iyYJ67Qwu5mFAfndW9FA==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6890564"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:25:34 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:19954]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.54:2525] with esmtp (Farcaster)
 id 910e6f9f-c171-4e3b-8480-8772ca7173c0; Thu, 18 Dec 2025 14:25:34 +0000 (UTC)
X-Farcaster-Flow-ID: 910e6f9f-c171-4e3b-8480-8772ca7173c0
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:25:30 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:25:29 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:25:29 +0000
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
Subject: [PATCH v4 7/7] ptp: ptp_vmclock: return TAI not UTC
Thread-Topic: [PATCH v4 7/7] ptp: ptp_vmclock: return TAI not UTC
Thread-Index: AQHccCopy5YWVTK0WEK/jBfWAHQ0Lw==
Date: Thu, 18 Dec 2025 14:25:29 +0000
Message-ID: <20251218142408.8395-8-bchalios@amazon.es>
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
To output UTC would involve complex calculations about whether the time=0A=
elapsed since the reference time has crossed the end of the month when=0A=
a leap second takes effect. I've prototyped that, but it made me sad.=0A=
=0A=
Much better to report TAI, which is what PHCs should do anyway.=0A=
And much much simpler.=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 drivers/ptp/ptp_vmclock.c | 10 +++++-----=0A=
 1 file changed, 5 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c=0A=
index 7f342e5a6a92..deab3205601b 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -82,13 +82,13 @@ static uint64_t mul_u64_u64_shr_add_u64(uint64_t *res_h=
i, uint64_t delta,=0A=
 =0A=
 static bool tai_adjust(struct vmclock_abi *clk, uint64_t *sec)=0A=
 {=0A=
-	if (likely(clk->time_type =3D=3D VMCLOCK_TIME_UTC))=0A=
+	if (clk->time_type =3D=3D VMCLOCK_TIME_TAI)=0A=
 		return true;=0A=
 =0A=
-	if (clk->time_type =3D=3D VMCLOCK_TIME_TAI &&=0A=
+	if (clk->time_type =3D=3D VMCLOCK_TIME_UTC &&=0A=
 	    (le64_to_cpu(clk->flags) & VMCLOCK_FLAG_TAI_OFFSET_VALID)) {=0A=
 		if (sec)=0A=
-			*sec +=3D (int16_t)le16_to_cpu(clk->tai_offset_sec);=0A=
+			*sec -=3D (int16_t)le16_to_cpu(clk->tai_offset_sec);=0A=
 		return true;=0A=
 	}=0A=
 	return false;=0A=
@@ -349,9 +349,9 @@ static struct ptp_clock *vmclock_ptp_register(struct de=
vice *dev,=0A=
 		return NULL;=0A=
 	}=0A=
 =0A=
-	/* Only UTC, or TAI with offset */=0A=
+	/* Accept TAI directly, or UTC with valid offset for conversion to TAI */=
=0A=
 	if (!tai_adjust(st->clk, NULL)) {=0A=
-		dev_info(dev, "vmclock does not provide unambiguous UTC\n");=0A=
+		dev_info(dev, "vmclock does not provide unambiguous time\n");=0A=
 		return NULL;=0A=
 	}=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

