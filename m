Return-Path: <netdev+bounces-167162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225BEA3907E
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6D6164EF0
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E5D1A840D;
	Tue, 18 Feb 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdgoGRjP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFE1A08B1;
	Tue, 18 Feb 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842642; cv=none; b=MiNqN3xv97UF8AMHoxaOANUPOq5+GV63krOONoZFUProvlPzA8vU0sVa20EiIYYbjH5XlFBgpjIfDJg/0q1XukMydm9Qy3TqLU7nhDAKmiWF2LK96RSKHH1rPyjSe14Eon/kFy4CK6hEBmTSFFok1VPmyO9X4Y70G/ryICyzT08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842642; c=relaxed/simple;
	bh=wp6fErtgRQAw9QT6alD2YZKiQPW6JyirNIZqxzsplWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8+IBkUxScMAiBrHhLK4uE7Q3pDBY6riurc/13MC/bbWR2VNzSWCvb6MSYfjC/N8aUkO0aOIGgogYB/Ia+T4fxY7yMax6bVRkaefB9R52Q6HYpvLykHmMwak72KUhNEJ7vUVeGWt7QozAiqOfLXk7RttM7C95UNeO35mnYfKgdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdgoGRjP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f048c038so59327135ad.2;
        Mon, 17 Feb 2025 17:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842640; x=1740447440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKLCDKY+mHeKsXEoXryyFkORSM+PA76Iv+i/R/w7Bcw=;
        b=LdgoGRjP3Eny6jh9y4gU4GMuzqGpssxrHw64L0X3HPzqSb7+W3L12Z202Q+WvQiitO
         gB88Kzo7FPb8EgpNeGtQmCPNEJV+e/TeJYyomxrOLbfHT9EXYXENBGKQCYHwmMuraOTO
         bMXTaNjtDb6IV5Pql/NMLAvUTX9L8rd5jttPEnElgb696ZBnQ3kdGxMDCavKqplg2/Sb
         hD/kS33mNv9Lkg+BWNa/c/yeKM6+lCPyDfkXu4CWgLcUmCzTPAFYsx6+JT22j7YPfHSH
         i4w8W/28M7wWIprOn66dMmx84qBiWVZ9+kpM7LMfkvoUisL3TTgRRmHamkVzeB0jtn1P
         0+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842640; x=1740447440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKLCDKY+mHeKsXEoXryyFkORSM+PA76Iv+i/R/w7Bcw=;
        b=vEdSM0HHUJmdmTFNOofZbuZe4KP91C27SRCBw8kHAEpGOUmCx1AvAObMF5j7Y4xZM+
         xi7kRzh6npeYUeGMqzJ122TLQPiKp+4rCFkjetd8vGzCSnQCeW+vPhWwA8eb3PJgU5kW
         qELbxwU0hSXUg1f8vM+Ix6L8sGHpslZgks7k/QCtK+WWBb7tG4y1/1UTCLwml4QeB2kc
         8ocf6TTU4k4ASXENGRfWkSC27E2aPH/GadnR4nHmvKlpatOfQGTb0e6dp6JC8BgBP44H
         nXaI0+UV9x316djI6nBCOO/vQGOrHytRa7bct2HMZXQaSXfLKzNQ1bFCbSxEce2jWdzQ
         Di3g==
X-Forwarded-Encrypted: i=1; AJvYcCUNpRZm6zsmP9EfCNBfTRpjd0N3DZvR/qHjcm66kSriaVszf0TBkOfTVEgA4yRGm9pYLcPXP6niwmgQX862@vger.kernel.org, AJvYcCX+8rkRNNths2/uVZou/PKAOYKNVrL81yKqKtyvaKfquubb43AbAl9ud6fem/wK+bt7ta2CpKe/@vger.kernel.org, AJvYcCX1dcNrsYgwJAWxUeLZtPJEwTjjnq2ii5rt57i1qO9WxffOpVtma9nkG/eka+4FhAhPpJlLW3CbOSyo@vger.kernel.org
X-Gm-Message-State: AOJu0YyxhE7LFEslACF3U+ZL8ZIvvwND9sXaUu+JMtAe9mLyEMNxwlTO
	/y05769GWbWwcQe/vpycUXkOxvO3gAG3NL+pkv5iOgFkcCR4byn/
X-Gm-Gg: ASbGncsOP1hE7z/VL30DlPuzKVllcU9PieaYw4ZeiXT2/CyxBB7GgyukWiwRQuillgB
	EFaeXBNybQsQ6Zxv8H+7ZNDY5Jpv4vvY3vf/94/s9jm73slMERTCD2pS5PIArF+ESt9sK4wkWZo
	viBq18wyY8RJVGSSwwPjP9BEjD1yeuu2RxPCSbZxDrFoaYLlVQtKrHPBjgQVPkeAB+mCkFbD8UO
	VSmJc9jHriHib7b8GgBXoyK9ksLzCnT5IdgC5Nr0M8Zv73zx+POnydrYPbcVSURReQura//pJJW
	sOc1R75LSM75girXjZodaTnKTz2ZoQzXwg==
X-Google-Smtp-Source: AGHT+IG6fuy4M3/uT1eijsCyZC0kZPunvOKQvdJWWuzg/1lXp63eqJRL241hIIWx/62ssxvn9TCnsw==
X-Received: by 2002:a17:902:ebd0:b0:220:be86:a421 with SMTP id d9443c01a7336-221040a9b15mr153229775ad.38.1739842640126;
        Mon, 17 Feb 2025 17:37:20 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:19 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 5/5] dt-bindings: mfd: brcm: add gphy controller to BCM63268 sysctl
Date: Mon, 17 Feb 2025 17:36:44 -0800
Message-ID: <20250218013653.229234-6-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218013653.229234-1-kylehendrydev@gmail.com>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for BCM63268 gphy controller in the
bcm63268-gpio-sysctl register range.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 .../bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
index 9c2a04829da5..99610a5f2912 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml
@@ -50,6 +50,15 @@ patternProperties:
       should follow the bindings specified in
       Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml.
 
+  "^gphy_ctrl@[0-9a-f]+$":
+    # Child node
+    type: object
+    $ref: /schemas/mfd/syscon.yaml
+    description:
+      Control register for GPHY modes. This child node definition
+      should follow the bindings specified in
+      Documentation/devicetree/bindings/mfd/syscon.yaml
+
 required:
   - "#address-cells"
   - compatible
@@ -191,4 +200,8 @@ examples:
           pins = "dsl_gpio9";
         };
       };
+      gphy_ctrl: gphy_ctrl@54 {
+      compatible = "brcm,bcm63268-gphy-ctrl", "syscon";
+      reg = <0x54 0x4>;
+      };
     };
-- 
2.43.0


