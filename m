Return-Path: <netdev+bounces-153761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC279F9A34
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157B87A1E6C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A520225A4D;
	Fri, 20 Dec 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h49gztQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2840225414
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722240; cv=none; b=Ct4HpSoESEag5R6TnO+nIPyS7P8no6Qlf5MrqwNIierqrYVcBTO8L/bPRd3JJPrvxiv2U+uDNhp/+++ddUg8kR5KyQJYtbSoEt3AITbhsYRpihdvPnRipBkVNfLQwk1+FTRu2nPgFcCgd3QvFw6tKSIUPO477tK0mynWrGwinZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722240; c=relaxed/simple;
	bh=3owT/KMCvF5XwxfrBAfaiky6eGpIYrzcz95ija8sMWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgIwIzZHMoYfIQ4toM+Qf8Y1g9fTHVtbdc/tUUxzH1Ygm1Rqj20xiCRDRj2fm/GZL/9u3BvglijFJQgubPQj7hDDYzZXGFcqvxp71XAFm9Tpmhh5Pree9OX1Zq6OzUc9QptQj94pVid6ecAaPG6TUCGSOCoQVOXfErmZCghv16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h49gztQW; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d479b1e6so2913520a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734722236; x=1735327036; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBR/gsOu5StkcyNL8p43Oyx52bSqF/t8CsaHctvuxX4=;
        b=h49gztQWoAh9Ae5RpDe/nkxfQDL6oPqjeFZeN+RXRSt6QaoT2Yr01PYZPb6/auh6Qy
         e3uok0CXIVUUT4NJPk+ElAy1DKAOQgycNX9Pc4HeWTpNPPAGNJOHHtBoY7ui40AmZ1Mv
         0HLHj8rXK4j4knGt6iGZEPjhgtFFu0EZ9DFBLCoquSYjZdqh6ZkUbwIn14PXajKPF4B8
         0kTmX6zy56OJ/8V/ZVrbPq22BAT/ss6AAURC/J1gt273iYMhg9nYynEkgTpBRjq78Aa1
         5EgsBAQUwtbIBHGzZ6NstFn5Xxh2pcALzMAxlmZxB6FncbjV54a60Ut8hd57K2o1g/mg
         Ciug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722236; x=1735327036;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBR/gsOu5StkcyNL8p43Oyx52bSqF/t8CsaHctvuxX4=;
        b=NJDp02AX29gAsaQRKjVnxzOhrUwd3kvCZi1UB/h5onZ9lSZPuqtTcIOdNpPr9tdyAP
         gZnAsiVqlrqsVKlZGd+Lk8ssu2iC2/eykhthGPplnXwOOPF0B3l8misWJwfwXwMFugsA
         eNWaRNwE4QrpIbrDpf0juZOAzADekWVNwljqLpK1VmAn81IdQbcFrlJwceFHcRHPoMj1
         xs4rL+ZSatZaGg0G+uzlybD7gursG40fEuVoi7TQR8ExiZouyq1APIfOsKwbpPXYwP7v
         XfcdUvKSwyh0pdYgPk8SLgz3+WpmvHYKo7625/ymJDN6VmN3PF5XAdMpY5GVKMUsuQNY
         16CQ==
X-Gm-Message-State: AOJu0YzLgtzRPWgLg9JqzsUEwO2tO1PeDCo4f7VvqRAvW3Ljmb83+RH3
	4Q8s5VX5nClUFaEUkAtj3Cq6DIT5RKe0ehd93EQjZ/v33chrachL1n3o26UKhqc=
X-Gm-Gg: ASbGncup66KjEVusEGBCtoujxGs3azHXSpnyt4BdDZaC0q8zYBXkRy4Cn2dBC9sMNY8
	XXoj2lXq14e44L9cnHXSJhTJgMvPB8ADPPYF6Y8kuwDwPUEmVdRGRAZuc9s1aWQkDSFzk+68jyc
	e/HvV5L2CB4nvlortjXol6/dWiiy5mqbj0aaFCBGOkCsTUR5UJxDMyYeZV4GcmhSdeMQjklL+qB
	9hREm4dZUTBtlczixPkgil+cr64VE3Ko3n1lvxeso3L/kWFcMHzR7iq8tXxWUWsUBI=
X-Google-Smtp-Source: AGHT+IFmLyPE9OMUVuB/6IZRMr2eptvA+ua1OuRWCkVTNnTDUTn6N/1kmxMoQ8Owur8tJ0XN93MY3g==
X-Received: by 2002:a05:6402:1d53:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5d81de06611mr7849152a12.23.1734722236189;
        Fri, 20 Dec 2024 11:17:16 -0800 (PST)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80679f11dsm1988727a12.46.2024.12.20.11.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:17:15 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 20 Dec 2024 20:17:06 +0100
Subject: [PATCH 1/2] dt-bindings: net: ethernet-controller: Add mac offset
 option
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-net-mac-nvmem-offset-v1-1-e9d1da2c1681@linaro.org>
References: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
In-Reply-To: <20241220-net-mac-nvmem-offset-v1-0-e9d1da2c1681@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.2

In practice (as found in the OpenWrt project) many devices
with multiple ethernet interfaces just store a base MAC
address in NVMEM and increase the lowermost byte with one for
each interface, so as to occupy less NVMEM.

Support this with a per-interface offset so we can encode
this in a predictable way for each interface sharing the
same NVMEM cell.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/ethernet-controller.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b2358002bc75e876eddb4b2ca18017c04bd..608f89359ca844e5325e3cc81bd2677b0eccb08a 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -53,6 +53,18 @@ properties:
   nvmem-cell-names:
     const: mac-address
 
+  nvmem-mac-minor-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 255
+    description:
+      When a MAC address for a device with multiple ethernet interface
+      is stored in non-volatile memory, the address is often offsetted
+      for different interfaces by increasing the lowermost byte for each
+      interface subsequent to the first in order to save space in NVMEM.
+      This property can be used to add that offset when several
+      interfaces refer to the same NVMEM cell.
+
   phy-connection-type:
     description:
       Specifies interface type between the Ethernet device and a physical

-- 
2.47.1


