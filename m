Return-Path: <netdev+bounces-177649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB2A70E2D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 01:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FC7188E7B4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5697C3D6A;
	Wed, 26 Mar 2025 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/MLhh5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDF1323D;
	Wed, 26 Mar 2025 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948683; cv=none; b=qanIEyWr1fDFcEaWYNWSzcyZO1ylMGXDBwyUAGwKN5cwIOUnK3sW4yADwjjRUnIMN+wcqOy4dXFikcIU82ry4/ak62+HO4dT/Ap6qSNXh/YKiUvaJ55AkW6sjv1eEHTR5D/2woP3YNO+FdcKpFRWMdK/TD5oEv8WuRdRdsZzw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948683; c=relaxed/simple;
	bh=IvSHZ7uW6XrC4TtmEYqJ60Tay1pUt+B4YYlFltXPxnc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dCtgjnTFU88mEeux69nS5qC89fX2c1Sq3tGHjrjDPNtAGCaxqWGQtU9S1VkZsK9/Petm/ahLCHliSGH4bTtg2hnRp1GXnTprmMJn++s2Jq1GUlKIU5Li0i3rZgG3Y9zaCOgCU4ff24FMGJ+55HHAP8k+z9XMTkj4qdVxK7sp4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/MLhh5Z; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so37436565e9.2;
        Tue, 25 Mar 2025 17:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742948680; x=1743553480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=psDzSiy+GefNpBKgyGrcVXnj36uOU8MvrpnX3Vh5YF8=;
        b=g/MLhh5Z8cM5/ixg4SPc+1JPh+3QkUTZ0lGl4IupHXUhCAv5ibXGCDR8g5x/7uGx5X
         knnKGTHaFPc/iYol7G7NFdbKAKR5GESqVFxLGSgIAGpt1obsN/MmBnVOqIHluE3n3Q99
         gehQbf/IpqeT+l4WzsdJa6HBfP8ulWW6rNSh2sGsufgxl7LUjBKkdiD1MYVbhTYGjSUc
         GD9rTJ4RqSliUaaux94Ywbg9q49x/Bfl/PQORUDioynqWQlq9XA2ZJLE9V8bd2S44Gmd
         mjlVCGj2wgnsPTSy36d57+uKwrL/MH1YKgCwVisRcL6gPYruP1w/jqdY0R+6tGkDQsPs
         dyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948680; x=1743553480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psDzSiy+GefNpBKgyGrcVXnj36uOU8MvrpnX3Vh5YF8=;
        b=LcrHTT1U4z9iPKoDSWl2FmmBsR5g4eegJ+alfjMu1X6y504tpveT1g5u0S+++2gJ8S
         Tk3sMad/KLNJL+AD9gzOhdf0Yvk1gLAH+zqLLgDEitTeLmpegT276ArzshHQ7/eo+7kQ
         J5ieY3eFFqoeO/20i6pDPx5k0W38GyMVPIiG8KIpa2rcso1Nne3tx7r3YaIX1GQHL2mo
         hU2WbGNPmHBp6zzz/Hl5tsHtpi8/07r0TQt0jV6IBmVj8ViLF0sz/YNpzMfyZZSf6u5/
         XhKERQorNCLrGrX3T2JriAg2JHsEfD9HVWiwzNzuF+SmZlNO4J+mvq0HUGRC/eYfyVFJ
         8bPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1x2wfLA0x+Azr16XROrBOCJtCl6T4hx74glA6PVgYUtE8Rt+WqtJOjpN8aDfRSI7Iwe0nZy0E5a/8@vger.kernel.org, AJvYcCVhD3sqWrMMXkNfzIKBlMNgp7ljHupRqwjAsvqzL2YCkZ7flHWOOBmspgDq017REwQy1B3Zult1USSdDxeX@vger.kernel.org, AJvYcCVvJ9C0JTrM6KtP9epbaRFlHqrFAfwWfHmyooNFahKzEuBCCg6Wn2r3+h0PWo/1tD5AHN9sCwAi@vger.kernel.org
X-Gm-Message-State: AOJu0YzaA14S2RT+LGnnElhAGB7R/UoM4gcEtibqH2eYEixT2sqL4+SU
	3AWvtB0CGbCWzjIUFcn8ir4kKLw/L9tvf1q4vd6S5J2uIoWFsVpX
