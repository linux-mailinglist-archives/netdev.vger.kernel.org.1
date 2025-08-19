Return-Path: <netdev+bounces-215020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF40B2C9E7
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 18:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78ACE1BC619A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3E283FF4;
	Tue, 19 Aug 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/XB9JiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398825228F;
	Tue, 19 Aug 2025 16:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621720; cv=none; b=CnEw/2Y9UEGWEsvbI2ZDfF7JXq7pDEpcGTdDxkUaDLprqVqzhoJH+R7MKdPDnwvprXhv7/z4qyEEqCVZSjNjb9pIPrOJ0mq9GoQWHPFUoNXKd/MmeMSRPbNFm/5dSqiNk4rLEa6AWDUFSqRzB0WXfJqKAHCw4b2dE4TjfYKMJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621720; c=relaxed/simple;
	bh=4NY2yeWwO1/lySCuscD0X6YTArnddn4170u6EFF+HfY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/WZlcgu3BVcGF4DFXA5eKSqsiMA2vfH9JRDuMJxaApyxRddcwxJ7/8G7Pmr+mEeTW0k4sURSbhd82h2UYKy2gvR/tqHldcA+x89OjUjRrUPd7UZsUX4pavOttiF6Gcp5XjsXxas7kWSHN432KKLmtOxqhSnDyaFFrVdqnYluKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/XB9JiT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so30499385e9.2;
        Tue, 19 Aug 2025 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755621717; x=1756226517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxX71PXS3MJnJ5r/8RA04vZAE4FRLUH21Dt1zod0mbQ=;
        b=B/XB9JiTEdwWrhVnO3sBsGA2L3qUi14JEiyRDiYESUeG+VKhUabxR20J7hkFpApqam
         DQOp49PcPBAdpqfMGvJAg0N+yODD9ZtbJM5wLPzVJqpm8e4QxwFfQOcoNgWXRnmV2sHB
         hrJ+j7MC1Z1vvRT5kAUu/ao/+KHBXBRnGWwY8j5ddYxxFjNKcQp4Z2qMwVbIEOZoBU54
         7i4wVQb43Z4Xvzmf5WAv0m+ijeJn0xV25j8ToZtfhTzwQ9cKw1sNZ+zC4et8WT8bBDW4
         lS7xc1rYK8IORiyIJNB7bZyZbqoAxWhCE398E2BgkiUNkns7ia58HY9lDi9FHCprPgBh
         Vu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621717; x=1756226517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxX71PXS3MJnJ5r/8RA04vZAE4FRLUH21Dt1zod0mbQ=;
        b=P70j2qWqNKbIFCu+SidPFAkvw6E/LDYANBzDZONt6GPAH5AMe/MJ/kNDFf4GWnakRK
         lYDDXaP/0l0XqQ9e3fCIKYhzePZBHTuwU4gtI1RYFCWbaf7BnVcKa089IowTYYcaIU73
         6J357+xcZjI36QtAR0XPgwthXuCsHyp1hI0GMmYfEq6meck+y4cSdnX0E9qvXZo7KnjD
         5AhU+mPDxLUh25O67GhCVdv7gysxJRVI7voGUPaJfnhu9WJnIJWzC72juz6bMZCZ0DGq
         /wV64/t0lT8+ocmgpj5LqEW8O42LcVn/nRBqmdNHQp98hUHnOGpL4If9KPi89bwmoEBO
         0seQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzJSN9jUAdEsXvXr8DkVlZrNAvWqdwFtEMxRwlHBi3u8u8kjijj1bMWiBGJHQSA6CKCjIM1euM@vger.kernel.org, AJvYcCVW/3wU5hwRVB750iTujRLoHrpMLQcwRZnzqsrrFDaoKEc1WK0OyNOCp3wmIKjUpqbZ8NadE4Tsit8Mp4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ83LFprFVHvbJaeabvuLug6OuqQ92EyaR2ZAW6hcQOCud5eJn
	qK4YpCo51mW0R6bXRlnXFZOabVap1igBto8X8XEjGOBiVcHpMR2HDq+v
