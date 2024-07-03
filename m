Return-Path: <netdev+bounces-109004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF39267F0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8BA1C25977
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1793818C348;
	Wed,  3 Jul 2024 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0TGKb5gA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F217188CBE
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030512; cv=none; b=j8KCeom3qcB08O2ghiR57Qd5sxViehcZhcHy7E1m7OBJ+KvEv/SZqUe6LLyWcHURNsmz17DIt9YokROiwYGZxW8ZQ2PAnwngRWuM1WMQTyhQd2UxwnX5WVydVx8//eMS2KS3D4k9aTHp0eri+lyk4K0Eum8WqgdcBiPXiQywlsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030512; c=relaxed/simple;
	bh=Nzm1nEbgG1D0fKsu4Slvc8dGgaXYua6EPR3wbZL6IJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YleZXBEhGzU+GYZ2GzuP482sC19qTRcLMlNYScYCSkpFrUgMr0NuqI+vuiSds031vZUFoCP/k2EFmgPZfybpycs0W6eQ4n8UtuCJ8cF2sqAsmPhd0mpdGUNF74iT1UswsTF//Ri2iEyxGkL8qgDO+kcBgxTf3BXwkmfLBExJjB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0TGKb5gA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42564316479so34998545e9.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720030508; x=1720635308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=0TGKb5gAt2SAnpMGpEjqfITXlMPG60r/lvwJ0UBmC8GfjCkXx66SePUWfPAjjxbfEe
         Jpbt24EN9BF4l3pkuY6xKYUlnUnSrQMf1sJvsFDna0RudrxDA8d3LbnThJ2KQCXj1nNE
         A54L2kuhQNGDZFBgfbVE+rSnybbfJTomrqFoMJUGwOLxXYxBMJRUe+vjNSTcSzqimp9i
         uCBaAHXCvZhHX0+/XixWjqrhVvimU+4rdB/VcnGbKWFjbyrN4WHvzPqsC8lA4n1xpAqX
         8weFX8neOdL5cX7XWtMuh36oSwouo9JcmHMfnh6N5MjntPMi2WjXN7qDM48BughbAR/o
         pjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030508; x=1720635308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxu9SpdSTVz3ebvxMLh70e0y0HDyyRtIxZX5+1VZmbE=;
        b=iRbyZ23nzdIJ0h/W+9oO77rGOr/LF1/4v8WHU/jpZVQLVYgG2/H4n9Hrl17Nu+d24d
         9jSs1f2GjKRwSld0j0nkZ1m9joE0Ut3wjDNDjaCibzGB/KQkpiCSTwmFKpp7UQRM/gUx
         21tlQ782TRAwZqbiM5mj6Z3owNUxCyrx5VUmseg9AlDHDufojs4tII2eHPPr0tmgwDNB
         PS0S+cvEP0OJQHOysnZ2l+FRjFhP2/K64gFidHiq5XZLl9nFIPdY+e9Le6bHUYTkfJjq
         ijOIQN06DlqjWe02uszzYsakkLYsLxI32zt46v598v6or7+aeipoBFo3DayBoMUL7YXh
         k2nA==
X-Gm-Message-State: AOJu0Yw8nKcpR468cbhx4L9Qar0drvTpSo3/vSywfCXL+84FbRrhOmvJ
	yowVJ/1vBzxpmotB1at6yI49SLO7gL19zkjkPS6QAdmRljltj77hAiiZ8ingiwg=
X-Google-Smtp-Source: AGHT+IEjkf41YeErUSmpNJnOMi95oDdVEgwvmMm7MFfhiFw5YUppyz+R82Mw2+TluKNGgFxKSGI00w==
X-Received: by 2002:a05:600c:3b1c:b0:424:a74b:51c7 with SMTP id 5b1f17b1804b1-4257a02180cmr81882125e9.2.1720030507898;
        Wed, 03 Jul 2024 11:15:07 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:c37f:195e:538f:bf06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c0f26sm245178845e9.39.2024.07.03.11.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 11:15:06 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH net-next v3 1/2] net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode
Date: Wed,  3 Jul 2024 20:14:58 +0200
Message-ID: <20240703181500.28491-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703181500.28491-1-brgl@bgdev.pl>
References: <20240703181500.28491-1-brgl@bgdev.pl>
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


