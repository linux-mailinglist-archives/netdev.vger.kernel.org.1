Return-Path: <netdev+bounces-131441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB98798E83F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C2CB22C30
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55841224EA;
	Thu,  3 Oct 2024 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbq1Ws1M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06D71A270;
	Thu,  3 Oct 2024 02:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921503; cv=none; b=HVWP+9NuvjRElbrAAty9iGsS0ztUr9Fhr5z/5nvfWGbOszeSOcDlkf1iROSYfWpUK1jaYSDSpmr5PFw1+sxtbycyC05pDq9pm5F7nat+yKOQpELJtblnILzLHgBCtzYGJ8V1EdHlvGRmyZsPCJqXjCf4wJZD1STeERdvXkUFCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921503; c=relaxed/simple;
	bh=A+1j/Ugq/kUN7xpD6mKc0h/usxX2L7w7reuIgtpSPxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T51uCEky3Av4JqjF5UVXWn9LRmbQ7gjvDooCLpxOqYD1/QB/NwDW17Bx8/LMQ5/K6HmbaajHcEsAXFQFM5cAfkw9yQzrXUt1dBR8JpxHZyMnzMlkvZoaE7ntdt46fMN85RPyxFRbDSFCwNVNMypgrbOGAHV1zcrLxBjZd7IVc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbq1Ws1M; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-717934728adso418444b3a.2;
        Wed, 02 Oct 2024 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921501; x=1728526301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIAV5bXXJI/k1ElcEpFKyJcx4VyhECZfs9bbGfC3jN4=;
        b=Hbq1Ws1MuQYwivZeWkjsSVJZecYSsupTk4MLf41EYL+BUYlyxBup9sefrqBtVX+OJU
         0hTWHRZb0d42CO2QcFlV7jS7I0qo6EEcfR9NTtFrsZ+886rZ93q8mod1qyV6isvFWuuj
         3lsBlCn+/zKKBMgqSeEh7OtM6UvasTIHu7seLPoC/avh0EEK6yJoHwMSv2R0XNqMieLX
         ypGwQm8XneaSLR59XsWNscjEVedBdu7Ufux9FtZsBuJ3wGL88QJROx3TuAnmN/WHEQD4
         nJyTPX8bppoW++UvyNVVpq/DCueFLH+4R3X7Gb02AKnwA92D1Eo66IU6GTn2QnC9Y7Rc
         xb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921501; x=1728526301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIAV5bXXJI/k1ElcEpFKyJcx4VyhECZfs9bbGfC3jN4=;
        b=wXRlJsq42wOxjvq1F2PTbFG6cFwP4qB3gL7Tg0b0eevwv9KfLQDoTB//xE6d/XoPjQ
         P7uSVEq4xHsjuGETB6X9dpeN2oa+RywX5ciaN0nV5y/tv1KTw6lGpd3BA9M9lJQgQueM
         6tnWaElA5whIg10FPru2CzwppDQrMZfVQzJ0w0Ix35xWDOmihbRj7ItT/34ggRoMI6Tl
         r5sPM8StPhFqn2OMMWYihHrTcqreoQ1MV5YTI/RhukRg9qJYcawLKuNV9XlezzOttE0r
         qaZHGugRZuWs4vN7xHqJwe3pxjeOGEpssq3bxy8XXIfmNVA8A85IM2/MyJNqqOx+4y8v
         xk0w==
X-Forwarded-Encrypted: i=1; AJvYcCUxqXzRjfz83zRzY+YOInrtyi4JOm9xXwbsrI3tIISY5RCmeJuMg+hMjziyA4Va+zajtG9UsR4DyqClVbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7jbTjDFNrP0NO7acifRjpNkofSC5hXRxAzEVcdhwgz49WdFF
	gXzbWYONs7H1qSZA2/FAHkRJPICG1h3GSSX4Km64zBgIF1gw1SDnwzT273WK
X-Google-Smtp-Source: AGHT+IELAHkKkRjaOhHkS4Z0nvYTiLvoV18UNoiKR+QhIhfFNLhcs6IsREUb7rXcp+9T1O6oOzMTyw==
X-Received: by 2002:a05:6a00:188d:b0:718:d96d:34d7 with SMTP id d2e1a72fcca58-71dc5c4dcffmr7484503b3a.3.1727921500771;
        Wed, 02 Oct 2024 19:11:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:40 -0700 (PDT)
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
Subject: [PATCH net-next v3 02/17] net: ibm: emac: remove custom init/exit functions
Date: Wed,  2 Oct 2024 19:11:20 -0700
Message-ID: <20241003021135.1952928-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're using EPROBE_DEFER, we don't have to do custom
initialization and we can let the core handle this for us.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c  | 39 +--------------------------
 drivers/net/ethernet/ibm/emac/mal.h   |  4 ---
 drivers/net/ethernet/ibm/emac/rgmii.h |  4 ---
 drivers/net/ethernet/ibm/emac/tah.h   |  4 ---
 drivers/net/ethernet/ibm/emac/zmii.h  |  4 ---
 5 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index d476844bae3e..97ae0b7ccb0d 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3283,42 +3283,10 @@ static void __init emac_make_bootlist(void)
 
 static int __init emac_init(void)
 {
-	int rc;
-
-	printk(KERN_INFO DRV_DESC ", version " DRV_VERSION "\n");
-
 	/* Build EMAC boot list */
 	emac_make_bootlist();
 
-	/* Init submodules */
-	rc = mal_init();
-	if (rc)
-		goto err;
-	rc = zmii_init();
-	if (rc)
-		goto err_mal;
-	rc = rgmii_init();
-	if (rc)
-		goto err_zmii;
-	rc = tah_init();
-	if (rc)
-		goto err_rgmii;
-	rc = platform_driver_register(&emac_driver);
-	if (rc)
-		goto err_tah;
-
-	return 0;
-
- err_tah:
-	tah_exit();
- err_rgmii:
-	rgmii_exit();
- err_zmii:
-	zmii_exit();
- err_mal:
-	mal_exit();
- err:
-	return rc;
+	return platform_driver_register(&emac_driver);
 }
 
 static void __exit emac_exit(void)
