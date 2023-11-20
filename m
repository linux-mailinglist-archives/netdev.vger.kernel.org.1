Return-Path: <netdev+bounces-49094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6257F0C59
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CCAB20DE7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A8D6FBE;
	Mon, 20 Nov 2023 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IJUoDyJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E891BC3
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so1316129f8f.0
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463698; x=1701068498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xto7Tip37Lek2ctdnc2c4IRoe9DKBWBBqaIXeBh3mY=;
        b=IJUoDyJKCCUTyd/AFKqtJAvRunOCz8lfd8VY/wZ7cxJwJdKJ09IUCtR4OzPHlIy0+H
         xuE8YBWoF4Zg6AiLTtbHiOv3/gwnEr3PWrob2SKnmdI3W4AtcXtOXMvOIlqHF6o2RZ1V
         Xf957maqds0ugaUR8JfF6KlAJLbQgDvxfqjknOUjKB31WVsYVmk0LYGHKnyzCDCHH5vs
         I6i3365ktiPG6UqqJ4QYh4sJeLujhZ8lLMVB3s1kaBFQoCwAC2vjMgnHqgn4TKse3S0E
         JM1wQwhaBQsW5bCaLuBATfFiw4mbfSxmaZNKPoMpS+lGxrdj745z/xACrjkpDhFirxcI
         /fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463698; x=1701068498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xto7Tip37Lek2ctdnc2c4IRoe9DKBWBBqaIXeBh3mY=;
        b=wSkg+96tnu0+IFJq360c3r1ut42llonVnR6hJt/DGGhm+UglkR6y+pLzINoVfAmIMe
         zJQN4jUJviy1Nwg2Md4aPG6S0pjgzJeIUdoXTz5dAXWphcz9XGT7qvFUKmVhHHeCgb6B
         barYT9zz1/tqB8pc9sofQ7N9DrPWg4PtUixR4ChZ9XdB+W4N5vCCwsRzQ0pG0kXqu92A
         xqKIVz/22QVizyfRX2k7KGrbdQrirheGKjyXfz89TontXF6zAI65Frk7h2r0JJbmrqsb
         Y5e5HED/mDFQRYFqANS0N40CAgb/LbnDihLngymRpzxH3JF7OnXoJ303stfUI+6xSBJE
         j+WA==
X-Gm-Message-State: AOJu0YxGmbXNu2K0v0n6SSgJQg7XZ4cnLs0niMIByltg5x2DWrKNjFpN
	ve5eIFIt7n0i+toXUYp6cpTXhA==
X-Google-Smtp-Source: AGHT+IEWKdn5r09/jusmgZ9D8PWRxsHArFwXtSh431y50HVwMIJ/hTh4CWx6rPth4Rz4ja4grM516w==
X-Received: by 2002:a05:6000:381:b0:332:c65a:8f57 with SMTP id u1-20020a056000038100b00332c65a8f57mr1772724wrf.6.1700463697863;
        Sun, 19 Nov 2023 23:01:37 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:01:37 -0800 (PST)
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
Subject: [PATCH 12/14] arm64: dts: renesas: Improve documentation for SW_SD0_DEV_SEL
Date: Mon, 20 Nov 2023 09:00:22 +0200
Message-Id: <20231120070024.4079344-13-claudiu.beznea.uj@bp.renesas.com>
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

Add switch OFF/OFF description to values of SW_SD0_DEV_SEL for
better understanding.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 275b14acd2ee..e090a4837468 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -11,8 +11,8 @@
 /*
  * Signals of SW_CONFIG switches:
  * @SW_SD0_DEV_SEL:
- *	0 - SD0 is connected to eMMC
- *	1 - SD0 is connected to uSD0 card
+ *	0 - (switch OFF) SD0 is connected to eMMC
+ *	1 - (switch ON)  SD0 is connected to uSD0 card
  * @SW_SD2_EN:
  *	0 - (switch OFF) SD2 is connected to SoC
  *	1 - (switch ON)  SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
-- 
2.39.2


