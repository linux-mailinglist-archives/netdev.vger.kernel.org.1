Return-Path: <netdev+bounces-163351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFDFA29FA3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3BB166192
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD937189BB5;
	Thu,  6 Feb 2025 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQl5bccX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C291862BD;
	Thu,  6 Feb 2025 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816293; cv=none; b=GIJaY7zPEMFwphWJ7THtC2qjWzjahAnJnSSBMCNsML1Fw2WJYw34IegVlRjy2Sq8ls1eWqel8dWx6BwvyFMQJJYTCSf+KuCsATKwPJXq/zw1a5HDvB3hY4oZ/r+aD92i5iDORoVn+AjyZ062vh5S4Jqhpx8xRI6KgB+6XU9ag2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816293; c=relaxed/simple;
	bh=B/54zHisFFydosnnsHrYfaMylY07fnwwe1l9UqL1r8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOYuaYHU4pU/m+5B3oIhhIMQjQeTk36mK+7BcVg22Ycuiuzof//2BbpHzNplv3LBGrlmzEhk07doS155hZnTITnm1+kn3Xgyz3u2lRnVxjpo1A0aprXcszkXXAoPYugMMPGl4LOCd0/0d/1qlWHKKcL8oLTFj77a3FSX6NOlwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQl5bccX; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso631444a91.1;
        Wed, 05 Feb 2025 20:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738816291; x=1739421091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmrgzTuzxI4DkOliZxCFpnbS2H5tkr7sWJ12HUTrkek=;
        b=AQl5bccXGGK2B3twIrR95ymObr+sQguECsjr+rXfnlHYCT//MVvBUKqEhcKpEMfumz
         YrkcL/UqueqdV5HvdRMuOyybDqyM3GQziTgLSlkPw0SqvJBaimON8XA6EavPzwQlVNQC
         KMl8Ia5aczJocSsS6o8F0xksW4GAu7JT8EbNnea4JyiKhPeJqNOh/m9d/8rd7aCD7/J1
         9Sx5jb5eaZbaGp29ZJQnx1FoGYDnpCgcEa6gbP6BfY00cnPFzqLCWl+GD5wHdWKNZdAw
         495qdjkhOTVIL3HDSi2MKi9LSMbAwDLbWUN6OupaJ9FfmmBTR61k56h3tiRlHcD4ttsA
         yCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738816291; x=1739421091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmrgzTuzxI4DkOliZxCFpnbS2H5tkr7sWJ12HUTrkek=;
        b=YUlv9W47hYxlewQZ+LghecyijTkifVKQCGLee86PF5vGhAgLB4mf5UsjrTiWNK1r72
         h6TtcjqJAPwd1mGHUciV/x7OsE+aK+KK19nrxmN61fn+j9X9ynlczuG2AygPxX/YazRX
         fV+xrJYckqzNe7YGC+ZB6Ir/clvpa2CYz8KtxJxNeWm9RvGvVsoz8UBjAdotnzpcq3Se
         8ozD+lBrc/j42MOupEJU7QirlW1iothdydHey0gzXD6RfUD78+3osHya3HH72WECv1eW
         sEi9Vs8LFRQQLN7ARGobBTNHaXi8fwLBwfRsIvEno+8I883Wk1WeYNhM2UOrchjpgaHW
         cT9w==
X-Forwarded-Encrypted: i=1; AJvYcCXWqrTDMRgydrDEmmpWPwCxEvg3Crz1EbWatI7Jt+BgYCD+5CmUawj0uBN114jI4LXT8DjZR/UZ@vger.kernel.org, AJvYcCXl1a53vbBcE5KsR6pbYdnr1KTMLSnTuEZx0fsQS9mXzWj8739MxacDD/nTRE+tXmmTmbkpZqJ6+wu7zMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIvW1lbSksw3wsVOlDnf+SFJsBTn2FK9P+KVu8PRiKexX4UjHc
	4jJVneajdqK+g4mV80Xm64D+nr/8oib0hLXhqX+yvoVi+qMTnLbK
