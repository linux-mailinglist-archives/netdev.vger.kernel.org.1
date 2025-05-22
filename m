Return-Path: <netdev+bounces-192800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E5AC11B6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 18:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4546E7AC3F0
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 16:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2299D2BDC04;
	Thu, 22 May 2025 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ69163K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503A02BD582;
	Thu, 22 May 2025 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747932839; cv=none; b=KQipvo9+0Ok2y6EyyU0jnYG9SJFpBwR8jU9tf+DBcppuGcumukstURKTasC+Lf4ktPK0Q7B7rQmBWwM7ndubHVK+Bk04wVeFqmmDVYkdrLyWPjoYV+o+gwjYoOz6eP5rbobhbxIQFcfJh9eaR3qg39Zg9ZJ7mW11+mEerJsrQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747932839; c=relaxed/simple;
	bh=5Nx46qMP2LaiYn+e/vEsyqmYR8nE5nhIOWz5MvdtQsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pI0JSOyu7beLWARhAmGoRq9MYYrf0mkOry+IxDtbJmxqNV3+iKqoGdaDQ90rwadwQiN5s9VMAT09p8RQCeji62q1qZAeGirYd1XDiONg119TprhtTpCBIwqs7aacyb53UenaKcVhRa/9KfZGW05xHqQhI2Ioas9v6fxRGp5CAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQ69163K; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0618746bso67788305e9.2;
        Thu, 22 May 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747932835; x=1748537635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSfESP3eCTxh/lZuV155AcEe86QVGTg9cJglhVrSbYE=;
        b=kQ69163KXUxrfpgPc3FHmueZZ8CIjjDnlAx35stWwv3nDv+3AJpuNSdwI4SNzhTAZJ
         aAAsnJm88F+1uihtrZeI+OxffG+HXtNFRC7jcMhRh//QDRPEVN36mdOQhwu8/bMn7gJo
         wLZrTcDm5waShTI+Dji7hHYR3kM7jbjOubCns8rY18MOxOYkJGfkNS5OkLtONCPuShVo
         QhfwWuacNWKBBexl+v2+0yliYsZbx8v+if2UPfNanHw/1g4Q4hrNYc2uFcPSLO5F8yMm
         8PtGnOoCDDG/i1RV7xAFFMEIKYF68pHJEfAKaT5fDJJYkH+qs+jKYvK67IHEKtNKl85f
         1gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747932835; x=1748537635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSfESP3eCTxh/lZuV155AcEe86QVGTg9cJglhVrSbYE=;
        b=JlHfZq9v4BXZeEYpdng21PEAjrrpW28WMdBClxpXdn/w5HqeqF/psodAIFZKSGZgVo
         DZZ/AwXr6ONDpAi+NqMx4MfnGobOGk48jtNFdnY7ic6kJFfgMWkD5r8+HuVf3l3mfJKO
         QtsMqmrO8vLTYldHw7Ns5n3qAEr1VE4KawRYoDsg6Js/2vbJWbG/v+s/PFKb1cdUvM4s
         9r1xbEtREznoGoF2+RwH5TrkUiHcmWLdUrCXDLmthC9YkoGUm29A7zfO86qOQ4jL9snU
         teQ6R61yVaUt5MG6SxcqFg9Fhuhdz9svtq8PcH2lk+OhJN0+CexbuA808WSXhPxSxCSy
         ftig==
X-Forwarded-Encrypted: i=1; AJvYcCW8nISM8D2A+jyruI/yGOtUMEvDbJYIlus6q+RWQIc2vUmLYFLhjscfUnZboR8KMY1/1LnyjfrBbzCu@vger.kernel.org, AJvYcCWYUN4sxESxIF44rKVXuMv8bHzKpRPfutgquDO1U72jdmn941Y/03s8JKTJZstDUaFCO8ihpLE6@vger.kernel.org, AJvYcCXlGkIoaf0uCMSf8FQfU3w2QVLb3BAmngsTipxnzCD6oeB/cfuM10ETUj0h/cG4QaJyxyKR3eRnu9O9jpgF@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaPS6tY5Y27RqGJuHo36yeggginKRwD+M8NdKiAzmASrAvEVy
	Qz8erB0UbeyjwG4kcqMbw53GxM2/9wau6TgpIh3MN2WT4fgXEqqHToqI
X-Gm-Gg: ASbGncvcWJ/Bjq6+72//DwnnxSXlXeR9Wja+pyS+y8SKnMJmJmjUlXxTLKCIC9UZfjk
	waLF7yl87pGbcNxOSTz2sUwkKTPPNN15yTiwysyPDoCkr9DQAhurafGJYrY/4x+L7xadvtamMH4
	xBvsfWXhfLzYHaJeTx64qQAO+iss+M5jHm/PIUfaCBWvA6znWH5LYiCtDqDdQKPITLAjay+R/ud
	Z6UHQwoXl5Rxrt/Xg5SWEgS7KLmpoygZk4OiQ+UAal1Lkyrw5UwipqP+PUCVxiaCT/YMvNe/lTM
	h27XHgFYbYEZU3NSfYbsRfSHDMMWzWl9QpWwR3rgJmEj6W5yE1SNJ2NunKokxfoh7FZU22iWtII
	p7+xnBLLD9BuOXG8s2CYZRBKTrRcnInc=
X-Google-Smtp-Source: AGHT+IEzv6dDW2P+AO+sDCJeKnMjKX39Z0fgtVNTUSFY3hWWH8aZvhhzfZqCq/1J9bR4RY3rI7hlEQ==
X-Received: by 2002:a05:600c:c1c8:20b0:43c:f3e4:d6f6 with SMTP id 5b1f17b1804b1-44302a1f0d5mr152421885e9.31.1747932835423;
        Thu, 22 May 2025 09:53:55 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-447f6b297easm118737525e9.6.2025.05.22.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 09:53:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 3/3] net: phy: mediatek: Add Airoha AN7583 PHY support
Date: Thu, 22 May 2025 18:53:11 +0200
Message-ID: <20250522165313.6411-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250522165313.6411-1-ansuelsmth@gmail.com>
References: <20250522165313.6411-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Airoha AN7583 PHY support based on Airoha AN7581 with the small
difference that BMCR_PDOWN is enabled by default and needs to be cleared
to make the internal PHY correctly work.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index a284e8435cb6..cd09fbf92ef2 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -17,6 +17,7 @@
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
 #define MTK_GPHY_ID_AN7581			0x03a294c1
+#define MTK_GPHY_ID_AN7583			0xc0ff0420
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
@@ -1463,6 +1464,12 @@ static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
 			      MTK_PHY_LED_ON_POLARITY, val);
 }
 
+static int an7583_phy_config_init(struct phy_device *phydev)
+{
+	/* BMCR_PDOWN is enabled by default */
+	return phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
+}
+
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
@@ -1509,6 +1516,18 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 		.led_polarity_set = an7581_phy_led_polarity_set,
 	},
+	{
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583),
+		.name		= "Airoha AN7583 PHY",
+		.config_init	= an7583_phy_config_init,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
 };
 
 module_phy_driver(mtk_socphy_driver);
@@ -1517,6 +1536,7 @@ static const struct mdio_device_id __maybe_unused mtk_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581) },
+	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583) },
 	{ }
 };
 
-- 
2.48.1


