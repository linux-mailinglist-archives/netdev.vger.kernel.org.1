Return-Path: <netdev+bounces-49116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60F7F0DF8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E6F281CE1
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEEDF4FD;
	Mon, 20 Nov 2023 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VUQPU/G8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558DD4F
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32daeed7771so2496422f8f.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469989; x=1701074789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X03fkvD/NmOk7FgJvVd2vA4cAoE3eXt5JBylRkbge34=;
        b=VUQPU/G8li7LV8UImVQnl6eH1YdsTdMPeMdYKJFo06tj0MIQ0ripS076wB4txtetXw
         TskECWtfuId9X3jmcv7W+L11HIKCBGLliELgDLtxVYcqOgTXq1VLI1WrPBIXL0hmN6Mm
         dX9unbFe9YucMGpq+IEyScGLAL3EwyA4R+OtpaQnMzvUxG9tNk0yJGsVAyHiSL469+fE
         e2ghgQg2Rv8GxDKF0SGfGm8ifO0wNdjKpcCdHSobf5a0l/z0z/nMGFMmV0Qx2gyJJs1D
         jdq4LeyVC73uu5a6gnPmYMPaynCaBDvScNaNlERMv00c7UnH/82n83dpr+k+4Y84fNFM
         8/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469989; x=1701074789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X03fkvD/NmOk7FgJvVd2vA4cAoE3eXt5JBylRkbge34=;
        b=d6TmX05wfKO4+kk8Hj7+I+DzO6H4+Nwahcu8vS5e9nMGAk1j3nbp5aSLj0euJ/ALbZ
         04Jx7Yt5lf73G6+oQbJgjTwm466PxKAP88yxTIVl/K2oPIwl2mofP7QUOmA+chhZRk0P
         Fw79AzdBm61v6ClVMeg02wIsmBhjcpj4PUu8h0CDKFegm4oGIElNn3k4E+zgEKsUsaly
         tazcBRA7SOuTWAv/d8JQjrsMnTbe7EMW3WWrjHIF1aBk4qRAETuYLzYqTXLbYtcHzMx6
         Wgzn/RWnXVPCrGLpFKyIy1z7Gg7AkfJWobG7fxnHVQf0TDU8fERbNoFBdtZZ+l77U/Mg
         c/jg==
X-Gm-Message-State: AOJu0YyhP6M3G270EsW8Tiy3Wygc5Lc3ZKE6WdnMRF7m0Tsf4lJXYTgD
	PaEVlljaeXWJlW+buBpXH50uAQ==
X-Google-Smtp-Source: AGHT+IFSlGhbc9YVoJY/Cj/t9l8QVKfrxCMhnLQGLI4Mxl0wHVZMEMgDMtkKoth9oaA89rn5KUGRJw==
X-Received: by 2002:a5d:5b8c:0:b0:32d:96a7:9551 with SMTP id df12-20020a5d5b8c000000b0032d96a79551mr3771027wrb.36.1700469989563;
        Mon, 20 Nov 2023 00:46:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:29 -0800 (PST)
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
Subject: [PATCH 06/13] net: ravb: Let IP specific receive function to interrogate descriptors
Date: Mon, 20 Nov 2023 10:45:59 +0200
Message-Id: <20231120084606.4083194-7-claudiu.beznea.uj@bp.renesas.com>
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

ravb_poll() initial code used to interrogate the first descriptor of the
RX queue in case gptp is false to know if ravb_rx() should be called.
This is done for non GPTP IPs. For GPTP IPs the driver PTP specific
information was used to know if receive function should be called. As
every IP has it's own receive function that interrogates the RX descriptor
list in the same way the ravb_poll() was doing there is no need to double
check this in ravb_poll(). Removing the code form ravb_poll() and
adjusting ravb_rx_gbeth() leads to a cleaner code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 588e3be692d3..0fc9810c5e78 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -771,12 +771,15 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	int limit;
 
 	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
+	desc = &priv->gbeth_rx_ring[entry];
+	if (desc->die_dt == DT_FEMPTY)
+		return false;
+
 	boguscnt = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
 	boguscnt = min(boguscnt, *quota);
 	limit = boguscnt;
-	desc = &priv->gbeth_rx_ring[entry];
 	while (desc->die_dt != DT_FEMPTY) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
@@ -1279,25 +1282,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	bool gptp = info->gptp || info->ccc_gac;
-	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
-	unsigned int entry;
 
-	if (!gptp) {
-		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
-	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (gptp || desc->die_dt != DT_FEMPTY) {
-		if (ravb_rx(ndev, &quota, q))
-			goto out;
-	}
+	if (ravb_rx(ndev, &quota, q))
+		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.39.2


