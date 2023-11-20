Return-Path: <netdev+bounces-49096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B0D7F0C62
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062531C21005
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B916FC5;
	Mon, 20 Nov 2023 07:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="lPhjqlFP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608F51BD8
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:45 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-331733acbacso1456748f8f.1
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463703; x=1701068503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uj4K1pfoFmhhsoRQVm6vixpVPFIpo1qe9oMsVe2v1kc=;
        b=lPhjqlFP2QiKu60ymedE1u3UuvkYV209Ysj1Lp2GqEUEcTm+8s0C+DufIvh/X8T8KA
         rCu/5ZVt0axOenEG93fsCsUiOVn8hxAu1wxSkNdoq8xbGOiTN8zf3BabR3L6gdjCdsRp
         sm8Q57mYhssWG4s0CU/J7NZs0om3mCRkWRru4DMJTaEZHO9pTiHsGKBXPAPMQ8tt/952
         4LZ9RPwF+zIxT4e4jc8dchqiGCi+cPRwui3RAIXACwdf76qipoyXtYtArQ6ZSbrJlU9p
         9PoMbJR7wKSbwLuKb85Qg0gFrtt6PZRqjepFkmM8eRrBtr25VUmpoa09GFIt2Ve77kxa
         cSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463703; x=1701068503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uj4K1pfoFmhhsoRQVm6vixpVPFIpo1qe9oMsVe2v1kc=;
        b=UOFZZU7XdwaK7pDg/6N0F0Q6MhoIbP8ud6wmwZdmn1BetslA/BvgwRqd/BKW29N1aA
         spNLazG+jAOjCSRjOZMRRrJ7REI/ATDK4AgU9DOo/y2Iy8TQmr/06UHIn8AQbaN2O8sK
         5SuptFbiRdIZY77tzQ6pA+ZkI2rgMHxyEOAhw/I9RY/VOUdIsN7NHcVFA+W3MCuUxse4
         HwofV/KpvuZDjeYI7KtPaZe9Rqua/2Y617yg9fl7JcMZaaeTe+cqEE3Rg65mMEMZiOgb
         y2sEWEJlG85QIVWtyQZ4NKhXCPZCOkbImLtSS0B9C2r0KK3wf1DWwOlUHmQ1WUGdIy4o
         rSSQ==
X-Gm-Message-State: AOJu0YymMHes1oDNt/kopCO8neNCT6X1A+pOxQlctWRayp+w9Mqbb2MX
	ylFEtIoQABWSloOa8U8BXNPSwQ==
X-Google-Smtp-Source: AGHT+IFbHUCjfCJLgApfU02GbEBAEEDTn2cUfzkYAcqxgH3UIdeUTzC7eHrWRIOHe/xLOqhqenD/bA==
X-Received: by 2002:adf:fd4a:0:b0:32f:7cea:2ea2 with SMTP id h10-20020adffd4a000000b0032f7cea2ea2mr4049149wrs.17.1700463703709;
        Sun, 19 Nov 2023 23:01:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:01:43 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux@armlinux.org.uk,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	linus.walleij@linaro.org,
	p.zabel@pengutronix.de,
	arnd@arndb.de,
	m.szyprowski@samsung.com,
	alexandre.torgue@foss.st.com,
	afd@ti.com,
	broonie@kernel.org,
	alexander.stein@ew.tq-group.com,
	eugen.hristev@collabora.com,
	sergei.shtylyov@gmail.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 14/14] arm: multi_v7_defconfig: Enable CONFIG_RAVB
Date: Mon, 20 Nov 2023 09:00:24 +0200
Message-Id: <20231120070024.4079344-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120070024.4079344-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

ravb driver is used by RZ/G1H. Enable it in multi_v7_defconfig.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 10fd74bf85f9..9a04564566a7 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -272,6 +272,7 @@ CONFIG_KS8851=y
 CONFIG_LAN966X_SWITCH=m
 CONFIG_R8169=y
 CONFIG_SH_ETH=y
+CONFIG_RAVB=y
 CONFIG_SMSC911X=y
 CONFIG_SNI_AVE=y
 CONFIG_STMMAC_ETH=y
-- 
2.39.2


