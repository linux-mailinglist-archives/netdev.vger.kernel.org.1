Return-Path: <netdev+bounces-232666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D1C07E71
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 21:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 335F54E6318
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF7D296BB0;
	Fri, 24 Oct 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfAlytB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BE2877EE
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333961; cv=none; b=WOVVhwvgE2f3MmXFRScJkjUZAys71WBvMHabJU5O0yMcFIN8vWeLQ16Elrnbt3czViKzi/BjPRtE2MMQMVdkm5t27Ax/JWTlxe6jvA7Yixvekd96UWhdNpMajAE6yuko/FBod1Prx4XPuTaC8SGnAntgw56wNYZD8HtucEA441k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333961; c=relaxed/simple;
	bh=xQbRXC8oBwRxPtiCrzEHA2/Fo+zSIleR2AOCUy+QtII=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GRDdE+GEyOZHcq2EKDERPIVLxErcSv8oNFj6g8K0buHaGTayMBbDYPYdyBDpDxaRhbMutt1b3faSCPBIjHtkADy3WFqiiAqF2jckVYmh9eOMRNusgqlJS7H6fmyI2ySx4IO78olmsoirDQ9f68MAg7B/YR8T/4v5xdYpPXWaong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfAlytB3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso2318830f8f.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761333957; x=1761938757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqFywCr55VrKMslNk/QGMOXV5hNMK9F5bxBArsZULoI=;
        b=lfAlytB3fCLthZgu2Gxm7giGu3XDsopogchIp+gCXSg5qD4DlbjO/o4VToZ/YZrtR4
         95Cves0T9L0UuxdvGQ3xn5+Zw+eh2VBbylacQaXReqOkVUYaYo8WQMkC2Mv+sImn4qC8
         DWQM+CTcf/4s4tnH+FWHuCZ/nB5uuuLvVrznaLAEtBJdI4Aa44u6jed4PL2+mWio72U/
         Moy9HDsKkA14LCXK5nDI6HITsFs2+7j/rAfU1tEInlAqhkfFAxzio7uioYDJUWAwVTPY
         5i7wEwo86M+UlE97iclVjlbiv3ska7w5TcSWaEP6NllJzk9qw9RHRRL+xoqTLuhkLhUP
         dekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333957; x=1761938757;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqFywCr55VrKMslNk/QGMOXV5hNMK9F5bxBArsZULoI=;
        b=c5L2Nj9AhXGjD43FRRlxyDlO1NDaaSQn7DrUcaFWCYlchzjNxAsZD3rHDl338J9ro4
         0QaWCpDPDRozTuD79oWCJoXgXkDKadqS4yA30dyiSH6vxAk40P0fIJ1UiTsKsvO8HxGY
         c/smh2SQVVxTmXZasJteUZM6qBl14pfmxYzbPBCnvXptOeXch5QMzua04YTaUYxVShCE
         OhozUYEQ/GICkTfxNnkin/Xrrn7MfzO94NVJTFx/WTpKZWahiG8KlZhmLSjQaKS3fec4
         JxCoLf2dKPRbF4NlA2ZANLeuwXm6ACla2vL0JiM7nRg6SUsUomgKIheED47bQx7SdaZ7
         7ryQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIXEEc9DrJFX4I5Cw5Q/Tw9srmEH1kt4Jj0/AhNM4ynHVkGuph7dcImT76LQRfJOhGovq3zAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfdeF+97MDFMpCdR2LiIbwdIXC0ELcPnRWoomlLqWAkdodWcc
	gxpCrigeLBQ7i9a1oH80nqJXkk2ZEf01pjSJgECxKwM2uwa6CpqIOUwT
X-Gm-Gg: ASbGncuv/kRUOYzX4+wdjmVENDMjgBVI5uRaQ0+7h0HBbg0lBPUKDoHuH/nekLu1jGc
	ywHFREKb2s6iryav5nmkIyyt39xro82jOv8dI3pWhZEur+a7vCqgg3wdWG49Rt6E6X6xU0zSaQs
	oMni2zKXG6bchYCe233+vVWO98AHijzj2kT7UXwkgIfdWNe9XPSSWuMOOvLvgRQHmg1W0UZ5kGs
	G3qrE7cqC7fo+6LQFOlNFIOfjnKuCeCcbhqTJYj798KyJb0Y676ocRSwbLy5kLRnd4zrS71IqFf
	sSpEgd5mX9YRDa1YjkQvUg5/0wpXSqAHgu+73f01pvFToB3Q4bQiy6pRMU5HIRUUviD7bEHxi/B
	Z1JMfD6WrZ2N9hoEBX0xhd4k57E4wsnNFYVI/5IeyOMPYa1lcBbgq82+/jkYazOudWJexebB3YJ
	Fd3HCBrRGpucipGPBjJ854jAlqm+9mAqA0AZ2BBYC9myPnMBGmpGIT4+pqEPengylvXrS1LbnXS
	luV7yEEmb12z3BuK+HZy596+a2EcV4GEXhh6ftIv3M=
X-Google-Smtp-Source: AGHT+IFzgFd0mKn5lagKBu1vcGEo58/NqJHfG5HmD4FjgxLN7PAUYJf8aNBB2MlJkzKRkcDthg76Dg==
X-Received: by 2002:a05:6000:26d1:b0:425:86b1:113a with SMTP id ffacd0b85a97d-4298f5825famr3429065f8f.16.1761333957262;
        Fri, 24 Oct 2025 12:25:57 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f20:af00:7cba:4f15:bb68:cf78? (p200300ea8f20af007cba4f15bb68cf78.dip0.t-ipconnect.de. [2003:ea:8f20:af00:7cba:4f15:bb68:cf78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c428e9b2sm167097105e9.5.2025.10.24.12.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 12:25:56 -0700 (PDT)
Message-ID: <8335ad5a-f5fa-4fb6-b67a-d73c4021291a@gmail.com>
Date: Fri, 24 Oct 2025 21:26:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: stmmac: mdio: fix smatch warning
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

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Reported-by: Simon Horman <horms@kernel.org>
Fixes: 4a107a0e8361 ("net: stmmac: mdio: use phy_find_first to simplify stmmac_mdio_register")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
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


