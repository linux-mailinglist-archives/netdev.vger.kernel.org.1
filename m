Return-Path: <netdev+bounces-49117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E88467F0DFB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F1B1F226DB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7DF509;
	Mon, 20 Nov 2023 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AELpa+2C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2519D6F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40907b82ab9so7912515e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469992; x=1701074792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zOeweRIPTzisv61dwOGKybnTDN8hrPF1gwr4IaPej8U=;
        b=AELpa+2CXCkaWfwEbbZ8yxg91im79/l4D8Gwtc2ZpsFdgHqJsRuUgDw6UhLW5iUOaw
         0FiEdlYw4OISlH1GyTUZDr29CvwOIgdNDK0oPgR86lR0W/jLE7v9hHi6iLgYyLWovcuN
         8nur0uYIW1Bf8YnNDsbaRiwB+QzOKdU3PPW0g2zlGNNzThYS9G50PTb54wQqWJqVmp35
         DK7fjMSqVZYV8AucUi0StDRhUmkXmIespw3zSaSJiIQ4tZeXBzA04osOpfQSZbzKSLyb
         AgzfNjoIwXTBvehl4Hw9Ac5lQJbtfpQz5vVVuhNcs6g7HIe3K7xK2Q2rF8/7mnnLfpo6
         uxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469992; x=1701074792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOeweRIPTzisv61dwOGKybnTDN8hrPF1gwr4IaPej8U=;
        b=kPcSY0TdNiPVrEhjTGTafh9F+K6U6EJzMB1tzb9XqSUIE51zlOSyqog7vskyvFhejy
         IKqGBJgjuhhVcDQ4451Z95uIqlnoOMwGmQBndkhJL6y/9zxhSPK68ksD/AHtcGKAGgoA
         yra43i7S9kNGSZz1LJFTjii0KJq7ceTeRVybUs8FmCqa7vgr7hkIe2wyrOE3ZWDCl09p
         Lbak5yCIXU2XAHyjfxI9aZfIwknrQ7qrJiiRcf0befZeeGzw1CyZiTE5V8Rfu8FAoHVf
         XLs4wUDpw4x3plyUZZWdHOReQn77sraT1MEUQukYPnGwSiHTOGURgtQ8hflUrhM3khuy
         RAKA==
X-Gm-Message-State: AOJu0YwbLxBqPJ0g3vlvUssE8MJUbsLyI0Sfd7GGcAaEbXCd2qXYZdX3
	TfbiSMneDTD0e+nxPDkQpMnZLQ==
X-Google-Smtp-Source: AGHT+IGEwTzVgPi+XFKHAI7QWLlDbO9F0/k65IkPe/o0Zgw1EIxZFufAS/j1wVNsDC3NMAVavifbbQ==
X-Received: by 2002:a05:6000:2ce:b0:331:2f9e:e8a8 with SMTP id o14-20020a05600002ce00b003312f9ee8a8mr6641722wry.8.1700469992303;
        Mon, 20 Nov 2023 00:46:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:31 -0800 (PST)
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
Subject: [PATCH 07/13] net: ravb: Rely on PM domain to enable gptp_clk
Date: Mon, 20 Nov 2023 10:46:00 +0200
Message-Id: <20231120084606.4083194-8-claudiu.beznea.uj@bp.renesas.com>
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

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64 based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 0fc9810c5e78..836fdb4b3bfd 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2762,7 +2762,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2786,7 +2785,7 @@ static int ravb_probe(struct platform_device *pdev)
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2806,7 +2805,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2869,8 +2868,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2893,7 +2890,6 @@ static void ravb_remove(struct platform_device *pdev)
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	/* Set reset mode */
-- 
2.39.2


