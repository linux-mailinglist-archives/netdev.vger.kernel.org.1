Return-Path: <netdev+bounces-234515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEFEC22736
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F22718863C3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 21:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CCB302163;
	Thu, 30 Oct 2025 21:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltBcw2Yr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097531196C
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 21:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860673; cv=none; b=QVwOT6WYR3RadEYbeS2v4xkdcNSVunlEeq9qKQxrduFrMnBN5v+y2FLwbwUkDD+/0lG+L2k8chxn9fGQyEoEjOkNc2ax3KDfXsCgu7Uzwb7tl6gypDU3T5t5j8Z7CMvhKE1r62CSLa3F+DOPhc3WRQEdTOZGgTESAVPBKo2K1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860673; c=relaxed/simple;
	bh=OVBZKCxisD4AEHoh4taDiiz3E1+5r7AD6sHhOB068/c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gd7x1JdHN9Qwx0qlg4X0+N9VOAMGe5ndvVR4KHZLkJFfv2+gwE65WnepQakn4dntCn6YoYZajPOf+Z5woAd42m9HgjAapZt4rIqqYFe3vjBPvwDQeEAFQOSgsPLFFkuHLP+HLPUkcajzMGLKJbEaYP4u/3zhzzHIJECgrMohmlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltBcw2Yr; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b6d83bf1077so311316466b.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860670; x=1762465470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O4uaKHAXwNb+uZrRxS66JNHHThWIDwiFtrSSrRD5tKQ=;
        b=ltBcw2YroJZ7sdX9UFb5NYT67lzbAWFR+qfEKyZL3nWVwsW3fKNiOVhe8bqLKQiKyr
         68UhleVia0iMcRG/aWmofP8xHuSs8MrXTOmCXEaCRYluRwM3eb1UF4CLsgo9EwD5MsUM
         aXRCbxzVSf0DzylsI0UiQ02oQoRNamFa4TvNfUDIYLIkNP4Y9mA7PJ132edFu6u+DdYq
         bbZVKVzB8ruVSVSOIfT3vHhJ2sGXZkwVRWbKkFNZdMkUbnwyKQm5nRlZqelfxdeiIY1+
         fGNRkS6sA1rNa78/Sl5x4neRABk8WxyaZ5kku24IscmY7FDBHGzpTwRNUOQkb9aMVRc5
         L3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860670; x=1762465470;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4uaKHAXwNb+uZrRxS66JNHHThWIDwiFtrSSrRD5tKQ=;
        b=iOINrqqITMk66FzVPn54A8wRtrFB4ORXaU/jFFZck8e9qboIbJyoSQMEntpyye115Q
         o3zSdNZoyY1ffQdmUdgOxqfvu1P4V0CuoZ9l7roCIYuQNCAnGoVfp+tDJPHSNM8Bhutq
         tOmJwM43DCpdJIpuz3jTXrxesHwPUrIycrvJC72vSTQ2uS6lKDaoE9LErj9ZiK6lx5he
         YD4MmYMGpTIm6KX5w2BHgfEUG0yOor+TS8UBlPEljA3WCOy1Nrb8GA6ff9BFqVQCAYLR
         onJuIA8b/HngIcYpfdKb/HY+xY4ydG+CyN60m567OFjNfr/YHdNs+2p89ibYTrlIUcON
         SZwA==
X-Forwarded-Encrypted: i=1; AJvYcCUVxYpoxwj3jfZ/vfy6CaOPl0CAFdz5uMVEwOmutyEGqSku+MjHLujVNaYTYILtyNbc32tVtm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1b3ug7ENREUufOzJ9tnMCkgbk15iLvXtV45haYdp7WAEezGEe
	0pKILoPyQzcJyGDnFMN0fnn+dYh+e/8u+VfHPOUyoIQiAvg2kSLGmARG
X-Gm-Gg: ASbGncv1RdP6r8DZT9gaEalqgnt2Y4vz7XP/kkRzwUWwy5BOFH/DBwogrHht545ZGdk
	2TNude+XJ1eKLFq+w4dn+ulOPgqJ2J8GkSDb61nbTkC1IE8CQ3orEvOI9awKM2LtF5BuwT0/fkX
	fLaJoqJJN2O0WbKfotrSBhGyqAwqmR4GbHTN5S96RiRsuFcU0vBJWX75VF0eMK2Zft8oX+nxMJt
	r0xkgxONyYDmaurtGX0HBYekjwK2/Qjdxb6TGCa5XPCxA+CTSBuh2EVESyckKGqdApdVF8zeQd7
	Oyxf0TK554x87K9E5MIV8RNVWtPJ6QpqQPFgrfIuavTAEOoVQHfd6l4JjSfgG/rnKxi37lbW7X6
	EL/3Kjs/xNRyFxYHf0y70Z8Dzqy+QA5Z1iqF9n0/6uS1VoweQI5H6GRSwAVTWNmIaLkcP1vpOCD
	y3QA9cnz649+dn/xQjOAQUSfc90736pqVdF0AoMQJtlFBNjBulLfxRd4vubyo3frIZRbC3dgED1
	k3hfcOo5fHCbdZj8U4uP1OOV2bOSgSAtvM57Vv5vMs=
