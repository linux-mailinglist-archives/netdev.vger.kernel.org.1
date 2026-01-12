Return-Path: <netdev+bounces-249112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8FD14695
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA79302BD26
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B7937E312;
	Mon, 12 Jan 2026 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0mooQ2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37AA240604
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239368; cv=none; b=cQlU9Na8KDuvqwKIPkzzDi5NHVEn7ELcL0W3tJBWT3pltwYvdg2w15xQj7LdVh3n4UftDzO0v3SOKUH1uH/vBmkO4nm4oVeZIa29o23dVrNLmcNmaXvpuvrQS2LL5wcxq5rbcirVGwddCJx1vNQr9WHReHmaLfKQvs0JW5f/KRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239368; c=relaxed/simple;
	bh=O+Byoxmx5aMFUn6zo/RCrmSirKIu6uGFmeSfQ28hT9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vgyb9hqZdnQTNnI3Q0uNf33/4JFZKQ3EEV8kjd5fikP8DtaSg9ON5LcbGzRjmR6UKbNshBcQ3bezwt+I5+siYg2IJcPC2KKVI4hQYQ+G8RtRul/vAuerhzccpEWJ3Yflny5aHcgeuD9HNB3RBGKjXINhblzueH++ZUkVrwVy4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0mooQ2s; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so63795745e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768239364; x=1768844164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ccwZkX7KOgsXzk4XTlSqSZLTxj9NHOK3gCOcjfYtLj4=;
        b=Q0mooQ2sSBLWEayWrPaXz+7d32pCMG3gxCofZ+EhEH8AdeulUEV5t8Dx09g3Sj6wqh
         2e6ZN9roEnfuH6AcFOSikA43vm/tkbEpipNhLDvuE2vdwQVh03He1mqTzEUfAYThKo4+
         5kpbD5aM9S5ZRPDg1mB+PolCzEthu4m7AOCPUFkiZNC/FKAF55PWCMEUI5GnpKS+mb2F
         MWexRnS7dQsJ7e7biOPMeqEGIED7/QqPw8Q4xlPuZas3Jq6G1GZjuDYdODJpfFt4W6AY
         LzLwUf6VbfNGJs+Hxg5XgGaK6QfoxIbFrUcSVJN65crhlNb5Kmnh9oK33JwVg1IiupsZ
         Msyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239364; x=1768844164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccwZkX7KOgsXzk4XTlSqSZLTxj9NHOK3gCOcjfYtLj4=;
        b=BWSdMKa/1Wyl1r7WHoY/pOye2Bl69/jU/CjbuvR7XkWJ2xzHigEzODDMfAF74aLycc
         PL1BhNugTgcsOy3lVBAzqNNu9RbhArtRNKbw36FWK6ewvrsoKrLX7zX5InxiPMkHhj3S
         FzK5Vo18SICkL13fNMWt5LnajcFqpqQS29sH7hVKBDaRL42iq5IXWFNh/Rd+KINPy1Mg
         nAFIP8JkZs06xRsclIZJjNyduxVgXBRux69P2Z0bq3IEMy+5XK6b9jKCITx3bujme956
         6qspnhvDyALRRVx+FDe59rHegkl3gf6HF0njksrDgo1YJGclaXSw59aIFepPmgi9h3N4
         TbCA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLD//yMmi1dsD/sblhiT/Um7SQnqLp2BvLFFAUHnmEqXk56J73YXkCrwYOCj7DQUg1irEVyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+44uidWMyqL32JvtpT1ERe0DfWaCzdxTUQHQ9NgybkYWLcW9
	hjvneorjSnH031CzBOte7pVEp4Gw7hAXfkIa1A3oKaOmEEJF1vucf4Io
