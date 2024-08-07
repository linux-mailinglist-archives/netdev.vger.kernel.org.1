Return-Path: <netdev+bounces-116314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F4949E89
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7D61C20366
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8D419306F;
	Wed,  7 Aug 2024 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="MjbA7RGc"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDB1191491;
	Wed,  7 Aug 2024 03:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723002275; cv=none; b=EjDFuEATqcQQ2Rq/3KKpMfFOEMLjtdUuH1iV5RTDl5HHmjTMrNhX8I+RHhBuHHnxZcxVwGdU+1Ukvb+eLNlEY/Tn+N6MIFMDzWny0xvafLHH7QDICIC269ruOMya0AEWyskbMa38f7BY9TNAyZAGibDJoE4bL4F/GVlR9wfHrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723002275; c=relaxed/simple;
	bh=lL6XwdZJ4/NSnyTZr5wjeCiLPkV47JPaGNNKpbRUVio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/E9r94JFUD4HMUupYwLZ5js96jAkNwky1wqCuS61pnsCBGvAAWoaiJMQtNFlL3JKaO/wxv6iM1E/XY1I+MmDSEAEGuqXnBelHD0YJ+cNoNOOSobMf0voxJIgNmqwq8XQiYh2k1Qdmg+KVmQrdzcV9035raKv/6aYKU4jOVFVao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=MjbA7RGc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773iBVm91925390, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723002251; bh=lL6XwdZJ4/NSnyTZr5wjeCiLPkV47JPaGNNKpbRUVio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=MjbA7RGcxP5rIgOgCjJWqjPHf8aXoOzcsz2iTnOWv5AcJtNNlJpRWZa36vUMLBYcH
	 E/ngs+Ul3hebQdlXZwwm5oJiz+Gs7fBB5EAJd2dqU62ZiW/AMzZLV8pI5+FgkGldME
	 7tNjRmaMhTQJYGDbc+wW9TBmJGqYOrqU/6tYn4/P2qLuQQ4BQu1++BP63hLnF4KMH6
	 RpZWFyWrAd77fIzxxjA+lICOlGNXcwSJ/2sJr0JrNUc8Edk8hysjFmAhf8+0NZ5Xyq
	 2gNwWFF5gtVjVHTKXEJMA94bkLI5CdhFuuAB/+3hU5LcMfuuJ690KuqNy4zyAQHS4E
	 S7EqBQ8pGu0gA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773iBVm91925390
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:44:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:44:11 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 Aug
 2024 11:44:11 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v26 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Date: Wed, 7 Aug 2024 11:37:22 +0800
Message-ID: <20240807033723.485207-13-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807033723.485207-1-justinlai0215@realtek.com>
References: <20240807033723.485207-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

1. Add the RTASE entry in the Kconfig.
2. Add the CONFIG_RTASE entry in the Makefile.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/Kconfig  | 19 +++++++++++++++++++
 drivers/net/ethernet/realtek/Makefile |  1 +
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 03015b665f4e..8a8ea51c639e 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -120,4 +120,23 @@ config R8169_LEDS
 	  Optional support for controlling the NIC LED's with the netdev
 	  LED trigger.
 
+config RTASE
+	tristate "Realtek Automotive Switch 9054/9068/9072/9075/9068/9071 PCIe Interface support"
+	depends on PCI
+	select CRC32
+	select PAGE_POOL
+	help
+	  Say Y here and it will be compiled and linked with the kernel
+	  if you have a Realtek Ethernet adapter belonging to the
+	  following families:
+	  RTL9054 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9072 5GBit Ethernet
+	  RTL9075 5GBit Ethernet
+	  RTL9068 5GBit Ethernet
+	  RTL9071 5GBit Ethernet
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called rtase. This is recommended.
+
 endif # NET_VENDOR_REALTEK
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 635491d8826e..046adf503ff4 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_ATP) += atp.o
 r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
 r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
+obj-$(CONFIG_RTASE) += rtase/
-- 
2.34.1


