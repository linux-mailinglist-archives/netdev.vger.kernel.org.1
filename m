Return-Path: <netdev+bounces-49121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 335A97F0E06
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA69D281EDB
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5893F4F3;
	Mon, 20 Nov 2023 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iBMqkxPN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFAA10EC
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c46d5988so594423f8f.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1700470002; x=1701074802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9P13AuwHQNyol8ESmYlCJi/3K3sWj05YLgHYicy7J8=;
        b=iBMqkxPNTEKDL95lA/Gege1l4FJrPbPsQCoqpWNqFF2xGZpWxD7QcZ+0dPgruBqd7k
         kRNbJgglTjkPvfYFgeXcY3b34xL3OWM2i/93BPqdqqiS23OkEQs1bYRZhj17Bkwi8GYT
         EC/CIeV5zt9pRat8dYqMKNQkydET0BXuURurn3vAHb6kKZwDTjUrp0ilxDX7UtC1cow7
         TFsP2n4/JeTaGIC/KugGxw2noj3cAZE+VNP8Pz02vz2w+AgMlcnNwN0/Y2M0MOC1VxSU
         28cL473bju9D7Kdu6Pqfk2ZHiYXCOF0lfx394up4yYe8r3E1t+P1uLmiuKDbLXKPUdLr
         dTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470002; x=1701074802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9P13AuwHQNyol8ESmYlCJi/3K3sWj05YLgHYicy7J8=;
        b=uAqN/mUxsv4p9ozCNKhqtB8I+7rKBC2TDv/2I1qHvQ/x/vI1Pu6y1Q1jo56d1yx/wP
         5Oohz0FPgco9If+IrwDtHmflq1tpC8s98N+2wGGLZvCOTUAdpSVnHzVmnQu4ktUtfUVi
         YOdeFzZALTxxbqGzS/8V9i46YLv2gCn4gks35AqWC0VrIdHcrpjvaV8rp3YnNndC7cV+
         DBdrb22tt18tbct4yPMUhfITmEL5k3Rlqzu0v6vFzX+6TjVeJWzukR0mFqbG1sla9NfH
         LlIzclaXV4P6m4IZbE1pWblXyiLZxpiSDoyNxTiO/DOHKwvaxdEK0EUEZWSBxo4J88Jc
         si1w==
X-Gm-Message-State: AOJu0YzAvNDfaYdJZ3UjeKJ1k7SxRN6IBJdt1BBmnJ+B+yLtT+vzN6LV
	aZflaq5R9EFiyCA5QpEI4TsikA==
X-Google-Smtp-Source: AGHT+IH4tqjzxhfDBRO9JzLmK8bOQRhJkxyEAkin5Qwp4aH4sfWHYtHF/u857ef9ciIBxj5ZRGSdMg==
X-Received: by 2002:a5d:5f94:0:b0:32f:8a45:93a8 with SMTP id dr20-20020a5d5f94000000b0032f8a4593a8mr5042551wrb.0.1700470001599;
        Mon, 20 Nov 2023 00:46:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.183])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b003142e438e8csm10435267wrs.26.2023.11.20.00.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:46:41 -0800 (PST)
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
Subject: [PATCH 11/13] net: ravb: Use tabs instead of spaces
Date: Mon, 20 Nov 2023 10:46:04 +0200
Message-Id: <20231120084606.4083194-12-claudiu.beznea.uj@bp.renesas.com>
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

Use tabs instead of spaces in ravb_set_rate_gbeth() function.
This aligns with the coding style requirements.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 15fc494a8b97..a93b3d6b1863 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -85,13 +85,13 @@ static void ravb_set_rate_gbeth(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 
 	switch (priv->speed) {
-	case 10:                /* 10BASE */
+	case 10:		/* 10BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_10, GECMR);
 		break;
-	case 100:               /* 100BASE */
+	case 100:		/* 100BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_100, GECMR);
 		break;
-	case 1000:              /* 1000BASE */
+	case 1000:		/* 1000BASE */
 		ravb_write(ndev, GBETH_GECMR_SPEED_1000, GECMR);
 		break;
 	}
-- 
2.39.2


