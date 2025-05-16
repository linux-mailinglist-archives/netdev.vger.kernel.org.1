Return-Path: <netdev+bounces-191176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09630ABA50F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF49503C93
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 21:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FB0280A51;
	Fri, 16 May 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtcknKRP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E228031F;
	Fri, 16 May 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747430669; cv=none; b=tq1XeANUo8livq5vQ6o49q8IjayQfNf3uqEHv70sp1OgVgJVg1PdiIa/H5f2/ZiKK87l11z1+ZE+nsLe3a1dD7LNW/WYWOCTMfsIY3l1gNNLaQZjSJvTOAjd/I0EYBQBpkCQad+u9kpmlhudOvhCCEkXkPVfS0Rtza7jl9i3M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747430669; c=relaxed/simple;
	bh=9G4ubJ6lV4V2dWOs0FNh/K1YDBBBYb3K8frA6VqI9G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiNwSc0H2d6ZnWaPSh4P+nzIS8sUAuobiuUhBVLUhuZlNL17J+ViwGfopRvZ583LW/gtcezEvViB62KDCO405oi5vvltG93nzcjO657H5b5lugaM+O3Vc5vWNamYHZW3GG0xm3MWShPp0K3lNVkNzE0F5CbpvV6HwYm8dZ2cyA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtcknKRP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so25357105e9.1;
        Fri, 16 May 2025 14:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747430666; x=1748035466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=YtcknKRPVo8Zp7kAE+1+1lmG6yDzN5EGNuKS1w7YNF/OjeNWd/P9pCmdteWfDMu+2n
         eE9aqr3zsc68rKAmv3qw+rQsCQHwHYl/msB4//BqFVmLFyi1GvIcmPnPD3zlMgWG73lW
         C6LFFbaWtG5jki6uxdVXbBSDTfZnzry2tTj+5Vh9shJvS9exVv2mLUoRmnKg0v7ro+0e
         eanquQZxtrfNqSTxqZWBh5eiX+/q+ZKYYSshekkMZFozLZ1+KCwMY0lcfv/4ZZPLEN9/
         y+PrFYMdZLxxEzg6OpLltpTmjUotSPjA651MfpiP4DoAPUKWKLO8og5HJowy8mjthE2b
         520w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747430666; x=1748035466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvRhcUvsur4qZV9ZsxMG2pchOpKzL3rOM+elE1weNSU=;
        b=SWbPNYkTnjVZCZp/gaYz3H+8zq9UMDe5HNFCWuFxENjUx7Hu0P5YMqhvI9qqkJNZWr
         wcuvR9NESuOaLNZXPr3zGBBomB49VqjTCeUmP0N6xQB5+6aRSBBtJQzoslPlf/Zaiz5l
         /GJayJaPoKjFqIDMfxbiPwYTF0YKkh73PLBmBSEQqA7X6sA4W9/3wMeXVUuTv4fDjEZQ
         vOndIjDDHhkcserkebcdmtpqNbo2QnqqN/9fw1C2TdRBFeeDOPGe7okusB28CqAbrkEh
         s37GCzt2FX5yKkpmUbHzbFB1j/xp2zWsnkVPS8L3Y1RMUkA1ryYsMYciy7pXzs0wRWIL
         WlHA==
X-Forwarded-Encrypted: i=1; AJvYcCUUu7JbMjQjWIN3KRHYEmfMUENXgn+fT5CIU2CpLIYIGq1ykCrcOzCH8gvNW8tB2PcmHXcIJ7/lKgsaKGjxCN4=@vger.kernel.org, AJvYcCUXmnvQVZbEamJg+ItW9oZ/13kWTCpN5kEdeR9GEBSUqOtK/Q7U6bKSjwHtSGBqcxkgYmIBznQLAoLoeksb@vger.kernel.org, AJvYcCWKtwZ/NXxLnpMT6uEV5OTiDWe4kEbUDulIrFOl4Q3DgMcbQfsTAkGbN3KPl8Rw7WbBFG2sG04K@vger.kernel.org, AJvYcCWxkQpO3jWWGgRSTqpB8IxwLBf4oIWWebGg0Pg6tVaMU1AOOecT7rXpCTLuHxcEkPgCJwnw4GoJhI6u@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1nRiZZZ2KUMsk3OS80XKE8i2dXkNzWsWrR68ONKCH4yD2Pdr
	OrrsvelyGmT9Vc8xC31qWzQLF63v3n64jBnRSz/IvoGnXqudMKT+487s
X-Gm-Gg: ASbGncvt2Pqk3LjITGWcrFUkQIsy9dV4Rkg4BUF+VX5VDOamp47eSndiri8FAa2HJa6
	Gk6Rdm7PSwVe1Ucl20mFwhxf1lPHZYGobB6mUFvqMU/rFz1Xjv2Z/hAL/Y/EjctfFsBUja+7o7v
	R+nvw53Rmpe0DiYyV8RpuY+25u3Ehrj+eXlFVzqtfv1h2EOWlwkVYk/EHedmG1WTsqxhqMvFtxK
	v6PVNFXFz0JRHYthNebwcd/v8Dja5nNkc37FiYnb1rC3sBty25iuT84gF0QONH7ihWwektiJA5C
	BTARlNt0OZXZkKsDA25BdG7rr9TvH50WsVUWzdFIyyRWaLg51VUMGKey4l8d7C4tz142bvzESyi
	/AMvWIQuk6ZWROGLyxVnM
X-Google-Smtp-Source: AGHT+IHBu5gaFTo0DO121zUQEU7JsjqRjD5+dD9+rqZvfWxvapxAxMvW0QSuLdEtxQjpzTqrpyJquQ==
X-Received: by 2002:a05:600c:468f:b0:440:6a37:be09 with SMTP id 5b1f17b1804b1-442fd6312f8mr56780095e9.16.1747430666359;
        Fri, 16 May 2025 14:24:26 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442f39e84d3sm126293555e9.32.2025.05.16.14.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 14:24:25 -0700 (PDT)
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
Subject: [net-next PATCH v11 2/6] net: phy: bcm87xx: simplify .match_phy_device OP
Date: Fri, 16 May 2025 23:23:27 +0200
Message-ID: <20250516212354.32313-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516212354.32313-1-ansuelsmth@gmail.com>
References: <20250516212354.32313-1-ansuelsmth@gmail.com>
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


