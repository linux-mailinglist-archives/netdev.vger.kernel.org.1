Return-Path: <netdev+bounces-196036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C1EAD33A8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBE165844
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E720228B7EA;
	Tue, 10 Jun 2025 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DIVzysIB"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D5221D59F;
	Tue, 10 Jun 2025 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551683; cv=none; b=vAZU/rWoGfwPj0phtTbW9yS9k6Os2qGR1YrD4Z6x3udvBKvmjKM3N+MqWgyp6W0+h1yaxoMs7ztx1AITkCjmgvS93CW1iHEDTZaHXYC0nx1hLqTT4lyBT+UoA7cLIdERb9+lK01KTenvSuX0FMYGvQfONDMpJGB8wZidXI8sbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551683; c=relaxed/simple;
	bh=A1Z1Ia1YrGfyTYH+o9dHWTn7YRDm8n2qSR1lYPY3qbs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GTB35flnFQwa2mCAIpTu+xdfR/K2Jf3Fs4DRTKkahJPZAB3Zz7F9M6q/6K4SF6hG6TFtVrl8CWeMcJrXuV8c7ifLL59AdZliFg1ZE4WtGXAQvlI7eDCt9b5dozqZhqVBd9JTKUSNx7U3IYmofOb+3OP+1eWUJdH8QU5ETvRLhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DIVzysIB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AAYJIP02658375, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749551660; bh=zfB1fy2OQfwjYr+OJuUKtyjtSZzXsoy/epyMcGBhiNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DIVzysIBYEGta89PAygHCmq1NOWwl67rGnVJ8tUTOdHnH3DCOc1vGQQmqQRG0QV2r
	 h4+yLe8wp+0TGh16E1Yog1dRlhfoRcg47pQ+vopEQZto/iWSKfTuWs8hy2wxwEOWtn
	 AF1e9aa8OBkA3UYzPFN8ttgmYENEQP5JP+ewyPhQha9x/d06rm3Z9s8KafgOMwJMdS
	 WyoI3btpQ41MxGEgY2DbVE3YoL/CbwIRSqrTkcSQBBmmyicd8WVvmPcWeY9mMSWWFP
	 TLHm9lIF3AVRBig5E3lwrCFOLhTAYwYH7y1fLCWUYTrSTMCB/cyVcfO/556RXJ//AW
	 o60lNQ0lPvDaQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AAYJIP02658375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 18:34:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 18:34:20 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 18:34:19 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next 1/2] rtase: Link IRQs to NAPI instances
Date: Tue, 10 Jun 2025 18:33:33 +0800
Message-ID: <20250610103334.10446-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610103334.10446-1-justinlai0215@realtek.com>
References: <20250610103334.10446-1-justinlai0215@realtek.com>
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

Link IRQs to NAPI instances with netif_napi_set_irq. This
information can be queried with the netdev-genl API.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 4d37217e9a14..a88af868da8c 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1871,6 +1871,18 @@ static void rtase_init_netdev_ops(struct net_device *dev)
 	dev->ethtool_ops = &rtase_ethtool_ops;
 }
 
+static void rtase_init_napi(struct rtase_private *tp)
+{
+	u16 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
+			       tp->int_vector[i].poll);
+		netif_napi_set_irq(&tp->int_vector[i].napi,
+				   tp->int_vector[i].irq);
+	}
+}
+
 static void rtase_reset_interrupt(struct pci_dev *pdev,
 				  const struct rtase_private *tp)
 {
@@ -1956,9 +1968,6 @@ static void rtase_init_int_vector(struct rtase_private *tp)
 	memset(tp->int_vector[0].name, 0x0, sizeof(tp->int_vector[0].name));
 	INIT_LIST_HEAD(&tp->int_vector[0].ring_list);
 
-	netif_napi_add(tp->dev, &tp->int_vector[0].napi,
-		       tp->int_vector[0].poll);
-
 	/* interrupt vector 1 ~ 3 */
 	for (i = 1; i < tp->int_nums; i++) {
 		tp->int_vector[i].tp = tp;
@@ -1972,9 +1981,6 @@ static void rtase_init_int_vector(struct rtase_private *tp)
 		memset(tp->int_vector[i].name, 0x0,
 		       sizeof(tp->int_vector[0].name));
 		INIT_LIST_HEAD(&tp->int_vector[i].ring_list);
-
-		netif_napi_add(tp->dev, &tp->int_vector[i].napi,
-			       tp->int_vector[i].poll);
 	}
 }
 
@@ -2206,6 +2212,8 @@ static int rtase_init_one(struct pci_dev *pdev,
 		goto err_out_del_napi;
 	}
 
+	rtase_init_napi(tp);
+
 	rtase_init_netdev_ops(dev);
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
-- 
2.34.1


