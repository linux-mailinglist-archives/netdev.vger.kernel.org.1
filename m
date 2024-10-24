Return-Path: <netdev+bounces-138864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E19AF3E9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F9D1C226A8
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 20:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B986E2185AB;
	Thu, 24 Oct 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsu8cNGV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9A217325
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 20:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802560; cv=none; b=eNGutgZPHkfu9UY30m623sqo9S6h2uaVsjSB6YwTueZ2CHNm/eJvRw5aWKMNACGLzgHL50tXDpEL+sLQL5bQwZFyR90gCu+XFxB9naKDOTTdJGbbA8VNHDeuBxvRtnbPqJhHbgdqTnbLzikXXcu1LwRVVPakseEVuSYeNgynD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802560; c=relaxed/simple;
	bh=pdD1GDQPxzwiHaCjULJcg+1TSnHPEH1Nruwn9rEZTvY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=JRPMWKM8bpZNKdYhJlIQV3YDthouOwy3cihDBE26wESu7P6aqDLC+LN06UyYjje4t1iz2s6tJnjhUoGbrv5doa2QUdVUlVPoiee6qAn7GabjRngV2gR+A1ndoLXvP7oFWHEIQQrGKW0tbvlT2rS3RJcEmE+rvYnSMLgvjl67gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsu8cNGV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c99be0a4bbso1728644a12.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729802556; x=1730407356; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7rfsgrM0X11yymfXh7QpKdCTliNxUIyv9mqWlZIciQ=;
        b=lsu8cNGVirH647I51qYabkffeq7igRYYrVvTIPd7Euuf6eVwQabcBoNPCrVU4ic1e4
         fLWvF7ZYcTpoUWGz5MkmU297SzMrRV1M8hcKmgI8+yHgxdVg0LT51eOn72GC8dbOwf+z
         f1PybhR/rne3ec6XEn2nxa2TNHuAyIFJUWfxyu2PoVjkMloQeGa6Wsq7Q7y0N3raUFqW
         LXQshzWrgSzkbffRjR8J9lA8VUkCZgIi02VkPZp7W6IM9mvjgJYzg9TgrnrTrxQ+ZFkh
         TDGexkptKW1lOxgIQ25mkeQa8D2mIrq3c9JeCOjbHaf97MZ1gIiKdlZX3A5xVvf1o+YB
         jUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802556; x=1730407356;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7rfsgrM0X11yymfXh7QpKdCTliNxUIyv9mqWlZIciQ=;
        b=rvIM7wXRg1ioKrrKomZGe/cuJFO1YkKlIRvLRjAay3Ig10InwYPphQnNXgZyauok6z
         gJtjnAQNlpEB8MFYdWZBiExpuLZIwVW1stW9wM8jRYOwUncgBwjR917/IdvyiVR/tA0O
         DK8dXR66ec8xjoqmcX5Cx4bUOvxe3tvTAoAioRiQ9S0Bp5K7ZFhZaScqxAbuUpvfNsot
         g0czSZAFixegQdXWRa2tBx9hZDZzGa18s81RLeABTzee/WJ50VBP5YULI/s9qs6zPZ2m
         twIdMMMha19i6mNAtLB8UfGFZ3XaHWoz0h4lE0cAvpGs2SWhju5PWUPWVBc0qXilAv5l
         yacw==
X-Gm-Message-State: AOJu0Yz6JF57CHrjmUrLkc7/T0XVF+rwUVY97ILdkWBxsSROgBtvMwGr
	rTPrxf28AzKx2m9OP2sXMGNrKolTqeW9kEFtr+F6CxfGZ+zKmG+N
X-Google-Smtp-Source: AGHT+IG/4QemWmyDS4NLUjmaOMaFUhXK9st5oJOo9W/5cLuJdfp+21gq3PykxTv3kpMcI96SpuhCsg==
X-Received: by 2002:a05:6402:d0a:b0:5c9:6fc1:6177 with SMTP id 4fb4d7f45d1cf-5cb8ac84615mr5078860a12.11.1729802555885;
        Thu, 24 Oct 2024 13:42:35 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c7c:7300:4169:9367:99a0:d46c? (dynamic-2a02-3100-9c7c-7300-4169-9367-99a0-d46c.310.pool.telefonica.de. [2a02:3100:9c7c:7300:4169:9367:99a0:d46c])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725dfsm6053560a12.81.2024.10.24.13.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 13:42:34 -0700 (PDT)
Message-ID: <d0306912-e88e-4c25-8b5d-545ae8834c0c@gmail.com>
Date: Thu, 24 Oct 2024 22:42:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add support for RTL8125D
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This adds support for new chip version RTL8125D, which can be found on
boards like Gigabyte X870E AORUS ELITE WIFI7. Firmware rtl8125d-1.fw
for this chip version is available in linux-firmware already.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h          |  1 +
 drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
 .../net/ethernet/realtek/r8169_phy_config.c   | 10 ++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index e2db944e6..be4c96226 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -68,6 +68,7 @@ enum mac_version {
 	/* support for RTL_GIGA_MAC_VER_60 has been removed */
 	RTL_GIGA_MAC_VER_61,
 	RTL_GIGA_MAC_VER_63,
+	RTL_GIGA_MAC_VER_64,
 	RTL_GIGA_MAC_VER_65,
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_NONE
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 79e7b223b..3da0f6be7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -56,6 +56,7 @@
 #define FIRMWARE_8107E_2	"rtl_nic/rtl8107e-2.fw"
 #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
 #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
+#define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
 #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
 #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
 
@@ -139,6 +140,7 @@ static const struct {
 	[RTL_GIGA_MAC_VER_61] = {"RTL8125A",		FIRMWARE_8125A_3},
 	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
 	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
+	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
 	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
 	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
 };
@@ -707,6 +709,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
 MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
+MODULE_FIRMWARE(FIRMWARE_8125D_1);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
@@ -2079,10 +2082,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61:
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2293,6 +2293,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_66 },
 		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_65 },
 
+		/* 8125D family. */
+		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
+
 		/* 8125B family. */
 		{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63 },
 
@@ -2558,9 +2561,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63:
-	case RTL_GIGA_MAC_VER_65:
-	case RTL_GIGA_MAC_VER_66:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -3872,6 +3873,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
 	rtl_hw_start_8125_common(tp);
 }
 
+static void rtl_hw_start_8125d(struct rtl8169_private *tp)
+{
+	rtl_set_def_aspm_entry_latency(tp);
+	rtl_hw_start_8125_common(tp);
+}
+
 static void rtl_hw_start_8126a(struct rtl8169_private *tp)
 {
 	rtl_set_def_aspm_entry_latency(tp);
@@ -3920,6 +3927,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
 		[RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
 		[RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
 		[RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
+		[RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
 		[RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
 		[RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
 	};
@@ -3937,6 +3945,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
 	/* disable interrupt coalescing */
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_61:
+	case RTL_GIGA_MAC_VER_64:
 		for (i = 0xa00; i < 0xb00; i += 4)
 			RTL_W32(tp, i, 0);
 		break;
diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index d504abba7..8739f4b42 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1103,6 +1103,15 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	rtl8125b_config_eee_phy(phydev);
 }
 
+static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
+				   struct phy_device *phydev)
+{
+	r8169_apply_firmware(tp);
+	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
+	rtl8125b_config_eee_phy(phydev);
+}
+
 static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
 				   struct phy_device *phydev)
 {
@@ -1159,6 +1168,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
 		[RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
 		[RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
 		[RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
+		[RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
 		[RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
 		[RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
 	};
-- 
2.47.0


