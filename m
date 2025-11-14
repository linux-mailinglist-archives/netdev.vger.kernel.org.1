Return-Path: <netdev+bounces-238541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAB7C5ACE2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDA23AE917
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE76272E42;
	Fri, 14 Nov 2025 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSZGeRAf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95CC26FD9B
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080725; cv=none; b=InbIDLYSbxgrX3wf0RjfROuctMGdyiGlm4gQ5qlH1sYASg51qsAHu6U0wAx97CY8qBlY72pawV+8DOJuu4l8dNUuTAOb7lkWRVo9wbKu9zPx8zdj2pU07a4RKzALsiBw2JUI2kAO5G8T10KlnqwHHRRXWylcgZTw7u1vYPgyg6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080725; c=relaxed/simple;
	bh=rxp/NrNnXrKf8e0GBNNTRnLO6fRnsXQEhl3HcuPYlQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zbshq1EuVyRAAASZTWP0yfYtW9h2WaDlal0O5+i4y9GdpX63c1M1ZKE5Eu86boISYM/dbjS/yA9Mmq4N6NuVHT6rUszeDo4KgmOgSwgZu7tSfxFNXBeeIXtCw5emYAwTuD4CdNiL4H1YiQF1xlO+xwJMsAifjjhbBQ6xY1AKZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSZGeRAf; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b98a619f020so1130609a12.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763080723; x=1763685523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpMkuoemEQ8nHGHR+sKpMED/PEl2v5+7S85Qkm8JY+4=;
        b=ZSZGeRAf2JLASbtROjIzWaYq9sNu4JejvsWnHk2DKY7fc1prl9yyfmCHjW8VC3JKTI
         +GJXCGMMRBdrglJi1d8cfPZq6cQ9Y0/EEgJ97Cv+UaLf4nKDUre8YDBo9b13XcDMn5UP
         hmM4Gl21JGh7jbOgMjjn0fgdfN0csbcf70PKmwIFKBI6/WH9qx5KjRYw4QdeZhG61lFR
         bDugT6ZYALrxMdin5htfBDixkTF77bIAeu7kg5XPnqsZB167sJwoepKPMKIHLE01+kye
         Dfz1Yrt7aD8fT5ujxDkMGjQafzs1hvXlpBjzKHRcZhXxwLT4TcEb6+a1vXS/KVk7BZ2l
         TEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763080723; x=1763685523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpMkuoemEQ8nHGHR+sKpMED/PEl2v5+7S85Qkm8JY+4=;
        b=wfy1+QdO2fwxWi9n9xDaIJ2wv1dOFYymzPD4h8C7E8Z2hDWMjPYKsjrwGaR42IT9wU
         jJ+Yy7R9PEh8rQyCMnfmv8cXCOdCQEdTPfQeQYKPaLCgJDnyud/5Dx4u28XqVkVP+OxS
         27VfK8EKt8UbABLrkrzHcR6GnHJ4yVftBNyd7PyAhy9UxLsjNrJPdO/u5orCixl1ftnv
         xrraQWgz1BN6PMSJclmUxPJArzJjvOWG6qhNGvR5jRdC6ZkpFAFsKF7b6iiPtpNVRnLM
         3BImmEKoayqZ4OQLAqVFjhBXKqG79KVBjr30E8y6NY8se7qQyxT9oNue3k5dkMG+xF6h
         Iisg==
X-Gm-Message-State: AOJu0YzatcCmy69o1OqhuILUezsjij+XFN2sDWyp/dgp4Tkj3qQNQP39
	8g7bG1U3ZCWY5+6zzT6D6kaZYxEmtyOsJSRs/WXBFi4NhuucJm3Kbx5z
X-Gm-Gg: ASbGnctnARkeJMS6wOLSNdcFQ8HRdoD9XZfBCbOApfUv8QkHdpjM1sXf4BosiUwOIyQ
	34wIYjJTXux3sX7uF6zzyHMPuG0aDueFKxHjD094FZxrlxPBky0L2XRCS7xpjDh4xIsDc9PUyE7
	keJdOEnCU8JDVLouqbl8j3UDDtdEEyrgPy25r/HpfLLi08ChkEh7+Wz5ofIDUBk/39T8iMOtK//
	bsh2urIMNhmOJLw1saWuiRqxwB6jOjW+W6VYZzevJ8DbHSAZ4xk8I6xh1W3RmhaWyg2P71YxLS0
	RIUhfXF8FjmGkLJcxcj2M4cAqUs3Sk5uV+9BqsaWZub/VvtEkAB6eobH2kdMRVljVVoqeZi+s3o
	HQtowtw8nF6qcTjr7P8+s4OYke/3CZ8btcXJ83GyYPpGujnmHNgjoCSGkPP7n+oLaoxz5PfYYDt
	I=
X-Google-Smtp-Source: AGHT+IHI/lUdW0Aaq91gtsiZA71Q/CcEnh/FJg4f8D3Tkw7Zsxdk4iz040Cwd2DXuBeB7xK+wipiHw==
X-Received: by 2002:a05:693c:8019:b0:2a4:61d1:f433 with SMTP id 5a478bee46e88-2a4abaa29cbmr464993eec.16.1763080722822;
        Thu, 13 Nov 2025 16:38:42 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49da0662dsm4527148eec.2.2025.11.13.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 16:38:42 -0800 (PST)
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
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v8 3/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 14 Nov 2025 08:38:05 +0800
Message-ID: <20251114003805.494387-4-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114003805.494387-1-inochiama@gmail.com>
References: <20251114003805.494387-1-inochiama@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sophgo.c
index 3b7947a7a7ba..fcdda2401968 100644
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
 
+static const struct sophgo_dwmac_data sg2042_dwmac_data = {
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
2.51.2


