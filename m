Return-Path: <netdev+bounces-234512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5D8C2270F
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A32B4E89F6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE9C314B7A;
	Thu, 30 Oct 2025 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd7mkfiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88183126D2
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860478; cv=none; b=h+ZEbf4sCePvVCDm2N2ioqSe9EfGYdB6FtXqqnZOaicr63GcvjzN5irtiRrFqcL8Yrt5i9vVuTV0PaD7YuCspegBVaEmQhC2jZXQuArD5upAWm3oF72Z4DarjN3+1F0ydXO2JM36ZX3c3NHwVlNV4UeXIMcpLv+A3dGrjPxuKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860478; c=relaxed/simple;
	bh=BL2gcDsqOsH/kUfGx5gIYSBmw9tJDe0SyiHyKUxzwmg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tt9kR1hUqZoKXR0lL9puC+49zpuZyIuKN8ds1b31Y6oG2e/yZn3/KpvfoASR7Ow7k9sPaANaawmxKS/U0hGM3bUjwu6e98LtolCF2q8t4mWuAXFqtBMUkNIc8sy9bD6OXEhMPSraZ6Mb/NdXGTMRSb+wMRw0+0bGMpCUsEwbxvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd7mkfiF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7042e50899so176866766b.0
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860474; x=1762465274; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ck2ZSs5oFDctNEkipq8C6FJLeHmWTqbX0DGm3ceJvfc=;
        b=Qd7mkfiFqR1V1Tszot7Qn8+ChVcfnXnHpaEQzooIz96lRsQYv0uduc76rINAZPcert
         dgNf/nqPkAsGRberq7kYITcukop0M1+SMAYkBojDmgZ18vHusJ5gA23GA/34mXlKcAAG
         m6R81xByRJeH97bCIEF0A8VXOKtAeJSMUiyE8PmrWlw+YpdoGNTemQ6GwYxPV8ypfyu2
         r8yq0HqhSW9VPBKfvXJCc3MK3NkOxxTifYj688eJE08HsiEyorV4X5vQDmud/d1Q7fo4
         mKyZ1W/pJd20FQrQnd61BxAvxVcqCJQSctOIZ9MW5PY2WrFow+0CMReVTu8lT52T+ELf
         9s7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860474; x=1762465274;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ck2ZSs5oFDctNEkipq8C6FJLeHmWTqbX0DGm3ceJvfc=;
        b=V/0DTjl4ur9CrJsQ7A205SUEjMvu7reFn5uLx3sUf5oWUhgkmCdG3SOiSb9QALVyNc
         wu60CqJWWyy56xMoRxjg+yCDD3rAkATECnygb9yLrok/PpcPCziS9/NWIHQMy2FwkuhY
         JUnt0hQqUkx7BAkvKcfBgM7mUPigdICZzrq2cCee3tNgzW7NrHjpvIAX/OI9oDxXjFno
         ZmoxRYVWdBSt1x4RxzYyuO7VSiv+4OCTErkrKHAj26Y6iEQZqXwP/pPVBLXMPgRl0htc
         tIkB75XXccnn1ZW11MB+mBU16I9cH8zYtnncjzQIMGqcwrbR7m2INffVj6yis5eMGDnX
         QOnA==
X-Forwarded-Encrypted: i=1; AJvYcCXxdHjBLWf7enFtuSCh+MQ2IVqxl0+pzu+hh1L2SVPVLVe+0bGLTHmzvOPCEwKzNHN5JcyZnSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygO5fGE4+mNhsR258nfmgbxNIS+7UGOvcpd2H7ildaynEupT12
	8P/bA4d71q5t/PNcQFNgKjCqKqKI9rDe8E4hMvxilPOD3/KvUQeFSM/v
