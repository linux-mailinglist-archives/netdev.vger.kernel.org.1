Return-Path: <netdev+bounces-191596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAFABC5C8
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E108B3A9B2F
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE7D288CAE;
	Mon, 19 May 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFyuXbZc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422F285409;
	Mon, 19 May 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676784; cv=none; b=cuFz/wgBXeB8bRKFjUnT163u6sL1Imz7sxXoOTd2LhK/x6tUM4C+eUs/9iG3yz8bT39nlrxKavrYyulyiH2H7OpkBznC9foF1FQDGbKNjvI3cFFOXlc7S+DHDdNIYJ47SHjADVFX5yU8n81Aqc7xsWR2BYtxQp60FAx0I9OZyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676784; c=relaxed/simple;
	bh=Fgt1Hv6DqWEvToz0/T51Ct5RfMys3O4EwPv5qKgqKWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JME4aA5bj4aULaCAcFWBYFPMEkucrKyDw/ctu8xH2TLEk1kvlf3kh5acz3DQdlOxIInQIJdqHOTmyqj7tD7vun3dVqTyND7Ybf7JBNnDZI1Xmp8uhArpTw/o7oozGzXLkhrTiVRLwACgAhZZHSDNuVsuXyuhePJ2VDiy6cuKEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFyuXbZc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad56e993ae9so258873866b.3;
        Mon, 19 May 2025 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747676780; x=1748281580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTRR1DsUv5T48ThSl4nokG/JrA/NXGwJCeTbonpTz6w=;
        b=HFyuXbZcfNW0CTqPHNY3lDLsjxmY9L1ct7ZXEEnJcpEucaY13ng4Q0K0xTO8gIrTPa
         dIPvTlOII1pUCZ/nLac3POYFoASU/kaOpgPJ4Qp9wCIXxdjjKHX2ByjErDZior7UuN9z
         7Vh9ExFwYdAmDvK6lmBOcd/RCPsU4xN7xT9M9W4BSDBoqNBNrqOYLvQR1eH6iSz+qNW/
         BowQ4GtXWePvOouCpAgbdfo1cxJ2DN2r248OonRJf6eHa45ePsdELB6JYc+PJjy74iL5
         WVqtuC6mxom3TpxMF78X3luMMkstwrpF0yKaxaSObDNSvrSKvMQPYcE3prAv9ht7rHi7
         16Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676780; x=1748281580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTRR1DsUv5T48ThSl4nokG/JrA/NXGwJCeTbonpTz6w=;
        b=eR2oFvksPiwCDGbnNLcFPTu7n7CBHi8I+oYCKY1nKZAdOVNJmWAsjd1vrBvklz7kIt
         CBW64vtdyLrn8cLwfm07b6+o4sOp92O4qR2ilGmU3ET0pGXZbE85tD2JFJqIuLA5Vvqw
         I2fW3QpjLBam9sFFpyvIXZroicJ7oxJZvr+RqrY94C8CmyDTROYCNetVg2fvjEmQQq32
         C+fnuve4CukThgeiB3yi/7cwt+Coij1OPFTzMyXzZri1Q/Hg3FsvSwbUX08FEaLkOCk/
         1zUV4dbkhty1vyErsggOzP/ckGWaEDmIIZEnmQlPqm0hQuS4VsUKhPdDLf+gcFMLcB//
         SJYw==
X-Forwarded-Encrypted: i=1; AJvYcCUqqX7T/DjRbo6Ea9V84r7HmtFChA4U+jNviYcOyg4Z6vufFvEZgLyhhHATzNRE0afAdY7sPc4M@vger.kernel.org, AJvYcCWHsQBAbNkCMaWRvKDWRdONXKeh7vlladgyAYjhs+VQgyPnB4Bd34PGlM0dMbO2N4BxssT/SFA9q7EQls0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7zH7z39DQkC5o0SmyRYkdCf5NUv/b60zAc2bRPMN/dxllf0g
	rtClPg5UVcOqsUkbExnANFCLwMmnz/Iab/DUaR3ypT7KZWkE0Jke3Vd3