X-Gm-Gg: ASbGncvRnnOie3wfR78lQ4hPObH/yvyLqex2GVuUyBRCCWR1CA/lV24diD4YGIgWt63
	4R/aby52p3qrO4LWfDyv8ullF0mhxiCmOuyN19CW5kstYxB6N0CvlP6X0RZ752kLwXZ05htYhgR
	1evLsiyEMV4RZZelTJf1hpwmftMVVPER+wwrHSmMTs8bUlIlYngrS53HjbpNq+uU8v6SuhE5ASL
	5WQzwrUWWoCACzHKF+TwngRAuhlujHPhWuP74M4sYhyp0S0sjRRSWNnD+6qRafvc372AU77zgKG
	6Cs+IDDrgFQLYl+Fad6TfbCm/60ON23EbTE=
X-Google-Smtp-Source: AGHT+IFPaZen2nMZZqplQOVhlWKjL7qWYOlES5pIYgvdbjFcB92j9+0qa2y53nOssJRgqz6zeR5xbg==
X-Received: by 2002:a05:6a00:6018:b0:724:bf30:3030 with SMTP id d2e1a72fcca58-73034fbc86bmr9507529b3a.0.1738816291568;
        Wed, 05 Feb 2025 20:31:31 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162f6sm305013b3a.143.2025.02.05.20.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:31:31 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] net: dsa: b53: mmap: Add gphy control register as a resource
Date: Wed,  5 Feb 2025 20:30:46 -0800
Message-ID: <20250206043055.177004-3-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206043055.177004-1-kylehendrydev@gmail.com>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give b53 driver access to the gphy control register by passing
it in as an optional second reg in the device tree.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c    | 8 +++++++-
 include/linux/platform_data/b53.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index c687360a5b7f..8157f9871133 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -28,6 +28,7 @@
 
 struct b53_mmap_priv {
 	void __iomem *regs;
+	void __iomem *gphy_ctrl;
 };
 
 static int b53_mmap_read8(struct b53_device *dev, u8 page, u8 reg, u8 *val)
@@ -251,7 +252,7 @@ static int b53_mmap_probe_of(struct platform_device *pdev,
 	struct device_node *of_ports, *of_port;
 	struct device *dev = &pdev->dev;
 	struct b53_platform_data *pdata;
-	void __iomem *mem;
+	void __iomem *mem, *gphy_ctrl;
 
 	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
@@ -266,6 +267,10 @@ static int b53_mmap_probe_of(struct platform_device *pdev,
 	pdata->chip_id = (u32)(unsigned long)device_get_match_data(dev);
 	pdata->big_endian = of_property_read_bool(np, "big-endian");
 
+	gphy_ctrl = devm_platform_ioremap_resource(pdev, 1);
+	if (!IS_ERR(gphy_ctrl))
+		pdata->gphy_ctrl = gphy_ctrl;
+
 	of_ports = of_get_child_by_name(np, "ports");
 	if (!of_ports) {
 		dev_err(dev, "no ports child node found\n");
@@ -312,6 +317,7 @@ static int b53_mmap_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->regs = pdata->regs;
+	priv->gphy_ctrl = pdata->gphy_ctrl;
 
 	dev = b53_switch_alloc(&pdev->dev, &b53_mmap_ops, priv);
 	if (!dev)
diff --git a/include/linux/platform_data/b53.h b/include/linux/platform_data/b53.h
index 6f6fed2b171d..ed73287e8ac5 100644
--- a/include/linux/platform_data/b53.h
+++ b/include/linux/platform_data/b53.h
@@ -32,6 +32,7 @@ struct b53_platform_data {
 	/* only used by MMAP'd driver */
 	unsigned big_endian:1;
 	void __iomem *regs;
+	void __iomem *gphy_ctrl;
 };
 
 #endif
-- 
2.43.0


