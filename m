Return-Path: <netdev+bounces-184098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC9DA9352F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3066D8A258B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48626FA54;
	Fri, 18 Apr 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzSLJYid"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7DA26982E
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968165; cv=none; b=UCT5NhfFxrB2mLUbiakAhjaeSr94V/OVnM88r4+T6GrLfnyIAmlo9u2E2dCtv2JSg6OjaSOXr58JI1v2GmdViAM5SODnKOZHcT2/YgOZuE5tYqKDG1ElGbE/UgW3a/R7YgofsLanhNWRQmDrrme2XemQZ0Z7kC7mcbyduVa2rCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968165; c=relaxed/simple;
	bh=aXBwUihk0Lfsl5JupYt3mt6Eg3oWr3vRnDY0t4N/3Qo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sQnsNUx7Xx/0cmp1ZErFo4XgaE0YzeakW2UaBsu3tZUCN5COYDptQ6FS8xDHqIJP0E/8R7J2dA4ADr6bq1DAs2kEvEnPKMwOaPALJhqDAom3vBkewkJMzb7euDi5gKaCOZZ1lbsvJgX1n9Z977rnyFWhUCVqu1C2CNupBA6ZHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzSLJYid; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ee623fe64so1449174f8f.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744968162; x=1745572962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oSHhgKEHLxIQyJL/nYLLu4i3nfOUvvZ/oNSr+PF+UTk=;
        b=GzSLJYid14Meg8uPCYob1i17WSDW+W/IZWCkihPBA5kCqtk7Kx/him92CtX7uI/scK
         CVvLx7aFrCR9sESYciLtKuGreB8GdaFoNFfvPufU0Dv1wEFfanHUwJMcVsmSW2Hnx1us
         GB8q+ZocJv9MMVTnEepJ+zHDxIdJe8XjCPk47tCuFY43qPjT/TkKh2ia797EEwGyqtUh
         jds0ZIBbGWEjMskkd8b6xXUlyaVtRtv4BkJTUBpPDU5zMlx2mWRUid8X1uunZQmUDYIQ
         eNi/CkpAOGyzwpeHVatEtoIwZpqMAWFxXY9qKoeyrh8+eUVHxu0vJlQz+yvFGa0jiprY
         1MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744968162; x=1745572962;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSHhgKEHLxIQyJL/nYLLu4i3nfOUvvZ/oNSr+PF+UTk=;
        b=PLQQ7D6WBNQE3pG+v7rgP2WHv/mnuKLqZB1Qjs4T+04EBRDf+uUmVdDOxMp/IWHAP5
         9+/2xIYiUZXSLB5vDzc6XajmaGxyJVQRBax6pUd+QnLFP9XYafkYnDL/nfIESxHS7Uxt
         y7NgmyfCBYSmgnX/yuPUHjnQo5qhi8CiE4iqjDc39uyVkzJ07XmpFE+BA6jtn6LHdkvG
         zTfLd6cXbY+KSexbueaNjFzIqF519PCKdsMJz7OICQe3mGssl50PNvPee7xeJUIM2Ket
         Re5v5V2KZW4TY4H2Ey79ga4NlpOIhMM3Z2JsFzmzDCR3d5d/ssgRpNyznxTPClA6FCB4
         8MIg==
X-Gm-Message-State: AOJu0YyVWzG6/FWxG1qJfkVMft8xNP6GnBtXJgaCtKUoEHby+QrafQN4
	eY8QRQc21lGTVdVFbNeUC0BM9zmVoXkWwkRB3lGTuEgbNNquzEtU
