Return-Path: <netdev+bounces-130994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF298C592
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A598B22835
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488B1CDA03;
	Tue,  1 Oct 2024 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqytChVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70901BBBDD;
	Tue,  1 Oct 2024 18:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808374; cv=none; b=WdlM3aNBCTSPuDwPDtcSnemxKK413mKg23doTevjjBVXUvwQQ+S5LC3NBABPXnwU872CaDFZ5/uNFYn0tO83fTFvqpooyI9r5hXwzW2thjro87AysOQPbDP5Ms2LGgWiEb+3VmaSSTL5VaOyD56i2y9Qsx4JbIPm7pDBiEXsNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808374; c=relaxed/simple;
	bh=4rApQvoi1yzj6doZCeZpbx6q0hq8Gy8NRE4rqCrnYxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DScVIxxHcB2oJZvKBXrkCkMivAWc9Q+MOzm8yLlmAWSnJj5Y+wVGnHsNX+lHhnTCuTqEZYBazJgzV67i5dw7RrJqdUBPHFmNQaBFSKUooRYHcKdNImEvUpDt2ynNHl0chYbCAE6ffUVl6/9QcjNH8/r5fLKSJJ83mBACUZoYbPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqytChVr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208cf673b8dso59691525ad.3;
        Tue, 01 Oct 2024 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727808372; x=1728413172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ABkpUrk1T/AeyBT8TSM+jedPOwNaiAliAZdMWlHabI=;
        b=SqytChVrKE4+BCrKwpqnDQFlv5MAgU9+t3TaYDpa6R0SwJd0l66me16t6LH60qEHqu
         GNzupfkdPRIt7f0tqSseYYevO3Gx1oEZvujGccICsSUtq4hEgI93Loljv9TdAMq1tg+C
         bGp5HQswziNUVPXhJL890xTjtWXqMchMYTgdrQgteEjdr/1Ff5BGVfgZ3iAc7n4O/aQV
         QVl0RcjIEpn5qGIkIFKRKojxeHBRsCR4cJ4FWmvuTwxmC+pet5tcsFzaV9ljrmJDgstN
         XKamBaO6xseoKuynPMQQo5d/RJ2gzPQi0x/fgNbJvlvMu0n6/Tg25eiN+V8z4DW2va83
         bWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727808372; x=1728413172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ABkpUrk1T/AeyBT8TSM+jedPOwNaiAliAZdMWlHabI=;
        b=SMrzp/BIOq9m4+Ax7onIN3oLDjJfAGJtKTIqr8plfR9PVgIrgDb5vhxXIbiA5V4iU3
         9xBt53TiAUMwulQBYWTWidR+goU7DymQ+uP+xaXVtmuXRZ3951j1Fe3wdtSb6U9lC1Bb
         //4oekeKM+tFPNL8wOqOlUp86QzC9FANctvdsiGQmTD+0QYdkqeriJf/O3d2Fj56rQxy
         SFmMkAQEsZEkqIZf7VyI4kdrx9AGGI11MQQ6KeAj0e2+40vrMIG5xte8F5euI//FDE9+
         sztJG+0jneul6inNKo8LIj+ksikAK5g3h10o2avvBf40YKKBiDWEjxxql8hT6abXNSEJ
         huAg==
X-Forwarded-Encrypted: i=1; AJvYcCWNV+YhsdZ7Tu5APSX5o1pm3FytoOX977apztoF5NNAGLgNm5Kwi1Rb4kgx5KYiBsfGNjf39O8yVIId3pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeb2kV0V4fPkTc70hb21KQkvjdkM+/srDffai+6V/h8+emxfr2
	A3oaOIliJ9b3bnEg5vqOfIcXah4TxZa42SVfvGiE6IQOU3a3OezVSK8zTRfF
X-Google-Smtp-Source: AGHT+IHh7v71Ub9/7I1Up4sjuqlA0eouLr0R04zFxulQU40cbt/ujaoB7jnjjG2AUmpeYs+LdiO7vQ==
X-Received: by 2002:a17:903:32cb:b0:20b:adec:2a26 with SMTP id d9443c01a7336-20bc5a0a81dmr9701425ad.15.1727808371881;
        Tue, 01 Oct 2024 11:46:11 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e357absm72278965ad.190.2024.10.01.11.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:46:11 -0700 (PDT)
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
Subject: [PATCHv2 net-next 02/10] net: lantiq_etop: use devm_alloc_etherdev_mqs
Date: Tue,  1 Oct 2024 11:45:59 -0700
Message-ID: <20241001184607.193461-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001184607.193461-1-rosenp@gmail.com>
References: <20241001184607.193461-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems there's a missing free_netdev in the remove function. Just
avoid manual frees and use devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/lantiq_etop.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 94b37c12f3f7..de4f75ce8d9d 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -601,7 +601,6 @@ ltq_etop_init(struct net_device *dev)
 
 err_netdev:
 	unregister_netdev(dev);
-	free_netdev(dev);
 err_hw:
 	ltq_etop_hw_exit(dev);
 	return err;
@@ -672,7 +671,8 @@ ltq_etop_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	dev = alloc_etherdev_mq(sizeof(struct ltq_etop_priv), 4);
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(struct ltq_etop_priv),
+				      4, 4);
 	if (!dev) {
 		err = -ENOMEM;
 		goto err_out;
@@ -690,13 +690,13 @@ ltq_etop_probe(struct platform_device *pdev)
 	err = device_property_read_u32(&pdev->dev, "lantiq,tx-burst-length", &priv->tx_burst_len);
 	if (err < 0) {
 		dev_err(&pdev->dev, "unable to read tx-burst-length property\n");
-		goto err_free;
+		goto err_out;
 	}
 
 	err = device_property_read_u32(&pdev->dev, "lantiq,rx-burst-length", &priv->rx_burst_len);
 	if (err < 0) {
 		dev_err(&pdev->dev, "unable to read rx-burst-length property\n");
-		goto err_free;
+		goto err_out;
 	}
 
 	for (i = 0; i < MAX_DMA_CHAN; i++) {
@@ -711,13 +711,11 @@ ltq_etop_probe(struct platform_device *pdev)
 
 	err = register_netdev(dev);
 	if (err)
-		goto err_free;
+		goto err_out;
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
 
-err_free:
-	free_netdev(dev);
 err_out:
 	return err;
 }
-- 
2.46.2


