Return-Path: <netdev+bounces-247759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0683CFDF03
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D47A13003B13
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8BB33F39A;
	Wed,  7 Jan 2026 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="jX/LC4+o"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE0329370;
	Wed,  7 Jan 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792494; cv=none; b=kZ6MmlVW7isF6pfKRETpb7d3YegDel38R0zNDIt3bMvAoB9ZB2b5C0saLAjU/H6wX8qMOCkUp7fkx82tkCvtFRaIr0WklBCW3ScIk+lEXlyUqJKAx+7BRekZzDJ7+APaQ7n0iiUpuTVZ6Vl2hxDfny+XBRpzRt/s6FkMjGpBTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792494; c=relaxed/simple;
	bh=56SPx3NZaWqlHf55gYEDxW0QrPTbwVfjYUEYtgxt3gU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DLB/2PchS1a340vCt2EMdAB5Vllogg32spSigct9hBs/qESQa2Lc+cta0wh1xog07OHMVzqGDQg08k/XJJzZipcwHB3p4Vp6iRzgTr8Hn7lvPPY0vEw6KYgiHvG+MNdQ452BLeFtburiFMvLOHYMNM8ZQJnuJa+kzlDYdQ6sUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=jX/LC4+o; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792492; x=1799328492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pWYlCloEqq1s81ftN7VRIRBv2cT68kwmWTOv6VQBqlU=;
  b=jX/LC4+o39lZiTvGSXRl3XAGSlwUPKgjzSpR0l8o8DsmYX/qHdrmDe6y
   MC79qhnGoDfB4q5Tb1QNsvNjba9larkw0EMXTAQNTWcd2YoWQiUVS6FNZ
   QDoPEo5WZgVsLr4inLA5luuDrJUufbxe5u4BmN5Z/NlIVzkV80WkxyTZu
   /Upvv34CBPRZuZUPYIZXN/7r/SwhLhVZxhAaMc4mX38tfh/1ae9tzrc5A
   F3yAPoGuAgyFRR/kWQcwkpfqE0swKnMJkemeyZ7StE9TPPZJAr24jlIty
   cKzGth0q558bNAqKBrTvNOaCMQlEzlKRJsFTa48/e6yHy/evucXM/u0s4
   Q==;
X-CSE-ConnectionGUID: uwteCHfpQNGxT0P7GCHsMQ==
X-CSE-MsgGUID: 7dsqaItRQpGThU2mZZ1i+g==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7469563"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:26:45 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:26223]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.29.28:2525] with esmtp (Farcaster)
 id 3cd3cefa-1156-46e5-b73f-a3f1871c1613; Wed, 7 Jan 2026 13:26:44 +0000 (UTC)
X-Farcaster-Flow-ID: 3cd3cefa-1156-46e5-b73f-a3f1871c1613
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:35 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:26:35 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:26:35 +0000
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
Subject: [PATCH v5 7/7] ptp: ptp_vmclock: return TAI not UTC
Thread-Topic: [PATCH v5 7/7] ptp: ptp_vmclock: return TAI not UTC
Thread-Index: AQHcf9k+JQEWfJl2KUO9UtZeCJ/L7w==
Date: Wed, 7 Jan 2026 13:26:35 +0000
Message-ID: <20260107132514.437-8-bchalios@amazon.es>
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
index 9f17f4a1b2be..ef5c2a66d9b8 100644=0A=
--- a/drivers/ptp/ptp_vmclock.c=0A=
+++ b/drivers/ptp/ptp_vmclock.c=0A=
@@ -83,13 +83,13 @@ static uint64_t mul_u64_u64_shr_add_u64(uint64_t *res_h=
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
@@ -350,9 +350,9 @@ static struct ptp_clock *vmclock_ptp_register(struct de=
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

