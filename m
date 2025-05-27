Return-Path: <netdev+bounces-193730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F13AC5984
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 19:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEB117161E
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FD22882D9;
	Tue, 27 May 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LExC9gpP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F9281512;
	Tue, 27 May 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368593; cv=none; b=sWSt21+Sjk3xO0lhKOFYaNZsQM86D5KnDbT8YTKGMIwEv8iLYWk3fX29dWckgCs92ojPZ7RJWyTVswpK1MvLOU88HUH1Ck+JFEy6upmeGeSlcatfKR7DYoiRwknvLzqyy4sin3S6kwXsNE6VPtbkvEQ1Ei+8ocaLNmFYlIj6edc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368593; c=relaxed/simple;
	bh=ocL9xN3l5CZIkJMP4iIsK/bvcDmu7NvmAZRKme5JHYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BAbfv8Kfs8LUlwZsSEXQAjd56WIHCa5ilF/grbf+V+zyKd0+OX1UHt/CuNNU1GYRmQ66R4etbEBWPM3HmHXyBEV2g7+yR9PaS96DHbXaXfvggVLnlrtNi8iHDmZHF6kPcwiI+sDcBV/XC/MgJ72xLA5sBaxAtfzkBNNJAdY79vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LExC9gpP; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c58974ed57so344065485a.2;
        Tue, 27 May 2025 10:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748368590; x=1748973390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=LExC9gpPlv88DAYFxW2F6YSjeEZBuXAFpk8/TPqQgs9EIsjOwl/Lg00vW++LhkYYej
         RysQfOQ2R9ACXGi2ptOJTQeyUPUE3Jrdw1Ms1DWWkDUxz3DVkrvd4laBuexuGG4Av+fe
         TF/G/cZwbIPbGYuX0BtIvMUa8YSD1LHmNsD872PAhg7FbssCZGH5LYyFoOpPoB1rUK6X
         deVKg6QT0deSaLFUYjQBM3uodAYmrYqsW0Ck7iC9cM20xZzw5eZHz09NIcBUdQ4/Jqsi
         YZCNVP8YrT0RJCLKiRs7q8EjpfeyWc6XMFSw6LOP5iKIYkNTsx6UMNfBZNOiOjrNmKpt
         Xbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748368590; x=1748973390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlxuW8EiAaobylr07WlFl9Wc9Vavh5mNNDPDEO1zHCA=;
        b=cuUq+27OLK8ObbOk6gX7K/XZCh4RucktxwukIKNtJNN9kl6RbdFtOUj0mVj2jjSO5m
         m1P+I7SX89o2MJGI0khSvKstjFzKLuyodfNltVUxNJxUDB1tczUgKRnCGzeW64ZTszqQ
         ECXMIcIkOV6ryW/lQ9g4CARSh9waXwUWldh4x8rFZrL099FUrAfcRjyBmICLn37NcYPH
         TFjLFrBW91nuNAL2wXtPHvz+HKco0sic2h1hAPM925bPMKzp4HImWfSpyEu4Ccdjue14
         n6CY6fPSotxB+hv6LuwA6PSNuAiXOGgna/aUhyz5aVFURcMVZ6xZAaP0qUKw3gI40p4s
         lPsg==
X-Forwarded-Encrypted: i=1; AJvYcCVMBpOlQ68dSrtQ54oFsRlT8ZvJGfqbjlWVYAchH5VnIjt2QZoXBvt+RzgLuvbvFYYpfPWfiQ6ypYssm6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEdgi4g/WJIgt8ZqG8zRG/q0R6y0XRaLNrFl1aRVN7qufOoWhX
	FqRxKYeRGn51v5J1wzaauFmwP5sGIVVc4YA8HSy8YHmk8bjClUHaKqVXLovn25FRiu0=
X-Gm-Gg: ASbGncvDmqVSUY236Hc6x44HrhBsAIDeKwb/jZwA0jgrKkkCVyP1UUSoPpZuiCVEPAR
	+j+ML9cDSvQxCXnZiRzv2yasfKU0FeblN7JjD7dV7JMb6kLApPAD50hz3ESQoy6YXAR84ya88io
	Ku2EiSdgQhOVN2W2EOfI/0Qs9HeMpjmDd+tu//vFe2ppiTqTzhtv0gk3ON1tbevnZaPgBJVq2I0
	bi6g5OS6z6CltQTWZI59riZspqy+loRIcFlMH6eO3ZEqpUdD0mYtcDA2DS0t0r6pFoO2aHo0k44
	StJ42oeF+qy7r7VlwyUlvo4O7s7h9Q9CID5ME5LX/+vy5ALWwbWwpkyjRo9fsiw8EkaMk1zw0/d
	hk1b64TsOuVFsiEbMsqjmC9LO25h6Tw==
X-Google-Smtp-Source: AGHT+IFLIO0D64jUevJ/lz7zQvSZw2ntrY7H7wTTGXZU+ByFDYJ39AXVKInapU4LgwZEqDykU4orhg==
X-Received: by 2002:a05:6e02:154e:b0:3dc:87c7:a5b5 with SMTP id e9e14a558f8ab-3dc9b67fdd9mr138337085ab.3.1748368579606;
        Tue, 27 May 2025 10:56:19 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-220.hlrn.qwest.net. [97.118.146.220])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc82e014f4sm38082275ab.40.2025.05.27.10.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 10:56:19 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev,
	James Hilliard <james.hilliard1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select PHY device
Date: Tue, 27 May 2025 11:55:54 -0600
Message-Id: <20250527175558.2738342-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices like the Allwinner H616 need the ability to select a phy
in cases where multiple PHY's may be present in a device tree due to
needing the ability to support multiple SoC variants with runtime
PHY selection.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++++++++------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59d07d0d3369..949c4a8a1456 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1210,17 +1210,25 @@ static int stmmac_init_phy(struct net_device *dev)
 	 */
 	if (!phy_fwnode || IS_ERR(phy_fwnode)) {
 		int addr = priv->plat->phy_addr;
-		struct phy_device *phydev;
+		struct phy_device *phydev = NULL;
 
-		if (addr < 0) {
-			netdev_err(priv->dev, "no phy found\n");
-			return -ENODEV;
+		if (priv->plat->phy_node) {
+			phy_fwnode = of_fwnode_handle(priv->plat->phy_node);
+			phydev = fwnode_phy_find_device(phy_fwnode);
+			fwnode_handle_put(phy_fwnode);
 		}
 
-		phydev = mdiobus_get_phy(priv->mii, addr);
 		if (!phydev) {
-			netdev_err(priv->dev, "no phy at addr %d\n", addr);
-			return -ENODEV;
+			if (addr < 0) {
+				netdev_err(priv->dev, "no phy found\n");
+				return -ENODEV;
+			}
+
+			phydev = mdiobus_get_phy(priv->mii, addr);
+			if (!phydev) {
+				netdev_err(priv->dev, "no phy at addr %d\n", addr);
+				return -ENODEV;
+			}
 		}
 
 		ret = phylink_connect_phy(priv->phylink, phydev);
-- 
2.34.1


