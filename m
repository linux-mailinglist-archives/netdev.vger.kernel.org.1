Return-Path: <netdev+bounces-148217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D73459E0E2D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 22:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08892B38038
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 21:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8811E0490;
	Mon,  2 Dec 2024 21:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ7cqSFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BB1DFE35;
	Mon,  2 Dec 2024 21:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733174623; cv=none; b=EClh5lPt257OmjigJh7jG0pgCgEA5EBHoINImRmNXX3nzUQhzBjras4fOIh9VqdjW+btcQw5Xp3Sgi3EsIzSry5DtsLLpiPeE9TpcD7dMOXb4LXaJX3+d7qPM/194ZmlLwoykvpqI1ZNStGa4KB05BPJiqnKQV+OaO6gz3U2cP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733174623; c=relaxed/simple;
	bh=iRjLNPgDmXU0ZuDDvgb0y9voPktGU76lk4ona35Pyow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smP+26PCnGda3MShdFUYRT1h248itRTJq+VLa+G76Waw/Wc7spSWCx9KNzJEcKYSRFBCOZOkbkrC9Mh9jrKcyLObgJrbpNpAxaV9eBYAreT+bNUBTATLqty51bg3h5pJvOdlDHlu9h6Wb0TWyj4RXSiavcXq/6RFWYiUWnQREgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ7cqSFw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2127d4140bbso44642445ad.1;
        Mon, 02 Dec 2024 13:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733174621; x=1733779421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76UHKIQAAAPA6JLZt0grZFCa+jWHASsY2aHAhp9vWZ4=;
        b=QZ7cqSFwXMuWlKZvXmLuw6z6rM+3PXp3RS0GF52oA6q/L59RAQBZhJpLl0IzP+WQJu
         dCjYwi99xX7t9o2tNVF3h8CocnxpS0du2M5GnvtzFRSeWjicjc7bBCaRazprVLS5ih4F
         iwDD1qsBWR02znxtnIvY1MFU/sXJ1pIXX0aA9JfekrdicdVAiQYI+vsG1ib7KKwkJbb8
         agiQKnQCe1AOz/DpJPd8Uxquq+mXuYDHCX37AAgy/mzn83IQE8sclgEwy6NR0ogZsVgl
         K1vCSHq6+91ijnRGTqMDAh1ZjBVJOA0bICptJ2a0nqRtj1hvNr9bKsp0aWUQ9u2PcNOO
         Athw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733174621; x=1733779421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76UHKIQAAAPA6JLZt0grZFCa+jWHASsY2aHAhp9vWZ4=;
        b=pFcQfE/dwuCQYGJTAoz3Vct4/TRFX4Zo0txuZe49BfwPG/6WzOEde18kPab0De/FoZ
         EFuQtsX0xe2hQk5nOd5XW2Wb128T6k6ULi8Tx8pcl2BNHAuxoGH/BvQdW1gcseIsiGnh
         PwHvBF+u2PmE1dn839xhPc9f+BcRpr2wLgjCkDgngKkmP2qqk6YQSJMBgksfnF4lgtX/
         tCoixwQ6z/+CZcybw+Smv+HPGyEPFSN86GoPw96lnFj6irtfSHrDssqoEsWO04FRwz43
         yzsCbY2j7z0RJ+qi4XjiUGXS4Oi0/Fx+jlriMtl5aqo7tQyX0zyzDabU7N2ci5LBdDQR
         CgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxczoZUwSa2w5kTKnC3GiGPgTDiZV1zEcmKJpfiwvTlmE0x0slFmnzRazGL+nGrARSfFit8aNmEmagbfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBqlk2jbfAdAFeQ/bpCLhBjbfz29U6NLwVH6fSQSHz//02IkbR
	4c8jt+99jOeFfJnMxElateDAmWrauPkW7u0RCM9j4shqr6JsKfWR35UbjMNi
X-Gm-Gg: ASbGnctGaFkD3njr6CtpCKMD4EcnyNQmq4fkzAlzisY3hlhP1SKp2X0UZQpfyFpRUNT
	P2Yi2eNgFXiiH7tUPZJDR/pYZbJGO+OFtjh7n85egNpfjRUEflL/yWdbvonkXEwYEstk7jjRRQ3
	QB1SMS3se5mJUPlRJ7McrH5YnPc7PEHeDxuBacFRxnXitQoCPZmwfZ2g3EoVXx1JhMT8RAQRmYI
	D/6hK3wTYV4ZG9XucOOwV/TlA==
X-Google-Smtp-Source: AGHT+IEDtBbIuru+g3X+1c/jZsmy2wYOm/dIW+uoYt3RRTsLQW0OQFcVMZ43qbOl9sGw66YOPv9Gsg==
X-Received: by 2002:a17:902:d2c9:b0:215:681d:7a52 with SMTP id d9443c01a7336-215bd17a76cmr360175ad.55.1733174620944;
        Mon, 02 Dec 2024 13:23:40 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21598f3281fsm20729515ad.279.2024.12.02.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:23:40 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 06/11] net: gianfar: use devm_alloc_etherdev_mqs
Date: Mon,  2 Dec 2024 13:23:26 -0800
Message-ID: <20241202212331.7238-7-rosenp@gmail.com>
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


