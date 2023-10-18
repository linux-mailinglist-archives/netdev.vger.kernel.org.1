Return-Path: <netdev+bounces-42167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EA77CD768
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 11:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E247C281C93
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831E168BB;
	Wed, 18 Oct 2023 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OoAfKx6A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F97134BF
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 09:03:53 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD14F9
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:52 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507ad511315so4375855e87.0
        for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 02:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697619830; x=1698224630; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zaIruG/+oRLmIiPtyA4re6+dZhPVyRXTEXdAK4NZbCw=;
        b=OoAfKx6A0Iu/niMUpEPUx3KGuTz5uQZWkFp2jBBEP/fSil7X7r327G3vAyDTooahjp
         EGgdU9a9cyDX9WJrbJ/rd6e9B0cfa60ku3RDTJODaj4bnkfwy6z5VjzxEeFaoDG01IJx
         CxQR4D1+cEVfzkybHhSH1OaG3mzXUO10h2ztnvg4K2ndaw1VUspL7Zdx/diYFVihC/VN
         nIP4FVS4R6l9AY80+0rXhwfYJISvhO5fTGdabBZGnJoPSiGFKGwjI0rLCQzu2RNWUU6t
         m7xbGxBeanjUGBlXVdNe0Ut5eQ75wa5mvRf6+LcVPtBrxqGCf10YgKF4qtCm9fM3wR1u
         E4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619830; x=1698224630;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zaIruG/+oRLmIiPtyA4re6+dZhPVyRXTEXdAK4NZbCw=;
        b=U7kvOgMniIC1c2dKyun1kT749qNngtA6lxjb3g1zTgInUfjK8LVJ6qhOOTUG9nb/kT
         3bhAie40X4aV2BYMtzxckjm1G2JSF57ZiJEov3O9ilr3bO5h0qDIrZ5HqW3kSfQ+ZDGu
         8iNcBu1s8Lot9hmaJq6mLjvVWE9Pjx03WvjCK54hxJ7dGuh67Eb+koGvdCLha7pSk1gu
         fi1wUl02GTqFCiyQofPHDk7vpNDIgtcjIihodPPNTDaSzNHXEIN9Vlewndh2bCN52RXv
         M7T8mJmPxzvf9rGae9KbCp1F1D2ufqHOTcZ/JiWJvxBJM9dESFQHa20o+iiN6uF4tYcQ
         x0CQ==
X-Gm-Message-State: AOJu0YyJ7TqZoOjtKFdkTplVBLEEYrMIt0JLAEP+DagrNjo5gNDYIpTo
	xBNtsuNtqB93/Dac4I7gQ0WTYw==
X-Google-Smtp-Source: AGHT+IFY0XDRY/pa63zXmKQrtZQymVa+AbJSNc4MhTRKG7V9Bl/TmTl9DLtY0/d2S5YnwLU222UlmA==
X-Received: by 2002:ac2:5585:0:b0:507:9608:4a87 with SMTP id v5-20020ac25585000000b0050796084a87mr3480502lfg.56.1697619830254;
        Wed, 18 Oct 2023 02:03:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b005056fb1d6fbsm616595lfr.238.2023.10.18.02.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:03:49 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH net-next v4 0/7] Create a binding for the Marvell MV88E6xxx
 DSA switches
Date: Wed, 18 Oct 2023 11:03:39 +0200
Message-Id: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGufL2UC/3XNTQ6CMBCG4auQrq3pH1BceQ/jorRTaIKtKaRiC
 He3wQ3GsHzzZZ5Z0AjRwYguxYIiJDe64HOIU4F0r3wH2JnciBHGKSESP1RMMAxYSqhoyfBLeTy
 Aya0Fb2trmDUoXz8jWDdv8g15mLCHeUL3vPRunEJ8by8T3favTvmhnigmmNSUtappZFnr6+C8i
 uEcYrehie0hcQyxDNVWKyLbSkrR/EF8D1XHEM8Ql9oI0Rjb0vIHWtf1A/ktN/5bAQAA
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Marvell switches are lacking DT bindings.

I need proper schema checking to add LED support to the
Marvell switch. Just how it is, it can't go on like this.

