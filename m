Return-Path: <netdev+bounces-71676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEB854ADA
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10431285EF9
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8C55E69;
	Wed, 14 Feb 2024 13:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JRXYa6Nx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144454F8D
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919130; cv=none; b=PGpykt2665KIzLgZ7U+5vPvEurjq0DLlMXbHO0YHdrEIuMWt4hwFEqGlM6vljNLo5d69e/vV14IO/VMmfH1czUR7Vvg7YTPLIzLqYtQLjnDfbw+Bmc0/l3DjFSuzQlwqHWa4Pi8vNj6jj7Q1CHF3cOsQqZLsV53ggk7ksXuFUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919130; c=relaxed/simple;
	bh=M4Y9mIMWHDIktHdxXrNnI2TKtm/DLPPURoaSoNyE7Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzvMdzjA4t4jRaL7/V+VFICSmFdlL2FTZiDtbW6Cr1RL7FnK7oyN/doPOPule+LPc3mZ4wAPb6u9+qVBgUlKaM2x7gPRoMzRm0fKP5meCvNpvecPIH8RijeQsoLB+6F0EKggpp5aFt0532GzCYbRtGok/10Gyvt+9LXg50AZgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JRXYa6Nx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ce2121d5dso697926f8f.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 05:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707919126; x=1708523926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlR5/FjPjiRmwOAx9UtkAJTic0hke24cfsu9KAX+Hkg=;
        b=JRXYa6NxplIY0Zn6C6eb99PeW+uCn2MHLzr2pAb9k2uJPV7PFP49hZeREemYCOM5wU
         BHl2oXlID3SCi0kPKP8CaxnAez1y8NsXqULEmSrY0Bd8IIfTrz4SJ9MzAKHgV4VO1JXc
         MLYv024l972eFbFXS8AX9FhmKBKWn6q84grcgokn5q3NGuXPOBueFT5yY7r8PZ3kIO/J
         KSb2mqL+HEGI8ClqKu8ege/HngjgSA1z6u5zUsOZQjageTGj7hGkrCFRGo5GLDKDYHaT
         c6ro6m0H29GoFdLvIVyk992nBqDi5TW7nrN+dC+Bncx1NzdXbainSal5jjkLA0GKAQWi
         FqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707919126; x=1708523926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nlR5/FjPjiRmwOAx9UtkAJTic0hke24cfsu9KAX+Hkg=;
        b=FHtJXyN1UJXqxw2lWktLN/3Ts4w1Rr9NwlhAg/NGJJlaNMO3PEja6PiW6Mo+hnYaMy
         w1tY4GPUxwpVFnehBETjtyv5I8MLCos/5dRXfq4MEbqDgj9F3aR+4Ojt5N5o+h7Xr6Os
         FJlKEUhNcioN+t4KcwjgaJMUf8nHZjZVrWcdAF6bzozkYIez3gvSk9zLhhRxc5+O31uR
         VJY04QK7m16dgignrhhKddPpNTeG/or8hv/KmC/tpOewQjsjwomgfjSCFEbwJkNUh8gd
         hhqnJjOH6R3uGdJl7NrdGNAjckjnbAhEsHe9UXnH8vdW5yYkSPFjB7lfjKuY1I314MYu
         xI5g==
X-Gm-Message-State: AOJu0Yztw181PNU5dCVuKqJm0AbJ+X1lv0iaYIYqdIw9IA3ERwMIcBhw
	2bryipDWXRwzZTtOMunr7IFk0jIZilPERSag+zw1N1WbNPRFviXaJgiOCyCzRuY=
X-Google-Smtp-Source: AGHT+IGkgcK49gW8USn9JN9o448EltIafv7DQf/wfSCtuzxO8qlGegPojxeL6/uNdwpiy1ESvjhKKQ==
X-Received: by 2002:a5d:4041:0:b0:33b:2281:ef32 with SMTP id w1-20020a5d4041000000b0033b2281ef32mr1688302wrp.69.1707919126512;
        Wed, 14 Feb 2024 05:58:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUrSz/VkR1W9EksF5qYZeuWWKTpRn1+2yazlR0ERZZdPhFNGzRKAK4T5ZAZD0bghSXAgt6rLFeblkPqt45kaAWuk3z5laJXoMV9Ko20Cp6v+ROpXh+mDqnpDYrqAFvUh76Da0AORwPs7VqoDSDLr+6HygCxHbvIYwGSu+lf2rHFZNvK9Bdgzl88mtIODWh/uUwcIlaLR1C2GCK7Ga6fyeYZ5CALTiBq+HLl09AV/6lYac6rt345JB3ZCoIsCbZO1I4jfE4cA7XZiJW/qUXUmEqdvuZISuJ45pnWizcxHC55djynCQUBAX+6QdSZSamiOLwTuGo8/vb0BZe8hQ7Po9booAItgseBDRkLAsXrBH6rsZtZpFIu
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id f15-20020adff58f000000b0033cdbebfda7sm4282140wro.14.2024.02.14.05.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 05:58:46 -0800 (PST)
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
Subject: [PATCH net-next v4 2/6] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Wed, 14 Feb 2024 15:57:56 +0200
Message-Id: <20240214135800.2674435-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v4:
- none

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


