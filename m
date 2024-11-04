Return-Path: <netdev+bounces-141669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFE9BBF29
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 22:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A41C6281EC1
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8331F76D0;
	Mon,  4 Nov 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng2TI9SC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3931F76A3;
	Mon,  4 Nov 2024 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754095; cv=none; b=hsTjFzwdp9v7W3tg5fPpUY4GW6KS/COqOwDnDO/0U3EyxDULg1idIAucgwPa6bveipHwuWFUeWa6xgmJQamTbpd9nZ6FWPPIdwZ0H3JdEKfcMkjckPWeYb65TOJb5uVgZ514E8GFyvM9Ul/8encCZeWWZS35NsQ3WWqWXUaRsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754095; c=relaxed/simple;
	bh=m4UQ3qookCbEq72M72UpvLW2AP94mcUVoh00RXRBfuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9nXOv6k6OPzNEGoB7B31foGsNxr1JteYkByvtyBH95HhIKanBJKKTWK03yDvTNtcZdKuSfnctQJqXjFuqlekGE0Kg3MlRO0oHdCOiRp0HF5MFPJH2y6tGzifI3BXiKCsIa5dxbXrnavHKBay+juUY6f6kR61pLVCAvknurh8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ng2TI9SC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e52582cf8so3994173b3a.2;
        Mon, 04 Nov 2024 13:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730754093; x=1731358893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bIZ8zF+L8MJ4yRKB9h8E75aKwY9cSMENvoX7DOPics=;
        b=ng2TI9SCcNm5vPDJpwe5khxlQYlzvNgAw6IjkOHS/ML0uC8bz3eknwGnR11S9s/s0I
         rDWFlWzXumhgsj3qIkz3CyRHBNzmqH6+lu5ZtsfpiBQ/gosvOfxsdicS3mggzlECb2WL
         LP9WOT4sKj4bOrO627i3HUQrdudMXzDBM92ptMrPtjnBIhtHoOMZy773qjvORIIDRaIU
         O0Jcp+emZfKly2ykv0MVCSKBzr32Wpok9yR3IeLBwBBRExNpy00XYVsAvuExy98jIOj5
         R/aC2WmvnzRN1C4WSBKwb4FVjnQT0FPsLp8/gUbmB0s1biron7AQhpzqwyqiCgVf3JcL
         hb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754093; x=1731358893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bIZ8zF+L8MJ4yRKB9h8E75aKwY9cSMENvoX7DOPics=;
        b=pOD8gAMse2q6YcZG2TmuJyG/qC/ROpLuz2LMxmn+8bBmCuRzwLovlhtuBe/eUZPKpY
         GeYl00k9QYl5nEyKcv9FXj5HPh2wwIWok0qk0Cz0K4ZVBN/uJpbYvP3bvPkT4Li2YlGv
         RmazW0lMBMs6hT26a5kFvORrm9nqTghknq7X80/h5L+3A2+1/LcOEunSvzU7LRWUWXnW
         3B+vO7L3DQ+8bgisNrczH5vSlnNCHddeajQ2i+3YrDZ1zHz18oPGbMLA2s0mhSafwcMe
         4aEyOjiOal6Dw2YMfaW48b+y6gVyaUJSMOfHbNFtUPBRdll4n/k4yJegZovUdJ0rpsf4
         Cfbw==
X-Forwarded-Encrypted: i=1; AJvYcCVay+WGkvVwpw8+sourHuTOvgoO0lIWu2dP3SK7xbGtfYrrhXBKdPWf7bd8YrmRaeYapFd6a4iEL7K9cVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/v2HVzvCzR7emGM3jQrwpc7+CbMOPsG74v10NRTO6JacZkOC
	DtAYYNXmfalHOMjz6LKj61qLkEeum48/cj9DkRfHNrdMs0ejS2N5OulUTZ7P
X-Google-Smtp-Source: AGHT+IHvyohNo16U96R1KwDf+tb8U7yjZoIHw3NSm12/Rem7Lvwp3HRybPvr/i8cZs2/qOPlSvCccQ==
X-Received: by 2002:a05:6a00:8cf:b0:71e:3b8f:92e with SMTP id d2e1a72fcca58-720c98a3b4amr19231161b3a.3.1730754093280;
        Mon, 04 Nov 2024 13:01:33 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm8307755b3a.12.2024.11.04.13.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:01:32 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	maxime.chevallier@bootlin.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linuxppc-dev@lists.ozlabs.org (open list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/4] net: ucc_geth: use devm for alloc_etherdev
Date: Mon,  4 Nov 2024 13:01:25 -0800
Message-ID: <20241104210127.307420-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104210127.307420-1-rosenp@gmail.com>
References: <20241104210127.307420-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids manual frees. Removes one goto.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 4bf5ff5642e7..00b868a47fd2 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3691,9 +3691,8 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 			ug_info->uf_info.irq);
 
 	/* Create an ethernet device instance */
-	dev = alloc_etherdev(sizeof(*ugeth));
-
-	if (dev == NULL) {
+	dev = devm_alloc_etherdev(&ofdev->dev, sizeof(*ugeth));
+	if (!dev) {
 		err = -ENOMEM;
 		goto err_deregister_fixed_link;
 	}
@@ -3733,7 +3732,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 		if (netif_msg_probe(ugeth))
 			pr_err("%s: Cannot register net device, aborting\n",
 			       dev->name);
-		goto err_free_netdev;
+		goto err_deregister_fixed_link;
 	}
 
 	of_get_ethdev_address(np, dev);
@@ -3745,8 +3744,6 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 
 	return 0;
 
-err_free_netdev:
-	free_netdev(dev);
 err_deregister_fixed_link:
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
@@ -3767,7 +3764,6 @@ static void ucc_geth_remove(struct platform_device* ofdev)
 		of_phy_deregister_fixed_link(np);
 	of_node_put(ugeth->ug_info->tbi_node);
 	of_node_put(ugeth->ug_info->phy_node);
-	free_netdev(dev);
 }
 
 static const struct of_device_id ucc_geth_match[] = {
-- 
2.47.0


