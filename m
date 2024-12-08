Return-Path: <netdev+bounces-149970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F79E847A
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B212C2814B2
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FB514E2E6;
	Sun,  8 Dec 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="EnLovTV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7456814A0A4
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733651421; cv=none; b=unqeHC3AXySPAANoWWZPykwo2/plaKMAy8+8UM/7NfZcOnb2LVxsqJ4j4hyWYiGnE0KzWuYJBOi9u0yhITxE6Wpz5Bt9e1ksEOx5jzAClSLb+z7e4HkJkITYNVbd91hI0niLEYuEuG1XzkHDLsKFqypeqjyYI5eCrWUNWfbnxDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733651421; c=relaxed/simple;
	bh=m3xLhEgvkVumCBPK7rvot6sHsRzw5hUEzzHNk/EM1Jw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBtJWmTa9pl0JOOz1pMpMPK3BqheUPvqYHXRcbX2PWgK1rblLJxjYrLRiRtRldgBGkugiga9X88YUMiqrgYY4Px37CGRS5+/XM1crTQa4Z6EfBeouRKosQhwvjjsdCDEGVV3RbRVmWTogDo5GBQFSMNDpsKniAxLASm4E1qrYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=EnLovTV1; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30219437e63so4465241fa.1
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733651417; x=1734256217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi9ee4q7wG9Z60y8ibg5HDfGF5CuB96sJUYWCS5oeVQ=;
        b=EnLovTV1hVXNz3iGbnvlrJwcGiUA+4QEgF7a76lEXrH0MowfFGGmST3lT+Vg9EZEOI
         M1AdhvjdWrGkXFqF6XebsOe2aU5z1oYHI8PSVanWWqGRXiSbET4iKKLOehkkytNN86QX
         cz3lC87U3WqQDd+aMkjr4EUW39ddEYS2EPt79n9xdRkSBCcsxmvNrEjosq6uyv2nMan4
         j1CwFmcwBvOyK9oU3If5pwoLQKjofhhFWjTJXpGt12v9dKBRh245PaLq4uyCDRADzJtm
         Dmb+cWLBHAMkGd+eJNRyW/pO1KUagLh3vtJFjS0S30UXIACZqSE/GgG5s0TpCdvM4jSz
         elXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733651417; x=1734256217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qi9ee4q7wG9Z60y8ibg5HDfGF5CuB96sJUYWCS5oeVQ=;
        b=C4zwLDyAWlv+Jr5bsG4WDmmdKjmlPcEMKLzIozPfdldzFm7/4sQA4LmWv3lPBYPsBI
         1KGkvxCKSL9s0+s3FQjVHuiLAgSUM9wTyl3bUX3owmxVJwiP+ahqOPLYr/m7p4QwOrCY
         QtSSEoJHv8dUM35vR2gj1mJu7uSq4NYjIH2QVgnbbP9zUlsCH4lTbr+zak8IQrsJyulk
         VQ2CpOqksATmTzwoZ+2MfqHoGHOZ3E+95liaX9W1XXmkFKY5uNnvNHFO6ahS2TvDertV
         m2hFjQHPNvkn6Hov1/DKbzotgQDq30xBNB2i+c15VNs9ZJmfK9Ugqe7UbWVDtaOn4sOs
         nS+A==
X-Gm-Message-State: AOJu0YwdsOIryvuhu50ls89I8SeUJtziez3aBaUp3vRgjkJoAR9tv9FE
	CGrNXy34lT9ip3mfx4ADahxMS/1noHd8v5TsZNJcAOT/4KdMOEHflm0nB86KjnM=
X-Gm-Gg: ASbGncsC1z/TZxUB9THOlxfNNOhA+M+SOgVEtj0/nbQJqASHvfRNpVEbm9Bh1ThzSpl
	BvpXlrSKMPC5to6/DJuTUxQ9gIYlLBc08jGfDFhmE8u20rjGgHqlar00ZT+HItycGwnPjG5HUbb
	rPfuMH+M96c1aoQm1dANFq9I6HT1lP71ucMH8zBy0b0ojznEVEliojRNw6a/dxTjcexPIHAkhhu
	cMFG1AnYr+smgOUFRdJ2jV3ww4tofDrNwNHmrn1suCc7LI3MrItfo1pHXYR34t8
X-Google-Smtp-Source: AGHT+IGMZmYJjHnUsc238RV3yY9xHt3nqaPN8mYEXiS21C8jUq0UJbg1npLyXNDZJfghXQMbM8fRmg==
X-Received: by 2002:a2e:a10e:0:b0:300:11e4:ce2d with SMTP id 38308e7fff4ca-3002deff095mr31481261fa.20.1733651416628;
        Sun, 08 Dec 2024 01:50:16 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30031b80e7fsm6645311fa.120.2024.12.08.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 01:50:16 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net v2 resend 4/4] net: renesas: rswitch: avoid use-after-put for a device tree node
Date: Sun,  8 Dec 2024 14:50:04 +0500
Message-Id: <20241208095004.69468-5-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
References: <20241208095004.69468-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree node saved in the rswitch_device structure is used at
several driver locations. So passing this node to of_node_put() after
the first use is wrong.

Move of_node_put() for this node to exit paths.

Fixes: b46f1e579329 ("net: renesas: rswitch: Simplify struct phy * handling")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index af0bc95ad6ae..3b57abada200 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1891,7 +1891,6 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 	rdev->np_port = rswitch_get_port_node(rdev);
 	rdev->disabled = !rdev->np_port;
 	err = of_get_ethdev_address(rdev->np_port, ndev);
-	of_node_put(rdev->np_port);
 	if (err) {
 		if (is_valid_ether_addr(rdev->etha->mac_addr))
 			eth_hw_addr_set(ndev, rdev->etha->mac_addr);
@@ -1921,6 +1920,7 @@ static int rswitch_device_alloc(struct rswitch_private *priv, unsigned int index
 
 out_rxdmac:
 out_get_params:
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 
@@ -1934,6 +1934,7 @@ static void rswitch_device_free(struct rswitch_private *priv, unsigned int index
 
 	rswitch_txdmac_free(ndev);
 	rswitch_rxdmac_free(ndev);
+	of_node_put(rdev->np_port);
 	netif_napi_del(&rdev->napi);
 	free_netdev(ndev);
 }
-- 
2.39.5


