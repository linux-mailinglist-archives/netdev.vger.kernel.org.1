Return-Path: <netdev+bounces-134686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8EA99AD2D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CA21F23015
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5BF1D2238;
	Fri, 11 Oct 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evO+HeBl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101501D12FA;
	Fri, 11 Oct 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676590; cv=none; b=oz21VNCCeaPr7FUDqIkR87dzjbmjXPNx1NdRCg8nrg6K2hkdYELrMZiPqg6YHvM9b8+Xo69N0xYSPlU0eUr7H5D0CTJs86PrzDwPxjbXTIFHQ8KsqqPjBK3zIKdfGZcyrAuDnmnUQpPxWMTX5SU9n2GTsM6NQXSvYD+vOMvYR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676590; c=relaxed/simple;
	bh=rWIE6AzEKpQ/pvQarynoXz/6Z4ynRunIhDPpAobfBU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6QWUiOW6iPZ3DctVDSpwv1OHkuNdwAKatiLYO3K8Pkcx6nxnF9LkK6ZFq93px0gXxHr5ty636zdqCWh9vtTlQ7cS/tWY9VTWTOb8uizcFNajItqsCKjfsGl/xl09G9mwZyIjP8Jutlwi0n7ke5JvQ+rJyOIVpe4aJO/Ux5js58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evO+HeBl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a39f73a2c7so10162105ab.0;
        Fri, 11 Oct 2024 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676588; x=1729281388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5AdPdwexmsdQ/Ip3yENErmE21+w4ARrrMDZEEMRiss=;
        b=evO+HeBlgwh8gYxNC/FLCtemKsq2Pu+BSc0LXswMRChESYYJA+J8F2qewMeFqXFtrV
         0blztv/ECgfmdV6ZRxCYVVTLvEMA5lV0mrBYfL2AS8ThIllWkurqRU/3FDU/UYKeMhZb
         CSvHGlKJSPwpnjFsUF/B3CdyGSWEyAI66eAwfrUTqlWtCnpuZ3hKxKC5o0BeY4uyv/rf
         yhmGO/D1HbWAnQ+CoSosKA4MFH+2loR5azfRfQLjmTj6qIXYwgp++P3Hc7lNVsVwe+68
         SsSLVYzHRvOBlJUohvPEI3o2ZR1oOihb11xLr3YweATauqo6BO2bTGcS1elwftEgZzP0
         CFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676588; x=1729281388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5AdPdwexmsdQ/Ip3yENErmE21+w4ARrrMDZEEMRiss=;
        b=ssHRn5jMDbhZHi62yZ4F5ShqvQrfHbKLQc124ebm0aJU2JryPbDEdTH4VEVyQXcrZV
         xnXLC5/AGXT0RxlzE7jFjroZTHfWJ5pVUnQMntb7llXj8vNijXlOsVhsRScm2O8V+neH
         khAgeMMPUTMKI7tqmlRNAoV/bZbsMJyfYTE9iu68cOz3ztH6CSty+6ScKpNMSeiYAGV3
         0569OtjEeWAFCBP5iqhX6y6pVSTaUuRlGyoweNlv7TyRgQPXAAM8ayHKCXKPOTp3Ha+/
         sqJAr4WZiY0HieIph9qYaii3DCpWJ3szJmppaBz1yl5NHXv9iAdBoFHyKchGpfaokbQ2
         bulw==
X-Forwarded-Encrypted: i=1; AJvYcCV7xVEUjrCBsrK+wdbqig+3z1RhaY3AMs6yXa3brLaYKdQXClwXl3ug45fTorCYd5xOXtR3NEdg/8Is/GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiNrri+gB32YrST9hyvZGPmuji6c2RISvYMQB0K9AoU6MCejbP
	wP9/OE9MimpUj+sRAJOUG4wgKBRX3oZSaq4Lrsl1ObwEK3e6awZqzT9yvykh
X-Google-Smtp-Source: AGHT+IEvm46yJY1ltCeK+PSyYlevHyboN7e2hUk18afnl7CNyGCe1Q1NwLU1ceIBtm9+JkxN7ZTfMw==
X-Received: by 2002:a05:6e02:1caf:b0:3a3:778e:45cd with SMTP id e9e14a558f8ab-3a3b5fbc20cmr40973765ab.21.1728676587882;
        Fri, 11 Oct 2024 12:56:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 2/7] net: ibm: emac: remove custom init/exit functions
Date: Fri, 11 Oct 2024 12:56:17 -0700
Message-ID: <20241011195622.6349-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

c092d0be38f4f754cdbdc76dc6df628ca48ac0eb introduced EPROBE_DEFER
support. Because of that, we can defer initialization until all modules
are ready instead of handling it explicitly with custom init/exit
functions.

As a consequence of removing explicit module initialization and
deferring probe until everything is ready, there's no need for custom
init and exit functions.

There are now module_init and module_exit calls but no real change in
functionality as these init and exit functions are no longer directly
called by core.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c  | 39 +--------------------------
 drivers/net/ethernet/ibm/emac/mal.c   | 10 +------
 drivers/net/ethernet/ibm/emac/mal.h   |  4 ---
 drivers/net/ethernet/ibm/emac/rgmii.c | 10 +------
 drivers/net/ethernet/ibm/emac/rgmii.h |  4 ---
 drivers/net/ethernet/ibm/emac/tah.c   | 10 +------
 drivers/net/ethernet/ibm/emac/tah.h   |  4 ---
 drivers/net/ethernet/ibm/emac/zmii.c  | 10 +------
 drivers/net/ethernet/ibm/emac/zmii.h  |  4 ---
 9 files changed, 5 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 0edcb435e62f..644abd37cfb4 100644
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
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index c634534710d9..c66adb7f4e7a 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -781,12 +781,4 @@ static struct platform_driver mal_of_driver = {
 	.remove = mal_remove,
 };
 
-int __init mal_init(void)
-{
-	return platform_driver_register(&mal_of_driver);
-}
-
-void mal_exit(void)
-{
-	platform_driver_unregister(&mal_of_driver);
-}
+module_platform_driver(mal_of_driver);
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
diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 317c22d09172..f275ebeb7158 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -303,12 +303,4 @@ static struct platform_driver rgmii_driver = {
 	.remove = rgmii_remove,
 };
 
-int __init rgmii_init(void)
-{
-	return platform_driver_register(&rgmii_driver);
-}
-
-void rgmii_exit(void)
-{
-	platform_driver_unregister(&rgmii_driver);
-}
+module_platform_driver(rgmii_driver);
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
diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index c605c8ff933e..77e881efa598 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -161,12 +161,4 @@ static struct platform_driver tah_driver = {
 	.remove = tah_remove,
 };
 
-int __init tah_init(void)
-{
-	return platform_driver_register(&tah_driver);
-}
-
-void tah_exit(void)
-{
-	platform_driver_unregister(&tah_driver);
-}
+module_platform_driver(tah_driver);
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
diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index 03bab3f95fe4..211e843fdc7e 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -309,12 +309,4 @@ static struct platform_driver zmii_driver = {
 	.remove = zmii_remove,
 };
 
-int __init zmii_init(void)
-{
-	return platform_driver_register(&zmii_driver);
-}
-
-void zmii_exit(void)
-{
-	platform_driver_unregister(&zmii_driver);
-}
+module_platform_driver(zmii_driver);
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
2.47.0