X-Gm-Gg: ASbGncv24qd7n//qF11yzsoqJy8AqRE8HjrJ/k1I+MIZS7YRr5kT+eGGGES/+1PWumf
	zjOip8YjXS9y7zP02XZ0UjpA/yd3weEOHEfR7Xmpm9w0oN+edm3xggStEPN7E8Qniv/2xxPLOXx
	1Mct+qtp9IqCfa0a2VJcVXprv/SXQgUycjQ/U9Ka1YtgwT5i0x93oSYVJ09Tf5siJb5lJpvKKWg
	ZdG/UbWzq1uEQ/rruniQ5HlkTVKIwDlrRfzW9tcvtTQ4GP4BVgW0GvRJCoJbhizvSy0zty5jqL3
	gWExekyXyNDRJwnvxY0qTioGpFvFVKfcd+z2mOhKqQvJ6TN8n4goOQ4M1KRHhQtzvVkG2l/Toa6
	RwKVSrIHaoA1ICkpnuFn3H+agrwlyVoBO5W1KLjyHTw==
X-Google-Smtp-Source: AGHT+IEMKd5IKPfWCpZ5DavepczIl2J5lU7U8sKeO6HQQqieOggoCYuQrqo+rZm7rd94C3KTik8tGA==
X-Received: by 2002:a17:907:2d1f:b0:ad2:23b6:149c with SMTP id a640c23a62f3a-ad536dcd710mr1032820766b.43.1747676780373;
        Mon, 19 May 2025 10:46:20 -0700 (PDT)
Received: from localhost (dslb-002-205-017-193.002.205.pools.vodafone-ip.de. [2.205.17.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4ca5c5sm615820266b.162.2025.05.19.10.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:46:19 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: dsa: b53: fix configuring RGMII delay on bcm63xx
Date: Mon, 19 May 2025 19:45:49 +0200
Message-ID: <20250519174550.1486064-3-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519174550.1486064-1-jonas.gorski@gmail.com>
References: <20250519174550.1486064-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RGMII delay type of the PHY interface is intended for the PHY, not
the MAC, so we need to configure the opposite. Else we double the delay
or don't add one at all if the PHY also supports configuring delays.

Additionally, we need to enable RGMII_CTRL_TIMING_SEL for the delay
actually being effective.

Fixes e.g. BCM54612E connected on RGMII ports that also configures RGMII
delays in its driver.

Fixes: ce3bf94871f7 ("net: dsa: b53: add support for BCM63xx RGMIIs")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a316f8c01d0a..b00975189dab 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1328,19 +1328,19 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 
 	switch (interface) {
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rgmii_ctrl |= (RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
+		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
 		break;
 	case PHY_INTERFACE_MODE_RGMII_RXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_TXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
+		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
+		rgmii_ctrl &= ~RGMII_CTRL_DLL_RXC;
 		break;
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC);
-		rgmii_ctrl |= RGMII_CTRL_DLL_TXC;
+		rgmii_ctrl |= RGMII_CTRL_DLL_RXC;
+		rgmii_ctrl &= ~RGMII_CTRL_DLL_TXC;
 		break;
 	case PHY_INTERFACE_MODE_RGMII:
 	default:
-		rgmii_ctrl &= ~(RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC);
+		rgmii_ctrl |= RGMII_CTRL_DLL_RXC | RGMII_CTRL_DLL_TXC;
 		break;
 	}
 
@@ -1350,6 +1350,7 @@ static void b53_adjust_63xx_rgmii(struct dsa_switch *ds, int port,
 
 		rgmii_ctrl |= RGMII_CTRL_ENABLE_GMII;
 	}
+	rgmii_ctrl |= RGMII_CTRL_TIMING_SEL;
 
 	b53_write8(dev, B53_CTRL_PAGE, off, rgmii_ctrl);
 
-- 
2.43.0


