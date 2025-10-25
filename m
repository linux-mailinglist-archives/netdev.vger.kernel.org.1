Return-Path: <netdev+bounces-232915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B1C09EAA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0E4401EF8
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ADA2FF644;
	Sat, 25 Oct 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etxHobF/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAB31ACEAF
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418246; cv=none; b=Frki9rioqgmHJGkwRE0+wAUqiHDokPab22Pqgs4gGGc+z/zZU1+wGwH+LRTJgfUu1I0ov7JVQKBZukDE9L2wzdeqbXDRpgYVzOGTp498bQ3ZX9Y4Cwt1TUCHHKIXCW0JhgQArOjPEDcA6J+2vGIFsxdkb5FZ9O117Luzd6ALlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418246; c=relaxed/simple;
	bh=r+DKdsODkadGXvvNZ/S8XJoz2FiQFDPW4f1v2XCikQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nOCzpdtm+veXf5A4/spqILUhttGhhlcjbrWEtH9jWOUvtncWxbQka+6E6Sb8hkfKh/bhdrVHv4au75mWWr7Fp1Ck6lrPcdmbfFTai25opph0tShJpUHeiLa7p8Tguystrdf87fmFPMVusPRHY6od6a+xscpRP5Yah6FLjPuZVOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=etxHobF/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426f1574a14so2053855f8f.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418243; x=1762023043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=98yfEBiDPGFeXKIHXMIyU3z8Qaq+Qc8MiRUCJmNKTJo=;
        b=etxHobF/0l0iyRd93R5XTp1VM6h9lRdWCh4AwKUtawmcOMxiX2Ty2yb14JkC1nZoyt
         ooAr/YgehYifssk6rnFMzoFJdZ8MCVZJQYP9JcAwqj8ORTOBU8I0mz5NmNXCIw1KlMGO
         7oJAfv2RwwWDaJB4buNj2FIFgAusVUCuFooAQ33kXl0h+v/GsCigld8ZD5dNT3a+lXNN
         NAEit7uCVTbzAYjGwptXFUAC/5ntUI3YlVHGTYa6MEYjESYBiALq5OoOVdlDVbdMt5Ov
         oE3ZBfI1orOGawN6ZE5zzX5T5tnsJhWfYJ/UPmHlSu7JUE+8efQ4EmVn6iiZwR3+ED+5
         PnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418243; x=1762023043;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98yfEBiDPGFeXKIHXMIyU3z8Qaq+Qc8MiRUCJmNKTJo=;
        b=K5RTfvhELxW9qX//g0hBLDGHQsLX2N6bRs7S+gRcH/EpA5HwEfrozIHcVKn7i7OFGu
         I7214y+6sgX6Wwh0cEewLdeMm7KbJ+O0X3RuE9+mPiGxFZUKpk9N3X40KFJGXFmc6m40
         6W6TcDEYO+BCF5lLJFZKGtQoqdRk5O11VcWOUiRsou0NpneZquWLpraEp1nPaKx0CchQ
         H9OiRdlA4uvjymEKLlmeQycOLat/cW7+KtWVCOnIazVJ7x2bmGE59ryFar5oPO7nDfWB
         mWTmVO00f6dz8ovwYSL0/iRjP0pCxoBLqH8exIuz/G+JJIPA56oJK6HA6NBTe8VyPrBj
         w/hw==
X-Gm-Message-State: AOJu0YwPxWEqECt9bMCX7fsUfV4j8shkKXsalvoBW1YaEONU2kDrb6FH
	iH0UIvY75gkJ2PdMYkvGt4yxkd0ybsYL2NkI7HrP4iRzC+v5NNsJxl1r
X-Gm-Gg: ASbGncsopyLIzyWIAC2VN0o/XN7HulktwKIOXYJAJS9W2+R4wzeQs0v4qBVijUxrFid
	ss/4DGgB47kUqKQ3IL84f8nH/3YRUEFZ2lv256eJtThM4kIaqvp9GifOA2Gy6nfsRpjiiKf6AJw
	EtRlrd6I9W7UqBkALUfx0Lcg0SNmaaVz35kw7UMTZypcr3ZHXb7aHgFLkufyL+L+xONHw+tKHYI
	PcluwWN27JdA4KKHG8MLYY4P9HGVp504+5KJ1BFo2C83wfRx5FH31lrF3l4K5/FDHRwt2MxEvx+
	RtbBSev+oXg2/dFXkTC4zVGWAOhKK0g9MstXy4gLrtKhOYyFsb81SVsHVe90Ols67GodkNGsJlk
	TJ+I7k1lCgUu5HYolJ298HRtGJYKtFMwWfTY3tMK/LknWhWZYwD/zVjede4MzeEgWr4ejs1TGur
	fva8sc2yihHsjlnMI5s3fLSnd86ZrhanEnf0mUDif3zeQpj4rCMpJrijuDT19V3+zpFVbLotr6M
	oD04Y+Llv9TSQW8H9g6hm2tImrIPS95RdSmAX+fKdNj8GBDGEZYSA==
X-Google-Smtp-Source: AGHT+IFr5ewN20AMLA9nfDxm/iJ4PC3aoQ2jPi+BAKHx+DPN5+GH/t/L6cIO//luoXtmLREO5RcziA==
X-Received: by 2002:a5d:64c5:0:b0:427:55e:9a5c with SMTP id ffacd0b85a97d-4298a04e8f8mr6979655f8f.23.1761418243388;
        Sat, 25 Oct 2025 11:50:43 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d3532sm5118118f8f.20.2025.10.25.11.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:50:43 -0700 (PDT)
Message-ID: <65eb9490-5666-4b4a-8d26-3fca738b1315@gmail.com>
Date: Sat, 25 Oct 2025 20:50:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 net-next 2/4] net: fec: use new iterator
 mdiobus_for_each_phy
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
 drivers/net/ethernet/freescale/fec_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1edcfaee6..c60ed8bac 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2552,7 +2552,6 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	int err = -ENXIO;
 	u32 mii_speed, holdtime;
 	u32 bus_freq;
-	int addr;
 
 	/*
 	 * The i.MX28 dual fec interfaces are not equal.
@@ -2667,11 +2666,8 @@ static int fec_enet_mii_init(struct platform_device *pdev)
 	of_node_put(node);
 
 	/* find all the PHY devices on the bus and set mac_managed_pm to true */
-	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		phydev = mdiobus_get_phy(fep->mii_bus, addr);
-		if (phydev)
-			phydev->mac_managed_pm = true;
-	}
+	mdiobus_for_each_phy(fep->mii_bus, phydev)
+		phydev->mac_managed_pm = true;
 
 	mii_cnt++;
 
-- 
2.51.1