@@ -3327,11 +3295,6 @@ static void __exit emac_exit(void)
 
 	platform_driver_unregister(&emac_driver);
 
-	tah_exit();
-	rgmii_exit();
-	zmii_exit();
-	mal_exit();
-
 	/* Destroy EMAC boot list */
 	for (i = 0; i < EMAC_BOOT_LIST_SIZE; i++)
 		of_node_put(emac_boot_list[i]);
diff --git a/drivers/net/ethernet/ibm/emac/mal.h b/drivers/net/ethernet/ibm/emac/mal.h
index e0ddc41186a2..2963b36be6f5 100644
--- a/drivers/net/ethernet/ibm/emac/mal.h
+++ b/drivers/net/ethernet/ibm/emac/mal.h
@@ -252,10 +252,6 @@ static inline int mal_has_feature(struct mal_instance *dev,
 		(MAL_FTRS_POSSIBLE & dev->features & feature);
 }
 
-/* Register MAL devices */
-int mal_init(void);
-void mal_exit(void);
-
 int mal_register_commac(struct mal_instance *mal,
 			struct mal_commac *commac);
 void mal_unregister_commac(struct mal_instance *mal,
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.h b/drivers/net/ethernet/ibm/emac/rgmii.h
index 8e4e36eed172..170bcd35039b 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.h
+++ b/drivers/net/ethernet/ibm/emac/rgmii.h
@@ -52,8 +52,6 @@ struct rgmii_instance {
 
 #ifdef CONFIG_IBM_EMAC_RGMII
 
-int rgmii_init(void);
-void rgmii_exit(void);
 int rgmii_attach(struct platform_device *ofdev, int input, int mode);
 void rgmii_detach(struct platform_device *ofdev, int input);
 void rgmii_get_mdio(struct platform_device *ofdev, int input);
@@ -64,8 +62,6 @@ void *rgmii_dump_regs(struct platform_device *ofdev, void *buf);
 
 #else
 
-# define rgmii_init()		0
-# define rgmii_exit()		do { } while(0)
 # define rgmii_attach(x,y,z)	(-ENXIO)
 # define rgmii_detach(x,y)	do { } while(0)
 # define rgmii_get_mdio(o,i)	do { } while (0)
diff --git a/drivers/net/ethernet/ibm/emac/tah.h b/drivers/net/ethernet/ibm/emac/tah.h
index 86c2b6b9d460..60c16cf7a41a 100644
--- a/drivers/net/ethernet/ibm/emac/tah.h
+++ b/drivers/net/ethernet/ibm/emac/tah.h
@@ -68,8 +68,6 @@ struct tah_instance {
 
 #ifdef CONFIG_IBM_EMAC_TAH
 
-int tah_init(void);
-void tah_exit(void);
 int tah_attach(struct platform_device *ofdev, int channel);
 void tah_detach(struct platform_device *ofdev, int channel);
 void tah_reset(struct platform_device *ofdev);
@@ -78,8 +76,6 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf);
 
 #else
 
-# define tah_init()		0
-# define tah_exit()		do { } while(0)
 # define tah_attach(x,y)	(-ENXIO)
 # define tah_detach(x,y)	do { } while(0)
 # define tah_reset(x)		do { } while(0)
diff --git a/drivers/net/ethernet/ibm/emac/zmii.h b/drivers/net/ethernet/ibm/emac/zmii.h
index 65daedc78594..213de06d8ea2 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.h
+++ b/drivers/net/ethernet/ibm/emac/zmii.h
@@ -48,8 +48,6 @@ struct zmii_instance {
 
 #ifdef CONFIG_IBM_EMAC_ZMII
 
-int zmii_init(void);
-void zmii_exit(void);
 int zmii_attach(struct platform_device *ofdev, int input,
 		phy_interface_t *mode);
 void zmii_detach(struct platform_device *ofdev, int input);
@@ -60,8 +58,6 @@ int zmii_get_regs_len(struct platform_device *ocpdev);
 void *zmii_dump_regs(struct platform_device *ofdev, void *buf);
 
 #else
-# define zmii_init()		0
-# define zmii_exit()		do { } while(0)
 # define zmii_attach(x,y,z)	(-ENXIO)
 # define zmii_detach(x,y)	do { } while(0)
 # define zmii_get_mdio(x,y)	do { } while(0)
-- 
2.46.2


