Return-Path: <netdev+bounces-182993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167FA8A832
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A4E3B58BA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA09A24EF70;
	Tue, 15 Apr 2025 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXfLRzU1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D424124EF6C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745908; cv=none; b=kb+YWuhIuHUydHKpKGcfq4BewhIu0/dtgAfnJWaSJDgbBmApuYh0hJNS/UpiJEIOuKMr0kZ9YgnaVaBeKiCbocrnu6+HaxB8LCyiv6koIQeW8KYHD3KHm3+9hNk25yNIKDQUUp4z9jUAYXNpcjx3tfGdV603kasraU6vx9Zp7S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745908; c=relaxed/simple;
	bh=i00dBLim3CRyPwOtlKNa1OXs4byK+SMvS0WBf3v4oE8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fILpxr7iUdf+OUseoMCSP2AnbbJGwzUreOceVEJMnflNGeUzIKMggXp4KHWfNqdTlZdse92D1PeYaRcWahazMF2bTPbASe62FXc/3aEMlex+G6Iet2CHfuul2N18ry7ZKKtB/pyl/24sSFnB0eSFIKOp3icxaQUbjHOJ6LnPsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXfLRzU1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso2047a12.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744745905; x=1745350705; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AZ0PzzqQC20d74EEYf6yHPBLQOFCdny3+7rbXHU1h10=;
        b=HXfLRzU1FefxFBX49bosfDTQYLgDPG8lx+asKcjnieDMdjnbwhuABeo/kLD6flwQDW
         DAW4ZG63tNKeQi3fmNCViGhiV00ZVdRqSoHwa/m8TBi2BG0Ycc52V+K0v6DqVTCraYUc
         diQkykkM1h14wI/cbNM7gX7o5Y6L+h+0LLKP3ILyqURlZSOOCx+Y0B4yJv3DtmUcm6a2
         H8SBbCrzpBNU4m4Xml0wznuolM+K0kcauwBgv7OEcdln/yW6FVMvyOexh0qJSGdnYz1U
         Vd7uGR5AjfUP/ICHjSIg/uPgmDijTMhSz1LgNk70Jf7szSt4FoMJS9Gx2Z+T+2fz0F3U
         M+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745905; x=1745350705;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZ0PzzqQC20d74EEYf6yHPBLQOFCdny3+7rbXHU1h10=;
        b=fw+nR6LlM8obSe2+42gYF4EPaOvsTkv87hCTXWjkZ7lQRD4OeJrpXL0flOREynYUaO
         BfAYbg9kiGjYxkWrYwGEKZ270fE5tif2Dwx6avl9TOq6YIvaYlbPWYM+dChS8eG4fbpe
         n4nb9/OoOhk0WPuSo3uxF9+5XssnDMbQVnkhTdzGXXLw/KJre8nrLQDSMuhaR3igfueq
         JsPiD4R6yhKNa0X/JIqKQvkMp+06ws+eP1tfHvBPLcneHxCHc3GUmZASkBqmdN456y8a
         40/bLZPFZZx0F/nv5q8SxmO9AbE7Yafrim7XNgCvwzL4lBNUBc9tTlKEtlHCf9xit7Rp
         3KpA==
X-Gm-Message-State: AOJu0YxxUYdZ8cDd/mq+7dVICXm7vFHceWsesZhCBqZqq+LZBop6+ffS
	N9hvcDqBAyvSpra4hqx8pi1Kg+/VKPyvEf9xQ7Ju8J2JFjfqD6Tl
X-Gm-Gg: ASbGnctToWnxROlfFPe5f/jgCSOluoNAfbnPPo2F1s6eYuaZMrDOsUjiDcHsmBT0UhO
	nt+GRcFpQDJDerry2Gr1mXhLHFnFqE0+ZlUf58OpMNzuO7A9v5v7NXaS2qU/3GsA04AqieIpk0x
	uf+c7umTvi6EBBni8FewnZwHey/lmKrvyT5089+67IE7c8MO/LkVOLX4gULbQG9lvomKkAhSF6S
	lssYQDcocl1e9+VxvsYDmrtsl6rQJun0uhPaIoE1hMs+BAi9V9IfKBBnTIz7bopZ775kd/mQp8Z
	Im3ilUBafiQQEzW1OlK//imzGnxMBze1RfpRHStR8VAp63nI1j661C4yOTNuwN8ZzIrnMoE7Y+Y
	rC4ek8eQuadnBs23iVTAT5mx1C4QHe4a8Q3mMa/h/fLpJC5CDsaD9IgbwSmtj0GmXrjYz3y2Quu
	+5ar9Ligoe4hABhlRqKowJyTs6j2eTIq1D
