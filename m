Return-Path: <netdev+bounces-172306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE01A54220
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482ED188AF5F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BC819D09C;
	Thu,  6 Mar 2025 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUvxcT62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0B63D;
	Thu,  6 Mar 2025 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239110; cv=none; b=jPQvvmV9nxD6wV2hvAR2ZTTOAA19/ggRpTC73K1K1PBfxDDNwQeykg/kLc7F+sKIaFmB11oo7LWOYFOfPiM9viQ7uqvK3UfkWWOU8qkDUGySqF6TQKCbzN8xXZ06nITKjFPm2Id0jaTuYJf1Klk+8ATPYMlprszd9OYR4u79pQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239110; c=relaxed/simple;
	bh=21+dOg3I9fKF3EHjdpUkxu22MliBZ1fbqSNwmAHh6lY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sBL3SzYzSV9P1NVyd7aZlEZeXko5nQuWk8eJVEAg1LQPm8i9I0qUp21Aa3PeysaSLT6xLBMSG/fbcJjJ+6WKbPpAh4BblNdtVDIUURXxwVhggSW3tTjjMhKUzDsPmi1L9lMoEWHKVytRHILvqNSTUA6vA/Zfc1wytEG5Vh6eMUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUvxcT62; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fb0f619dso3899955ad.1;
        Wed, 05 Mar 2025 21:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741239108; x=1741843908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XPV0znL7nz58O+lW/24l76muS4jiliyuI22DsAMYv10=;
        b=UUvxcT62EYVhzpBOFz9WrxaqFc02utnlKQxlsKizFqjZDLs2eYJ1K0sTpTpZ1aLT3L
         cdMsNK+ForZWdxcXs2fblai6sbknwCBFLlpNfaarlsJ4Syp3L9iwSIsMb0NVEaLHalRh
         Q4QGFfzq1LWp1+TfOB/mNusBlrsntDZL7ye7QTwE8aQTK0bRJHxsZ+FqeXioioR0l6cE
         9DvRid15RYoG2w1LCG0pkE7COxwiFFQkfaOazBw6EY0UGy81xUD3u7DSKRIAFRApy9FM
         +3YZjTEn/F659I3FnzHfXJQF3hx+Ec/GO5qV4koH3kTDGjDYzSGSLkl3XcWIJgeQR4qB
         ElxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741239108; x=1741843908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XPV0znL7nz58O+lW/24l76muS4jiliyuI22DsAMYv10=;
        b=wLCOsL5r004n8Cus5xrdrSjoSeRzkcvpsUOEZCpYZTsEJlIfmUmqFG3PwGG748RgCI
         ZC+Yzq/yrVoO03RuaPxPQY3yf1T0e/cnggFHNqloc/vqiNLBEnkdagUk10KjwVhbeVJn
         +DlgT5338hf57WTKITKZHehO2/eAi5r87i/j9VY3zKbFxyvlPNVbbfL50tN+K9o1y1o3
         ZRAhD6iLC0kvI90TWeR1/U/i1o8GL4k0RAjoYb3JppHKCzNfw3czRlpFdcczcml8McG1
         1IyOF+ca0ZPztXqk1kQrofWBsUgTS8LMC75h3d511y/siJM0+ta3GCmx0Mlv9J4BFOTQ
         lsAw==
X-Forwarded-Encrypted: i=1; AJvYcCUShSJ4YysfKUNHv2WsBpWiZ1y/hYfFWdv/NYz7G5sV0pE6eHyFMrBHMOUfCOtQoUZKG6HFYg9q0C5pU4Ip@vger.kernel.org, AJvYcCWbuGZE6UPAJkPEt3zmBlGWC0bMm1jgccrNzx/B0/YLsQV3Yi2d6T38VIkvxntfHAHNINYnj5ON@vger.kernel.org, AJvYcCWiJvbKSADIdsZDYZ6hX/OAuoJqbV5Ljmik5hXD1cllRFYiLgk/rEwMEALk+VqofG8IRX5IrI+JTUXE@vger.kernel.org
X-Gm-Message-State: AOJu0YwdAu1+tUd/MH8akz2lACHnj+eSOOfN39TMBYh/1hcduyCOFr7z
	trcgmf2kxPQFkpW1SO7mGx/eKH9VN3/Wz1ck2y5XTQdO4xLEJ3XSzsWy2Q==
X-Gm-Gg: ASbGnctc0+NNt/DYLP6tmNS5iKXa5JYjAMGUExFExDlobojmzBtfBYAV9m5scphvbtU
	0c6uTUqsgCStcms6kVKOZApjmTX4vv8+6b/5qySrJF5PusJrhc3B31GaQ2EcjaHSJuf2gmqwilW
	4HpmcZFMZtWIgqFRyTmseGJDYl3SJ9igZYZ7VqiJ4VE3goczx7XY4qXBEn1eULgm8Qz0EZO8nqG
	g/4LhDneGs2RBMXXiMbIEgdhR6Z/353QZsiOsSdnKDRRcNAVpMZLp1NELZxQ9+T6AxegfLaY3NU
	xPosFmT12Ro3uCdyko/1W1xa7bsVtWtVGhHDls6vwXoQyWIUBRnQv/+z9TPgSQoz
X-Google-Smtp-Source: AGHT+IHhjTnrYo8BFZpFqMB3SZ/0bD9Efdlw+aOVV9ml7zTFUgtLO0KPb2PzcYfEpCkJ+sbXFwnJOw==
X-Received: by 2002:a17:902:f683:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-223f1c982c4mr94308325ad.21.1741239108322;
        Wed, 05 Mar 2025 21:31:48 -0800 (PST)
Received: from localhost.localdomain ([205.250.198.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm3470045ad.243.2025.03.05.21.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:31:48 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Wed,  5 Mar 2025 21:30:57 -0800
Message-ID: <20250306053105.41677-1-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BCM63268 bootloaders do not enable the internal PHYs by default.
This patch series adds a phy driver to set the registers required 
for the gigabit PHY to work. 

Who should I list as maintainer in the schema?

v4 changes:
- Remove unecessary checks
- Make commit message more concise
- Tag for net-next
- Add include to schema to fix dt_binding_check
- Schema formatting

v3: https://lore.kernel.org/netdev/20250228002722.5619-1-kylehendrydev@gmail.com/
- Remove syscon for the GPHY control register
- Change driver to access the GPIO controller syscon
- Move syscon phandle from mdio bus to phy node
- Remove unecessary devm_phy_package_join()
- Made functions static to fix build warning
- Fix formatting and whitespace issues
- Add schema for PHY driver
- Deassert PHY reset signal 

v2: https://lore.kernel.org/netdev/d819144d-ce2f-4ea5-8bfb-83e341672da6@gmail.com/
- Remove changes to b53 dsa code and rework fix as a PHY driver
- Use a regmap for accessing GPHY control register
- Add documentaion for device tree changes

v1: https://lore.kernel.org/netdev/20250206043055.177004-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (3):
  net: phy: bcm63xx: add support for BCM63268 GPHY
  net: phy: enable bcm63xx on bmips
  dt-bindings: net: phy: add BCM63268 GPHY

 .../bindings/net/brcm,bcm63268-gphy.yaml      | 52 +++++++++++
 drivers/net/phy/Kconfig                       |  4 +-
 drivers/net/phy/bcm63xx.c                     | 88 +++++++++++++++++++
 3 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml

-- 
2.43.0


