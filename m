Return-Path: <netdev+bounces-237350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34323C495DB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 22:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E54E73A223C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 21:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C062DECAA;
	Mon, 10 Nov 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMUPst/H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE192F49E9
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762809087; cv=none; b=YMi9NTFZIRbVAJHLyJ3EedZ5MTSseF1Rt5F706SQIP1fsSQuSQJ1pyIyXYXS/6+2OfGUIAs2bIXPxIL4j5C9jTJb5zMQ0/6/giSVSfxz1rsWudJ5XsRpesAElKO1rde5Dc2/mGfpEr0AYJYYWYpth0R6W1EiS+gfanUX0Z7ySDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762809087; c=relaxed/simple;
	bh=LrkURI0gSm8PlqcAUJbCABNYiL2cCdnxh5meaQNYxoI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=uoR9aCzbMHtLCvcawh3Q6CNpTDcK91RRHRgTB+3S/ntSPxcJMLsYWW9riMqlq5760v/0HELBpQYaDpp/kUTLnV8T/JrUFd2MJlNXFxbxNqKN9yZdOFsITop4CDCy85E0nDedNvVGCtejQSc5vfGOe+jWf518MW7gSdg6TWDFg1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMUPst/H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso863070f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762809084; x=1763413884; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At+ab1WSgPuU0PAsbZBhlG6un2tXeW7kWEEZOPeASes=;
        b=nMUPst/HWpkivdwvP511vrGN2e4R1xNullgkwevG5lnsRrJ0juAgAy2Vzp/Ot6UeGj
         6goRmUitkrAVG2BgYbabsS5i50MFFI658ThuZA99GQBqoJOO80jdS6jQ+h9DokLdI/+B
         xj8X2OVjH9MNX0RYbNyV7HKeFjP8/IgGLToC0klwl3oxulvpLS+R0JtyqfZ6Oidm0j1c
         08Aok1MISiBKR0kEQi+9kuN9Lq8+Sdxu/J9iZhzh/QUnt+seQH15I5RGTe0NpAVS6eFC
         FkPiyI/8OPt9dM4YHQSEK5ZZi0rWCajpvlp1Vqur6FJXQ5w0PVAhAPMgXCFV9outrnmX
         mBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762809084; x=1763413884;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=At+ab1WSgPuU0PAsbZBhlG6un2tXeW7kWEEZOPeASes=;
        b=WvbJz6Pmua6Bla4i7Rf4kI79SIEzjLST18Miwfp7IAUisL/F/dyuPs/Mf6QMKotom5
         VFuhPIZ5BcJ8+iZAvoG5V/7TXFHFS9sS87wqDVV5SnxdeoUQyVL0K8rZmBkTsB6DgzwS
         E3L+V72RigYeN0qn8C5YjFw7hzxsIexnpjkFnNu5/z4i3jiTxu6N6dpgEJlW/5Nf8ArQ
         XEmXy585ROhIHFEZWw/tUUvJbhlNqW5vboUfpXaokd/wcCWGzNA8vWtIrv6zE4QDCGzJ
         1V5lD5ufZFZUQQS2DKDtzqJqzJr5XpB5fx5SInyi+uM6JNCQ6jkrdYoo429gjhBnVQzF
         be6A==
X-Gm-Message-State: AOJu0YxK9ynWrb8ATG5JgS4/HfEgC+D1T43vENu1Eow8srBKXbHbmP3t
	zJFSThkQ6bM5AvWZrDZfemvYkZJ+RU+/QuHGqv2IiA/qXKkIb1RS6zh3
X-Gm-Gg: ASbGncu5joCpqR0t3xnWPAQi/aSq/H3ivlc+C0tTdfinVRol4fw7+5lmO3+O+69Kjbl
	ucM9w8smKTNtV3nSD1u45EwW1WOOEY5/99XQTNGea1lGwVvVyS6rbwQ5Jo7UKE3YwYQG/dvJfJa
	h+zbOQvCa+9k9BKs6FkBdGZgFtDEFYe1sbYntd9mwG6Lkw5W/hKpj8IN3ujzHlIdfgSUOPPKXuH
	6jgnd9JKBBtSAiTFBTj7jrWOgeTAbqG1L897JDIEQ9GKU1J5Sao5k+FzQqRFL8AUc+Dth4dut0l
	Gpwft2R3A9ycseTpIX+74IxNa2YKEddb2t7VZ8cytG+nZGEVZA5hGK1Nzt5XQnkaws8YY1iWic8
	TfEMhTU1BNqvUvf8xc6ryFqJZ5lbUQvQXFt4MUmB0bsdPosJ/2+jykRoPtL87djZVSRPZHYIoK4
	C2lziN09Ibr6FYkKmFnk4y+oe+2Y4LTkNAK+GKBJ4KP+VZipZYIjvU+qN3W8JV/ca6jeacV1SRq
	TPhhplJCSeABwRZJDYH+3ySFW3ZtF41jA714s0AZ8M=
X-Google-Smtp-Source: AGHT+IEyX3U+imKS93B/quTA03oSKtyWl+Yv9tcIywlwPSfp2YRZaOiQsoisUNHoJ6el0t+848DDeA==
X-Received: by 2002:a05:6000:40cd:b0:3eb:d906:e553 with SMTP id ffacd0b85a97d-42b2dcc0ab2mr7232766f8f.55.1762809083903;
        Mon, 10 Nov 2025 13:11:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f33:1e00:300e:33dd:b203:22f9? (p200300ea8f331e00300e33ddb20322f9.dip0.t-ipconnect.de. [2003:ea:8f33:1e00:300e:33dd:b203:22f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b326a950bsm13365782f8f.8.2025.11.10.13.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:11:23 -0800 (PST)
Message-ID: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
Date: Mon, 10 Nov 2025 22:11:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: use genphy_read_abilities to
 simplify the code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Populating phy->supported can be achieved easier by using
genphy_read_abilities().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 2e46b7aa6..32a9b99af 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -18,7 +18,6 @@
 #include <linux/of.h>
 #include <linux/idr.h>
 #include <linux/netdevice.h>
-#include <linux/linkmode.h>
 
 #include "swphy.h"
 
@@ -157,27 +156,7 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
 	phy->mdio.dev.of_node = np;
 	phy->is_pseudo_fixed_link = true;
 
-	switch (status->speed) {
-	case SPEED_1000:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
-				 phy->supported);
-		fallthrough;
-	case SPEED_100:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
-				 phy->supported);
-		fallthrough;
-	case SPEED_10:
-	default:
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
-				 phy->supported);
-		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
-				 phy->supported);
-	}
-
+	genphy_read_abilities(phy);
 	phy_advertise_supported(phy);
 
 	ret = phy_device_register(phy);
-- 
2.51.2


