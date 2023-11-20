Return-Path: <netdev+bounces-49118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAF57F0DFD
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB5B21214
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3141AF9C6;
	Mon, 20 Nov 2023 08:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gaKjawyR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3DE192
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3316bb1303bso1643054f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469995; x=1701074795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzcPPHS9PLZPTA2qr9UA335fHiFxWMFmb2QEUprvcuU=;
        b=gaKjawyRvmtWnZzaIkrr/naPRCwvlX6RMI7pboiXv+Xlu9jpOf2qDPqa/iAP/mcCCg
         gcZqSEViPByiRa1mXqf5dlBYbBmbNJpGJG82zhh+jYo+UqPRQJG113UWYdTYq6MmdbJ7
         XKzmeOtBLweueCJvbPfJV62qraBNvhYh5/IOmO9OoFrZoa+VLubipm+3R9fACJL4LmFb
         kv0HEI+/fR2dbQ3aWCtmJkViPyvkVhco9A392QB2imrPPwQ+QT2qKKBe2c+Phocxqwe5
         VBdTGnpIk/MJQ96t51EuKW9TQXAqaHjDbM+fMZesFXlK2QbGL0j/ncXJNu6Ek7QNCTZ9
         9xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469995; x=1701074795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzcPPHS9PLZPTA2qr9UA335fHiFxWMFmb2QEUprvcuU=;
        b=cNLItSbCctAYR0bX1wXiZoEd8EwvPn6y6As8fnEwlU48Ohiligqlj5tl4i9oOL9Wl0
         P4itW//JgsuiCUEr5sNzKAxL+3NprDrISLW0WfqS1sbsmP0JfETllW2dqlk10TbSeYci
         TdWCBYaoMzAPJODsIG5kms3CT3zchnMxPLUaih/VF7R0LBiXhiTSIFNzrq6WGDdNetEL
         EISA96ix+fFyPBZ/uFYVu2kG8ZA8CSVvfNB9em+1IOGLmtVHyBr1iuAih8ZnW391sSgd
         R1IVG12fxx6ffhMe/kuN8tOjODhSAxcEYbAvw5jF4iH0h1xKg7Q60OWoMVr1x7fmXu7u
         4i1w==
X-Gm-Message-State: AOJu0Yx5aNBDnuWxK5QPX8T/Bx20UAEq+2Xt4aBSv3a6hKB04XBVhxZa
	Et45qByo0kvtjO7YmJhiWhSCyw==
X-Google-Smtp-Source: AGHT+IESA/FNyVv4jfN3ZbB7tbyHeGwu3USQsyegzaRPh/atGzZvqVXvBllR97R9rSm4O2NOQn17og==
X-Received: by 2002:a05:6000:a8f:b0:32f:7867:112 with SMTP id dh15-20020a0560000a8f00b0032f78670112mr4914227wrb.13.1700469995379;
        Mon, 20 Nov 2023 00:46:35 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:35 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	sergei.shtylyov@cogentembedded.com,
	mitsuhiro.kimura.kc@renesas.com,
	masaru.nagai.vx@renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 08/13] net: ravb: Rely on PM domain to enable refclk
Date: Mon, 20 Nov 2023 10:46:01 +0200
Message-Id: <20231120084606.4083194-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231120084606.4083194-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

For RZ/G3S and RZ/G2L SoCs the Ethernet's reference clock is part of the
Ethernet's power domain. It is controlled though CPG driver that is
providing the support for power domain that Ethernet belongs. Thus,
to be able to implement runtime PM (at least for RZ/G3S at the moment)
w/o the need to add clock enable/disable specific calls in runtime PM
ops of ravb driver and interfere with other IP specific implementations,
add a new variable to struct_hw_info and enable the reference clock
based on the value of this variable (the variable states if reference
clock is part of the Ethernet's power domain).

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e0f8276cffed..c2d8d890031f 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1043,6 +1043,7 @@ struct ravb_hw_info {
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
+	unsigned refclk_in_pd:1;	/* Reference clock is part of a power domain. */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 836fdb4b3bfd..ddd8cd2c0f89 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2502,6 +2502,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.tx_counters = 1,
 	.carrier_counters = 1,
 	.half_duplex = 1,
+	.refclk_in_pd = 1,
 };
 
 static const struct of_device_id ravb_match_table[] = {
@@ -2749,12 +2750,14 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_release;
 	}
 
-	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
-	if (IS_ERR(priv->refclk)) {
-		error = PTR_ERR(priv->refclk);
-		goto out_release;
+	if (!info->refclk_in_pd) {
+		priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
+		if (IS_ERR(priv->refclk)) {
+			error = PTR_ERR(priv->refclk);
+			goto out_release;
+		}
+		clk_prepare_enable(priv->refclk);
 	}
-	clk_prepare_enable(priv->refclk);
 
 	if (info->gptp_ref_clk) {
 		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
@@ -2869,7 +2872,8 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 out_disable_refclk:
-	clk_disable_unprepare(priv->refclk);
+	if (!info->refclk_in_pd)
+		clk_disable_unprepare(priv->refclk);
 out_release:
 	free_netdev(ndev);
 pm_runtime_put:
@@ -2890,7 +2894,8 @@ static void ravb_remove(struct platform_device *pdev)
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	clk_disable_unprepare(priv->refclk);
+	if (!info->refclk_in_pd)
+		clk_disable_unprepare(priv->refclk);
 
 	/* Set reset mode */
 	ravb_write(ndev, CCC_OPC_RESET, CCC);
-- 
2.39.2


