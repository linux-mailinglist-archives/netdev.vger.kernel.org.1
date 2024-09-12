Return-Path: <netdev+bounces-127643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBF1975F2A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFA0B22893
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233D61448C1;
	Thu, 12 Sep 2024 02:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdY/Gs3H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3B13D281;
	Thu, 12 Sep 2024 02:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109353; cv=none; b=gxR6o0Oqz3UZk0sID20O2I9irxnERYvddHSNMNSTG4l/p0FqwlRq1ScyMy/QDMCfQmoRN3FuA9kQ0JEutIvmpHiIglz1xPPFxjrUI90xiughnLjH6QQ42s2sbVrgOqnKlQ3fdM3iTBHwv9K//tFOoPApXxcUdq6wEt2YFdQlYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109353; c=relaxed/simple;
	bh=4417gaXl8FXFi2g8/QrmuQcNe480XU3gPSFGn3wpTpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwWQ+90rWaP179E8Glku/HPBpePOixHIluUmPMbCi1XyhFE+nFIeGyBD4I7Ot7K7CLztVJ5XfTNQFK3szga4Wyf9HfLlWkclP6IgX/XdVPE3vKI3TmdBb0QMY+C3XtYLSNisyqFjj0uAWz+IMtHmT5tVg0T9pRxiXNUxJAlxL84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdY/Gs3H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053f6b8201so4559525ad.2;
        Wed, 11 Sep 2024 19:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109351; x=1726714151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CVImb9caOCrRdmt62xCIIDvZ7oEnEcSXvnot+RJZns=;
        b=PdY/Gs3H5goOw6SE+RkFD7F3LLlYZyOieVLnqCZQ/C6Scm5SmAyW6Lg2nyHZXOkGVN
         21GeHQd532aiDhUh3WAima2yLSNk7KHE0i4N2xCPvONP5qqL8tdbTD5LLR1Kuf0rHYYp
         VkP25gqw9txS6UPaEAKVL6aaqB+Trw5AsnsPqMX4DEaZIUL+0+VdtvGV+/wmy17i9aZR
         lHCo1Hgp4r0bj74NuqckR9aXln1cxkU+vHRzj3WMXqJa2gJDUG7xy+z3vppXv5iTl3YG
         7U+1qIJg0+ro4/804LDCuVS744HwIhx7TqjtJHQSzuwiWUYiR2mDhWMyFZH3ARqQ8lMX
         QzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109351; x=1726714151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CVImb9caOCrRdmt62xCIIDvZ7oEnEcSXvnot+RJZns=;
        b=nKRJVB886KN3ftBJxvtkFdCnNMOdD2uKVFcPbSDtjLDbb8yNk81RQI/7W3A0JrtPeQ
         59hNhr5Bl9+74puIia1J2QCmIh34ea4Z8fSycxzuQvgJQZ27CNmSryd5qI/OW44GUGgx
         L3ku7tYzEjGySBFxX+b9G5c38rWwHNKDurv4nYQHTgIlly395FBma7vRNSHci5zj2nb3
         8tVGpm+5QcJUxMVGJwwV7xj9X8TR6RMhR8cIySYYBG12hkzWTZEhysezeWqpurbzWT2c
         DIKV0uaVtKEBp9N6ri3YIos0haZKHQtf0zyexjfLqm2V4gaLC2lKObpeDXL0qJDsnECF
         q7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVx2pnF+fBGk/yOEyMu9hBHpyQm/GxpEZLp41tFCAfleM7+buE0F9E1ZG9/LZctTH2KSKgzJxVic7FANfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0nKGIjOt6XMahvdvU0rKZuVBqbSu8Gr6tKbSaHaFChk0YJdkd
	BZZ5K/WCjlyMlpieadAet/JzGFn2RtrzuFg34e2Xg4eD80miHdPSGkf4DWvZ
X-Google-Smtp-Source: AGHT+IGMXF5l0ACXDWT98fbifi5mLZqeT0xF203cgm/Qisn7bdm18fHEW5xL+SVotrEN6iNLeEbSFw==
X-Received: by 2002:a17:90a:4dca:b0:2c9:321:1bf1 with SMTP id 98e67ed59e1d1-2dba0068058mr1565472a91.39.1726109350617;
        Wed, 11 Sep 2024 19:49:10 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:10 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv5 net-next 3/9] net: ibm: emac: use devm for of_iomap
Date: Wed, 11 Sep 2024 19:48:57 -0700
Message-ID: <20240912024903.6201-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing manual iounmap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index d1e1b3a09209..ad361202e805 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3084,9 +3084,9 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Map EMAC regs */
 	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = of_iomap(np, 0);
-	if (dev->emacp == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
+	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
+	if (!dev->emacp) {
+		dev_err(&ofdev->dev, "can't map device registers");
 		err = -ENOMEM;
 		goto err_irq_unmap;
 	}
@@ -3097,7 +3097,7 @@ static int emac_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "%pOF: Timeout waiting for dependent devices\n", np);
 		/*  display more info about what's missing ? */
-		goto err_reg_unmap;
+		goto err_irq_unmap;
 	}
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
@@ -3230,8 +3230,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_reg_unmap:
-	iounmap(dev->emacp);
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
@@ -3276,8 +3274,6 @@ static void emac_remove(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
 
-	iounmap(dev->emacp);
-
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
 }
-- 
2.46.0


