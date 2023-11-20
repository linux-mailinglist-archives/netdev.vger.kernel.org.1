Return-Path: <netdev+bounces-49120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3B7F0E05
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7009BB21383
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41581DDAC;
	Mon, 20 Nov 2023 08:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="g5Wn/FQ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB328E5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso2663902f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700470000; x=1701074800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezAPzcxWw8oaCnMq9MMaqVY5m8sIIEr0Duonqihjljk=;
        b=g5Wn/FQ2SCHrMFOlQK69E2fXGkqdPXGOtq+BnN16UECyS9OIc7JxZIr/IcCSh2nlVQ
         exWMW+ADLQDiPmJWVGMsqZkuIzxTn4KKpjQBycfeoNQiiUrzor3tUywlUp6MBuiye0wN
         3DufUJ5lpJd06fdKoMAWSTOE9M9B3xHVWfThe+XOPJYPmsXe5KyNv3UmcG0Oetld8ddI
         qJsTAoo75c/q6g818gsJWEtY2MTMnvZZ7n1+k89ZfYfDnSnzkEzCax5xoNguHeiTQ15d
         LvqzjZldC6scJOgaUdBzq5qWWdvjuredeutRpV18+APhn1oKVLOCW6IUcgRXoMS5yr1g
         Veaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470000; x=1701074800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ezAPzcxWw8oaCnMq9MMaqVY5m8sIIEr0Duonqihjljk=;
        b=f1RPPQjPsBp2L7XOBjWcM8Woluwichx+aOU6XaBl+bBvqK9tEpGjBb+CbHTsBMNuu5
         jNyLlkYuqROarbiBerbL5XL6EQu2r/be2gZ3kjftxk74/ulizfEGRJGUPK0KDrGCWeWE
         OUo1URmFaF+jflOGlB5e+G4f6WXadSfK8npiSVde3e/7CaMczmHCBLtCQDkc8eKpAumZ
         1FUUgEjqjPC6VRfkOwTla0FfXA4a1UzE1pGOZZtmS4Ya0XsGar3Uaf3N34MZomFAJgcV
         1JhxtXK7HGdrGUSP7CrWndWys7xoX0jOPcVU25dyBBau1eSBDniNE6WueuNM2gsDUHbu
         gnyw==
X-Gm-Message-State: AOJu0YwQZWws6zFeAQqMrKzfhTNUfAnPof8cs6Io4axI3zEwYUB+nB6k
	jXEXzUAtWMIaA7pIZ6BF6lLKHw==
X-Google-Smtp-Source: AGHT+IEAgykpFjgvqjsDJ9ujkx/pXzS0QC1Ua+yXU5aenNy6UwS04GrphPWepSLY5gmq7jYPGWeDwg==
X-Received: by 2002:a05:6000:1001:b0:331:34c1:7a0 with SMTP id a1-20020a056000100100b0033134c107a0mr3949148wrx.57.1700469999993;
        Mon, 20 Nov 2023 00:46:39 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:39 -0800 (PST)
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
Subject: [PATCH 10/13] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Mon, 20 Nov 2023 10:46:03 +0200
Message-Id: <20231120084606.4083194-11-claudiu.beznea.uj@bp.renesas.com>
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

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8874c48604c0..15fc494a8b97 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2953,7 +2953,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2975,7 +2975,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3029,7 +3029,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -3042,8 +3042,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -3051,7 +3051,7 @@ static struct platform_driver ravb_driver = {
 	.remove_new	= ravb_remove,
 	.driver = {
 		.name	= "ravb",
-		.pm	= &ravb_dev_pm_ops,
+		.pm	= pm_ptr(&ravb_dev_pm_ops),
 		.of_match_table = ravb_match_table,
 	},
 };
-- 
2.39.2


