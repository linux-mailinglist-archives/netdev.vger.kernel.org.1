Return-Path: <netdev+bounces-237499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B442AC4C94F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE3924F7C77
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095B2E975F;
	Tue, 11 Nov 2025 09:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJj3DaH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F9261B8A
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852274; cv=none; b=S8SRnBlQ03DiGIfoxK3WV3Zl4ZMlSDq24P9HVEFQwD9Ia8FImzPvbJbQoispOYFjwEbPuOkAhoWplx5mEsWLd9beuLwpvjid3Z0tb1nU8fvHiqwebAq9KbOSyh5Is1Gi3W1Cy8glCalGlxNQfQb4BN5LacHswspX0BHJsbB8LKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852274; c=relaxed/simple;
	bh=lqV5WRM2NSFAJWw74e2ONru1rtp/SZ+WcUnGqRa/bLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnpH1IVMN5VTaT061a81Ui0Hq7FvoFB9Vh1geuD75YkH0SHZY8FLzDN2ykjzDBSfoNJmuNDqGnluUguZW73Z6pCdwbM8AmKwgLs1/8XqWPuubVpbTKq+lExfIVHZNouO6kNscr81X6dmkCFKjKdK+YtUdbd1bqazxRjRCZfEWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCJj3DaH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29812589890so25916365ad.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852270; x=1763457070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdoqcLpLAaqwgFbl0QBXFrgUcQK68Y6GkxJRdLyp9fM=;
        b=kCJj3DaHT80ENJiaozJoMP0mxBtxgNFmxAKXxX+CDMOi2JXXcdsk0Odxi9y3bvX5uP
         gEuLehrSe0Kh6Z530CA6MvfzvB9UQpmZI5IRCiq4ggfhutLdTL/E+XTELXl7T/c+c/2q
         Sr5SNqGIIY4KrDVAb9jnHa7x6TJ1vcvrrIuoOxd6CSm2Sgu0jU4XvmS9U44oCWB7tc/Y
         FBEOYmkWfR6o6MhNsC1qXy5Z687mzpis35OiYn8qpEeLxcXpB8BbkGWpJ4dpgpmh83pe
         KsRvw5vCX98hMjLe2xthpiD8LCDTP9vP5InNvDizw1ve1YRm5d2Feigs19iLmmy0F/Gz
         PwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852270; x=1763457070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DdoqcLpLAaqwgFbl0QBXFrgUcQK68Y6GkxJRdLyp9fM=;
        b=cJHWHRSWpNTp6xbZujE+YiiDbmRKvivHM3Z9x+P9/LhKw76/n+8sl+ZsNlHMcFyeT/
         0QnslQ8xXzWVc66Rn4Haib6nGs1XDGPYtRj/87sw/xjb6JpXsmJymou8YrLP1mPHpU+0
         dN4JICl4Q2n3TTaKBohu2iDwQqZ5TD0DqZQr1vlnOVCporvxID2MAjRCgd6wUDxaIP+W
         tHK/HeOFZEqZq1LASkR0kLmLqUi7p4q2hbQEk9XRiHhNnw+WuHyEooNPyRhvG8O/TlO7
         JMyAqaKR236qRoN78HGclwQ8UIXEZ4J6CuRB+M4rLH92QHRHP2VkXmx+KEKjxXjsnRnJ
         4rMA==
X-Gm-Message-State: AOJu0YwrdWxMvB8b5AxBa0vOMJWNLe3AVon2NdmEUYu3ax+bJ63crRz7
	yoDmNpfHk6KQdVYyNp4eeHJmuMgYdK761J8GRNA9NQ6nP+LTkTTRVvoW
X-Gm-Gg: ASbGncvp40dxVku3BSMYvWl5x/NJp2wmTQVj2meQ99gLckBMc/x1xtJvv+lPXeJsXH7
	6yt1WmDa7ErYH9rFJawj8KpSbPeoAf+5vBH+qGzfDj3LROqKnbz3qG17stiCBiUVKz9nyuT7628
	k5XZVX7ACBAcONUPZ+2n5D314C5XgZTy20YqHnnmZZLDgX/jaBFuJfuw7AIcP1c7npu2betxkKK
	1VkXx33YzRlOkrUaoULZXPoyRqrtleeZ0G9kBk7we58QYnSBU4MXdMUCx+hVAEHh6myPExzUvfK
	jbtNdSmYFPQt/vSuXzU+d8Z46P3eZnUCHKyd+6INFxSX5/N+TrGm7coDJiU9E5kWXXC4fd4tQiF
	bR6vULkyghP01dH/Y8G/DAaFUk10+PFWkAln/EVfZ2nQ4WlFAq3wD5WkEDrM9RCBTZix8SNDXPw
	Mc7s4kQWW/+DFHlqBGisP95Q==
X-Google-Smtp-Source: AGHT+IEplxamzvFzNgi3OD1pMrtWSJCi9ogRE5FJIgYLTfsbriTNnGpDHIDuvjqeLpXuDDLdxABm5w==
X-Received: by 2002:a17:902:f684:b0:290:dc5d:c0d0 with SMTP id d9443c01a7336-297e56d0e12mr165153635ad.49.1762852269852;
        Tue, 11 Nov 2025 01:11:09 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:79c0:4ab7:69ea:ca5e:a64f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5cf37sm172715415ad.35.2025.11.11.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:11:09 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 1/3] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Tue, 11 Nov 2025 09:10:45 +0000
Message-ID: <20251111091047.831005-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The vsc85xx_led_cntl_set() function currently performs a manual
read-modify-write sequence protected by the PHY lock to update the
LED mode register (MSCC_PHY_LED_MODE_SEL).

Replace this sequence with a call to phy_modify(), which already
handles read-modify-write operations with proper locking inside
the PHY core.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v2->v3:
- Added Reviewed-by tag.

v1->v2:
- New patch
---
 drivers/net/phy/mscc/mscc_main.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 8678ebf89cca..032050ec0bc9 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -177,17 +177,10 @@ static int vsc85xx_led_cntl_set(struct phy_device *phydev,
 				u8 led_num,
 				u8 mode)
 {
-	int rc;
-	u16 reg_val;
+	u16 mask = LED_MODE_SEL_MASK(led_num);
+	u16 val = LED_MODE_SEL(led_num, mode);
 
-	mutex_lock(&phydev->lock);
-	reg_val = phy_read(phydev, MSCC_PHY_LED_MODE_SEL);
-	reg_val &= ~LED_MODE_SEL_MASK(led_num);
-	reg_val |= LED_MODE_SEL(led_num, (u16)mode);
-	rc = phy_write(phydev, MSCC_PHY_LED_MODE_SEL, reg_val);
-	mutex_unlock(&phydev->lock);
-
-	return rc;
+	return phy_modify(phydev, MSCC_PHY_LED_MODE_SEL, mask, val);
 }
 
 static int vsc85xx_mdix_get(struct phy_device *phydev, u8 *mdix)
-- 
2.43.0


