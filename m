Return-Path: <netdev+bounces-166775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9320BA37434
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54FF18917E4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568E194C75;
	Sun, 16 Feb 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SILqL0XW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB81946BC;
	Sun, 16 Feb 2025 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709634; cv=none; b=LRCdKjFlUTrlTVV3wdPr/zE3ZvVuQwGuh7zsWEcTgWlm4Ws5eWKP85+EE1gbpo2/PthTvZfEraFXyOCPcRUQNefAKeCf9ceQuZiDngFXl5QCJzH56a3iA+38k1a7MCq9Vbq8qn3udZjrI7+3RWZSwETAcTL8UimlJd6HmMSqz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709634; c=relaxed/simple;
	bh=1Pj52/8KJlgnD25d3/zs/IIeaAZNBOULaUvcOE8jy4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAo2YhA6vITBjhaTir8rAji5w/qRsHdxZODZQ3YgfBMfKgj830cOJUTaNGBO+JvZwb40t1iv3U2f9FHpVi/kvtapj5inHko07PmF6LzSY7bUXCaSjsrTf5hlBrOjrfEBRsywm1uN6F87JYaD3sF4ct6/yOH8Vb0aHrjjTXkQfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SILqL0XW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c081fe0a5eso291052485a.2;
        Sun, 16 Feb 2025 04:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739709631; x=1740314431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbqdsXVR3N15jF5g1M1GQwDGOPgdER4+dFi3kR5bHSs=;
        b=SILqL0XW599bZ648kIVpz904MYBdNe5yaTEVHGuxhlyhokcVlmMmgFmVON1HSr7Dos
         Cw7/9AzoDTHBPq58iBo9S/bsrnWQnOwYq4HrTfG59erTGvYL8PPl/Sx93ATTbgmK7WvY
         LWH9ucc1rAHtbftgpz3IXUclD0rf2al0MAL7h6Zstw174BmwpUtu1UvxplBCyeAnAIUx
         sq7vSVH/y5cLCwynLXUwPju1e70r2Jp65EYxdGsSs2jb1Gf2BwQJH1XZRB8ndsfTJY+/
         jqrb6y/U+go1aFbVs2lT0NkQUujZRlTiillKnGqanrNN1FEv2HbhmXlTm7ycRYPKfzrp
         0B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709631; x=1740314431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbqdsXVR3N15jF5g1M1GQwDGOPgdER4+dFi3kR5bHSs=;
        b=q7d4zSZjErmynNvue9+dTlj29YxDzrPYmDETkwJG458KXKURxMIL0Vi6PvS8Z2Gl4c
         W55vHKDLSif0Mp/jz+dxubo6KLF9ugXawj6AoDbQOsoo2nh72M+Zoe8sBRi1TtQofhi3
         3tjwL74es3pETODpN+7PzX2ycrbF8cdsuJzOXTeqzNaD2mvGAhDldYyVq2ychbGXmJ/P
         IclvDqWbTBNhjAyskytOClvfImENdExgqLfn0KxomLdpSW8bIP0rxf34BkZJm22amps+
         sAShIQ/ghqk+MHS7+QJtA6q7DDRFMCd1v7Are8oEkQcs2zGb+MOGwkPhvpDXftA4H5qN
         oB2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6gQPcNgP2BjlTqY45L4q0bN0FCm7tzdgG5yFhEyGs3Hexj9jRhTozmmNd36LyGoB/vtbkGDS+jQG@vger.kernel.org, AJvYcCXOchozEFcjtt3XQ7eFoozgeBI/b4CoOJWf70GZBmHSHo4AeFUua4bSf+yCz0L+NUlODT5j4pSDluVlmPNB@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiDUW7MUOWrwnpzLy9n+bX/7T56UL7/OK4AxlKBivs7yF2wGL
	LYrYvkoktfDX/bpYmX687i+wvBY9z0uP+NQHIhoEHxGvo9p2vDUu
X-Gm-Gg: ASbGncv2HCktgpwbj4zegO7VjDVILy7uxHmwzmV5IaJOXzGv4D2fvbPMdLHETc3ONfq
	wKQJsz746qevyNrPAy3kiHomtEEW5PyQm0uVknSstErpCeaWNmz5+psrNn2sisXqsUuLzAXfsel
	1g6oc7VfGl+J4ev/DiMGyS7FdRxZstGXH80WBTPNePBntR+BodDt/f+4gcI5ji7750kfu5Dhi37
	VG8VJyo08rokvtUd0FJKFEZfJmym2+5U08SyM3mIC/czsKBaUC+CG08zqMWIChUxPs=
X-Google-Smtp-Source: AGHT+IF5XSuhiI2P5QLx2nsbWyypxYdcETy3LCJ+aCkIcrEcibIXS/f4XBYvlBrBHEwSP+ZxkyRe4w==
X-Received: by 2002:a05:620a:4010:b0:7bf:fffb:5818 with SMTP id af79cd13be357-7c08aaa2cc8mr943249585a.57.1739709630750;
        Sun, 16 Feb 2025 04:40:30 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c09a14d45dsm31099185a.10.2025.02.16.04.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:40:30 -0800 (PST)
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
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Furong Xu <0x1207@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v5 2/3] net: stmmac: platform: Add snps,dwmac-5.30a IP compatible string
Date: Sun, 16 Feb 2025 20:39:50 +0800
Message-ID: <20250216123953.1252523-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216123953.1252523-1-inochiama@gmail.com>
References: <20250216123953.1252523-1-inochiama@gmail.com>
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
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c   | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index d0e61aa1a495..8dc3bd6946c6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -405,6 +405,17 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 	return -ENODEV;
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
@@ -538,11 +549,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
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
2.48.1


