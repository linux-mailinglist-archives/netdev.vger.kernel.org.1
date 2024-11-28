Return-Path: <netdev+bounces-147791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70A9DBD4C
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 22:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9ED281B67
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC081C1F34;
	Thu, 28 Nov 2024 21:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lha52pLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195513DDB5
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732829116; cv=none; b=UtzMLP/yEsShrvSh/nvyfwxuZdtTKH4iyloB9aEALDjpUjQMHwrIk3FkobycEXRFfqMSU4khVmWR9ZZ6a9hBO1KtCjgigO3sosNaKiwsFlLezoJ3JU4NizG7hbLxaNl1uYSHk4ulnjOHgmzHBq4yTSaJe16hFEYaT0VLl+PF9Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732829116; c=relaxed/simple;
	bh=o40S72OmXWEYBa1L/VhS3iN74SBct23b1W/y5FnyhIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X0+llyslWmBLZWq2DmgG6sxh1E6W5SBR9bC3ofDXqdizXxp0XAYbOllOKxob9gRZK7MlErNCw8F0RdGNiDeuP3CrN/dVOixOvyOpa5Yl61L59wsFaxzFCjFHyVnj3bo4WJEHwgrprTc0u4VX9wLi1IEasdfw6d3MpWYzcU9NAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lha52pLn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385d7f19f20so252435f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 13:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732829113; x=1733433913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MnVY+LHRobNXhxM8xyMKF5ThUbcm0aAhgQh7beftfEE=;
        b=lha52pLnXT+rPgY4yIuupWGT9REZi060NFEMyhj7HQp5zOx2K9+uWShM8JYan2j7Qo
         95/6R2gV7r3Z02MhCzcE015HVOC83/vCEXooko2njzuZlKNJwJj1XoJWvdMfMCwzhMiz
         l49BqhRN7GRlJRKnapEcTyCEN+EvF2OjMbiSaoHGOhGOFv8TKAVhJRcH40iEqw5ROqlq
         TvInXprknF+Q8B8gRVv72JJAV2O2RpphxsLobUEbWD130HyNQGD9pCgDhQ9WzTHFeg5p
         SiOpmpjQuPPO5c/Wo1WoiDOkM+GigSs/jKQZ62wnDbKj70Gz116GveNNMado/j1Sb8UI
         AnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732829113; x=1733433913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnVY+LHRobNXhxM8xyMKF5ThUbcm0aAhgQh7beftfEE=;
        b=rip8wcWZF30YEDW4dTXbwKG+8+2R7+u3nxuB46FltW3igZaS+q3TaH7Hii/qNnyt7o
         kHuof/m1mtJFpHtXAdBVwSs8xsrwlNffoCQE/w94437r+NaBt05NUPAQQKVLFBRiPBDd
         LQpryAO2T+K8dTrDnY4ebb5LW4ZpOvpWXejK3yfePt9i4dVRKRdr7x9VhgODnTz6BfVz
         kkS2tZ4Eh2StXr4uW7sN6Cqs9ouBon7lPj/xIK2Xqtr73jehR7YX/uc9pgL+agJLPSyd
         YWKZfEpT0LIXTvxk7E6JjGy9LJuGUYwL4yW7YyIJnwUDDT6uAwjNDCAe0Kzt5axLpJNC
         39RQ==
X-Gm-Message-State: AOJu0Yw1r0hDxrlh0wOK+FkOQdfSdG6lG67P6PMrZ39bYRa5Xj/KiGFV
	mcwu2eYPZazsZJ/l8jBSHAIl6ULQibEaobJbbJf8/1XgQr6q0YEX6XhYH+Mh
X-Gm-Gg: ASbGnctQWzftPwHYJ8fNfrkRCYnYxolTxxsdmto5RYMUJfThOC+KeekBedOKjpTz9ZW
	y61HYhFOMgilPhr4CrALJj2cYuEWfpdX/tGhFNuh+FQgnIkq1Juiwq7zQhOpEo90auJpH78U51m
	ShLgaXyFUlFwDctGOGIztU7XnXFi7SPFBGK2v+zbMYyZbItdC+c58wNmxD+BN7+zc0/Gg+l5euF
	C/E35EQnpW8OLFwvPLYNwGZNfOxnbiF2Ep6MT1ullJ1vzlaR8Uy53vDbYRR8zs0TWRAIie4E0nP
	+Y0kIPfekIo9c6AugEJ+7GnvpKHXPGiJaGwe5MzFwzASNg==
X-Google-Smtp-Source: AGHT+IHouAi0AKWoSEQUhlKkIB3m694WgaqB8o78RacWlouZFKk7L/3NIoCXTpISRAxx3tt5YLQRkQ==
X-Received: by 2002:a5d:59a7:0:b0:385:d7f9:f166 with SMTP id ffacd0b85a97d-385d7f9f21emr1519512f8f.17.1732829112513;
        Thu, 28 Nov 2024 13:25:12 -0800 (PST)
Received: from KJKCLT3928.esterline.net (192.234-180-91.adsl-dyn.isp.belgacom.be. [91.180.234.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd68df7sm2641903f8f.83.2024.11.28.13.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 13:25:12 -0800 (PST)
From: Jesse Van Gavere <jesseevg@gmail.com>
X-Google-Original-From: Jesse Van Gavere <jesse.vangavere@scioteq.com>
To: netdev@vger.kernel.org,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: [PATCH net-next v2] net: dsa: microchip: Make MDIO bus name unique
Date: Thu, 28 Nov 2024 22:25:09 +0100
Message-Id: <20241128212509.34684-1-jesse.vangavere@scioteq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In configurations with 2 or more DSA clusters it will fail to allocate
unique MDIO bus names as only the switch ID is used, fix this by using
a combination of the tree ID and switch ID

Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>
---
Changes v2: target net-next, probably an improvement rather than a true bug

 drivers/net/dsa/microchip/ksz_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 920443ee8ffd..0d5dbbdd41f8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2550,7 +2550,7 @@ static int ksz_mdio_register(struct ksz_device *dev)
 		bus->read = ksz_sw_mdio_read;
 		bus->write = ksz_sw_mdio_write;
 		bus->name = "ksz user smi";
-		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d-%d", ds->dst->index, ds->index);
 	}
 
 	ret = ksz_parse_dt_phy_config(dev, bus, mdio_np);
-- 
2.34.1


