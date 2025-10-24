Return-Path: <netdev+bounces-232676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDEC080B3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 22:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFC81C2439D
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D212F39BF;
	Fri, 24 Oct 2025 20:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIRD2yCW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72832F0C74
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337415; cv=none; b=gUpTAReTuLvAHNu3GoRzBUvvJwcb9s2Kmhn/oc+yftAA8sr2Hx40H2wDzH6UOBYvX0VceytgQN6q0EmKgK2E9TV4N0FVJajM0ob75e0i2QNtYHN6l1txVgIvvd2iFSJyEZyRY6YomkeuNihjh8UFqv1LFI2nS+DgvlaKRWxnf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337415; c=relaxed/simple;
	bh=OhJd8xXPcEcT0DW7ngFFIodfptbKL3zNA9AKjslt5I0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qMLjj/Q01SEuYDnGBFD260sgRhHauXf9hQA7geFTwuS4B6BcsPibEOESqEd+Odu2wrFB4SB+xvLlZn4TskU+fCxsF5R4Jfg/CEGlMJ7J+BPNtDXrQZR0tvvCCzujPfmT33oImWYCKsCOxJGtUKazIcXlcJADYWgxpAU/dR37Ffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIRD2yCW; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso1561470f8f.3
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761337411; x=1761942211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nbS3pF4SQlN6nJst9gf1MGtul+xJiXycghgmgoEvhFA=;
        b=dIRD2yCWD6StOh7R+Qh7jrTNF6yoZ3bOMX/xwLowdB5I5CWwzfaEFnwWa9tG0a28yw
         DFZMBOFHX0FPwFqVypdVdiY0x6t3lO/w6szVCoZwWFmbqtJHq1FfUhIIEIxZBVUXEPYu
         EDjE6Bsp6caAxgaG7VGAIIR0UFMb0MiFeE9xFv0BOEAcVhKbUEXcAYJPT2RBPD1Mqj0f
         jFVt/TyJcSuQWuIm0EeeiaVRzngwzFeJTo6ai3/F0GGQGpOXabhccsm/j0v/s8ySBFEQ
         KoaDnr8SAEpj9UGj+bpNm+VdgAk2MmT/5uwOnv4ggJxaqE0SkxqfeFFxUbjECVSvJXh8
         k9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761337411; x=1761942211;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbS3pF4SQlN6nJst9gf1MGtul+xJiXycghgmgoEvhFA=;
        b=fhrKkF0u9ORS1f3E0CAwzWkxF+LDOuwZS8xmG25n5uTB7SqDPHPaOHO6WNIs7pCeIC
         Vm+YnynYNf7EdwoHGgGTL+FTwvGkQkjNZAi1yWY4nELiE8xp7l+6PCPhvkDbsy070jtg
         +ajDVqrfIFtW5qQxKDunP+dsAzU7q44OXBHfUkz5oSQl7im0xZw6hsgE5ruyIm/znU8N
         DdJOn4rOQjw62ahNWY0To/sjsekPTtFUlfA81xiw6XOw/vlAoo2AGiZ5aBU7DCcpZY2c
         rtKiddxsBFmuxk08DbBEmrg1O0FYw2yvjUye3HdAtj8PpVxIIWjBGNOz20vtoeY2EvOR
         nYag==
X-Gm-Message-State: AOJu0YwCRzqqN/KavwmJBcPfzIeD4W9oZ945bQ1j4QgwIQtyqeDsNQ7c
	gb+XpBi9SlETWYuT8HygbvQ/NlNyaUkUOW0mcRvV+yXzZLfWaHFL1TG/
X-Gm-Gg: ASbGncvBU5nRAoBrjhbRZRfy16BBFuwtOIrguSw4jqcZIDXh3m+m/VlEifYbVjdMVVa
	Cs+22l0l8CI+8FvlZt/ejRGtP7A90QxPHUodb8s8/3gbDuOx2yfitQkRbpX0mgOVvmfSXfUZX5e
	fscNQqE8zsnp988m833wDM55SXjwP/cyv7Z/cgrKJMwG4G3JzEgyDg3KyQ5+JzqkrZx5IfPm1LI
	LRVC8yoDIV2/NGX9ko3Lh+M7R031yOQFFbpM+SXhz5l9Z4jhJCG922/vvPNc6GqybpnI6A/efz1
	s7cVdM5yS8GhivZsXrBI+KZ7OePvLwqjc6fr3fq/YsmbMl8tQjj8A4xkv02TzqSNiYBcCNSaxNk
	ySHObH7gFE89VhsKHkC4p7P3yZ5PsZ4Y7P9h9rUGI+3BYCvUr/m7edogvGURxKMhvsyMCGIRkr0
	DGThNo9W6pEsGegXX1qPyzyeUZExg7vRPwq4wLr00DYfBfq/+IL+pMD8cJnhwSasvXwWeZI2cOy
	XndujESL6ok7F01yU6PuEmnqMW3Ixrl3rdmxSA3KyE=
X-Google-Smtp-Source: AGHT+IG4IY+grum2RAe/4ZPmFWxqYrPxM8oPy0gbReq+19TlrgCjDXVWLsTj+qAjoigdXYkviWwGPw==
X-Received: by 2002:a05:6000:400a:b0:425:8133:ec6c with SMTP id ffacd0b85a97d-42704d1460fmr16419521f8f.9.1761337411112;
        Fri, 24 Oct 2025 13:23:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f20:af00:7cba:4f15:bb68:cf78? (p200300ea8f20af007cba4f15bb68cf78.dip0.t-ipconnect.de. [2003:ea:8f20:af00:7cba:4f15:bb68:cf78])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm169628f8f.38.2025.10.24.13.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 13:23:30 -0700 (PDT)
Message-ID: <aadd3bd7-5cc5-45f5-b14d-d0b63629d612@gmail.com>
Date: Fri, 24 Oct 2025 22:23:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 3/4] net: davinci_mdio: use new iterator
 mdiobus_for_each_phy
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
References: <9c6aeec5-f651-4cf0-8cca-d2455048e89e@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <9c6aeec5-f651-4cf0-8cca-d2455048e89e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new iterator mdiobus_for_each_phy() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 68507126b..713ed4ef6 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -548,8 +548,8 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	struct davinci_mdio_data *data;
 	struct resource *res;
 	struct phy_device *phy;
-	int ret, addr;
 	int autosuspend_delay_ms = -1;
+	int ret;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -652,14 +652,10 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 		goto bail_out;
 
 	/* scan and dump the bus */
-	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		phy = mdiobus_get_phy(data->bus, addr);
-		if (phy) {
-			dev_info(dev, "phy[%d]: device %s, driver %s\n",
-				 phy->mdio.addr, phydev_name(phy),
-				 phy->drv ? phy->drv->name : "unknown");
-		}
-	}
+	mdiobus_for_each_phy(data->bus, phy)
+		dev_info(dev, "phy[%d]: device %s, driver %s\n",
+			 phy->mdio.addr, phydev_name(phy),
+			 phy->drv ? phy->drv->name : "unknown");
 
 	return 0;
 
-- 
2.51.1



