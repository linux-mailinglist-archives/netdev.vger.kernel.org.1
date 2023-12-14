Return-Path: <netdev+bounces-57370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850FA812F49
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5651F21F22
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA8641222;
	Thu, 14 Dec 2023 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="obK3CD2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB7D69
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:46 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c5d041c23so10540517a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554404; x=1703159204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NoiORotVHtzab0Z6R5tqUvsar+MHiUXnH/O7lUfaa34=;
        b=obK3CD2vYmWEWmP0mcULb0eviBnLlnYYiR+Ndups6AtUc+CRZEge1FuXcQJfGTkLGm
         YjPgydXT+WPSw9V1mluhIchdeZlSLw0rO1Nv5GPxxzJL1rgxxT1bO1W706io5AszPp7Y
         MopgGi1I6VlucqY9srivY6NHCr5I/glGLDDKeIV7eRJP80Uoraok+foz3LAbDsNjIIOR
         fe97aynGeJWHvrLlN4h9JPd/NdtHUxN4D+mV3cScNSzVo37uJFTxM4vEZVKeUfrpzfB2
         5hjGDCpBoBluGDWoyJO28zpiOjnnSbzBD6yR1hfugzFeTf/2pjSr5IGjgbK8ivL2U0Zk
         OcXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554404; x=1703159204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoiORotVHtzab0Z6R5tqUvsar+MHiUXnH/O7lUfaa34=;
        b=HjekwOcWAURdbf9IUJ67KQF9HHWia2fzFhNfpMW6NSaHxD55O1koyQuWErkZ2/aAO6
         OM/VEXr+WjVgx/fYcGG3kFxfCCVKbPq+35cqzt2YtNn9sd7ATParBvF4YgC454XMaPjP
         DdHnAABbrW/HEopza4N6ho60W/T85CdBnIejAEhNGM4MNUgVE6mKv60yZy/cNgKRNIX5
         s4oGVgsIADotKkNaDbE4KukoG1cdP6QIu0minoEFhfpHqq4Blh1m5CfjcLD5hSZkc6ST
         ClopFcbUP+Y4LGxaz9nJk/kNZLwDYZjUQPqnABZCdzqhw+d5R8oRMNEP4QUHC6IoOcXJ
         SFSA==
X-Gm-Message-State: AOJu0Yww4c4vXIGJtieUhQMTGfPHBVimu+gh2LmVvq0Ah/TK0xQlsFJh
	2g6uTQ3OKbC3LmmDThAv07bcBw==
X-Google-Smtp-Source: AGHT+IEkHkIjbZxyWNnhWgVzwKp1oLjVB6rkXJC6EiXk5LsZBUGVINMSQUgKJqcBBpk9Att/KP854w==
X-Received: by 2002:a17:906:de:b0:a19:a1ba:bada with SMTP id 30-20020a17090600de00b00a19a1babadamr2578053eji.128.1702554404767;
        Thu, 14 Dec 2023 03:46:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:44 -0800 (PST)
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
Subject: [PATCH net-next v2 16/21] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Thu, 14 Dec 2023 13:45:55 +0200
Message-Id: <20231214114600.2451162-17-claudiu.beznea.uj@bp.renesas.com>
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

Keep the reverse order of operations in ravb_close() when comparing with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b581666e341f..38999ef1ea85 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2182,6 +2182,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2200,14 +2208,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2


