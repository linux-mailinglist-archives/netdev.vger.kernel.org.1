Return-Path: <netdev+bounces-117594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803D94E6EF
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE235283CE1
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8C1509B0;
	Mon, 12 Aug 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bG2bHv3f"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741214F9C7;
	Mon, 12 Aug 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444941; cv=none; b=K2EGdW74aDCCRRB0aTNfXqxx77BdbH2Li/Y8c3uPfc/AruFtG92G6M6yycWpdsYdRrqLHxGAKtY4NFeJh8279jPRNM+ypgq++gxMedpgqZVQyqtsFETp5/20ZWYG8fKB9qAGWHSrq8hVOeVwssjoltCHothxggD2VXKIpYYVJdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444941; c=relaxed/simple;
	bh=lL6XwdZJ4/NSnyTZr5wjeCiLPkV47JPaGNNKpbRUVio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh0v6jVvBY2PpS0TIwxbI8M8umfQPYvkKKVI9bbVYbOtJW5VXkmUrJBKHyMQ2+Vil3U2Ufi+ozXLmRxzXNvaiyxpDkTMBcBRvnE83bCQZUdjqL7zAm9kwYXhmqWhHEfEdlnd9GFMnskzVSshetLF1ikp2I+6ElgOCU46Ed0PKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bG2bHv3f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47C6fnPZ33759069, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723444909; bh=lL6XwdZJ4/NSnyTZr5wjeCiLPkV47JPaGNNKpbRUVio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bG2bHv3fVL+8QF99nc/yknr6h7Q3oaqJOhgckpKA7fUrvLkCWszFGW/pXDE3AZJ6+
	 IpOr+vDBqz0iJg7oDVUyPXWeva5L6xTAK02ii2s1MiWmRf7R8kDf6ihhqq8Mbjy6z/
	 jjcuSUCcho+zf6i/ENRqrRJnGUZt5y4MEA3YYU/bVFTuBfjUdtaNixEh+rHq5kW7JS
	 ZKxqPzyRDyQoxz3asvbvDKHF0pK3xiKxutWrd//neRRZ95M4o0Kf2yjPrs98EHF9M/
	 iudFh3TXPHvBBd3IbbZBv0GlNThRNUZsCHqtrr92XZVjdv+ekYEwhyPETZEGyxm0Up
	 pii1g9lbLKllw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47C6fnPZ33759069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:41:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:41:50 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 12 Aug
 2024 14:41:49 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v27 12/13] realtek: Update the Makefile and Kconfig in the realtek folder
Date: Mon, 12 Aug 2024 14:35:38 +0800
Message-ID: <20240812063539.575865-13-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812063539.575865-1-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
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


