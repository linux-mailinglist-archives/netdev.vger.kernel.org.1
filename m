Return-Path: <netdev+bounces-49115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506C07F0DF6
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9714AB2130F
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EB8DDAC;
	Mon, 20 Nov 2023 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ktCZkBmk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C77186
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32d81864e3fso2571209f8f.2
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469987; x=1701074787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTMsePF1mIhRVZgGZkTVw0dE2aONjlO+ow85WD/JWc8=;
        b=ktCZkBmkvmQUDiyuap6uQwubSBx7KGSyi5EtxzayIrQ8mSpYn8nEM7yjrs8+RbyHng
         Rg3Dr7OTYPdQ2I5lYB0Ff2+9k1CSYbG5St9XWKu/diOxFfCW38O75PK0PX+CPusRH/D7
         mh5m8YPIaILJM6NoK2UH7jn+uWoLwI4QtoWePpC7W/nTojbKAyAgX3RuDNwfhd0uFc25
         S6BV2OTfxLOZ9FgMedRqAwbMALqpUVONeG7f0chfq2aXWCJSIxca4gaaTlmiisBX6VGd
         DO1+5vK3+CBGMArf3bmA9Ngzv5Z31sZfIlsiddoSsDQKAvSqbmkaBHzfEwOff/MJq3Ou
         W2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469987; x=1701074787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTMsePF1mIhRVZgGZkTVw0dE2aONjlO+ow85WD/JWc8=;
        b=rqUAzRTvxs4ImOlBYhWmYJ9hRQNj0NjvQA+/fbNdatOubas5vLVvfjbZJgcNb/1PsB
         sKLT1YpdyTjJmFrShP+94OXy6tGuzaqEQAPn2TajjfYOLLldpiStra5JBCfyxK6CZNcR
         7F9NOwf+O16bdK4nR9xWkhYSQ+Kclhp5NiGh694afdgI6j6maqxMdDNdIqtjwlEO9xJu
         rKX4ayEDbUsQl+jwcjFYMyndfsEtmGKlDe2kOueMCnk1fxT1uYXOhtH9A3vFOO6HVmHz
         /sKjJ5JL5Ov2XUBd/pi27ygc7fjbD1Z7MnSecIDjQkAoTTAyBsUGcKS3hBXMy4Gu570E
         TkBA==
X-Gm-Message-State: AOJu0YyzaZI+PrZGW4oCA7s2AvsSS4kONKjSbCxofBU3lRGRGpVq+al/
	+j7NNkrypbgXRoLE/sONghtZ1A==
X-Google-Smtp-Source: AGHT+IHfqiV7VgEqFIq+d6ViMBq15jgGeoQzEC1z36ww167uYWXbfgpS3O66gbmfQWdM9U1Cajw2iQ==
X-Received: by 2002:a5d:64e5:0:b0:32d:8da0:48d0 with SMTP id g5-20020a5d64e5000000b0032d8da048d0mr4783264wri.68.1700469987164;
        Mon, 20 Nov 2023 00:46:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:26 -0800 (PST)
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
Subject: [PATCH 05/13] net: ravb: Stop DMA in case of failures on ravb_open()
Date: Mon, 20 Nov 2023 10:45:58 +0200
Message-Id: <20231120084606.4083194-6-claudiu.beznea.uj@bp.renesas.com>
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

In case ravb_phy_start() returns with error the settings applied in
ravb_dma_init() are not reverted (e.g. config mode). For this call
ravb_stop_dma() on failure path of ravb_open().

Fixes: a0d2f20650e8 ("Renesas Ethernet AVB PTP clock driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b7e9035cb989..588e3be692d3 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1825,6 +1825,7 @@ static int ravb_open(struct net_device *ndev)
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
+	ravb_stop_dma(ndev);
 out_free_irq_mgmta:
 	if (!info->multi_irqs)
 		goto out_free_irq;
-- 
2.39.2


