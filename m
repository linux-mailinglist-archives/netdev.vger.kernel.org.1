Return-Path: <netdev+bounces-171929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C5FA4F74A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 07:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035423ABA2D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 06:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FE1F03D7;
	Wed,  5 Mar 2025 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv+sNUmC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F211EEA36;
	Wed,  5 Mar 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156801; cv=none; b=KQiMQZ1gCQ2oRqWJ9KyUWwP/n0cGQ6JH2XDWpObs9e4/tD/Xhfq7layRNwk//MyRbSjz/FcLC7VdcJU3P2PxuNephek5vvBA7tju4XmGhs1IelM69ifeV9Z97m/x3tOeAsTgi5+LcM1/TJtG/RlcB8BgsWMnq4hB3qOCEGtXkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156801; c=relaxed/simple;
	bh=86l/66xIownBaZ3cwYjV2cscKhBS6FrLrokPJGrjecs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sW0IVj9UMxRmFJ+G/n+ifKptZpZDOSAcEEVUC7VfhucfcbILLO7oJZfFY6rm4Y2WBEamvRFofWQGvabt4+X3cFVxthterjrBKZO5kZu6yf19QonyJiSvtzAd6urowA+B/V11QafD807TWvZufjwnEoma5oc/GIMnHZT1uehmcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv+sNUmC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ddcff5a823so50841946d6.0;
        Tue, 04 Mar 2025 22:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741156799; x=1741761599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnUFYilpgj+lApe/lLMUPIRjzjwA/TjaOromIwsEgpY=;
        b=kv+sNUmCqhddtEgR4Lrs4kDdSIq8Z8ftukv1m2ZianCusCJZYpZu1jpeNjLvsXFEB6
         VfCxx1AHYKYSwhlO0cJzGueJkLeZl1rlfqwjpGT1LkJCXN6Y+5st9Vv75bn62buQ4HoJ
         TmM6QSjCE8hjOylchXoq6WqSujDG2hr7lmS7esnNAA32rXn20yduN2WnZyCDGl+smE5j
         /iNMHvkNQLA51EWJpYGq7Y2yovck47b/WzXLp/R8Cbns5BGbkZ8vpskaq8uA0lSIfGp2
         rJ8FEvxNb/uLvd9w8+WDi3zX2USV1jEJsj3Gy7qB4UBAgjUXoCjnHeclRt+x3tUuOI3F
         lzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741156799; x=1741761599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnUFYilpgj+lApe/lLMUPIRjzjwA/TjaOromIwsEgpY=;
        b=uqL6wwlvVXb5Jz5btH3wH50MWBS8f3/iiZNLxKEOxWHXbwUZkr0IDsaC6w0EJGTNQ5
         StaIRt29P2ybVZpYtWC1Q0cwEswuj0WsYI6Ru8UCB9ESAJBEyANCv2Re3UiTZB9sLW4m
         pU2kL7DwsHp+NxO5uc7VNx2YkygLPheYZGnPRUf2g9NvW3Pcigq14SFfEm4jP0woUZfs
         uqna4XYoBhHabHJoeIEoMtglQFyuz/72rahIrxWbngNbio8ZNDhT43jJWMnZ9TU1C/sH
         iyJguPYDRv9b8gu1EzJINHAT3FnzPJ9sD0NKML6u515aPvNHjx/VxttqkVlmsDjSUfji
         343A==
X-Forwarded-Encrypted: i=1; AJvYcCUdegFBCN9mY+NEwqfWzCVeTHr4ULYFgcxCvKry1et0QNdWYOfkRWQDJFfNdao2YZQK16Re56blAROdCtWn@vger.kernel.org, AJvYcCUyC+w3we/efRu8x5Vo8A+f7gNbTCPSF6NOxQ1u8+aEmoQHj0WXNQrCFnOtEkuv65kQD0Ohh6+6iMxw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv1lCaoA9PyHnNzlYfLD0whb2gxumtAvNIMwwWd6CdR1lkqzqX
	lB4PfR1LrFzu8Usu6BZDTBYE5JvPJMTxLFL5zJ+TSo9mX1XIq9Hs
X-Gm-Gg: ASbGncuSBukWbTzf/10W73g528UeEffiaFbkZXolSKDPVSiRcEu02PEI6DYXA0LqmgQ
	Y2Zcn0821bFNsEUc+kiBi5CU2M2fKsko5dwlGPSHS90cYOzVFopayLmQJLT7SvlsJ9f9ClkKBJS
	Du9IrpQBk1t91jtlkwIYfoZpTQ1z+oyLtfXEaoXxGSAQlwH2XP4FvpWmRHvdOBJ97qwdBXGgStQ
	1nB7DOcNKsGl9GNkr7PJGsgn5f0v27DjQQU7h1kZqp6bBFZvhD6/rB4b9U/OJX7kNOKf7nIPQq7
	cze+L0hi+1xNdRA9Ciip
X-Google-Smtp-Source: AGHT+IEuoOgEWieVXYXs/BnBGn13ST7tq7MLg2Te/z0E0W/Uw2i3Q/8qgPco6xeoeTBuGR6vTw3lBg==
X-Received: by 2002:a05:6214:500f:b0:6e6:5e21:3b20 with SMTP id 6a1803df08f44-6e8e6da9f4emr26434836d6.35.1741156798831;
        Tue, 04 Mar 2025 22:39:58 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4750aee9694sm7883261cf.36.2025.03.04.22.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 22:39:58 -0800 (PST)
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
	Romain Gantois <romain.gantois@bootlin.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Simon Horman <horms@kernel.org>,
	Furong Xu <0x1207@gmail.com>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
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
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v6 2/4] net: stmmac: platform: Group GMAC4 compatible check
Date: Wed,  5 Mar 2025 14:39:14 +0800
Message-ID: <20250305063920.803601-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305063920.803601-1-inochiama@gmail.com>
References: <20250305063920.803601-1-inochiama@gmail.com>
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


