Return-Path: <netdev+bounces-124007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B3967593
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 10:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4B51F21B8C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 08:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B21428FA;
	Sun,  1 Sep 2024 08:36:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-149.mail.aliyun.com (out28-149.mail.aliyun.com [115.124.28.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9381E87B;
	Sun,  1 Sep 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179768; cv=none; b=R5iGs9CN2NqsVuJa6FchppfeJyLDrTnG6hCxeSxk6AQBc/kVx/diazHp1VT/x/nwg953RlCLjg6v5A++redr0DBOum+0s6WsirZdyG+DPMl2TXnhfxX6T8NdZWXofcCVoq0SU9PmEHSB3HWSwOrG/sL1S4acAxTR81y3ciRaiKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179768; c=relaxed/simple;
	bh=Gmi7k6UkPOYhBa4r2T42fV3RHnBGQE/xc6vWt6lS/UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sU3a3pIgrqoEjbWgMp9xUWa2/QkwKM8CCExJeYnHqSPYbLE+Adr1MutfMbkUUXHPBiL554fe1msZpyxHXlxXR8h4JIcKMZLL4bnLiNXgsRitCxUfHRAjoSTODRlDGscpmR2bqRykx4snQWFsFdbREmiVd2StOAK8DbTXT8UhaZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.Z7fmnAh_1725179750)
          by smtp.aliyun-inc.com;
          Sun, 01 Sep 2024 16:35:55 +0800
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
Subject: [PATCH net-next v5 1/2] net: phy: Optimize phy speed mask to be compatible to yt8821
Date: Sun,  1 Sep 2024 01:35:25 -0700
Message-Id: <20240901083526.163784-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
References: <20240901083526.163784-1-Frank.Sae@motor-comm.com>
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


