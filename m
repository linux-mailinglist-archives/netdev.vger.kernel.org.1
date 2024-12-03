Return-Path: <netdev+bounces-148704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B59E2EEC
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255D52811A1
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313320A5DB;
	Tue,  3 Dec 2024 22:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAagXLXV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842221D79A0;
	Tue,  3 Dec 2024 22:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264210; cv=none; b=aBBIkOhhgmgHUp53fu45MOBF2BLD6U7zfXVGUv1ZZbLxEFxz1K4D3vkiOnLqBw2cKVWxIECLyzYlvJDSw2Zv5VIUKuEMfGCmeyzaDTVVoqqxZdxpfkFizzpUbG6YeGJ6KBYAUS4wowAXTHnuMcsg6H7fFI8fD/zWbeav9UMyZus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264210; c=relaxed/simple;
	bh=WetT4KCWoqobKHA1jyiEvTHpEHivM3duZhF3iopc4mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUj795u6wRAFAugGxsM9U0wMI/Q7VYzgC7mIsb+2dBZ6tC+YtVb9jigA/qlq/ss5Uv8OrfnAFcYxC8tD64UOfrC8T2vXYJGiY3RLNH1EN30wwe7Z/Vwyg7eJN3AF6QhGP5MLeie9azPPBBEypL8GQFxgjTzUYhitWz6jeAuZlz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAagXLXV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724f74d6457so6031545b3a.0;
        Tue, 03 Dec 2024 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733264208; x=1733869008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Xlv6opsF0xbu6Gw4XKogPA2B7SDuqsnkMJ1U4QmmKM=;
        b=iAagXLXVWc4KXnFffG6aozy/szUoJ3YJKAZ+wJ/9oH5R1MiA9xPdxo/DOpHJM5bp0G
         rv09MMRDPNM7XWvhAkrVMhKbusIHN1TchnyjMg5vxToXK7KMCIrvB6HCz5dgLodeJPUy
         TqhfwbC4/Y6LbhEmiWDtBeqvfdJPmGkw6JSgnTXoT1ei1YgwTW/po8h+z43Jc1u6MkW0
         t83bMvb6t3vE1J1M4t6WRPCCFKhU4oeAHWww1E/CTG4bvzy1/iDwIhJo51HzVk0QuQFV
         yK1Bovu3kEpF3S0hjPdhxKCPen9VK8lgOIbk8g+akUpEuU2P/LloXcwwAhb6iQrsRSgB
         8GPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264208; x=1733869008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Xlv6opsF0xbu6Gw4XKogPA2B7SDuqsnkMJ1U4QmmKM=;
        b=nHYRWps7SHoo5GzkS2o9x5+kEE9ywCoE9/hpCFqnxHASYRyJ/+bwjvBDE1hoWQHFBB
         rBLFCAhfSElqgivuk0bjfvz4GuD0TwSYcEFD1rutDMg8PF1TpDDqP1JRYzvYD6EDltpb
         wLW7Z9HoKV4M1wDwRkaa9DqxAHfbEZfljB3JO0RI0XrRIbclqQUYqrdaOYiCcZBbo1EX
         TAIhlyaYHCwhqXSSr+x4v0bprS9fgnFhbzuXd0BEE5ZWpmAkW6resXsNaGIoaBtLnuTz
         yN7vexfNBlTQkvj0QgBouRfVAziOR2YHJH+8+GQ1H8Og1/uOzBFTKsy15jPnGqTDqbqD
         9ilg==
X-Forwarded-Encrypted: i=1; AJvYcCUSmLJMETYAWJv6uWqh4Vi3tbQLdxMQ1sgvFmyZxBbK+EtuUtwUcJZkmczTDAoHr3/5gunmf6ycYsql0mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUs9/NeK7VKEmTDnLRPqlbuJ4S9O1zemDxI56w2Vrirbiyc5vt
	54jONlPFo8TEI5DMZ+KPn5uSlm4w30q56b3LZct2xybdX9YtCagi07upIE8B
X-Gm-Gg: ASbGncsnL08diHiNMmpVLW8HIjd4hJxlhG0rqdj/k1tUuTxYdtwDowOmq6LcFNp5XhI
	/QouqdI/aa2PiKpSWiB/wTtSQH4+MufK5d7Wj4vyHELRIcKLbteRQiGfKanT2d8hInOWlYQTTBh
	7H+CvVPsyx3AHecpHswaEbjxsHJes1AUktMTVCG8N0xub7/zCCaPenLzlSOg7dma1MO5DmWi4af
	dxqmfDikD3TdbCv2Beuf07V9Q==
X-Google-Smtp-Source: AGHT+IHROhV5htb2QLt95N99yUx2PVs0JHDFrSRIHgnSYs0N+C/zFeBOT+RpRc3p5H7US/OaJlgLCQ==
X-Received: by 2002:a17:903:1790:b0:215:853d:38 with SMTP id d9443c01a7336-215bd200b3emr55713325ad.25.1733264208593;
        Tue, 03 Dec 2024 14:16:48 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521904caasm99779045ad.60.2024.12.03.14.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:16:48 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	ansuelsmth@gmail.com,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: mdio-ipq8064: use platform_get_resource
Date: Tue,  3 Dec 2024 14:16:43 -0800
Message-ID: <20241203221644.136104-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203221644.136104-1-rosenp@gmail.com>
References: <20241203221644.136104-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to get the of_node explicitly. platform_get_resource
already does this.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/mdio/mdio-ipq8064.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-ipq8064.c b/drivers/net/mdio/mdio-ipq8064.c
index 6253a9ab8b69..e3d311ce3810 100644
--- a/drivers/net/mdio/mdio-ipq8064.c
+++ b/drivers/net/mdio/mdio-ipq8064.c
@@ -111,15 +111,16 @@ ipq8064_mdio_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ipq8064_mdio *priv;
-	struct resource res;
+	struct resource *res;
 	struct mii_bus *bus;
 	void __iomem *base;
 	int ret;
 
-	if (of_address_to_resource(np, 0, &res))
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
 		return -ENOMEM;
 
-	base = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
+	base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (!base)
 		return -ENOMEM;
 
-- 
2.47.0


