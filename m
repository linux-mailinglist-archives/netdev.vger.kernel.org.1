Return-Path: <netdev+bounces-108458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44776923E61
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E42AE1F2318C
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432318306B;
	Tue,  2 Jul 2024 13:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="Jd+yYe5S"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AC85C74;
	Tue,  2 Jul 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925503; cv=none; b=bk6BauzsvM/ZzeSA6I+IW2c9zy/YITpshciqZTECg6Q1S0ycbFvTaL2UYvkSwyUX4w/EEMo8p+59bRgB2lodz41YXgWdH7DgKALkNiDC92B8dw0bVm7CCR4W8Jd5YPNsOXvUE8XMTkITcDfI16SQcVT1L4BQynd921QxF4LNq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925503; c=relaxed/simple;
	bh=3KcH1mvo3c8vxp6bWIMM8taPOyXym4k8+bE8hSgVFVw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SR35b2Bu104ENGmliFRrhgjtfsPg5W6Zikl0VpUjWcSIy2dLazXPnpOA8bf3KMMQF5MB0NMLUUZ1ytYCEDdNv/9VNJdLjrB94jrTVX8SEbRBnvXMbhJlpBPj+MDUU6lG8xRkUqKczn6mFa15MCy+J9iAk6k+flNbnTREYRdUpM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=Jd+yYe5S; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 4FC10100002;
	Tue,  2 Jul 2024 16:04:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719925475; bh=zowmtXX0f+3Uklt3sUVqGKSt/ix1I6aiLaxyigUy3zA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Jd+yYe5SOTcaorMCkrsPJibc1u+/4fi39vjeBCi8XsE3ujPzE8+kzCSCYyCTRjdW3
	 R4OcCaMIClDHK2kKAQ9cW4AQJ8bTwJDFJEFFKGnr7n9fWqWt8dzzPlALearBXP39gP
	 HkkuyeVFRLiovFUT9dUT+Wf8R7kMltbZG0LZ9NwD6eLoNiZIndG0AIz60abISshGIL
	 0UUP0tp+KfEfHQ5YDbd0tpgcy2XkZ95Dxb8e6Iq+EaHoVqvGGEEMlXFNCYcBjq1yQt
	 T6AeVxytvJI6NbkH7gmDhz208kB7w0BVGNbue4E4d9vxyuPFZ+Hdl6guT+TcwI3Vzh
	 i9RCFHOxflkig==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  2 Jul 2024 16:03:30 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 16:03:10 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Michael Walle <michael@walle.cc>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH net v2] net: phy: mscc-miim: Validate bus frequency obtained from Device Tree
Date: Tue, 2 Jul 2024 16:02:47 +0300
Message-ID: <20240702130247.18515-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240702110650.17563-1-amishin@t-argos.ru>
References: 
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
X-KSMG-AntiSpam-Lua-Profiles: 186279 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1, FromAlignment: s
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
Suggested-by: Michael Walle <michael@walle.cc>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Detect overflow event instead of using magic numbers as suggested by Michael

 drivers/net/mdio/mdio-mscc-miim.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
index c29377c85307..b344d0b03d8e 100644
--- a/drivers/net/mdio/mdio-mscc-miim.c
+++ b/drivers/net/mdio/mdio-mscc-miim.c
@@ -254,6 +254,11 @@ static int mscc_miim_clk_set(struct mii_bus *bus)
 	if (!miim->bus_freq)
 		return 0;
 
+	if (2 * miim->bus_freq == 0) {
+		dev_err(&bus->dev, "Incorrect bus frequency\n");
+		return -EINVAL;
+	}
+
 	rate = clk_get_rate(miim->clk);
 
 	div = DIV_ROUND_UP(rate, 2 * miim->bus_freq) - 1;
-- 
2.30.2


