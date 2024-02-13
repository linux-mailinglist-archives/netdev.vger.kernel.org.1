Return-Path: <netdev+bounces-71239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D12852CD2
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBE311F28368
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C23E47E;
	Tue, 13 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KJfPgRHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E439AD0
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817307; cv=none; b=oae82GIH+JuuXFSslLLEsHAIKzwud4cgO0hp7c5P9CHeHP5ananiYfwaQUDC9u0yo/Hh6MNNQDhQkYBQmjmnWcGHZB+x547u3+ImZCzTjLdrCFpdGZh7C6mlN71dHYsOpqN33Ga53zMoxuM3Bej07hyQihSx0q9+POJ5R+S12Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817307; c=relaxed/simple;
	bh=enmy+LoY5r8g/P1HcJj+4PzEb3nLIvXmdJEA1A5e1ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzMidNP4T3wQ60YAIVSHU/YdslatKZaDoA0CSlD86xHBynCwemjedeLW+pffVkx6r4SP660CDP1b/cwH3ajYmuzlg30KsVxnpkhzna9+BVxY/2pIzfAV0pQhiKljYRBmTZ6qapMIt0Wo1L7+Wr/UUwaiA0nUnUxP9XNfDOl0uLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KJfPgRHL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso2338901e87.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817303; x=1708422103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAa50mXZbPqqgphxhzpCHoCd19uwy4xnnSSFW1+XwKE=;
        b=KJfPgRHLm9Eq94KaPzNNmX+TEPHUXD96exrxaHIMiQrUYOXbxmZa2eY58kj0aQ35EU
         X+uKVtSHqqW0St7ruKV8XAL5bR+lY4EBPNM8rh0J7R9fUM53YwoKDnk5Jr5zm6UFyedY
         VYY43gxGBsCQ10CC1njy2L6xRdR4gaQzrVEu4ssnSzhw3GLF3xYOZnUXnMywj7HjfkKG
         QCbPjakxCPXdDJzwTEqkyM40+5kKyCajfn2Agrcm+3JCTt50xSlzsRc3eNVLG23XM8iu
         nRKCaVJQghoEcUFLDDobCzPAg0lYUt5n7g3mh0nPrIE81eLVhUKVSnHfId41pKC+0fEM
         1LmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817303; x=1708422103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAa50mXZbPqqgphxhzpCHoCd19uwy4xnnSSFW1+XwKE=;
        b=l87wJ16HWRoQueZ5MB9+w7tUYqJqUblA4taeGNoqE230eAhLpfOvbNdWRNmaf2j88X
         V8GvyJHpV51tIIpz8Iu4PfhGSkk/HyAmcdHvTAfdG2xguz9a8vAuBdOpaK5oq23OFcnA
         Oy1EdBo94pvf4XDY8SrsDUNXGyMgUNzVXzs3yL9k4IjkmDqvxoIkZcQIB9oVdczUan7J
         ZxdiCbaUOtZrp437ikAPkYmOv/HB0AlnsKa601Cs36uVKRNlrVibg+bfKNUbnmQ2Twal
         oRS/ocA/5CtcHBbowZHlk6xRJfPF3qxTUUi0QxiaEUNlys+dLQiAek0fehNds5WoJZRV
         X8Tw==
X-Gm-Message-State: AOJu0Yxa6rH5ddsec+GusPQQIVbFoVBGphY9Fi6xWMTvcPAjQ0YmMbiN
	RITjScopioqVZGs2E7YY458drEwu1Xpd9h/+vVX247fq5MEMCq/PEctJubrzX7E=
X-Google-Smtp-Source: AGHT+IGNd5nHQ/HEfCk+VJ7X1s78HVrWAJaGoFhdToWwxTcZsZJ12WqoGmgoQqhHUWtI+Wr1HyAvVQ==
X-Received: by 2002:a05:6512:49e:b0:511:4ee3:dc0f with SMTP id v30-20020a056512049e00b005114ee3dc0fmr5561325lfq.19.1707817303330;
        Tue, 13 Feb 2024 01:41:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW69Al/3XiflcXDZn21jWBYjJTg/9YKAkSVPu7lcjXWsEFj22RQh8x78vO7ZDXQ2jbkrOg2+H2Jh5cJoPHYHc1gWmn2Fmy3w0baKaxs1oaLpab7PQLXyv8vthemHmcCWqIGDr6FF6lBFIb7DvWYESwnS1UNT00GA0k9KBsTi6QWmNOH9CFVFt8X8RT/jDoJ6Q8jfZ36yOJ5r+EJ47XzX4aW/ykfx3Y3TirLNuMe7uraNmJIN25disnVBZUpPUtbIqOlHes6vKvSHqoTIfkRlMq9GqFaPyD/D2+69D7wmqp1/2Oc9SG4LcLI5lpESA+o9VHA7gYHgo12c+jW3DzcQNrbPsomBPmgT3cZHDH32ar0o5soRVXm
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:42 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	biju.das.jz@bp.renesas.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v3 2/6] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Tue, 13 Feb 2024 11:41:06 +0200
Message-Id: <20240213094110.853155-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v3:
- none

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


