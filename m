Return-Path: <netdev+bounces-166190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A59A34E4A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64D53A9429
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD2245AF4;
	Thu, 13 Feb 2025 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG53qLNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE15207DF5
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739474113; cv=none; b=BhhSrdrsQJzULa4anYa5dnZJsxMr+mDybiZFQM/AOCVwEmj0uYiX6Uq0AZRPbHq0Mz9fu1kwWimasF92XlveLfth2Je4XEYaoTzd+j7f8iPsl2toYVypj1pPrzNBSLCN9rjhqDSAiORrh40DitVDXEu02gS8ixALlHcNx/XgcYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739474113; c=relaxed/simple;
	bh=YHwj2vgw0edAtD+zWlq8pSERpoEpDr7QktM9pnOs8ss=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cm+ZQjlDFf8OCl9fJirE/pGMwik7VfI2ED/lmvg70KWgYxRkYah8DpgcAwttwyFrwHMvzbesxC3EevApnrLwlra6C3aWPHkwZF5KQ7a90cvO3LChRZCpE/v+d8drmW6K438sw9OIIsKWL7IHe9eavPCYW3i/8sOiCfcPY7diz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG53qLNC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so1895475a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739474109; x=1740078909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kLy/VUh3iLQXwGRX+b2tFLjcAPop6DDCMG2HFbW2lX0=;
        b=mG53qLNCzDpcOKNfgELAU3IdpKAOJT5GEHbW03Jv0Bv/7rsLa3q9LwRs90mDc2r5vo
         HcLhUGlIahvvQEu5iliYqQ95nHLahIW63FovcgmKxuNWbI0+gdJAjuS5l24VPsjq1ORs
         e5MrGj4206KkE5JrKtCC4VflpML3SmE4g7i0vtBkiNLkNVem9puoKAwgJcedSGiICodf
         fMuzK0PRwRHG8R/dyrsOQM22O94ZCkqJsLz0d7Z+AwIrZfoI+pzfikQQNQhdojYyUN5r
         XjKy4eQYLmO/u4hoyk4qaH/OzeDtJJrp7BPWZIx1sZSoMPRUsqCxjxBIIjVa6muWMouo
         NiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739474109; x=1740078909;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLy/VUh3iLQXwGRX+b2tFLjcAPop6DDCMG2HFbW2lX0=;
        b=swsmGSFQUphYq+ohEUr0L63q7buXiOoPRlXLjW88WNZdgbjhXBsngSEM+JpP9LrOgp
         VivxXXLham+iIsCRL/W9PJbQ0aI6TbtAUi0HU1ozWbhwQ0hWBfhM4hkUWb7tYR+GxUhE
         GDmA3c/xbjvjMT23FULsec8C4+ZpLOyB8iTHyxACOun64fQEeFlRFP0d+zFje2fKFt1Y
         P6ZPJxcF2epUL9qNpB2F81gxprzLRUz6GLVBwbmE5uSmznKTlqvYj3IJdmiqcHqIfEO1
         Yi+Pkq+wphuLn9sq6fNDQBXv1FGTBvwi1KELs12WiQZxqrwvjaYweEaskWu7bab2XJx8
         H7Fg==
X-Gm-Message-State: AOJu0YxqNT9hFh9c3ycoSuVrDd/WzxiJPteYF35na9qdWu8ryME4nOXo
	HFVDXtJTX7Pxe2UYQGn38fPsOCHTXueFNjRGuI8nQHND3bhyu/6e
X-Gm-Gg: ASbGncu1HpmfU+0j3VO7K5eNRrJcu2kWHhPWK9+UOmQu21VBZufkCOevRY2/2GRVTrI
	NdcBPi3fiN/KEMHe+k5VSUv28KW/m30j//PxElsns1+yiJCynXwJ2rjOYboBps7p7Kv8Jd2rSoh
	VDEbGuC4zS2ucf2wfsHASG8bz+XBL8aL1wHJYXyFbdswUHb4SSLBpFGyyBTg/TpnjPcAPCEltw5
	oyWc41Qc1K9Hv/ArmQEC8LeU10PtgNhsvHsFBIq3XmAe1pW1tx4LWYo72cN67qX0LEFMkykbkOc
	4CniVYcmtzI2RBLPKvQDZe0AT3N/q8JdV9pJEQ2odqVDQg4FbczRIw8YCxN+rNk2MLiLiUds2T6
	fAgpUQOnM596XjtmHJLYoF753dzeZNBpofN5H3WMEBEOLZv0+ciPXDE9G17ayW1ft81TVbXuS1q
	SNUT5u
X-Google-Smtp-Source: AGHT+IFk3ripNihVXRilgD+8AazXf/lze6Q7Jjx508qpNS2gzDi44HgfgBCYTdZ0gDhBo6kr5wYn/Q==
X-Received: by 2002:a05:6402:2382:b0:5dc:73fc:2693 with SMTP id 4fb4d7f45d1cf-5deaddb60bfmr6893018a12.18.1739474109186;
        Thu, 13 Feb 2025 11:15:09 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dea:b00:8140:d035:b1a4:911d? (dynamic-2a02-3100-9dea-0b00-8140-d035-b1a4-911d.310.pool.telefonica.de. [2a02:3100:9dea:b00:8140:d035:b1a4:911d])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dece287d13sm1623783a12.68.2025.02.13.11.15.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 11:15:08 -0800 (PST)
Message-ID: <d6f97eaa-0f13-468f-89cb-75a41087bc4a@gmail.com>
Date: Thu, 13 Feb 2025 20:15:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 1/3] r8169: add PHY c45 ops for MDIO_MMD_VENDOR2
 registers
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c6a969ef-fd7f-48d6-8c48-4bc548831a8d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The integrated PHYs on chip versions from RTL8168g allow to address
MDIO_MMD_VEND2 registers. All c22 standard registers are mapped to
MDIO_MMD_VEND2 registers. So far the paging mechanism is used to
address PHY registers. Add support for c45 ops to address MDIO_MMD_VEND2
registers directly, w/o the paging.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove superfluous space
- make check in r8169_mdio_write_reg_c45 more strict
---
 drivers/net/ethernet/realtek/r8169_main.c | 32 +++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9fe53322d..fa339bd8c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5200,6 +5200,33 @@ static int r8169_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
 	return 0;
 }
 
+static int r8169_mdio_read_reg_c45(struct mii_bus *mii_bus, int addr,
+				   int devnum, int regnum)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (addr > 0)
+		return -ENODEV;
+
+	if (devnum == MDIO_MMD_VEND2 && regnum > MDIO_STAT2)
+		return r8168_phy_ocp_read(tp, regnum);
+
+	return 0;
+}
+
+static int r8169_mdio_write_reg_c45(struct mii_bus *mii_bus, int addr,
+				    int devnum, int regnum, u16 val)
+{
+	struct rtl8169_private *tp = mii_bus->priv;
+
+	if (addr > 0 || devnum != MDIO_MMD_VEND2 || regnum <= MDIO_STAT2)
+		return -ENODEV;
+
+	r8168_phy_ocp_write(tp, regnum, val);
+
+	return 0;
+}
+
 static int r8169_mdio_register(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5230,6 +5257,11 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->read = r8169_mdio_read_reg;
 	new_bus->write = r8169_mdio_write_reg;
 
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_40) {
+		new_bus->read_c45 = r8169_mdio_read_reg_c45;
+		new_bus->write_c45 = r8169_mdio_write_reg_c45;
+	}
+
 	ret = devm_mdiobus_register(&pdev->dev, new_bus);
 	if (ret)
 		return ret;
-- 
2.48.1



