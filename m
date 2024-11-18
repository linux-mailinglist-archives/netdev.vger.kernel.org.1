Return-Path: <netdev+bounces-146007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 851149D1A97
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 22:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118F0B216AB
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE9E1E7C29;
	Mon, 18 Nov 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfZNILUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653E1D0DDE;
	Mon, 18 Nov 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965241; cv=none; b=Ep6FohGFON61htI/bXWHuFb/cu3tdjI0WNePeMjcbBdoHPJKj+CfKMg6lPktP5YghyLmP8JYpouJfEI5hWsRj29FoIOZLk/37dwQapuNLMHizXB9Vb1NWdCGAI8kB0D8oHcHlPITlhuu+8DfLb0SpWG6frv2BFrYE1Hn7NPnSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965241; c=relaxed/simple;
	bh=iRjLNPgDmXU0ZuDDvgb0y9voPktGU76lk4ona35Pyow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cncxy+w8WQz7X8VWbWXPZogu5+gW9NcExXLpEFb26rYV230yjk6sF6/CrlzZegAOJXukilv80Bi16SXJs05s/e9jAildfUycsp4dT1eMerfCLSgtJsZjqbMvsyOOw/CfTnC7TJapMTHO5nj7HVAWd2LwNeu6QbPiBiJ9DFCfezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfZNILUX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so21043495ad.0;
        Mon, 18 Nov 2024 13:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731965239; x=1732570039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76UHKIQAAAPA6JLZt0grZFCa+jWHASsY2aHAhp9vWZ4=;
        b=GfZNILUXvwoeO7v6EqfM0lbe0atQLQ+y8G3vsCg24k1QTqojTUg/WQCLU1LGhmPwaK
         wWuH/jvkCPK4Q1W65u59E7ZgGubG4uEHeZwTjMIfrLguepg23VqeTlniujXf2aPsSehg
         2A17PUyHhHPTKkoOcpNKfgcokE4wcEHUkto9V8VMHw/FbbliG3oUNf/uYRyRosQ/7Mng
         i4C3Q5ltnBhEQkm7XnWOoeaXE3Ql64ZnMElUjWws/7B1jZb42PUAsX2i0bCnMj4ASYtT
         OvldE0V3Z7uOk/XyaU+E8rj0htl9wQ6hPJ8bqBZcNs6/F39S9PxjG58gG9dZPzzfVUfK
         ORog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731965239; x=1732570039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76UHKIQAAAPA6JLZt0grZFCa+jWHASsY2aHAhp9vWZ4=;
        b=g+nnMeKMUGsv5vM0JAtk5ws6s+zDXdFcwCN/Yw4dO5hahHoQqN2lKjHPFNAT/rIPiB
         x1QeB9V2FBTB2s2KqsU/8bXFsRWePh6YNdl/yt6/6zhI/NQRs+y4F2/t9HQQhALyAFQm
         ZQ0bgBfRrHNIZ31kpvVheZ4GShiMJZC1fcU8bnVAG5upgCbLMI20DsplfOw4vBgPpB4O
         vtBmVBcEYUGIGcbSTfcbp6veH7YAmF1qTw6TFKJYEHF65MzHp8y7oqk1JdgS60Txlc2i
         vWiWLQTuJJ/mwF1upaxkcoOzR3dXDNd76WNlc0epRI7HAD0ZJGlDGTBKIDOBep4nDv/h
         0pAg==
X-Forwarded-Encrypted: i=1; AJvYcCXF77TwxCH8AcKbzsQZ6RSu9WgfC/B/JZkeqk2tGSRK5BjhgbIj1bicj7Q0y2yeteq0oyrwrYDkINwARus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNOxESBT5x/0ODDHPnxtwYaH67j1hA3gPCSqIveoBTWa4aTZw
	FAhjidRb6lkCLCCy4CGH3IVEMfruMNF9GDwEm+ERjHGFQriF3BECZgRyYWKZ
X-Google-Smtp-Source: AGHT+IFg4p9YzBLZWC1HdjgW8IYWRqrj5X6VXoRC7TGMmA3DT009mgnm8Fq/+atq9J8UbUJg+ISmUg==
X-Received: by 2002:a17:902:d508:b0:20c:5c13:732e with SMTP id d9443c01a7336-211d0ebf9ffmr207065895ad.38.1731965238751;
        Mon, 18 Nov 2024 13:27:18 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e4c48490sm50681455ad.38.2024.11.18.13.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 13:27:18 -0800 (PST)
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
Subject: [PATCHv2 net-next 1/6] net: gianfar: use devm_alloc_etherdev_mqs
Date: Mon, 18 Nov 2024 13:27:10 -0800
Message-ID: <20241118212715.10808-2-rosenp@gmail.com>
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

There seems to be a mistake here. There's a num_rx_qs variable that is not
being passed to the allocation function. The mq variant just calls mqs
with the last parameter of the former duplicated to the last parameter
of the latter. That's fine if they match. Not sure they do.

Also avoids manual free_netdev

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/freescale/gianfar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index 435138f4699d..e486b77bc6f4 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -475,8 +475,6 @@ static void free_gfar_dev(struct gfar_private *priv)
 			kfree(priv->gfargrp[i].irqinfo[j]);
 			priv->gfargrp[i].irqinfo[j] = NULL;
 		}
-
-	free_netdev(priv->ndev);
 }
 
 static void disable_napi(struct gfar_private *priv)
@@ -681,7 +679,8 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 		return -EINVAL;
 	}
 
-	*pdev = alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
+	*pdev = devm_alloc_etherdev_mqs(&ofdev->dev, sizeof(*priv), num_tx_qs,
+					num_rx_qs);
 	dev = *pdev;
 	if (NULL == dev)
 		return -ENOMEM;
-- 
2.47.0


