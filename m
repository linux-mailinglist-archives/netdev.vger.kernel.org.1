Return-Path: <netdev+bounces-99976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EEB8D744C
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 10:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76EDFB2090B
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A9200C3;
	Sun,  2 Jun 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PMRYLY3F"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F57E107A8
	for <netdev@vger.kernel.org>; Sun,  2 Jun 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717318062; cv=none; b=ARI1QLcGrdRDvHJUmclsJwtLs3osox0HLG+WYn6NSjPr19V84ByAnsGqFv0al+9I1wyH6y7To1zMxVFqiIe8fwQ9DvTW0+eXY53J1KEGVUe0r/8OgpPduZEFebs8ohN6WFW+vS2/iG+/bLoTVBMDQ14/b4SDjYk4NQB2Ia9tTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717318062; c=relaxed/simple;
	bh=vxhHl1shAaT9SaQw+1I9O3xUoHL1Bo5eWQUn3I4F6yo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TwA8c81P7UljqgGxJr/ZX0AgZ3/Zd4uPnGyrInWQBK31r9piQ5eXo+yNpag8Kz5JPOiGU6sVHfysH8Lv4IlqNaVMoWDF0N2IMle3G96gZxIEnZ58UkVze3vMMVZcpbZ1Exx/rzIJ8NWJJPHsFLxl2nuznnZcO7hc3DS1QDUjTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PMRYLY3F; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=1NEJXsLR64adtlrsXa
	2OMmHhNf/cgPalZPeH8Bwiw1I=; b=PMRYLY3Fmld7551D+sapcuMJQ6rMVOpDcF
	8G4RfMkP59nPayUzvTE620kRTt3hPuOAJ0oVINiOQgpTwG92cQ3WrTxzt+8NF2HF
	D2sloroSMvtjju2Eb9OD+XWgtCYkwQKrOceF8ShxQvZYXesN/HVCC/xQhz/kFbns
	1J9SwuLXk=
Received: from yang-Virtual-Machine.mshome.net (unknown [36.157.223.206])
	by gzga-smtp-mta-g3-1 (Coremail) with SMTP id _____wD3P4CFMVxmPpIDAA--.521S2;
	Sun, 02 Jun 2024 16:47:03 +0800 (CST)
From: yangfeng <yangfeng59949@163.com>
To: andrew@lunn.ch
Cc: hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	Yang Feng <yangfeng@kylinos.cn>
Subject: [PATCH] net: phy: rtl8211f add ethtool set wol function
Date: Sun,  2 Jun 2024 16:46:57 +0800
Message-Id: <20240602084657.5222-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3P4CFMVxmPpIDAA--.521S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw17uFyxXFy3WryrKr43trb_yoW5AF4fpF
	srAa4rtrWUWwsrXwsxurn8Zr1Svan29rWxGry3Xa1I9F9rJrn3Ja48WF98AF13CrykuFWf
	Kr4vvF9rW39rJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiVgrxeGV4IoOLEgAAsw
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Yang Feng <yangfeng@kylinos.cn>

Stmmac+RTL8211F cannot set network wake-up, add related functions
- read: ethtool NETDEV
- write: ethtool -s NETDEV wol g/d

Signed-off-by: Yang Feng <yangfeng@kylinos.cn>
---
 drivers/net/phy/realtek.c | 73 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 7ab41f95dae5..2378202e6d5c 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/etherdevice.h>
 
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
@@ -87,6 +88,11 @@
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 
+#define RTL8211F_MAC_ADDR_32_47_OFFSET		16
+#define RTL8211F_MAC_ADDR_16_31_OFFSET		17
+#define RTL8211F_MAC_ADDR_0_15_OFFSET		18
+#define RTL8211F_MAGIC_EN			BIT(12)
+
 MODULE_DESCRIPTION("Realtek PHY driver");
 MODULE_AUTHOR("Johnson Leung");
 MODULE_LICENSE("GPL");
@@ -1109,6 +1115,71 @@ static irqreturn_t rtl9000a_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtl821x_set_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	int err = 0;
+	int val = 0;
+
+	err = phy_read_paged(phydev, 0xd8a, 0x10);
+	if (err < 0)
+		return err;
+
+	if (wol->wolopts & WAKE_MAGIC) {
+		struct net_device *ndev = phydev->attached_dev;
+		const u8 *mac;
+		unsigned int i;
+		static const unsigned int offsets[] = {
+			RTL8211F_MAC_ADDR_32_47_OFFSET,
+			RTL8211F_MAC_ADDR_16_31_OFFSET,
+			RTL8211F_MAC_ADDR_0_15_OFFSET,
+		};
+
+		if (!ndev)
+			return -ENODEV;
+
+		mac = (const u8 *)ndev->dev_addr;
+
+		if (!is_valid_ether_addr(mac))
+			return -EINVAL;
+
+		for (i = 0; i < 3; i++)
+			phy_write_paged(phydev, 0xd8c, offsets[i],
+				      mac[(i * 2)] | (mac[(i * 2) + 1] << 8));
+
+		val = err | RTL8211F_MAGIC_EN;
+
+		phy_write_paged(phydev, 0xd8a, 0x11, 0x9fff);
+		err = phy_write_paged(phydev, 0xd8a, 0x10, val);
+		if (err < 0)
+			return err;
+
+	} else {
+		val = err & ~RTL8211F_MAGIC_EN;
+		err = phy_write_paged(phydev, 0xd8a, 0x10, val);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static void rtl821x_get_wol(struct phy_device *phydev,
+			   struct ethtool_wolinfo *wol)
+{
+	int value;
+
+	wol->supported = WAKE_MAGIC;
+	wol->wolopts = 0;
+
+	value = phy_read_paged(phydev, 0xd8a, 0x10);
+	if (value < 0)
+		return;
+
+	if (value & RTL8211F_MAGIC_EN)
+		wol->wolopts |= WAKE_MAGIC;
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -1179,6 +1250,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= genphy_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
+		.get_wol	= rtl821x_get_wol,
+		.set_wol	= rtl821x_set_wol,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc916),
 		.name		= "RTL8211F Gigabit Ethernet",
-- 
2.27.0


