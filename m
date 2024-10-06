Return-Path: <netdev+bounces-132440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C710991BF9
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D87F1F21CE1
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424F7170A31;
	Sun,  6 Oct 2024 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZeN8UCr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E01684A3;
	Sun,  6 Oct 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728180388; cv=none; b=l2V2QmuBXY6zTyHvw24BMNjzuhI+Ht/De85Jl4NpG+cn4oJUTIzuodUtDEKKV73vN4HTJywz39Q4531jVe0U1jx1qf+NBUEuRJgw2LsMrfAnFRpk/7nVZFu1wRM9vet+99iyp5Xyhlxo10nq5+c1CHlU2cOTY2aiJ9XXi5+3rG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728180388; c=relaxed/simple;
	bh=q7o0cJMxi0DzV78pTyqjiFVSs0dDSozXPCzq6LyjX4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9uST8ulnCI6hCWkhEae8tk3XRfnRzI14JIIPcSIerTNsU9juGIQxYfd7Ok4wgvCifjYoYt6U9e3v7+9vp3vhRyzugi6HyGDVHfkr67vlphaDbWKVZhJnyWgOZdNBfyUmwSx+4f+bpyVgQuiCbOMto9BLmmHQHNh+0rR77t6b5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZeN8UCr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e01207fa0so22966b3a.3;
        Sat, 05 Oct 2024 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728180382; x=1728785182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TyijJ9HqzRmIYvYkc7oUYJVhtfbDNhwf/UapPkOZEc=;
        b=RZeN8UCr4xKQDdFeWLziL3mG9AqNvtNNjoW8ju62LfF2auE8meahbd6frHoSYeCh2g
         F8Y1S6rEXfA8nA5mNT9y7jt0sEjdTEDchNCTRpmtlpgKImtbDH2RyFp6SWFIN23FN0UP
         EIFx3I6+COreIYFus9pz8+p+vdEQHddbDOgN1mchOTdudNfLQbt2AeYY3sYMGGYCq5PQ
         Fs/TXSkWniBdleKsFY5zLfzdfOGvzA69cwYQqJyJD4V8eT5z3jEVEhbr/KxOJ1iB35o/
         ys6S4WC1DAKr5a/UuFgiXlEKsZ5bwLhH42fGya0sS+/xuYTfxeBLgBZwjd3F+fKmL+7n
         dlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728180382; x=1728785182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TyijJ9HqzRmIYvYkc7oUYJVhtfbDNhwf/UapPkOZEc=;
        b=ketnjvD1MIKp1RY9z1lbeMD+jIlxfugS3y9f9nQctXKC8GsYGcsiSYzzHpL3UABUcM
         SVyex8s8mctTTq6o51D9AI6bVYxFa9e4n5+UOyZJ4gQmetf26MIJMhe4RS3qBH2rEdzQ
         0pDnKv0MGd4rK+hgWlOnBGEJhpOdv/IvxP8+ISo2PizOBCyGwiU2eWKbZHhxuILbW+NR
         +ISn/laYGIS1e08v3qkGqkOKCYeFOG+VIZxpa9O1Y7j1uL4qkKWm/s5ERN9cQoZqVUDi
         ndrd7FW8rX3sjOqVNcTmb7qOGZFBZln392yStR9VJYbJmz6KRbKvli2Rg8XE4d9ssrOn
         7Kqw==
X-Forwarded-Encrypted: i=1; AJvYcCXgHWnGkuBxNgIfH+2S2cuP6rvw2b8+vnhMMWfjea37LmmNlgjiYV0FXUefBY6ZlV3UHvt0uv5F0VFRMvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJi+xeG9YSBEho6XNGLUBizP7cHaKvvuvBZ3EtGfu0u5IhrI1
	cqjeljyYdDdcm5U25hwRnhrWs0iZuOPF8rRS5eZGYZp/2BHK4dMiLZDafQ==
X-Google-Smtp-Source: AGHT+IEc5g/BlvwiwXAXkwe/98XTL8Fuh9OOOXGnaFAURcBolsBmcmCy6x/pPzhUnAqh0jal+xUTow==
X-Received: by 2002:a05:6a21:3941:b0:1cf:2513:8a01 with SMTP id adf61e73a8af0-1d6dfa41684mr12206855637.26.1728180382059;
        Sat, 05 Oct 2024 19:06:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f683153asm2034212a12.50.2024.10.05.19.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:06:21 -0700 (PDT)
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
Subject: [PATCHv4 net-next 2/8] net: ibm: emac: remove custom init/exit functions
Date: Sat,  5 Oct 2024 19:06:10 -0700
Message-ID: <20241006020616.951543-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006020616.951543-1-rosenp@gmail.com>
References: <20241006020616.951543-1-rosenp@gmail.com>
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


