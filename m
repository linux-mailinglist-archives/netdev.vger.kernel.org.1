Return-Path: <netdev+bounces-182687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F4033A89B44
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BD983AF215
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BF28BA89;
	Tue, 15 Apr 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqFM81Uj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B112628DEE2;
	Tue, 15 Apr 2025 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744714429; cv=none; b=XLjSeZOER+wipjIZjhbaQhyklF6seIOTG3gI0999oLjW0DmKVnLb2blxZ4XUYV6+fPUweZVDd2/+oEqkQiJBzvleAVjNpcxbh2x9Qi+hOEmOUf1iN18drI3uIU5hIajbkmqEhLvdhMMWvw9Ktkw5U7pP4Cx4+U8G+dftqQS231Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744714429; c=relaxed/simple;
	bh=Hhwkz6LjE1771bqwO/c86QlXNkO/BLXIsbXHA9JkXJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOgI3KlyCpgdD6MVgzefX4I6O7pCaSoJPOFrlouBgypBwjMXxxKgN8yTQ23mxIDzv3ipnQtVCprPmgSRd5PwRVzrI6LNwaDPc45TuhYrm5y1UP+yADakN/Ll+4dNxDGNxwZKyXYkWFuv89ws10ZLtIdd5XdDYhWy823a/yXXNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqFM81Uj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c1ee0fd43so5205707f8f.0;
        Tue, 15 Apr 2025 03:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744714426; x=1745319226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ/sNjG6+jopWKiMcxNEdpFMYBYSU6NzwaXfhYsGhCM=;
        b=HqFM81UjL3z07XUWYR3tRbS8rweCX51y6LO9ebHT4BnjZZWLpOMMVHpSNiF+3FVJ1s
         syTyz2uqTX5w11+p5weC/2tJao+8139U7/RIPosUIxwCvu5Rib1Fgh8zuMDvHiMPmhwa
         Z2XeA2FOEgASN5nWfxgFRXQ+M66GzgK+KxPp7qCIcyeFPi5ehkwnpNoxuGnX1Nxzww+L
         FObecvqHV1ZJqf87G5RnMUol0smsny/CVceklmifulpbOcDGRnzwqg/lEvBjVheNhkJ8
         cR5376kdSWvNISrZVSxYOEmVSTTI4G9dZou3kzrevr9Pql+DaDzkA5jbnNmIgwgYAYVj
         Sj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744714426; x=1745319226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ/sNjG6+jopWKiMcxNEdpFMYBYSU6NzwaXfhYsGhCM=;
        b=sBMDX3TzHJNuKPzPGSBv8820EGooreMzfBat+lYvJhizs/9RvodJhv6oH0+1r6GL0H
         ZBheFjf7b6A6nc1kvgckPpntqFY71Y+ZmQlqKovVeniMqzCYjTijSkVODxaH4gTC+CBL
         5yuBn9sGLV5IIr2KYv1Tk8g6omJovlgybll+8yPYnCaw2d/LPrEN6Va2nKItbwFcm+di
         EPEcOYm6GPm+5RnFGmPSmdFYXQ4L3xDQ/7RgtyLDUT31UZSsY+9XcxjgSvcDCRONFIUk
         fFRBnyZupjzO63ChfARhMAmJczEjHZrx6jKyJOSrDAjsvJb3HPIZ/tP0iqu+clbaq7G5
         R/sw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FH9HhLxZDeog8+m/txD0mwxTobRi8ZIfLkgDE0dRK9Y//U8qpWCTZ7Lqkxb2L1g0Zznfc8Cm@vger.kernel.org, AJvYcCWrvEaD69ZRTxcoRKHZM4wKx/DMuU/zoTMFpx/lXigJgYMbR+vdtg52GxsIxSA0vYFSvisGt46n0wpNKyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyeoUV9IbiZobdFZybIywg68Q+MrLiVkgsJG24B4XnR02vKJ5e
	y+VFw6T5qiGME8PNHlFQLEOMxrybBeHL1YbAaHlrhxq0U7F/OI7W
X-Gm-Gg: ASbGncszvLbyhEh/ke/wOAxQB60eRkIB0et+mtmE9g8O0tYIIiWG1RtfQnJusuj0lDU
	7oPJu98P24wpUoWAXbh1gBPWqqZEAz9RIVTNOUJFSwB2PWWovYXHo91VM/zzHM55Gp+pF7R+0qJ
	W0o2QaDzywBO3HP9V2HsL6OhkDdrWX7uUofUCeBZIiLnbx+TDnoksBi3LH6ZIxtRP9MWthw/fk2
	bzPaEl2PeB0eRe4FqF8yAOLeHcj1WTXALX1/I6jYii0GbjtzS6Pkcv5dMxo3F5DrzjwJPaDH6qf
	E89pvQ0aMW55XM+RCj6ByUJLn09EWXPfKArMcpimxpFh0S92QLDge0f8Uq9WirDIBS0YYpNECBo
	epfuQY0iwpwkN2Vdsc/6MOC5RdQ==
X-Google-Smtp-Source: AGHT+IHAKzbyn3QbO27Y4E/NIYe0sT0rh6l92PwWJFTu6yx26yYGsnbr5xQHCgxMSU5AqBF3VEZhFw==
X-Received: by 2002:a05:6000:2504:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-39eaaec7564mr12366347f8f.37.1744714425663;
        Tue, 15 Apr 2025 03:53:45 -0700 (PDT)
Received: from localhost.localdomain (host-95-249-95-100.retail.telecomitalia.it. [95.249.95.100])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39eae963c15sm14199021f8f.13.2025.04.15.03.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 03:53:45 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Simon Horman <horms@kernel.org>
Subject: [net-next PATCH] net: phy: mediatek: init val in .phy_led_polarity_set for AN7581
Date: Tue, 15 Apr 2025 12:53:05 +0200
Message-ID: <20250415105313.3409-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix smatch warning for uninitialised val in .phy_led_polarity_set for
AN7581 driver.

Correctly init to 0 to set polarity high by default.

Reported-by: Simon Horman <horms@kernel.org>
Fixes: 6a325aed130b ("net: phy: mediatek: add Airoha PHY ID to SoC driver")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index fd0e447ffce7..cd09684780a4 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1432,8 +1432,8 @@ static int an7581_phy_probe(struct phy_device *phydev)
 static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
 				       unsigned long modes)
 {
+	u16 val = 0;
 	u32 mode;
-	u16 val;
 
 	if (index >= MTK_PHY_MAX_LEDS)
 		return -EINVAL;
@@ -1444,7 +1444,6 @@ static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
 			val = MTK_PHY_LED_ON_POLARITY;
 			break;
 		case PHY_LED_ACTIVE_HIGH:
-			val = 0;
 			break;
 		default:
 			return -EINVAL;
-- 
2.48.1


