Return-Path: <netdev+bounces-182998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D995A8A891
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E648D188506F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75456250C09;
	Tue, 15 Apr 2025 19:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZccPDcm2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D7250C19;
	Tue, 15 Apr 2025 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744746900; cv=none; b=kmhtwyLCvuLfwZ0Sx4UfAhckaBOjNAY4TwWPaqalFXHsYSly1v9WOhIbrYHFeQy8zjTrxzqkK0WRZ9IRt7gHhHDd3yhpBFGG/s7kNS41HX5iRabgSmMo8Tczjobu2YBn8KyP1CnCAIgWkJvPvp+VClBmBgpjuVKEJETKlLvG7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744746900; c=relaxed/simple;
	bh=Ix+6HpNHc24fuK5m6etCqu1ONR7umkQsEXsEZuE4Xy8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JWy3Ck4fCOUvgJD9rmeM8v1J5zPAB9EzTFvBY2qKk1NCbk/bNT1BcKOm1EUYsJBP7/Wle7aFws9QsGtSSb7Ijo20akqwL7nsii00zJ5/bOeAhgOjLYT90MrpULTqXA+QXxnAEHPcAZEA34KgmlbHevJCNtgbYVWDHMpry50NzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZccPDcm2; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so10469423a12.0;
        Tue, 15 Apr 2025 12:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744746897; x=1745351697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+RazAtjX6evBgZen9Jx6aV5E2vELwUcHhoKLX8rCi+c=;
        b=ZccPDcm2TNxiKboWEsdLwii3nRGFNVZiKKLZD+riD32yRlZ+Xsa5M9vSNpeWMuyo4J
         K/oXBKxQ6gUEo3Qk/ahgNeQRYodDx4A4kLw/2mLIrpzhdsZnyLlogAb1MXM/W5n7DAEK
         1JiUMVfj0RSyy5GuqClZt+wlcpmgNRXVmm5zxziIDZXoJFlsi/pla/DCtZFQtWSI3PAp
         /dOSlj6fsR3OS9/JkPprxrWHq+BIbVbBKyzjRdA/Vc0jKLuKjoZkTxBT3A+RN6vhxn64
         J3z3ofx/VqePgwzo1uCO4Dl/qXmAtR9i9p3Ivfw0IcUQ3ESACHUGYYvut6Ax0MppyAGO
         mleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744746897; x=1745351697;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RazAtjX6evBgZen9Jx6aV5E2vELwUcHhoKLX8rCi+c=;
        b=mQqsGYSbGs0gmyd6mGXuyuMYgVO7SecU9P2SNY/5xhiZ5PiLH4TbCadMlwkKLBNe/2
         9ub4B3/77hQFK5zTctarzR8r+DVYIsEB6ZErBAoCpwvlDa/veL6hneeZmO7SnPWdGDWP
         FMQlDonygtCPEbelybQnGdhjEquakODmUYT6aeW/0RKBcxjEEle8v+M0i7SfQPYyS03r
         5yv0Ans7CAwc1ZnYtE41ksGVtgmaWJIVWuMV7i6Bt3AG9btb1p6FMfeiykZATtS1IQoP
         99ZRkxMOh/tPJAE30CAtu3DxeYo3JrpCMzoIbmAgGPffdzTl8q2HDaSyANAx/UrfbYBu
         LY7g==
X-Forwarded-Encrypted: i=1; AJvYcCXOpZlxWKwwhq3oDdwej8xX3Hx3EZz8wMOGB/F+gKMg2uPI2QU5lCJXDWlNHMl4qOrtV2PM6tWycotz@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfmv36ywAln0twy0hb2r853ii34AQq4O45o1ezkzKxT1dIn8w
	VqOOSvpDszhWTsordQyOsLoIEVh5dnlMBbxzVPvA+oeuGnJ6m/Fp
X-Gm-Gg: ASbGnctK/Y5egHGAGlSrj51/3lQbKb97PKlBHUlrTp5x3/rcT61xy0ULn0rzc4kYcig
	WbTTFUqZsAXyFp+4+9BEPoaA3RJVxUYQ3+zctpRy0a/IjUcH2SxleYgr8l9S6Z2bOWqas/sDgMa
	VJ/3FzM0oa1Fetz8o7MTIf0DkLVibn81Bi1ZQaqoyjhvfOokfNiWSvhQWZ6r8OQkoAagIqRF0za
	94JGELVjMVKpMjZ8cDTw5o5Mj1JFl74o856spVE0vUytiuh3K8ZmQArSwIqyI8BiZ+g0vDWhHUr
	VXLGOfB8AHqY9uKxmyibl3GjVFF9idvo/9qpxo3xAp2gYuGvfqnPGN/rlt//kx3UXS9py6qXAUi
	bXPxBhdQByGcUWBz55x0VLMLnUeQ8Bs1PmhNIenIDcFsv+x1On6kh9TjmpzF+oY3AQYpv1pk0bY
	xZXMmnxQEetVEDm1vYS0AmFQqGBgswt9Yo
X-Google-Smtp-Source: AGHT+IEW2muTh69Qx1yPeg65+lv/AmC1woBv1km7hKqs81CHiyilhU17/wXpnQz+FK7YvF9DiVV44Q==
X-Received: by 2002:a17:907:9445:b0:acb:36ef:b920 with SMTP id a640c23a62f3a-acb38252335mr28398966b.15.1744746896534;
        Tue, 15 Apr 2025 12:54:56 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e? (dynamic-2a02-3100-9dee-8100-1d74-fdeb-d1fd-499e.310.pool.telefonica.de. [2a02:3100:9dee:8100:1d74:fdeb:d1fd:499e])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-acaa1be8eebsm1123768566b.40.2025.04.15.12.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 12:54:56 -0700 (PDT)
Message-ID: <aacd2344-d842-4d10-9ec8-a9d1d11ae8ed@gmail.com>
Date: Tue, 15 Apr 2025 21:55:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 1/2] dt-bindings: net: ethernet-phy: remove
 eee-broken flags which have never had a user
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <ee9a647e-562d-4a66-9f9b-434fed05090d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These flags have never had a user, so remove support for them.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 .../devicetree/bindings/net/ethernet-phy.yaml | 24 -------------------
 1 file changed, 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 824bbe433..962bc62e3 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -134,30 +134,6 @@ properties:
       Mark the corresponding energy efficient ethernet mode as
       broken and request the ethernet to stop advertising it.
 
-  eee-broken-10gt:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Mark the corresponding energy efficient ethernet mode as
-      broken and request the ethernet to stop advertising it.
-
-  eee-broken-1000kx:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Mark the corresponding energy efficient ethernet mode as
-      broken and request the ethernet to stop advertising it.
-
-  eee-broken-10gkx4:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Mark the corresponding energy efficient ethernet mode as
-      broken and request the ethernet to stop advertising it.
-
-  eee-broken-10gkr:
-    $ref: /schemas/types.yaml#/definitions/flag
-    description:
-      Mark the corresponding energy efficient ethernet mode as
-      broken and request the ethernet to stop advertising it.
-
   timing-role:
     $ref: /schemas/types.yaml#/definitions/string
     enum:
-- 
2.49.0



