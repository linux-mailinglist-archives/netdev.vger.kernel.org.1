Return-Path: <netdev+bounces-130601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8385D98AE45
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9C90B25A19
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57C71A4AA6;
	Mon, 30 Sep 2024 20:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ+08li+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690E21A3BA9;
	Mon, 30 Sep 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727887; cv=none; b=HxAWBiUzlFhR1TebJJTcrUSi2AXHY3wUHIHy95d7o+vaMpRQgJtHlJk93+o0+c4Psutlhv3rvCBQz4fxyH3Hc9mkE6uudZfEdTwUhI2Q/IIrSbQ6wjajWPF7MawMgKOPz7gVA9tbDObsWEgmEXnzQHyFpiPFpZhUSG+Q+PlvLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727887; c=relaxed/simple;
	bh=6LYk1ZXYkRN20IISS7yrx8q2kInlJ1DrccOhvVCu++A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUqeka4cq32tPiGOG26OwfYVV0x33IAd4jtDO+SjmpCcGv4jDzgDPl1nQsxFXKCgykqffqhpR0RI+/9bHjkR9xvF5U44ZB9hWyiEOmqoy04k0SZFRxrwDxR9In6nM7tohHlrhmmwi3gDkpnpaCyXbyzc1sgE9h202b/kzuz3Nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ+08li+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718816be6cbso4103765b3a.1;
        Mon, 30 Sep 2024 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727886; x=1728332686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ644ZQ2SXYReITMnfkt2rkgVzvlQg7D+UukPue1XLU=;
        b=iZ+08li+8wt+vQUJhSPt/TRIs1M68gBnBiYzBTjOAXh3dcRU7P6/KuvIxtKA/mBGJ9
         qGccX5enubfWW+ATRfcrS04RXNoZYh1vR6UIL+4LbLQlvkH4/P/qBz0cQwbArJJB1X5A
         2YzISThOWUsnMgdHbdUG6BM2WImTSzRf3EaoKAEgYDfmpKu0L1J6N0RUHqIxOjzfbk7g
         WpsJ6eai/KAPy6NSQeS3brRWWF5b9l3HsRHDZYElXs8v7AucZCYYVWAb0Mh7m/wSky4P
         wicuUc5XMBlzczl8iUGwNfRcTnMIxU9nlGVEk/4IlxGva3SabrjguAnB58k5GoLjBCAG
         kQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727886; x=1728332686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQ644ZQ2SXYReITMnfkt2rkgVzvlQg7D+UukPue1XLU=;
        b=BzIJaj2Muyz7AXwqA2RZ79o8Ylfm/PAUMPgGK6Q6J2PdYMeRnFfplRmmEGmcY6XACk
         arITpCXLW3Gp8dLTkmB0xA9r0CQ44ahgvU8Y0tV7bTSY9TgACJMtYszljiKK5yB9w4BW
         8iqs5BRuhub9jA8qXiDlxUwAYsRynXQFcjIZUP+GGB+SJCmOdYC6Q4H/b1C7okxi/fWE
         z6nllEHBIFTIRxdSwr/Y7JgkuL4pCsVa8dmquGP9gez6Gy8gUSPDUoCzOx6EK9poR6wR
         NAv3fdI7fq5JDE4sdsIGbfLPNaHRbXhR+oaD1u5gcbHgWq91jaAwj7uJ01SJqMwzwBQq
         GSMg==
X-Forwarded-Encrypted: i=1; AJvYcCUaPXSip7hG8cczpqCIJ0bCLajOiYN8bzRP9Cx6YyH0cGYDQNwWwKGE85Fa9deXgbxSl9P/8CB+r2Hj+SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjqyf+38nDj6dtwLWvUbPhEZ9wX5tG7IWjxs625rXYL/HBCL/Q
	swycqagGUjOs1rGc74RgfCKRKK8A6eziFEAm7hc+qqd6asPi3YPigMS49msG
X-Google-Smtp-Source: AGHT+IE5UZU6jatcMT96Dhs1v077E3aIIlIFT9w62DmKJYxCLscKbmPULw8epYDHLVEUpCO/nVk+cQ==
X-Received: by 2002:a05:6a00:3e1c:b0:718:e062:bd7e with SMTP id d2e1a72fcca58-71b2607a1f8mr18466041b3a.24.1727727885576;
        Mon, 30 Sep 2024 13:24:45 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b265160a5sm6670623b3a.103.2024.09.30.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	olek2@wp.pl,
	shannon.nelson@amd.com
Subject: [PATCH net-next 7/9] net: lantiq_etop: remove struct resource
Date: Mon, 30 Sep 2024 13:24:32 -0700
Message-ID: <20240930202434.296960-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930202434.296960-1-rosenp@gmail.com>
References: <20240930202434.296960-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of this can be simplified with devm_platformn_ioremap_resource. No
need for extra code.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index bc97b189785e..0cb5d536f351 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -90,7 +90,6 @@ struct ltq_etop_priv {
 	struct net_device *netdev;
 	struct platform_device *pdev;
 	struct ltq_eth_data *pldata;
-	struct resource *res;
 
 	struct mii_bus *mii_bus;
 
@@ -620,28 +619,13 @@ ltq_etop_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
 	struct ltq_etop_priv *priv;
-	struct resource *res;
 	int err;
 	int i;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "failed to get etop resource");
-		return -ENOENT;
-	}
-
-	res = devm_request_mem_region(&pdev->dev, res->start,
-				      resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev, "failed to request etop resource");
-		return -EBUSY;
-	}
-
-	ltq_etop_membase = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!ltq_etop_membase) {
+	ltq_etop_membase = devm_platformn_ioremap_resource(pdev, 0);
+	if (IS_ERR(ltq_etop_membase)) {
 		dev_err(&pdev->dev, "failed to remap etop engine %d", pdev->id);
-		return -ENOMEM;
+		return PTR_ERR(ltq_etop_membase);
 	}
 
 	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
@@ -651,7 +635,6 @@ ltq_etop_probe(struct platform_device *pdev)
 	dev->netdev_ops = &ltq_eth_netdev_ops;
 	dev->ethtool_ops = &ltq_etop_ethtool_ops;
 	priv = netdev_priv(dev);
-	priv->res = res;
 	priv->pdev = pdev;
 	priv->pldata = dev_get_platdata(&pdev->dev);
 	priv->netdev = dev;
-- 
2.46.2


