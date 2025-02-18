Return-Path: <netdev+bounces-167157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCDA3906F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05EB33B2039
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4B5839F4;
	Tue, 18 Feb 2025 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K79MvNZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA755749A;
	Tue, 18 Feb 2025 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842630; cv=none; b=jH4Qw4BXLvnH4XZSpPiBODXx1bjiLENzKJI0Mns4ZfEJ3U6D7+m3ZSuuDS8anqmgiuD9YiBr+HCXttG8lLuZVnc//3EiAavrIYlnQdkOXql6Gk2fW0uQ38VhjpDfGdq+oMHnZNmFhmFI2J7mPPmPhcQ+nR1i7Ygn8bh1KE2Z5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842630; c=relaxed/simple;
	bh=Golq5pOJ58qCIOwNPQcEKKn19gMS2LOuoLL9GpvdL0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4H52eCymkC5o05grhx2979yZnKeg1ySQFhv3DIvfXvZYXfVwcJMX7VnJk/8XqO+iLAdt5hmxUDPM+Y6wc44UNzvcDVP4l7hw/Y0+H5Kr4kBmahMbVtnEXaqpiTBnH4BaJWl2oRCICiGBXEuMvwEuiS5XT5ob0JlYAIU2g7JxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K79MvNZU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220c8f38febso88502275ad.2;
        Mon, 17 Feb 2025 17:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739842628; x=1740447428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8oCl2eTznyqUfjq2trkNMkws/7opLjRL3jZAvLRiyE=;
        b=K79MvNZURpFMSTiQhrHVQqcofFgqqvHxpxRGWNMLMAwRnnlh2g53+k3+GZYLQkssnN
         o/qX+8+AyjfwjcVg8il4e0ukQtYXCnhlGvv9vZdJKqIyhSCx+GEjw38kPPuYwR3Fkax4
         goa8f1D2FlZS7t7JHnMw0GZpBA2E/IF+N4hUy01EM1gxgFgC4kdcsau8zlxtBFDk9ksS
         Sf3upwK99LYEsEOqdWhUASI8ayluKEggV7B2PnxOSqTJ+4QCwh5723N/7sey9NLqZxMa
         QYZSVRy+7JU7XSHgtCFTssjfgY8xMl2egae/y+38lk60b1steVelkhCuzpO64oI/JCOc
         5Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842628; x=1740447428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8oCl2eTznyqUfjq2trkNMkws/7opLjRL3jZAvLRiyE=;
        b=sthqpmwMgv4oxblS8k5dyJP6ke4pXKrhzAZmOORbMGP+x+Ic750NQpjmhm/4y2xbgp
         QqLPLgCRxGaHA7it1LsYtTDOmrmP+7CBLJPJ+26GtwE49l9b0nkQBkeqM0B++BpX5Q7k
         psfLA2dbsSgbKJvji7mwI8varYJTLROS1dWAqPhGTYcktwHMJ2yiG1yX6MHIQAEAPtt1
         x0xrXQedAdtIoqfrGQr9tX8tP40I9MWf66h0eZVz/EEiwKqThvcXxRiGfqD33/Nrhu3W
         AjxRMQCfPr5YU2Rvs3ML+7v5YO3nXsX4eeXnLWSl7ERwe+MZUJqKqtZb6R49KdbHB81q
         t+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVB4jCt4J4QeGFbE1fSbsdy3UObOEzIgAKjKFsvodxNS/3XLphYnXNnFjQkcihaVwwBhkyJN3br@vger.kernel.org, AJvYcCWH34T0ebpHfvIFm2KvrVadSqrpInDyUC+obIFz5nqxO69XMDalF08p71zhk7OE6s4qAv1VYavcGPTttZNH@vger.kernel.org, AJvYcCX050e4pL3YMDe7x12A6xckEbXAlpazqYMJ2bWr1TND3aiGwxieB7dpCsYaYT591WULxD/eGdvCRjNv@vger.kernel.org
X-Gm-Message-State: AOJu0YxPbXJ800aerIqYpDQNjXBY+04eNzot3n4gnDSOQqkO/e78148M
	JDSkErW8iqIPGUq07N+qh1dAmQLkrK32vLBkvFe9uW9ot0bqszQy
X-Gm-Gg: ASbGncuLPQc/vFFp1wFIFdMe1Lv9V9cmgMxh6Lwk55y4taLmLiGJIohbpox/l5MkHlt
	MvPsGtSW6tiPJdYgglnTb4LMkcvHByeIduN0oG1Xusmi1xhWUjseotDr7LO6sG00fHYuANUyoXX
	dhOZVROOJ59wLfiv32OMjQ9Uug+0dXMmrNE489K3GBEzDpy6yuQaQAU+GiuvWLB2RKRF5P/WUp8
	yNf2cWqz6t6OpXR9On1Yr4rsBtkL675o5eZK7nzUBbXgQfAO6jgAPDxNSGv40tadybml8u9gPny
	w/z4hokuZS/pk/bVSmCJsbY78keGKi0QIg==
X-Google-Smtp-Source: AGHT+IFw4wjOLV7f/83aAUDs6sD+FtKdvlrf1ER+lB8E87lZWrU0/9p6Lps0nDWdfZdRoS83Aw5v9w==
X-Received: by 2002:a17:902:e841:b0:220:ca39:d453 with SMTP id d9443c01a7336-2210401a692mr197817165ad.17.1739842627918;
        Mon, 17 Feb 2025 17:37:07 -0800 (PST)
Received: from localhost.localdomain ([64.114.251.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d4d8sm76910165ad.170.2025.02.17.17.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:37:07 -0800 (PST)
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
Subject: [PATCH v2 0/5] net: phy: bcm63xx: Enable internal GPHY on BCM63268
Date: Mon, 17 Feb 2025 17:36:39 -0800
Message-ID: <20250218013653.229234-1-kylehendrydev@gmail.com>
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

Currently the PHY can't be detected until the b53 switch is initialized,
but this should be solvable through the device tree. I'm currently 
investigating whether the the PHY needs the whole switch to be set up
or just specific clocks, etc. 

v2 changes:
- Remove changes to b53 dsa code and rework fix as a PHY driver
- Use a regmap for accessing GPHY control register
- Add documentaion for device tree changes

v1: https://lore.kernel.org/netdev/20250206043055.177004-1-kylehendrydev@gmail.com/

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>

Kyle Hendry (5):
  net: phy: bcm63xx: add support for BCM63268 GPHY
  net: phy: enable bcm63xx on bmips
  dt-bindings: net: bcm6368-mdio-mux: add gphy-ctrl property
  dt-bindings: mfd: brcm: add brcm,bcm63268-gphy-ctrl compatible
  dt-bindings: mfd: brcm: add gphy controller to BCM63268 sysctl

 .../mfd/brcm,bcm63268-gpio-sysctl.yaml        | 13 +++
 .../devicetree/bindings/mfd/syscon.yaml       |  2 +
 .../bindings/net/brcm,bcm6368-mdio-mux.yaml   |  7 ++
 drivers/net/phy/Kconfig                       |  4 +-
 drivers/net/phy/bcm63xx.c                     | 96 +++++++++++++++++++
 5 files changed, 120 insertions(+), 2 deletions(-)

-- 
2.43.0


