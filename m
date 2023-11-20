Return-Path: <netdev+bounces-49083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C27F0C19
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E61280C5C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CFB5224;
	Mon, 20 Nov 2023 07:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bk9qi9Qz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D196126
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3316bd84749so1625597f8f.2
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 23:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700463659; x=1701068459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvVQDVzWJ+CyhFQxQLIJ69wjbv3n+I6qePm2Xo8n7Gc=;
        b=bk9qi9QzACH/BjI8KLeYj1qmi8Z19+IYrfoLnRLkNekVWH4HaGkhpuHD06YD1O/9oQ
         YYyEvjo+N9syjmKzHk/eypepK/2oawWZhRrRRLNTUDiua76k9+xWwVE3Wy6A/oX+LM2y
         BMgXowShkOfctxdSjSFrl7VQobPucQmwbPYPiQYQNuLE7s4z+tNS/xH3IwSO9hW+3IkM
         DaUaOeTzfWQleXVLn/OSfdbVSRNplnj3QW4FmP3OButZe+uciNht4PVCzBsAwbYQBDyi
         npM9XA+nnEbCRbIVE0pc5Fvjhr0tdvBVHzRwGGfccxTzacp2UtSeLUyM0aCuC8p5PdNS
         5duw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700463659; x=1701068459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvVQDVzWJ+CyhFQxQLIJ69wjbv3n+I6qePm2Xo8n7Gc=;
        b=ZVdj3xqGM26ORSZdc7hh14Y0ueCey/otC18SVq2tEdH7ErohOD+xAjmVeIT0qoUmZY
         bh4LQ3yPsC2bO8M8nqJkhkqbaXTnx74tcJzN3rovJuK2IK4GcXVCVrfm2xj+lcip92kI
         kBxKPD3z6qITkasBI2QqhxAFeM+GvRalKGPwpsZfSZ3CSPFYY3JShosDWD5Zb3OktiiM
         wTev2H1f5pDKThsL91BWzndV6tjunzHYCJy/bd5uDz0LtC9PDHfB3S5kYgQJLaLL/ibp
         68IyxR5pa1fWgoz9fBvpFEEiW/UYa2+gsj+JBxO7v1XUJXRfvKIyE9RsOpy/UprgxsZe
         YJBg==
X-Gm-Message-State: AOJu0YxMBNXx7xmz8koASXKNHIJYG6NFRvZ50xJgytJe9/srSKwCchYB
	JQZSlAm4Lx7sQWGQqJN1h0buzr5W3LuzRMN5lBk=
X-Google-Smtp-Source: AGHT+IGfTPFlP3Fps1jXx2D8NtfyUEZnxAphWc5ESbDftl9ZuQTNbxAvSON6SHmfbEPMtENC09wVUA==
X-Received: by 2002:adf:dd8c:0:b0:32f:7db1:22fb with SMTP id x12-20020adfdd8c000000b0032f7db122fbmr3678754wrl.28.1700463659555;
        Sun, 19 Nov 2023 23:00:59 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id p2-20020a5d4582000000b003316d1a3b05sm8777667wrq.78.2023.11.19.23.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:00:59 -0800 (PST)
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
Subject: [PATCH 01/14] clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
Date: Mon, 20 Nov 2023 09:00:11 +0200
Message-Id: <20231120070024.4079344-2-claudiu.beznea.uj@bp.renesas.com>
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

Code in rzg2l_cpg_reset() is equivalent with the combined code of
rzg2l_cpg_assert() and rzg2l_cpg_deassert(). There is no need to have
different versions thus re-use rzg2l_cpg_assert() and rzg2l_cpg_deassert().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 38 +++++++++++++--------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 764bd72cf059..3189c3167ba8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -1410,29 +1410,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
 
-static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
-			   unsigned long id)
-{
-	struct rzg2l_cpg_priv *priv = rcdev_to_priv(rcdev);
-	const struct rzg2l_cpg_info *info = priv->info;
-	unsigned int reg = info->resets[id].off;
-	u32 dis = BIT(info->resets[id].bit);
-	u32 we = dis << 16;
-
-	dev_dbg(rcdev->dev, "reset id:%ld offset:0x%x\n", id, CLK_RST_R(reg));
-
-	/* Reset module */
-	writel(we, priv->base + CLK_RST_R(reg));
-
-	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
-	udelay(35);
-
-	/* Release module from reset state */
-	writel(we | dis, priv->base + CLK_RST_R(reg));
-
-	return 0;
-}
-
 static int rzg2l_cpg_assert(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
@@ -1463,6 +1440,21 @@ static int rzg2l_cpg_deassert(struct reset_controller_dev *rcdev,
 	return 0;
 }
 
+static int rzg2l_cpg_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	int ret;
+
+	ret = rzg2l_cpg_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	/* Wait for at least one cycle of the RCLK clock (@ ca. 32 kHz) */
+	udelay(35);
+
+	return rzg2l_cpg_deassert(rcdev, id);
+}
+
 static int rzg2l_cpg_status(struct reset_controller_dev *rcdev,
 			    unsigned long id)
 {
-- 
2.39.2


