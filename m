Return-Path: <netdev+bounces-148218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95C9E0DC5
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8671657B3
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33681E0B67;
	Mon,  2 Dec 2024 21:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4yCCVkc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433C1E0480;
	Mon,  2 Dec 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174624; cv=none; b=NK2IfqCxWzTlNX0VRdLT1+MQ9fhCpbBRrwRMV0T3qETBKOPWDEmjNwuLYB2QIl3SuCas8u9uefQCa8eHs+FZjKj11DVLlys4sJxwkuwYq4cx1stJR+xYBa30xl4G8e6mpND8ZlxODVFu61GdBY3q5aMUWn2jBdBxxTvdlGOL+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174624; c=relaxed/simple;
	bh=IXcltZehn2/3SyvTBeTFQotnSCT34NjXj0QE95LAAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0WSQKILXhEtCOcgSIe4ZD7e9HK5mDX2xltOnlY3U2i0tGYDiotKzBljQJYpb8EuhSDyy5xk3w647utSsXHXH89raFMh8ZvCbIMXotMwMq6bkGt4PGCCzH17d+Y7sv1plUJUdFB8PChlPv9xftZ4jVSlr3GjsI80y9NQyKn8QO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4yCCVkc; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215b9a754fbso1507975ad.1;
        Mon, 02 Dec 2024 13:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174622; x=1733779422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OGc9m7b1KRhFbZ7uSZDHwwlt5GMFJZQQcjtXg4RTOY=;
        b=g4yCCVkcCttW5YU6aL5PwYAYMPg81HBwCQ73eNm/BRrxNLX/xIy6MM2E+BtWYu8jM9
         AnPu0pkda1gxsM8pdgBLIaNNPyA/TejnfU2MNBCA9jToxFD1oW0YInZeS53Yn0mpefDK
         kitrzR2W/gKJePPS4K7w+3Gi4MXFJ8Q0ThJRcau+wBjbucWNptx22UH4IQWNjfTYgf5+
         a6Y7KCNr4zL9lNvdg0/AXfp28VYnDRlLdlypzhxRsMKXRgDU+bupH6KP4azWyrHlfAB6
         bH8c5PTFMybVC+gN5UxHVWLLWJytmQOpgBgKPF7EoqBH9AoOeEj9K6uNKuLPDXr1n4Ny
         WwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174622; x=1733779422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2OGc9m7b1KRhFbZ7uSZDHwwlt5GMFJZQQcjtXg4RTOY=;
        b=sNGdPZsVb6kg8aCJ2b1nFYJStwT6PIpJydJffO51+667SpBNEp7adzmDZypJELIct/
         gcoSVb5ulDvqjcm3hfYvEmfoa31r9XWPGXgirQE7mZqnpTcEUS+oxI2An5dM7Cel6bT9
         qDHrcLTbFWAXZouS8fDXLZYFzkVjolzlqL2U1rqHkJXTNm01e5bHU47m0FyMAxwdEM+l
         l3mtsrpfgI6pW8yCmlmR7NyYm7C6S5L/ULFEZFwb+x0Kr+X1YOjIN9OIUMtLyl3dGYWU
         h9/lDkDU2Etd6gQxNXbffG+YdfRa6QBax7dD5omnJPl9oZ0tc6KZfH32wjKta5zxwwdz
         A1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4iDTS+GSnqxLFjaxzbLEsgJu9HzclrwoKs9yhuL44PT1iBIE07isjL5WSwpGGHr2LSWnScrQEbWSY1n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMFp8XULh9anU7wBeIhBZyfncfYnd9egML1PliBHy6+bDGuiE
	ngkb13EWDdULQdZK2kUIB0/7f7x7KuuuKk+Rk9Lm3IrQNvxjNlwYZN7e6GVS
X-Gm-Gg: ASbGncusaFRV7Ym0aORs4PAvPG9lWbte4ZQTM8RWMY5Piu2r+JHPUilhSySYrPMI5GJ
	8mBl+kOgKotDyyxh1ER6QcBb0VYIpc3ixm9GqxWhe6vbhqTkNx40fwAZ8NLfp+LHT4n0SexZln/
	fKNVRY3zg5WduNeqXcsy0IGV+m5mx3RKqY0JAcZ2FKea6LdTjZIyuOUtBc5CbSZwpgwZ2y0KOEr
	GjTeTAbpqIsGlVW68yUWOR8RA==
X-Google-Smtp-Source: AGHT+IH8hjNECaWA7HdBpu+vfjxaam9yKVKhbl1rSKe8TMovwBq6iDjlz0SSZbFtgiRYxUzjj5zK5Q==
X-Received: by 2002:a17:902:cec2:b0:215:b8c6:338a with SMTP id d9443c01a7336-215bd1b4373mr290205ad.4.1733174622249;
        Mon, 02 Dec 2024 13:23:42 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:41 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 07/11] net: gianfar: use devm for register_netdev
Date: Mon,  2 Dec 2024 13:23:27 -0800
Message-ID: <20241202212331.7238-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241202212331.7238-1-rosenp@gmail.com>
References: <20241202212331.7238-1-rosenp@gmail.com>
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


