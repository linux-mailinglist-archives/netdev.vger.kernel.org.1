Return-Path: <netdev+bounces-220631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7AB477E2
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 00:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF2E7C00DE
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 22:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83B027815F;
	Sat,  6 Sep 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz0BsfQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC020C038
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757196052; cv=none; b=T8DzRXcSLVCj8OTx6qpXFDXJsSjooDhBIg3xN5lOTIWqlBCGpPHON0LCGIHr8tXzooD85KJF6OY4h+65pgnupK2wIZhDVejt4MMuH/R1LLFje/Yk7Op3Khl/iFL3UvqW9LMu7CH9bnASWnhke07JUVo4Jov/rvlnaVl1L/b/2ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757196052; c=relaxed/simple;
	bh=y3W6Pg4uUBIUBD8Z8veUvPcg1I949YFjHMxV0OgtEvs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UcHkbHXYydMzr15B7uwkHH9b0GWOWwVcu9jO6rqRunVNoTpA3VJdsoGVv3yuXTP9jxs6JGA2cY5lw8UC84BRhofxS5h0/Aywucvc+CjuBSQUZRD4q4IGWxyMl9yYeNv7b6EpnNCz7E6WezUFqMaVKvhGDvjm/SpWX1jTFO9dfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz0BsfQQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so27260965e9.1
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757196049; x=1757800849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zy+uQHQulDLS1flxkvqY4fWngxYOcJt1/EF9+xGnp0I=;
        b=cz0BsfQQmGslL7ytIiCLLxgzN2nhsQW6iV1V1fuq1ZYHx0LpqTuIgHD72kWNnxIiLO
         p939MSO5sjqc4MPmgYGA8WhWn2A5vpFiV/RwxdpILg2Qq6NjTgkLLCdZWUlaobbPORo0
         n2DFlX53hdJxBH8o6Gr4fIehOhmO7STxBqFKMKFeQhV0KA4yVc2FE0cCYaf2BNhZQw4x
         NXeLvBvA8v8at6FQydBKytBojxHiAZdC23FvhsMlpk/wV0CC2oxdNcWZm8ZPYRYTpiq2
         shRrIarEfMFeWX4VqjABBiAXDs3fxVw59zCRHT9gINssDqQCQuiefaThaIFLWg3wVeXA
         RS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757196049; x=1757800849;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zy+uQHQulDLS1flxkvqY4fWngxYOcJt1/EF9+xGnp0I=;
        b=v5wckM+cFy62BgdJSRIgCKx253v9qpmctzVOsMgbemLmVtzYonZ8EXsMWB+XLkSQys
         E5fqrNH0UVKHamtZmMHGc7dl6CVg2cvg5AGecW54WVSZTE82BG3gqZYgo7ujQFw1nePX
         GhyhgkgZkL8DrGPaS6jqfAtK+fyscDbWtuuaXph2v1IGYP+9nJ/Xgp1/o4Cds0kpWWqV
         sRy6+tT1lVj8hwpjf471wSoRSMDfsTtzp13qfX1nxK6PXx++VF5Dax33L9NHuY5boftg
         ByBP0s1jG+DzZ/gNiUveoAeNELwUbBxrnpJ/qCt5PRDHwiLtGLaNX9SYRf6AzQIjS5wQ
         sXQA==
X-Gm-Message-State: AOJu0YxgVmvovuzIc/dcKXj2kJCy1Zd4/cWulRcg6UtnIeBvF5VSs1VP
	P4NL8Llu4wmuvlRLsW/GG/+ciCx/Lg1eBnx4th9j+71xECRb4g9HeLu/
X-Gm-Gg: ASbGncseutkolAsTifPdnb5wYwgSNXfvUGy2oP57dLoez/LPHZFlIqLpcNSq8VMjFRV
	Zgiy0z+ODaS2RGNmUQy0gQhdCmb30VJbdu/xSYf0b/jGl/qQsLWsR/HwzheJWzQy3iz+R3AjZPP
	CVGE/syNkN2Hrb0mwKJBpP1V8gv1Saol5JOiJZ2eHE00+ZKVZjZBhCcNop7mK8iEqxIG1aIXltB
	Ly0P9NmtSaG8bj78DTEqB8pRYWwYKUPjNiVMROwueEFoxdzJXcEONl+jlIapBjR0y7+JTqM2rg9
	n2sCD4uCgisgbNLD5CgVWwLEU3+kEyFz9FGQuoItg4huBbxQppTrIL/ghAzhKauJoIfiOVc+RNl
	b4IrYpaG1Wu/Sc8Aq96G5k0YGDdw7N2Kd4qlnk1lCS1qyhEhgjYXEjJtjhXr5NUC7jtcsGW0EAM
	nNG3L5jszd6mmjqaBoSIYVapBntLHwPueTEzo3mIi2HfMIrCJMm2VrCov5rTUBz4ffrifMPQ==
X-Google-Smtp-Source: AGHT+IEjkuF97sv8faZmBGmI54gcDDq42H3bgAJOmec7fBPrE/VAaKwGx81NYDfJomHP/i7IEXWAXA==
X-Received: by 2002:a05:600c:1d16:b0:45d:dd94:7c09 with SMTP id 5b1f17b1804b1-45ddde955c3mr28396845e9.1.1757196048935;
        Sat, 06 Sep 2025 15:00:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7? (p200300ea8f2bf400f9ef05bb5d7726c7.dip0.t-ipconnect.de. [2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm5524777f8f.0.2025.09.06.15.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 15:00:48 -0700 (PDT)
Message-ID: <deca9f14-55ba-4176-8535-bfdab618871f@gmail.com>
Date: Sun, 7 Sep 2025 00:01:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/4] net: phy: fixed_phy: remove member no_carrier
 from struct fixed_phy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After the recent removal of gpio support member no_carrier isn't
needed any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 1ac17ef33..35ac29c3e 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -32,7 +32,6 @@ struct fixed_phy {
 	int addr;
 	struct phy_device *phydev;
 	struct fixed_phy_status status;
-	bool no_carrier;
 	int (*link_update)(struct net_device *, struct fixed_phy_status *);
 	struct list_head node;
 };
@@ -52,7 +51,7 @@ int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
 
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phydev->mdio.addr) {
-			fp->no_carrier = !new_carrier;
+			fp->status.link = new_carrier;
 			return 0;
 		}
 	}
@@ -67,8 +66,6 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
 
 	list_for_each_entry(fp, &fmb->phys, node) {
 		if (fp->addr == phy_addr) {
-			fp->status.link = !fp->no_carrier;
-
 			/* Issue callback if user registered it. */
 			if (fp->link_update)
 				fp->link_update(fp->phydev->attached_dev,
-- 
2.51.0



