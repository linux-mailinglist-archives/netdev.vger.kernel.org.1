Return-Path: <netdev+bounces-232918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83AC09ECB
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3EBE4E18E0
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB82FF664;
	Sat, 25 Oct 2025 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZO4qKC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB423019D2
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418380; cv=none; b=uBrAm1nWLd7Z59n+9b9ZID+Tc+P72rBSxZwkCaSb5Jol81spV4oT0sTSbRROWNuyiRQsJ5Wd9rCObT/Tk5SGSdvmio2G4Wt+vuqhrQmh+zTetuFRq6nbW/qH518tgl8hDlxvFCl8ajk89AbOHjADOozHua+UGnpY4taQm+pBKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418380; c=relaxed/simple;
	bh=++qhl4KSNWgMDQx7EKaOxJp4oYwDNeFiiI+BE3om2D0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ItxZJE2XW2undAepGonfqmJ+XFHzDApcfaKjGwfLg1hSQKMvqs/mi5WPQc6V3pBWC8kj88zDR0vRnsBYFqkEJdSr8xOMkaKG8ObJpCf2Do28Fkx/B7kCkBGoJA/h4Q5LaNexKcAaNNXR4C8sP02SVL5UT3C6/fV70VTHDvje7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZO4qKC5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2255037f8f.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418378; x=1762023178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rioMXLIytYS2vDdWj/lGi+EnzevNN/0HrVqMOMW5YCw=;
        b=GZO4qKC5D2lL11tAL4EnhVD4WSzMIC0bkomTeb7tAIPui4CRsQ8fEkJWo17jgFtjy8
         he9O7U4Prz0NSOqqPwIjiRbieWPWKwty3Js7j+5siXSGBs7euA97A//cU9s7TDDi5sgs
         zrMUpJ7xy8YJY1ww8mifC03yyrlU+bUg8rhXbMJpkjhnerpiOhEVgmfgsJbQUvLe6PNu
         YX5ouMw/MelavN8XFstKowe3vkaHS/FAn2P79WWA3SO3+1Um5BUzGQethhIV9XfMj93U
         l3eA97iEfAtRMOBNBkge0B8FFSq/JjJlWU2nJliZ+0qB2R1rG9oHru1NQWVuB8UKdmu1
         3+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418378; x=1762023178;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rioMXLIytYS2vDdWj/lGi+EnzevNN/0HrVqMOMW5YCw=;
        b=FiO+Vim4RcmBqIGIMQqz6d8PWvHa4lPlKa+sI+l6m9dTEMTitchYpD8XSbx7tGp9F+
         2T5463FQVTA+1FypxOj2Xw0b9ZeEf3lM7+A52LY1xWuP3ml6O+za7FbOX5SNtm/CdPs5
         jcMe4Obd5HIFSjNzyas8djbOvEt/KfAi2IUP5OiNJUUjvB88+Afjnx933mw0F5RuUtPw
         KnfZXapCdEi5Th+EP77y+6sSre/qy3Bzgo0eGkoLZejUopQI+mPWWKSBwOjAGrJMHkDF
         qFFEpOmTPG5Mkog+OcyBKfX3thDcKgVsLQKxxhLpLIhuZWLw4cmHPrHvchTD/aaAfuln
         frJg==
X-Gm-Message-State: AOJu0YxaFh4kKbUJUWE6ToKAOQNAj+k14KzitVeLXOGiDb8QZ5K2GUGh
	Ll4/4ZJI1QYevKX6N+OnQpx78vODMmmEaugKA31kiestRuIRuHymGyhE
X-Gm-Gg: ASbGnctBnwDC5bTnO6vC8cyCDjPKFPJFG8Yw/EeIm+vI29LHy8MP6NODWVyh5o+BzzW
	ZvPIbXKFCdXhoAovtp6uX8X0koTmDDrcyeN/n+r0d02GTv8eC95dYsVa3cZKaGab3b2j3ZgWtWG
	+1kj5f2FngTcTaPw9Y3/GicwBu/0Ulmvca7u+a0Ga8OPu2lFwdCwA6BLeUsWNvvoCVDneZZvv5Z
	dQDyG8dNYxxyHmEUInl0RR6LV1K29oR1QaZrgvQv53CDsilpQgisMtKxoK9yK2X7FYlz/bNQbs5
	SvQ+o2pGBcTmYZNtI2yAIuRtgCQKPG/t+m79rElXJvrwQmTp0mza26bP2I9RWU80TBPvMGWbj8N
	MXdaByS6zhg3d/1z/ck+xLjjaC1SAfxgMh6S54BEd7atK4XAQ5IygyJ7nxisEb2LyP+9F8kMHTM
	Sj6UMx3h+lrW5z2uZEKbRDv212aeXa3IgjTdIvIqSbUMx8TeUc+xHX3gU428juC/RTBGSf8NHgl
	DWOtSF05m/8Mzd6uaEcOw18QUu7HIIblF+3hvXght8=
X-Google-Smtp-Source: AGHT+IFje2vw71LCSYtKx715VjGao8U1JqPzcYNORegl3cXgFepLRp8cL8qgkSfxNKDPItoF8ydqmw==
X-Received: by 2002:a05:6000:24ca:b0:428:3fa7:77ff with SMTP id ffacd0b85a97d-4298a04e599mr7818417f8f.14.1761418377510;
        Sat, 25 Oct 2025 11:52:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb55asm4956750f8f.17.2025.10.25.11.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:52:57 -0700 (PDT)
Message-ID: <6d792b1e-d23d-4b7e-a94f-89c6617b620f@gmail.com>
Date: Sat, 25 Oct 2025 20:52:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 net-next 4/4] net: phy: use new iterator
 mdiobus_for_each_phy in mdiobus_prevent_c45_scan
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org, imx@lists.linux.dev
References: <07fc63e8-53fd-46aa-853e-96187bba9d44@gmail.com>
Content-Language: en-US
In-Reply-To: <07fc63e8-53fd-46aa-853e-96187bba9d44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new iterator mdiobus_for_each_phy() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus_provider.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index a2391d4b7..4b0637405 100644
--- a/drivers/net/phy/mdio_bus_provider.c
+++ b/drivers/net/phy/mdio_bus_provider.c
@@ -249,20 +249,15 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  */
 static bool mdiobus_prevent_c45_scan(struct mii_bus *bus)
 {
-	int i;
+	struct phy_device *phydev;
 
-	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		struct phy_device *phydev;
-		u32 oui;
-
-		phydev = mdiobus_get_phy(bus, i);
-		if (!phydev)
-			continue;
-		oui = phydev->phy_id >> 10;
+	mdiobus_for_each_phy(bus, phydev) {
+		u32 oui = phydev->phy_id >> 10;
 
 		if (oui == MICREL_OUI)
 			return true;
 	}
+
 	return false;
 }
 
-- 
2.51.1




