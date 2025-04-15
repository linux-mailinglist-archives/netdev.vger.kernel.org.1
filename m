Return-Path: <netdev+bounces-182971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D6A8A7E9
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345F119018B5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9524C07B;
	Tue, 15 Apr 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5geDbkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B824C069
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745320; cv=none; b=ZVxr5XJOS+XwM4jYxnytIxxiqKcBz0Qp6xH10dPvTbEKkdZ2LrldHd/NuyzbWVz6TQVjdWOx17XbhcfKk5qFzBFiT3OwOHPpx8r007JVq6UAcp/rCkNYpEAe4+YMbcWEINQHp/gJD6bOvutkv1dH79q7Vkbl+GwaMkmuWI8u6rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745320; c=relaxed/simple;
	bh=EMx/nEaEZzwd86G44R8ZcbX52fVE97SOgSp2RJKiWC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=i7pgevIN+WkFEnhR4E86912tXVBj+p5fuulDVxvPTJtyjPFPJ3s5V5zR1MatuIO+tE0xyifY24s5kwx8CqjyCFLiUqAi0Tcl/lsI16PaHbAAC678s64sii/ae7rFR2R6Vub1Z5dqCHDt5q2bGS4aFl2JJPqpD15GDZOH64qNyVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5geDbkQ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so770450266b.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744745316; x=1745350116; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AF+CM7/MR7/r23Vi+3DjUAQvY/OQn6JKzVDtpglX7n8=;
        b=Q5geDbkQ2gUcr41C2ylDnsHu9MPi7Sr0K1FwUcdnbr3o2ZjW2rStocD9gYNbYOIpM4
         XU381vsOkWAXfi+Nk5ZaPfFHe3O3BBcrpav+7/w69m6WaFe2m9Dw9kHzz+jcHXhROcCZ
         T+i6tlaR5bVRVsnu/E6BigbJwD90NXuiXkvZTp7ahJRKtnuOG9Yuf+tnz/aUsA3ONqhB
         evE6e1rPkH1vXg9qLF6mqxFM3gXVfEA9uML34x0I86M7BTSpt3LbX/mQ6z6i6b8xEmso
         P40hlUESBoBerUS5pDCjXgTxP7lYYMZfYVmqfsJNdh2+M+M26jPyTDXCzCBBOMYx5bfa
         vJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745316; x=1745350116;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AF+CM7/MR7/r23Vi+3DjUAQvY/OQn6JKzVDtpglX7n8=;
        b=n3y1DA5HlI83bpFvTY4IVj7iv6yhT4yfPeMVy+fCtNM1FPlc+b4zIjE2pZyLd7e1tE
         sLA2wPsqzGJsoktQD6UhEOyaKvBu66CNB53XQxHJiwolNl4qGuOpWFnZeeSSLnEPAAiV
         UxPV/zwoFsvUNnza43uI12v1AqJsBNHfkp2wgAhdS9cMLL+Hl4TuKLkV+1W/4c/t/MXq
         MUsfoyeJFHkMyoqYlkOHa+55HAGm8d5T4/kU7RWhsHI6hntxUgQcQIzJW52OCSi0wkI1
         VD4Ckof91gKvw7rOuvHp4kTYH60SVpR5+V7HpWj7IglrN+pifbrFF9VFCLi6wpgwqD/M
         0G8Q==
X-Gm-Message-State: AOJu0YwWoUJMk8ygLFcn1bdovlEIc4bjYUk8nz55JdKOLelSUN/xRp4K
	urZ8+4NbY73F8xzVmx4VhGP9UfTqFSH2tL6GL5CmmPqJFr4cFchU