Some Device Tree fixes are included in the series, these
remove the major and most annoying warnings fallout noise:
some warnings remain, and these are of more serious nature,
such as missing phy-mode. They can be applied individually,
or to the networking tree with the rest of the patches.

This series requires Rob Herrings series
"dt-bindings: net: Child node schema cleanups" to be applied
first.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v4:
- Rebase the series on top of Rob's series
  "dt-bindings: net: Child node schema cleanups" (or the hex numbered
  ports will not work)
- Fix up a whitespacing error corrupting v3...
- Add a new patch making the generic DSA binding require ports or
  ethernet-ports in the switch node.
- Drop any corrections of port@a in the patches.
- Drop oneOf in the compatible enum for mv88e6xxx
- Use ethernet-switch, ethernet-ports and ethernet-phy in the examples
- Transclude the dsa.yaml#/$defs/ethernet-ports define for ports
- Move the DTS and binding fixes first, before the actual bindings,
  so they apply without (too many) warnings as fallout.
- Drop stray colon in text.
- Drop example port in the mveusb binding.
- Link to v3: https://lore.kernel.org/r/20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org

Changes in v3:
- Fix up a related mvusb example in a different binding that
  the scripts were complaining about.
- Fix up the wording on internal vs external MDIO buses in the
  mv88e6xxx binding document.
- Remove pointless label and put the right rev-mii into the
  MV88E6060 schema.
- Link to v2: https://lore.kernel.org/r/20231014-marvell-88e6152-wan-led-v2-0-7fca08b68849@linaro.org

Changes in v2:
- Break out a separate Marvell MV88E6060 binding file. I stand corrected.
- Drop the idea to rely on nodename mdio-external for the external
  MDIO bus, keep the compatible, drop patch for the driver.
- Fix more Marvell DT mistakes.
- Fix NXP DT mistakes in a separate patch.
- Fix Marvell ARM64 mistakes in a separate patch.
- Link to v1: https://lore.kernel.org/r/20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org

---
Linus Walleij (7):
      dt-bindings: net: dsa: Require ports or ethernet-ports
      dt-bindings: net: mvusb: Fix up DSA example
      ARM: dts: marvell: Fix some common switch mistakes
      ARM: dts: nxp: Fix some common switch mistakes
      ARM64: dts: marvell: Fix some common switch mistakes
      dt-bindings: marvell: Rewrite MV88E6xxx in schema
      dt-bindings: marvell: Add Marvell MV88E6060 DSA schema

 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   6 +
 .../bindings/net/dsa/marvell,mv88e6060.yaml        |  90 +++++++++
 .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 225 +++++++++++++++++++++
 .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
 .../devicetree/bindings/net/marvell,mvusb.yaml     |   7 +-
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/marvell/armada-370-rd.dts        |   2 -
 .../dts/marvell/armada-381-netgear-gs110emx.dts    |   2 -
 .../dts/marvell/armada-385-clearfog-gtr-l8.dts     |   2 +-
 .../dts/marvell/armada-385-clearfog-gtr-s4.dts     |   2 +-
 arch/arm/boot/dts/marvell/armada-385-linksys.dtsi  |   2 -
 .../boot/dts/marvell/armada-385-turris-omnia.dts   |  16 +-
 arch/arm/boot/dts/marvell/armada-388-clearfog.dts  |   2 -
 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |   2 -
 arch/arm/boot/dts/nxp/vf/vf610-zii-cfu1.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-scu4-aib.dts    |   8 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-spb4.dts        |   2 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-dtu.dts    |   4 +-
 arch/arm/boot/dts/nxp/vf/vf610-zii-ssmb-spu3.dts   |   2 +-
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |   4 +-
 .../boot/dts/marvell/armada-3720-gl-mv1000.dts     |   4 +-
 .../boot/dts/marvell/armada-3720-turris-mox.dts    |  12 +-
 .../boot/dts/marvell/armada-7040-mochabin.dts      |   2 -
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |   2 +-
 arch/arm64/boot/dts/marvell/cn9130-crb.dtsi        |   4 +-
 25 files changed, 356 insertions(+), 160 deletions(-)
---
base-commit: 1c9be5fea84e409542a186893d219bf7cff22f5a
change-id: 20231008-marvell-88e6152-wan-led-88c43b7fd2fd

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


