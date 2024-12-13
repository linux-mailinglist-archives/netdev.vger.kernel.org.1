Return-Path: <netdev+bounces-151886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C229F174E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664B816139D
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F4518FDBE;
	Fri, 13 Dec 2024 20:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kq87gbaa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C842A92
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734120857; cv=none; b=tfZVNmnc9rf4Hp2LhN5MVFu1jsGTSCyDBURXj0K0bpNCPW2qQDHilf8jaSMYo6dn7+CCnqw5m1YlQa9VImH5WrKh1xidlt+Im/gzkQHK7PUI+hV7grKG3xfq2w/TqnjMK2XaY5qnOVksuRTdHQ9oyjOp8SwC8iO1AdbnVWyc5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734120857; c=relaxed/simple;
	bh=ul+Ig+5EMCBFCkC7jtgQlDYMGuzA/ywpDUuLDZk6mqA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TRWfCU/5y/OXAYbFLPke334egQ699ThUwljjIjQdBBaYr69deKb/UWllp2Ilul+Qi+xMJ+8Wx6/IdoyVPYR/RF2Lle7bBuPgldZyQMcR8iD6WdfMwxR7hi744UHV5Xeb1ksU4GFNE0tWlySTpNQeHTaodWpXxn6/JN4m+MQ23Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kq87gbaa; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso4334155a12.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734120854; x=1734725654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GxLhhx1bPHZyy7VCIJxdS8FHBEvN8N4uFCgXQLUtZ0Q=;
        b=kq87gbaa62AHaAA1CsgFDRwP0OAXWMht4AEhPl06zAW+whxv2vIxu5bJKEYeEVUQn4
         SnbVkBh/pnwq4h/Qpk2lqNZce/oT5BFAmVIVA7Qw5C24UZA8M6NUQI9FVdlo6fDB6xVo
         lZGXZy3E5hvbSJN66LSjDBE5CPvCJgmdAtSUvzQOk1EiTwDiapeM+Fq6mWoYXX+LXBhs
         kiV0X5W1bgLfUBBSXPP2jRly2MKv5wS9QO9eEfo6awwad3u/+8kLi/TUmIzGO99876ov
         QeZp0Lo0jVg4ugUxKGeKMyxdEfbOjWnkmjQEtggIYjplYjzxRwIxK1j5GfULSitWWx57
         LG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734120854; x=1734725654;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GxLhhx1bPHZyy7VCIJxdS8FHBEvN8N4uFCgXQLUtZ0Q=;
        b=VWoIYYilYe1ZGI9y5RZl0Z3xWCu15do7QMpz0nE3PpQU1NekTQ6uOm8rZ30PQ0tp8R
         jKqjnFO0yR8Lo+E42PzGskRLRF5+UR5hnvhrqaMJscB/4mC6wSV43TaQqqwS5OO2SdQW
         lddFMHX848KrdoRM0l7j4EiBrx0AYUvXE2EGzuHAPBUyLJgw1U354CzVkrXkfmO7YWfY
         piuJG9aiUKy5izElkfeRlTmSLEzgwUVPd71Pnjn5S99B1ONDopydRCjnZyk9/+1kMqwb
         N2p6QPcOLmx/j6U5+He3n0hpLuSXJwAh3jkoxFWGG8tWt5OoyQxSeW37ApImNwPRl+RY
         VhUQ==
X-Gm-Message-State: AOJu0YyTcewc9C7stm2zRJZEOIDIYsB/A0fw66STR/kP6XasQ2RRtCeO
	WJMNZVI+ISzLMxZfgb+sD0EEC1Z80mVLm4nIROhy07k8AQdSp/pDh7TIMQ==
X-Gm-Gg: ASbGncvrCRLdMj/ou3V1dWkjBWGLCAbJEXvQVTw8rL5NSs9AAyIgVOCddsrddHwdIM+
	q9zOFUFX+kyMoAfqEPlZtWp8TR3GSPtpwaKScYBX7FRkeFaMGntVVQdxAuQXW1KO+yjE4AHd1BZ
	FvoHJVFti5t5uYdCZ7CfixhN2in4hT6RLB7aW/6mwNdv75yCZq3nFiwYOaBvE915Quuh1lNic1G
	/YZ8mhIH/IcPvVQQ295NMvwBctDOGgrrvplqp0MMPfbzQVd8a+ETvlnv9FddtbU/B8ROaWXu+Yh
	vOhbsTR4/fYyoqW2cPJVi2ITpyQAW/0XEii8rZZQLcV4Cyof2DLhF3zxGNRao7txthN2KSi9qu0
	33AbX24WBoel/Hr6tF6cZBIKZlUy9svyr+naDhC0245DAvA==
X-Google-Smtp-Source: AGHT+IFXAfIyk8r84WarUoe21uQeW080AX18O2r/M/+zqnVuC+NDsVyJueufVFuP35jr3gNPDBSN0Q==
X-Received: by 2002:a17:907:3e8d:b0:aa6:c168:8dc8 with SMTP id a640c23a62f3a-aab77e827c9mr450750666b.44.1734116580998;
        Fri, 13 Dec 2024 11:03:00 -0800 (PST)
Received: from ?IPV6:2a02:3100:adc3:fd00:9eb:6163:d514:e25d? (dynamic-2a02-3100-adc3-fd00-09eb-6163-d514-e25d.310.pool.telefonica.de. [2a02:3100:adc3:fd00:9eb:6163:d514:e25d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aab96006514sm4485666b.36.2024.12.13.11.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 11:02:59 -0800 (PST)
Message-ID: <75e5e9ec-d01f-43ac-b0f4-e7456baf18d1@gmail.com>
Date: Fri, 13 Dec 2024 20:02:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/2] r8169: add support for RTL8125D rev.b
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Chun-Hao Lin <hau@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: ChunHao Lin <hau@realtek.com>

Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
based on the one with XID 0x688, but with different firmware file.

Signed-off-by: ChunHao Lin <hau@realtek.com>
[hkallweit1@gmail.com: rebased after adjusted version numbering]
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h            | 1 +
 drivers/net/ethernet/realtek/r8169_main.c       | 6 ++++++
 drivers/net/ethernet/realtek/r8169_phy_config.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 00d74e76c..e0817f2a3 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -69,6 +69,7 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
 	RTL_GIGA_MAC_VER_64,
+	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_71,
 	RTL_GIGA_MAC_NONE
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d153fa559..5724f650f 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -57,6 +57,7 @@
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
 #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
+#define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -140,6 +141,7 @@ static const struct {
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
 	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
+	[RTL_GIGA_MAC_VER_65] = {"RTL8125D",		FIRMWARE_8125D_2},
 	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
@@ -706,6 +708,7 @@ MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8125D_1);
+MODULE_FIRMWARE(FIRMWARE_8125D_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
@@ -2259,6 +2262,7 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
 
 		/* 8125D family. */
+		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65 },
 		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
 
 		/* 8125B family. */
@@ -3837,6 +3841,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
 		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
+		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_70] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_71] = rtl_hw_start_8126a,
 	};
@@ -3855,6 +3860,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
 	case RTL_GIGA_MAC_VER_64:
+	case RTL_GIGA_MAC_VER_65:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index bc498ea78..968c8a218 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1162,6 +1162,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
 		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
+		[RTL_GIGA_MAC_VER_65] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_70] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_71] = rtl8126a_hw_phy_config,
 	};
-- 
2.47.1



