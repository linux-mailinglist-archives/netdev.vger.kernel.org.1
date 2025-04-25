Return-Path: <netdev+bounces-185862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C210AA9BEC8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12ACB1BA0491
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653F22D780;
	Fri, 25 Apr 2025 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fi2yxVXy"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB322D4EF;
	Fri, 25 Apr 2025 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745563289; cv=none; b=TL2qAfD3nFoe448N9Wnh1tA7J/Uy3L5rV7yoeYiqFh8jWDwoQ7kq5nhTXxvAlAVj6E3xyRRRQNeiriLG5p6YvHefH0rHyoGJhHXLifRbko4grwD8exqDnDgyC+hVPVhrSkoIcKMs9RMVJzx5EHsyMNzemc+FaQhukEl6V4Eu3Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745563289; c=relaxed/simple;
	bh=O3p8axfLSNJ2gLotHYzkCpD+1PoLs7XYhd8gjjBQpFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g+F2IwCApuDxwh4ba/TEU1qwW6hw5ZKPFDJN72hZtxCOnN2mYlYKOT6mkVUiwexU0Imjg6zrDWcb4fAoSkFlO51A7iYF99BUQ5qdTdaPjjLuBUgPwXC66JKHOMo/Cu/SRqzv+8bTgujfbpkhh19CeRRBMmDyN1d/zmchIbJ6wqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fi2yxVXy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53P6f8HO12530571, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745563268; bh=O3p8axfLSNJ2gLotHYzkCpD+1PoLs7XYhd8gjjBQpFo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=fi2yxVXyTqOmBsFd+QlWYztZc4e3Y9qB44e2n1x7Yp2jhFjMIgbUKqclkErLvpzye
	 4OEn763QZcSenBjv/JBnOjXCW+5soG9+IwvnI7mirQHuW98rDLcvliJP57jPC3Lddx
	 RD3EgTw5T+iGKwkqDt1JDV6rsOGl7XTh2FBcZWzP243j+aJdIIX91QqJw5RnPjIl0E
	 uzwvP4fn1oHudvtL06oCEmr4RuoFeW4vgu+dcMG36wQpSsyBU621rlMtlPUItyFn0M
	 xSv9JpUjc4/KJs3JhKAUkUVQQVntbQyPKyVnkLnT3/3n3NEsnxyfGRta1k0K5Sqjrp
	 Bp79SRp0xC+Jw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53P6f8HO12530571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:41:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 25 Apr 2025 14:41:09 +0800
Received: from RTDOMAIN (172.21.210.124) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 25 Apr
 2025 14:41:06 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>,
        Joe Damato
	<jdamato@fastly.com>
Subject: [PATCH net-next v2] rtase: Modify the format specifier in snprintf to %u
Date: Fri, 25 Apr 2025 14:40:57 +0800
Message-ID: <20250425064057.30035-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
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

Modify the format specifier in snprintf to %u.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
---
v1 -> v2:
- Remove the Fixes tag.
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 8c902eaeb5ec..5996b13572c9 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1114,7 +1114,7 @@ static int rtase_open(struct net_device *dev)
 		/* request other interrupts to handle multiqueue */
 		for (i = 1; i < tp->int_nums; i++) {
 			ivec = &tp->int_vector[i];
-			snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
+			snprintf(ivec->name, sizeof(ivec->name), "%s_int%u",
 				 tp->dev->name, i);
 			ret = request_irq(ivec->irq, rtase_q_interrupt, 0,
 					  ivec->name, ivec);
-- 
2.34.1


