Return-Path: <netdev+bounces-140883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2599B88C2
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B279D282A1B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD088139D0B;
	Fri,  1 Nov 2024 01:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdHIHbRw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2F681741;
	Fri,  1 Nov 2024 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425450; cv=none; b=pk6M7a9s1DLTRjOtV++szYFWtVvN2I7HKWeUx7vzSbhS9Jz1p2F7h3OUlLzvwlhaPNrDkRwl0z8TUlQm1UscLDrhhJht0MGG/haTMdnbZJwpJxKakXOfo6WDxkoqk5PBDO1yuwsljfyCrlI7c69uXdH23T8Kph4Yjt0klpzhtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425450; c=relaxed/simple;
	bh=Rm+galXTiV6N8MuVFMQgKwOoQ3w9H03hvs4ZTzCWpac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahKLXXuiJo4aWoJVympg3wmhGHLoGY9hnMdKvgxiQbQc316KgaJ+/NV2EaBPql9CvF1RRP4KzBzLyuo8WDD6ntyQ5TVYXGvg/6pwmqnUAkCbDzItOBJVxMfecD4FkBGRoWQVFz7ct5XRZH87GnL3bKfnPOvMbekv4GkLKcwQeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdHIHbRw; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1258877b3a.2;
        Thu, 31 Oct 2024 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730425444; x=1731030244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxfricRE7uBgf4L4U+T/hPqm/Ex2rRvslCVlqeVs1RU=;
        b=HdHIHbRwDawdNfR7aGmjjc9wTTrmBgr4Cds0CaBt4anDk96MNsE8L+S0gmmwrpzJgj
         xdcrpHZGpuSel9FVT/O0+A/o/uYrvcQIPcuCbflXjMcIWTcHp0z4vF1hjZXFuJc4+fg5
         0HqzewOZ4hurHpEsiyNrbOzZNeTx/G64Hi8WB3KroNS6qowIpjWfKjsDz6y094UdZIs6
         0MUKWd4RaR/21wsQAsS4F5v8OEjZ1TinAE4WVXxFSvHDedSxxXrr1t8EYGWrNqbt0rSR
         SsrImpjVyje1jEpo79La64DtttqiB1AicAfKcBg8Jm0M4JyScrZNl1NL3ycgYFkAEJU0
         dGJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730425444; x=1731030244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AxfricRE7uBgf4L4U+T/hPqm/Ex2rRvslCVlqeVs1RU=;
        b=iSpmQgUyIUTW+XGdZEOB6cS4xvmqcmqPEnZ5gjhgt+rKcboRzxGfian8QL2jWvl/Uo
         sEuJKjzcc1Dt00LuEtxTR5f5DNEAYKPSEhi2hu0MRQveaaPllU5xqnnqfx3pfVKF2kV7
         re5zvcBcXgMdiu5kmCatm0EMDoiqMaDZ41Qn8rT65REglVZoYJpnEZnm8q+8/gWEBUWm
         UhFUll8oHk0Gd4aHQnVhUm7jaJ8Q3DLyCZf50nWlYpw8hbor8mhuxWbsjDQ4eZr8cKws
         DB4vqkU3ZHgM/2VtX157CXvQ+pQb+alRqvaXDJP2WVCr8IHHX5GZcQUnHswZDccBulWc
         HibQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK2HQGieD/JmU25riC4JLa4gVMAzh260+7z/6YJym/3WEqMnhP3h+vqw9fIDiYkvHG+FQI54BrOrnCkfjc@vger.kernel.org, AJvYcCUlydTVhxcAg0Oc01DbSJN57B7HrhyQ9ZeAEe5kzWIRbuWJ0vp0AAppkQ+n9qdjxcc4Xc2L8mEOmAX/@vger.kernel.org, AJvYcCVEgSkLEBzKOuMCRJ7097eGBz67do2Y7GJNjiQyIHC+jMQehgknawIVQ77Z2cXSeS2qNYsxIGlB@vger.kernel.org
X-Gm-Message-State: AOJu0YyR9jM2CTimtukQJ44Zxl22OhPutB8GXQVxVk8Ov5k7j78ae9dm
	P23t9vt94I+ZTDo7QcH7kTwIXcKrsfZk7tFKImu0TSuLmnfF8O30
X-Google-Smtp-Source: AGHT+IHZtCCUDX7mDEeuB8aZyi3qRWI1DKZU0sOe1chkb3X/72NCuBzDYpNglTWXoR6Evrq69uLEFQ==
X-Received: by 2002:a05:6a00:a93:b0:71e:f83:5c00 with SMTP id d2e1a72fcca58-720c98a19d4mr2723785b3a.2.1730425442887;
        Thu, 31 Oct 2024 18:44:02 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2e95a6sm1834390b3a.145.2024.10.31.18.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:44:02 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH RFC net-next 2/3] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Fri,  1 Nov 2024 09:43:26 +0800
Message-ID: <20241101014327.513732-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101014327.513732-1-inochiama@gmail.com>
References: <20241101014327.513732-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add "snps,dwmac-5.30a" compatible string for 5.30a version that can avoid
to define some platform data in the glue layer.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index ad868e8d195d..86ca39f89447 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -421,6 +421,17 @@ static void stmmac_remove_config_dt(struct platform_device *pdev,
 	of_node_put(plat->mdio_node);
 }
 
+/* Compatible string array for all gmac4 devices */
+static const char * const stmmac_gmac4_compats[] = {
+	"snps,dwmac-4.00",
+	"snps,dwmac-4.10a",
+	"snps,dwmac-4.20a",
+	"snps,dwmac-5.10a",
+	"snps,dwmac-5.20",
+	"snps,dwmac-5.30a",
+	NULL
+};
+
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -551,11 +562,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 		plat->pmt = 1;
 	}
 
-	if (of_device_is_compatible(np, "snps,dwmac-4.00") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-4.20a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.10a") ||
-	    of_device_is_compatible(np, "snps,dwmac-5.20")) {
+	if (of_device_compatible_match(np, stmmac_gmac4_compats)) {
 		plat->has_gmac4 = 1;
 		plat->has_gmac = 0;
 		plat->pmt = 1;
-- 
2.47.0


