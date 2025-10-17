Return-Path: <netdev+bounces-230594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E741BBEBB67
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617F9744ECF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3482417DE;
	Fri, 17 Oct 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaePMpIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312621D5CD9
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733809; cv=none; b=Xdj8OyZle1VZ6WrPPDj+u21DiI8plknnuXVeNjj/ErecOdWrPKA6RtoCSe0X0ngXY8Tlg7jxFXJhizoEzwbqIrU8/yilYaHZKj4+jD55Uo7Fyua8I9sjip3z+OrMil1DuA7gRJCdioR3pcUliybbhqkVbx4wT2mjDTEnhl8+wjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733809; c=relaxed/simple;
	bh=zpxsAfywcOGonYp8jwDeXQJxVIheKotNy1jQTcvB64w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mC8e4GoImQeHoBbovanofdjKLVCCbNt82zisoiSbzKJmyWsNyN62LDv3JOJcdX4wL7C58UxNihA6FVdHajQhDW8q4dnRr16rZgKZ0jph9ZKrbf/uvblyhxzyPv2QXFtc4v14ipn1ZgKHVOfM90Rzpp5dEFgeGejfiMER1DVWkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaePMpIc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471075c0a18so24005395e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760733806; x=1761338606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YblLB+VoeF9BFQt2gR7pkyBE7woK4HA/GZV9/fFi7GA=;
        b=XaePMpIcbW5HZL8bvSM+Mue0+nutxzlhDsR9QsiFpeKEb2YNURC9RmddquWDfirD09
         h/FRuS1K0aNoAGduHAtJh/bhvQWhEhJFGcqTXcT2siv+xzdsGZp/Tus8QasRXtQqwKaV
         XeuoWdZTD4QadzGre8y/wGPIvongYdDxhXIVfbVhFaxjiFpcpTI+myXL4J+VsPceoC4c
         q7U2s+urFsHBS8T46C/EUbxOSb2HxrhEKNvdvbGd9BfL2lHAY9MtcpDjCGzo9aPabnGh
         L+sduZ6Ok+OWpPXJbFVw4vWFof87RWzEBvjtVtPVDMcjw6kESOhXwUnyrPTug6YAeQNb
         /PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760733806; x=1761338606;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YblLB+VoeF9BFQt2gR7pkyBE7woK4HA/GZV9/fFi7GA=;
        b=GS9Bac1BvCaduuu9IeyE2QEm7BO4/E09pN7IIArm+SQNdj+UomWd/GBdcU9nVUjh+C
         k39JLy5DMXgAClmcvd2M6WSpVwgTc6vPkrXFTazDIW3D0NU+nkrB+JUKAz2UfhMmghP+
         99Vj9/9HeTNCpX9cYA1Z5AcWJrdBoR6VK5HtsGUJvcKDHxIQy0/ptxtmCoLQhrbA6Q5j
         2/TSS+mKCA3EgjDwcqh6QZemlpyqg7PA74yHIl0D2VKx2Lr7C3Q01T2/Mu9/lerzMR1M
         5huKUGvjG1vmLVlvquqHRo8+Zlsb/Q4l5Y+eObg3tQ1X9+idAAh2oWP2/zsiScSeybUh
         akmg==
X-Gm-Message-State: AOJu0Yxukdept9UwcO/GFBMq4DSZ4oABHB0LuFiAWHDkCVArAKKGaG+O
	UDDNG1H2LoJRhuorltjWSTOXg3XA3FJQi6l6l6wPrCjTYkU1n0svw6SB
X-Gm-Gg: ASbGncvUJ6BA33KsmAU9gNPUoY6HENnuLnD1ASxwDiMQ7DhYzgCGLgTn0kKe15JjkiH
	rmvxtjcXErBJtWIwRRKJqnLbAuKNbOnIPISqbxA3wkJT9vAsUfwL/J0lzcp7v5R9mbHYznfN3cZ
	BKfF/kZ7FTA+Xrg4+o+3maWFAcRRAK/HWkCcttFDTeiCHLz7L+x6UCsowy19dCF3zd//WnfR/88
	hkbXNK/gEczDTq8tGt/PMWz1lTlPURXd3w4ruoo9nGZXkNlYPuNxHPIQI8hz9pi1mYnVS+KPvPX
	14+8S1Bdiytp3L8u/IX77nURNTh6HmDWOnUTU74FOYH1ez2yraO04bpmJpgdOMWHVJDEBRokINU
	zt0HzTA3Ot2nMxkYehM7dzn/CCqJTo5m8pUWsyts2z8nXME58zR/OOVZLZg8yEvkGGgs2m+Fvmy
	RJZ00rJl9u2gwZWTFVdXxqzDFemkJ7kBd3b1c54FUd60FFk/aqFcM3l0gZq1CVRuzsuChlU3w6Z
	0wavJmPjmrn7zOxSMYQLcH1S3HsE+iq6MuH2YyuvG/v7H6ByoM=
X-Google-Smtp-Source: AGHT+IEy7De19OU4PdeTfKZM7IHOvIC1vIAHcvV/sJCVRDr3sb7371CN2c84VFJUPGNWinn5w0QB6Q==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id 5b1f17b1804b1-47117906a23mr37520665e9.22.1760733806493;
        Fri, 17 Oct 2025 13:43:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4714fb1b668sm15931035e9.0.2025.10.17.13.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:43:26 -0700 (PDT)
Message-ID: <43b95134-0646-4129-840c-bea85cffcc65@gmail.com>
Date: Fri, 17 Oct 2025 22:43:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/4] net: phy: use new iterator phy_for_each in
 mdiobus_prevent_c45_scan
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, imx@lists.linux.dev,
 linux-omap@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
References: <68a7779c-acc2-45fc-b262-14d52e929b01@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <68a7779c-acc2-45fc-b262-14d52e929b01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new iterator phy_for_each() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus_provider.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_bus_provider.c
index a2391d4b7..20792480d 100644
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
+	phy_for_each(bus, phydev) {
+		u32 oui = phydev->phy_id >> 10;
 
 		if (oui == MICREL_OUI)
 			return true;
 	}
+
 	return false;
 }
 
-- 
2.51.1.dirty