X-Gm-Gg: AY/fxX6njnTTcWqyRJwqCDY0XXuF8YqW5hfxMI9j4eMw69cvztS82WPyXzWD670Y/LI
	FUHWSf8KOQLqXQZq47JYuEAATW6CAeI+MOds4fD7zkm5l+GTVJsUb4erqgIRgtdPO2qzL3XB36Y
	JWzH08n7UsgzC+5VoyNO+mbkZB5gnjYW2BmmVoQ8AqcS+eruOcKmoozljCDpu86uorU+DU4Q4lx
	/82AV4mPOH4/MqY/iBAE1JtKh9Wim2Qgp+VZhQa7OyvqVALFgjOw9uY1HsqJO3ECC5SQhqWiTiK
	y5hMw4NeKARiYvTRUuwzq44V01dM30TWBdDQKRneF+N7g8r+87XTGhLWyMykJYzI+xx1oo3APke
	fWBmNlS3X4aef8YiDYCk4hw9UFdCLDd2xhQCw5By0bMXZX4XWaie73NYK7FjLh/pz5jJzmG47ls
	AdOlisbyA60JYpMFiuXSc03vEbNNRms5D9yNVjQIfDKzYFiZ+KwKvE4eJCXzZ1d9HG4zHpaR0TB
	X9eym+mQBIhmOIoaDeRcbTS0aS1aVtyFzU=
X-Google-Smtp-Source: AGHT+IGd/dXpE1UekMm7fe2Y8Zq6LtE4qiSGPXepY3N31F28l3HQsMUDGb9MfgiyYpESAriyrrGkzg==
X-Received: by 2002:a05:600c:1992:b0:477:7c7d:d9b2 with SMTP id 5b1f17b1804b1-47d84b4a815mr228892545e9.32.1768239364058;
        Mon, 12 Jan 2026 09:36:04 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9336:b2a5:a8c1:722e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ff0b2sm39625403f8f.42.2026.01.12.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:36:03 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
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
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 0/2] net: pcs: rzn1-miic: Support configurable PHY_LINK polarity
Date: Mon, 12 Jan 2026 17:35:53 +0000
Message-ID: <20260112173555.1166714-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This series adds support for configuring the active level of MIIC
PHY_LINK status signals on Renesas RZ/N1 and RZ/T2H/N2H platforms.

The MIIC block provides dedicated hardware PHY_LINK signals that indicate
EtherPHY link-up and link-down status independently of whether the MAC
(GMAC) or Ethernet switch (ETHSW) is used. While GMAC-based systems
typically obtain link state via MDIO and handle it in software, the
ETHSW relies on these PHY_LINK pins for both CPU-assisted operation and
switch-only forwarding paths that do not involve the host processor.

These hardware PHY_LINK signals are particularly important for use cases
requiring fast reaction to link-down events, such as redundancy protocols
including Device Level Ring (DLR). In such scenarios, relying solely on
software-based link detection introduces latency that can negatively
impact recovery time. The ETHSW therefore exposes PHY_LINK signals to
enable immediate hardware-level detection of cable or port failures.

Some systems require the PHY_LINK signal polarity to be configured as
active low rather than the default active high. This series introduces a
new DT property to describe the required polarity and adds corresponding
driver support to program the MIIC PHY_LINK register accordingly. The
configuration is accumulated during DT parsing and applied once hardware
initialization is complete, taking into account SoC-specific differences
between RZ/N1 and RZ/T2H/N2H.

Thanks for your review.

v2->v3:
- Updated commit message for patches 1 and 2 to improve clarity
- Renemaed DT property from renesas,miic-phylink-active-low to
  renesas,miic-phy-link-active-low.
- Updated references of PHYLINK to PHY_LINK and phylink to phy_link
  in code to avoid confusion with the Linux phylink subsystem.
- Simplified the PHY_LINK configuration parsing logic in the driver
  as suggested.

v1->v2:
- Updated commit message to elaborate the necessity of PHY link signals

Best regards,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: net: pcs: renesas,rzn1-miic: Add phy_link property
  net: pcs: rzn1-miic: Add PHY_LINK active-level configuration support

 .../bindings/net/pcs/renesas,rzn1-miic.yaml   |   7 ++
 drivers/net/pcs/pcs-rzn1-miic.c               | 105 +++++++++++++++++-
 2 files changed, 109 insertions(+), 3 deletions(-)

-- 
2.52.0


