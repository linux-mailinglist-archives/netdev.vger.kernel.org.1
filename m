Return-Path: <netdev+bounces-153760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D679C9F9A33
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71D3E188F7F5
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16E122578C;
	Fri, 20 Dec 2024 19:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSKR/Sss"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82882223E9D
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722238; cv=none; b=oYnihTfRzmmhtLol1KEe5jBbyskQQtZbOggv15Xd1AaE3FVgcdXhFbqveY44FlV9cIk6Ft0sg4laRMwF7w8+qEN8SWpLlU77r/WN54dC+MZfucf6sSzXArmx9lQouIlwG1aOMiiP//jZotUMRpg4UWYTWWLl/DyzseCQ/hiUOF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722238; c=relaxed/simple;
	bh=mROo70r3g2S/tXwv5rKi02O+xk2NlNXfmA0D0Dp8cVQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dprlvecNvGZHGzl+v4NTHSKmNqlzfEseOosjnJzevmoBACNGnsMdS0E6FEgo7FUkdCehIVPItQRE/chhFQtZIiZSTwV1MYALVdRfiOEh6zochp83pElyzb+wt51DYhsUcxP8H2rYJ4e8/j9cLEl1O5Lfgg0hPI0dm5Uk95oGzQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CSKR/Sss; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso4358626a12.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 11:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734722235; x=1735327035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvrKNpEqve5cJuqmaGHqssmvLsFFOo7PR9+wMUJrj6s=;
        b=CSKR/Sssb4rUA80mlff9IG8RRu1S4iRqp3tH/XzbaVWluajMWd3H6nvsySYVU45Y5j
         bwquEGlWgnUuCGSQ2XATtquLdaBQUqINp7Ikfr9RVKquRmNjeJShQBwKoJ8pF5Z9AFG+
         00gHOGsHcHH61oye0FxOZzeDCQHzsxlIP1FTggwXlW1lkku4zLkmPiFLVCUgFeR2H7vf
         P8fOXMRbxUxKyAz9lY476zQYqqmScewHnKJIBWP8T6HPIAP1a+kedFJOASH0SanOfDW4
         ax6Secxsmk7GO9ivcxbH8fSsNPOvC/nO4yoiJRZfJuA4NBy9iVcfGn6FJynxIMmj1Vfh
         PGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722235; x=1735327035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvrKNpEqve5cJuqmaGHqssmvLsFFOo7PR9+wMUJrj6s=;
        b=OcVUhCXxl+BsByrZmmPUocr8lIgkJZSad/lrpG7tLkZYcqsvnIKSgkUvGwO0DFAqAm
         Kn/08LYjlr9qRBTKE7kETcFyQvaVke6/OfiJOpSOnkPSZ7iEDCV20myY55L/4BLfEtC0
         RXLhe5v1C1nBtsLDgEKhagFWwrLdYYa7+cLzReYStzXWmB1QecYsOvDcVY1eaJuKHo2Y
         RIWEa7vCxdeEtqx1pg3CGh+P5R35gP5us4VEoR/9J17IJEfX9NOQOmbibowpTWqsGUvp
         mkCIrZzdKb9N/ubuPl0XTzOjgGRa7v/+x2igxzSsOw8ef83orWtteuWzUpdaAqhu5zfC
         Rt8Q==
X-Gm-Message-State: AOJu0YzTKL3daD6w4CYH+LUsNMGr2VxhM8IDzcxRtPzLImBfbmlbYjDm
	3xmdO281Mmd/WQFu/zh1soNLvKWG7VtxukAJPqqzswHb02INIJXMujbX27MAOKY=
X-Gm-Gg: ASbGnctY4dzbohiReJjLzKVL4Ucdv3gVq2cUnXKrI496eot5iJGNNWcu3sCtx2zqA0n
	1MoVgAbbFfDYw7gue1xw1RjLncafx7vLLuH8y0zOStnewPZhMJop3o84k24Vb1HzHLSlz7XBpNN
	7WHG5yKw8s/o3e08aR0lO4+6DF2CBhcqlxx6ZeB8OG1/FRgwOZQrfQ55kxkDpVe4PMrW3oBJwXL
	PtE2vwCWO9HoV3HCYCeLs6XXW1J28ZQWjIiRHDNSOqeNxUrgLS7iZqoR1X5a5hVPkQ=
X-Google-Smtp-Source: AGHT+IGnn+xqSTGSvP8yxaXAB68F1Ssb80mPVA95NHef0ZS07c0bnjhJDyoAPHazdWv8mbbYKzd0xA==
X-Received: by 2002:a05:6402:540b:b0:5d0:d610:caa2 with SMTP id 4fb4d7f45d1cf-5d81de1ed59mr3500781a12.26.1734722234872;
        Fri, 20 Dec 2024 11:17:14 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f11dsm1988727a12.46.2024.12.20.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:17:13 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] net: of: Support minor nvmem MAC offset
Date: Fri, 20 Dec 2024 20:17:05 +0100
Message-Id: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHCZWcC/x2MQQqAIBAAvxJ7biEXieor0UFrrT1ooRGB+Pek4
 wzMZEgchRNMTYbIjyQ5QwXVNrAeJuyMslUG6kgrUiMGvtGbFcPj2ePpXKqCyPakBqNt56CmV2Q
 n77+dl1I+STsnpGYAAAA=
X-Change-ID: 20241219-net-mac-nvmem-offset-22b6218a4b0f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

In practice (as found in the OpenWrt project) many devices
with multiple ethernet interfaces just store a base MAC
address in NVMEM and increase the lowermost byte with one for
each interface, so as to occupy less NVMEM.

Here is an example patch from the Linksys WRT300N router that
was used before we had device tree:

f = ioremap(IXP4XX_EXP_BUS_BASE(0), 0x60000);
if (f) {
    for (i = 0; i < 6; i++) {
        wrt300nv2_plat_eth[0].hwaddr[i] = readb(f + 0x5FFA0 + i);
        if (i == 5)
            offset = 1;
        wrt300nv2_plat_eth[1].hwaddr[i] =
	    (wrt300nv2_plat_eth[0].hwaddr[i] + offset);
    }
}
iounmap(f);

In order to support this scheme directly from device tree
we need some way to encode the same into device tree, this
patchset provides that.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (2):
      dt-bindings: net: ethernet-controller: Add mac offset option
      net: of: Support adding offset to nvmem MAC addresses

 .../devicetree/bindings/net/ethernet-controller.yaml         | 12 ++++++++++++
 net/core/of_net.c                                            | 10 ++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241219-net-mac-nvmem-offset-22b6218a4b0f

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