X-Gm-Gg: ASbGnctiwYcg2kvDImNRLYbveKsFWbtnCXekzMMXRiNIihwr/x4Jj0Alsk6neUF1vfK
	/gfdyKEd/Ezz+LwqI4NjDErrTPlQDOkKLt57nalIb23eWYTHoD3BoW7v/WaOAcqcc5MOHrue1sE
	bBQrURrlgJxqRPngo4sjP5qSRYYnbtvocYXfuoOAn3awYbFdgkoOwtRkE+CRBmFmoclJC9bPR4+
	B7MzUlp8irrf/qT3xXfDSNImLZwZvsn3wxZVQjrizLigOnyfubT0FbGWCR1V1Ia3y68nfTw3Chx
	XwsjzXgBEEnga87aSkPijbDO06k/qlYNtMC7hlAQPvlAJqx+L5U1OwoqWX8SkBV4I56R/bwZ8Ks
	6HokEReYjytvqCWE1PdIiuucErzSb27algJ+0PHnihKg4l9PatZHiqF1Pj4pgTchPnQZuJ6XoOm
	C8sDpe4Mx6EvgR8ciWXWwjnVSxIJuaLHhP
X-Google-Smtp-Source: AGHT+IEqm2r5xYC88R91k/oO7bK6jZ+PgeUfrKQuMTSbHZV4GDFI9vrNACqaplfghXRVgAEiqkO/fw==
X-Received: by 2002:a17:906:6a22:b0:aca:9c94:3d66 with SMTP id a640c23a62f3a-acb38311525mr23021366b.32.1744745316021;
        Tue, 15 Apr 2025 12:28:36 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54d84sm7362497a12.8.2025.04.15.12.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:28:35 -0700 (PDT)
Message-ID: <1fea533a-dd5a-4198-a9e2-895e11083947@gmail.com>
Date: Tue, 15 Apr 2025 21:29:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] r8169: refactor chip version detection
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

Refactor chip version detection and merge both configuration tables.
Apart from reducing the code by a third, this paves the way for
merging chip version handling if only difference is the firmware.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 325 +++++++++-------------
 1 file changed, 128 insertions(+), 197 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 8e62b1095..b55a691c5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -91,61 +91,114 @@
 #define JUMBO_9K	(9 * SZ_1K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define JUMBO_16K	(SZ_16K - VLAN_ETH_HLEN - ETH_FCS_LEN)
 
