Return-Path: <netdev+bounces-205926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B23B00D55
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097A83A50B6
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4192FEE17;
	Thu, 10 Jul 2025 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZvGE1ns"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162DF2FE39D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180041; cv=none; b=GojflQho3UfmQGp7dVmAapINeMPggol3uTm2mJ2+WrvJd2oNQ4pYsBBLcvZUkmX0Q8Fq0Fql6vKgiF7L+ueYihX5VCDC9qpqsfrxUG87YZNKc9Tc7Q6M8PQuMuUKy0pTCYoTGPh6tGqPn1wf3JjMpLr7r2tYdED78agrhHC5vgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180041; c=relaxed/simple;
	bh=wXV+IY8xrz3mSeCH3MF62AvWgxZDkji2MJahf0zBfb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUPWcHqbz182LmfiaoNxPg+bo2uB2x/BK19JuHNZR3vQvPBtMYqC1SYoLSrMNxsZW7ZzfbHpB7Czeze3L899MWvwa5Sia1aZzcwsdCEM6CPLWZct0nJXnXDJbt6jk8uLx7xKNBg+dhAmuqVqB+fOBGXnRIiWA5Fvmh+sHJjSKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZvGE1ns; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3135f3511bcso1234937a91.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752180039; x=1752784839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5Jitk7DnV6mftEGUz+m18DOyo5IeOMztY5h4LP0syI=;
        b=SZvGE1nsPJ3uqXLHdtTwsCG+aT6rPK3asS14epFwoP9glSheNj9cft9TE1Mv3Gpx6/
         CRdUgBMi4OcyAp24GMh++vtpWFr+lK56zW5Yf36f9V++hvnbuufAA0pkB4Mx+ipBr+sK
         sg4wNSrBo1WGJM5wZbME3SYkfV63AzzUs7AkhF5sXqSJcYJ8+cgJEoHc0ofCI72uwmzE
         mCBw8Y9zVnat/S9Q3jT1zJmYYOxFtbERIKWyNJwr2JqJa5Eb3o2pJeiSupZlpyqg62c5
         vUgLA1qY3D53R4KGweH6T9W31qLh53r1jn25qqaLHqcmUA2UER5AE6aStQeKLjk2HSnE
         Sc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752180039; x=1752784839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5Jitk7DnV6mftEGUz+m18DOyo5IeOMztY5h4LP0syI=;
        b=tN+9jIKEVp3ABkQO6Uu+u2MIrZvKOqOweqx/pKeAfKI/LqeDhwUvuIpJ2RyxkT1Cvj
         TXb9YMjwA0Klx5ZGmPUQ50ET4jF7gYwv+ndTa0WQ4oR/oXLcwtP9NjoDjInFAXD9bKWO
         s52N7hRCZQYnJgjoNgZqIyI9mfE3sUwYuXLUUBryqfJw6fz+ry2Aptja4oimvu1zoFXA
         PLpoYqkldLdsWUCZGzaYVv8SSiVWbgej8ar4o2Qf3l+wbGjgoFFfYxvWSA0g6qpaLoit
         bb7XN+SURD38QkbunBnzsAIH3KVQOimQiPLHm91mwsCBZCD+vJO43tRo2DTyGLfbbmDy
         zpUw==
X-Gm-Message-State: AOJu0YxvZWpbXTH1vMXc3BM6kk4N+oRmyPYSpnoRuouV7Tu3z53MowF4
	z6U+LZxIIXEGht2JSFqgYU+TDduBmuI973T98/WibBxfs64NW0b/wcExk9ItTZFr
X-Gm-Gg: ASbGncvvclC7CSsIGLZb8g+VferBL7PVb/v31AAXMun41YQtRzN/GiCRyxkv2DIoTRy
	iK2HtFf/z3XrcbatfZWp73CwAd/vLwZv1+1YXmvEgPGiArZjqPLyauuYnpUojZyda2Jaj4Z/U81
	dhzocLiNLorsWnpWxTINTGZj52Fdd8c6Y8X0RDEqP82Cao4VLhKuaA8q6PiTchM3fpD4SX1QyiD
	iFJTgY/GBDxBhawEQxamXh9ukdqiIllqlT+zaExN3kI6j22ASd4pTFBoO+JwroK7BlUkn6tObFT
	vVvtfvWZ55LjIiMl9/Heu0AnaMByU1HnWb7VESM4GR8=
X-Google-Smtp-Source: AGHT+IHEvcWRddgXpCosOea/GWgnMJwNClrnhkFdJPWuXDW7XWqvzAdzyWDjgw5C92qijJ8YE33tag==
X-Received: by 2002:a17:90b:54cb:b0:313:1e60:584e with SMTP id 98e67ed59e1d1-31c4ca84064mr1270446a91.9.1752180039070;
        Thu, 10 Jul 2025 13:40:39 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm3547861a91.46.2025.07.10.13.40.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:40:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 07/11] net: gianfar: use devm for register_netdev
Date: Thu, 10 Jul 2025 13:40:28 -0700
Message-ID: <20250710204032.650152-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710204032.650152-1-rosenp@gmail.com>
References: <20250710204032.650152-1-rosenp@gmail.com>
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
index 05dedb6c9848..53839dfc5e7a 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -3265,7 +3265,7 @@ static int gfar_probe(struct platform_device *ofdev)
 	/* Carrier starts down, phylib will bring it up */
 	netif_carrier_off(dev);
 
-	err = register_netdev(dev);
+	err = devm_register_netdev(&ofdev->dev, dev);
 
 	if (err) {
 		pr_err("%s: Cannot register net device, aborting\n", dev->name);
@@ -3334,8 +3334,6 @@ static void gfar_remove(struct platform_device *ofdev)
 	of_node_put(priv->phy_node);
 	of_node_put(priv->tbi_node);
 
-	unregister_netdev(priv->ndev);
-
 	if (of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 
-- 
2.50.0