X-Gm-Gg: ASbGncuxC3pjXGmbNaltIdQCAZzeWwc3EELmLriMVClPj1AnXw0Ye8bXqnQ8+rBXit1
	H4iqw1ZnrXJ4J5KRgiN5ezgj2N/4anjMEx48qBmSggSVyf0+6JiqRwwLf9lJ4Xs37/IRsZjeN3N
	ku9OEoStbCm08HTKq6DppImSRav0GI5LTAtPHMpdAusbcqE6y/fjokOk/i3LyKJFJ2qXZO/oJUQ
	VSyYA3FqY7rOkHXTiQwcdoSMZ++0bnEHbxPnOZ+dPjqEqBeg+an20g1kkvKpli+5zA+r0NzCPf4
	7wrYPVE+PlqQdhuns7M61BaPxPMtpfx+CcecTfIR/a1d5Zt2JnzKSgQqhNRO9CSAT3Pl3P9qi2d
	lDTt61Eo5Vm9s724FAjj1DHOx2Borb+oXKw8brvAupiGmM8AMEecRdIXf2NQ5WYUA7TGrQWalBQ
	K9tcQmd1bQ5mgVsQ3Mo+ItIf2KYJNZJ1wYysxyh056ETTXLw6tndZyO9H55B+EW6AbrYVCoFS4o
	c2CbE6L08i9XdJvlit+ua+EeDui04EljPYd34nzY8Jj2IUWnPxUOw==
X-Google-Smtp-Source: AGHT+IHjonNJY7v3yBQd3MV46djU8t/giJRgAZF/fV+bC+xHHeZMkRdA8EB5KkWvu5NDjQA7pOpVOw==
X-Received: by 2002:a17:907:6eab:b0:b70:5a76:d3e8 with SMTP id a640c23a62f3a-b70700bc350mr112939266b.8.1761860474010;
        Thu, 30 Oct 2025 14:41:14 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d9b536710sm1514947466b.57.2025.10.30.14.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:41:13 -0700 (PDT)
Message-ID: <bf564b19-e9bc-4896-aeae-9f721cc4fecd@gmail.com>
Date: Thu, 30 Oct 2025 22:41:19 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/6] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Greg Ungerer <gerg@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Hauke Mehrtens
 <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Michael Chan <michael.chan@broadcom.com>, Wei Fang <wei.fang@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 imx@lists.linux.dev, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Language: en-US
In-Reply-To: <0285fcb0-0fb5-4f6f-823c-7b6e85e28ba3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In few places a 100FD fixed PHY is used. Create a helper so that users
don't have to define the struct fixed_phy_status.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 12 ++++++++++++
 include/linux/phy_fixed.h   |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 0e1b28f06..bdc3a4bff 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -227,6 +227,18 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 }
 EXPORT_SYMBOL_GPL(fixed_phy_register);
 
+struct phy_device *fixed_phy_register_100fd(void)
+{
+	static const struct fixed_phy_status status = {
+		.link	= 1,
+		.speed	= SPEED_100,
+		.duplex	= DUPLEX_FULL,
+	};
+
+	return fixed_phy_register(&status, NULL);
+}
+EXPORT_SYMBOL_GPL(fixed_phy_register_100fd);
+
 void fixed_phy_unregister(struct phy_device *phy)
 {
 	phy_device_remove(phy);
diff --git a/include/linux/phy_fixed.h b/include/linux/phy_fixed.h
index d17ff750c..08275ef64 100644
--- a/include/linux/phy_fixed.h
+++ b/include/linux/phy_fixed.h
@@ -20,6 +20,7 @@ extern int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier);
 void fixed_phy_add(const struct fixed_phy_status *status);
 struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 				      struct device_node *np);
+struct phy_device *fixed_phy_register_100fd(void);
 
 extern void fixed_phy_unregister(struct phy_device *phydev);
 extern int fixed_phy_set_link_update(struct phy_device *phydev,
@@ -34,6 +35,11 @@ fixed_phy_register(const struct fixed_phy_status *status,
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct phy_device *fixed_phy_register_100fd(void)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline void fixed_phy_unregister(struct phy_device *phydev)
 {
 }
-- 
2.51.1