-static const struct {
+static const struct rtl_chip_info {
+	u16 mask;
+	u16 val;
+	enum mac_version mac_version;
 	const char *name;
 	const char *fw_name;
 } rtl_chip_infos[] = {
-	/* PCI devices. */
-	[RTL_GIGA_MAC_VER_02] = {"RTL8169s"				},
-	[RTL_GIGA_MAC_VER_03] = {"RTL8110s"				},
-	[RTL_GIGA_MAC_VER_04] = {"RTL8169sb/8110sb"			},
-	[RTL_GIGA_MAC_VER_05] = {"RTL8169sc/8110sc"			},
-	[RTL_GIGA_MAC_VER_06] = {"RTL8169sc/8110sc"			},
-	/* PCI-E devices. */
-	[RTL_GIGA_MAC_VER_07] = {"RTL8102e"				},
-	[RTL_GIGA_MAC_VER_08] = {"RTL8102e"				},
-	[RTL_GIGA_MAC_VER_09] = {"RTL8102e/RTL8103e"			},
-	[RTL_GIGA_MAC_VER_10] = {"RTL8101e/RTL8100e"			},
-	[RTL_GIGA_MAC_VER_14] = {"RTL8401"				},
-	[RTL_GIGA_MAC_VER_17] = {"RTL8168b/8111b"			},
-	[RTL_GIGA_MAC_VER_18] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_19] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_20] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_21] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_22] = {"RTL8168c/8111c"			},
-	[RTL_GIGA_MAC_VER_23] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_24] = {"RTL8168cp/8111cp"			},
-	[RTL_GIGA_MAC_VER_25] = {"RTL8168d/8111d",	FIRMWARE_8168D_1},
-	[RTL_GIGA_MAC_VER_26] = {"RTL8168d/8111d",	FIRMWARE_8168D_2},
-	[RTL_GIGA_MAC_VER_28] = {"RTL8168dp/8111dp"			},
-	[RTL_GIGA_MAC_VER_29] = {"RTL8105e",		FIRMWARE_8105E_1},
-	[RTL_GIGA_MAC_VER_30] = {"RTL8105e",		FIRMWARE_8105E_1},
-	[RTL_GIGA_MAC_VER_31] = {"RTL8168dp/8111dp"			},
-	[RTL_GIGA_MAC_VER_32] = {"RTL8168e/8111e",	FIRMWARE_8168E_1},
-	[RTL_GIGA_MAC_VER_33] = {"RTL8168e/8111e",	FIRMWARE_8168E_2},
-	[RTL_GIGA_MAC_VER_34] = {"RTL8168evl/8111evl",	FIRMWARE_8168E_3},
-	[RTL_GIGA_MAC_VER_35] = {"RTL8168f/8111f",	FIRMWARE_8168F_1},
-	[RTL_GIGA_MAC_VER_36] = {"RTL8168f/8111f",	FIRMWARE_8168F_2},
-	[RTL_GIGA_MAC_VER_37] = {"RTL8402",		FIRMWARE_8402_1 },
-	[RTL_GIGA_MAC_VER_38] = {"RTL8411",		FIRMWARE_8411_1 },
-	[RTL_GIGA_MAC_VER_39] = {"RTL8106e",		FIRMWARE_8106E_1},
-	[RTL_GIGA_MAC_VER_40] = {"RTL8168g/8111g",	FIRMWARE_8168G_2},
-	[RTL_GIGA_MAC_VER_42] = {"RTL8168gu/8111gu",	FIRMWARE_8168G_3},
-	[RTL_GIGA_MAC_VER_43] = {"RTL8106eus",		FIRMWARE_8106E_2},
-	[RTL_GIGA_MAC_VER_44] = {"RTL8411b",		FIRMWARE_8411_2 },
-	[RTL_GIGA_MAC_VER_46] = {"RTL8168h/8111h",	FIRMWARE_8168H_2},
-	[RTL_GIGA_MAC_VER_48] = {"RTL8107e",		FIRMWARE_8107E_2},
-	[RTL_GIGA_MAC_VER_51] = {"RTL8168ep/8111ep"			},
-	[RTL_GIGA_MAC_VER_52] = {"RTL8168fp/RTL8117",  FIRMWARE_8168FP_3},
-	[RTL_GIGA_MAC_VER_53] = {"RTL8168fp/RTL8117",			},
-	[RTL_GIGA_MAC_VER_61] = {"RTL8125A",		FIRMWARE_8125A_3},
-	/* reserve 62 for CFG_METHOD_4 in the vendor driver */
-	[RTL_GIGA_MAC_VER_63] = {"RTL8125B",		FIRMWARE_8125B_2},
-	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
-	[RTL_GIGA_MAC_VER_65] = {"RTL8125D",		FIRMWARE_8125D_2},
-	[RTL_GIGA_MAC_VER_66] = {"RTL8125BP",		FIRMWARE_8125BP_2},
-	[RTL_GIGA_MAC_VER_70] = {"RTL8126A",		FIRMWARE_8126A_2},
-	[RTL_GIGA_MAC_VER_71] = {"RTL8126A",		FIRMWARE_8126A_3},
+	/* 8126A family. */
+	{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71, "RTL8126A", FIRMWARE_8126A_3 },
+	{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70, "RTL8126A", FIRMWARE_8126A_2 },
+
+	/* 8125BP family. */
+	{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66, "RTL8125BP", FIRMWARE_8125BP_2 },
+
+	/* 8125D family. */
+	{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65, "RTL8125D", FIRMWARE_8125D_2 },
+	{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64, "RTL8125D", FIRMWARE_8125D_1 },
+
+	/* 8125B family. */
+	{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63, "RTL8125B", FIRMWARE_8125B_2 },
+
+	/* 8125A family. */
+	{ 0x7cf, 0x609,	RTL_GIGA_MAC_VER_61, "RTL8125A", FIRMWARE_8125A_3 },
+
+	/* RTL8117 */
+	{ 0x7cf, 0x54b,	RTL_GIGA_MAC_VER_53, "RTL8168fp/RTL8117" },
+	{ 0x7cf, 0x54a,	RTL_GIGA_MAC_VER_52, "RTL8168fp/RTL8117",
+	  FIRMWARE_8168FP_3 },
+
+	/* 8168EP family. */
+	{ 0x7cf, 0x502,	RTL_GIGA_MAC_VER_51, "RTL8168ep/8111ep" },
+
+	/* 8168H family. */
+	{ 0x7cf, 0x541,	RTL_GIGA_MAC_VER_46, "RTL8168h/8111h",
+	  FIRMWARE_8168H_2 },
+	/* Realtek calls it RTL8168M, but it's handled like RTL8168H */
+	{ 0x7cf, 0x6c0,	RTL_GIGA_MAC_VER_46, "RTL8168M", FIRMWARE_8168H_2 },
+
+	/* 8168G family. */
+	{ 0x7cf, 0x5c8,	RTL_GIGA_MAC_VER_44, "RTL8411b", FIRMWARE_8411_2 },
+	{ 0x7cf, 0x509,	RTL_GIGA_MAC_VER_42, "RTL8168gu/8111gu",
+	  FIRMWARE_8168G_3 },
+	{ 0x7cf, 0x4c0,	RTL_GIGA_MAC_VER_40, "RTL8168g/8111g",
+	  FIRMWARE_8168G_2 },
+
+	/* 8168F family. */
+	{ 0x7c8, 0x488,	RTL_GIGA_MAC_VER_38, "RTL8411", FIRMWARE_8411_1 },
+	{ 0x7cf, 0x481,	RTL_GIGA_MAC_VER_36, "RTL8168f/8111f",
+	  FIRMWARE_8168F_2 },
+	{ 0x7cf, 0x480,	RTL_GIGA_MAC_VER_35, "RTL8168f/8111f",
+	  FIRMWARE_8168F_1 },
+
+	/* 8168E family. */
+	{ 0x7c8, 0x2c8,	RTL_GIGA_MAC_VER_34, "RTL8168evl/8111evl",
+	  FIRMWARE_8168E_3 },
+	{ 0x7cf, 0x2c1,	RTL_GIGA_MAC_VER_32, "RTL8168e/8111e",
+	  FIRMWARE_8168E_1 },
+	{ 0x7c8, 0x2c0,	RTL_GIGA_MAC_VER_33, "RTL8168e/8111e",
+	  FIRMWARE_8168E_2 },
+
+	/* 8168D family. */
+	{ 0x7cf, 0x281,	RTL_GIGA_MAC_VER_25, "RTL8168d/8111d",
+	  FIRMWARE_8168D_1 },
+	{ 0x7c8, 0x280,	RTL_GIGA_MAC_VER_26, "RTL8168d/8111d",
+	  FIRMWARE_8168D_2 },
+
+	/* 8168DP family. */
+	{ 0x7cf, 0x28a,	RTL_GIGA_MAC_VER_28, "RTL8168dp/8111dp" },
+	{ 0x7cf, 0x28b,	RTL_GIGA_MAC_VER_31, "RTL8168dp/8111dp" },
+
+	/* 8168C family. */
+	{ 0x7cf, 0x3c9,	RTL_GIGA_MAC_VER_23, "RTL8168cp/8111cp" },
+	{ 0x7cf, 0x3c8,	RTL_GIGA_MAC_VER_18, "RTL8168cp/8111cp" },
+	{ 0x7c8, 0x3c8,	RTL_GIGA_MAC_VER_24, "RTL8168cp/8111cp" },
+	{ 0x7cf, 0x3c0,	RTL_GIGA_MAC_VER_19, "RTL8168c/8111c" },
+	{ 0x7cf, 0x3c2,	RTL_GIGA_MAC_VER_20, "RTL8168c/8111c" },
+	{ 0x7cf, 0x3c3,	RTL_GIGA_MAC_VER_21, "RTL8168c/8111c" },
+	{ 0x7c8, 0x3c0,	RTL_GIGA_MAC_VER_22, "RTL8168c/8111c" },
+
+	/* 8168B family. */
+	{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17, "RTL8168b/8111b" },
+	/* This one is very old and rare, support has been removed.
+	 * { 0x7c8, 0x300, RTL_GIGA_MAC_VER_11, "RTL8168b/8111b" },
+	 */
+
+	/* 8101 family. */
+	{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39, "RTL8106e", FIRMWARE_8106E_1 },
+	{ 0x7c8, 0x440,	RTL_GIGA_MAC_VER_37, "RTL8402", FIRMWARE_8402_1 },
+	{ 0x7cf, 0x409,	RTL_GIGA_MAC_VER_29, "RTL8105e", FIRMWARE_8105E_1 },
+	{ 0x7c8, 0x408,	RTL_GIGA_MAC_VER_30, "RTL8105e", FIRMWARE_8105E_1 },
+	{ 0x7cf, 0x349,	RTL_GIGA_MAC_VER_08, "RTL8102e" },
+	{ 0x7cf, 0x249,	RTL_GIGA_MAC_VER_08, "RTL8102e" },
+	{ 0x7cf, 0x348,	RTL_GIGA_MAC_VER_07, "RTL8102e" },
+	{ 0x7cf, 0x248,	RTL_GIGA_MAC_VER_07, "RTL8102e" },
+	{ 0x7cf, 0x240,	RTL_GIGA_MAC_VER_14, "RTL8401" },
+	{ 0x7c8, 0x348,	RTL_GIGA_MAC_VER_09, "RTL8102e/RTL8103e" },
+	{ 0x7c8, 0x248,	RTL_GIGA_MAC_VER_09, "RTL8102e/RTL8103e" },
+	{ 0x7c8, 0x340,	RTL_GIGA_MAC_VER_10, "RTL8101e/RTL8100e" },
+
+	/* 8110 family. */
+	{ 0xfc8, 0x980,	RTL_GIGA_MAC_VER_06, "RTL8169sc/8110sc" },
+	{ 0xfc8, 0x180,	RTL_GIGA_MAC_VER_05, "RTL8169sc/8110sc" },
+	{ 0xfc8, 0x100,	RTL_GIGA_MAC_VER_04, "RTL8169sb/8110sb" },
+	{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03, "RTL8110s" },
+	{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02, "RTL8169s" },
+
+	/* Catch-all */
+	{ 0x000, 0x000,	RTL_GIGA_MAC_NONE }
 };
 
 static const struct pci_device_id rtl8169_pci_tbl[] = {
@@ -2265,151 +2318,30 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_eth_ctrl_stats	= rtl8169_get_eth_ctrl_stats,
 };
 
