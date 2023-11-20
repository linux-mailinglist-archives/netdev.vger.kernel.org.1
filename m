Return-Path: <netdev+bounces-49114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01667F0DF3
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8805B212A3
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A977101D3;
	Mon, 20 Nov 2023 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SffkOGBz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0989B9
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:25 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32fadd4ad09so3068411f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700469984; x=1701074784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5DUTseQ9M13B3c/uNsGDyKmzs8yrYsJMqyVo9/Bt0g=;
        b=SffkOGBzwA4VLDateY/j88lK4kM93BCcrecM+r8sOsIKiPFqFMkxD0QZCLGS1KDKA8
         lTV6i6Dnmn9kr14gQvYDiLHLIS/SpKkA/FxTWm+ZoEQP/s5WFg5osYmiwgumnu8SautG
         Cmr0qYF2ZrSURmdKM6tBsZe+0FIN9XNtFX8xOy4wRL0j7vcmx0ERgJJN3LfITIGIrq4g
         J1JICItYgP6tOBuNBlnaLIVFRwbxRHOcu6UQ0GkCnAnho21UN5lujm7tOl82twRISzAF
         pZU0w4/2vTwireL9dEIg7VNqCwabLw9Fs7au5Lzh4+uF6dLL17nB7cQzoDrxX5fhXTDa
         0CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700469984; x=1701074784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5DUTseQ9M13B3c/uNsGDyKmzs8yrYsJMqyVo9/Bt0g=;
        b=XtrtItfQt6T98Y7EszmvHoVJAZqdr70iOh55uajIzCO4bBlvenw6RryCXNM5hVHOaG
         VB831hQWVbS02EdKuRQQkWmRllWZa0/o3dKByW9xdi/ae0LKLjRF7hsTDXEBQ6Ke0wRo
         prghSR0u/zwa5o6TTKBRFYvpeIhl2+QujUlzZ2kRfZP1DAjVDTnf6K+tlkQ0ypd/oXpX
         2DvYnNfK/+i1SBGYmClANASeyZr8Yl19NLcNRubuAK99Mb47Fe8oFUKTnfKtpBQR/sVi
         vZLUZI0APrujEBSfcxL3e/tDrnY+FDriMjoKKMXn9XcmZFu3jKwVNei1GyIXKdifT1ID
         OjqA==
X-Gm-Message-State: AOJu0YyOWU+fznr3R1jwtrmGMTvVTyEF7A8LqFSY5K+MqqpATX9dXVS8
	v/mN55bDk8PHEic53E/0eAaQwA==
X-Google-Smtp-Source: AGHT+IH+kw0D3I8hcIjXDKB623M+1uoixo0SRLnUYry7SJ1e2Cyi7IKXMIG8YCxsaQqU/WoO+oYnFw==
X-Received: by 2002:adf:e406:0:b0:331:6d38:5d18 with SMTP id g6-20020adfe406000000b003316d385d18mr3774080wrm.61.1700469984417;
        Mon, 20 Nov 2023 00:46:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:23 -0800 (PST)
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
Subject: [PATCH 04/13] net: ravb: Start TX queues after HW initialization succeeded
Date: Mon, 20 Nov 2023 10:45:57 +0200
Message-Id: <20231120084606.4083194-5-claudiu.beznea.uj@bp.renesas.com>
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

ravb_phy_start() may fail. If that happens the TX queues remain started.
Thus move the netif_tx_start_all_queues() after PHY is successfully
initialized.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d798a7109a09..b7e9035cb989 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1812,13 +1812,13 @@ static int ravb_open(struct net_device *ndev)
 	if (info->gptp)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
-- 
2.39.2


