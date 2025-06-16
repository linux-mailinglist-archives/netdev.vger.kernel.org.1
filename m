Return-Path: <netdev+bounces-197939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BEEADA6C3
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DAE16C1AA
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DB28E59E;
	Mon, 16 Jun 2025 03:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Vd3NfXTE"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FEF1FE444;
	Mon, 16 Jun 2025 03:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044215; cv=none; b=TytH3/EdUkNxAjkMgpWKxsmTUQ/O1OwE2gcnQj1JFmjq4qIMPEKuLPcqG5CUHkQ4TDLEjjviUIE59wUh2CwhuvPlTRebAp6j+gV+Xa1cF7/IxJEeH66h4FvYf0LTcpDNm0G7pntszDF96iW26QZWNcCy5LhLFYlXxMr8C0kNp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044215; c=relaxed/simple;
	bh=zuRubDgdhyaVBelPbTWu7FxxjsOP/AlwqUEazFgTPOk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKpHuds5kT3FH9lXW5lg4153M6DVSu/T7MBkNXg7M7Drz2aZmBCT9Svv/vmy0mxC/Oe/At67d649MBhwNEde4Uxw7ddJdaQC7Ti4MtVwmW/cgZfcorIAofT6R5SlL6B0FGtHsCb85WcW13CIPVCcYql2PAph4RPy/XAeem5ua1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Vd3NfXTE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3NA1e83976478, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750044190; bh=WFooEOKAUiQJqcx+ihqU0ZIMimYXeAicAjCdvwMxz5I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Vd3NfXTEi+X8xQl6RjE7+U/2RzGAgymVzksB/9LD42ZggOYH2zs1pDlWkD79Lrozk
	 MSLV2VIWV2xHuSGNk0TJ1sSzgwBEQLpycs65ZONvsqcOFadJwkPTA1JYtx4mMf6uca
	 vXSk/J1x+i6qvf7OoKBtdzXo+ZCLEeHb5I/vr+5jVQu7837w/gSBIMa7OPf9iqo823
	 gPp6ClpoAi9AQN/PFIHU71/VP6BpLkZ4/RKl7rs9MuJw3pT6NULkZFD+5YMh5b/Lf5
	 sKMImWq6t/kqVuJux0yTlCbJ3AwTK53vvrTkiwe4qJ5RWh85S5PBYpSSZR+HdutdLz
	 5vWDML8A/tXTQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3NA1e83976478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:23:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:23:02 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:23:01 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v2 1/2] rtase: Link IRQs to NAPI instances
Date: Mon, 16 Jun 2025 11:22:25 +0800
Message-ID: <20250616032226.7318-2-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616032226.7318-1-justinlai0215@realtek.com>
References: <20250616032226.7318-1-justinlai0215@realtek.com>
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

Also add support for persistent NAPI configuration using
netif_napi_add_config().

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 4d37217e9a14..d13877f051e7 100644
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
+		netif_napi_add_config(tp->dev, &tp->int_vector[i].napi,
+				      tp->int_vector[i].poll, i);
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


