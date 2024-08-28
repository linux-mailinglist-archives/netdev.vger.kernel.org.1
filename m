Return-Path: <netdev+bounces-122687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E8962316
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF06B1F21C76
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC7E16131C;
	Wed, 28 Aug 2024 09:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A81607B4;
	Wed, 28 Aug 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836270; cv=none; b=D5uzbSc3LIJyNzbUUpEi9SPZISio+saHIzSLcERfxrlwM1ezmIUI+nPeBl3O3Q4AG8tv2St2vE2Bup1WoaW69Ki7HbQMp32SojHxudthVXf6nSwMnwwxRApJrIJEp2mZ50VSUFRgJ/WjcBizMRrBqDAKndbufrGSL4PSqgS28Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836270; c=relaxed/simple;
	bh=Gmi7k6UkPOYhBa4r2T42fV3RHnBGQE/xc6vWt6lS/UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QiRvCpTJ9JuKyjlqc+O3AboFK+eRuQEB4dTfFxD6HvUWqsRi4PEMLWXVsma9KdTXSviuvue8PzDlNdG4Y/NhLe/5QTmlh8x42KADGEzlP+Ysm9TvT5tuOITrMdekaF1zt+WqdQlKs/GYOwitkC64SshvTMCcTKLSswpRoJxDh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z4YaRPI_1724836256)
          by smtp.aliyun-inc.com;
          Wed, 28 Aug 2024 17:10:58 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanlai.cui@motor-comm.com,
	hua.sun@motor-comm.com,
	xiaoyong.li@motor-comm.com,
	suting.hu@motor-comm.com,
	jie.han@motor-comm.com
Subject: [PATCH net-next v4 1/2] net: phy: Optimize phy speed mask to be compatible to yt8821
Date: Wed, 28 Aug 2024 02:10:46 -0700
Message-Id: <20240828091047.6415-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828091047.6415-1-Frank.Sae@motor-comm.com>
References: <20240828091047.6415-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt8521 and yt8531s as Gigabit transceiver use bit15:14(bit9 reserved
default 0) as phy speed mask, yt8821 as 2.5G transceiver uses bit9 bit15:14
as phy speed mask.

Be compatible to yt8821, reform phy speed mask and phy speed macro.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/phy/motorcomm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 7a11fdb687cc..fe0aabe12622 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -46,12 +46,10 @@
 
 /* Specific Status Register */
 #define YTPHY_SPECIFIC_STATUS_REG		0x11
-#define YTPHY_SSR_SPEED_MODE_OFFSET		14
-
-#define YTPHY_SSR_SPEED_MODE_MASK		(BIT(15) | BIT(14))
-#define YTPHY_SSR_SPEED_10M			0x0
-#define YTPHY_SSR_SPEED_100M			0x1
-#define YTPHY_SSR_SPEED_1000M			0x2
+#define YTPHY_SSR_SPEED_MASK			((0x3 << 14) | BIT(9))
+#define YTPHY_SSR_SPEED_10M			((0x0 << 14))
+#define YTPHY_SSR_SPEED_100M			((0x1 << 14))
+#define YTPHY_SSR_SPEED_1000M			((0x2 << 14))
 #define YTPHY_SSR_DUPLEX_OFFSET			13
 #define YTPHY_SSR_DUPLEX			BIT(13)
 #define YTPHY_SSR_PAGE_RECEIVED			BIT(12)
@@ -1187,8 +1185,7 @@ static int yt8521_adjust_status(struct phy_device *phydev, int status,
 	else
 		duplex = DUPLEX_FULL;	/* for fiber, it always DUPLEX_FULL */
 
-	speed_mode = (status & YTPHY_SSR_SPEED_MODE_MASK) >>
-		     YTPHY_SSR_SPEED_MODE_OFFSET;
+	speed_mode = status & YTPHY_SSR_SPEED_MASK;
 
 	switch (speed_mode) {
 	case YTPHY_SSR_SPEED_10M:
-- 
2.34.1


