Return-Path: <netdev+bounces-232916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E909C09EB9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 216574E0F0D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DE301477;
	Sat, 25 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j82R5tR6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8762DCF71
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418334; cv=none; b=pPcUdRFDksFGgWaFzVLqzwjbqjVRsuVV+IzbicAs8s37vacLyTStkydyyv8vPP6pkk61DhZrl9xf/0IXWjS+icEk4xG9htFGa/GfBkQ2knz8VhYgfU5zOAlCGBUiIT0BdJnOakui0XjNvfUEP6EC+d++N9fVq37AA0LdI9ihU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418334; c=relaxed/simple;
	bh=DjzMNMITkdHrQn+TK/Lp9x4kSBfLr/Q4TTfQSfBhlXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p2ocR6OUa8nDi7SOMvYpXKL7NVagU0MkME/ltCGe+ZPAy0WYMnOBy2yPo1mJ84wRgOFM8HAJR6wUlXb7Icme6P7dTO9bMZHe2PLkLEusUymLJgG8MN5Ct+gBKZ14XmasUKP+BeT+IxemNYI4YU5zEXpwzUkz1iQ+7M59eZlr0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j82R5tR6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-427060bc0f5so1743059f8f.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418331; x=1762023131; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ReDAp/8LpQ3zDb8wx9z+hWL5nB06qpMyYSjY/XtFYNM=;
        b=j82R5tR61sAssvtn/lzVVgkr00DrsculR+mszjRom1Fax9vEPq/MTpt23abV4q3ts3
         P/UgoAbzrWTH6VnYnTvKH3fiPbdqMLd3mu7kbinR5gMkBkJMWAhst73NOSsjkyu8u8GB
         SNDO4EIc7nhUSiK5cpxzmp/BW/mb0CggqzAr712hZRPw03jiuUo7BuXM4MkuJ9gx/W0/
         EZxdtzymvC3ooR23C6wfxe7rnCEVmIISKnPrys/aOyAfnqUOHnD6R1TU2NicTElYY2s5
         Fily8V77zN3KDTmFYr9N8+d7f1LQ63gLQTEuE38WZwj7WmfLd/OlbrpZUPhO/+3wrYog
         UG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418331; x=1762023131;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ReDAp/8LpQ3zDb8wx9z+hWL5nB06qpMyYSjY/XtFYNM=;
        b=e/nr+jvSh4cE40jkpH8GZzCwT34F/Tt//vLq62jjZENAqwapocZKuKoqXRpPjg54o4
         elUwWB9bFrdlYu3eVtJPw9q9W1Xz6kBe7MDIgtbr6YSTnpld8M3dof+JOAmyMjx54kGk
         8GMjyS3Xvx8OI5KgwD4QMPhwLagZPWq7D74brMAnz2AMzVvzBEf7FOdYGEhQeTrAFAJ0
         Kbbwi6jW8CtH3ByS7lX6QH8+bk9AulN8F5YqYdUMQV5P0pvF08s0Ojw3K3E5UFiRfE7j
         CHuClVG9I1u5IIDhSRKHggPdGvzLEt9oySzgn55k1IvMCMoodfyDqJvLMAeBC7SFcyUm
         E05A==
X-Gm-Message-State: AOJu0YxqydLllyAhSDavZ1RoQq2amph6+iQXe4kIRQYQnAmzM1ELGkyk
	QUOTMpRJvCx2m1LncYnD/v54BsX8i4ddh4Z+lOEQ/hbnoefwDJcdvGgc
X-Gm-Gg: ASbGnctBwwAhLNCgsz+DuLM7SBBmifISYLz7rqYkTc9eosF2Mur/oVBGu8sQXGjtHO5
	jO+J45ZFk3FeVQ/0hJyyNc7uxRmRgaFiSuh12V3U9828SMwZ/ylN5Az8Z7QZUAifk/kDPai4tsc
	FCwuuD4zziNNcT8OA/mhMEH96s+J0RYqRSr7MAc8GfZICEQErxkMLodXM+ApLeiJt6Z52hh5Mvn
	RqAhtPIkgapWTFRPKfHvYWX1hlqz6Jb6Zuncn0v5015jiOeiFI+ARFgy/CmsBTEHw6GOkjqGQlT
	f3HttqNjmi49SNHeh+t3bsIpSR57meA+F2SBQFwWMh18rjA8gm+/BREW9Y2VQcx3WiqBmKhv1X0
	nhJbgYg+JC+sHsnxB4ngA5MYaKAZQyP65O0N/pZIq+5N+2xUVY08LgC8znrmUydwQkD6UQYvv2I
	Ev4PbGIatApyipLe+0lTMDm/YyD0NVQxTp6Vv5mabO66dFV/TI+LsXISY1E6IWZ1i7pZJZB1/JP
	vYX8bxVS8eNRpy+GuXaMryp2m6DzLf1cIqKzL/n08w=
X-Google-Smtp-Source: AGHT+IHCy6CuHWreuhY0kzq3aXI1LYVdpD3LbDxQTXXB3GVcd1wp3XcWvi9HhxFTqvcu//8jL+NjOQ==
X-Received: by 2002:a05:6000:2411:b0:405:3028:1bf2 with SMTP id ffacd0b85a97d-42990753148mr5404740f8f.62.1761418331081;
        Sat, 25 Oct 2025 11:52:11 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc16sm4853730f8f.15.2025.10.25.11.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:52:10 -0700 (PDT)
Message-ID: <326d1337-2c22-42e3-a152-046ac5c43095@gmail.com>
Date: Sat, 25 Oct 2025 20:52:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 net-next 3/4] net: davinci_mdio: use new iterator
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

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
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




