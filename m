Return-Path: <netdev+bounces-130652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B3998B01E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262CB1C21D47
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA51A2623;
	Mon, 30 Sep 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYfIjUZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89311A0BC8;
	Mon, 30 Sep 2024 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736067; cv=none; b=PF9u8eNvkv/7O+3rlTDaN84fuBhc8xMC5KO0kYP1cE1mMCiaUp3/zEdizcUeMHFZLuWch/oQSxKTsXgJ/q4ce5n9WPBQVFRirHJOXDn7QaOi1NOGcg4EqhAWmiimnQN7HsC5//qVWLi6BN1pURhtCGLrkObyR/uL8H3RqS4jl/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736067; c=relaxed/simple;
	bh=d1wcnJvYT1jEDXMivdbAMm3QJ4G3BETNR+XYEB1nViM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK1Vs7aXDD6kLEw4KTcYJkKkubg0wZ2AZoI7dmmJJ41sGUphvmxA2qGVyoK2ga7RrX3gc0m9GZMj57CghibedLoJpEGRgUCe41V2NoZuQDTeZ1rjy6qCZiLl5IW9itrg/3hpNeaGawUYJIYp8TfLnYdn4ZHddFlj+YI3AZTRltE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYfIjUZ5; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7e6bb2aa758so1898613a12.2;
        Mon, 30 Sep 2024 15:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736065; x=1728340865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/VnWmql9WWehTPtP4OLmkpJC/y6jUxvQfB7GmfsfBk=;
        b=iYfIjUZ5dfd0qIcCcLqXW2kXoPbk8Dhe6v8AB9tA+Xu34VLGWMVkcwAbX0d+mPp0Si
         QEhdymA75pegjC7otvopWgK+P1kpoWkSWi4MTE5kbIfcu+sbeITUUzOC99Z02pr1oRQt
         FL08BVeqhP1LPgnDAYWF/wgw09hXRlHDkCYTqXXIUlUPMSs/J/5JK2ojqEEpMJaYwND1
         v17cIOMjjXtz45wJ0+At477aDJxA7/xO7slLTDzT5qosbw0fMvcw3DZ+exXzunZKOeeh
         KCFXlrcBOikkGjJtmlX2ACjCFDesu6sVK6Gz3ndcsmgmB/LBWFwpjQ/qP8yn9DUdmNFZ
         6T6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736065; x=1728340865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/VnWmql9WWehTPtP4OLmkpJC/y6jUxvQfB7GmfsfBk=;
        b=cxFIr8Sse3CI3fJaKW4SmT1rC2mDW99yTMcbZ7mDGDu3LvUf+Te4ZQWTESgFvIjJPm
         hkANDFhwXJA6+5YoKm2I5qQGicoIavOkAy77k01uPzJFtCEdsGm0LQT2h0TECcA8AgtL
         VuKzyfcY6wLwOgmTfmtIpf16dpa+NNihsKqF7z+1NaXskTmc5odBcrLlHtV1hzOMwNSs
         r2YI4b0uU2/8NTvVNVVFNbTR/0QivrefMs9b0nvH2cApQFm7UvWo+8OCFfgMQQ/lhpd4
         FVGaQ6p+/mQJHQD4nT6feeiVjHUmE9lvcsWUj0CGpsD3F1kSK7N+bglnQ+cJ2a5fs0vu
         hQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUCHPgoHEWy7Pif6zaLme1bGLy9PIHli/SGA1tW8op12+KDn5RSzPCp/i9PxWPEK8xSDT2KjFD/s+594u8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvwzH3gQ3JxladgvSA0D2j6c+Cu3CCFk5wzjKs90pzsERIvylA
	nVntw+lcfPoP7BgfOr3txKcMwhKFpfSz8AVNvdolwX7LgTOQn2aUcFO4gXNE
X-Google-Smtp-Source: AGHT+IE2w+RXd5jCyBSR90eeIfdfGWdd7qpYNzmkULK33nPjOzgfoYw9CM/OGnt59HeRPG6alRJy4g==
X-Received: by 2002:a05:6a20:948c:b0:1cf:ff65:3c30 with SMTP id adf61e73a8af0-1d4fa6cfd16mr14845120637.29.1727736064831;
        Mon, 30 Sep 2024 15:41:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 4/8] net: smsc911x: use devm for mdiobus functions
Date: Mon, 30 Sep 2024 15:40:52 -0700
Message-ID: <20240930224056.354349-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Frees are missing in _probe for these. OTOH simpler to use devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 68687df4eb3b..843e3606c2ea 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -991,13 +991,10 @@ static int smsc911x_mii_init(struct platform_device *pdev,
 {
 	struct smsc911x_data *pdata = netdev_priv(dev);
 	struct phy_device *phydev;
-	int err = -ENXIO;
 
-	pdata->mii_bus = mdiobus_alloc();
-	if (!pdata->mii_bus) {
-		err = -ENOMEM;
-		goto err_out_1;
-	}
+	pdata->mii_bus = devm_mdiobus_alloc(&pdev->dev);
+	if (!pdata->mii_bus)
+		return -ENOMEM;
 
 	pdata->mii_bus->name = SMSC_MDIONAME;
 	snprintf(pdata->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
@@ -1028,9 +1025,9 @@ static int smsc911x_mii_init(struct platform_device *pdev,
 		pdata->mii_bus->phy_mask = ~(1 << 1);
 	}
 
-	if (mdiobus_register(pdata->mii_bus)) {
+	if (devm_mdiobus_register(&pdev->dev, pdata->mii_bus)) {
 		SMSC_WARN(pdata, probe, "Error registering mii bus");
-		goto err_out_free_bus_2;
+		return -ENXIO;
 	}
 
 	phydev = phy_find_first(pdata->mii_bus);
@@ -1038,11 +1035,6 @@ static int smsc911x_mii_init(struct platform_device *pdev,
 		phydev->mac_managed_pm = true;
 
 	return 0;
-
-err_out_free_bus_2:
-	mdiobus_free(pdata->mii_bus);
-err_out_1:
-	return err;
 }
 
 /* Gets the number of tx statuses in the fifo */
@@ -2256,9 +2248,6 @@ static void smsc911x_drv_remove(struct platform_device *pdev)
 
 	unregister_netdev(dev);
 
-	mdiobus_unregister(pdata->mii_bus);
-	mdiobus_free(pdata->mii_bus);
-
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.46.2


