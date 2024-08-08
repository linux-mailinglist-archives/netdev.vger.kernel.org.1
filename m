Return-Path: <netdev+bounces-116685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F594B5C3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E5A1F23575
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971A87F484;
	Thu,  8 Aug 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6sAmAq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205F32E419;
	Thu,  8 Aug 2024 04:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090274; cv=none; b=P6yr3e8WPnlQYpSyN8auPIhDT06Xf30Kmq6hJqVxOARau78e2E2SD5paN0p9aKpSsXRrSliwvP/mva7T7T2Y+R1D7dLGOHDuLxRLDfhoCkKCOr9HuZb8YA57QEK1POl2/8h0WInBGwxgkRzUfHEWx8sBL4fEsGu6B06dOM+qEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090274; c=relaxed/simple;
	bh=g77BYHZuyQWUySSdMkKlIRORWX5DQEXVkxFlPBGewzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UY6pgnphSEIKztmObtUYSQFBW0xMXE1A9QBpOqluy6FLEUZLfuFo9cnmmrht48JhzVCh8p89YI/2bqrWcqOpfLpShK/8uWbjmeygmYLfIEZuQUJiOFZb2HdvZUxR22WyWCOVco9yw3qxN3dONL64AG1J4OM6zUMBdMllTFkTgIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6sAmAq0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso444877b3a.2;
        Wed, 07 Aug 2024 21:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723090272; x=1723695072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nw80wNgwCOZs/0Sah8DGuFBIZj4cxP28UKSdbAt7aTM=;
        b=J6sAmAq0qRDkNc0R7f0Zh3ntOgyM9JeWb9b/7PDpFqTqWXid9JP1CHtTouOzM5EbjG
         T4XOegOm6a2RjlirFuqOdkHmtCJKFMos26JBzxzSEEbYh4KpHTH8OJ7KoMItpZcTGr4/
         VgS/GxBAuUxYaF8jFy/66q9Y+2ae8gMY33JYdAdV//RS3ev7IukO9iKTlTOJP0DlV1H0
         lN8iN/ludv5hZm80Nb9P48qebXMxC1x19Pht92fPFd24Odx5BDBeph2w9s07TUfbLHwT
         uIZRorpk4ilOCppZQzu7ldOYSkEfAV+z5gJLRJACEbrqL1kplALJWzb+lXS+jM5Wsmkc
         dq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723090272; x=1723695072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nw80wNgwCOZs/0Sah8DGuFBIZj4cxP28UKSdbAt7aTM=;
        b=pv+zTixXe6J8RuV6wOyHri0jtkUPvWZAnIFSkgjAHLYNo2IoI9InWKUrLePvPZcxrL
         12xUEO7LVI03pdrzC0L0rnHjSRL2FtyaHb4Drbu+c5f82Is7afLuuib1t+DOufg/soth
         2s4h5zBzxxxOb+O19YlJ2lk1I12quQ+h5gtyGx9x1SmkIKhTosUr78vPTCXhqxsy23/i
         8xeAVaW4pKanEV6olabDM4m5IMOqAU0djU1pM60u639iBSx0oGq6XIADDDGt35xC9qeu
         w5y7iqiTPHJ/4Z1IPA24qcKxWjcsiM6Y5U9dUn159pGEh0O7TA7DXNHKTY0OKHxY7FW5
         FQqA==
X-Forwarded-Encrypted: i=1; AJvYcCX/8ZZpWazml/Xrh+DmM0tViG/tpIn48AxLQA5/67hHjyhMdtSQ+AD6xjmJtFqImIcEZdVkNR2BjuoUjiq8fDel/1HGHb6ezKOXDLdY
X-Gm-Message-State: AOJu0YyfgRxJDMCQ9Wt0M2LkqKtGb/BpanpaoBFB9RMZIKg3mK6/dpRi
	B0z0oTHTWcsAidHRmlBde3tt7YV19RQy2EAxD1y5vR524ls9j5Yvh4vcFIOy
X-Google-Smtp-Source: AGHT+IGTcAB6J6QaMmMT3mk3795KOh7FU7yH1hJPeO27BLyz6bv76XnXocRSDBwQAFD1qhMalczw4A==
X-Received: by 2002:a05:6a20:7292:b0:1c2:956a:a909 with SMTP id adf61e73a8af0-1c6fcf18f56mr700742637.27.1723090271950;
        Wed, 07 Aug 2024 21:11:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5927f40dsm114101505ad.229.2024.08.07.21.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 21:11:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: quic_jjohnson@quicinc.com,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: hplance: use devm in probe
Date: Wed,  7 Aug 2024 21:10:55 -0700
Message-ID: <20240808041109.6871-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removal of the remove function as devm can handle the freeing of
these resources.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/amd/hplance.c | 33 +++++++-----------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/amd/hplance.c b/drivers/net/ethernet/amd/hplance.c
index df42294530cb..2ebf7cc9ab21 100644
--- a/drivers/net/ethernet/amd/hplance.c
+++ b/drivers/net/ethernet/amd/hplance.c
@@ -49,7 +49,6 @@ struct hplance_private {
  */
 static int hplance_init_one(struct dio_dev *d, const struct dio_device_id *ent);
 static void hplance_init(struct net_device *dev, struct dio_dev *d);
-static void hplance_remove_one(struct dio_dev *d);
 static void hplance_writerap(void *priv, unsigned short value);
 static void hplance_writerdp(void *priv, unsigned short value);
 static unsigned short hplance_readrdp(void *priv);
@@ -65,7 +64,6 @@ static struct dio_driver hplance_driver = {
 	.name      = "hplance",
 	.id_table  = hplance_dio_tbl,
 	.probe     = hplance_init_one,
-	.remove    = hplance_remove_one,
 };
 
 static const struct net_device_ops hplance_netdev_ops = {
@@ -84,21 +82,20 @@ static const struct net_device_ops hplance_netdev_ops = {
 static int hplance_init_one(struct dio_dev *d, const struct dio_device_id *ent)
 {
 	struct net_device *dev;
-	int err = -ENOMEM;
+	int err;
 
-	dev = alloc_etherdev(sizeof(struct hplance_private));
+	dev = devm_alloc_etherdev(sizeof(&d->dev, struct hplance_private));
 	if (!dev)
-		goto out;
+		return -ENOMEM;
 
-	err = -EBUSY;
-	if (!request_mem_region(dio_resource_start(d),
+	if (!devm_request_mem_region(&d->dev, dio_resource_start(d),
 				dio_resource_len(d), d->name))
-		goto out_free_netdev;
+		return -EBUSY;
 
 	hplance_init(dev, d);
-	err = register_netdev(dev);
+	err = devm_register_netdev(&d->dev, dev);
 	if (err)
-		goto out_release_mem_region;
+		return err;
 
 	dio_set_drvdata(d, dev);
 
@@ -106,22 +103,6 @@ static int hplance_init_one(struct dio_dev *d, const struct dio_device_id *ent)
 	       dev->name, d->name, d->scode, dev->dev_addr, d->ipl);
 
 	return 0;
-
- out_release_mem_region:
-	release_mem_region(dio_resource_start(d), dio_resource_len(d));
- out_free_netdev:
-	free_netdev(dev);
- out:
-	return err;
-}
-
-static void hplance_remove_one(struct dio_dev *d)
-{
-	struct net_device *dev = dio_get_drvdata(d);
-
-	unregister_netdev(dev);
-	release_mem_region(dio_resource_start(d), dio_resource_len(d));
-	free_netdev(dev);
 }
 
 /* Initialise a single lance board at the given DIO device */
-- 
2.45.2


