Return-Path: <netdev+bounces-110490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48A92C956
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 05:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2956B22D02
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D69F39863;
	Wed, 10 Jul 2024 03:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="URB/wZJa"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51D383AE;
	Wed, 10 Jul 2024 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582788; cv=none; b=kJfxfCxCtiqjB8R1eUC++uRrD75EChOkJHBmdl5k+w9UaCuOIPYOlLEWIy0zWU9oR/WVgVuuWqCY+Dnae/2a4fG2VuyDdBl94p/a/1XZGW+Gp3E/DDl16MwIVHKzz3gJJ2CP1WeSBhRMsYKXFb9h+8Nw/glnbx//q2vFwCEGaFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582788; c=relaxed/simple;
	bh=SlqGkIVRf6lyj7y8M/u+PC9E6k5Kr08HL6t3Mmf1fpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MteuvTEQL+JGzaz1/ORwWl2fvelmc4MDO9/DwQ3o+DmamJ00TmpUBp7XCEKGawbSAq/mG4gIlOAcKKNudRsb2GbtXznCcQclyas+7746pDXE9Jxl/cCM3RPl7VM3o7M+WBo2FmCyc84mFNaVty9gqW6fdnwugeKNIKcnr+RsfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=URB/wZJa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46A3dPoA51590768, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720582765; bh=SlqGkIVRf6lyj7y8M/u+PC9E6k5Kr08HL6t3Mmf1fpQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=URB/wZJaVMzYn3dgcsVN0BZYG4VLxuF6EWHyggSirZDivRY60JXsbkuJEMQICIX6m
	 3K6CcAA3+U21YBaCXMOjxhzJClxbcTc6LzRFW9uwCIYglDvhwozL5WdibL7SUXzSG9
	 Tcu4phU952SoJwfQSzFiJV0CZzYP3on5lUNwjzRH5zl1/fZhYMLiHM8fC3iRHGF9HU
	 9UJSYsMcUct+8ZGelG+0XOwswznk8GDhREiXcg0ohXN1PsoZ8SuXfQYGdY3i2tT/KQ
	 jctxoBplOIRK1KeufAMP0D3oyhpAbtO6G+qm5tiwdPU3WMgRcqAgXyyIf4FU4stjWm
	 Fx2wT2caZTmwA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46A3dPoA51590768
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 11:39:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 11:39:25 +0800
Received: from RTDOMAIN (172.21.210.68) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Jul
 2024 11:39:24 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v23 11/13] rtase: Add a Makefile in the rtase folder
Date: Wed, 10 Jul 2024 11:32:32 +0800
Message-ID: <20240710033234.26868-12-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710033234.26868-1-justinlai0215@realtek.com>
References: <20240710033234.26868-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add a Makefile in the rtase folder to build rtase driver.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile

diff --git a/drivers/net/ethernet/realtek/rtase/Makefile b/drivers/net/ethernet/realtek/rtase/Makefile
new file mode 100644
index 000000000000..ba3d8550f9e6
--- /dev/null
+++ b/drivers/net/ethernet/realtek/rtase/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+# Copyright(c) 2024 Realtek Semiconductor Corp. All rights reserved.
+
+#
+# Makefile for the Realtek PCIe driver
+#
+
+obj-$(CONFIG_RTASE) += rtase.o
+
+rtase-objs := rtase_main.o
-- 
2.34.1


