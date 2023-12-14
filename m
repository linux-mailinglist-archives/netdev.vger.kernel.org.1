Return-Path: <netdev+bounces-57356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC96812F1B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4101C214DF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD2D405E1;
	Thu, 14 Dec 2023 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I69wKj6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A31121
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso101489466b.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554381; x=1703159181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzZ0BgGaxayTSFzsb/BEZRjubDF9VvMmh4DxIfBVmak=;
        b=I69wKj6ciyjUxJ7QD/w621gbHVWbppXUhhnZ+Pw2vfjD8ysGHonveitzmjV0HB8mh2
         IvfhpZ+S7Pm6BoW8V1eVcmePUjQI9SofLtPnOHA4dCR+fHx5rKqhNE7DQ36cWzmlEaYq
         8iWDPRf2R0QDU4T3+u47GbIGofv5MGz4AOuTjxQkHUK9b+Hod/kH98vj2H3YtMetKvV8
         a4bcab/zx04lAVQfa/bvp8ConLHmtSAOH6Dxq+9xnp+mKBIwaj1IJGrUBOQu2llmExbH
         Y26J2rISYlvGRem8LXGGok/FeVXkOcQxaR2QRvMY4ENlVPazClO/5UascgOx4uWxPBww
         T56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554381; x=1703159181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzZ0BgGaxayTSFzsb/BEZRjubDF9VvMmh4DxIfBVmak=;
        b=uirKjZy04V3iApu34yNR+vLxp1wJTIwvMGqjDVXVd3DQE2geP7L+F73Dsa7qyx/ZsI
         k8H0L5F8nwyrBuftrnW6134bDSKSzktOTpKT6S7/lOgd8GG2xA3lv0JbzauQXXzDmKWU
         ABvVcqD6PtUAb3kkjnSy00LgZRY/k39HXXagR1D+Pp8djwEFAaXceoqnRj42nD/6ahpu
         dtVrEzzaA4QPDIhsbu85UgJpZuxWeAldzxK47Lz8tS3ZiCaB4VuEcuuNjYK3BhBGuhb8
         NeDOrX5cYapkBp4rbYy/CJUo/VJDhhfcEPPDGLhClWNx8aGDlF+GGsYn++sIMxR2CVRa
         aRdg==
X-Gm-Message-State: AOJu0YwXi04t4l2CXoppujAZlfuk+5PdI+Ey7iumgJ2CCFLTmzouBoof
	iyrr5nPt0lhp6xgB++PcC1sI3l8bIaDJw4F4mGs=
X-Google-Smtp-Source: AGHT+IGrfsWF2TK37JNT1iRMcyS+d6NKRvQ7j5MzSSkR+QkO1AqE2szxYNqX3A233KgAaRlYFdYN5g==
X-Received: by 2002:a17:907:5c7:b0:a23:f56:98e1 with SMTP id wg7-20020a17090705c700b00a230f5698e1mr903990ejb.18.1702554381683;
        Thu, 14 Dec 2023 03:46:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:21 -0800 (PST)
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
Subject: [PATCH net-next v2 02/21] net: ravb: Rely on PM domain to enable gptp_clk
Date: Thu, 14 Dec 2023 13:45:41 +0200
Message-Id: <20231214114600.2451162-3-claudiu.beznea.uj@bp.renesas.com>
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

ravb_rzv2m_hw_info::gptp_ref_clk is enabled only for RZ/V2M. RZ/V2M
is an ARM64-based device which selects power domains by default and
CONFIG_PM. The RZ/V2M Ethernet DT node has proper power-domain binding
available in device tree from the commit that added the Ethernet node.
(4872ca1f92b0 ("arm64: dts: renesas: r9a09g011: Add ethernet nodes")).

Power domain support was available in the rzg2l-cpg.c driver when the
Ethernet DT node has been enabled in RZ/V2M device tree.
(ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")).

Thus, remove the explicit clock enable for gptp_clk (and treat it as the
other clocks are treated) as it is not needed and removing it doesn't
break the ABI according to the above explanations.

By removing the enable/disable operation from the driver we can add
runtime PM support (which operates on clocks) w/o the need to handle
the gptp_clk in the Ethernet driver functions like ravb_runtime_nop().
PM domain does all that is needed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 8e67a18b2924..aa5e9b27ed31 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2780,7 +2780,6 @@ static int ravb_probe(struct platform_device *pdev)
 			error = PTR_ERR(priv->gptp_clk);
 			goto out_disable_refclk;
 		}
-		clk_prepare_enable(priv->gptp_clk);
 	}
 
 	ndev->max_mtu = info->rx_max_buf_size - (ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN);
@@ -2806,7 +2805,7 @@ static int ravb_probe(struct platform_device *pdev)
 		/* Set GTI value */
 		error = ravb_set_gti(ndev);
 		if (error)
-			goto out_disable_gptp_clk;
+			goto out_disable_refclk;
 
 		/* Request GTI loading */
 		ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
@@ -2830,7 +2829,7 @@ static int ravb_probe(struct platform_device *pdev)
 			"Cannot allocate desc base address table (size %d bytes)\n",
 			priv->desc_bat_size);
 		error = -ENOMEM;
-		goto out_disable_gptp_clk;
+		goto out_disable_refclk;
 	}
 	for (q = RAVB_BE; q < DBAT_ENTRY_NUM; q++)
 		priv->desc_bat[q].die_dt = DT_EOS;
@@ -2893,8 +2892,6 @@ static int ravb_probe(struct platform_device *pdev)
 	/* Stop PTP Clock driver */
 	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
-out_disable_gptp_clk:
-	clk_disable_unprepare(priv->gptp_clk);
 out_disable_refclk:
 	clk_disable_unprepare(priv->refclk);
 out_release:
@@ -2932,7 +2929,6 @@ static void ravb_remove(struct platform_device *pdev)
 	if (error)
 		netdev_err(ndev, "Failed to reset ndev\n");
 
-	clk_disable_unprepare(priv->gptp_clk);
 	clk_disable_unprepare(priv->refclk);
 
 	pm_runtime_put_sync(&pdev->dev);
-- 
2.39.2


