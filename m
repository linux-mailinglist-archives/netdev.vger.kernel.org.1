Return-Path: <netdev+bounces-108420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD11B923C18
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AC1CB23BB4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 11:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808515AAC1;
	Tue,  2 Jul 2024 11:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="absIHYmk"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D115B10F;
	Tue,  2 Jul 2024 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719918534; cv=none; b=Vdni/Z2vYPYjHoP3pF+2RQ/GZ6OJMkIIAXOYxDAl6sNMgGoxHz4afKwZyOyZgV+9/kuplgsMcjeH3ICpF+9SOVC0sGLJdmiV7wV3mmw0C8mhDB7P417FWv+oUmxlCqd3k3W/OhPylIOQob8q+SgJ6qxmcRa91WiQhln2f9C7Yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719918534; c=relaxed/simple;
	bh=qqu1f8bbeU/SvJtG0ec6mPjZ4RG7l4GtvYUYiXGx2Z0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q25lgNbJ9LmHqh356wCMH+YfU6a99YqP+1subeRO9YtGbs2NPFLEWf99yoxNtm7GCou0m5Q7P00FIy/OZXc8sNfLWzpJZ3KaOqX8L9a6xF5Gda+pRkb6Es/P1InDjoh554ZLWX1l6TMnY15HDUCJK5JUenUP7CA9zcbvOV0940I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=absIHYmk; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id E1C3C100005;
	Tue,  2 Jul 2024 14:08:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719918510; bh=fPpkEigsqYyjY+usdDH0XAppyEwih+KQZdXHBtDT3hE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=absIHYmkNib+lwQ3U/psX8NwxfEO4GxLGeMy7iCga6mucsKDyQNe/Ry191Pf9Ig5Y
	 DHHf6wf7Jfu1+7pzMZ/zhZSIaSEXiegjgJbbafAG4KrTAwMXWrq5VXWxnl4R2EKZXx
	 f/dLzeMT84f99djqiOZ8Br10OfTqdTj7EuoGoQHXeQDncXfPJouTWL+M72Do0PNXWO
	 t3w60RfnpaW5AnboRZLsLmDaHcu80KlrGi5+cLdGphSStBxK6VaN4PuPNw6/7cNB3/
	 1PYIkrv99wug0GsN/1hZ8KRrZ6bcn6QGCsfdSxocHfZyyN9zguX/hWwi/iZE9sc69V
	 ZwxTMiQIM04uA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 14:07:24 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 14:07:04 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Michael Walle <michael@walle.cc>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net] net: phy: mscc-miim: Validate bus frequency obtained from Device Tree
Date: Tue, 2 Jul 2024 14:06:50 +0300
Message-ID: <20240702110650.17563-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186273 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/02 10:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/02 07:20:00 #25796017
X-KSMG-AntiVirus-Status: Clean, skipped

In mscc_miim_clk_set() miim->bus_freq is taken from Device Tree and can
contain any value in case of any error or broken DT. A value of 2147483648
multiplied by 2 will result in an overflow and division by 0.

Add bus frequency value check to avoid overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: bb2a1934ca01 ("net: phy: mscc-miim: add support to set MDIO bus frequency")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/net/mdio/mdio-mscc-miim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index c29377c85307..6380c22567ea 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -254,6 +254,11 @@ static int mscc_miim_clk_set(struct mii_bus *bus)
 	if (!miim->bus_freq)
 		return 0;
 
+	if (miim->bus_freq == 2147483648) {
+		dev_err(&bus->dev, "Incorrect bus frequency\n");
+		return -EINVAL;
+	}
+
 	rate = clk_get_rate(miim->clk);
 
 	div = DIV_ROUND_UP(rate, 2 * miim->bus_freq) - 1;
-- 
2.30.2


