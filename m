Return-Path: <netdev+bounces-13322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E949373B468
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5B2A1C20EC1
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153E53A5;
	Fri, 23 Jun 2023 10:04:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B74525D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:04:25 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126AE10F1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f90b8acefdso5246815e9.1
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1687514662; x=1690106662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfAhAsug9ufzHE7mkap9OTTt62MSzJGSWiVrEWzAwlU=;
        b=vlo7MECE6WT8irpc++QJKIGj2qAwuykW75HaE87JgC6WhZ4YtwBXnSss/nC8/z1pvI
         hjPF5qA4MGdqEiG7FBROddqvRiVXtio+8xH2wHemsUhm1mlCdrg4RhSn+4YID921UF/Q
         5TlcSD1WgwuqPAKcfVs9noiQ7Y4rNAiKBUnCVjJOrJL50KuwnGSC7Ny2bHov2cl70MTD
         0tyXOElThG+N8HVivMT3MrZndyva1w1s5TVe2fxvBt4jq97h41cOaPi1YI0DIjGKQuAV
         3VYTPlAYxeyP2m2J3+0QNroKNUe0KRqYhGo163XT4Lpz8Y20c/hTnxchH9Ztn6BtX7g0
         f62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687514662; x=1690106662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfAhAsug9ufzHE7mkap9OTTt62MSzJGSWiVrEWzAwlU=;
        b=gKJxSdidMAgg7hyFv/2cqC7n+mxsp5XuCZaSc9sMXt71n2lktkxFqi2h34AfqdO0pU
         5fR5GZmB/IaMcSN493DhPJlWMj8Qe7fCRiwWWtdjSj8dugQoi+oPvwhUCMIdI7OfgmG1
         rGypM9n3QbAtbPG/V4rHAKI9p1fZ8ydXJD1EwtTOVic/cPCH0s4WJ0wsXPwXZBCEdztl
         raAUPqN6wjxTUvd/rT7G6hiK7p6rtyMnRwbynBAfOU57uX5wtkZ9vvweTOjKfZ9TtJ9+
         YEmzQfNqYYzEeitvK2e7X82komDnofJpTw41LfL0Ap0L4oHsBzn973dpLtUoUKntG5lz
         wykA==
X-Gm-Message-State: AC+VfDw8/C3M68IPmLEkE+6c7FzFnV2qQd4iIsG2DK7QrkdoV7cN2rdb
	i6jggf70HCgbEyn/8ORXRzh5NQ==
X-Google-Smtp-Source: ACHHUZ7yBYg7767eJ6l0yNyjOWhD+B1pFOg8mtipHqxiEFN19KDOEVQ4rtrMgdPufUYXQ2uhXSvwnA==
X-Received: by 2002:adf:f203:0:b0:311:19df:dac7 with SMTP id p3-20020adff203000000b0031119dfdac7mr15154776wro.28.1687514662647;
        Fri, 23 Jun 2023 03:04:22 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:ddc2:ce92:1ed6:27bd])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d54c8000000b0030fae360f14sm9079360wrv.68.2023.06.23.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 03:04:22 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Junxiao Chang <junxiao.chang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v2 01/11] net: stmmac: platform: provide stmmac_pltfr_init()
Date: Fri, 23 Jun 2023 12:04:07 +0200
Message-Id: <20230623100417.93592-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230623100417.93592-1-brgl@bgdev.pl>
References: <20230623100417.93592-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Provide a helper wrapper around calling the platform's init() callback.
This allows users to skip checking if the callback exists.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 25 +++++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.h |  3 +++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3c6b55b60461..41ca4fc9f863 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -701,6 +701,25 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(stmmac_get_platform_resources);
 
+/**
+ * stmmac_pltfr_init
+ * @pdev: pointer to the platform device
+ * @plat: driver data platform structure
+ * Description: Call the platform's init callback (if any) and propagate
+ * the return value.
+ */
+int stmmac_pltfr_init(struct platform_device *pdev,
+		      struct plat_stmmacenet_data *plat)
+{
+	int ret = 0;
+
+	if (plat->init)
+		ret = plat->init(pdev, plat->bsp_priv);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(stmmac_pltfr_init);
+
 /**
  * stmmac_pltfr_remove
  * @pdev: platform device pointer
@@ -755,9 +774,11 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct platform_device *pdev = to_platform_device(dev);
+	int ret;
 
-	if (priv->plat->init)
-		priv->plat->init(pdev, priv->plat->bsp_priv);
+	ret = stmmac_pltfr_init(pdev, priv->plat->bsp_priv);
+	if (ret)
+		return ret;
 
 	return stmmac_resume(dev);
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
index f7e457946681..6a2cd47fedcd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.h
@@ -19,6 +19,9 @@ void stmmac_remove_config_dt(struct platform_device *pdev,
 int stmmac_get_platform_resources(struct platform_device *pdev,
 				  struct stmmac_resources *stmmac_res);
 
+int stmmac_pltfr_init(struct platform_device *pdev,
+		      struct plat_stmmacenet_data *plat);
+
 void stmmac_pltfr_remove(struct platform_device *pdev);
 extern const struct dev_pm_ops stmmac_pltfr_pm_ops;
 
-- 
2.39.2


