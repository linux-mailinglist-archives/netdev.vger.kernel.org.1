Return-Path: <netdev+bounces-250679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B48D38B56
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 871633009233
	for <lists+netdev@lfdr.de>; Sat, 17 Jan 2026 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875C019E992;
	Sat, 17 Jan 2026 01:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Qu3r5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C36119CD1D
	for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768614435; cv=none; b=bfDAijAv97+/BcC+GGuYyvP0wGs467ju/G1QF5fSBJH3Izpy6zCpbg5BEHYZtGmxX567edMojxt8AJpuURX1MpX3TSI3mH5FnOZlYHVWW8KstvmNPFA+RY0QCB2zbg2RU5tBI+KUfSFgnyuMACMDhaF2rnYld+baxNPv+OhvTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768614435; c=relaxed/simple;
	bh=BvuU6hrE1kad6S3+bK5hW2J5kpLldKHiQJhKeE9NW9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ucz+QbLw5kXwAOjJnYOFVy53dvAzP6jKPU83akj0cAizNAtUl7pAUYeBp1GSfEDQB/FWbp5SASa4CbcOwbDEDo+uUSzUkifQLG26xHuFohg8fCXKhIJwqRGqcAoC6uHa4xgwLsmMz+7ZA25KTvBX4kJw4RYD3b4PXDsJnGjHcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Qu3r5Y; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-501469b598fso18737211cf.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 17:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768614433; x=1769219233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQx60645GAGQ1r8004YFDj1uRm95KZRpsaEBWEqJO9k=;
        b=Z+Qu3r5YivQN3CuNBudcj7MvJTatWJaeTGnG6wXbihq3clIaj1iFWtaGJ5qKxlU/qR
         m8sgB/q0Sq8+U4cYtJ7cCgs/yE3nK3zzDSIeS7URug7tNbQyhVoZtZvVp8DaLefW8WAg
         uXm3e5k124JPJV3DpK4aEQRl2UJnGx9DVaZlK/ahRN3de6w8ZSZuEXSPx/LJpmjwzxdy
         /o8jVR/MOacSQyGEqC4OnQvdik1gL/i7N88Tqt6m1ixFYT9T+0iJBi1Zq/Fn5tmiDc1E
         m2pt3EKybexTRTicpvmUlk3A+HCEW0I9O3c8WNQ3bCDk5vwIAQODzoi1zy3I6rkcPuzc
         oyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768614433; x=1769219233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQx60645GAGQ1r8004YFDj1uRm95KZRpsaEBWEqJO9k=;
        b=VEBfCZ984Ji5NPjbxT4zfcx7AtAnE9GgwJN8CZdXzOjRiN6T2wwyjyROurWzljL3Ub
         qH9XwoRoOKV7MY4MdYjU7nZN2pzl+Q3RJillyfRjIiqUdd3Pd+M/n06JGQW9jujuuNiE
         cypGp80NMleZmVAlqXBtro3nZQKoK0S+6nHZ740cgbM228JN0Z+cRuxTr6mS8LGw0cEL
         m5/p1EI22VwXnQcBxA+0CaAGCU+Vo5rCAKvADUWm1QL2ZL2quo7OBGR/eT+nTw0U7OQW
         eptMiA0ows5GHBbxeUJfZVp/qCiVPLofkBbUQCHtdy+W1xDZlDtFH1lFGv50Ia9BDTLH
         0UGA==
X-Gm-Message-State: AOJu0YwJ45ortRzIda7s8x5Zdm9VEBLAyBb9JpgCI+oXX19n32XYXg3L
	PZB1QlLR8nFmgAFmyB2nEW2pNpdMDvXIPrB8rPCBZCjNhBDhG3a1X0hZHh3EelDUVfk=
X-Gm-Gg: AY/fxX4UGVmKymy5MJoFWaKlVuPnq44Qj7DoPeqSsbNmVqzhhOIuySIt+04nNFg/rAu
	ldnNw/WkzJbN9dtUHvMpF80HU6t+kTy2Xg0+7tfZq0LbCrSS3nHf+Y3lgRYwckb88r3pB/088xK
	AnPio2vDMv4eLF3MGVe7vLMs0XxkT5GgHWde0X8vEtkTU5qOZP4IMfo9WpKDrjb31ECRwb3eG9E
	hLyIu329ztyfa8iPAX7gGHOIk6ro2om87ecrOrs+GdE9fvHHOMIrjri1LrA2eiUF9qPmdvizETx
	u7ZrCAXKOMcIpHudv5A2MHcLwylGFY4BXnKU59FxYAAbAuo1uLkJ0NnXl1glqCwRX7TATfPGCrA
	3BKGtDsB2ZGVZbW/bJOrPi3baFbGyeUjD7za7+DcxSqjDawF2CT4X06mXIjJNutxsFYpbDeaJU5
	8SmmmtQ/UtsVSgO+W1txJJ
X-Received: by 2002:a05:622a:58e:b0:4ee:43b0:b053 with SMTP id d75a77b69052e-502a1ddba73mr57064661cf.9.1768614432848;
        Fri, 16 Jan 2026 17:47:12 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e49b4sm36481806d6.8.2026.01.16.17.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 17:47:12 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Date: Sat, 17 Jan 2026 09:46:18 +0800
Subject: [PATCH net-next] net: macb: Replace open-coded device config
 retrieval with of_device_get_match_data()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260117-macb-v1-1-f092092d8c91@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOnpamkC/x3MSwqAIBRG4a3IHSdkA4W2Eg18/NYdZKERgrT3p
 OEHh9OoIDMKzaJRxsOFz9ShBkF+t2mD5NBN0zjpUSkjD+udhEEM2hvtgqWeXhmR679ZKOGWCfW
 m9X0/owMPu2AAAAA=
X-Change-ID: 20260117-macb-e7efd6c76bda
To: netdev@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.14.2

Use of_device_get_match_data() to replace the open-coded method for
obtaining the device config.

Additionally, adjust the ordering of local variables to ensure
compatibility with RCS.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 2d5f3eb0953038dfcbb28db591227cbe5f6e80f0..5cfd859f3b293de3abfb827fcdfb2198f6304ae2 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5433,9 +5433,9 @@ static const struct macb_config default_gem_config = {
 
 static int macb_probe(struct platform_device *pdev)
 {
-	const struct macb_config *macb_config = &default_gem_config;
-	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
+	struct device_node *np = pdev->dev.of_node;
+	const struct macb_config *macb_config;
 	struct clk *tsu_clk = NULL;
 	phy_interface_t interface;
 	struct net_device *dev;
@@ -5451,13 +5451,9 @@ static int macb_probe(struct platform_device *pdev)
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-	if (np) {
-		const struct of_device_id *match;
-
-		match = of_match_node(macb_dt_ids, np);
-		if (match && match->data)
-			macb_config = match->data;
-	}
+	macb_config = of_device_get_match_data(&pdev->dev);
+	if (!macb_config)
+		macb_config = &default_gem_config;
 
 	err = macb_config->clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)

---
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20260117-macb-e7efd6c76bda

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


