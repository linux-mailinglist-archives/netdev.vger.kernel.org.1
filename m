Return-Path: <netdev+bounces-107230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 002EA91A575
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE451F246EF
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 11:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D414D28B;
	Thu, 27 Jun 2024 11:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KtcJVRIy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B213F441
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488400; cv=none; b=SNWT95niqtb57E7N8udUTNR5w0/ye5khEoE/AU1w8Hds+KTixOtkRmo6AijFjcd/O6PFPdL+cNVqykq7U9zJkFePvinohv/8ovvoBJNcms00RnVT+KjFxfXne11M+rLLIXubSK3VI1VI2YzoKqjWRox6cXh5dUKpYBHHNj8ddXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488400; c=relaxed/simple;
	bh=Nzm1nEbgG1D0fKsu4Slvc8dGgaXYua6EPR3wbZL6IJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbOUGe7olKkK/mbZJIxfw/fv8jbo410DL5+2YfeyQ9KmaplLCYLlAAZ5cau/sj3fHlWnzltukeoEWtITKOCYnHxZHGNazZzrkguo1epsN/QNC2fbK84ax2qROfm3Mkg75gQMzERHXJCrIUWhAQlob0ARdptOXZAaKRS9RjnyD3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KtcJVRIy; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso93453431fa.0
        for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719488397; x=1720093197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=KtcJVRIyTDj3+PsuJ9LjDtUeoh7Ila/Kh3xkxhkonNMcc3R2+DtiKqj3Sid+mwOcF/
         3FNAEzeCzN9a14vPtFf3nhd4uwV08pRuFy25g/mSFIqoBdBvoH4e89c8dD8s6cUG17EV
         VNxXFSl/JaOPa3ZKuY6UTEjvn09CofREFvUIA7UtD3ZvQTM660cwWUXiZYByAbzpS/y7
         Od/MJ9XpXgUQvh8e6IEDWZT5nncR5EojuWnheVBnHRIZskmF5000A7TQ1rpKz0eJjIzs
         MzEG3uyiC8KvqDyNBd32Dj3i4GcLQp6j+ZRlM469CL25agbkSYw0RY394UnjVBC5hhOJ
         /tbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719488397; x=1720093197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=f3JgjM/zLd5bi86mxvFmOzbBQLqe5SZUWOHxSLoMuqjHywQRNFwXGK1x2+1LuhG8jN
         slbSSPrsxjqzHcJyk+dc2PKOga0xxQu8g1IgbFkWeyH6JOxTyJ6pK2jLYvW7X7zaHc6m
         jbsXjB52F9XUDvnDEw39Y8B8vwEuYZ+hKmv2RyEIg4D+rQyPRCMNP+cpWSzZgL453GWU
         7DyzVgLBbOkHpTgt2SogY/iQc026X3n6bjXt4qIwtQnirF2XQDFnk37vTGKTuXASzC5a
         LLF+DNHg0UgW44jBEL7YGnMcX0kf8pzbwI2Busf1MpNfdGvbRr9cjn3a6aRuBcw4NPX7
         /fDw==
X-Gm-Message-State: AOJu0Yw36+OP8HzVp1nBJtXE+mLw6QRqA2wu536wfkFLxatuxYgr93Sb
	PGVlkTIjGjRm8oeG8ZMTtjzb353asB8ij8vzwhyhnRdZvErzd11xLRyOIj0Urdk=
X-Google-Smtp-Source: AGHT+IEX942vNvyHTmy9tspQQQL/qKLX+sbQ4RkDTe+pTb3TOEUopxyuIw7WbECrr/t329Hui5TQGA==
X-Received: by 2002:a2e:8047:0:b0:2eb:ed3a:9c65 with SMTP id 38308e7fff4ca-2ec593d93a0mr77254481fa.15.1719488397179;
        Thu, 27 Jun 2024 04:39:57 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7fe5:47e9:28c5:7f25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8468613sm62081815e9.39.2024.06.27.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 04:39:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Vinod Koul <vkoul@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 net-next 1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
Date: Thu, 27 Jun 2024 13:39:46 +0200
Message-ID: <20240627113948.25358-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627113948.25358-1-brgl@bgdev.pl>
References: <20240627113948.25358-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add support for 2.5G speed in 2500BASEX mode to the QCom ethqos driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c   | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index 80eb72bc6311..91fe57a3e59e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -665,6 +665,14 @@ static int ethqos_configure_sgmii(struct qcom_ethqos *ethqos)
 	return val;
 }
 
+static void qcom_ethqos_speed_mode_2500(struct net_device *ndev, void *data)
+{
+	struct stmmac_priv *priv = netdev_priv(ndev);
+
+	priv->plat->max_speed = 2500;
+	priv->plat->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
+}
+
 static int ethqos_configure(struct qcom_ethqos *ethqos)
 {
 	return ethqos->configure_func(ethqos);
@@ -787,6 +795,9 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		ethqos->configure_func = ethqos_configure_rgmii;
 		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		plat_dat->speed_mode_2500 = qcom_ethqos_speed_mode_2500;
+		fallthrough;
 	case PHY_INTERFACE_MODE_SGMII:
 		ethqos->configure_func = ethqos_configure_sgmii;
 		break;
-- 
2.43.0


