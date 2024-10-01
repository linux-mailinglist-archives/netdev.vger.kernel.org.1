Return-Path: <netdev+bounces-131046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105898C715
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637FB1C22197
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5864A1CEE8E;
	Tue,  1 Oct 2024 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGVUmoat"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9931CEAB7;
	Tue,  1 Oct 2024 20:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816332; cv=none; b=X+09fTahWcHevkgIMJjMuLmWAVaGDFFCr9puKi06AKI99Uik9c3HoWeAxghlmKzNpIz9gYvwzXRo9iyryZWVnpLXr6yIUDw0s890/3iEnwnSIia7zSuAhP+s0LAVH4WwnJWWte1mVXCaG3wNRwJEJuUnOKK1KWNo1q+XNz+NZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816332; c=relaxed/simple;
	bh=A+1j/Ugq/kUN7xpD6mKc0h/usxX2L7w7reuIgtpSPxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oLEN7nzh459LOHX7PncjY+q0mnLie2l1pPdDZF+nb05xGkLlukIILoioWHQW5ce/kwOuXMZ8Rj2VeF1exNWli4pckud2mpnovSPbUfd2AQrsNbbzBi0J5VvYwR9J5HGoiS2oX7GNDm8YrZyrAo/qR2n9s9tSCBP7ICp3eMPQbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGVUmoat; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b6458ee37so41997325ad.1;
        Tue, 01 Oct 2024 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816330; x=1728421130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIAV5bXXJI/k1ElcEpFKyJcx4VyhECZfs9bbGfC3jN4=;
        b=eGVUmoatpEdfBsIXIFRlrHP1R1KUdRoBcSrW9E6sxQ/qXO1YO3tEuCANA8fF/1zKDS
         4pr7pZNg/K9oaQ+J7Irs48zSVGzMBf8IJJS4peQ3OoYSRUvPkAI6w7jOhzYhiICQfooE
         3KWMpl7mdg+HNCUVKDTlXUaewrrTbhV2xiYyp//MljrbLfVRZiTbeiYfTjRSB+pe1UK8
         R0Pqh8NG6nhbLGvDGOXJ68R7k2fRn+FtZqWdqwxpTCsTfXQNLQsO1U5vcgsQPJ/T3g4I
         oSPLMLeBLRvyU1sYc7J7HuddBmV0bILn40dyuoPhMp5qgZcgE+8f8kqj8mOSkM6AvSqZ
         cTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816330; x=1728421130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIAV5bXXJI/k1ElcEpFKyJcx4VyhECZfs9bbGfC3jN4=;
        b=SEh/BFIzSrEcq/GBoyVOQwb2L22g0B+zbdg65W524h/7e02hRzn0uTYBiLaKets3E3
         W3Ywe+mvjx+z/E2SFrcMlkljqhLQldqLD3OqzXgdpDoJqHdWlg341RS4xS6iuaHQk/iO
         0M8VSyGM6jeb+4L6Z0/fNjhmJPzPVe0abPdFPPFyKaGzq4+5lyw7aQoBiixRztB2k/Li
         JE9eb0Lnj67rbRcpGeT8+tJt8m9mMNRZEAiybGXErtLKHUNHKcMD9kMdTCLskcKR3Yoy
         ilFGWtQ4qWSIen/DTKMlTapJkJPScpdy9d6TQDw4weW7Ov2p2BPgJuJ4TSUNWi+AjChO
         zxgw==
X-Forwarded-Encrypted: i=1; AJvYcCUuczmaavfjhWrjPGq64b/s+BzjEZHPiVZ2ittXkP1FPBywXa64KGVvzQAS/DpGnvwQY5n6BGuVnwlVdBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1u2C8ut3nG9NfQguP/L/jLbUiynofyG2sOvt4I7IOPftMLHKD
	P7sA7WNFznoVRgVM4E0XMiG+TE1940RPSz27Liuqj1//n2jzgfmYKqvbOFc7
X-Google-Smtp-Source: AGHT+IHE1+VXwxYDEtoSaaRpy5X0sJ3H8mwx9vxyCYdC1AeW8zrrppOQOLx3EnsCTwKIQlPN1ZsnaA==
X-Received: by 2002:a05:6a20:c996:b0:1d3:293a:47d0 with SMTP id adf61e73a8af0-1d5db1a4430mr1232825637.7.1727816329745;
        Tue, 01 Oct 2024 13:58:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:49 -0700 (PDT)
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
Subject: [PATCHv2 net-next 02/18] net: ibm: emac: remove custom init/exit functions
Date: Tue,  1 Oct 2024 13:58:28 -0700
Message-ID: <20241001205844.306821-3-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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


