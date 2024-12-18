Return-Path: <netdev+bounces-152815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C39F5D5D
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE390188D148
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655631369AA;
	Wed, 18 Dec 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="CfH3k6Zb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7014B06A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 03:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492172; cv=none; b=TA8ZPyBwa0AmaZBTszKatlazXAe1RW/KA3tFW9OGSqfBZoYL3Sda+O7JxBkoiwlo/iYJYZIvqjJYFvozWpTrMX540LdVHKYXVQlGils+J7TZ9Ysextuz26iZKgcry9khSKcWgwSgdUNhoSkyxgKsddCRDjHpRCdCFXM3R8KrmGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492172; c=relaxed/simple;
	bh=+O3eJn/t90CvIgKVKJUyIZ7oV6fPTqSOBqO4L3l2hG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ppe+1CZwcbc/MsxpdXx4AE8V5TtcAAkyw7N9EPBw9xo51P6BXrPckyv/96v50g8Pcp4QzpBx5Av+IRjZUHp7zRlnEovdKbHDtwrq/xb6Hf2ZrpvG+jzuSh6slc9NFE3HqpBZvbASWFi1jYO6zoZ07Lr8PZfs9QUsLOYLs6gSvA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=CfH3k6Zb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728eccf836bso5286526b3a.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 19:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734492170; x=1735096970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vuMlOm5Vhfm1uY+gt1Iarlvbs+b+hzsU/W/+TpNLRM=;
        b=CfH3k6ZbA+zra+2rml+gT2V526d0S66ppQDmqvQrfqsj8oLhnCFU7rD37QJJVyyOD6
         pqE7vkGLxOeywZfrNBPDlfDhMb7dq94IzW94w9MkYvfmfCFXPFI3TS/8n+2z0F8c0YMS
         IEVPR02zfwPwNHnsDQbTVBi0Ef5kGWNoa7bxMT7DjHlAteYblJZ7PfEJIk0vPuMpO5lj
         vvf8lGFkIve24+hcNcJ8doFfRgGtHIb1r6HbmdCXiuOqiKeiFKtLwFcg1MSdkNvRf9T9
         AFBCHS0IUFZaKcGyFvLSTi1l/LSNZ5bPrYYmE1oQ8hlfwsQqUHhgOFMdDvr6Vjnai52r
         M+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734492170; x=1735096970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vuMlOm5Vhfm1uY+gt1Iarlvbs+b+hzsU/W/+TpNLRM=;
        b=V/czhMPy+d0OUofPz8BvNIQK0mr1joE1vfnu6PKxGLJ7BqPjXmZouXLj06YAsoqPsR
         nDvmZffIZQwPe2/nMCQMgUc2RjJW2WpsGAMMl+xcDTkYg3j8o6Ws02cHEjld81Jbjawg
         9ZikH9LqEHyaAY6Oi9JWPQXksTS663LvrFMVqUAXGxC+p9oKTB/VAczn8aXm5oLySfvh
         aSxSFpzxTHlZBBgqI5FA6QaWkqIfZZqfxA6kV+/IT38duWZjeGmqVYCm7GyOV9WKLGhm
         47/GbkflRuyfdMf8UppbmAcewUWU7hhmwbLi0u4g9VtRwBa9MppLdaZeuMSSCEFCVwki
         YMyw==
X-Forwarded-Encrypted: i=1; AJvYcCXqUTMgCLWXqPnLxGWaK2X5L6ccvS45mNo2l+sdLMYe8elcK/i+w2myRqy92bIu2FSek7m1PVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELfqQI/mkjIkiK6C3baUJvSKsgOWMGgH++cD2t5uJn6V/BGpy
	WVpjN4Q66mJnR1lLMrftcgX85/V3r2YgXHynqGtmgfRN4hZOJVV74W7mdZN5c3k=
