Return-Path: <netdev+bounces-170464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28DA48D47
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682AE3B7F95
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B9D211C;
	Fri, 28 Feb 2025 00:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVFELRzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE9C1C01;
	Fri, 28 Feb 2025 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702465; cv=none; b=f5VyykWzD+OnxpwmMHgBtYUaYhnLMsOsKZr4TEbFoFJ2KDQ23Cs1zNNm3QwoeDJE12T//Psfq2L4VpwgmUUVpi1/jm3xw2dTjNjBc8I6iyhi4YV/xOzKH+6gvVZhi1/dD3tCvUGxw7DwAxHUAQsJwO2hS/L7H066E/Hjn6EEAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702465; c=relaxed/simple;
	bh=usACp1Fytu0FQ82mCfBBWBEi7F0eED7aci1NMNS2fJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/z8ozwKL3iRMJxTSC5biRZk8oGqdePsRGhSC76kSvtJ4B4zg1pWhrGWGWHsNY8P8+WwdjbnmOKBQilqelqJgWIm4fLC3SpMAfvggtgmj873Gwuzx7H3pJbTxyrTRXMrbiRWtta0M8bCPaT0ODghHUbFUKm6BR9BWUyyp2CMFRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZVFELRzW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f44353649aso2555306a91.0;
        Thu, 27 Feb 2025 16:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702462; x=1741307262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOGpWEpFZoFhnnUL6vRF5rCZdZE128rFqODXlLPLjyw=;
        b=ZVFELRzWILPzPGN61977kZc1X6ND+/fvYiOAjFuvlDSgKW7W9y/mv6cGMRVwsHvNZn
         IjI/RvvAG6jjt+Y8awhesIvB8L+F+uusEMX0kEuslg7qKmTcWo6h9jFRb0wSl54nd3Kw
         MUmjsAXI8Qu5X2EfcZ6/OttJDDkLI2c9izAJ9EjbenzTpMSl3HaK7cRX8uwEVpnkoy/v
         aIFd9FM2x5yGPqRM4OnqI6HkUgo+R/SJ7ZXqk37IiC41nGtuaHFy+WUyN8GAddVeW+YL
         PVChLbLYvytBvWmzJ2szCAI4LWUnI8a1WX2mP3VvEtEiT3K6w1pLM1R+khyetfQDKVUB
         6IrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702462; x=1741307262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOGpWEpFZoFhnnUL6vRF5rCZdZE128rFqODXlLPLjyw=;
        b=fxPJhYmzA6Zu1B8JsyX1Az1ovdYCf/QMlMBROmNWHx2MhPqrQZwOW2NMc6mQpvfdr2
         OsDxNzDMey8r2KtB8LisKXxKI7JFVxNkBq4N1v2j7qixwLmtAMofU8YgNvVf72YHA210
         uILnFMHuQd/jc2B3jekWb01V3uRB5hEo2WC8KCjkKR4j8LffYgi5w9e23FVu7GbMLzzm
         Drep50opFwlwEuA+KXvTnRqb5vFMxhks31eZUDMHffLITCP00LDnm/+9S1zutz6xaYtU
         RskVleTScVu4L+hdhbg/+NChnXtWe69XTKmtZeP0u5hBGBGZtbH+00ITeU/rvj8k39jB
         IWhg==
X-Forwarded-Encrypted: i=1; AJvYcCV3t1a3NIM0o6mmR/mSXWyi7tGo5sj9z9JJ2J9/o5qcOCnLCokKFdPatNuQPYKk2MmsLArCTm1MiXVA@vger.kernel.org, AJvYcCVJAIPSFHwrsFriGGlucz/DERaUcYHMRds1kaZtCGnucjNPi8ewOtWW51/ot2kqA3TUlQtq+oApvra8nXTm@vger.kernel.org, AJvYcCVJwWilvkbN8obE6wt9wKGatmKDeYWOmncDYj3OLd0Ly7OwPMgulAC9rjZlsV1COuXZ3P7NtrhG@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAkjjyq9YezA7MOmgxkTtfdIQy7A5vct/6qHGXazyB38cQkHr
	f4jlTxpyraJ9lp3V7UxSfzT363khfxdBaEZ8wrXWQrv1lOBkWlvx
X-Gm-Gg: ASbGncujbebu8JZu3oWk3CG0xscAGndZOr64Da8kFmsGZe42Cmvux3VNCAwtkA2WTPP
	mZXuTc6clKFWTqr+oUFtKUZt8PLzgDinVKrh+jtf8/v8SDnmZCXT481S+ol/85zhJt63k9zlUy9
	g+xagE0i2eZlPBbrVInpEVj9EWtsXc9/gYdWDfZMZ5o3G8dhV+zjRR5fJ12hXf2iBSr0DtvlnDV
	uzK9BGksckbhJVjZxNGo1EnXRpjeltedIBEbXreTPfIeyP6TB9YUMxSwF7AMlSqYaF6Kti2qO4g
	MoZDfFXa9HQelrkwP+wag0LNx3C0VHp7004dP7a3D6eULg==
X-Google-Smtp-Source: AGHT+IHXBBC8ljYes/EltY6ClB6ux2PJGByCqbPWFjPc825Ynl4CDOt2cR5oNI8bpcyHrhbht4aknw==
X-Received: by 2002:a17:90b:4b86:b0:2fe:b5d1:dbf4 with SMTP id 98e67ed59e1d1-2febabdc2f9mr2285289a91.33.1740702461989;
        Thu, 27 Feb 2025 16:27:41 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe82840e62sm4511094a91.34.2025.02.27.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:27:41 -0800 (PST)
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
Subject: [PATCH v3 0/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Date: Thu, 27 Feb 2025 16:27:14 -0800
Message-ID: <20250228002722.5619-1-kylehendrydev@gmail.com>
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

v3 changes:
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

 .../bindings/net/brcm,bcm63268-gphy.yaml      |  51 +++++++++
 drivers/net/phy/Kconfig                       |   4 +-
 drivers/net/phy/bcm63xx.c                     | 101 ++++++++++++++++++
 3 files changed, 154 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml

-- 
2.43.0


