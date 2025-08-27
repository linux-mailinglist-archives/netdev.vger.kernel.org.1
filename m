Return-Path: <netdev+bounces-217448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B70B38BA9
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 23:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD618982B7
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A930E83B;
	Wed, 27 Aug 2025 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJEsixCJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7030DEDD;
	Wed, 27 Aug 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756331447; cv=none; b=Dgzz2M5lB4a73HMS1fgHPQYEVcuj48R24Xwdlah/sjOwvdYLh8Im50gclfLopTK5o9fnz0i2EMQ/tpQ51yGp4/8fAG8V+Y8UMTLcnVsSpzsmD8Q/rQwuOs7Ape35IZBxDi+uoqIurcbT0+A6xvX7tmgm+psRbsRaPrDUThr2/mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756331447; c=relaxed/simple;
	bh=HbJ30dCazZc+WvSIXQMk2/8w4kjWLWDIFAkrSuu0ASw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La0oTP+6QR8K+UZ8oQk8o9j/CHJhSs5N4i2rHe2LQQqIspC2v4sE0lVEFs1mIDYkuJhQjQ2+4YvrGN5soPH7+Ct25J8mk3kcuF8njESv1HCK7+CkyRpALT1KnUUYsdZgDj3MBuy3Za6FAseYplNod6lr2/VxWOSRLuJSXjB0m/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJEsixCJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7720f231174so315373b3a.1;
        Wed, 27 Aug 2025 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756331445; x=1756936245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeRSf9JRvQDMG1wF1dhz0wFZHyy96BAve4rAFav5LgU=;
        b=HJEsixCJJjMmW9y1uB2GolrY5iK6qmQ6DTfuZ4+cAzNWwfOB96QlynJdVBObDK6Ty0
         w/Svotp3DV4m6w9go3r7efOg3p2lKUYiF/cGpH4GJ/Tt0K7PUPkcoj9bo1X/XG1Jz650
         6aLkfD7ZGaqjk1IYQ4WXJviagHTYoTwpzfLphLc2rmUS+V7ufrojMlDXo+nyks4lVlRk
         wl9tjlnN7Bep1JGyjM+4hQrSSneSTFn8I80Z7ajYaA+Lac8EfEvTraWOru5lCq9eJG/Y
         TgjzE3lyV34HTsI2UvFXGYHdbtA+G04OK8vFZRdlVQ8M073N27qzylrDRsOsd+YxXJKg
         bgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756331445; x=1756936245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeRSf9JRvQDMG1wF1dhz0wFZHyy96BAve4rAFav5LgU=;
        b=CywD7VFky73GEK6P/8J87uo+djzlq/KjX1S38jtVTtELre4rz1t7IhtWbIPDXNXAz/
         +bylfakWVEp5i+26V0vRgTpCyI/S8c8Gb0G1C1tjLfgYNeTcZ4DwK4iQrfCdNGCMs3c0
         kGgyZc3HxM7PHMHACC1W+Ck9vfxDLzkmKKL3qn6I6laQkiwYRnNTxNX5QgP6wHHYG0CI
         7W76EKsm8K75/s0sRZE1CBoQe+w2Dkx4RsbMwEFlePTBWNow5uZQnx8eSVUfF5KSz878
         Yfj++50kgw9TxEarLyuTBETXND4K72wge16TeCGmpZqcu0rZXDo8mpwGJnasCYs1V+Jr
         U06w==
X-Forwarded-Encrypted: i=1; AJvYcCX3RwMcyzvcAsA64yhdt1FJxh8mNJtgoOca5wCfzxZU3lnnSK5WN2fjcspD/M3WpGu0FxHQrasr+H/4/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJ2RvmoL0HXF81OGQ/CbmVV3JdrahbsIng8BAaKBTr3JUA0tJ
	UDdwqgs1gkAl1TyAnwLBQRLkaEtyRruVBkymgzsuhuLBWz8dkNu+xlsm6hj4fqDi
X-Gm-Gg: ASbGncs8ENznFlpPV3lSEbeLyR71E7PrQYoYh8znsYmoNbHcJfWmvi/KSI52HgFEVYN
	BIG7qShyR2F0cae8wZjBX7MREz+CcGLQwkF8Q3tMd10aLk69VQX2P27eU0+Ll/dSbFWR8tNGIWJ
	vilyGyYjzAdAk4QpN2shY/Xg02Hj5nCTtfXUVTpRHzy+Q4phv25AJ6NO0DVLxTNKf5o7QUMpnCO
	U+BE+MFq7U/7r13A75BP3z1Jn33Ur8xavcZ+4LmH6FdS+BJ/EEBUIlvwo+h08WAA9Mw4NvfzUAB
	VOOaIPyJ1HF+OI19ieoR784PT7OEYx7Vk0jorpWvuwUzbLYYvRzH1uvnrXsWvAlW24/ChjbYwd1
	7gbPdTdTs91l4UUkmLzdoa14AcMZsrOM0u9IFqBFlMsbjDNzcwOsudbTjO2k50OM142YEl7MgTE
	FB
X-Google-Smtp-Source: AGHT+IHCaHhYI3mAHhQ9fOx3+UTlMHs0mnH8B/R05D+H3CddlstOwpaEoo2kwIZXoX1+8jSUjdyDDQ==
X-Received: by 2002:a17:903:298d:b0:248:9429:3638 with SMTP id d9443c01a7336-248942939bamr58351735ad.7.1756331445075;
        Wed, 27 Aug 2025 14:50:45 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:acc7::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-248cd2cd5desm6430765ad.147.2025.08.27.14.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 14:50:44 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com (maintainer:MICROCHIP LAN966X ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] net: lan966x: use of_get_mac_address
Date: Wed, 27 Aug 2025 14:50:41 -0700
Message-ID: <20250827215042.79843-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827215042.79843-1-rosenp@gmail.com>
References: <20250827215042.79843-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As lan966x is an OF driver, switching to the OF version allows usage of
NVMEM to override the MAC address of the interface.

Handle EPROBE_DEFER in the case that NVMEM loads after lan966x.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 7001584f1b7a..8bf28915c030 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -1083,7 +1083,6 @@ static int lan966x_probe(struct platform_device *pdev)
 {
 	struct fwnode_handle *ports, *portnp;
 	struct lan966x *lan966x;
-	u8 mac_addr[ETH_ALEN];
 	int err;
 
 	lan966x = devm_kzalloc(&pdev->dev, sizeof(*lan966x), GFP_KERNEL);
@@ -1093,9 +1092,11 @@ static int lan966x_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lan966x);
 	lan966x->dev = &pdev->dev;
 
-	if (!device_get_mac_address(&pdev->dev, mac_addr)) {
-		ether_addr_copy(lan966x->base_mac, mac_addr);
-	} else {
+	err = of_get_mac_address(pdev->dev.of_node, lan966x->base_mac);
+	if (err == -EPROBE_DEFER)
+		return err;
+
+	if (err) {
 		pr_info("MAC addr was not set, use random MAC\n");
 		eth_random_addr(lan966x->base_mac);
 		lan966x->base_mac[5] &= 0xf0;
-- 
2.51.0


