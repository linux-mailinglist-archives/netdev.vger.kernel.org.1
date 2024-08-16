Return-Path: <netdev+bounces-119115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5873954185
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E34B2417B
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607983CC8;
	Fri, 16 Aug 2024 06:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467181741;
	Fri, 16 Aug 2024 06:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788627; cv=none; b=MAJFdInDUMJtwEyl5Ozoo4xV1AIOcaOIhxsCl1BDrU18TEoHH1DKFlIT1AcQ5nyvXeEzqgIK3xQyfwy+xnldgnf3I4VT0ZnkAFW18SCve7a4BgBngKApAeDQxWotkbE6oG/gXgtIvsrm3FJJQ0B1zQbJKB5wBLjGXOCPTrTD9Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788627; c=relaxed/simple;
	bh=rxmN7Pby24mGurTygZWz9+BPv4X/JVoMM3GvCcdYTKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZsxsW0/sFSwS69G9FMFdVtDrvkcVaz/HthCxx9ANi9KrgWy5fsuFdX1B8+cHU5g1Z3YmzceSFoSW9IURoVCd4hfwjNeDC3MmsT99QGfvLpYj2+6oFwLzTKBQ0NA4WfcQRzTiq1FJOFPw0mJoXQEmxaw3VJgLaejtH3Od/tAEZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from ubuntu.localdomain(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YtTOKia_1723788612)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 14:10:15 +0800
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
Subject: [PATCH net-next v2 1/2] net: phy: Optimize phy speed mask to be compatible to yt8821
Date: Thu, 15 Aug 2024 23:09:54 -0700
Message-Id: <20240816060955.47076-2-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
References: <20240816060955.47076-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

yt8521 and yt8531s as Gigabit transiver use bit15:14(bit9 reserved default
0) as phy speed mask, yt8821 as 2.5G transiver uses bit9 bit15:14 as phy
speed mask.

Be compatible to yt8821, reform phy speed mask and phy speed macro.

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
2.25.1