X-Gm-Gg: ASbGncuNatDCh1otQ8bOr+ZMPQs985YBs5ltZENME+bdTAIn8lzkMxMcfmglAGIIHGz
	WjL9DIwU3sPs6MxoUdeVJkA7gYHQyWdKlApmgbkMwgtP2otX8F5jLl+dmIq38rlPIYriUUyDU2x
	oDMXKaegKhsRQvufiPDPRA59yO4bq3kZ9L/JY3D6vgfpA/yWDunmVkTnJ1VTBDi1RKADcchvrJP
	iyFqeOsW3mENc1MV4FQdSbJq3z6NdbEP9lHKpAPW4PNeTikCU+e0G8vU7NHFg/3XXKjha2xfmrW
	Csh2NiPxAHDtEJuWICigEoqcEwPMHlL2i91KBvZ5lDfh2yfDy/1mcwuN2TPHQcemHbvZ+CkD1S+
	jj2abC6fbgiFMq3eSA434TOyO
X-Google-Smtp-Source: AGHT+IFQE+PH0PmM1pimT6vM2pIPEUya0UWh7IaAgL2g81MnJ0RG9KhtPrnZ5Ff0hSKtqwY5YKQqkw==
X-Received: by 2002:a05:600c:1f10:b0:43c:e2dd:98ea with SMTP id 5b1f17b1804b1-43d5a32ce3amr134428365e9.22.1742948679566;
        Tue, 25 Mar 2025 17:24:39 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39acb5d0c33sm1881990f8f.26.2025.03.25.17.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:24:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 0/3] net: phy: Add support for new Aeonsemi PHYs
Date: Wed, 26 Mar 2025 01:23:56 +0100
Message-ID: <20250326002404.25530-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for new Aeonsemi 10G C45 PHYs. These PHYs intergate an IPC
to setup some configuration and require special handling to sync with
the parity bit. The parity bit is a way the IPC use to follow correct
order of command sent.

Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
AS21210PB1 that all register with the PHY ID 0x7500 0x7500
before the firmware is loaded.

The big special thing about this PHY is that it does provide
a generic PHY ID in C45 register that change to the correct one
one the firmware is loaded.

In practice:
- MMD 0x7 ID 0x7500 0x9410 -> FW LOAD -> ID 0x7500 0x9422

To handle this, we apply a simple approach where the PHY
is registered a first time, with the PHY driver maching for
the generic PHY ID (0x7500 0x9410), probing and loading the fw.
The PHY driver enable the new option "needs_reregister" in phy_device.

This special option will detach the PHY driver from the PHY device,
scan the MDIO BUS for that address and attach it again. This is
done entirely in one go at the phy_register_device time.

At the second time the driver will match the more specific PHY ID
(0x7500 0x9422) as the PHY now provides it now that is had the FW
loaded.

We can assume the PHY doesn't change Vendor or Family after
the PHY is loaded (that wouldn't make sense) and in the extreme
case this happen, no PHY will be matched and the generic one is
loaded.

Changes v2:
- Move to RFC as net-next closed :(
- Add lock for IPC command
- Better check size values from IPC
- Add PHY ID for all supported PHYs
- Drop .get_feature (correct values are exported by standard
  regs)
- Rework LED event to enum
- Update .yaml with changes requested (firmware-name required
  for generic PHY ID)
- Better document C22 in C45
- Document PHY name logic
- Introduce patch to load PHY 2 times

Christian Marangi (3):
  net: phy: permit PHYs to register a second time
  net: phy: Add support for Aeonsemi AS21xxx PHYs
  dt-bindings: net: Document support for Aeonsemi PHYs

 .../bindings/net/aeonsemi,as21xxx.yaml        | 122 +++
 MAINTAINERS                                   |   7 +
 drivers/net/phy/Kconfig                       |  12 +
 drivers/net/phy/Makefile                      |   1 +
 drivers/net/phy/as21xxx.c                     | 973 ++++++++++++++++++
 drivers/net/phy/phy_device.c                  |  27 +
 include/linux/phy.h                           |   5 +
 7 files changed, 1147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/aeonsemi,as21xxx.yaml
 create mode 100644 drivers/net/phy/as21xxx.c

-- 
2.48.1


