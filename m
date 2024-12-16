Return-Path: <netdev+bounces-152069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A61B9F2943
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C41650D1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A5C433B1;
	Mon, 16 Dec 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="XoZj2o5Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B01155C82
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 04:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322550; cv=none; b=tWC29jhYMGvBWhfKp/TTTYsLwNGRYoa3sDbQA3yvyNtQ0GDNG22CQveaQdcxtzKpVvBRh8S0iQUilahLcn1OMQTk8/XZBtnYXJpwSI2eZNTzMbkI+GabW2S2hyFoqT8ztC0MTNk3xHH9g82h29khE33ME9dk21rP49g5ziohemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322550; c=relaxed/simple;
	bh=mJRYfArAEDIL38d/5h6aXCwlVo71CrFvNaiE36YxwrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QrcNnJvX1HqunaQqEzoOg4aXXih54Vwi6sIi4dOxsPhG5dsMTwW6gkiIVY4QjSMGPdZnyWD2TVcnwV53Dqnhaf44hQVdcOkoiSutMUfg476F2WvjrrT4nFzm1c77NH0w4ozAyx9n2Ms/ilq+3t0jhB3ExS8wnR9EWPMA+I3S5u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=XoZj2o5Y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21675fd60feso38200265ad.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 20:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734322545; x=1734927345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XEARyVQezicJ+XfU1gdJuV1k2qCDvZVe02THgIraJg=;
        b=XoZj2o5YTgfo7YghyLYZH7I3yQyTlgBl+EIgaWYAj9l6j+osCrFA3nkyGfDJRrKK2U
         71CPSfPsWQn56Pr+oH9CPqNr2+/pEjbHkHQXA8PXKnZdhF6+dF66yqdey9AxbhxsODVm
         749wgyfWcaJkI4EDZHZFPH7liP6oy1dR4oMvGeyJ2+hOih77wcmlTYMMC9hJmJNfL7Zw
         u4nMr/9/1UDcAVF20kyc5tVo0vrHK4xqM0/dGCqVGUZKqrFEvl+hnRyRBe2VZmtV+l2F
         Fc8Cz8jeY0Cmpkv4faGSX+WK2n9H6wXDo+hUkvBn+f04MnRZJ5qBgbuUdo0yOUOt6tbZ
         xcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734322545; x=1734927345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XEARyVQezicJ+XfU1gdJuV1k2qCDvZVe02THgIraJg=;
        b=DsQ7Mw5F3R2QiKsq/XhBca/CmhylLw3upkhZdnz1q1KhEgWhyKEMlM0Q3SZxikGK4U
         i6bSspSu8v7V48hDtTj2CluZ5bn1ruzzqThhLYH2nu+zpFgN7fy/V9M/wvCoEht0TRnQ
         39CO5Px08MRoFAgDjbVHCY9Ss1M7g67nU3SAeZuOMCHkNWlTQXTh36t143+1NQKIQyAw
         hGMGnDITLWV4TcW1U8O5T/QZahPyWHzJUGr0GphxWEgPT+xywrvXR5cSJ4Q7ARHiS/Rf
         m2IlM+H2/CxXGEUrxjB2lnF9Pa982p/tbEh+JlIz4zjAa5OPs1fefnuY3aHfQf9WmW7l
         ugOw==
X-Gm-Message-State: AOJu0YwdhgP2hLbScrjj8vETLYJcG2Gp7K6wVi3FuG+f+wEItNpLWyFt
	rrhoCVmTBPRpEvDyPJPUFEs7B4zH6CtzNWaD39Tk9BeGY/pchVN898MMlbdHbW5rR5QKDWjv+YQ
	g8/U59Q==
X-Gm-Gg: ASbGncs7E6V5ukgKr20b1hMlC2N7JTchwTnyQQXh8JogDbwb3EyKmbGWFi75GqmXTgz
	ZIrOzRS/nuYGLSqb4gDZCv7GXGsmL//MQgDaakLLjb0b+BAny75+1ZcTWMWf9GfUVXEPF6iMDzE
	eink3rpLAR2ce6lQgw1xO10gsOuW8QPXe3x1yIkEIYzgZFwblbUyRHvoDvzq5wqAJ7J4jZKHqhP
	lI+euIYaUBb7jpCp5qddt8+NSDoynLbh0Qm3y5FyfzjF8sPoILbGwkTgrMiogiqasLN+K1+TvgK
	9EDvFr8XnlU3OZtdzw0SK2ifYneAvmEMd8cb8ByCeq4=
X-Google-Smtp-Source: AGHT+IGwKaVk9uDz3e7q+xsi5xoG3qCzFqDHgJE1XP9X4glKbkrwJ72u1dYTNk42RQ8FxvRy5SrGOA==
X-Received: by 2002:a17:903:187:b0:216:3e87:c9fc with SMTP id d9443c01a7336-21892991e99mr137504975ad.5.1734322545062;
        Sun, 15 Dec 2024 20:15:45 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e728c1sm33436375ad.278.2024.12.15.20.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 20:15:44 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: sebastian.hesselbarth@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] net: mv643xx_eth: fix an OF node reference leak
Date: Mon, 16 Dec 2024 13:15:36 +0900
Message-Id: <20241216041536.485250-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of mv643xx_eth_shared_of_add_port() calls
of_parse_phandle(), but does not release the refcount on error. Call
of_node_put() in the error path and in mv643xx_eth_shared_of_remove().

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index a06048719e84..fa30f8c4a0cc 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2705,8 +2705,11 @@ static struct platform_device *port_platdev[3];
 static void mv643xx_eth_shared_of_remove(void)
 {
 	int n;
+	struct mv643xx_eth_platform_data *pd;
 
 	for (n = 0; n < 3; n++) {
+		pd = dev_get_platdata(&port_platdev[n]->dev);
+		of_node_put(pd->phy_node);
 		platform_device_del(port_platdev[n]);
 		port_platdev[n] = NULL;
 	}
@@ -2769,8 +2772,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 	}
 
 	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
-	if (!ppdev)
-		return -ENOMEM;
+	if (!ppdev) {
+		ret = -ENOMEM;
+		goto put_err;
+	}
 	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
 	ppdev->dev.of_node = pnp;
 
@@ -2792,6 +2797,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
 
 port_err:
 	platform_device_put(ppdev);
+put_err:
+	of_node_put(ppd.phy_node);
 	return ret;
 }
 
-- 
2.34.1


