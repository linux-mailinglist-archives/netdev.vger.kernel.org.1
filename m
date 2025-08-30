Return-Path: <netdev+bounces-218510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013C0B3CF0A
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FC7560199
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04672DE1E5;
	Sat, 30 Aug 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA06a0ge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1F2DCF41;
	Sat, 30 Aug 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582183; cv=none; b=BZXn/sZLKISo3iPckXq7NX2hdMhhbNPMBN1kN66TmgSETJyjmout4yTOhZzz45M35niCtOTblUJMn4pAhszPujPbcCrryw/zxRVx8XohivcpGOd9WUistrgN5unokt6vytyT9oLHDlLQBgtFC+gsqQflQj+JwKjy1ObX1Htpki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582183; c=relaxed/simple;
	bh=K0th4fdNOHQOorf+otPOZvX7LS6gLt2Pt8QKob9MTfY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F4yYF1BLNEJJJQo+UHV3q90S1cJc2HZcI4+i3m69zhCmgTZN+gIBldtIb2dQ6YH6MWzueSUcszEGuVbiLQeicW7G6pg0MIuyOc2wBa/w8jFBMIbG5JeoiPO8m2/vAkkjIrQbawbicELM7UExcu0AnBew6RN8tNFEeHhhCfT6y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA06a0ge; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cf8280f02so3003705a12.0;
        Sat, 30 Aug 2025 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582180; x=1757186980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3rLLJhgYHhQvYp9/eSoMbwWQ9QTJU3+YaixBARoYFc4=;
        b=YA06a0gemPwvjLM58l1SR5WXh9I02fUlcKYYyMlgsIs5yxaLFxfwhb2cHTTS+x/c+C
         GCQ/9ulORB/xknkcotnPpoBTfq3IJTWKA54+6REL96yAOx4LlUo/53fZw34uROfdy6nW
         8krSLPETkiHA0VT7YlWix501eo8GLJjhpAPYs/zs0pe8Kk10uqc8+o3cPHNf+DOA3vlD
         a/rDCpJHqHbzwQI1hxKBwPiVLAXl5KnBi4DLwWUzDBUdqWE97tNnnFwk9B4hjMVpCCzy
         vFwH6aVTTwtW8E3FvzyU6Y3xo/UCE1NFqQgB6fUaw3oioInT4T1m3TOiyFUo6bZTb3A7
         vh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582180; x=1757186980;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rLLJhgYHhQvYp9/eSoMbwWQ9QTJU3+YaixBARoYFc4=;
        b=FQCZRoGhamhY0Ib+7Fgne3byyoHtAXMy1UokPjavYFpfhTabXSYJ2RlDMkM3w7gpTy
         uYxRoI/xWQzLhYarrP5VLE6pyFo7UWklt/01SSKYPo6bqlS7RjYIrVnheXQ9Ho6qSb2P
         BV9zHYY82oWAuAzhagD+H9q2wt1wI4CcNbLi3raByPAi/9h4Qn1wU5R4e3y8FHkkt26Q
         ngF1oKCtVGHg5RONRPP+Esg8hVWcK66XVZa/CgBuSFMGvfvE+9RCNR7+n2avEvgPA3lJ
         +pOY4y5b691Dc5WxLoxfTrvbCp1IqsF9ABJ4YB7cWyM377LgXNJ5bBHeboiLno7nJ7q/
         eAHg==
X-Forwarded-Encrypted: i=1; AJvYcCVQpjSSDSsrqgv/2CSfTjiz5LeKLPiaJcA+20BLIvPz5T2Y+DYaA97rCU3v2xaZRDX0WZuAFOkW@vger.kernel.org, AJvYcCXQ8s4CTX7c0gzh1HrgO+SH2H/lIvMXtPoc2tBYSun6V8a6GkuDpBLo9Q/Z0aTbajk97V7hvSDaKfHD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzix6oVB9lTD6XV34QVemJowQepY+31cJsunrcV5PYGlM6jCjG4
	tS0u996K6uUdue6OKJpg2rNUfPOzU773ekWBErAdRepcyVl/7wiFckKV
X-Gm-Gg: ASbGncttoPcPccoBoiEzjgs42fgSU+u6bs3/1nEK4Nf7EwDjvhO4VN2SwofOBDEXp2c
	PWJ0281HHJSLgpF4ddECDlZBczXyMfW5urXMpGrFyiESNiSFhas/Zex7WZVMFxuT9ZxL4jO9YLw
	yagex87hI0vYK6ESMoT8fYusy2sCON0D/aZ1SjLdu1+Rxi80PSB8gbiS5VCitl3oQAt5JlrTnBp
	rKJ5wDLeres1bv9wNprSeBgUFsQV+QghGzJ6lZ4fh3yKjXtgsCukjYWtR8v6ps5YFUkY229sQDJ
	knmcBx2sBcOQ5GeBxI3nwHrT5vTaOw/BSvzB8IwGL5wib67uwaDu6MMtG1i/W/4vqYGYX9rmKj+
	BI4ZqiHtVqCZD/vQdPJntIZtgNaxvVSNRFS8KzUhrfJmCGgfTw/GfqRRrnfoNmLjt4Y1iRB/MJG
	RTLoEr8YAElo3KUoNuDHb/EMgigPSnbU6yITWS+BFyowberidp+ZitQUMKoNaLz5sCJ5s=
X-Google-Smtp-Source: AGHT+IHgTaCK0S/XYssZtoOOtOK1Z6TGrDrOyTFbgg7Y/LQnnD+HImLfy3f8OoJe0VxTa+zTeAf8jA==
X-Received: by 2002:a05:6402:84e:b0:61a:9385:c78b with SMTP id 4fb4d7f45d1cf-61d26ecf561mr2268262a12.38.1756582180303;
        Sat, 30 Aug 2025 12:29:40 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc4bbca5sm3994735a12.31.2025.08.30.12.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:29:39 -0700 (PDT)
Message-ID: <2211c0aa-c343-4930-9f7d-5d8058017d7c@gmail.com>
Date: Sat, 30 Aug 2025 21:29:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 1/5] arm64: dts: ls1043a-qds: switch to new
 fixed-link binding
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
v2:
- fix "Properties must precede subnodes" error
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index e850551b1..645588911 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -205,8 +205,11 @@ ethernet@ea000 {
 	};
 
 	ethernet@f0000 { /* DTSEC9/10GEC1 */
-		fixed-link = <1 1 10000 0 0>;
 		phy-connection-type = "xgmii";
+		fixed-link {
+			speed = <10000>;
+			full-duplex;
+		};
 	};
 };
 
-- 
2.51.0



