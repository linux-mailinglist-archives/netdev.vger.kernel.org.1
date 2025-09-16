Return-Path: <netdev+bounces-223662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBCFB59D7D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7409A3A47F6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 16:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260E1F584C;
	Tue, 16 Sep 2025 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg/NP985"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122B234973
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758039822; cv=none; b=uZIlzBhDrXgNd82MWaQyT/Fxe275Z2GxhT+z1kIM1XW+sWblRKGG8FQPHUPms5IldVLn5EkByUF1l90K6cGXDG7SqxeAS0kllKsk+ELopaVCmC7THeVtkBNn4L1KeEZuDRmJZLysemSTIm7yF0pGaM6FsWLUJQNjmvNboMKZJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758039822; c=relaxed/simple;
	bh=LrD6BrLgpUvSdcLR7Skt26zZgEQ2s0Ux2XOn4YPB7Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t5f+kvZfClGmLL1EixZS8P2PjzMWwAwCfqWZzCjKs/GMdweIkbVHIlVg929+R9ipWCgtOCWsD/RWam7YBVV1LFn8cirFGxYB64J+GMqXDZJ3V/nSUj9RcXAi+cV4mU7E8h54n525C3WNuNx7QGILC/ThJlKBBaih2i1qQ3+y3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rg/NP985; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so328425e9.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758039819; x=1758644619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K/7fckWG4F5rhCUIhkg35WDPQwJJKTQY1bkq1rzEfW4=;
        b=Rg/NP985qniJZy3QUCuAo6thS9AAPa08TGk6Vbr024serU+stSllIgdaQcy/BK55fF
         knf56vz1cWIOssfKS2VZEc1R6c1durXcX1dcUz/b0+wLlXZRt6Cb+AIM67bUzWL5k+ok
         TCaKX4JtfYOoz69vc5UqOR4Yo+sSRPIWK2C8yXuv3t02yTud/EfYu0sRudaNaXgT9Gvc
         mOs7ot7NrTnR9/hPq3t/nyT4sWjGmcw2ua7ILhqLoyPK1WSHLIY1by95n7fsrn36kKNv
         486/YNUTXVPM3SQgDi0nQWbwPduSOX1ejvSDbrFXms9jRfifr156AdKsDzXZLij2JOuO
         +RAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758039819; x=1758644619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/7fckWG4F5rhCUIhkg35WDPQwJJKTQY1bkq1rzEfW4=;
        b=aWmq4d2CP81MjjQW+EYsdaOCxzCKSHPDGPI+qHhzNPC2oEGAPZljv619X5TQURC10i
         6ROrTtS1yaQclEtP5F+vfbcePYGIGYBhfKebYRoLTEHAm44UaTSqngWs50xglDJGwxI5
         W2Rp5NcLatYjeKZX5fgfxjYeqAvxHx8JjSTETapSzCrTBEsS8grS7gGcCLSQbZWzZhyp
         aYW5P/56uLvPGKJeCJX3NZ1isnrHHmuiYvyG1I7vF+HIHutJ8/GBSS4LVhFAQ/fFqnbj
         HNOl7dkMVXNPmI5zBgFuTq/067XbAS8vX3mzVSllCn/xDFboUL2b1gU8eno5ceGbBtA2
         tCBw==
X-Forwarded-Encrypted: i=1; AJvYcCW9IH/gJ8Xroq3QyYuMRN9ZFZiWqqpRcHSLayvJTMon4Hj+RYnCuDt4my0jA3E8MqQr+OshBCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWD62MoYU9LGjWE8wgeAa8m/wpbL2mmHhsO+jRsnchJjWnjTI
	hwRc2Lqba8PSa4CcH0CvVtUJHc3C+XjI2p1/6vl/cNNJIH7vYdi91C5atz0aNA==
X-Gm-Gg: ASbGncuES5aMFnwbRuYw2cKiqLVZGZmMmb8Z9Jn5cRK3cLLr4NoNo9gDa4tz5wwjdZn
	/hOo9so197hAZmF4X1oVG+eBdYvArAU0QQ7CeVxNfox4ZPPg78qAm8GuQjVhVKrJgC49MOKRg2j
	js+IwuZ5iWvZyBYFt3CnQkPfHpqbZG7Zw0YuwBA5drgEWuMsCMrJt7RTFgB14U8xErVYQmsoAbs
	cjB0QzDM6npGxjd5vThZ+lX8JTXiNyhxtWxpXFOxCeAUYfM5Cp4sLu+wq1tLCQtHILuP6HvBM/g
	88t0Nev3Zc8KF53WIRPHByb4Kwu5yCYqm9qkW1IdTdXMeOvrPXC88VNiSW2jq9iXMNMuPr41pva
	Ih1IXSf3lG0Udua5JI0/V0w364D2naMtX+qW4NBWyd8Mpcls=
X-Google-Smtp-Source: AGHT+IHHuSYAzUDnzV8A0W3K4WH+E5KPEEi2k/OrYuXUvaclai/18lUV90Qfo4UZxkj86ARB8Jf7Jg==
X-Received: by 2002:a05:600c:3505:b0:45f:2d7b:7953 with SMTP id 5b1f17b1804b1-45f32d512b8mr29544545e9.18.1758039818697;
        Tue, 16 Sep 2025 09:23:38 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:ddad:97b9:9e9b:bb33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32083729sm21385035e9.0.2025.09.16.09.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:23:38 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: [PATCH net-next] net: pcs: Kconfig: Fix unmet dependency warning
Date: Tue, 16 Sep 2025 17:23:35 +0100
Message-ID: <20250916162335.3339558-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix the Kconfig dependencies for PCS_RZN1_MIIC to avoid the unmet direct
dependency warning when enabling DWMAC_RENESAS_GBETH. The PCS driver is
used on multiple Renesas SoCs including RZ/N1, RZ/N2H and RZ/T2H, but the
existing condition only allowed ARCH_RZN1, ARCH_R9A09G077, or
ARCH_R9A09G087. This conflicted with the GBETH/GMAC driver which selects
PCS_RZN1_MIIC under ARCH_RENESAS.

Update the dependency to ARCH_RENESAS || COMPILE_TEST so that the PCS
driver is available on all Renesas platforms.

Fixes: 08f89e42121d ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/all/aMlgg_QpJOEDGcEA@monster/
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/pcs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/Kconfig b/drivers/net/pcs/Kconfig
index 76dbc11d9575..ecbc3530e780 100644
--- a/drivers/net/pcs/Kconfig
+++ b/drivers/net/pcs/Kconfig
@@ -28,7 +28,7 @@ config PCS_MTK_LYNXI
 config PCS_RZN1_MIIC
 	tristate "Renesas RZ/N1, RZ/N2H, RZ/T2H MII converter"
 	depends on OF
-	depends on ARCH_RZN1 || ARCH_R9A09G077 || ARCH_R9A09G087 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  This module provides a driver for the MII converter available on
 	  Renesas RZ/N1, RZ/N2H, and RZ/T2H SoCs. This PCS converts MII to
-- 
2.51.0


