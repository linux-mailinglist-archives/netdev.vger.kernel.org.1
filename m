Return-Path: <netdev+bounces-191365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1AABB32D
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 04:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB4B3B26EF
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 02:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20581C7005;
	Mon, 19 May 2025 02:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCY5/VFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BABD148838;
	Mon, 19 May 2025 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747621472; cv=none; b=IhUvc6hbY3ujVLFt6iaPAqpSnHFavPKk3+3XCb/W1Yhouf0bk8rWqZVzyBhw453w92PlU+iIN/KfF7TPFHmqPfavnOlZvubdtPJZIonI7OVA6QkXUJiUHyG0DJoLwgP7oSO6Q/ftJmzMrFDAkLFhUjM26qeHkD4TqXRSkU0TO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747621472; c=relaxed/simple;
	bh=+6JefHOyRDhuRcD7uicxKOr2Vmu000LwlUIzhsrBtfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/NJyul2JpDTKc8D3sQKojkt1t0d/SxIngL8DnTKO8AOaJnv7VVTBQVkHV5hkBsc193pa9R9kYf7KulxvjkL/eLYGl/d53VUiv1IU/BhlP86Q7bgTF74V4qtjYeTgeqsds0F++UgGFmTuhC59Ka4VXewyjry2326urURiMfybfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCY5/VFy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c922734cc2so464245985a.1;
        Sun, 18 May 2025 19:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747621470; x=1748226270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgckMePkDsvoiomlsNhotMuX9O+MXw76eEiqf1frqvs=;
        b=kCY5/VFyyez7MlM3+IOnwnBqJ2FauaixfY9Ez6BAQN9d0W5+HYWTiGsd1hKWEorahY
         gceliX1PQGi+slSyNVOxhi+qNs5artzEqIyTs1PtQT3ZJCu82sfMB8Ac1TI9JgXhR6rf
         zEkIsvJPfr7fjjtY8s1tCQq7AUgFVjDAaHEZjnj+PnJ2r1VdrK3V61M1VwADUFRWxEAP
         loXcUpYOZwky98I7VQK2/7lC0PnmC37kMNEEbvG0VsCerTDp8x4gVJTbMj5fDx9Waxvq
         84HW7n/RTmHwYDqleoKIjpcoeQczZqdB+/RBra+nDFau+/sSgM9LvEKWHLYKIoFV6iyC
         eh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747621470; x=1748226270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgckMePkDsvoiomlsNhotMuX9O+MXw76eEiqf1frqvs=;
        b=Gu/K8En1s0vmaG/Wp7lZIIRP+m8ZN/dU0Eg8lBE7qnjNbvSoIlkfbWM1EmU6UXvRkI
         EJHYih1h1xfRSujrCMBbTL0VOD839JRXJbjxSQmqGuRpXo6H2QrYKoSS3QhMXHTf1CRx
         QaChA6yhlGLyMOYMU//Axs9Zt/GkaXEsUdY+64HcqZmVvERjRWDof7kQsTn7IkTU7gRa
         gchjZxRgysRxCIpD9movGdsG42wL6g7ba4lxyvev9R1HUqAgm1QMsMiYVuiiDzHzyz0G
         mSrRDkAF7S3+pHq+mvZCmOy1dnT1R9Ljmi3WQsw8ZZdO5IKYkLMIWvsXISmbqinHtHRW
         IWvw==
X-Forwarded-Encrypted: i=1; AJvYcCV4cNvQSo2wMtUrbRjK9m2yxoMf04KdOKv04ShG/n3QF/XeShvv/TA09BiSQuQlyD2BTxb1wbJKPGuZqWA=@vger.kernel.org, AJvYcCVgS9tef91LTM5w/ltIfD9xF6xC/BbFIoUADkS0puOwizsBeT04aZyr8FgifbiM1hTEKThP4BHD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywja4bTfeG+l58VultGeFye26KsqF/Ca5ogI5OeDqf60tfMXBpL
	khx6gSSWVLPG5IVge35ULCFBhDAF5CG7Ip57YF3zHJjz+c3R0IAM6n/c
X-Gm-Gg: ASbGncu0DSBllsjgQzHzkPVJjYLMt3MJHRnmHWUGwNx+pwxJVXnRKq6JSvyeZ9F/i7m
	bonC1TyrCEM24N18eWFfcrsFVw7XYaLVIxcuhMlE4UTE+C4eBWMwspiTx8+Ea9Q/kn8hmWXLFXI
	RKUCS20dUYw1NzNlJodnfnIE57dfIDmRTQdRFj34VQQ7AxDf3bJuIfi+Nor5PrSsfvPSy1GGacF
	ESNX5GOZTsWntNoTBrQQZ0YJuZUz+kpGeIQxht0D/zw0ufRBsBcyzdHjqEvADONLO45T+7fT6iZ
	7AjrLc57ZB4m6LCgoxlHG2OaHtDSSs6K3wR9vbsYd4AihWdaF5Kl
X-Google-Smtp-Source: AGHT+IHuWe/rBBjfv75XfVSHZZHVi2QoC/iWDtHKHkxwz+Y444DamRvdY/8UvCyFty7xfX3CD65ggg==
X-Received: by 2002:a05:620a:1265:b0:7ce:b799:8eaf with SMTP id af79cd13be357-7ceb7999146mr542709185a.3.1747621469745;
        Sun, 18 May 2025 19:24:29 -0700 (PDT)
Received: from CNCMK0001D007E.ht.home ([2607:fa49:8c41:2600::f21d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08ac575sm49550766d6.43.2025.05.18.19.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 19:24:29 -0700 (PDT)
From: chalianis1@gmail.com
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anis Chali <chalianis1@gmail.com>
Subject: [PATCH] net: phy: dp83869: fix interrupts issue, not correctly handled when operate with an optical fiber sfp.
Date: Sun, 18 May 2025 22:24:17 -0400
Message-ID: <20250519022417.338302-1-chalianis1@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anis Chali <chalianis1@gmail.com>

to correctly clear the interrupts both status registers must be read.

from datasheet: http://ti.com/lit/ds/symlink/dp83869hm.pdf
7.3.6 Interrupt
The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
be disabled through register access. Both the interrupt status registers must be read in order to clear pending
interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.

Signed-off-by: Anis Chali <chalianis1@gmail.com>
---
 drivers/net/phy/dp83869.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a62cd838a9ea..98d773175462 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -25,6 +25,7 @@
 #define DP83869_CFG2		0x14
 #define DP83869_CTRL		0x1f
 #define DP83869_CFG4		0x1e
+#define DP83869_FX_INT_STS	0xc19
 
 /* Extended Registers */
 #define DP83869_GEN_CFG3        0x0031
@@ -195,6 +196,12 @@ static int dp83869_ack_interrupt(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, phydev->supported)) {
+		err = phy_read_mmd(phydev, DP83869_DEVADDR, DP83869_FX_INT_STS);
+		if (err < 0)
+			return err;		
+	}
+
 	return 0;
 }
 
-- 
2.49.0