X-Gm-Gg: ASbGncswIYSgN1J26tuL4cTu5WqemogSYM5e2LtXgxoA+n2+Q1GVbK8uHl4R0u/MLbE
	xUzz0VvqYicq4Tut5Jtn5y5NoqKtBoHIr+Rpm8LIg5Rhz3Jt9K00MH6tZ/Pq0LuRppJYZqCZLtj
	cS3RgwT/U0D6Ra9xUQF8s+ayv27LaarvKdm01YtMMR01aLJmMiwUHtNGX3ShlEkupmjKC6yHLWP
	CzOP76Lb8VEyP8VZAG8g1PRbRx8nRGr/URgi40i/f5DwBCaiwbthNvcRj2KG++Z04qSuQ+U3HZE
	SZmDpBvSbYjPYgSGQHU/clGZvH6kGj1oSmwXh1XZPmQ=
X-Google-Smtp-Source: AGHT+IF8fwSRfHcuWOf36OfOopQzL2j6KV+8JldHzRqRWJ7xQ/UyVl0JXNaUuzbM6ZfBXf/2BL4kFg==
X-Received: by 2002:a05:6a00:3a28:b0:71e:4786:98ee with SMTP id d2e1a72fcca58-72a8d2f0b49mr2057104b3a.21.1734492169889;
        Tue, 17 Dec 2024 19:22:49 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bb4037sm7453908b3a.168.2024.12.17.19.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:22:49 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com
Cc: krzk@kernel.org,
	dan.carpenter@linaro.org,
	netdev@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2 1/2] net: stmmac: call of_node_put() and stmmac_remove_config_dt() in error paths in stmmac_probe_config_dt()
Date: Wed, 18 Dec 2024 12:22:29 +0900
Message-Id: <20241218032230.117453-2-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
References: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation of stmmac_probe_config_dt() does not release the
OF node reference obtained by of_parse_phandle() when
stmmac_mdio_setup() fails, thus call of_node_put(). Also, the
error_hw_init and error_pclk_get labels can be removed as just calling
stmmac_remove_config_dt() suffices.

This bug was found by an experimental verification tool that I am
developing.

Fixes: 4838a5405028 ("net: stmmac: Fix wrapper drivers not detecting PHY")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 24 +++++++------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ac32444e492..669d8eb07044 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -436,7 +436,6 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	struct plat_stmmacenet_data *plat;
 	struct stmmac_dma_cfg *dma_cfg;
 	int phy_mode;
-	void *ret;
 	int rc;
 
 	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
@@ -490,8 +489,10 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		dev_warn(&pdev->dev, "snps,phy-addr property is deprecated\n");
 
 	rc = stmmac_mdio_setup(plat, np, &pdev->dev);
-	if (rc)
+	if (rc) {
+		of_node_put(plat->phy_node);
 		return ERR_PTR(rc);
+	}
 
 	of_property_read_u32(np, "tx-fifo-depth", &plat->tx_fifo_size);
 
@@ -627,8 +628,8 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 
 	plat->pclk = devm_clk_get_optional(&pdev->dev, "pclk");
 	if (IS_ERR(plat->pclk)) {
-		ret = plat->pclk;
-		goto error_pclk_get;
+		stmmac_remove_config_dt(pdev, plat);
+		return ERR_CAST(plat->pclk);
 	}
 	clk_prepare_enable(plat->pclk);
 
@@ -646,25 +647,18 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	plat->stmmac_rst = devm_reset_control_get_optional(&pdev->dev,
 							   STMMAC_RESOURCE_NAME);
 	if (IS_ERR(plat->stmmac_rst)) {
-		ret = plat->stmmac_rst;
-		goto error_hw_init;
+		stmmac_remove_config_dt(pdev, plat);
+		return ERR_CAST(plat->stmmac_rst);
 	}
 
 	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
 							&pdev->dev, "ahb");
 	if (IS_ERR(plat->stmmac_ahb_rst)) {
-		ret = plat->stmmac_ahb_rst;
-		goto error_hw_init;
+		stmmac_remove_config_dt(pdev, plat);
+		return ERR_CAST(plat->stmmac_ahb_rst);
 	}
 
 	return plat;
-
-error_hw_init:
-	clk_disable_unprepare(plat->pclk);
-error_pclk_get:
-	clk_disable_unprepare(plat->stmmac_clk);
-
-	return ret;
 }
 
 static void devm_stmmac_remove_config_dt(void *data)
-- 
2.34.1


