Return-Path: <netdev+bounces-190937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33951AB95B5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACD3500CB4
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 05:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758A8221728;
	Fri, 16 May 2025 05:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dDFJCk6G"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AE2139E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747375011; cv=none; b=e4uXfHiIbMOlZ2fjxWfFulNejNNbtFJmNVNeWaVPq/tmXPFcVkftluvuJE6TJvyQpkuI0iFPl8OsmZsW0r5IuqsJiKnJ/Hfpk2tM6UGcXrSomDWeT9uKYQJjHMDClLkdr0RKcT+FEl91ILNjrUqT2wKHPcfAlVgN6V0VBHRX4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747375011; c=relaxed/simple;
	bh=ZIXvE9BaAk7s8wIvwGhpQNwVhXXtQgJYEv+VvIPZtSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Koed0urSYzrUBG9Hy5rwqp7jwkTqNshfCPZ4UKnXAZTSipnL1TXdc9MIY+tdV7dAoMO4usYZbawuzGWF0KSuiA7+SWXMOQ3xQX822tLus2AO94AONAyHaoNZXUQ1tf1Ogj/fzvI7fshCdBilTgp1pXqL0i63ym/OPCXDTaHCRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dDFJCk6G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G5uQCX1442984, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747374987; bh=ZIXvE9BaAk7s8wIvwGhpQNwVhXXtQgJYEv+VvIPZtSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=dDFJCk6GUO6eY9gcfTaV2bYtvharTeNu9qKj+++YuEZmZ60+EepkMgK0/ZLCTbIV1
	 d8GxLd6ol1fqEDzCliXB8DPCK/DLv0QaLmtgbxUaRa8gZyxL/H5VlQyALEtpQHkvo2
	 DuieSDlKH3b+0Vm6shEnAeexsY5pxc56qfnru7HWQYvJDDBnh4qk6DxtZjjAGtUgCN
	 e18mvUKvxKFepOBR88mtaz1VT+CamN2eSFGVfVdvePH12eoED4TIhIDX6kpncNJPRf
	 k9/oRRZzthqRdbWUpf5qoqZT67x5P4F5ySMnT3FYeCc+9buK+MGb4fonhLfm0olAa8
	 XT4B72TyUAh/w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G5uQCX1442984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 May 2025 13:56:27 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 13:56:26 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Fri, 16 May 2025 13:56:26 +0800
From: ChunHao Lin <hau@realtek.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, ChunHao Lin <hau@realtek.com>
Subject: [PATCH net-next v2] net: phy: realtek: add RTL8127-internal PHY
Date: Fri, 16 May 2025 13:56:22 +0800
Message-ID: <20250516055622.3772-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8127-internal PHY is RTL8261C which is a integrated 10Gbps PHY with ID
0x001cc890. It follows the code path of RTL8125/RTL8126 internal NBase-T
PHY.

Signed-off-by: ChunHao Lin <hau@realtek.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
v1 -> v2: fix typo

 drivers/net/phy/realtek/realtek_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 301fbe141b9b..b5e00cdf0123 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -158,6 +158,7 @@
 #define RTL_8221B_VB_CG				0x001cc849
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
+#define RTL_8261C				0x001cc890
 
 /* RTL8211E and RTL8211F support up to three LEDs */
 #define RTL8211x_LED_COUNT			3
@@ -1370,6 +1371,7 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	case RTL_GENERIC_PHYID:
 	case RTL_8221B:
 	case RTL_8251B:
+	case RTL_8261C:
 	case 0x001cc841:
 		break;
 	default:
-- 
2.43.0


