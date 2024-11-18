Return-Path: <netdev+bounces-145721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0D9D0853
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 05:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3992B21850
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 04:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670D126C09;
	Mon, 18 Nov 2024 04:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="m4HYMhv4"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E9F12DD95;
	Mon, 18 Nov 2024 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731902984; cv=none; b=Za1B2q2mtNECalNUC8wta7eO81dv760/DnuQGoWxqyZKIJupYlJfhV10YohRGLoSZaXk2cHvMy+53uB70vYKqOPPctNrcpmn/styTCffOPKqo/fSN8PsYlxMLPv3NjaB8D7hOCdpLIutBRSUUrBUtPp4+L8K3ifB1fh56GJPJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731902984; c=relaxed/simple;
	bh=CykH9i7P9pZRTLcdwSphEWfFe4k6k8acMq71zcZ+/tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CQ4/E9BDcevH1zJhpO3COdBUDh5l0sINjmQMVK1NPG006RbjuO10ENLecrwkcuWuXAU537FnczsFiebLNP2ymYQoJS/XedMbFSKcA30ffNSswXt+lB5nd0AThW6jZJRVjWnf5t0Ydo/6fv4KsASOre4TexFfj4i5Rq50MK/veVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=m4HYMhv4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI49QMo8108266, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731902966; bh=CykH9i7P9pZRTLcdwSphEWfFe4k6k8acMq71zcZ+/tU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=m4HYMhv4V1E1wYKsOd5TrToIUYTHBtBD4o4r/MmcO5iN6xaCITZGWL7gFM/zLrb4a
	 VGlkkByIg+Ca+DWNb7QcFIfMXlJduOlCqLRTx6qtCeJZf2nvEosMFr50usznlnJKtI
	 OB9uYIvx/RkEJ6yw4BMWeCVFbzpsFocadrdZjO+1OeShx0toZQyw1oc5x6gIvAQorW
	 6f0Lf1IcqxmGywOp41HL9iMgGbAoWVjgK4K3jcETwDOdUXPhwqyp5hl+c8B+36irOo
	 EB5ut3fmSul4OLpccOacro/KlErycqirmeY4kCCh03Kre8ibXhQPAcpIDairWhYPs1
	 fJ0gfGYYAPo7Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI49QMo8108266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 12:09:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 12:09:27 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 12:09:26 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v3 2/4] rtase: Correct the speed for RTL907XD-V1
Date: Mon, 18 Nov 2024 12:08:26 +0800
Message-ID: <20241118040828.454861-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118040828.454861-1-justinlai0215@realtek.com>
References: <20241118040828.454861-1-justinlai0215@realtek.com>
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

Correct the speed for RTL907XD-V1.

Fixes: dd7f17c40fd1 ("rtase: Implement ethtool function")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 0c19c5645d53..5b8012987ea6 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1714,10 +1714,21 @@ static int rtase_get_settings(struct net_device *dev,
 			      struct ethtool_link_ksettings *cmd)
 {
 	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
+	const struct rtase_private *tp = netdev_priv(dev);
 
 	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
 						supported);
-	cmd->base.speed = SPEED_5000;
+
+	switch (tp->hw_ver) {
+	case 0x00800000:
+	case 0x04000000:
+		cmd->base.speed = SPEED_5000;
+		break;
+	case 0x04800000:
+		cmd->base.speed = SPEED_10000;
+		break;
+	}
+
 	cmd->base.duplex = DUPLEX_FULL;
 	cmd->base.port = PORT_MII;
 	cmd->base.autoneg = AUTONEG_DISABLE;
-- 
2.34.1


