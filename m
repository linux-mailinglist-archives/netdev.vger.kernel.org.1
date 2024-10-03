Return-Path: <netdev+bounces-131488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3998EA27
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 09:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC4528994D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 07:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772883CD2;
	Thu,  3 Oct 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXZ21Ly5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476881741;
	Thu,  3 Oct 2024 07:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939462; cv=none; b=GWTVxwi+Ljdr0+G9lptjcxRhnBRIayEb2/1sBEE9kAHnj4UNkdGZKYRKanRd9r01HvaQg8j3wNmDB69c7vT3WAQGW4YICKZ79zD9TxKI2c0/Ocfpf4XW8xdlU3YUYIHjnRnHuG8MlvJETCFdNdwgCbGZVRWgzTffDlvJHrioHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939462; c=relaxed/simple;
	bh=84lnNA0eqVpackYrBd523yXXCmW6IkDpAA5xeW+IymI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=StLSDQh+BH/JHP5RVc/EBzip7wXa+tHU1zBOSfYqe9sGDpXNEVSZ8Yhmh2nNSKxkuDggcoVQHJ5wd2Klp8efPZvTNNTfeXIvibHKL/N1BW54NBsf385+SUWxWTYSuDR7Hzx+7aZAlm8mMkhOHDl8A3S90h7Dxe89G0h0GHxMaKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXZ21Ly5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20b84bfbdfcso11699145ad.0;
        Thu, 03 Oct 2024 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727939460; x=1728544260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4swTbsIyyjGxId3pTtmiwYIu8DgC7aQm9o6kUfsLAtc=;
        b=bXZ21Ly5tyM7R4AtkCzcCvH/+1riW9efUUYQkdKMNbXypUay2h4vMUUrMcodUHVs2E
         cV2f7dTvmrJQDXeY8UYFkBSWZu8mi8Zwvubu1rmlm2gjgLlvFEhFvo8SdgVWYhzdhWpi
         Cm3jXAOZS0LXx7d5E/3MuvPGX4/LuKhRP3VHjlWjpuEFZcFjbQKj8r5jL4FOZgERb+VX
         Je7I2lbbmECjwZQQnWm5OyB851WnWYVb47xz1ij/H6GXOBPhE3QXnl/gm+qfp20DrEES
         eBew9lTjm3M0Ztvqf/rizFHR7lGe8IeKqacb6YNxL3vRyrHp8KSWZ59Lny4nnetB0x5S
         ROhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727939460; x=1728544260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4swTbsIyyjGxId3pTtmiwYIu8DgC7aQm9o6kUfsLAtc=;
        b=kTC9DH/TawkMVD+ukRF8bU8HXkJFipsGBYaGB/e/K3XJkbQgfj1n59FVijMe4wl98A
         emJmlr6teeHOfEv9HfOqBHtXIUHDF1LHy7EuYc/gfzUyW/8wuajmgDpCgoytBn8N7ZAF
         XXJuof+kYbeQ1iMkSjGQPTtEObq394ujhptRGNr6cN29V2Tf81JMnduuMIF1psZkFHAM
         EUCEn0h5r2RxF616unzHbFH4k0L4Hrzki3Pm0Jp15iiMpD71VZIcWUsuwb9RLdOLEhSc
         LqDnzcckdZHfkA92jvZaOQZbjMp01cSKkEqlWIBpyDH8y7nJlbhoLKJL8zVP8u3sWQh5
         0lzw==
X-Forwarded-Encrypted: i=1; AJvYcCViau1//Tv0umsu7frRB7ld8jYGTMiyRiouHoiKTjOZXM34jJas6Nz/SI8UvNtvmunliRnzNIr6@vger.kernel.org, AJvYcCWgDIr48ZUXiBFeKU6h+lbJCVGVFRudQZEV/t7gGoekayN9rZRGMqiBPtdIzjjIQt4S4XfaIy7cnfYg6Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr6b5iA+Xbk68zz4ZF+4txrLEVw+Zuv0Vf+XJSkXlN8Mbmy9LX
	wHETrfexcRmSwAxPGvBcxOQwTeraR+a6hk9M1v9RvGqvh09HeFZA
X-Google-Smtp-Source: AGHT+IFbSIec96E5DlG2psOFYqwDO0BuMCkonLjj1NtHBEeVIm0osDCp4AuUPwImocc9QNJ4jt4gmQ==
X-Received: by 2002:a17:903:2443:b0:206:aa47:adc0 with SMTP id d9443c01a7336-20be193c440mr29276495ad.24.1727939460266;
        Thu, 03 Oct 2024 00:11:00 -0700 (PDT)
Received: from harry-home.bne.opengear.com (122-151-100-51.dyn.ip.vocus.au. [122.151.100.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beef8eae0sm3455255ad.150.2024.10.03.00.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 00:10:59 -0700 (PDT)
From: Qingtao Cao <qingtao.cao.au@gmail.com>
X-Google-Original-From: Qingtao Cao <qingtao.cao@digi.com>
To: 
Cc: qingtao.cao.au@gmail.com,
	Qingtao Cao <qingtao.cao@digi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/1] net: phy: marvell: avoid bringing down fibre link when autoneg is bypassed
Date: Thu,  3 Oct 2024 17:10:50 +1000
Message-Id: <20241003071050.376502-1-qingtao.cao@digi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 88E151x the SGMII autoneg bypass mode defaults to be enabled. When it is
activated, the device assumes a link-up status with existing configuration
in BMCR, avoid bringing down the fibre link in this case

Test case:
1. Two 88E151x connected with SFP, both enable autoneg, link is up with
   speed 1000M
2. Disable autoneg on one device and explicitly set its speed to 1000M
3. The fibre link can still up with this change, otherwise not.

Signed-off-by: Qingtao Cao <qingtao.cao@digi.com>
---
 drivers/net/phy/marvell.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 9964bf3dea2f..efc4b2317466 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -195,6 +195,10 @@
 
 #define MII_88E1510_MSCR_2		0x15
 
+#define MII_88E1510_FSCR2		0x1a
+#define MII_88E1510_FSCR2_BYPASS_ENABLE	BIT(6)
+#define MII_88E1510_FSCR2_BYPASS_STATUS	BIT(5)
+
 #define MII_VCT5_TX_RX_MDI0_COUPLING	0x10
 #define MII_VCT5_TX_RX_MDI1_COUPLING	0x11
 #define MII_VCT5_TX_RX_MDI2_COUPLING	0x12
@@ -1623,11 +1627,21 @@ static void fiber_lpa_mod_linkmode_lpa_t(unsigned long *advertising, u32 lpa)
 static int marvell_read_status_page_an(struct phy_device *phydev,
 				       int fiber, int status)
 {
+	int fscr2;
 	int lpa;
 	int err;
 
 	if (!(status & MII_M1011_PHY_STATUS_RESOLVED)) {
 		phydev->link = 0;
+		if (fiber) {
+			fscr2 = phy_read(phydev, MII_88E1510_FSCR2);
+			if (fscr2 < 0)
+				return fscr2;
+			if ((fscr2 & MII_88E1510_FSCR2_BYPASS_ENABLE) &&
+			    (fscr2 & MII_88E1510_FSCR2_BYPASS_STATUS) &&
+			    (genphy_read_status_fixed(phydev) == 0))
+				phydev->link = 1;
+		}
 		return 0;
 	}
 
-- 
2.34.1