X-Google-Smtp-Source: AGHT+IFcB4chxXleGHfpbi4tes9/Dmfh2jb+AmLIc8A8cgDrKbGPgclO9Z8TRjob7Me9mlGjw5VonQ==
X-Received: by 2002:a17:907:7252:b0:b46:8bad:6981 with SMTP id a640c23a62f3a-b70701917e6mr133084066b.20.1761860669719;
        Thu, 30 Oct 2025 14:44:29 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f48:be00:f474:dcfc:be2f:4938? (p200300ea8f48be00f474dcfcbe2f4938.dip0.t-ipconnect.de. [2003:ea:8f48:be00:f474:dcfc:be2f:4938])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8540807bsm1843940166b.54.2025.10.30.14.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 14:44:29 -0700 (PDT)
Message-ID: <53e4e74d-a49e-4f37-b970-5543a35041db@gmail.com>
Date: Thu, 30 Oct 2025 22:44:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/6] net: b44: register a fixed phy using
 fixed_phy_register_100fd if needed
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

In case of bcm47xx a fixed phy is used, which so far is created
by platform code, using fixed_phy_add(). This function has a number of
problems, therefore create a potentially needed fixed phy here, using
fixed_phy_register_100fd.

Due to lack of hardware, this is compile-tested only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/Kconfig |  1 +
 drivers/net/ethernet/broadcom/b44.c   | 37 +++++++++++++++------------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index 9fdef874f..666522d64 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -25,6 +25,7 @@ config B44
 	select SSB
 	select MII
 	select PHYLIB
+	select FIXED_PHY if BCM47XX
 	help
 	  If you have a network (Ethernet) controller of this type, say Y
 	  or M here.
diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 0353359c3..888f28f11 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -31,6 +31,7 @@
 #include <linux/ssb/ssb.h>
 #include <linux/slab.h>
 #include <linux/phy.h>
+#include <linux/phy_fixed.h>
 
 #include <linux/uaccess.h>
 #include <asm/io.h>
@@ -2233,7 +2234,6 @@ static int b44_register_phy_one(struct b44 *bp)
 	struct mii_bus *mii_bus;
 	struct ssb_device *sdev = bp->sdev;
 	struct phy_device *phydev;
-	char bus_id[MII_BUS_ID_SIZE + 3];
 	struct ssb_sprom *sprom = &sdev->bus->sprom;
 	int err;
 
@@ -2260,27 +2260,26 @@ static int b44_register_phy_one(struct b44 *bp)
 		goto err_out_mdiobus;
 	}
 
-	if (!mdiobus_is_registered_device(bp->mii_bus, bp->phy_addr) &&
-	    (sprom->boardflags_lo & (B44_BOARDFLAG_ROBO | B44_BOARDFLAG_ADM))) {
-
+	phydev = mdiobus_get_phy(bp->mii_bus, bp->phy_addr);
+	if (!phydev &&
+	    sprom->boardflags_lo & (B44_BOARDFLAG_ROBO | B44_BOARDFLAG_ADM)) {
 		dev_info(sdev->dev,
 			 "could not find PHY at %i, use fixed one\n",
 			 bp->phy_addr);
 
-		bp->phy_addr = 0;
-		snprintf(bus_id, sizeof(bus_id), PHY_ID_FMT, "fixed-0",
-			 bp->phy_addr);
-	} else {
-		snprintf(bus_id, sizeof(bus_id), PHY_ID_FMT, mii_bus->id,
-			 bp->phy_addr);
+		phydev = fixed_phy_register_100fd();
+		if (!IS_ERR(phydev))
+			bp->phy_addr = phydev->mdio.addr;
 	}
 
-	phydev = phy_connect(bp->dev, bus_id, &b44_adjust_link,
-			     PHY_INTERFACE_MODE_MII);
-	if (IS_ERR(phydev)) {
+	if (IS_ERR_OR_NULL(phydev))
+		err = -ENODEV;
+	else
+		err = phy_connect_direct(bp->dev, phydev, &b44_adjust_link,
+					 PHY_INTERFACE_MODE_MII);
+	if (err) {
 		dev_err(sdev->dev, "could not attach PHY at %i\n",
 			bp->phy_addr);
-		err = PTR_ERR(phydev);
 		goto err_out_mdiobus_unregister;
 	}
 
@@ -2293,7 +2292,6 @@ static int b44_register_phy_one(struct b44 *bp)
 	linkmode_copy(phydev->advertising, phydev->supported);
 
 	bp->old_link = 0;
-	bp->phy_addr = phydev->mdio.addr;
 
 	phy_attached_info(phydev);
 
@@ -2311,10 +2309,15 @@ static int b44_register_phy_one(struct b44 *bp)
 
 static void b44_unregister_phy_one(struct b44 *bp)
 {
-	struct net_device *dev = bp->dev;
 	struct mii_bus *mii_bus = bp->mii_bus;
+	struct net_device *dev = bp->dev;
+	struct phy_device *phydev;
+
+	phydev = dev->phydev;
 
-	phy_disconnect(dev->phydev);
+	phy_disconnect(phydev);
+	if (phy_is_pseudo_fixed_link(phydev))
+		fixed_phy_unregister(phydev);
 	mdiobus_unregister(mii_bus);
 	mdiobus_free(mii_bus);
 }
-- 
2.51.1



