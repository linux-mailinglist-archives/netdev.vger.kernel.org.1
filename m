Return-Path: <netdev+bounces-70585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3284FA8F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B2D289ED3
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1977F479;
	Fri,  9 Feb 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l7T8VIHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BEC7CF3E
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498312; cv=none; b=kD6TKK/DXjTE3YT6/G7BELTJT2jmKKcLhUgayBQ0r3zbTkffArCy0mfS4x8Ij/xv07uYkYTdfbHfhkE8k2ynmZRTQEC1gPnm0zlhC2SxwnRttOHMIVKsHZP8Ft4W9zwOEwIOWE/Yy/Lxfyxo5d117wmyVj2/p2kGxp56lJ5UEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498312; c=relaxed/simple;
	bh=E9qfFlPW1e6QyyiFWyQNW8LWGspZ155/NwV+vfM7aoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXEW2FScKo1XqKyxJ0zdfBEOu7gFe82JET3NFPov0MTM2SChNApQYTqYOOD56Iz0BEc24B4IhwQxKkL28NovT+P1YSPlcRP6bbSoODyRH46fiI7kAU2n5dUUVPUoUusTUiijy2HWC5v59xD9FR602GaCAc15xauS4vIIlb5RmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l7T8VIHe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so727219f8f.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 09:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498309; x=1708103109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJVjrzAqciRb2/LRj7N8tiqtGPPPqEc7yCwP1DwWHTU=;
        b=l7T8VIHegpD1YRWTO6MaIW2hj6CeU+uTg5tmRZ3y2TRklBUpQTWPvdsoLPhKmVOqUv
         QgRzKMXBg0ut+7cipkcImfG6GD6hpaRcqtiPlauQAOX4xqqqKt5rQGJKAytvzIrlWTcT
         b6pkLV1KFEm5HKWkfBDmIc4VFq3kyKvd4nwjgTJWDsarNV7ziH3wQSSi6bA4DJ7iiJPp
         19I731vgH5Sys0J51pDwf8WM1UaL9vzNeC2m/KUXED+yaiBleWTGuhGeBpf3pTfrmqdV
         jU2oMlTH/Y3xBdJ4yGrIcJKaS8eUcPLmt+/vG9l4GU+bq7jY74RyTRDAPBmLA6IF3lZO
         SeOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498309; x=1708103109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJVjrzAqciRb2/LRj7N8tiqtGPPPqEc7yCwP1DwWHTU=;
        b=R4l/AVLJEHiNc1sqLd0BZmHtWCCTaimboywWzkiiQKxNkrRhJGL8EozrRtV9jkH2LZ
         cbL9iMqQfDmaj3J0Rd2Al4jrcqseNTaQFHN3+1jgvy3lAxwqb6/P6erbNmuJjf4fBACa
         SWtcVSITwuxQ/6BR+ICxH7/d9IfaEWb+wGpwui904iQZU3Pz2I1ywqUUZNlCyvjuDZX1
         8U68p9q1lmblwoMup9J4BfNknErJo11cMQbzL+9nc68IxFllYSnNnxOUGIY06FrL3q3L
         vGBipjxE6gJr46gw33+FluoG9XDnv9L676qZvBIII0gKO65oM+uJn39DEKFYbkzz9D6t
         VsSA==
X-Gm-Message-State: AOJu0YwGc3JuslSEnulSnamkjgZWOZ05q8pRQILuhBHTzWlhC9ysFuMo
	y2C6yW1sNuwFtmlF+0YCNy1aHBXDNzxXpSnXHL/tDSM/ALjlH2ZNk13Sf7K6L6Y=
X-Google-Smtp-Source: AGHT+IEHp22JYBjn3LBrSBS2ExLaFTW9k7a4NPbhDL5/QOqpK139dOb9BQtAHdDvKxL8IrBvZERLSw==
X-Received: by 2002:adf:f987:0:b0:33a:e7de:aa8b with SMTP id f7-20020adff987000000b0033ae7deaa8bmr1508064wrr.26.1707498309451;
        Fri, 09 Feb 2024 09:05:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUL4NavJtL5JVa5Qyv6YHLP16s54U4xbfNKAHPk4QSUTjHRZVC7rScJU2FPwmIlt5b5HX+LCfOT34/72Q9ciLLpeaEVxL8z/63tDftL56fqTjsDzwzwsxM+iS1lUHZau+4yGYUkv+XDo762sSc/3MQxMQ5D0ilM5MW0hgWRBglOy31oJFFWTMnMF6SkJCf9copIVlu0I3rUm5CSFm/rzAEogw0wWxINU2/ly9Qpl0O3lkygYzXQpUGpEXQb8+MyVWTeI94r22kUn9+84bXezFq3HEc6y1fzHZxhoWLC27uKfqO6GOK/gDoRwy7Ue+KEw4ZmJ826uZE2e5Q=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:08 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v2 2/5] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Fri,  9 Feb 2024 19:04:56 +0200
Message-Id: <20240209170459.4143861-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Keep the reverse order of operations in ravb_close() when compared with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes in v2:
- none

Changes since [2]:
- none

Changes in v3 of [2]:
- fixed typos in patch description
- collected tags

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a1bf54de0e4c..c81cbd81826e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2321,6 +2321,14 @@ static int ravb_close(struct net_device *ndev)
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
@@ -2339,14 +2347,6 @@ static int ravb_close(struct net_device *ndev)
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