X-Google-Smtp-Source: AGHT+IEtt8LRCp1LJo/dmR8am4X0ThAsSzWfHU4rp/s5NqzZfu/IZcc4c36lnEglAPZJX1D1FVP3MA==
X-Received: by 2002:a05:6402:348e:b0:5e5:854d:4d17 with SMTP id 4fb4d7f45d1cf-5f45e01b30bmr3498953a12.11.1744745904714;
        Tue, 15 Apr 2025 12:38:24 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ef56de1sm7435943a12.21.2025.04.15.12.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:38:24 -0700 (PDT)
Message-ID: <06991f47-2aec-4aa2-8918-2c6e79332303@gmail.com>
Date: Tue, 15 Apr 2025 21:39:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: add RTL_GIGA_MAC_VER_LAST to facilitate
 adding support for new chip versions
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a new mac_version enum value RTL_GIGA_MAC_VER_LAST. Benefit is that
when adding support for a new chip version we have to touch less code,
except something changes fundamentally.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169.h      |  3 ++-
 drivers/net/ethernet/realtek/r8169_main.c | 28 +++++++++++------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index 7a194a8ab..9f784840e 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -73,7 +73,8 @@ enum mac_version {
 	RTL_GIGA_MAC_VER_66,
 	RTL_GIGA_MAC_VER_70,
 	RTL_GIGA_MAC_VER_71,
-	RTL_GIGA_MAC_NONE
+	RTL_GIGA_MAC_NONE,
+	RTL_GIGA_MAC_VER_LAST = RTL_GIGA_MAC_NONE - 1
 };
 
 struct rtl8169_private;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b55a691c5..635785d91 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1289,7 +1289,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
 	case RTL_GIGA_MAC_VER_31:
 		r8168dp_2_mdio_write(tp, location, val);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
 		r8168g_mdio_write(tp, location, val);
 		break;
 	default:
@@ -1304,7 +1304,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
 	case RTL_GIGA_MAC_VER_28:
 	case RTL_GIGA_MAC_VER_31:
 		return r8168dp_2_mdio_read(tp, location);
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
 		return r8168g_mdio_read(tp, location);
 	default:
 		return r8169_mdio_read(tp, location);
@@ -1656,7 +1656,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
 		break;
 	case RTL_GIGA_MAC_VER_34:
 	case RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_LAST:
 		r8169_mod_reg8_cond(tp, Config2, PME_SIGNAL, wolopts);
 		break;
 	default:
@@ -2129,7 +2129,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 		tp->tx_lpi_timer = timer_val;
 		r8168_mac_ocp_write(tp, 0xe048, timer_val);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 		tp->tx_lpi_timer = timer_val;
 		RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
 		break;
@@ -2491,7 +2491,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_LAST:
 		RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
 			RX_PAUSE_SLOT_ON);
 		break;
@@ -2623,7 +2623,7 @@ static void rtl_wait_txrx_fifo_empty(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_61:
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		break;
-	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_LAST:
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond, 100, 42);
 		rtl_loop_wait_high(tp, &rtl_rxtx_empty_cond_2, 100, 42);
@@ -2898,7 +2898,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_set_bits(tp, 0xd4, 0x0c00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
 		break;
 	default:
@@ -2912,7 +2912,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
 		rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
 		r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
 		break;
 	default:
@@ -2950,7 +2950,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
 			/* chip can trigger L1.2 */
@@ -2962,7 +2962,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
-		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
 		default:
@@ -4094,7 +4094,7 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 		RTL_W8(tp, ChipCmd, RTL_R8(tp, ChipCmd) | StopReq);
 		rtl_loop_wait_high(tp, &rtl_txcfg_empty_cond, 100, 666);
 		break;
-	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_LAST:
 		rtl_enable_rxdvgate(tp);
 		fsleep(2000);
 		break;
@@ -4251,7 +4251,7 @@ static unsigned int rtl_quirk_packet_padto(struct rtl8169_private *tp,
 
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_34:
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 		padto = max_t(unsigned int, padto, ETH_ZLEN);
 		break;
 	default:
@@ -5302,7 +5302,7 @@ static void rtl_hw_initialize(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_48:
 		rtl_hw_init_8168g(tp);
 		break;
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 		rtl_hw_init_8125(tp);
 		break;
 	default:
@@ -5327,7 +5327,7 @@ static int rtl_jumbo_max(struct rtl8169_private *tp)
 	case RTL_GIGA_MAC_VER_18 ... RTL_GIGA_MAC_VER_24:
 		return JUMBO_6K;
 	/* RTL8125/8126 */
-	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
+	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 		return JUMBO_16K;
 	default:
 		return JUMBO_9K;
-- 
2.49.0




