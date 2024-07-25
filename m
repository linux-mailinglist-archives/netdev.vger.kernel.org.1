Return-Path: <netdev+bounces-113083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0093C9C4
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB411C21DC6
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 20:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BF813CA93;
	Thu, 25 Jul 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b="DOrFhUfr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685213C906
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940112; cv=none; b=QgtTz45b+e4dS/ZaiiGCn2ueX+tla92lpK/R1x7Wv9pU8nX4L+ng3D7O/VmWOb7mTsHbhGvZ58Q3MZfYrSLeGRgDakx6wCnX3wW2tF3ZvS+wWx9gMSuCqT4jzSPBWj0ELOIy6aFVz2aoait965T+uR1s/yLqrg7j4C9mKNpOWFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940112; c=relaxed/simple;
	bh=xK28mng/bnxaic1esP1slkZdnGWYZ28SHlouBEsT0FM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S1VRvKsQbuu9nUZlMGljcXTRv9Nly5bLuPYx2IVflcNtEbmTOuVM9yjznJh+b0cYhMNwdVlnXDVzZ24MgVdNtBNKtMnvuyhHFrl4rB8F7um13bK3GmoXRIXMoEd+L+Jp+L8fxPAQ871xs5319gAUZr+HA56W9zgRk79PtABwGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com; spf=pass smtp.mailfrom=mentovai.com; dkim=pass (1024-bit key) header.d=mentovai.com header.i=@mentovai.com header.b=DOrFhUfr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mentovai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentovai.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a1d3874c1eso79489285a.2
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mentovai.com; s=google; t=1721940109; x=1722544909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WLbpeqt3rIl8y+5rh9L8E/UYZjJ9HJIE7nj3MV2qTU=;
        b=DOrFhUfrWIERzKyZcjblnfafzz+Z0gXmgTu923Bg2Ko4ZdRv3ePl6Hu5CRQ7kKSuNy
         PSrPheMLfBYuumHbZAoKLOo3gqSXSWkQ9fo2IbGhhpq5JDzUx90BhgZUNGKX2nsNv4Bf
         Ii5P0nn+3qMSOgTiHGQJG3JRc9SF/50SaXAe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940109; x=1722544909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WLbpeqt3rIl8y+5rh9L8E/UYZjJ9HJIE7nj3MV2qTU=;
        b=p9iyOmGsdSkpW+voMaSk/N5C9ucBoj92HaAxIjtgWrFrfqSoX4CpXTTiF5t8qIirqB
         rDNr1wpGWppV4ToXrlMC59UJfGFrzWJXkwjcVkEHfOTXLuGsbdw4ewy11dZLv8UXJRfm
         YGVNr5SFrlgfIkO9XYlkjAP6y/gmZpZz/QDYxfsKW3gZsmMPyNXb9+cIkEdXe2yyo63W
         78JtSSg80aXXi/3NS6tR3nSKEiHNJjON9lGwFhPv9W77PRBv+Nj7ArhHLFfzvRLVne33
         XVnlnuJgjQg09GyU4UneI75CdhpqrvL2OaVA2JVkugmHJFwRcwC7Dwl4ymPr/g+j6VjA
         jCCw==
X-Gm-Message-State: AOJu0YxQBw1gqzVGWLTMFteCmbo600VREkiEUpj0nKSi+wsYozmBTw/g
	c1e0uAJzPGIZ9xbU/GW9WDRe9uuUP29qcFeS9gKD0lHJrBj8ObbOA9QC+bF+PMwxgzBHYrvd66U
	O6mCYBg==
X-Google-Smtp-Source: AGHT+IEQDtXdknDU1gPe7D5nkSErKlBMUC3pLSMIdQd63CpbkXd2fzESJOUmy0dIseIMsiOt75fiuQ==
X-Received: by 2002:a05:620a:404b:b0:79d:5399:baf5 with SMTP id af79cd13be357-7a1d7e49247mr425554685a.15.1721940108898;
        Thu, 25 Jul 2024 13:41:48 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:a8a9:9eca:3c60:83f7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73ee80esm116966285a.70.2024.07.25.13.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:41:48 -0700 (PDT)
From: Mark Mentovai <mark@mentovai.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Russell Senior <russell@personaltelco.net>,
	=?UTF-8?q?L=C3=B3r=C3=A1nd=20Horv=C3=A1th?= <lorand.horvath82@gmail.com>,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Shiji Yang <yangshiji66@outlook.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: phy: realtek: add support for RTL8366S Gigabit PHY
Date: Thu, 25 Jul 2024 16:41:44 -0400
Message-ID: <20240725204147.69730-1-mark@mentovai.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PHY built in to the Realtek RTL8366S switch controller was
previously supported by genphy_driver. This PHY does not implement MMD
operations. Since commit 9b01c885be36 ("net: phy: c22: migrate to
genphy_c45_write_eee_adv()"), MMD register reads have been made during
phy_probe to determine EEE support. For genphy_driver, these reads are
transformed into 802.3 annex 22D clause 45-over-clause 22
mmd_phy_indirect operations that perform MII register writes to
MII_MMD_CTRL and MII_MMD_DATA. This overwrites those two MII registers,
which on this PHY are reserved and have another function, rendering the
PHY unusable while so configured.

Proper support for this PHY is restored by providing a phy_driver that
declares MMD operations as unsupported by using the helper functions
provided for that purpose, while remaining otherwise identical to
genphy_driver.

Fixes: 9b01c885be36 ("net: phy: c22: migrate to genphy_c45_write_eee_adv()")
Reported-by: Russell Senior <russell@personaltelco.net>
Closes: https://github.com/openwrt/openwrt/issues/15981
Link: https://github.com/openwrt/openwrt/issues/15739
Signed-off-by: Mark Mentovai <mark@mentovai.com>
---
 drivers/net/phy/realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index bed839237fb5..87865918dab6 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1465,6 +1465,13 @@ static struct phy_driver realtek_drvs[] = {
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
+	}, {
+		PHY_ID_MATCH_EXACT(0x001cc960),
+		.name		= "RTL8366S Gigabit Ethernet",
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_mmd	= genphy_read_mmd_unsupported,
+		.write_mmd	= genphy_write_mmd_unsupported,
 	},
 };
 
-- 
2.45.2


