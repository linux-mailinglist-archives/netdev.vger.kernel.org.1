Return-Path: <netdev+bounces-162235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488DA2651E
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1D7A43D9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 20:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7999E20E70A;
	Mon,  3 Feb 2025 20:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlH8LReb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329820E701
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738615669; cv=none; b=WXN81wRd4dyv/moZtanKBZaH9LJjuFz6/7F6R7D91BQpGE3CVpR084XLdwb5ajG95375f+HsprVbawM72jEqYGeGKb54H42Lbdd5PljfHzNL7+fIxRM9IQyPg3uyNOlrsKl5OfDdAVzt5KWyTj5jy80QgYWHLqEjGoahgpP7ckI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738615669; c=relaxed/simple;
	bh=srEFEraNkrt+I2G6BUHQytSDu5aYR3ZThrzEJaHJ+5U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=qmB77+SfWWLEz0NkGODTLZO0l1yatvTxk3dVh8pkUgBcKw7mFYTER3SKJcFkZLGpcGCUpzKTYnzGKg5+H9Kq6YqkQSIHi3zF3frJ7aHji+gBDrd8KKCPNrtBQ+Hj0RxBtiTU4Zget37EukBsH4m10PJCCLKzVCexyV+CET2j5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlH8LReb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so874471266b.2
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 12:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738615666; x=1739220466; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GBSCGtHOPIDBnrj/8l+PXAZQNzyGTu54FDa+QQLhoLA=;
        b=mlH8LReba53zwjhwHg2PatfSX/0qypAdBPvZ4eyoqu3dR8T09+o8S+mSQkvXsguN6D
         vKg8nZxIhFwuBMgY8UcT3K9P8Xa7KHylQwcyCje/RbqubOI88nX/hIMEegDmaJRbEv4l
         KK2sS4y0fnebLfHQmC2eaCjYAXad0+NYrxhITyMLK563bHZ8MkwBSZY1K2d+E/e/600+
         yvoaBkXjWL1k+Pvc7anxztarrCNh4VvoNDkR/FA3nm8J1JpqI70wm+/tQcX7JR+9FKTy
         DzA3l+UiZKOxtIMD+02PvjQot+i/E4P8BKT3TjoBRbOqUieiGjehxOWlCtmdQ9QVRo/J
         qxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738615666; x=1739220466;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GBSCGtHOPIDBnrj/8l+PXAZQNzyGTu54FDa+QQLhoLA=;
        b=YaSMyVN34SAB8rYlQKRw41JpH8/QrA/zVPZzwVeZAVTtlbwrIAqnOB+X9Y8TwxirI/
         q2K8ZbLhIPIbmZu2Zrad/pgesc/Q8DbGBW/LurPNHfASYYV8rTxZh0Lj9LK8ukpI0+sV
         +CAFXw5xE+3sFFcGpN2PpA7EuEIRIxVBagBobCXPweGd3y7QOynEeyDwn+jhnzrR9bHK
         OGYKtUZwzjIKEPCP/Yz67TzEauV2p3QBdSq5uqpc9rpOhb3xbEm1huB6eRJWPIJr85GW
         K3iLObyrlSuAl3iDef3EYW4AYRV2Za8SKQZEYEqslzldOeRgk9yJZ19WQzCQIjd18ka3
         WrgQ==
X-Gm-Message-State: AOJu0YwD8MFJO8mj2ci3QB7pOgE4Q8+Puu7x6yh0W5oahFguhQ3R2oK9
	4XBDbXywLkMZOPKmKqrDqzuIdDeWr2EY4kH1Dd1LiNL1A64Ta6J9
X-Gm-Gg: ASbGncuFO+97sibTfFYW/AqaQ8opXbokul4hIZqniM2gYuaXenSO+zrJkIBt4FCcl1l
	6/plOfvkT3X3mZyZPZygu/tkv/R584tHjoST26Fi8XnkP2iULz16raYPlWq+RhKZj3GZDYLxXzh
	DleVA+pDoOMbGcG4gijjP3yTCip0UdjFKleVVLeefsk+9ZgvZoZfa3yvHicBlahcepUx/Y/txec
	qa8wMytzsJT9er5sBqaING7LS/M7oCrmJkX5rSwUeD1g64aQJIn29UHFInN3XStOlbqIKZD0EBh
	1jv0SuhiZ6f/F9l4B/hsf5f3uaC4NJVcVpwAVKhwSbsg9w8M6uJqLq5tLLvDMWY2WVI+veOkdhh
	ju4LkO9Kw2KlfrKWT1NefdDdYG0Xj389EGJo9oBr1dQWfsXe5O3s/Uf8WFiuFG/GKr4tjnp3pRt
	+lfOhuq1o=
X-Google-Smtp-Source: AGHT+IF5/0upmNJFLZpVyx5dJu1P68Fvf37X0DRMFZ2DP50dV5bjFqC+vUr/89Z2HLou7AKs2UxnOg==
X-Received: by 2002:a17:906:f5a4:b0:ab7:4884:c804 with SMTP id a640c23a62f3a-ab74884c871mr72332866b.36.1738615665527;
        Mon, 03 Feb 2025 12:47:45 -0800 (PST)
Received: from ?IPV6:2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04? (dynamic-2a02-3100-ac6d-8e00-811e-2e8d-e68f-ec04.310.pool.telefonica.de. [2a02:3100:ac6d:8e00:811e:2e8d:e68f:ec04])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab6ffc9eb9dsm607641366b.27.2025.02.03.12.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 12:47:44 -0800 (PST)
Message-ID: <65a41b61-1122-49cb-805c-cf2cfe636b72@gmail.com>
Date: Mon, 3 Feb 2025 21:48:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: don't scan PHY addresses > 0
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The PHY address is a dummy anyway, because r8169 PHY access registers
don't support a PHY address. Therefore scan address 0 only, this saves
some cpu cycles and allows to remove two checks.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5a5eba49c..a65a6cbe9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5180,9 +5180,6 @@ static int r8169_mdio_read_reg(struct mii_bus *mii_bus, int phyaddr, int phyreg)
 {
 	struct rtl8169_private *tp = mii_bus->priv;
 
-	if (phyaddr > 0)
-		return -ENODEV;
-
 	return rtl_readphy(tp, phyreg);
 }
 
@@ -5191,9 +5188,6 @@ static int r8169_mdio_write_reg(struct mii_bus *mii_bus, int phyaddr,
 {
 	struct rtl8169_private *tp = mii_bus->priv;
 
-	if (phyaddr > 0)
-		return -ENODEV;
-
 	rtl_writephy(tp, phyreg, val);
 
 	return 0;
@@ -5222,6 +5216,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.48.1


