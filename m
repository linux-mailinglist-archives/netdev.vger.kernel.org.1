Return-Path: <netdev+bounces-218511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD5B3CF0D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161DA18925D5
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6A2D7DF9;
	Sat, 30 Aug 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heUxTm9e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3231E1E1E;
	Sat, 30 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582230; cv=none; b=Gf5dWEwt2hSnD0d2zbSvBNUJBQpU3Ix7J/SvNwvEFPvJEtH+yxwqGWDgcANQ/A1mg7+iq3LMFB1CpHDkFvIx9tAcMXVb/sUjTJAR+dzUPNUuqZWwmjCQZ6X557IUmRgrUCLAmTxJ7IZVn+rlUlAVqw9TeeBIIyg0XRhia0N+K+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582230; c=relaxed/simple;
	bh=yZS/7FNYBusl0RfgqjvH/uckKXPtHpypeI5A3LoJcpQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hvieu4Bz7ydvgmuXNmdol5b8F2kiBwihp+JaGqpT+RkdboyljEa0Ihm04SGqizv2IY/a6K0DnvsFUu2mHIPjFlSqr2yMLMKjnCivruuTi48ghyBU0NK1XlqwpTldEtUbPXbqrLrMgvi2Q7M0Lib5fAL4igizIkvKP9/WUH58lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heUxTm9e; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afeee20b7c0so413131966b.3;
        Sat, 30 Aug 2025 12:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582226; x=1757187026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CondtgD1DjFQjVasjxVpy8iDXhUbFuUoV39CG55v1Bs=;
        b=heUxTm9ePAOoeFlpr9kUS043+fs1kjCaLkjeu3iMLHx4JaOyD0Z2gUeDdeUbgtTkvC
         P2IBHUay+ExW4IIPzWKMDIlr6lzyQSmM8LYWae+LFcSCsRNL8Lms5fdp/Xnw47zOxygl
         7C9R7WJf6dEa/5O//C2aesaCAQmj3xY3K1bZOEKaN/ydANf2yAmqixwFR3bRJOgJ9Lek
         u1R4bQ3G1GqPPXwFIY3sB3SxfKUVQyGgXvu8zFrw/ZRCmBOzct6XkQ9B7Tscgf3qXr4h
         0sMSlcazKIXJS5gwsc/YKxd1tlRbhTotwrgwZUc7YbBO5g8y87zcDRRPqGYAcOp1UAht
         00WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582226; x=1757187026;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CondtgD1DjFQjVasjxVpy8iDXhUbFuUoV39CG55v1Bs=;
        b=o2K0/Dlbeivm9bgSZKcaeFSWa/3pOSgkIvE6DQfFnJieBxQu7OsWiAeJdOt2bj8inP
         dmV7P3MbPz/cMnHy2jYaJjVAjB7i9eQGjAwXPjIaZKpKbEfOKYOaBO274vm3Fz4TWiTZ
         IdVTi/byy5TH8Q3QHzPiipUXTm7e+zZc6+J2nGfPxJOiAEWKF4wcODpgOrlymCIHPjr1
         kCnNs5ygjnzovMo/0QE8C0BOk5FsPpFhQIu1CX6+LDdxivH+ToZumBErXypGFNkVBiUq
         MJDRZzxUWYnNntFeWKF9COGwwN16zLldG5ewIe9njaCwkCvvOQqJYJCCPaMoC2mXdPGV
         H9dw==
X-Forwarded-Encrypted: i=1; AJvYcCWNDWWLUmfrSC1PHtwugSLAqBUH3Z1z8prHWuNfL2eZWvXD+0mTFhLVxQz5i10rg9tL1svV2wtMzjlg@vger.kernel.org, AJvYcCXu9S7BoDAkKio4M+iDaVQC+ei7coyWaqCjYmFiABqGRw8+L/dwFnNn5Do/l1p5Vgi5uetdQ4eg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbiu4/zMzlBc337Y9u7QOUK2KfunprAmT6Q7NmO2pyFHZn/kFR
	vA4cjYjvS808pvPgzUIkHlMTHTW84SPUNlHCAxZJtoBQH9FW32k7AKAO
X-Gm-Gg: ASbGnctTw5mRmvbupxkgrb3VpllHR/NHfY6RHB3TYsblS6XkwP5YqS1OKwSd30Z4tuZ
	qpv8iYLcERivBnaa5XvPHn1JJQOVwe/FICVqlEvUQwWj+PbOlCRsGLjoZiHP6iOkfWtez2uBdzB
	CBXrwCuJfsgK9uLxqaFZ1kFxXI9RJrMokIYJdgHdNB6cLY6BPj3IJKyWImgDfrMDA1E6lMieuFX
	j68ccafSlAjZXzpikvMHl/XjzxX+T+V/JdxyEjE7iQNl/mBbVI/wA5iGU/IM6UnFQ4hhHgu2DMB
	0boVvbmUtzo4gTFTtOTnPPmrHF6mz+R661NbKT3fUb79+p4oSVOYhc/6DXPzY+k7+Bq8ojkKT8Q
	cuyAzKJrkGL5w9LwD8wBK8cVmCloK9XCoo32jvN6ms9cWwDtka7ASGGg0HWqUmPhkFaRHfGsbLY
	mPGNj9IERc+5Pfa6rpUb2XtT+JuZEYbBGYR+Uzb1w2kmEWSxmTtaZ27YtY+b02RCuZwldbay0ye
	GDihA==
X-Google-Smtp-Source: AGHT+IG+Fy509ibl4vMoyjdRQJ/11pyC2NLwaDbsUnATnB3iiEGhuvxQY8W9gdPCcapJQHM1ZUamwA==
X-Received: by 2002:a17:907:1c0f:b0:afe:9880:8a9b with SMTP id a640c23a62f3a-b01d8a30e2bmr261607766b.2.1756582226030;
        Sat, 30 Aug 2025 12:30:26 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b00bab3ef2esm238563566b.11.2025.08.30.12.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:30:25 -0700 (PDT)
Message-ID: <758786b4-5e0e-470e-a078-1a730ffba9a7@gmail.com>
Date: Sat, 30 Aug 2025 21:30:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 net-next 2/5] ARM: dts: ls1021a: switch to new fixed-link
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
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
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
 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
index e13ccae62..6722c54f5 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts
@@ -120,9 +120,12 @@ &enet1 {
 };
 
 &enet2 {
-	fixed-link = <0 1 1000 0 0>;
 	phy-connection-type = "rgmii-id";
 	status = "okay";
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
 };
 
 &esdhc {
-- 
2.51.0



