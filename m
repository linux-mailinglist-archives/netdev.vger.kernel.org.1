Return-Path: <netdev+bounces-238003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE6C529B9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F781892C2F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFCD33970D;
	Wed, 12 Nov 2025 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH5g/mvo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA17335549
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955861; cv=none; b=ZVrbRxepKL+eNDwWqWt/yqK5dkBmHVt30pCO9idpxSUsFZXSDmEF33uDwoIyRB2FrRwlAraE8XWUSZnRkmcV2ATIe/w6jEFiWtRPjPQyaoj6uLGYZP0e7FFBT3LKBGPvMoCTfFLfqU3lHI0qyfZ9dpyojrHTiNM2+eCfah8+XOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955861; c=relaxed/simple;
	bh=x1YSbtYbRyTPSIhv0/6W+8ceVWJJTyabUu/t8xJbjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KejPZ4qj/zUQWcxbWBeFdAVSQp2kbu12zREpjgn4QPhXpbd2R0XAolvSXUq580Xn0nGvXkWJLzvHZrRQRlyEHtBjx9QSrexsXpF2vZqC+xOr7HTBNVtRFgf3un2DK2m3yf658mNKb62DbXLHracp0QXaZee0OuJGDYt6FlYi0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH5g/mvo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo146604b3a.2
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 05:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762955860; x=1763560660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSrL1EoqDUfnyHQYh0k/jlWwCZWampIQnukH68EzSFQ=;
        b=mH5g/mvo8k/a/WwAJJt9PSQAQFLYAC0cqhaA7TwV5ElIHX0pTFAN1/MG2YyiIQdPrM
         ay44YH6e2Wb9fzij2PfoWALQ0QeaG4v9QWJVTOPb+yTKbKnxFQmXRxjjfigIwIXBaa6L
         Oxtpw8Q6mDm8O/GGFFFpykzAzutcWkw2chJbckiChhLl+JvKr9o4IqRDovJviMq8zlEk
         RZx6HAoMrKM7dL8wNQE9bG2NcCQfKVZYHz/btbIXhd3vJZnvEi35/kLM8VKnNl01DQeL
         YRRmI0MhbVjjJMjF3zSu1lYePRqfBBQRl6ZbIlAOtc1Wcl1aj+9MM9F9cSXdMgtkYsd5
         GT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955860; x=1763560660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSrL1EoqDUfnyHQYh0k/jlWwCZWampIQnukH68EzSFQ=;
        b=Qoc3jUQ3Kc2uS01rFJQYcbA49X/3POkt57n5zbvpCawiSAu6L5gD9IA35B97PaLYUm
         yDomCKST0hrQRU7nhOtau3FYNYbtafao2rDczxcSq5dx/EFDAdp9sHVlTvlv5kExHhyf
         2W8cuWCDhNYe4Y+fkFiirbv8+970kRj6+6UjPAQWzAmRMPN3pympUAJQe0ZJXfiOtSMQ
         ub7ynGT+kWCK1jerJ10RawiO2Xyjpomuu7iyJAjayaPwuXExgFsMeUR//kv5t4GefVq/
         JTo5WVyvDMG8MFPJk5w9/iUKG1zesYiX7/QQ+hxFdj3HXvU3lD+iDjosr/vV2eRDlcK8
         Nv8w==
X-Gm-Message-State: AOJu0YzAam3Vd3wP80m4wR5B1kn/ClYCrrOOjQNlapB/n+Gortu+Pdcy
	cwJzLP8x2DHtlEcVEfXarfNZr/Nh4Rmv2g85MYJG2adlV+T7dFJbgiay
X-Gm-Gg: ASbGncuTGh+Z55J2q5MeHRZqkyt8cl+d9iCjlrIdrF+PBsqZeyT0BmWWh3gqky11bqe
	hqWVL3FoIUfTQC2LSp8XUe5RavzggsbGboNS5f75lf+Fe5tP4v/pJIk22H5z9Rf3evBrC8JwKeE
	MVlQ2d/oS7Neaumyn3MWozEOj7vwvYL5FwD7lWL+UCTO5cBuPazMResxgPKG/qjjFRwrH2TTVyY
	LokQIXX4lxi89FchUTTz6an1mvHGndi8Lfml/IE1wGEcmPtbKT6S811UKA/ou33Zas8+Iu7bmfl
	7g1CD6yOpooyIbW/om5Tt4sUNUWXw7fPaOndpEe+6J3qtQsRnEhyHG+gkVc+FQHrwMMYTDL/quB
	pcuwdeKA8QU7AjJPiZEkVdCPYD0J/5pap97rcMp1LLIz35udeqjFB7ekJ1ZU2NIXHxh9bOjdpDf
	WjJXVtIvtUONYvzi8EgHRa
X-Google-Smtp-Source: AGHT+IH8wA3xt+CQCkNui2Syc/fmlLx07b5o60cQDt4Q0PQIytlU1FHXoiYwxMvPJRREYg1Iq4EEZg==
X-Received: by 2002:a05:6a00:855:b0:7ab:78be:3212 with SMTP id d2e1a72fcca58-7b7a4af65bdmr3263452b3a.19.1762955859786;
        Wed, 12 Nov 2025 05:57:39 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5748:1c6:5ce6:4f04:5b55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0f9aabfc0sm18361299b3a.13.2025.11.12.05.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:57:39 -0800 (PST)
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 1/4] net: phy: mscc: Simplify LED mode update using phy_modify()
Date: Wed, 12 Nov 2025 13:57:12 +0000
Message-ID: <20251112135715.1017117-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251112135715.1017117-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v3->v4:
- No change

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


