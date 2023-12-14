Return-Path: <netdev+bounces-57371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2040812F4B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55354B215D0
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE434D122;
	Thu, 14 Dec 2023 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="W7zLXBgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FECD7E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so10540556a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554406; x=1703159206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYBn9/laLzrg7Vdv2MX/5C0b5odhy/gUWFCra0JFpOw=;
        b=W7zLXBgU/MmJZmapmnyy1jmsQHZ7zVFjlgXXG1EsktOvneRpT/IuxMOOMw9WM8K56+
         SWsoyZ7uC+zoDdYkq+Idik3vzN7uxAA/y3GlzqvxcJS8db8iCKB9Z72NfU0ksgPttFIL
         Cm0GvfuA7aEYcqrruZpkgwpb3guc/CFjPMCAh3uGWJ3TUOUtqBLlw0TMjvlbqPlvtSTc
         GteAnq8rhPPTKkTR0IADYOwsJsyrmkouIArwUtjlH4xvHmMM96aRCKb+038EFGSPjpGT
         iNytUewClQt6tYPHSsY1hhEJnRkFKdZ6BvdZcTLjK3FTah9rN8VmniVvN1ZqgP+E6VTr
         2zAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554406; x=1703159206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYBn9/laLzrg7Vdv2MX/5C0b5odhy/gUWFCra0JFpOw=;
        b=qkbGl7MJoV/QOXxDEwee7gJU2yvrx9fjvYo8ZPAtgoF9bPEdz1pooxoeeBeyKtArDl
         IGmO+i/Q/SIPK3Ypd58AqV8zezVd5g3ESLfN+CIuhyyGs8IioR+uqn5vz/9BAMn/5dPg
         DDyDgS7415gomQ+IkfFBfGmLuIr9kDeih71FmOuJj+5iTLXlg0//gZzBQX2atPnxAboj
         oSZ1UTrdg5KtOwgM6Bf4XxIjC7c9pnLxa5kfhNZweT9YajSQniEM8Mqlp8NsGoqcH9o9
         NIhaZoI3Cz5yHdxY4kVK5pdSCrW2IYpfOJJHd0WLU5DWDfDXmTfOUnBPk/BDv4xhHXXN
         RuRw==
X-Gm-Message-State: AOJu0Yy5sesXjqUvux5V/e/9yaXQOMFcN5gVZJsCQ7QMSO5K78xE50XD
	Ww4qEc+GRKomIHpKVdUTBviABA==
X-Google-Smtp-Source: AGHT+IELfCBw9NbcKSq88512K3cgJnjQwOtGysv+vOQMfS/g+oF4gHBjkLsL02Q1+qt0DyW+mANwkw==
X-Received: by 2002:a17:906:197:b0:a1b:d7a5:927a with SMTP id 23-20020a170906019700b00a1bd7a5927amr2171533ejb.183.1702554406583;
        Thu, 14 Dec 2023 03:46:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:45 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	wsa+renesas@sang-engineering.com,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 17/21] net: ravb: Keep clock request operations grouped together
Date: Thu, 14 Dec 2023 13:45:56 +0200
Message-Id: <20231214114600.2451162-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Keep clock request operations grouped togeter to have all clock-related
code in a single place. This makes the code simpler to follow.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 38999ef1ea85..a2a64c22ec41 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2768,6 +2768,20 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_reset_assert;
 
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		error = PTR_ERR(priv->clk);
+		goto out_reset_assert;
+	}
+
+	if (info->gptp_ref_clk) {
+		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
+		if (IS_ERR(priv->gptp_clk)) {
+			error = PTR_ERR(priv->gptp_clk);
+			goto out_reset_assert;
+		}
+	}
+
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
 	if (IS_ERR(priv->refclk)) {
 		error = PTR_ERR(priv->refclk);
@@ -2801,20 +2815,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk)) {
-		error = PTR_ERR(priv->clk);
-		goto out_rpm_put;
-	}
-
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
-			goto out_rpm_put;
-		}
-	}
-
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
 	ndev->min_mtu = ETH_MIN_MTU;
 
-- 
2.39.2


