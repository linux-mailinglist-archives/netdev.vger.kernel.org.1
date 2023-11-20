Return-Path: <netdev+bounces-49084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B15B57F0C1F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29111C2090A
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C8A5668;
	Mon, 20 Nov 2023 07:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jteQd3gI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AB1AA
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:03 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32d81864e3fso2513416f8f.2
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463662; x=1701068462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfOiAJGxKuFWs2NWOIwVX0esmzm7aks9t4Cs2rPO3Ns=;
        b=jteQd3gIxDYoQ0MmForZh67/JEJCMfow7L1/mxJxllxJoRp1ZR/Fd4W5obZk1ui/vn
         2272gIvWQ6LSGo4O0GdOn1UkM9QRFBmT/1enokRu/nrywQk4dlU7Q24jfb1lQiJLuRKH
         25X6CS+B/FSLQWkJUFs0tk8G37qQ4ZORH/dRPgj4UQkhHsGCZwbymdJjtyOPPzpexyQL
         rw1AyYBkytsX8GOPxFfVDNrzgZ6ehzj/RWXpQB1Y7pq4szP+afFl1Op+bz4tsiTk9XT5
         sEImRSG37Ppsl79eWpeDvEd8bmd6PUnx6CBgguB5BBHhzyPITnknqRd8E3x2mD9RDOTn
         qPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463662; x=1701068462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfOiAJGxKuFWs2NWOIwVX0esmzm7aks9t4Cs2rPO3Ns=;
        b=Tdno9rX9v9xU/xQHza9OYxE0VX7hchXDOZ+gDX+Yrhz4duBvo6iQyGImrSz25WW3YZ
         qMSVSx75Q5gNQkR+QHuxsSk0BgWbY2QiD1PS5YsxzPr/eYVayxbt5yIRHGBBHCT399je
         Kh0g2M18mV9wnvNRlJZ8QHdgGOfm5kdfAtKWfH46l+tzkTrIm2kt5QWZ4Fqsp9y8cYix
         Wa/UmQ1T0FFz6SB9PYmC4d5GsSAYvIz6LehxWinewT9/RXL9es6ZzvpwR9jEeuqZ3Ism
         awvq7vI0PmMJYPZ8ko25NwW5vB4jebmYxRNmfXLjb3LeX2zt2B+ozswtFnqsUODo2qDy
         fh9w==
X-Gm-Message-State: AOJu0YxcjJBFDZC/8tI4yMvyU/d7MsP+wP2nHhEcwsITHTQ8V7Ssdlpu
	K3PW6uYhwGavznJpiZIll1RdvQ==
X-Google-Smtp-Source: AGHT+IFYhQC0pKwL0X3X3CzqpSXg8s469lrvzqmbezPv+06Vdd64UWtM2cJIFyyY6eDNFLel2u3BPA==
X-Received: by 2002:a05:6000:1883:b0:32d:701b:a585 with SMTP id a3-20020a056000188300b0032d701ba585mr5891937wri.69.1700463662121;
        Sun, 19 Nov 2023 23:01:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:01:01 -0800 (PST)
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
Subject: [PATCH 02/14] clk: renesas: rzg2l-cpg: Check reset monitor registers
Date: Mon, 20 Nov 2023 09:00:12 +0200
Message-Id: <20231120070024.4079344-3-claudiu.beznea.uj@bp.renesas.com>
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

Hardware manual of both RZ/G2L and RZ/G3S specifies that reset monitor
registers need to be interrogated when the reset signals are toggled
(chapters "Procedures for Supplying and Stopping Reset Signals" and
"Procedure for Activating Modules"). Without this there is a chance that
different modules (e.g. Ethernet) to not be ready after reset signal is
toggled leading to failures (on probe or resume from deep sleep states).

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Hi, Geert,

In case you apply this patch and patch 1/13 as is, please add a Depend-on
tag on this patch to point to patch 1/13 for proper backporting.

Thank you,
Claudiu Beznea

 drivers/clk/renesas/rzg2l-cpg.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 3189c3167ba8..2922dc884e35 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1416,12 +1416,23 @@ static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
 	const struct rzg2l_cpg_info *info = priv->info;
 	unsigned int reg = info->resets[id].off;
-	u32 value = BIT(info->resets[id].bit) << 16;
+	u32 dis = BIT(info->resets[id].bit);
+	u32 value = dis << 16;
+	int ret = 0;
 
 	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
+						value & dis, 10, 200);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+	}
+
+	return ret;
 }
 
 static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
@@ -1432,12 +1443,22 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	unsigned int reg = info->resets[id].off;
 	u32 dis = BIT(info->resets[id].bit);
 	u32 value = (dis << 16) | dis;
+	int ret = 0;
 
 	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id,
 		CLK_RST_R(reg));
 
 	writel(value, priv->base + CLK_RST_R(reg));
-	return 0;
+
+	if (info->has_clk_mon_regs) {
+		ret = readl_poll_timeout_atomic(priv->base + CLK_MRST_R(reg), value,
+						!(value & dis), 10, 200);
+	} else {
+		/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+		udelay(35);
+	}
+
+	return ret;
 }
 
 static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
@@ -1449,9 +1470,6 @@ static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
 	if (ret)
 		return ret;
 
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
 	return rzg2l_cpg_deassert(rcdev, id);
 }
 
-- 
2.39.2