X-Gm-Gg: ASbGncsLCJN4wppr9OoXKTJm0hDcTaMcEIWQcykAweoe5u1Bluxs3FpEpj9g2O3ueKu
	c77ruXyEkAC5s/T4yjjckL8FF2pqaB1Q+JenbeJFM56VW0vN4VyKHSugFgmJzLUxK8wmih4LyQJ
	TqOiICX0Kx8+Ropz7oB4DXjeI2WSICPdvHncf2E1QZi3KD8Pwdq4TwObWjRKAVYI2AJ7PWKKhOD
	TAcaQhFUwr9LZV8iUeqH5XXPp5tENLEhkqxj6eUg+5t9LEyNDI8d564iFnvpfs5a/frXKXDOga8
	YQmh6dIXmikOq0971SG8iS/9p2tVl7qmC3pOqAQBedRat7XyDeQDkEC7eUvBFDx1jI2nGa1Q9yL
	G6h0FTxDT2RZDeBMVukvSr5DipbORQGC9BqTg5EchCG0wPjfQEMcggsK8/0XUharprIB/N40o8A
	ZReJTd93bPuTY=
X-Google-Smtp-Source: AGHT+IFDIfAL1PMrBbwe09+/9imnqhNdJLZgmQly4SWiKUqwJ+XF2dETMxPxVQYyM9rrcs8MD+Eokw==
X-Received: by 2002:a05:600c:4f8c:b0:456:1204:e7e6 with SMTP id 5b1f17b1804b1-45b43dc0522mr31048255e9.11.1755621716705;
        Tue, 19 Aug 2025 09:41:56 -0700 (PDT)
Received: from Ansuel-XPS24.lan (host-95-251-209-58.retail.telecomitalia.it. [95.251.209.58])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b42a8f972sm51494015e9.20.2025.08.19.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:41:56 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 2/2] net: phy: as21xxx: better handle PHY HW reset on soft-reboot
Date: Tue, 19 Aug 2025 18:41:41 +0200
Message-ID: <20250819164146.1675395-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250819164146.1675395-1-ansuelsmth@gmail.com>
References: <20250819164146.1675395-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On soft-reboot, with a reset GPIO defined for an Aeonsemi PHY, the
special match_phy_device fails to correctly identify that the PHY
needs to load the firmware again.

This is caused by the fact that PHY ID is read BEFORE the PHY reset
GPIO (if present) is asserted, so we can be in the scenario where the
phydev have the previous PHY ID (with the PHY firmware loaded) but
after reset the generic AS21xxx PHY is present in the PHY ID registers.

To better handle this, skip reading the PHY ID register only for the PHY
that are not AS21xxx (by matching for the Aeonsemi Vendor) and always
read the PHY ID for the other case to handle both firmware already
loaded or an HW reset.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 92697f43087d..005277360656 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -884,11 +884,12 @@ static int as21xxx_match_phy_device(struct phy_device *phydev,
 	u32 phy_id;
 	int ret;
 
-	/* Skip PHY that are not AS21xxx or already have firmware loaded */
-	if (phydev->c45_ids.device_ids[MDIO_MMD_PCS] != PHY_ID_AS21XXX)
+	/* Skip PHY that are not AS21xxx */
+	if (!phy_id_compare_vendor(phydev->c45_ids.device_ids[MDIO_MMD_PCS],
+				   PHY_VENDOR_AEONSEMI))
 		return genphy_match_phy_device(phydev, phydrv);
 
-	/* Read PHY ID to handle firmware just loaded */
+	/* Read PHY ID to handle firmware loaded or HW reset */
 	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MII_PHYSID1);
 	if (ret < 0)
 		return ret;
-- 
2.50.0


