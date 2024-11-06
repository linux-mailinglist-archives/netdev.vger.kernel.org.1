Return-Path: <netdev+bounces-142456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E4A9BF3C1
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 17:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4566F1C21A5B
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F227205135;
	Wed,  6 Nov 2024 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KU0Son9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDD201115
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730912195; cv=none; b=PY6MjLeGs03S+CYS3+JOuzZOrlqz3U+aarTXbIQwO1UeRLdUiXQQz9vusD9Xxe/6qqe2+Zwl8yOVsh7nh6JF/bAhfIyDm3rHWTPNwt9oHWpT5qXeu8g+QztR/dzB/A3eDSjZRiY0Ld8SAe/uy+9U2TnShCyuDDACZ1joIMl1oZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730912195; c=relaxed/simple;
	bh=NcyFBrgNEtXfl/TXTedlUKHq9mfOuTbcUmx9SovRdBY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NqORckYwQAH86bL2AAfgqUeM/eMuUsrIuJBjXhLeBuJcp/pDKi94mT6Ac9HZrklOMArhj/s9zBJ84pevUr6erAph3EC5U4Cssh7v4GV60f2kZ29qbGR0IqS4mfvXlO/Td1mD9RipKUPY0raJdjqoRSJeY6VLIJ58Om06NcXTqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KU0Son9f; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb443746b8so45301fa.0
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 08:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730912192; x=1731516992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K27qf8b2fUyTi3Pnd14zvc2AQ7DT/G4xA+zdvUxzZKg=;
        b=KU0Son9fLEhGiAuOLjfslFsFD+nFyhn8G+/TwMxnBkZcXI2VF27tJYOGXfc7FCiTNI
         VoKw6zmwiPZa7yI+rdK/QDDLUStXAc0p4LSJe0iEE42tBzTMW9uk6cQ1ULDo7anx2m7Z
         dajj78RTweYV+IgtbY4P9yY4XV6tY69dTjvrU4srKqG077WnSvZa+3KrODCJrkUoQDj0
         hLn97IOPssHToeTfh03Io/uixYxYXIymi9PZ5IPwASBzCgQuS4Xei+DgINMl/dSQ+0x3
         6DaLEDLNJ72u3Atg5KksUwHAbRauF7VQ07VPTK5Y+FBruTsbs+Q2JOUo8vr0/1/ZCfCF
         S4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730912192; x=1731516992;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K27qf8b2fUyTi3Pnd14zvc2AQ7DT/G4xA+zdvUxzZKg=;
        b=JERzcshCSnqx68ik/O6ZU5qY0xIaSzXqScKxNH6j4PbbQHGVclHdRXVU804ylw8Ujt
         U2qxQ6bIj6shi0FknqSZHV3iRa06bMjU0I3h+W2c7UJAT2GssBSUs9lbALUS7ass8Fms
         aOw/LsldUvtHz9mTnBsM+Dh2DxFnoH+Y/PS2sRWBN7+K4gy86wG2GPrCe3r4KAgKPWzN
         XAg0O//7p95sIXaic3EA+0BxOVRACJnW37LTGuwjvssEPo5DMwfwiASa6zadAlEWS3YS
         zRWmS69207QXDYUijYyfV5RUI8mrrdkhG1jG9zOjKaKM5LMMFyGBev32/4arnA+aXtAu
         o87g==
X-Gm-Message-State: AOJu0YwyGabS6dqZRWndKEqJWfNVKp+iJfIim1YYaIE8SyEHI6VBotcW
	WN1vhCJDQBQ7KR5pfPqIVBpQDbu1355wrMLG2jzVwvGW3TIeFmX5vpe/9w==
X-Google-Smtp-Source: AGHT+IF2Oy5v8xFNiLZaM1vB5VQ2g5UpRFTYQQxffRIxz9F62Rc8iA8CafzMZCgVaqB7r5bnMVNFkg==
X-Received: by 2002:a05:651c:1989:b0:2fb:b8a:7abb with SMTP id 38308e7fff4ca-2fcbdff7529mr216141821fa.21.1730912191390;
        Wed, 06 Nov 2024 08:56:31 -0800 (PST)
Received: from ?IPV6:2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6? (dynamic-2a02-3100-a488-4700-cc12-ac39-a3b8-6ff6.310.pool.telefonica.de. [2a02:3100:a488:4700:cc12:ac39:a3b8:6ff6])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6afe576sm2952469a12.65.2024.11.06.08.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 08:56:30 -0800 (PST)
Message-ID: <e1ccdb85-a4ed-4800-89c2-89770ff06452@gmail.com>
Date: Wed, 6 Nov 2024 17:56:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 2/3] r8169: improve rtl_set_d3_pll_down
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <be734d10-37f7-4830-b7c2-367c0a656c08@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Make use of new helper r8169_mod_reg8_cond() and move from a switch()
to an if() clause. Benefit is that we don't have to touch this piece of
code each time support for a new chip version is added.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 2ff95fde4..43b03176c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1431,19 +1431,11 @@ static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 
 static void rtl_set_d3_pll_down(struct rtl8169_private *tp, bool enable)
 {
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_25 ... RTL_GIGA_MAC_VER_26:
-	case RTL_GIGA_MAC_VER_29 ... RTL_GIGA_MAC_VER_30:
-	case RTL_GIGA_MAC_VER_32 ... RTL_GIGA_MAC_VER_37:
-	case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_66:
-		if (enable)
-			RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) & ~D3_NO_PLL_DOWN);
-		else
-			RTL_W8(tp, PMCH, RTL_R8(tp, PMCH) | D3_NO_PLL_DOWN);
-		break;
-	default:
-		break;
-	}
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_25 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_28 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_31 &&
+	    tp->mac_version != RTL_GIGA_MAC_VER_38)
+		r8169_mod_reg8_cond(tp, PMCH, D3_NO_PLL_DOWN, !enable);
 }
 
 static void rtl_reset_packet_filter(struct rtl8169_private *tp)
-- 
2.47.0



