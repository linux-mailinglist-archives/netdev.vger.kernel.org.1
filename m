Return-Path: <netdev+bounces-57364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C21E812F30
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66281F21BE3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB4C4AF94;
	Thu, 14 Dec 2023 11:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ooVfqKUk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE01B6
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so1030057a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554394; x=1703159194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1OUji9wCp+dAckpdOqeAMpojOUtVbEPR5TgenY6gOI=;
        b=ooVfqKUklJlxQoHrqNicnWYxMgvGyQHIKGfKpVWUcejGNBMGhz0Xqk67jOZ8HMF+Em
         busJOk1edJAoH8ivjjr4DnpRY6LodWH+jyn8kwygrirP8JNOHIszNF61rtn0qEOmcTIW
         S2QwAQsh3m6rrxDfSKv8ffFm9kYHxSrrp3skRmd7wVJL4NFvjE1ZwSYm+cS6ted1C3KC
         BeY8hZoU05LeXGXSPZyAJVmbbvyXlXyR89er3uAlhXkcSOIW8DvZcWUkWVhIgywEykis
         IxJLHd4lSM9cTS1bdzwGY9In++0axBUwa5Tcbtafht4tfzrqjc+emo4Ci4CIVSgwrd65
         CBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554394; x=1703159194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1OUji9wCp+dAckpdOqeAMpojOUtVbEPR5TgenY6gOI=;
        b=GqiU7dqcCcAb53C3gPSgiozdlIqytCdJ7cMMLHQCti4DBdnbZ7iXUSj47GiJcoefEM
         9aKpZdfAp3CHi7wSZ7MohlNtFOi/HUHvy5s44KDaH7ZA88D/0RxCCJp+f0K5kMieTAet
         r2XsZQjCLmDMqoGFVA7Psj5++TLE+zDS0ImHU5cAGUQoJXj1TArC2YbdqIGzkZW5bERE
         mfgDBs5n18IrnSPscdJ5mwRmf8U+dha4zww/O36/fylqsRvTmBWX3Jg4Talv2Dv27kbi
         w7O5qx96JgHQEuPB7Joz2//nRCkyJlQsd1Sby+j6u/4uiAG5LJI0D4qus2Z/KHlkJcPS
         cb+g==
X-Gm-Message-State: AOJu0YzwyuZciFH07uYEoLd270D4vqaCXlw5eA/ovFR3iEv5i5xiDGT1
	Sk6DejyXJgNxQgFa0hHskmh7+Q==
X-Google-Smtp-Source: AGHT+IG0O3EByFK5t8ueAC3nSEptoUgXCTlKhlPL3bo+hmkiivb3jH82qzlmXVkixY8Xyi001BW14w==
X-Received: by 2002:a17:907:9729:b0:a1e:eebd:ecd with SMTP id jg41-20020a170907972900b00a1eeebd0ecdmr11378221ejc.32.1702554394749;
        Thu, 14 Dec 2023 03:46:34 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:34 -0800 (PST)
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
Subject: [PATCH net-next v2 10/21] net: ravb: Move delay mode set in the driver's ndo_open API
Date: Thu, 14 Dec 2023 13:45:49 +0200
Message-Id: <20231214114600.2451162-11-claudiu.beznea.uj@bp.renesas.com>
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

Delay parse and set were done in the driver's probe API. As some IP
variants switch to reset mode (and thus registers' content is lost) when
setting clocks (due to module standby functionality) to be able to
implement runtime PM keep the delay parsing in the driver's probe function
and move the delay apply function to the driver's ndo_open API.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 37 ++++++++++++++----------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5e01e03e1b43..04eaa1967651 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1795,6 +1795,21 @@ static int ravb_compute_gti(struct net_device *ndev)
 	return 0;
 }
 
+static void ravb_set_delay_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	u32 set = 0;
+
+	if (!priv->info->internal_delay)
+		return;
+
+	if (priv->rxcidm)
+		set |= APSR_RDM;
+	if (priv->txcidm)
+		set |= APSR_TDM;
+	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
+}
+
 /* Network device open function for Ethernet AVB */
 static int ravb_open(struct net_device *ndev)
 {
@@ -1806,6 +1821,8 @@ static int ravb_open(struct net_device *ndev)
 	if (info->nc_queues)
 		napi_enable(&priv->napi[RAVB_NC]);
 
+	ravb_set_delay_mode(ndev);
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
@@ -2530,6 +2547,9 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
 	bool explicit_delay = false;
 	u32 delay;
 
+	if (!priv->info->internal_delay)
+		return;
+
 	if (!of_property_read_u32(np, "rx-internal-delay-ps", &delay)) {
 		/* Valid values are 0 and 1800, according to DT bindings */
 		priv->rxcidm = !!delay;
@@ -2679,18 +2699,6 @@ static int ravb_request_irqs(struct ravb_private *priv)
 			     ndev, dev, "mgmt_a");
 }
 
-static void ravb_set_delay_mode(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	u32 set = 0;
-
-	if (priv->rxcidm)
-		set |= APSR_RDM;
-	if (priv->txcidm)
-		set |= APSR_TDM;
-	ravb_modify(ndev, APSR, APSR_RDM | APSR_TDM, set);
-}
-
 static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -2818,10 +2826,7 @@ static int ravb_probe(struct platform_device *pdev)
 	if (error)
 		goto out_rpm_put;
 
-	if (info->internal_delay) {
-		ravb_parse_delay_mode(np, ndev);
-		ravb_set_delay_mode(ndev);
-	}
+	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
 	priv->desc_bat_size = sizeof(struct ravb_desc) * DBAT_ENTRY_NUM;
-- 
2.39.2


