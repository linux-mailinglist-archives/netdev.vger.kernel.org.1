Return-Path: <netdev+bounces-112278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D2937EE0
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 06:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74FCA1C212C8
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 04:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36498BE4E;
	Sat, 20 Jul 2024 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAnYkQ+A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D6C322E;
	Sat, 20 Jul 2024 04:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721448049; cv=none; b=Pi5h0AnnTmiQ6zMXuJLFgw2edZ/n7mdjCbRHBdef7M2WAP/yShtv/v1k1mcOZKT1tCiDucq0NS6Xnn/wR7yMt66LsYK+IkxpJ1wOuuWNBVcjnGvygNBa4oT7ceaG26HEMVj+jJupun42ILDBd5FSBZl47xuHwtugt8yQTb2MXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721448049; c=relaxed/simple;
	bh=prxQ+KpZSiOvQZb+H0+x7DBHDL1OLBALXRbUMNR+a5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4BNFKQw+rVpX2RRh3Qqt6vJ8bmk2UDdP/3etZb0eVPQMT76uQ4gVVs5L1xXF1LglcakUSwkRS72TteV26Xn+hyhzB1c8+oX9xq0FbCWsvbwzxHCDPxzg08nQ72KE2GxRaWsShjKlIje4WNbCblkgQT/cgJT5ICR1zPoDbNMA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAnYkQ+A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b07bdbfbcso1132429b3a.0;
        Fri, 19 Jul 2024 21:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721448047; x=1722052847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4LEaw+AqpH2JFLGxA4n+vH2QKdcct4eQZVeSkv6l4ts=;
        b=gAnYkQ+AaklJ2R2ot5+g9HWYDrr5A/LSQD2KAtybckKPpaSQEuqdJ9r5Mjh9sn2iap
         Ib1OyQ9Et4W4BHNMJIWJk16n7QrezJ+emAIj/vUzX7UWUPTZH94Mwfcwb08yGrTF/ndl
         ESyUFolYXBy8lJguNhQN4NybIXBOl4vKHzecI4x54U/rNcHcvUMuEjHuIDeMrm25z0sP
         j4aQUghPbW+5YiIyE0aVHjOaA3x+Gif7/fKEJHj+Y6mUvuEp3kiUeE+zgZWwuV5aGC32
         Ij4vhENMzX9QzwePSt0nocGkrgPZVGIIMgFUD3h02FAHvrZtIBuZAd+iJSIE5K2KSWzC
         VtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721448047; x=1722052847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LEaw+AqpH2JFLGxA4n+vH2QKdcct4eQZVeSkv6l4ts=;
        b=tl3ziDn0MX4jlBpMVNODrewKz4fSY/Ph96LppEJJAS8KFN1CzDaY4CXePDbvB2SCUn
         bRp+tCMATL94gmrrfwvzcMPRyt1HJlRSBQ+0PUYb0WjtHlSVH1+PImlDh1z05r52v07q
         Z778c04+T/UFLW5i6/1m32EROAmzsttCRNO+rHGT3nH4OVuEvxyjG/3JJa+hYuAWQpWV
         YauY7RDIPuS9aSWShM3MZ/R2ZzcoM7sMqKtVizeuGQgooYMnZYfcJVio0sCiCoIIlJ4z
         4jp/IgtCAeSdTT5lwbin6rE7BQWH2ayD3ttcb/LzY6q6oKyea+V+PnCiRSNLOh7jeivH
         eHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv7Rfq20Mem1g9APHCoO3byd3XUqZi34l7bOlj809wz26LY/bdr/lMvgAtRa1QlKfKCZEc7NqOmM1qMW+dHR49nAeGtiqqJDe7irUy/CQG4HQIbaMbVtLQfygxF39UDwQiLoAA
X-Gm-Message-State: AOJu0YwHgD8fsSEoRoXfxOJaoHmEwOgeUyqeXlS9YTKEZ9aj6entsfv+
	5bHhMexijkChg3yzfTDewUdWpD4Tv19hZTL2zRLBvzqdR0z4ByYb
X-Google-Smtp-Source: AGHT+IGjA01k09HWKzmc4ybFCGHr482A/uCJKVK6xKRbZl0Y+RhKZRBXXVtMBlWarDEr2prSOEdXGQ==
X-Received: by 2002:a05:6a21:320b:b0:1c2:8a69:338f with SMTP id adf61e73a8af0-1c423ac8ca6mr2497856637.12.1721448046768;
        Fri, 19 Jul 2024 21:00:46 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff55275bsm1901517b3a.128.2024.07.19.21.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 21:00:46 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	mcoquelin.stm32@gmail.com,
	andrew@lunn.ch,
	linus.walleij@linaro.org,
	martin.blumenstingl@googlemail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "zhili.liu" <zhili.liu@ucas.com.cn>,
	Zhouyi Zhou <zhouzhouyi@gmail.com>,
	wangzhiqiang <zhiqiangwang@ucas.com.cn>
Subject: [PATCH] net: stmmac: fix the mistake of the device tree property string of reset gpio in stmmac_mdio_reset
Date: Sat, 20 Jul 2024 04:00:27 +0000
Message-Id: <20240720040027.734420-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "zhili.liu" <zhili.liu@ucas.com.cn>

According to Documentation/devicetree/bindings/net/snps,dwmac.yaml,
the device tree property of PHY Reset GPIO should be "snps,reset-gpio".

Use string "snps,reset-gpio" instead of "snps,reset" in stmmac_mdio_reset
when invoking devm_gpiod_get_optional.

Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: wangzhiqiang <zhiqiangwang@ucas.com.cn>
Signed-off-by: zhili.liu <zhili.liu@ucas.com.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 03f90676b3ad..b052222458b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -462,7 +462,7 @@ int stmmac_mdio_reset(struct mii_bus *bus)
 		u32 delays[3] = { 0, 0, 0 };
 
 		reset_gpio = devm_gpiod_get_optional(priv->device,
-						     "snps,reset",
+						     "snps,reset-gpio",
 						     GPIOD_OUT_LOW);
 		if (IS_ERR(reset_gpio))
 			return PTR_ERR(reset_gpio);
-- 
2.25.1


