Return-Path: <netdev+bounces-172726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2BA55D02
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA2C1885FDF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128CB1624EA;
	Fri,  7 Mar 2025 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHsmmp6R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023317E015;
	Fri,  7 Mar 2025 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310228; cv=none; b=QrVevdmzGKxBYQB3EeMo6EcKq9lwyr6xws33RSmP0BigpbnuGOr7TOTox6SEcP9lMjxZioybDAPGe9hPwQuWlGJ40FtiylYEtBpNpGI8d1Agb5BLPHkLrxWrDuNlVIOemmVeqYdM93LfytHUkgfCrgr4em7U3xSh9aaGKE4tSA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310228; c=relaxed/simple;
	bh=86l/66xIownBaZ3cwYjV2cscKhBS6FrLrokPJGrjecs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs47SWtfyO6Inh3eCg3Necwg/AfkGqwVE8kPY96gkQh84TOKJMEeI1lNX4HTeFWWAhr4Kv0JGehRz9JobkupM2sTYD52pbrJLzLq1iJa2U7SMss/3M4SUpOi6OmkOayCpHE4+985P0TWRV3plZ3UtiOmhbv/Z6+sdKHKew9lG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHsmmp6R; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c3d3147b81so160053985a.1;
        Thu, 06 Mar 2025 17:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310225; x=1741915025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnUFYilpgj+lApe/lLMUPIRjzjwA/TjaOromIwsEgpY=;
        b=bHsmmp6RtKImjcCqlYX05ABfbnBoM/p+B+4s4fXc1388i5xCnHPPLFLCVlueIddV0P
         RVCwGj6I30AB4KLDK0wCTtQm/JpKaOw/ZDS7L7J13zlEwqkVbgQognJA9SUYi8qaMnpG
         /RGZ13AlD7kp5I2r2qs0KHfJCR5Je9L4mSONwBvt14BgZu7dtzKOxOF4pyg9LqpLVAmE
         ryCQYjiPpWc2Es4fYrh8fsBKVzxUuwHeF1aKONCKIHwKULqkJ/byyE3NhldV2kk5ELb2
         odQNJSagpPKCoNm0z/S4K1VznhXSfglehnlS0DKKg3etn7lJLN8WjJEEgKkG3mJlBIny
         ZJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310225; x=1741915025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnUFYilpgj+lApe/lLMUPIRjzjwA/TjaOromIwsEgpY=;
        b=PHiw7DUugr0sifpy6FffEZpIiItMrj77fdu8DStD3TuMH1aIhcZsbveYraxD/d36nE
         +OA1bYKPKtMoTuE9VA0IY5bP723Ck3vAIw4m5U53BBJUHd/ydv4ivPImvmX95ry8sZBp
         LjtS717I3bMkRfiAkPJz5+APNceob02ZaJ5UID/c6dBE5kn20hSRUbbtwVSg0SJlmXM1
         k/+Z0PpPq+xss4/CQyUOC8eVo82//OXHH6q1h2Yaut+mGdHkOHAAUJyLJQB0v9AywCe1
         iGF1Q36p3ErH+o2hohXFOUV7jj4DlzttejDIGNniM2onzWXwaJjhG+2AFdE5U2FLdoXW
         OCxg==
X-Forwarded-Encrypted: i=1; AJvYcCUmPhbnwCyMLVcRHSX/zyYsOy3OaFVw9KXzYjp6kxriZIurddqTneALJ3ZwzkPk5T0iVANR+zbT@vger.kernel.org, AJvYcCV3YFmIchPt4tHLWBxzGnmFV5Euwkni9Ddvxl/xhU2eTJGDWEoEpx0Zt97i/qpzKhu1czRWSa/tcf6emUeY@vger.kernel.org, AJvYcCX44NRx72jw4VOrMu+bspsC3JgSBSE+NQxDpzjf08FshcmG+gmhQvtUzDVbBn3Ka1ebdiW4o0UcBYqj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh8qKqSxIvLnkHl4U2yOUNcdjApBUum3RQrQgp67DbgXz6pfJx
	FIC12XydSOI4CzpLUUam9motPu7NQAJvZVyTVrDX2cUnqUwokypM
X-Gm-Gg: ASbGncv1KYnV2QrGpII+LejaIC6+Waj19oK/o4QUiVDf88C+4P6Jc339CTTQiSTfELM
	qyivM+wVGmZdZHheP2nYT+ZnrrcQ0ZI/T+ui2k+2JraACo72+Tnz6340+GqRpVbGwoU2O1AwDEr
	A7/8JSbcYtECemZx/tZnG8V9LRgNxhM9RkvsobOW6kgBDWtNASUUYiBt4WJFVYvDYRXHhNDCiVG
	dkkZ+f5q+2D5txQ73iaesYzsLgqgqXlRntmAUX2na6RhgvPX+ZDQMdMNilVQK4nfueILIHueMLg
	z4PFQOBo5snWSovaPpaL
X-Google-Smtp-Source: AGHT+IGYsH3sSP+qAZYndPm/6yCLkWYSNzyIRwRqHTgXvkWd663LqIaipq1S+8GRypyA2mF4w7TN/g==
X-Received: by 2002:a05:620a:8b14:b0:7c3:9d0a:6959 with SMTP id af79cd13be357-7c4e61137e4mr162902885a.27.1741310225187;
        Thu, 06 Mar 2025 17:17:05 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e7c0a266sm142441085a.30.2025.03.06.17.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:17:04 -0800 (PST)
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
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v7 2/4] net: stmmac: platform: Group GMAC4 compatible check
Date: Fri,  7 Mar 2025 09:16:15 +0800
Message-ID: <20250307011623.440792-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307011623.440792-1-inochiama@gmail.com>
References: <20250307011623.440792-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_compatible_match to group existing compatible
check of GMAC4 device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../ethernet/stmicro/stmmac/stmmac_platform.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index d0e61aa1a495..4a3fe44b780d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -405,6 +405,16 @@ static int stmmac_of_get_mac_mode(struct device_node *np)
 	return -ENODEV;
 }
 
+/* Compatible string array for all gmac4 devices */
+static const char * const stmmac_gmac4_compats[] = {
+	"snps,dwmac-4.00",
+	"snps,dwmac-4.10a",
+	"snps,dwmac-4.20a",
+	"snps,dwmac-5.10a",
+	"snps,dwmac-5.20",
+	NULL
+};
+
 /**
  * stmmac_probe_config_dt - parse device-tree driver parameters
  * @pdev: platform_device structure
@@ -538,11 +548,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
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


