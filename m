Return-Path: <netdev+bounces-232320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7179C040FE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54C534F6DFC
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD3B2288CB;
	Fri, 24 Oct 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlTFWQqu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E7223DF9
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270950; cv=none; b=a3tlzwSIRpYsBjxp295ddfojjCfyHH/UfXR241LnAxh+SCeXPZJ0RQZOwmDKvlkdGtxUgsp9uAj1PAUzEpXNo/PNP3RtZap9XlWeGJYENyVokRQy/7geUN88IBTN7lAD/h3p8SSSjIBFQLI0wFUQHcbSDnvTuPx108o2lUIrVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270950; c=relaxed/simple;
	bh=P2La+FoJZ35MJzEo8yVcVLSFzhQhJljTmUai3XD3wr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEoMVg0Mq0Ag2b+9smWUYvn4ZiMqC+24fZmi3ctozVf6wWPawXg1//qxiNa3bVQjTNygU+RnSJJvV2/BFxeDlmegqgWzrujAAjuDP9+a3Lcw2HiG9atGz3pD3ORIUmcRPi8uApf5HhxkJ5v9EcIiOASjWASYQQf7ZbBctJoSzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlTFWQqu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso1137540a12.2
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270947; x=1761875747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=BlTFWQquanZcgkWqUI8akM1oo8M8Qm6KX5dxnptUhCScGhIR8O7o1xL11meRjKrZWP
         a6RtWwbcTebIEHa/tNAV+IbKpmdOLclfMI/rsBSH/ZKy4+Wm/l55vF+WwSmdjyK5P0aZ
         Vc5Mk3SkRCRrR8rRWLpfVpgR8YM4I4YaFAQkF19ziDfYkijlpCNu1oyuehW/f/aOXIFF
         YfwcepqDNnjkBCi/8Ppas+Hd6uGoml9vQESXkecLHW2MW4su3ThrMC8pFZioEvSRMk62
         QwGvNWOOLyFCjPpGkh1ozrFOCQpkIpD3VG13zfmSgjHNPT+3MkYtMQ8aYqHMqkjppGzA
         UaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270947; x=1761875747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6e+TNG8HQKWjELTx3r9i/rdMStiwaJjw+wxw++IoG08=;
        b=if8/LDEA3UWgSdBjdTBoSvzUSPiqMtQYbCqpaEyuoe81htoxnn5iU2MWoG6dxMjSvF
         eQGciO+bH3n2pZBOU6mc9zhyoB0cVr9ILGIiGg7Zn6GJsm4NZa/AtydIjbnzAsEBYHBa
         k4mxVT/+1amG+pRywMFM1Lrd7KXU0s4mEWHm0REZCQgJZjAa9i40sNnOhuucmu9SuV9f
         ij8zZTy0nH2FzHv0pgxtTJGmP3PwRe6cTswk7PEmI5qgN5MitQ+lvVOB1TVS4u+wQTqO
         rMs6mHZ3cYLY37oT+/An08eLzMcAbA5sOb46P4GI2UZKeklmENnf/0PpWhAFhHlU1CNu
         valA==
X-Gm-Message-State: AOJu0YwUisg7OC70x2kmn55AgyBQBeyWNXYrZ4nJXWyJEHatf/LlRlBe
	zImFwB9rtMkigIydTIsm4EAO4gpsR8yqM1aQnLt6FGeBPmO2xRTrnXSL
X-Gm-Gg: ASbGncsVFPUDcPsF3CZ4LqWNNpY7IPOCNRvDd89/VPfAARMLxl2q4Wvrk77jpZCkWf0
	6LBmPbomzQGJPZCdk8XTRO6YdrzBsNl/HxzcHwhuHUgHZgz0cSvhejxQ3DL9/GLX/2t+qdl0LrP
	yNxlLHPmSDIdSR4C/5fuC9buV29cZWtrzPStnCVA9Ey+3F8X5toxVSJDHV/laDKv4zsvceG7bWD
	rekNsmqZ0luowMpOqpRCsmm5B5SqVde35mHXCixzOkxS2bLo7Cc5BcD5i7nJ71zQwgZ6Pbp2OsY
	abIRjxVEhoYezufzObDnsLsVjOT5SdfvBw1mVrtKx4eccH2w4M1FWJRZ1bR+Z3SLrUzYZM9qa7v
	y/bQnA2S2SmS8s3PlkRNLp5MiyjbRYOJNm/1F7nJqH/FHf8P2ilE3QXIS0xOGEcAeh7u/vKg13O
	2EB5gDQWmuhQ==
X-Google-Smtp-Source: AGHT+IHpW5wlGIbn04l1ii92JJTddNPs25LrGmd/cpssrIhv3LxjZMplAv5M1j+a+0YAZnT5qvs+JQ==
X-Received: by 2002:a17:902:db11:b0:240:48f4:40f7 with SMTP id d9443c01a7336-290cba4efc9mr405211955ad.39.1761270947035;
        Thu, 23 Oct 2025 18:55:47 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dda793esm38533865ad.5.2025.10.23.18.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 24 Oct 2025 09:55:24 +0800
Message-ID: <20251024015524.291013-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251024015524.291013-1-inochiama@gmail.com>
References: <20251024015524.291013-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be removed
when initializing the mac, otherwise the phy will be misconfigurated.

Fixes: 543009e2d4cd ("net: stmmac: dwmac-sophgo: Add support for Sophgo SG2042 SoC")
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Tested-by: Han Gao <rabenda.cn@gmail.com>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..7f0ca4249a13 100644
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
@@ -50,11 +56,23 @@ static int sophgo_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	data = device_get_match_data(&pdev->dev);
+	if (data && data->has_internal_rx_delay) {
+		plat_dat->phy_interface = phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+									  false, true);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return -EINVAL;
+	}
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
2.51.1