-static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
+static const struct rtl_chip_info *rtl8169_get_chip_version(u16 xid, bool gmii)
 {
-	/*
-	 * The driver currently handles the 8168Bf and the 8168Be identically
-	 * but they can be identified more specifically through the test below
-	 * if needed:
-	 *
-	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x500000 ? 8168Bf : 8168Be
-	 *
-	 * Same thing for the 8101Eb and the 8101Ec:
-	 *
-	 * (RTL_R32(tp, TxConfig) & 0x700000) == 0x200000 ? 8101Eb : 8101Ec
-	 */
-	static const struct rtl_mac_info {
-		u16 mask;
-		u16 val;
-		enum mac_version ver;
-	} mac_info[] = {
-		/* 8126A family. */
-		{ 0x7cf, 0x64a,	RTL_GIGA_MAC_VER_71 },
-		{ 0x7cf, 0x649,	RTL_GIGA_MAC_VER_70 },
-
-		/* 8125BP family. */
-		{ 0x7cf, 0x681,	RTL_GIGA_MAC_VER_66 },
-
-		/* 8125D family. */
-		{ 0x7cf, 0x689,	RTL_GIGA_MAC_VER_65 },
-		{ 0x7cf, 0x688,	RTL_GIGA_MAC_VER_64 },
-
-		/* 8125B family. */
-		{ 0x7cf, 0x641,	RTL_GIGA_MAC_VER_63 },
-
-		/* 8125A family. */
-		{ 0x7cf, 0x609,	RTL_GIGA_MAC_VER_61 },
-		/* It seems only XID 609 made it to the mass market.
-		 * { 0x7cf, 0x608,	RTL_GIGA_MAC_VER_60 },
-		 * { 0x7c8, 0x608,	RTL_GIGA_MAC_VER_61 },
-		 */
-
-		/* RTL8117 */
-		{ 0x7cf, 0x54b,	RTL_GIGA_MAC_VER_53 },
-		{ 0x7cf, 0x54a,	RTL_GIGA_MAC_VER_52 },
-
-		/* 8168EP family. */
-		{ 0x7cf, 0x502,	RTL_GIGA_MAC_VER_51 },
-		/* It seems this chip version never made it to
-		 * the wild. Let's disable detection.
-		 * { 0x7cf, 0x501,      RTL_GIGA_MAC_VER_50 },
-		 * { 0x7cf, 0x500,      RTL_GIGA_MAC_VER_49 },
-		 */
-
-		/* 8168H family. */
-		{ 0x7cf, 0x541,	RTL_GIGA_MAC_VER_46 },
-		/* It seems this chip version never made it to
-		 * the wild. Let's disable detection.
-		 * { 0x7cf, 0x540,	RTL_GIGA_MAC_VER_45 },
-		 */
-		/* Realtek calls it RTL8168M, but it's handled like RTL8168H */
-		{ 0x7cf, 0x6c0,	RTL_GIGA_MAC_VER_46 },
-
-		/* 8168G family. */
-		{ 0x7cf, 0x5c8,	RTL_GIGA_MAC_VER_44 },
-		{ 0x7cf, 0x509,	RTL_GIGA_MAC_VER_42 },
-		/* It seems this chip version never made it to
-		 * the wild. Let's disable detection.
-		 * { 0x7cf, 0x4c1,	RTL_GIGA_MAC_VER_41 },
-		 */
-		{ 0x7cf, 0x4c0,	RTL_GIGA_MAC_VER_40 },
-
-		/* 8168F family. */
-		{ 0x7c8, 0x488,	RTL_GIGA_MAC_VER_38 },
-		{ 0x7cf, 0x481,	RTL_GIGA_MAC_VER_36 },
-		{ 0x7cf, 0x480,	RTL_GIGA_MAC_VER_35 },
-
-		/* 8168E family. */
-		{ 0x7c8, 0x2c8,	RTL_GIGA_MAC_VER_34 },
-		{ 0x7cf, 0x2c1,	RTL_GIGA_MAC_VER_32 },
-		{ 0x7c8, 0x2c0,	RTL_GIGA_MAC_VER_33 },
-
-		/* 8168D family. */
-		{ 0x7cf, 0x281,	RTL_GIGA_MAC_VER_25 },
-		{ 0x7c8, 0x280,	RTL_GIGA_MAC_VER_26 },
-
-		/* 8168DP family. */
-		/* It seems this early RTL8168dp version never made it to
-		 * the wild. Support has been removed.
-		 * { 0x7cf, 0x288,      RTL_GIGA_MAC_VER_27 },
-		 */
-		{ 0x7cf, 0x28a,	RTL_GIGA_MAC_VER_28 },
-		{ 0x7cf, 0x28b,	RTL_GIGA_MAC_VER_31 },
-
-		/* 8168C family. */
-		{ 0x7cf, 0x3c9,	RTL_GIGA_MAC_VER_23 },
-		{ 0x7cf, 0x3c8,	RTL_GIGA_MAC_VER_18 },
-		{ 0x7c8, 0x3c8,	RTL_GIGA_MAC_VER_24 },
-		{ 0x7cf, 0x3c0,	RTL_GIGA_MAC_VER_19 },
-		{ 0x7cf, 0x3c2,	RTL_GIGA_MAC_VER_20 },
-		{ 0x7cf, 0x3c3,	RTL_GIGA_MAC_VER_21 },
-		{ 0x7c8, 0x3c0,	RTL_GIGA_MAC_VER_22 },
-
-		/* 8168B family. */
-		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		/* This one is very old and rare, support has been removed.
-		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
-		 */
-
-		/* 8101 family. */
-		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
-		{ 0x7c8, 0x440,	RTL_GIGA_MAC_VER_37 },
-		{ 0x7cf, 0x409,	RTL_GIGA_MAC_VER_29 },
-		{ 0x7c8, 0x408,	RTL_GIGA_MAC_VER_30 },
-		{ 0x7cf, 0x349,	RTL_GIGA_MAC_VER_08 },
-		{ 0x7cf, 0x249,	RTL_GIGA_MAC_VER_08 },
-		{ 0x7cf, 0x348,	RTL_GIGA_MAC_VER_07 },
-		{ 0x7cf, 0x248,	RTL_GIGA_MAC_VER_07 },
-		{ 0x7cf, 0x240,	RTL_GIGA_MAC_VER_14 },
-		{ 0x7c8, 0x348,	RTL_GIGA_MAC_VER_09 },
-		{ 0x7c8, 0x248,	RTL_GIGA_MAC_VER_09 },
-		{ 0x7c8, 0x340,	RTL_GIGA_MAC_VER_10 },
-
-		/* 8110 family. */
-		{ 0xfc8, 0x980,	RTL_GIGA_MAC_VER_06 },
-		{ 0xfc8, 0x180,	RTL_GIGA_MAC_VER_05 },
-		{ 0xfc8, 0x100,	RTL_GIGA_MAC_VER_04 },
-		{ 0xfc8, 0x040,	RTL_GIGA_MAC_VER_03 },
-		{ 0xfc8, 0x008,	RTL_GIGA_MAC_VER_02 },
-
-		/* Catch-all */
-		{ 0x000, 0x000,	RTL_GIGA_MAC_NONE   }
+	/* Chips combining a 1Gbps MAC with a 100Mbps PHY */
+	static const struct rtl_chip_info rtl8106eus_info = {
+		.mac_version = RTL_GIGA_MAC_VER_43,
+		.name = "RTL8106eus",
+		.fw_name = FIRMWARE_8106E_2,
+	};
+	static const struct rtl_chip_info rtl8107e_info = {
+		.mac_version = RTL_GIGA_MAC_VER_48,
+		.name = "RTL8107e",
+		.fw_name = FIRMWARE_8107E_2,
 	};
-	const struct rtl_mac_info *p = mac_info;
-	enum mac_version ver;
+	const struct rtl_chip_info *p = rtl_chip_infos;
 
 	while ((xid & p->mask) != p->val)
 		p++;
-	ver = p->ver;
 
-	if (ver != RTL_GIGA_MAC_NONE && !gmii) {
-		if (ver == RTL_GIGA_MAC_VER_42)
-			ver = RTL_GIGA_MAC_VER_43;
-		else if (ver == RTL_GIGA_MAC_VER_46)
-			ver = RTL_GIGA_MAC_VER_48;
-	}
+	if (p->mac_version == RTL_GIGA_MAC_VER_42 && !gmii)
+		return &rtl8106eus_info;
+	if (p->mac_version == RTL_GIGA_MAC_VER_46 && !gmii)
+		return &rtl8107e_info;
 
-	return ver;
+	return p;
 }
 
 static void rtl_release_firmware(struct rtl8169_private *tp)
@@ -5440,9 +5372,9 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
+	const struct rtl_chip_info *chip;
 	struct rtl8169_private *tp;
 	int jumbo_max, region, rc;
-	enum mac_version chipset;
 	struct net_device *dev;
 	u32 txconfig;
 	u16 xid;
@@ -5492,12 +5424,13 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	xid = (txconfig >> 20) & 0xfcf;
 
 	/* Identify chip attached to board */
-	chipset = rtl8169_get_mac_version(xid, tp->supports_gmii);
-	if (chipset == RTL_GIGA_MAC_NONE)
+	chip = rtl8169_get_chip_version(xid, tp->supports_gmii);
+	if (chip->mac_version == RTL_GIGA_MAC_NONE)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "unknown chip XID %03x, contact r8169 maintainers (see MAINTAINERS file)\n",
 				     xid);
-	tp->mac_version = chipset;
+	tp->mac_version = chip->mac_version;
+	tp->fw_name = chip->fw_name;
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
@@ -5602,8 +5535,6 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rtl_set_irq_mask(tp);
 
-	tp->fw_name = rtl_chip_infos[chipset].fw_name;
-
 	tp->counters = dmam_alloc_coherent (&pdev->dev, sizeof(*tp->counters),
 					    &tp->counters_phys_addr,
 					    GFP_KERNEL);
@@ -5628,7 +5559,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	netdev_info(dev, "%s, %pM, XID %03x, IRQ %d\n",
-		    rtl_chip_infos[chipset].name, dev->dev_addr, xid, tp->irq);
+		    chip->name, dev->dev_addr, xid, tp->irq);
 
 	if (jumbo_max)
 		netdev_info(dev, "jumbo features [frames: %d bytes, tx checksumming: %s]\n",
-- 
2.49.0




