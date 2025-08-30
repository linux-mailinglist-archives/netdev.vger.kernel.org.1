Return-Path: <netdev+bounces-218485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36450B3CA24
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 12:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A55317AB95
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D70274FD7;
	Sat, 30 Aug 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4nS7I+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143523BCF3;
	Sat, 30 Aug 2025 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756549638; cv=none; b=KqEKGYFwf9iqXqHvFv7u7duWMumT6nhTBRNLF6BmHfhnzbJY2+Qbg4RtBHGg78AWEDwxLhLdV9LjzZKkt9+4IlgPlngO8akNvlhxmxxRHW0w7Ox7YOA+PBJ6umK0ZjUdKfE2jieqWuefM3fQjS8NTifT/RCEvSgiPY3v19PTO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756549638; c=relaxed/simple;
	bh=8ThQZJ1bh/Pz8Uu5pQxL2vV22SNjFjWbYGjNc+SX60w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jMSxxVRdk7Lu7TFL1WvSwPQksl8eJ3stZu82zSlWr8y1yWWotKILN+RaH2hXS1NmoKXJiC9lmDm5qe98V1qJ2+nVJFvZXtQC4DMqYGDIOJmKUm0dCg+iNwjWOURC4qiRTdvvp762ianhwYDnagYKoRFrUO+QM6/qLXZbOwSxTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4nS7I+L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b869d35a0so1309665e9.1;
        Sat, 30 Aug 2025 03:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756549634; x=1757154434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/FzMRiTqQMPpBl/3jG9WvKbH8IHjf8CjWW0SBtbvgT8=;
        b=l4nS7I+Lw9Ya1xwJsUUamYViuo4fBd5xLYKu90YDCFhKqW3qJfiwkw0MMR2Y53tqaF
         fpIUf7wlzczhSEB5X26vV/BAaCzq3WetSnepzedZyQE6S/RQphQwOAF1IisTYy6TtTJh
         9pZUDfRzPgaDvXoeA/MPae8jYJduwyx32KuzbXB3yjzAuXzgjpM9zDFkJdAC6dgZidJS
         SataJ+LrF82ICO8uZOQdKiRhxrP+lo/UziZcBDNehDh6K8pXs0JWjZdW5ZHH4t9xEdr8
         NyEynVQNYrSvx2gp83gr/yOjWhOln6phK1aRHotFQ3NlLw200z1Sp/XbOaI1IAc1Irc9
         ZAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756549634; x=1757154434;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FzMRiTqQMPpBl/3jG9WvKbH8IHjf8CjWW0SBtbvgT8=;
        b=EfOHmSard3/6LNYFHlPsDNQagPZMKOsSMmqShfQsOLZmdNtKo4nRQcn4IWP8luWJ5U
         p5/RKHmfjQxUjtklvQ1E3nipkmswWE/A407B0yymKkHnpuhA1iSO6LYHjcIUTNCc+g4W
         O48OdCVu/frx11BruE4qIeH9lGb9MCZXLbvNc0dxZEg5Xu+ri8CMJAZB0HOIsHJ4uFWD
         cP2U4Ne0Z2Tq6FScVnEaYjrWyQJWqsqoovkUMmzvd3DDEbmoMlyF+x4hfD4Bf+BLkSsy
         1NAnzTdSsWun3lltOznUuKa1Uh4EhTKX+y5kQk/c2AWbJ5RlfTK+Iv+t1mvwcCmaIPtQ
         nzkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvOTFX8PDG0pHJSHkGohopnzWINHuURWtHGMg53Scxy3NH//i/lycjqgjEL6bDusNMG4KyYyAp@vger.kernel.org, AJvYcCWDLpjQBYD6c8oH6yfgaHa6Dy6JWzeAoCrENyV+aJOzntkSLA1yq0oQOYcb68lPHc4GHqLIN1AzKJfP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu3HswsrQpn6+avb3ojMuif6oj0Hb7nCuld9gkl664EK8+V+nk
	tzf85xhKvJgCRDBiDqzaJt9FEenJafus2eQMk6L+y47XF+LCtmbHmXBH
X-Gm-Gg: ASbGncuNbduAkm22lOgzCO3dLww1DsxBHmQrzt63hpy7+d66w0iQeRbsycx6/RYN4qC
	Uo7m3rGds5POFA6WGeGyVvEH7HS2mgg5/E0lpwH0IVvJMQNZe8NN26wd5YrsG2SZviCjX++3RxK
	yUy1ml8hh+7L5vQYGFaU8ENL1DSAMdZ0Z1oe/nv3aecRKnwJWdYyV6dPZCwK48Zn8c/Vknz13Va
	hA7mnNo08yGzCFPyBqPnTqQFavVDhwOU412wVezyMwfwewIno2/iPOxyUzMawFUvUiVeTaGGnq0
	DaqG0lqlX6SazGQHK3pGP5eMLhz3CosDjsomnt16RwgMZK+j4QYIbOohjChI4NkimwXmQrwgBio
	++gP08d0rChYW4NWI0UL+2Zuq0pFJepGzce16731uowvuT+SZev5Hm5qLDNjiuH3WRvCOsOfD78
	VY2TBv5z7qWL+0/KqXmdvlzaYO8vItzo1tbNw9/CW+3J1dS/zvSIJx5aVRd6VhhXn8Xg3kVsalW
	tqLbw==
X-Google-Smtp-Source: AGHT+IFs0nILNL+C5UOYPA/wPpQfRmPGcuIsRdL1qmH96i+O8bfEcxlhl8DfdOzeOm5L6hAc+bYnVg==
X-Received: by 2002:a05:600c:3b1f:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-45b87bf22ecmr4199455e9.11.1756549634403;
        Sat, 30 Aug 2025 03:27:14 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2? (p200300ea8f2f9b00080ca2fc7bcf03a2.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:80c:a2fc:7bcf:3a2])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm94179935e9.5.2025.08.30.03.27.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 03:27:14 -0700 (PDT)
Message-ID: <fe4c021d-c188-4fc2-8b2f-9c3c269056eb@gmail.com>
Date: Sat, 30 Aug 2025 12:27:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/5] arm64: dts: ls1043a-qds: switch to new
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
References: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a3c2f8d3-36e6-4411-9526-78abbc60e1da@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The old array-type fixed-link binding has been deprecated
for more than 10 yrs. Switch to the new binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index e850551b1..2e6fd153f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -205,7 +205,10 @@ ethernet@ea000 {
 	};
 
 	ethernet@f0000 { /* DTSEC9/10GEC1 */
-		fixed-link = <1 1 10000 0 0>;
+		fixed-link {
+			speed = <10000>;
+			full-duplex;
+		};
 		phy-connection-type = "xgmii";
 	};
 };
-- 
2.51.0



