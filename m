Return-Path: <netdev+bounces-57368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DFA812F43
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1DAB2149E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240F4C611;
	Thu, 14 Dec 2023 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CDEYaeaE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9ED57
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:43 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bfd7be487so9091268e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554401; x=1703159201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cT7sZVhk3SPH3qfWzj9p6vjX2dF9hm4OYxHa78CzWQ=;
        b=CDEYaeaE6qduuOmQss6XjTpBXM3l7gS2mus6VDSWgpvsyp5VVU14HtMHCVJG7z5rUX
         YkkdljRVLrtBpLWUoHHqmN73+boOi/tndrwdDrNwO03k5sScGTIoyMZv1EMB9KzhPAdV
         eXXr99nB4SQRzrDPDnMsfLd9I1uVo01hmH1PSXz6sI5ltOtO3eq6pA/gfxEnt6WqZuYj
         GskgPJd7cirHQ9sde+NaB75o769xgmBDu9vcb2MvmzihbVAzZ3NPbsrwmjHek5dOwurS
         Azdv0m4nc37IAPXIyl2lCCV0+9Fl9g/XAyvZ1Y7JV+lGnX9hALmkfZJVJSqAUdHGps5Q
         2UYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554401; x=1703159201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cT7sZVhk3SPH3qfWzj9p6vjX2dF9hm4OYxHa78CzWQ=;
        b=kUaGkd7IxIfNdmGZoOv8gu1GDTI92p9XS11r0LBJhPpGopWaHdxwjL4g1wpbwOFE8W
         T3oFM/wAYnI5HTUzstm9RD/88SARmoa9eTtMWFM2tws7+SsYE/3LHPYfWvT1IzIimGOO
         gx9iE2XfYLMFY5TwieQh01DmZfCwhiXZtZWuzp4QX9DEsH8l+76ror7mi/S9CZgMilFP
         b5B/6v3Xa6L7L/3k9wC8g8/rOj6JgdcK3KlVhVs2q46XgHjWRdjzn2jR5L5t7QhOFtJJ
         4FnLjAW04XInvFIRzF64eG0RKOX3UsVPEqBlTd88S8enwi3ujSJL/IVYnam43rzSP7tM
         VmSg==
X-Gm-Message-State: AOJu0Yz3U4zGeg1tZpk6rzBwt9xBepkmd6dEm9aUBkwc9szqpstd6ok8
	bjayHNYYQZPdrd6pMMl6kPneHg==
X-Google-Smtp-Source: AGHT+IG971WfjyERHQhZ0TdR63Dq7y7Fb1xD2Xpc2eRNcB9COcCGSdCFifT0aHwVpfyDHrdNy75McA==
X-Received: by 2002:a19:ad44:0:b0:50c:2fc:cac with SMTP id s4-20020a19ad44000000b0050c02fc0cacmr4070502lfd.126.1702554401526;
        Thu, 14 Dec 2023 03:46:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:40 -0800 (PST)
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
Subject: [PATCH net-next v2 14/21] net: ravb: Simplify ravb_suspend()
Date: Thu, 14 Dec 2023 13:45:53 +0200
Message-Id: <20231214114600.2451162-15-claudiu.beznea.uj@bp.renesas.com>
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

As ravb_close() contains now the call to ravb_ptp_stop() for both ccc_gac
and gPTP aware platforms, there is no need to keep the separated call in
ravb_suspend(). Instead, move it to ravb_wol_setup(). In this way the
resulting code is cleaner.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 31a1f8a83652..16450bf241cd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2968,6 +2968,9 @@ static int ravb_wol_setup(struct net_device *ndev)
 	/* Enable MagicPacket */
 	ravb_modify(ndev, ECMR, ECMR_MPDE, ECMR_MPDE);
 
+	if (priv->info->ccc_gac)
+		ravb_ptp_stop(ndev);
+
 	return enable_irq_wake(priv->emac_irq);
 }
 
@@ -3000,14 +3003,10 @@ static int ravb_suspend(struct device *dev)
 	netif_device_detach(ndev);
 
 	if (priv->wol_enabled)
-		ret = ravb_wol_setup(ndev);
-	else
-		ret = ravb_close(ndev);
+		return ravb_wol_setup(ndev);
 
-	if (priv->info->ccc_gac)
-		ravb_ptp_stop(ndev);
-
-	if (priv->wol_enabled)
+	ret = ravb_close(ndev);
+	if (ret)
 		return ret;
 
 reset_assert:
-- 
2.39.2


