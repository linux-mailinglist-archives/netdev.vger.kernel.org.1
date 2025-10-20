Return-Path: <netdev+bounces-230839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E20BF057A
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 11:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178823B549D
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EBD2F6900;
	Mon, 20 Oct 2025 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhBYNuRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE52F6574
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954179; cv=none; b=KwC2QsOcA/MNboqRO/ixDDsHKhofJyGML3P5FNjBKiLIYcZ81ETOZId9J4AiFxTyHNx4k4cHQ7mGrnDadygwUoWT300birabJkPVzv1AJlS7ALTUgnLuUqzaS4S0NLVEXhmAQN+0P1/geoNcRUA25NX6Ia2N0MU69c4lvAA8o6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954179; c=relaxed/simple;
	bh=+B7PvhGg1S0PvwspMXETMgLYp/UFFAeeaKBgvPZ6eIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFlNUEyjkxzptviaZKy4/QOOQuzC5fwbq0fUaRqTg4/uz+v0XFolfQ/nEwgepy8BvmuBSBhYLWfw+KMI9ARKjoYgp4e7R7ZZF7LlGd1rK2nGgDMrU6Fd4Bqk/r64+vNFSoh7WCdILPJIAi3qTQxS4hJWdiMvI/Gtc5VnnXHU73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhBYNuRv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3490147a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 02:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954176; x=1761558976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZEu6atp1wquusXB2V3FIm0pgDgjjEvvFZHTGTlW15k=;
        b=NhBYNuRvjS2ScG4xVzpvUN7roYkGgOJyYjn9l2+JK+bSiYA8jBntGhLkbY8RyAVHMJ
         /JdOQt7VPya+9s11SXSKrTTgciV8fw7D4rD55Ls4xJjLAkOED82JTbxO7W3nHmxOTcPS
         mzHyouOZ8yry5MfWANo4VFJr7mPbDwaSlkgL95vMKwgYMiYUdhCFrLiHB3+nslapxwr2
         btSHwsocopNwObOH4r4/sU1Rglwovq+jlYiEVd7SgPPMODYAPr9l2OrzcvIxeo3a7Avt
         JyTxTjiyigW/4djIfiHMLpyP3Oi6WMhQ5F7MX+SN7dfuTkFiGTcbvlCyn86Xsr5mL4JM
         nryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954176; x=1761558976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZEu6atp1wquusXB2V3FIm0pgDgjjEvvFZHTGTlW15k=;
        b=OsuM+kpJ2GNKWTgBjPw4ZGzvniVdkBz43N9JFm6xvcadKgRnWDqA2CfMohv3xT5URG
         S1Pqjz3rB2cHynXYWZOXasl2rbCnvls0xKulxRCgNYorgO3fFX8rtyeJIAvf4exb4H9R
         IEgt97wNOFMUBHKJ6O+AUTsGZy2vbdViiHgIjjRRWIwlVihlexNdWtg/t4LTva4Nj1F2
         oGMMHpuYyQ/wk1vhiJLsfEkdIzGbyCsHrUlOXi6NfXSBEWkFQarypPzA61dJqe2IqkG7
         x7yD5an6fk0JMkzmdTQRP3KroiHT8VYsQl4Fna18GROS0xUjmF0FYoJ+Vf/m4wbfDk0b
         XF0g==
X-Gm-Message-State: AOJu0YxEZlC7VeuIrWe91+FFVbgGeurVBcFPpX7OTj7UnmmbewZNYUHf
	AOibHfdYyas5Izw7wjE09Fv1qF+ApuVRbEv7ncKsPlleXuh0fcWsgNiS
X-Gm-Gg: ASbGnctGAZ1CY0v60MGBk6/19D9kiqpYqgAz8YLMXY4twRY61/wKnmfttBP7C9NYNca
	ARx+bZEs7+s6TbCZYTiZf9eeZxUCwgtzzeA817eVOEyqXLaasLM0iDbpxPZg2Ktq9zJ8GoBT5t9
	iTxXTwlAHFQPyv2Qrhf1sRrhCgFuzLube9uTpmXQvWOFfBtP+amNwgN8u1j3tAIw6fC04ItTVDT
	vRbR5u4+/z16+8LY042+LOjXs4MxqpvH/y2UN7R6QoLw9ib0w/30ZXPyx7v4WdEbrZ9k/vi0WRw
	qIMcjMAmVXkMQvRMfLPRiSz8jJ3IWjCypyXlYQ4V3HHJJnN2JiJT2yd63GewNFTFYdIFgcFQTyl
	LFqoxO5ZQyuZcRn5Mm9vz/vrhdf4uRGifejTz6dqkDE6G2qRqXK6UWHz4GLBC8vZoRGIV3JZMAV
	c=
X-Google-Smtp-Source: AGHT+IGGbVMAvLRNPJzY/dwiHRiAXKBM0roNWAjS8uuWlxmmRK+1VU9M3wcXUApOTf5kLg4NLvhkzA==
X-Received: by 2002:a17:902:eccb:b0:28e:80d7:662d with SMTP id d9443c01a7336-290cbb483demr161050105ad.58.1760954175971;
        Mon, 20 Oct 2025 02:56:15 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5794sm74880555ad.53.2025.10.20.02.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:56:15 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon, 20 Oct 2025 17:54:59 +0800
Message-ID: <20251020095500.1330057-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020095500.1330057-1-inochiama@gmail.com>
References: <20251020095500.1330057-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sophgo.c  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..960357d6e282 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
@@ -7,11 +7,16 @@

 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>

 #include "stmmac_platform.h"

+struct sophgo_dwmac_data {
+	bool has_internal_rx_delay;
+};
+
 static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 				    struct plat_stmmacenet_data *plat_dat,
 				    struct stmmac_resources *stmmac_res)
@@ -32,6 +37,7 @@ static int sophgo_sg2044_dwmac_init(struct platform_device *pdev,
 static int sophgo_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sophgo_dwmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -50,11 +56,20 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;

+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay)
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+
 	return stmmac_dvr_probe(dev, plat_dat, &stmmac_res);
 }

+static struct sophgo_dwmac_data sg2042_dwmac_data = {
+	.has_internal_rx_delay = true,
+};
+
 static const struct of_device_id sophgo_dwmac_match[] = {
-	{ .compatible = "sophgo,sg2042-dwmac" },
+	{ .compatible = "sophgo,sg2042-dwmac", .data = &sg2042_dwmac_data },
 	{ .compatible = "sophgo,sg2044-dwmac" },
 	{ /* sentinel */ }
 };
--
2.51.1.dirty


