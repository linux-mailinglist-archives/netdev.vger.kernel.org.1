Return-Path: <netdev+bounces-232909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E963C09E71
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 082044E56EF
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA21302174;
	Sat, 25 Oct 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO9lWt9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8D3301000
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761417352; cv=none; b=hcu7qIX4JpOwHgJh25GN68TsxizmpsvhHcJbGZe+Ng6o+GP/gxqkC/rroYIEYkOwYEthIb8YeYiYxqMvzaetq5rG4kxSpG5ce1s7K97TSzouPIwPy/aN1GKMaZGFA52F3qwM/AeVbiURplSPLTeZ0LIoePPbNQNe1K0Lyt5/Ij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761417352; c=relaxed/simple;
	bh=RUhf82rtTXkjEw7e8aTaJy+jIFbd0/C70nBFghXneMg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=izUOzD1fvL3oUsvaugeKQG/Nzpk1Sha46zWiG2HgBV/LNdMKOZsLZHS73/t0RVhz4fnriJKpU25rLVCg0ErcBLsGeSuxToxLnPaTdutT7CHSBngY2cKZfyGyY18TIc2x823xJ7MeR0KEzGJlrY5U1pPXNTE3covGbJBZnGe19vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO9lWt9M; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2773897f8f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761417349; x=1762022149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PENM03p/Mkr4FgZeTCTmwWhZL8Qw72e7c64zdaNuV6c=;
        b=SO9lWt9MiKnjO0Si4uk34VPubNwH5BwTqKF4kgnmqTosGcMrLOvcXxltwgYsQnjEwf
         t066Vkrz/gTxDQU5brtWYcE2Z+w+M4Qq2kLXjkQXEKYpPrboRuAZofA8TScB2AToGFiT
         53XNXlTdfMK+qMrBJlWN73rkePyPYxt/4c/9h1Q0FlhDHrsAOn+gEZi+RuD/OFkogM97
         cD05N0SChb5G0IRfZ9gC4Ybc1D2yX27Em8VYaCeRfdx+kGWR0MTlsl1Q43cKi5Kmg8H6
         nDZa5ojAdBuzMzd6LYfY95J6N4mOVc/lh9mdPbT6XANw1Y6Sm4AP8cJ8dyFOwDtKZ8cb
         TtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761417349; x=1762022149;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PENM03p/Mkr4FgZeTCTmwWhZL8Qw72e7c64zdaNuV6c=;
        b=oVhO9J0Qlv9zDsY71z1lhKp8+7c3t3+hkhNRq7zpzzt/F1s8cIke4yqNjemogY7Y+d
         PaD/EhyroVysDuyhuC4ZufnevruqyG3AVMuify02wdnmkyia2nLZoscyGH68oSNY9L5H
         HZXZ2VMfx/mG5zDIB0JJcZ1Xky/Lve3k+9NAKnjSQryzgmqSuV5YNNPOkw4k9tKTIbV4
         Jtsn3BEVotYNqUjj42jIO1KttS43wtjJHe3OIqLYWKYksevaEbOXh9qbdg/c0k6WcCWw
         ptFQUFM0KTZN0ziSvyCGpiWJkD20jDBaGBnFEe/5/xK7TKsllvkBMzR128vDBh7nMc8i
         lkPA==
X-Forwarded-Encrypted: i=1; AJvYcCUiYnr+wmUkzBkEAwjkZb2QN+EwrFKMIPH/X3VabWClwLQH0tT7/Ey3I8WiXPfDzHRiZqmP4pE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNI08XhayTw2TeypjMaoh/b2deL8lZlDYwGzhTq8TiaOcZDCaU
	F1XHw6YipocOaCb5irANdtM7W5a/OQ6Ei1rnRB303BGq4i5bKUPGs1TR
