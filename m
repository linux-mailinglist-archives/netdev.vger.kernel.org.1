Return-Path: <netdev+bounces-218512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FEAB3CF0E
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C0918902A7
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D372DCF57;
	Sat, 30 Aug 2025 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9SxfQwc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EE1E1E1E;
	Sat, 30 Aug 2025 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582279; cv=none; b=iCnvAULuZWNg5fCR051ABJfEW3AX68lFxqivPVaByK6AyBVwlbkvzfFJjHH4moCQM6nKb741wAYtlJGROrV0+XtTb5GbSFGOJj9qHe5yuLKLevcYoswILWGU9gRxveQZEnKpVY/1U1plUtT1sIxGhBMdSOgusLSZwQwfzzPdQzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582279; c=relaxed/simple;
	bh=+DwoslA7/kfwqHfljxKUTzfBmEeaGG9DKg+W8ghJOwM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=em3caydlqojh/PqImgaOxfn6we6m0TXqyuUSeK8q6fwyQpuzHNaUVcqLxy2dB4s9a8gU2r7pAcJmOWr1crK6odCEvTOgXCEOL4VfI20nSWsdg4IR0k55kXVvZr5Zh807QO9vxBtij8Wd1dWiCFhNnBdBYwS3maR8jMmkUxjOs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9SxfQwc; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b0415e03e25so15456566b.0;
        Sat, 30 Aug 2025 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582276; x=1757187076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WHgH8oy5n+l+ZwlFEabPRf0dx6W3J1c630BijBzFt9g=;
        b=V9SxfQwcACTUM9BDNC0PBQlSTU693ec0+iHaadPECOJtXG6jhME9on+P6YOQtTOdYW
         CvvtwV6qNOwTiANOcSkGv1knvwQDXNKJweixN2sLOVtZAwAhP+n/PZ5PbHbALJy4k9lu
         XCtfIzE5AP8BiRxCCAfbrXFFOlC7ElPJYj8FPN073BexHXItKgteewiqMBf+zMaU363T
         M8FTGImi3c6ExXBkh1VFvnmnaQJHy5S+jgy660xIFo09Wt1LXhW1daZCkVgb/OYcYHDO
         J1tBCpW1JYxCDQxB3Df/0ssttY90QFV1qaSlCVj+bnt44u8i1sweqr2so+KoWxgikXxi
         MkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582276; x=1757187076;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHgH8oy5n+l+ZwlFEabPRf0dx6W3J1c630BijBzFt9g=;
        b=QDrPn8N5rtmrN/MaykVYYHbMVIQxd9FC5xeucrNRM2YoL7AqDVJ0DCwIt+5TehT9qT
         ka8oQTW0M5RRknOsuJxkSPAFoGPYUaL+8FiCBrpG18140OvjYZtGRb7bkGrFWBKsrIfw
         bMV8YtQqOuGQh4rhb4DF1zibFTawTN7YptEKvnKbVyq7kg2s0o8lznuHonC7PJS7rpjR
         SB2jDIoj3MkeqmuF3TevKXo3kyw1BeqJZ3vCSjoqROOE1eQcL7dezDnco6bnzXVyu/gA
         iNRRHaBAtYUI0arraWf9mRwlIozK26bN7mGnIXBnlENq/nTzsOc6CZ7SJOJ/Xna/ARpY
         C1Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUJBK3HgyjtOQSHxOiOr1opgIm8zfTgeHq81ZqLRurOMeRL0iMVt0Avs6ZWBTAMH3W1HjJN2X6V@vger.kernel.org, AJvYcCXxB/xlfXskIM5HulwN74v/3OMg0gGLFm46I+xAXBUvcovxSAuob0OaxBgf6y2iceJ6AO798r/IT47d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw72ESfA3EbC9sTMHsHrxOO6nHMDNLH99hew+PTWh3mKpXQHvbJ
	9bhOz1m2o9JtmQ4S6x0gCA/93tMJMjLyu/c8qFRDbOwjUSWmgB2s3RAtOZakww==
X-Gm-Gg: ASbGnct8Xi5Vio4KqZspsbPFGS+ui8/7u8i7o1sohabznEAOmx09qYofngiL22aQ7+L
	GKZ2DW9sjTC+oJqPCdWn45cwTXvgp5/slKASkHmcGS+qqVLoxRxoni0hSugq+W5wYM2BPL0GUpA
	9YCZs/DI3Uu3axLOkqSFitnB32p+FDBN18i3/xvYrC4VelpTcywpxRwLN9drT9EuopDDiVvXDWJ
	RolXj3iXRwEkLO1I3wqzl1uIxKXW4bVEQ2fpx+D2hcqoemMOFFL6Hje4Gedri7qxn7TOYyj7tzV
	e6P0Qapmfdm8Q/2HlQUDLepX99nJ+jokagQ4BRRbr2Tyt4zyFSkAbh3WjefmQ4fY2QR0nnLV3VE
	4N7HLcFLN3p70NZyOfkcv6KmrFQRsj37G0FxaYgDceuLnmpiUwwxzlR2HhOA+hrvB0YrFJLWHim
	yRn6VsjIp4FIoffGGomjD0ylzlNxRuRHAOTVslGSJE3M4uKeRKIyw8P8Ak
X-Google-Smtp-Source: AGHT+IF4j9iCk4u5SP+oeXkkhHtMTGZdfBYtCfpqO9ohp/v2puGIBv4BvjT1ORfwCEJdUw53vlF8Nw==
X-Received: by 2002:a17:907:7ba0:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b01d8a30045mr263387066b.5.1756582275714;
        Sat, 30 Aug 2025 12:31:15 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afefcc66431sm465153766b.94.2025.08.30.12.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:31:15 -0700 (PDT)
Message-ID: <64284769-ed7f-473f-8e1c-30c217da5c87@gmail.com>
Date: Sat, 30 Aug 2025 21:31:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 3/5] ARM: dts: st: switch to new fixed-link
 binding
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <cd55d7fb-6600-49e5-a772-18b39811b0d2@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cd55d7fb-6600-49e5-a772-18b39811b0d2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. Switch to the new binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm/boot/dts/st/stih418-b2199.dts  | 5 ++++-
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih418-b2199.dts b/arch/arm/boot/dts/st/stih418-b2199.dts
index 53ac6c2b7..5231222b7 100644
--- a/arch/arm/boot/dts/st/stih418-b2199.dts
+++ b/arch/arm/boot/dts/st/stih418-b2199.dts
@@ -103,7 +103,10 @@ ethernet0: dwmac@9630000 {
 			st,tx-retime-src = "clkgen";
 			status = "okay";
 			phy-mode = "rgmii";
-			fixed-link = <0 1 1000 0 0>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
index 8d9a2dfa7..f45c65544 100644
--- a/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/st/stihxxx-b2120.dtsi
@@ -147,7 +147,10 @@ ethernet0: dwmac@9630000 {
 			st,tx-retime-src = "clkgen";
 			status = "okay";
 			phy-mode = "rgmii";
-			fixed-link = <0 1 1000 0 0>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
 		};
 
 		demux@8a20000 {
-- 
2.51.0



