Return-Path: <netdev+bounces-47537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620087EA710
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA848B20A6C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9B73FB13;
	Mon, 13 Nov 2023 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCYath4z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A03FB0A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:36:07 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B9ED6B
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:36:06 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5071165d5so21789701fa.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699918564; x=1700523364; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7sBbrB5dazvmxdFbFWIm12yMxEolhEuwzB459S9svI=;
        b=GCYath4zyDrnwOJWVtITfzen6Cj9ndDAB2wpCz5yC2xJOvoIZmqQk6tfjPcKHKzIQX
         47rXe699q6IgYQatad0qpMeMa482pPA+cOvTH5HFU26TvYy6i+pkGh7Z4q+fsajhaDUC
         AdZvCAjiBSlg3dHBwVwTw7/xwRZ6evsSdHEtPL+PDEIleTaJXhGHZjh1mUah46fdAYQ1
         bbSrTHcCzykX/FPbMkmhFsadn4LlEWZyPB9sl34KXWBx6XiM6cO/H9HDycNyEM5J++Xw
         J3AAMkeohFvs+wYRT10v0Tqfw55dOHX4tqvMY9MXgjLzqdHRvgU203ibprg5npJ9P/gX
         yjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699918564; x=1700523364;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7sBbrB5dazvmxdFbFWIm12yMxEolhEuwzB459S9svI=;
        b=W43XrbGEixJJg6JGiy0Wbcxo34lZgzR3H5FPOJxpgQimghDM5KT4CkxD5wG4qQzhTF
         abF2dtJEKnmZ2bqogufUTylkVRrWJTyvx3Oemw9CFSBWUjMUQnZKqPaiAepPlBxM0PcP
         0Et9KsWtgjenub93MMvMmUxCpa976F0swwlCMKcXev6fTIJtwoCHTbtpGnnukXiWQmVC
         DqpYNnX7Pjmz1T2pehKjNk4vNMINsjsEkttHLLu2iDEJ7XV1uyQqqR6bhhJNyjkbl/CP
         nLWSwiniXgDFSTMMfGudIPef73vxSdzrKiGtDDrw1k6BgUQn8aYWs4JoZZNLgjhZ2hT6
         VJcw==
X-Gm-Message-State: AOJu0YwATIxS0yDwYELP6FecrFWCXDqnRoosE8MxKRqz83ch7/RpTMqx
	f+pJ7uhJAOz4Uf5+nXuM+r7uAA==
X-Google-Smtp-Source: AGHT+IEcKzuTyUsnCCKx0aDIJeN7M8fqCWuHVFSv5zu+wJ/DA8g7pht0vHxLMNEUkq/nMkCaBzn1tQ==
X-Received: by 2002:a05:651c:1055:b0:2c5:3139:2d04 with SMTP id x21-20020a05651c105500b002c531392d04mr451059ljm.47.1699918564602;
        Mon, 13 Nov 2023 15:36:04 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 17-20020a2e0611000000b002b70a8478ddsm1202859ljg.44.2023.11.13.15.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:36:04 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 14 Nov 2023 00:36:01 +0100
Subject: [PATCH net-next v8 6/9] dt-bindings: net: ethernet-switch: Accept
 special variants
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-marvell-88e6152-wan-led-v8-6-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Accept special node naming variants for Marvell switches with
special node names as ABI.

This is maybe not the prettiest but it avoids special-casing
the Marvell MV88E6xxx bindings by copying a lot of generic
binding code down into that one binding just to special-case
these unfixable nodes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/net/ethernet-switch.yaml   | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
index 72ac67ca3415..b3b7e1a1b127 100644
--- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
@@ -20,9 +20,26 @@ description:
 
 select: false
 
-properties:
-  $nodename:
-    pattern: "^(ethernet-)?switch(@.*)?$"
+allOf:
+  # This condition is here to satisfy the case where certain device
+  # nodes have to preserve non-standard names because of
+  # backward-compatibility with boot loaders inspecting certain
+  # node names.
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - marvell,turris-mox-mv88e6085
+              - marvell,turris-mox-mv88e6190
+    then:
+      properties:
+        $nodename:
+          pattern: "switch[0-3]@[0-3]+$"
+    else:
+      properties:
+        $nodename:
+          pattern: "^(ethernet-)?switch(@.*)?$"
 
 patternProperties:
   "^(ethernet-)?ports$":

-- 
2.34.1


