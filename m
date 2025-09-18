Return-Path: <netdev+bounces-224233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D373B82A87
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 04:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353F27B11A7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851C1FBEB9;
	Thu, 18 Sep 2025 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="l9Ov9PEJ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC961F582A;
	Thu, 18 Sep 2025 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162926; cv=none; b=kbmqG+A0R2nxWv2aPGGH2zuquIgaOU7OXZmK9MLrts+1BnqXr2D+hDkc2H5OoFFmv/J8bu5KufHl8LGNVt6BImbHJDrjzvF9s2vWy6V8zPs5md+ejH4oD26orekEXpYKLbVCuFQ0mRAL25KioEMfI5vUGNcOQqMUXrNZE2vdNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162926; c=relaxed/simple;
	bh=Ub+XbuCkb3TRROxtk/77YAYbPimsD6APSgrqgCixQBc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbdK/So4mYl29g+ZWHh8jXYGrlqVIQ5ewuqg1+1UqOXdZxaQMfBpuCKTXcVloOnJGOJ0oN1Ut6R+H2MM47F1gUcQq5b2tanJrn0vsgVwvXPI8ZaJJeWMaXLM9k1XYdQSbM4GcEJKdHzZvFoU4JLMti22jitIs57r00k2Va3Qvd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=l9Ov9PEJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58I2YrPzA1253472, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758162893; bh=5GgfzCcsVBrBOyrzohjfkGGUZgibSyCdVHMRgrgGc/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=l9Ov9PEJnkHhHfmIluFnwIP/311NycLwpah1Gv4GzxDEyX5TL25KPYe2XMqMe15I+
	 26WS4V7W+XD1j+U53xg6qkDznGOJGIR+ckklH8yp4H6JkmWZLIAXSXp/16F4nvHehv
	 geIyiOOx4+FTy2ME1ZgGUwDCBrKcP5sSVMsghlMJM+Hdz5PMU7NkQvU98DbuGYACEk
	 eUJj4QxuY/EWUsQHFu7Bi8dJQNVaSPF2GcDsvJfothLeswdWRWlqIIah6FSku31Vu1
	 hd4PGGNjo+sYspXJwVJuPtnyioMcjnwfbAc2TlApJaKGBAomiIUAZzoohF19WujOmj
	 acEgUNACC28gA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58I2YrPzA1253472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Sep 2025 10:34:53 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.33; Thu, 18 Sep 2025 10:34:52 +0800
Received: from 172.29.32.27 (172.29.32.27) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.1544.33 via Frontend
 Transport; Thu, 18 Sep 2025 10:34:52 +0800
From: ChunHao Lin <hau@realtek.com>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        ChunHao Lin
	<hau@realtek.com>
Subject: [PATCH net-next v2] r8169: set EEE speed down ratio to 1
Date: Thu, 18 Sep 2025 10:34:25 +0800
Message-ID: <20250918023425.3463-1-hau@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

EEE speed down means speed down MAC MCU clock. It is not from spec.
It is kind of Realtek specific power saving feature. But enable it
may cause some issues, like packet drop or interrupt loss. Different
hardware may have different issues.

EEE speed down ratio (mac ocp 0xe056[7:4]) is used to set EEE speed
down rate. The larger this value is, the more power can save. But it
actually save less power then we expected. And, as mentioned above,
will impact compatibility. So set it to 1 (mac ocp 0xe056[7:4] = 0)
, which means not to speed down, to improve compatibility.

Signed-off-by: ChunHao Lin <hau@realtek.com>
---
v1 -> v2: update commit message

 drivers/net/ethernet/realtek/r8169_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 75272510f7e2..8903ae90afcb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3409,7 +3409,7 @@ static void rtl_hw_start_8168h_1(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xe052, 0x6000, 0x8008);
 	r8168_mac_ocp_modify(tp, 0xe0d6, 0x01ff, 0x017f);
 	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
@@ -3514,7 +3514,7 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 		r8168_mac_ocp_modify(tp, 0xd412, 0x0fff, sw_cnt_1ms_ini);
 	}
 
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0070);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
 	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
 	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
@@ -3715,7 +3715,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xc0b4, 0x0000, 0x000c);
 	r8168_mac_ocp_modify(tp, 0xeb6a, 0x00ff, 0x0033);
 	r8168_mac_ocp_modify(tp, 0xeb50, 0x03e0, 0x0040);
-	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
+	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
 	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
-- 
2.43.0


