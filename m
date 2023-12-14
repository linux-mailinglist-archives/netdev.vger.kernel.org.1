Return-Path: <netdev+bounces-57372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11B0812F4C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41160282F62
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7F4D58F;
	Thu, 14 Dec 2023 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l7aXLowx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C335910DD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:49 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50c05ea5805so9456144e87.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702554408; x=1703159208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hga+Euca2ffWU8RByuMIoZjdDg4sBJqJ6E8Xj3GqHcU=;
        b=l7aXLowxuHeivrKOLCrOxfXiS1Nkru3oah4VqGlbWzr/wvwFOVe4IafZKyJEBZsLE7
         Q3Kri5ufiU8CX9ITsqdLvbIe3CNkWNKPN7oywmcvoD6u8ulM/EAcowXe7m/MQ1wWkqPT
         DUGDkvyLM2kFAC3xfLE9aSmrOvXmDV+doBJbK9ywwWDTBjp7JAaiUXwpaZWaLgRFbTIt
         i9oSBRGOalagrvRzGbHKOWP3IHnlz/VStR+oT0HpnFUIfc8dv74IbvmTZPgTjzEX1rO2
         A3H5qLN0KnqwO4A1VU4k8Ur8vxNq9ITQv45AIgcPYmfxRMq5g37AzsTfAVm1/ly/9EYJ
         3+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702554408; x=1703159208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hga+Euca2ffWU8RByuMIoZjdDg4sBJqJ6E8Xj3GqHcU=;
        b=LPeoWsuJNztnteo2DwXUEKIzKM+yb0nNsSuQ8fbux6o5z8OUXljIcHmUNmQjsauxGZ
         oRPyuwMONXN7JtIj+ku22YoRdRRr0msTxSm4JXYzkdDBo5kufE5GW79KwesG+FLR9yoK
         Tx1ybUDjbUDBDd6RIzWEWDHRwxxEmie9DOnTkOFPLjNC7T1NYdk/uX/3+pvsulrD1ca5
         zb6QOFLDKOgOQCj/9Ky7E876dQDr9IZh2wBm4kjofbcIAXc1rMAdCgqqitsegeXNyaIp
         GaZO1M2Q/PIPlh2PWar4aEMME1IdShuK0b0w+TM+4ypwEbsDeWZ2kFAmW+0KbtqHC2cF
         JrMw==
X-Gm-Message-State: AOJu0Yzgl4+FiX5OjfDTaIoWYMUJasG0OtQh93vTn1DH1xGoLm6jmOPp
	JK7GLKwMyLeuMJeHZmV74rGHeQ==
X-Google-Smtp-Source: AGHT+IFnDBljg1qdRWJ1vg6w1v/K2QMbcocaqB1sTTdcbBfsJx37oqwxmTaj3RmyvXHm2M4a86VXcw==
X-Received: by 2002:ac2:554b:0:b0:50b:f09b:e5a6 with SMTP id l11-20020ac2554b000000b0050bf09be5a6mr4073265lfk.112.1702554408129;
        Thu, 14 Dec 2023 03:46:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ll9-20020a170907190900b00a1da2f7c1d8sm9240877ejc.77.2023.12.14.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:46:47 -0800 (PST)
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
Subject: [PATCH net-next v2 18/21] net: ravb: Return cached statistics if the interface is down
Date: Thu, 14 Dec 2023 13:45:57 +0200
Message-Id: <20231214114600.2451162-19-claudiu.beznea.uj@bp.renesas.com>
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

Return the cached statistics in case the interface is down. There should be
no drawback to this, as most of the statistics are updated on the data path
and if runtime PM is enabled and the interface is down, the registers that
are explicitly read on ravb_get_stats() are zero anyway on most of the IP
variants.

The commit prepares the code for the addition of runtime PM support.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a2a64c22ec41..1995cf7ff084 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2110,6 +2110,9 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
 
+	if (!netif_running(ndev))
+		return &ndev->stats;
+
 	nstats = &ndev->stats;
 	stats0 = &priv->stats[RAVB_BE];
 
-- 
2.39.2