X-Gm-Gg: ASbGncu0wFWS4UhlaOlxg5jSMHQPZOTfQ0TLGGaY0HgEu17gIp59bl9AZmUCElGXkIS
	/MUJixu2QSeNv19unxPicMwVul4vwVO0hT8Py344b75FkIpsD7UObUtFGxXXZE2GLpxgFLfG5Lq
	vq8Ph+sQGPADC2GeL9Ozq1nrdroeAS6OaZTC2FNFH/YA7LbWy7TkjRLOmG2tqbiix0v1iOvF7+h
	2DrrT1gUdpure0GSr8JgLogp42CRTMHySRTDdYQeceob7oOmEDT7Wzc7OLaXBv+W09pZO2q/Cod
	/VuWx6seI7JsHHTbGD8XBSrzraVNf+JVdqyXWxjM94traqinoPfVVcDQFssqUrY5LGW8wGWEc70
	EvtBovcihEbQV9FCXdTHp8Z3jJj3wWNtUL9giWFMORC3yEvGlc/WbSSpjxmTuRA4nzoC+l0ovst
	ORLjyHEqHXxj2mMtSLtk5708baYpEM1SAd/ciSqzXsT9mkpYIxHZ7A7kghDTQVxVPtAzzY6kEJX
	MF3i6ySPgikNG5caSW6HNJfh3dueJwop1F1MjxJpW0=
X-Google-Smtp-Source: AGHT+IFX9OvthXn1TU4BXDSEiEVVG2CTwp0Ga68UYsWJzmZPnpNrDzbEYmuLWSYJGqN+JXrw3hq+bg==
X-Received: by 2002:a5d:5d10:0:b0:425:86da:325f with SMTP id ffacd0b85a97d-4298f58257fmr5895476f8f.27.1761417348977;
        Sat, 25 Oct 2025 11:35:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d5768sm4949273f8f.24.2025.10.25.11.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:35:48 -0700 (PDT)
Message-ID: <e869999b-2d4b-4dc1-9890-c2d3d1e8d0f8@gmail.com>
Date: Sat, 25 Oct 2025 20:35:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] net: stmmac: mdio: fix incorrect phy address
 check
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>
Cc: "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

max_addr is the max number of addresses, not the highest possible address,
therefore check phydev->mdio.addr > max_addr isn't correct.
To fix this change the semantics of max_addr, so that it represents
the highest possible address. IMO this is also a little bit more intuitive
wrt name max_addr.

Fixes: 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Simon Horman <horms@kernel.org>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- improve subject
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 3f8cc3293..1e82850f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -583,9 +583,9 @@ int stmmac_mdio_register(struct net_device *ndev)
 	struct device_node *mdio_node = priv->plat->mdio_node;
 	struct device *dev = ndev->dev.parent;
 	struct fwnode_handle *fixed_node;
+	int max_addr = PHY_MAX_ADDR - 1;
 	struct fwnode_handle *fwnode;
 	struct phy_device *phydev;
-	int max_addr;
 
 	if (!mdio_bus_data)
 		return 0;
@@ -609,15 +609,12 @@ int stmmac_mdio_register(struct net_device *ndev)
 
 		if (priv->synopsys_id < DWXGMAC_CORE_2_20) {
 			/* Right now only C22 phys are supported */
-			max_addr = MII_XGMAC_MAX_C22ADDR + 1;
+			max_addr = MII_XGMAC_MAX_C22ADDR;
 
 			/* Check if DT specified an unsupported phy addr */
 			if (priv->plat->phy_addr > MII_XGMAC_MAX_C22ADDR)
 				dev_err(dev, "Unsupported phy_addr (max=%d)\n",
 					MII_XGMAC_MAX_C22ADDR);
-		} else {
-			/* XGMAC version 2.20 onwards support 32 phy addr */
-			max_addr = PHY_MAX_ADDR;
 		}
 	} else {
 		new_bus->read = &stmmac_mdio_read_c22;
@@ -626,8 +623,6 @@ int stmmac_mdio_register(struct net_device *ndev)
 			new_bus->read_c45 = &stmmac_mdio_read_c45;
 			new_bus->write_c45 = &stmmac_mdio_write_c45;
 		}
-
-		max_addr = PHY_MAX_ADDR;
 	}
 
 	if (mdio_bus_data->needs_reset)
-- 
2.51.1


