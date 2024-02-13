Return-Path: <netdev+bounces-71241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAF852CD7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3BB1C20994
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FACB43ADD;
	Tue, 13 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="omRoEFN+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE70940BFE
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817309; cv=none; b=Jv+ypbtOzslzC8sOFfDOquZWhLFNAveem/VZeIgwKgdTHvZ9pulH8RzJrHJrklaU+ZRT8/eQ6UwsxqkmTPdBREu2Ea9gfa+jBycAzvhKL2bYXDZi09iycooHKf2hWTujb1tz2zU/BsoQBsQAODIIrYX1/uSYF2gK6RekGwiTSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817309; c=relaxed/simple;
	bh=EnYdAd19jAwWHKc4rTgfMXY+rwG0QS5c2MPhvFCHKqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lol91DMO19fL8JsmtPa405Q0YSyAFo0mOaHw9c70wV7uP6SMP7dsWLJNjpNrjlNo/Mx/jZi71gwgwJ4kYv8Vz30Ea2Zbv1S/mzXrE9H6UI3qru+9cxRjUUDJ8PosgI5d9aNeU8IDsZCy41r7IkluvG5isd0A6685zmVyCEUTHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=omRoEFN+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5119cfaeb9bso279733e87.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707817306; x=1708422106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3JEuLP9KTchU1G8nG9TZkkS8ubWydU8LFmKq7GO1a4=;
        b=omRoEFN+2yqeQi1bA+sjv6MlujBNCx1y1w0PZDpnguGfER1alEh5294XPfH94A9xgb
         Tm+dXO5nSjSoXmj+wek7QCLAf7BC94xOHsKegmk5Po6mbTJBP1pMcna8upPoOEDkPnXb
         h7qJwKtSF2e1jjwkqUH4M3eW+vBPJ2TWKGwM58cWe80oMO6nmF+5nScQo822q9mFdfDo
         kYQ4h+N3MVRWgnsrOg+v78qG+MmQxWktqg++9xHqV/IZXVz+X0UpYYrUsMOkeL3eJUlv
         yvNvvAZojz8RKC+I/C1okZilO7qIe7bJsUqO9vdPIlQ+tHiLpS7Jtj+Yej/4g8/VQfD6
         /ugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707817306; x=1708422106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3JEuLP9KTchU1G8nG9TZkkS8ubWydU8LFmKq7GO1a4=;
        b=Nlb928GFsodNFtXKQGqONWun9D2lcA32LhlCOgcR+IV4eAtkS8J0cg3YUmkj3s73sh
         xXL6645BhxNcK4/y4YnC5SVXsAHituoFGvC0O5Ayr6/7C0vLARIl7ks598uZ6/JdFNaM
         IxXe7PoTRZcUsD4hBfTr74o5zAhg/tR/qUg+LFrfAZ7+qLYJ61SSGHmftk1VkjQD5WVv
         5yJ1OCecXDvb0GIBYxv4Y70fegd0ZJu0M/b9CewFw0U99y7AwnFLadBt9gKn+s6hzQeV
         /Fl8sbOTarfCzhmRE7JluQ/ND+zblOW2CYKrGbdTq0gnkiXspf8ByWpDfU1ZPjoVl/yh
         P+7Q==
X-Gm-Message-State: AOJu0Yyz249bvH2P55Ma8TRIzaIU6W/tafG48d+0TFXEaxRcvI7bt264
	4bPKay9bk8bGKWgFug+QdYU5NcwuueJZgYaWXVqdbNAQXB5XxFCrARBZlVSgOK0=
X-Google-Smtp-Source: AGHT+IEXSqcZoPS0bZRKSH9IvfC2XnxLY81g12wgJilqY+A+42HCNKHHFwzyfpnnMVNtdVg1VOhLIQ==
X-Received: by 2002:a05:6512:220a:b0:511:4860:425f with SMTP id h10-20020a056512220a00b005114860425fmr7089788lfu.17.1707817305969;
        Tue, 13 Feb 2024 01:41:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpx/iWNTvhbGArJHuVS+xJtVDBJufLVxr9+Tyt6q2KGYNfq+yhlLx4uiyXm+TkwpNS3CUysf3vSYXi38naHoKvPpAbowAO+P5fGxT9bSLYvJyc2DD3TiEhttCmbE8KBc7wJKnO572OFuzeYUOjhlimSuFf0GqrXJEgiArhc9yLuDp+0JdHPWq4NWaSsOYvmWsbffxfYVbeXufF1FWC853KEJtWtOe8Ds79pIp5EmPlXapnRvpvqq9lPsu/8lVDUQjTfuAkzyRj/tasWdJSoGdVUxSSl88iNy/Z+gmgQgowR565dCVCM5Pso6uekM0nVfJEgTlRIoO3l2h62QWRWL4DU6NnahABqHrID55EWnPAkXzgNfQy
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id fs20-20020a05600c3f9400b00410232ffb2csm11207446wmb.25.2024.02.13.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:41:45 -0800 (PST)
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
Subject: [PATCH net-next v3 4/6] net: ravb: Move the update of ndev->features to ravb_set_features()
Date: Tue, 13 Feb 2024 11:41:08 +0200
Message-Id: <20240213094110.853155-5-claudiu.beznea.uj@bp.renesas.com>
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

Commit c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
introduced support for setting GbEth features. With this the IP-specific
features update functions update the ndev->features individually.

Next commits add runtime PM support for the ravb driver. The runtime PM
implementation will enable/disable the IP clocks on
the ravb_open()/ravb_close() functions. Accessing the IP registers with
clocks disabled blocks the system.

The ravb_set_features() function could be executed when the Ethernet
interface is closed so we need to ensure we don't access IP registers while
the interface is down when runtime PM support will be in place.

For these, move the update of ndev->features to ravb_set_features() and
make the IP-specific features set function return int. In this way we
update the ndev->features only when the IP-specific features set function
returns success and we can avoid code duplication when introducing
runtime PM registers protection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none; this patch is new

 drivers/net/ethernet/renesas/ravb_main.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 7a7f743a1fef..b3b91783bb7a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2475,7 +2475,7 @@ static int ravb_change_mtu(struct net_device *ndev, int new_mtu)
 	return 0;
 }
 
-static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
+static int ravb_set_rx_csum(struct net_device *ndev, bool enable)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	unsigned long flags;
@@ -2492,6 +2492,8 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	ravb_rcv_snd_enable(ndev);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
 }
 
 static int ravb_endisable_csum_gbeth(struct net_device *ndev, enum ravb_reg reg,
@@ -2542,7 +2544,6 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
-	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -2557,8 +2558,6 @@ static int ravb_set_features_rcar(struct net_device *ndev,
 	if (changed & NETIF_F_RXCSUM)
 		ravb_set_rx_csum(ndev, features & NETIF_F_RXCSUM);
 
-	ndev->features = features;
-
 	return 0;
 }
 
@@ -2567,8 +2566,15 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int ret;
 
-	return info->set_feature(ndev, features);
+	ret = info->set_feature(ndev, features);
+	if (ret)
+		return ret;
+
+	ndev->features = features;
+
+	return 0;
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
-- 
2.39.2


