Return-Path: <netdev+bounces-130986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102A198C55E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3515E1C250C2
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648681CDFD3;
	Tue,  1 Oct 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq3kE87E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C11CDA25;
	Tue,  1 Oct 2024 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807366; cv=none; b=dkbzhl7eHIpxJf0OwS3boyg8QxEui5wniIOxUsEVgsWVpkNmn/qwugg9Sergy69Rf6q7SoY9mcTYMsuG1l3eRGB1SVY/DL4cjXO7M+/grg6D03Q57Y2tsSiXHkCajIt4oSQZIytil44bqrkQCcFnejAnhIeoEgDSpRp4VnUo2R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807366; c=relaxed/simple;
	bh=d1wcnJvYT1jEDXMivdbAMm3QJ4G3BETNR+XYEB1nViM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5NkU0eSqoImVcy2HGMDgWiTPdhWd99MmDlEmA+hhE34VUAmKCnnchu5JD/lIpn7R7l2wPJds7JbLAhw6211fKs6UYRv+oJmCABxgHNDIOz6d+EOEfygifyruPudWQGq/KhEqYbkDlA+E8LnZ18vSlsVp2oOehWrxO5t13PBMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq3kE87E; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7198de684a7so4124545b3a.2;
        Tue, 01 Oct 2024 11:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807364; x=1728412164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/VnWmql9WWehTPtP4OLmkpJC/y6jUxvQfB7GmfsfBk=;
        b=fq3kE87E/f5ph9FuBTOLt5zdnNv6BY9KngC6jKgcwMhh0bHPveToSvFyiQd4Cv2CjA
         hewrrnxcqVjHQpfS3k64ooAFBoamYnQNr4VxZGKc6XK2zdQnVgFcjohe3i6xzpihHkf8
         DfgQglMM2eUxSSIlpKyhtuJUq2QUZkJJsWdFGZepEoaXjXXcdJ6gYy2TtyC/W3gDHlwA
         5GSz+6w7OfQx3KoyhJJNa7ZKCLaulRDRqwbzPckoCSNC3Lz1/0Dsp8G7e3SosyjatOHf
         t5766nWjW+0p/QsLdRb4fT6NPWv58AhF3rhWeSd+G3gM/zqvJf3TPwRaue69VnnRuvkv
         ZeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807364; x=1728412164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/VnWmql9WWehTPtP4OLmkpJC/y6jUxvQfB7GmfsfBk=;
        b=c7ALvZok5FE8wQGtwX1E1aFqhYUWBle+TUj9H0zTMdwxjcGS4PjKpTK0qvdZZuAM/B
         ARRE30MwkFju+nOj5lmuRY9QbhT7DuAixuKwRu7PHhknzL2HhW9q/5eg7594n027l9j7
         v7+kSxHcBB5BPgMYKKv6W5XTEAg46fP4CkwImtSye003aee0lJL3hn+cBMu8Lf7BAJZc
         7w/eu4dstoE6UVTtEXraRWxOUpsA0Nn0ek2eANzNGTjImtay8JTMt45ey6z18uoVET81
         JD41wYFO7NKAOAjtU0Zc0Y+8iT/P13mnfsN2sPzKVwWR6KVtxh+BJ/G1AzE3NTQPocWP
         6IbA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRYIdkZvROyCvM8LWT9exrakXM29aik++vusNcXGMOR5yz4b8w9FHxBYtokFIUa+hVglQotJDEIexYKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygxg6Xz7ApnCxTb2mKolgT4brIZ5BAAbGcU5fwFQQS7S9HOsMy
	Qq8xWyr/QVpFVhPCKSDwNSxyVp/0dzOJZZK4XJBet7/N211CaA4FK7RrLqgI
X-Google-Smtp-Source: AGHT+IGgKsUhqiufYkpWD+3wntMC/sVJCE5LCvSaAV3HzyWzXRVsKSFZCvfvIBMmUv/SoHY4aIed/g==
X-Received: by 2002:a05:6a00:98a:b0:710:9d5e:555c with SMTP id d2e1a72fcca58-71dc5d6d9bamr904336b3a.23.1727807364145;
        Tue, 01 Oct 2024 11:29:24 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 4/9] net: smsc911x: use devm for mdiobus functions
Date: Tue,  1 Oct 2024 11:29:11 -0700
Message-ID: <20241001182916.122259-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
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


