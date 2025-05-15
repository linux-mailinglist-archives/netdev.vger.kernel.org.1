Return-Path: <netdev+bounces-190696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A26AB84D1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10C19E6FBF
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD88298C2F;
	Thu, 15 May 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVqdw+DT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E8B2989A3;
	Thu, 15 May 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308474; cv=none; b=rBmb61h/1EkeYfggi1kLWrSEZfloYF8S9GF4z3LHldx3lAOWwPYxhDGX4SZJC80TYcE1ZCPOEPjdfZdNNo7eOreOj6tuuaL/sDq9rcoCiqYM7JWuQgGrd8nNVjTTFyJmLvzlJo9zpc/RYPO2+D7aMFlx3Hosm2FOWBtA1E+tCN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308474; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYenVyvZSABinPZ2Pn+5XUOZq0YbYuRH88jh1VOXXoWhEG12FPkly3gtwrY5AcJA6jiUv7d+hM0Fl9yFpC3G/yevXxwEvXGmPZbGVbboTSOeoHdNuaQMgpcnslOCRBVGauaprTkxq9XovgkNh+ITti5yLMC/QQ2tI+OTvlXDNTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVqdw+DT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so8120085e9.1;
        Thu, 15 May 2025 04:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747308471; x=1747913271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=nVqdw+DTTbRAcLUDwhDVk4MNWqtOVqGHLYPnpeaK07URmDOB0Pm7yM98XZX8fYwXq7
         7qbh7s840M2LiILT0dYa/QkM0fQqUJ/3iF5RyXPuMZGUXyrwbgIuauwbdtruKrkcqc/G
         iBWrq0O38nC19JnOn9LVvLffg5H3b1vKbafQUArAJEEMYZkdIGBLYN9vtYmXo5x4yAu2
         k3QfWp0IGkRQW9ZSjFg+GIcD3oOh8YRnwKAQPUDjgjeXyUVpMDrqnaukcvtdMyxmKpwc
         o7/Z0uoLj2QdAi0w6RtTVe8R10F6LCP63EBOVo+fVqvI+3pUvO0USHGzMlcPlVbLXqHX
         qRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747308471; x=1747913271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=NwSw/bATiLjDYKtwEbBE3eO02sVvXWZRRnMdA3ODZ1mbGIrM7PO223I2L4BM8lkKcL
         lgdwATvG/CWezj/q7TwP911XqjqHa8Jnr68Dwz5wRLhw2q2b/qdr9FU7DeFVVyAvdtaC
         UGPSxzew405it5+j8ZfbbZX/0Ph97b3CEbSyf77+KYgPHIefGXWp1Fg37OdDhvgIcfeT
         Tf+3rmPOlSOo8nAmzT/IZExb/0LeKVu8nc1vJeKjrl6OhWtz342zMPxh0tdQyUxkAPv5
         jH07AAApKypn+vD9uw8X3igFVouDrQugNpF7GUH9FeW6o6S+iSq3fzq6WRWBwy7abi5m
         X0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7bejAuiWWarkOU5PryVOirtUI2ZjgbqHpkYPrSJckRBMV9h3cGPHLEHLbR0TChWbwrDwSqhGZVE4iXj8VP4M=@vger.kernel.org, AJvYcCVd7KZvn1s7WL/pjTDZmKlcdFrPcgMcIU30clqHMunmcLfp4AsffeSKQFWLzZCquSvBv5TO6K9lxOBm7imI@vger.kernel.org, AJvYcCWPPYF0X8kKSRfco5wuvZB2AhlXhp4T1cM9b9sDsF+KfAOEbbFOlHj+Lry5AsN8rLU7ozhnK/Ht@vger.kernel.org, AJvYcCXvbZ045DnVBJpu+1fKwZc539yiC+B4DBmZHLCa+COQiTruAOd392ibE/MDP8zIDqzxxwMB+jht8HAU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx86RCM55jtNuE0mhQrdnnhfEx1AuQ2GCNDCTtOad6oI+mzF9Vs
	AJVr1qeUBqDVVvVj8jU6k2523WJ43az6i8er+tCKSaQLuC0Lbbks
X-Gm-Gg: ASbGnctCFnrs6eIiOwEIdDhRmvEne5yEcjBFqTcnJBC5i71Xy3k6+5cfH4i9UE+1WbR
	vcoDmWaYlmX7SZlEUyacbIoTeUSYwudYy1IOykzsUjwl+YltgbCg9lqHIER9NDe+cmuaX0uTjej
	smKH6tdXkxxglXfbGN4MSXKGuDMDg9x3uO8nfbijyzW7PosP6TmMZeR4Y7kNZ7XZLeZIqnVDiBr
	xdOifP84tQsL4/Qj8+dAzDo3JKpSOA5tOuqBWWxKLijh9/1gpyFQbrrYavyAxKuAlLR02jMYaM6
	PbClTJbxRwaMBufSF9sfF7CsVV2EeCQAJWdwoO6FX6zNkikPXrnuXXvNkzMBNsCpekHbrRTz455
	6BQ84AP2AOTp2e1hlx9si
X-Google-Smtp-Source: AGHT+IEkqgA3KuxI0j3sKFIFR48+izICIU8GG93b8j4McLqorypMq5wxXe+mpsB0UwxTxMHRa4MPkQ==
X-Received: by 2002:a05:600c:5298:b0:43c:ec0a:ddfd with SMTP id 5b1f17b1804b1-442f20bb1a4mr62974175e9.6.1747308470994;
        Thu, 15 May 2025 04:27:50 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39517f7sm64497795e9.20.2025.05.15.04.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:27:50 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: [net-next PATCH v10 2/7] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Thu, 15 May 2025 13:27:07 +0200
Message-ID: <20250515112721.19323-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250515112721.19323-1-ansuelsmth@gmail.com>
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify .match_phy_device OP by using a generic function and using the
new phy_id PHY driver info instead of hardcoding the matching PHY ID.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/bcm87xx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index 1e1e2259fc2b..299f9a8f30f4 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -185,16 +185,10 @@ static irqreturn_t bcm87xx_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
-static int bcm8706_match_phy_device(struct phy_device *phydev,
+static int bcm87xx_match_phy_device(struct phy_device *phydev,
 				    const struct phy_driver *phydrv)
 {
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8706;
-}
-
-static int bcm8727_match_phy_device(struct phy_device *phydev,
-				    const struct phy_driver *phydrv)
-{
-	return phydev->c45_ids.device_ids[4] == PHY_ID_BCM8727;
+	return phydev->c45_ids.device_ids[4] == phydrv->phy_id;
 }
 
 static struct phy_driver bcm87xx_driver[] = {
@@ -208,7 +202,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8706_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 }, {
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
@@ -219,7 +213,7 @@ static struct phy_driver bcm87xx_driver[] = {
 	.read_status	= bcm87xx_read_status,
 	.config_intr	= bcm87xx_config_intr,
 	.handle_interrupt = bcm87xx_handle_interrupt,
-	.match_phy_device = bcm8727_match_phy_device,
+	.match_phy_device = bcm87xx_match_phy_device,
 } };
 
 module_phy_driver(bcm87xx_driver);
-- 
2.48.1


