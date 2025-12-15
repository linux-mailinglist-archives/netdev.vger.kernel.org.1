Return-Path: <netdev+bounces-244748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE1BCBDEFB
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C5C530329F1
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C28C2BE64C;
	Mon, 15 Dec 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LfrZfV0+";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LfrZfV0+"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5589A2D7D2E;
	Mon, 15 Dec 2025 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803605; cv=none; b=ZK8aDf4AlmcW0HTA9zpAqvnEF6TvvOsg4cQPgWHnIbPoWvJaDybG5cKLGk1572R/GEBRohQ8lp42beGopxEXM9jOxEQj+/uBJAaAJ27qFMnlbHbALTinKDWe+MLsmCKLpUKsgHHzSwQJbSVlHfkm9fbgNHogwWY94/c0QmzQU8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803605; c=relaxed/simple;
	bh=bFW5wc7teN8wCrjLWApoNlxe5ivNEhXG0ZFJWMv1Om0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIhpxnCY4glOKqpHaxykHlL3NETBp1CKRNfhSbUBkAJSGboo8RFyeWmaHr/ZidSSBBQb6xkb02R4p0NF6lRsvHRxfscs8YynroNbpehDfb24ra7X2mm3TSUHGHR9gD5ah3qE+pUbcHmkI6nXrbI5J+pk8TMA3bNkR7BGEIztSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LfrZfV0+; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LfrZfV0+; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/BAOnQl4PiBFWoROmLFA/gBRGEHU/8ET6VKFmfi7mQQ=;
	b=LfrZfV0+uuxrwE+xZihutr3i0daDSADpyAvJGAOuxVA1L1K8rrxycuDlXU1+Bvp8Vm7Sld1nu
	71sqlVorS2fJaRL/KEeXD2LdBXQ6fpSc8Br7lgE5pSqUJTImVt0IUR1spTQf/qj4ZEmoQz/aD0p
	0xJsKmz5PdBgO0ccYIUCXzI=
Received: from canpmsgout11.his.huawei.com (unknown [172.19.92.148])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dVKs94Ttgz1BG4S;
	Mon, 15 Dec 2025 20:59:41 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/BAOnQl4PiBFWoROmLFA/gBRGEHU/8ET6VKFmfi7mQQ=;
	b=LfrZfV0+uuxrwE+xZihutr3i0daDSADpyAvJGAOuxVA1L1K8rrxycuDlXU1+Bvp8Vm7Sld1nu
	71sqlVorS2fJaRL/KEeXD2LdBXQ6fpSc8Br7lgE5pSqUJTImVt0IUR1spTQf/qj4ZEmoQz/aD0p
	0xJsKmz5PdBgO0ccYIUCXzI=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dVKq33MvnzKm6s;
	Mon, 15 Dec 2025 20:57:51 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BB601402C6;
	Mon, 15 Dec 2025 20:59:51 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 6/6] net: phy: motorcomm: fix duplex setting error for phy leds
Date: Mon, 15 Dec 2025 20:57:05 +0800
Message-ID: <20251215125705.1567527-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251215125705.1567527-1-shaojijie@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

fix duplex setting error for phy leds

Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/phy/motorcomm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
index 89b5b19a9bd2..42d46b5758fc 100644
--- a/drivers/net/phy/motorcomm.c
+++ b/drivers/net/phy/motorcomm.c
@@ -1741,10 +1741,10 @@ static int yt8521_led_hw_control_set(struct phy_device *phydev, u8 index,
 		val |= YT8521_LED_1000_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_FULL_DUPLEX, &rules))
-		val |= YT8521_LED_HDX_ON_EN;
+		val |= YT8521_LED_FDX_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_HALF_DUPLEX, &rules))
-		val |= YT8521_LED_FDX_ON_EN;
+		val |= YT8521_LED_HDX_ON_EN;
 
 	if (test_bit(TRIGGER_NETDEV_TX, &rules) ||
 	    test_bit(TRIGGER_NETDEV_RX, &rules))
-- 
2.33.0