X-Gm-Gg: ASbGncuLb7HsjcBnhFi5pv7IvuUkvgeNAPCaDhCDA/LUCIQHKKH3Dpg5FV/8cNrhat0
	GE9LaAWUBfKieEgyJlnsZRKdWIgxYTnt5FTVwrvrrJDuoVA7sSoOgwvPt84bxNIfHynOXt11Isu
	ux8rCOXFStHsXdAGHIzGUq42meMksbZvE0dnNLAr0g4XBYKcWs4x2+s1v9gzDs70UmrXm+1PK2Z
	ZCUDxJL4TdYKcnwYn/JP5MmKzP6aDKl1MI2U2u7/VF5Xm3G+HH4/8AZulAbiF/Efh1OJriGLcEV
	/vJI+MJrEl3CUbDuSlfUSjX0xH4FfXsgjP7BmbEHJ73AUDziOi+bwRRmIe+o5gJU3wJySYVdVns
	/6GtsPyk2o0Qr3Dn+Hwwwuasbd6K7kvJ/1Md5b9DxnZRjC77A1ufMl31CHnwku0LRtERcnKJqxu
	07DDyJx/AazpHysY+x72bPKlnpuHPkVvFq
X-Google-Smtp-Source: AGHT+IG0VudBRwXQUjEeOyaYLSHIUqGBoQviHEO8G0sH6m384hLlJ0dvMIeBiOB9taCdGe3UFE4cuw==
X-Received: by 2002:a5d:5f4d:0:b0:390:ff25:79c8 with SMTP id ffacd0b85a97d-39efba3c7edmr1563955f8f.20.1744968161548;
        Fri, 18 Apr 2025 02:22:41 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8? (dynamic-2a02-3100-a14c-6800-64c1-f857-3ca4-c5c8.310.pool.telefonica.de. [2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa4332b2sm2234051f8f.30.2025.04.18.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:22:41 -0700 (PDT)
Message-ID: <97d7ae79-d021-4b6b-b424-89e5e305b029@gmail.com>
Date: Fri, 18 Apr 2025 11:23:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/3] r8169: merge chip versions 70 and 71 (RTL8126A)
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5e1e14ea-d60f-4608-88eb-3104b6bbace8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Handling of both chip versions is the same, only difference is
the firmware. So we can merge handling of both chip versions.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h            |  1 -
 drivers/net/ethernet/realtek/r8169_main.c       | 15 ++++-----------
 drivers/net/ethernet/realtek/r8169_phy_config.c |  1 -
 3 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 9f784840e..3f7182dc8 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -72,7 +72,6 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
-	RTL_GIGA_MAC_VER_71,
 	RTL_GIGA_MAC_NONE,
 	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
 };
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ba4610022..58d3acf2b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -99,7 +99,7 @@ static const struct rtl_chip_info {
 	const char *fw_name;
 } rtl_chip_infos[] = {
 	/* 8126A family. */
-	{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71, "RTL8126A", FIRMWARE_8126A_3 },
+	{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_3 },
 	{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_2 },
 
 	/* 8125BP family. */
@@ -2940,7 +2940,6 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_mod_config5(tp, 0, ASPM_en);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
-		case RTL_GIGA_MAC_VER_71:
 			val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -2972,7 +2971,6 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_70:
-		case RTL_GIGA_MAC_VER_71:
 			val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
 			RTL_W8(tp, INT_CFG0_8125, val8);
 			break;
@@ -3692,12 +3690,10 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	/* disable new tx descriptor format */
 	r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_71)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_71)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
@@ -3715,8 +3711,7 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
 	r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
 	r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
-	if (tp->mac_version == RTL_GIGA_MAC_VER_70 ||
-	    tp->mac_version == RTL_GIGA_MAC_VER_71)
+	if (tp->mac_version == RTL_GIGA_MAC_VER_70)
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
 	else
 		r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
@@ -3839,7 +3834,6 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
-		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
 	};
 
 	if (hw_configs[tp->mac_version])
@@ -3863,7 +3857,6 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 		break;
 	case RTL_GIGA_MAC_VER_63:
 	case RTL_GIGA_MAC_VER_70:
-	case RTL_GIGA_MAC_VER_71:
 		for (i = 0xa00; i < 0xa80; i += 4)
 			RTL_W32(tp, i, 0);
 		RTL_W16(tp, INT_CFG1_8125, 0x0000);
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 748ca8b21..7f513086b 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1183,7 +1183,6 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8125bp_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
-		[RTL_GIGA_MAC_VER_71] = rtl8126a_hw_phy_config,
 	};
 
 	if (phy_configs[ver])
-- 
2.49.0



