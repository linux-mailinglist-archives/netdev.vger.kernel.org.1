Return-Path: <netdev+bounces-70587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62784FA96
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494AF1F2962D
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE084A44;
	Fri,  9 Feb 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I9VR92yd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411780BF1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498316; cv=none; b=rvgNhfas0y+iVgk8pK1iQbmQ6+QGiDfRuNEdRAQtN9FjqC4FhzAQY2U4cTMG5lXtCwEl/xgJBN2c64bPIvAaXPTU99n1L/XMtSJk45W45RhwGks0/yuoXAnS8GrRVL7UAWvYSyWNB04ZiRt9/J8/lbj+kUS3H9HQRXNbFwRQ6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498316; c=relaxed/simple;
	bh=Iko31EmtrFT0a0Vf7Lv+AOwIvZiu4+osFAFWG89yDtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dvG5lvi9DvxA9Fxl6qaLkIGzBfuuoV5XVT/h1PqtjXyQOPBBGHDAZfSkDvzk+o1eWDYsI6yPto2xjd9C37qYN8uvbdGRsT0H50K73us0UztQ/ny/jEtPGQZ5Z4Az5cJylnWCeaVnQk2zkL4AXjwDx7zbGVNcLJtKy7YAlCR1FpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=I9VR92yd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b671ed002so366437f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707498312; x=1708103112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geEctI3jAWOmh+DPS0zOGyuq69MDOHJs/LeL0ZEzs9E=;
        b=I9VR92ydaA20CdS51Qgnext83aZTOe3U2NoX0yS4OvQsyBSUbhcO4YvVDBm5HgtOdD
         XjPHT5HVsoJS5AKxawVlA1EvsZL3E2pp93y7tePxM9G4vNUwGARBbK/P4UkUJ0opX0ML
         Ciea5qDDT+DHGAvsEftOG4Ey4XaVmLGiAJODOMeHIY861AtTQNAIWOtzxxSHbu0yg/wG
         V6tQL65SxbJGlIVeHYFCvlK0Kd89fLyrhV48Li/10uANwXUfYInw0fermDHXdIxKmQ54
         lnkd8z5VqqUKZT9x5ytU6+nwpnwDHKuj1A+RTGGpARY7ZAtm3bS4c/5W/j5YDWFjlECw
         QhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498312; x=1708103112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geEctI3jAWOmh+DPS0zOGyuq69MDOHJs/LeL0ZEzs9E=;
        b=YiSH/ZJY78ija7XnFgP5udeTVEf+dkZ5FtGhsmQbVkl6hSqYieqOYHcr6t6rFzsvFa
         DsZVUMYzfTL3SZIsonJ52E9GeNh9WQbHMvGl2g1pH4lq140valGMLo/gzwpVnq22DqFE
         dv1O3H79jTMQ8t34S/Fef93O3so1vJ9SUtA2T3lPmdzgqBoJvAiRbto9J2weIGKNoI2I
         0/ZHII2efm+nRwXsr9e6L+EuRw/Y1JNtlhZTuIH4gmLJ+elB9bTJyHOwPpvVrXvZ074s
         FXn307xTsK1R6YCBtwstB6mekiRz0+0/HTbuPaJPyLLYB/YOj4diO2eG3loJwpZQVj/1
         QqiQ==
X-Gm-Message-State: AOJu0YwPLDFj0JEwc7cc1oiqj4AKJ/iy5xVYSG4m2uIZqK3P8+fjMQHK
	Q0q4JTnox5H6WKQM5rlv0alMV+7//COk8gs6gesUM66R2jpQ3GWyhNRRUCEvqP8=
X-Google-Smtp-Source: AGHT+IHGDrwg2I3LgwpKOO6wvnvaYMaxZe/nShvFogWyG63q6Yt78Kqcm6Pl9HPaPbhK8s0To6KxcQ==
X-Received: by 2002:adf:e743:0:b0:33b:4967:4d2 with SMTP id c3-20020adfe743000000b0033b496704d2mr1660714wrn.41.1707498311891;
        Fri, 09 Feb 2024 09:05:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd8zxXd0rM6pvBlpP/uV/+a8KGsTugrcQTnPU4iOwRPDgTMDAa9tUnAZGrems6xZZ1MgjrXeqNQh++MB+vh28kJkD4F03MObu2ymt5Rl1XXTk2Rf8h+3OiJEn7Y4rrw8hh6QoeUdn3K5LiEVzs+e7zlfCczdcTo+5FkiTsj/fZmCBiykEyMHl5R/8bAfL7ao1lkUVcItUaX15yB10h/Xllg2YuTBEAy5x+LSln8bpxbnj9adz9oBR2G1vyrZtDtfFdoY2X3fiadO3vxQ+cFfUZP/EiaQGIC/kPI88aeqvT0092AefdS8b514en7xkWQXhwxjAbKYKnb2U=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id j18-20020a056000125200b0033afe816977sm2254998wrx.66.2024.02.09.09.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:05:11 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum settings to hardware if the interface is down
Date: Fri,  9 Feb 2024 19:04:58 +0200
Message-Id: <20240209170459.4143861-5-claudiu.beznea.uj@bp.renesas.com>
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

Do not apply the RX checksum settings to hardware if the interface is down.
In case runtime PM is enabled, and while the interface is down, the IP will
be in reset mode (as for some platforms disabling the clocks will switch
the IP to reset mode, which will lead to losing register contents) and
applying settings in reset mode is not an option. Instead, cache the RX
checksum settings and apply them in ravb_open() through ravb_emac_init().
This has been solved by introducing pm_runtime_active() check. The device
runtime PM usage counter has been incremented to avoid disabling the device
clocks while the check is in progress (if any).

Commit prepares for the addition of runtime PM.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- fixed typo in patch description
- adjusted ravb_set_features_gbeth(); didn't collect the Sergey's Rb
  tag due to this 

Changes since [2]:
- use pm_runtime_get_noresume() and pm_runtime_active() and updated the
  commit message to describe that
- fixed typos
- s/CSUM/checksum in patch title and description

Changes in v3 of [2]:
- this was patch 20/21 in v2
- fixed typos in patch description
- removed code from ravb_open()
- use ndev->flags & IFF_UP checks instead of netif_running()

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/

 drivers/net/ethernet/renesas/ravb_main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7a7f743a1fef..f4be08f0198d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2478,8 +2478,14 @@ static int ravb_change_mtu(struct net_device *ndev, int new_mtu)
 static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
 
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Disable TX and RX */
@@ -2492,6 +2498,9 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	ravb_rcv_snd_enable(ndev);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
+
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 }
 
 static int ravb_endisable_csum_gbeth(struct net_device *ndev, enum ravb_reg reg,
@@ -2515,10 +2524,16 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 {
 	netdev_features_t changed = ndev->features ^ features;
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	unsigned long flags;
 	int ret = 0;
 	u32 val;
 
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	spin_lock_irqsave(&priv->lock, flags);
 	if (changed & NETIF_F_RXCSUM) {
 		if (features & NETIF_F_RXCSUM)
@@ -2542,9 +2557,12 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
-	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
+	if (!ret)
+		ndev->features = features;
 
 	return ret;
 }
-- 
2.39.2


