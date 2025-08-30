Return-Path: <netdev+bounces-218509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 990E9B3CF08
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 21:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD151B27344
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B3E2DE6F1;
	Sat, 30 Aug 2025 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK28+oTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846D2DE1FC;
	Sat, 30 Aug 2025 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582132; cv=none; b=ZuTGugw2eck5oN0tA2s4vLlj5iqNdoU7qCWY4dmtfLJRRXKig6CrVchw7U2+9RgKJ1N5H6SMnTjUughylz6OKXuA4MYZCRewY8orK76oM+L4KFlaBX7mMFSU2FL1/lLvhXs2CPwGFmfuqkAYg+wcDn3ux6GniX75crecgnBQB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582132; c=relaxed/simple;
	bh=mj6BBkXtTp5OEVoAmwshIMCFa6xmRm5kYv2DqZLbl1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iTI7wBsKxkTSgghKB3IMsp9eWU8UrK8fJT1epys4qXxPfVY35jGwWpiO4oMFcpG2u+idv3y2mouvCGAXnVJ2C9DxZ+THKnj02rVVqOyj+bKTnwIjpJGgvGrV5VP/nNqfbjZVH+e6YSw3Qg4C8jFVH1gPsZRzxXaueTTHJGd5EP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK28+oTG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-affc2eb83c5so156272966b.2;
        Sat, 30 Aug 2025 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756582129; x=1757186929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9Ms4hIwxfuw6SwTL5RIgMEksEmD8lz0uMx7wT1GeCU=;
        b=YK28+oTGpSJ5wz/HcwNCa6bQ6p2dW1+mn6IbVdeGQ72zYSkShElnwcR1DZBdknKg0R
         ugVxUI1YI/l51YDj6f8bIWn9dI0jL1iZgjIwhhC7e2QPEHD8B0QgjOs60gQxF8ouEmE/
         5gg0177JzwFZw+/GFPVZ1Bi2E9tosEBjNsc7KXJt6pVtDzc16m1DsMBOIW2d8nkg2DBu
         k2Lr3IKZaWRY8/h9fDqPlkkPM6478saLGGodXvuVNZcNx0k2CyCmX0FU8ZA3eW9OoVEy
         uIJvsMqkdRatud3pyE3qGWpTLh0tL2OrTVVyk8tQvKeirgr4k55rgsSf/BjIjlpMApFV
         dVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582129; x=1757186929;
        h=content-transfer-encoding:cc:to:autocrypt:subject:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g9Ms4hIwxfuw6SwTL5RIgMEksEmD8lz0uMx7wT1GeCU=;
        b=B4+3cpB7Iqxn4hWDxfjobjwPd4pSQhbWhSEj1osVYLHi3G/tG1TDVabbpS7RUetSWv
         4vnPiT0wA7hCcY/gv399k0cKY6e2273KZTN/Ld6Okc+t4Xk2wXj+bZ9oTZrhJo6vWbiK
         1IR+mPTEFK01XTbb/gP2zH2uVvOthLZ4YNdb/CpDuSt6jWxVOTDlW2NAG6rEO7Yh4oAn
         DFl+/YhX1Pb7AE+m1WW9QwBscph1hMilgsv4hu1EMaMgIzPDZsjpJ9QxH0tCXmNgUqE1
         fFOATMwO2j7LiRSusUj3UlNT72GFo7uTxGu+cNYPvveWV84Vkki8YdvU6E5FvOUy6Mgo
         rm2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCDjIitb5HjbolEBLmNxXQ+53SbxsxgyZ+1CUS2MDPg+d1/Fj1S9yyzLOep7EWM6CSPkFkWCjFb5Qq@vger.kernel.org, AJvYcCVonhhcQy3jzVQ0zLZcrCC931djga9Hje8+c/pXH4LQ3PZFJofSXEoHs6+2uObfGE4yXyqpg0Pz@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxzPYgqLwIVrqyiVf3/3SqM6dBt/vkmvBSBeuE8Q6V61ykyd2
	R2KtrtR5TkaztJcSlo7gbyznsoxdEt+PyNBJVTKHbkktiAEcmhSi2wD6
X-Gm-Gg: ASbGncs/Nthhpjlb0lM60rZ/2YKZiNFOcx53j2LHwsP7CqFGT0mATajukNSdK1ukIuy
	hYsackA2RPgjWVlyCfp2MTMB7Csjg8jxaRzs5OwpWGIPHoW4r6UxMCq1Q1SdyzrygZoKbSL3YCa
	OGL5orwgPG+aXQNh6zbDkrFs1Mfs/zZE8OP8F0zNtoqAxcot47g+8IMdvQvUVLAEOOHtFpOr7yc
	4x+qsZgN8q9/Dn6o8TxmfIIeF0ElotGhNvBEMbXtMjaKEDk3JlHzOWejk0gvuDisJkQD1xKTNGF
	QMcI8QC3jEMo/JUYnvllDCUHKYH8aABFFxDKIfJXfzPfA/nqRLAG+JqylIxXazAUrS74c325r/v
	4pUCihPTP7d1YyN5Zjnm/eXCIowiyCFqI1kK21gnqWTUobG/JXmeDNm8GY9i8u586Xkq+fveZZN
	hdGk38BVvhhNr/F0L16fujExg7z9AS8xEv3zLgLOr+/cHFTDHidT0MGL2obwrIFG0CXOw=
X-Google-Smtp-Source: AGHT+IEJ/Gu/lFJ1aMzBBgxaQ2ogVr5hZIfka5fOlEdx/5pq6/tFR1Jp2zQyF/pR0Gl4mhVXUM6YEA==
X-Received: by 2002:a17:907:9453:b0:afe:7d3b:846b with SMTP id a640c23a62f3a-b01d8a32453mr167748966b.7.1756582128633;
        Sat, 30 Aug 2025 12:28:48 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:9b00:d113:449:b8c4:341? (p200300ea8f2f9b00d1130449b8c40341.dip0.t-ipconnect.de. [2003:ea:8f2f:9b00:d113:449:b8c4:341])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afefca08b41sm465104766b.25.2025.08.30.12.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:28:48 -0700 (PDT)
Message-ID: <cd55d7fb-6600-49e5-a772-18b39811b0d2@gmail.com>
Date: Sat, 30 Aug 2025 21:28:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next 0/5] net: phy: remove support for deprecated
 array-style fixed-link binding
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The array-style fixed-link binding has been marked deprecated for more
than 10 yrs. See e.g. 91c1d980d601 ("Documentation: devicetree: add old
and deprecated 'fixed-link'") from 2014.

So migrate the remaining few in-kernel users of the old binding,
and remove for it.

v2:
- fix "Properties must precede subnodes" error in patches 1 and 2

Heiner Kallweit (5):
  arm64: dts: ls1043a-qds: switch to new fixed-link binding
  ARM: dts: ls1021a: switch to new fixed-link binding
  ARM: dts: st: switch to new fixed-link binding
  net: mdio: remove support for old fixed-link binding
  net: phy: phylink: remove support for deprecated fixed-link binding

 arch/arm/boot/dts/nxp/ls/ls1021a-iot.dts      |  5 +++-
 arch/arm/boot/dts/st/stih418-b2199.dts        |  5 +++-
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi       |  5 +++-
 .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  5 +++-
 drivers/net/mdio/of_mdio.c                    | 26 -------------------
 drivers/net/phy/phylink.c                     | 25 +-----------------
 6 files changed, 17 insertions(+), 54 deletions(-)

-- 
2.51.0


