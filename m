Return-Path: <netdev+bounces-146008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB99D1A99
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40F91F22979
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A31E8846;
	Mon, 18 Nov 2024 21:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3P6DB0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52041E7C1B;
	Mon, 18 Nov 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965242; cv=none; b=mcJl+k+feNFGECMVJewDHQEamP3wHNgsv4KcglGjYW9GuymBg5KqEAENIQkevGSfW67Ojq7g/tPVMZTQ9G+8o2bh6EsA4CicSmenXdbx1rj98a8DW8vtfb+ZLA5Y6IUXzSnuVitvRoNE9d6h6JGQ3BTR57qMHwScg6wQGNU3jYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965242; c=relaxed/simple;
	bh=IXcltZehn2/3SyvTBeTFQotnSCT34NjXj0QE95LAAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vgg+4CAiAemmtmK4YzGsSt7uIlvPxVvp2nw+lHP2EZnn+6z3h5tm4ITRRTiGlW3naF+HTkLOoHgMrIOa3e/2n1n65A+euvX/4Qifbibtu13BC6G7X/x8lSjrznfr4ZsYl1FT7tPn1kksBnrIVV/G3EFg1O/e4k14vmxWR6WpsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3P6DB0/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c714cd9c8so21043645ad.0;
        Mon, 18 Nov 2024 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965240; x=1732570040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OGc9m7b1KRhFbZ7uSZDHwwlt5GMFJZQQcjtXg4RTOY=;
        b=M3P6DB0/2+BJv5YK1lKqAuM3ct9ivnHeqQ165PGkHxupMD31m6rwt2Dv6/ipsTNPpu
         qnIlKyXYOys0PaQxy98Pig+1rav60F5OET14idztb2EW8lzKSs/Dx+hZS7G82e+utlL8
         BYwuSqtyKyhrtHmu+w/502xQAWNaHAT4MkAD018enXnIuJExlsizD/Xkp/Qhd669aigF
         Y2IeXTU7I7JSHrBr28uRWXbNWAJ/W8SH7yGyfcFagLsLdR58lEv2QZvrQ06V7krelxEP
         s3iOdobo+lPBPAnkruner1eKOa6/5eR0RLaPwEWb3M+J/k3QYpUBOK+f7SN9JdSgHYcq
         3d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965240; x=1732570040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OGc9m7b1KRhFbZ7uSZDHwwlt5GMFJZQQcjtXg4RTOY=;
        b=sjSPGarx8c8iGykwA6IM2e8jkAeJz55xN1lO5KHQRmBX6OtPXogCc6vNJw/Wo8PwJ2
         YMddCB4XiYhgukbgXJtOO0FruERspqavJ7AmofrqtBcjwxJ6SN8Kgj9+MUh+z74vy+t1
         0Vnh7Og128NokzGUw1td0YFoA4yhICdEgjJPGHxCbIzwpRkbvtXqhNkoWQudfW67RnN7
         CP7fpgFwQ5eS1CmWBSMg6GKJYqpI+JVY8NQT3EK+rGXPTo9KR+OfqtZoAx9HRFbqpGqi
         PJ0HXglUyo5Icy57oV0NKnrxJoo1Q9IKQaSlkdRCXrrzkyFXZs7VvgYNmxa2Ds6mFqip
         jECw==
X-Forwarded-Encrypted: i=1; AJvYcCUK4ludBPwCzHMCLeB1st6AYx+ZJuutfIFKCK1RSNvb8BSDDvlenOtOtMTObhiF7sUTC1MWqf1F2KYaggQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4SIzBe9lGf34o65OJFjUek/bQHUvwYntnUUGJSoSdRJ/nfk8
	uLnRQMTdX4D/Nrlad0IPr6Apx7J07WQZLCSVQQrCfN+2F4JR/2Narga6cDGt
X-Google-Smtp-Source: AGHT+IEXyChbEnTIOAQHmNvWShE/OZleJ8erpeEtv+l0n5lLJ2/2mXkBv5OURjCEegWUlYwlEb9OGw==
X-Received: by 2002:a17:902:ce81:b0:212:6a4:9b0 with SMTP id d9443c01a7336-21206a40f36mr108779305ad.43.1731965239958;
        Mon, 18 Nov 2024 13:27:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	maxime.chevallier@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next 2/6] net: gianfar: use devm for register_netdev
Date: Mon, 18 Nov 2024 13:27:11 -0800
Message-ID: <20241118212715.10808-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212715.10808-1-rosenp@gmail.com>
References: <20241118212715.10808-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid manual unregister of netdev.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index e486b77bc6f4..9ff756130ba8 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3305,7 +3305,7 @@ static int gfar_probe(struct platform_device *ofdev)
 	/* Carrier starts down, phylib will bring it up */
 	netif_carrier_off(dev);
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&ofdev->dev, dev);
 
 	if (err) {
 		pr_err("%s: Cannot register net device, aborting\n", dev->name);
@@ -3374,8 +3374,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 
-	unregister_netdev(priv->ndev);
-
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 
-- 
2.47.0


