Return-Path: <netdev+bounces-236758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F30C3FB06
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6073A3A25
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7769031D366;
	Fri,  7 Nov 2025 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImzEP5X7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069D02BDC01
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514258; cv=none; b=WrpRdoYQDTKTGr1SjGBCHZ9xbR2vpqK3lpV6jGKVVKGweCqzZBGe6cr8On0sbxFj7o9xWM1SvW671FOXKCsUlrgeYzzFULYCgjtGUPo9bkXojVCNPTPeNTis0vHnvUyQmTrw309boe251Ez1KkzR+DE7v3LNGcFLSCyGXAY2qOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514258; c=relaxed/simple;
	bh=cSppAl7ekFmJZsAY8PhVJr/WleO/l+2uOj25qvFGNsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgpPfiHMLtmrhI8OxmFxZwDuW2VxRV6bieDqixpGPidgRAQDZjpSG2iTROb86/wiGjHyD1n9zWe54W3N5/ZZ0gUtcgmyOlH4AAl6K6iZ85CVFoEK6OZu9afLUfoBvPzi0BKYOp4DqzumHv5tilP4siWgcygxDB9kgtriajjW0f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImzEP5X7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-294fe7c2e69so6955915ad.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762514256; x=1763119056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LN8J2MPpiqnkZZeP9rMuN2R02piDWN78Q70NiOhBpfM=;
        b=ImzEP5X7yoirKelNliJZtxUjuJhV9o+D02y2XvuslJSStHCPfYG4KLC/VHpXYP/t53
         BBZSF++lNH/R4TvR2RmCdjIMOO0YsIQl+3mOGZY9W/vwfmHEN17esibqoifO+KupnNV5
         +EEXX7m3X5LstBcu2EGM8BJ7DRH+ZuWWYWXDwRwjGBO2PdkXbseuIpECNJ/OEXfoqerK
         GZDKwNEAHwhnTB3Yn4KeagYuQJyMddtcneWKuo/mDdM0w5a7v79XR2BLTC91FqaIc1FM
         YnWo5RbTXMHHgboRTvkMKeUNzndMJiPBAVaaCvXeuJY5mIz3uSBe77R6k+9fIgJGIBkR
         7GnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514256; x=1763119056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN8J2MPpiqnkZZeP9rMuN2R02piDWN78Q70NiOhBpfM=;
        b=TDjTeN04S0JPQFZsqsYATQdrBlPuOC9RdOnpNLuwzwQGjnr63QSonzyoRQR9y/gXNX
         zhJahP9B/mwxtEnEA0c/JG0DTicHLyPe303plLo14vaej5kq5Sgys8cB3x8xyoiY7vKA
         6w3yeuMoIk4gwkvbUhLXlkHCU4BoxnsqW5dT8YH3Qy6vI2xe9TKXPA4r8LcqaUVDaTJo
         IcVwwmsLDeUDgNTElv6v9PDhaFDvUc6KDZRIodyW1NXumzdHoZ69amu7IaPZXGlN0EU0
         tVturg30sWr9uuK1EG09/CsIE5r/4Nh/2c/Ov3UBPTNJ+4V81xRm01Z7KHFDOQDqZuF1
         JIrA==
X-Gm-Message-State: AOJu0YxPhvqUb/CsGieFiJ/+uadDZRJ3Oow5psZz9qwQ0NXyAG0cNA7N
	7sCjrpKCa3s9aZk2GbguskD594n0n95SHRSUPzRHvcKezvHMp0STKVL+VzS7BA==
X-Gm-Gg: ASbGnctvSbjSU2zQF4sr2K0mqMYksXUP8AHaqpo7N3jtwWYV5SWBjF2vH6dSDbjoLpp
	OI6K1m2Fm21AxG4neiyMzNc5dNSnSVe1gZSF4PQ8NjTkuyYIWgHW60KxyCB4M7b0Wkkj6rCaJaz
	bkT3LfIgw0Wx/Cq3QCo8AnAUGarQgSBxyzbQDOCWJNUyg5+rEZMNDcvb8avYczhSySvzY+7CSJB
	BlbnukLARLjQngrAHeLXZFIvoz9mETAg6AwzmQsOEL3xOFAX4HgGUqoKKyNJn2ued80X7xkrmXl
	mVmuxo5uWxMngHKM39m4tI93LrqLBd59o0fZs2rMH1NOLaEbDu2aSid/fcKb0oXM4dQKl4ZoRQ4
	xByG+aXm3CNDHpLNbJIN9wIleBCKElIci/kTtpjAcpqzcEOvs2uVG9sAmYjxBiPNZg/agwYyb72
	Vid14e20X+ug==
X-Google-Smtp-Source: AGHT+IE6dkmZ1xSfeQ8gFlQLsPa6AwKU7ATxDW7ucEzzW+bfiWTWRF3rzrVJ+aYG0hm2l5jNpYpSqw==
X-Received: by 2002:a17:903:19cd:b0:268:cc5:5e4e with SMTP id d9443c01a7336-297c0386b92mr39537185ad.1.1762514256178;
        Fri, 07 Nov 2025 03:17:36 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c6f6cdsm58791375ad.71.2025.11.07.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:17:35 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v7 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri,  7 Nov 2025 19:17:12 +0800
Message-ID: <20251107111715.3196746-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Since this delay fix is common for other MACs, add a common helper
for it. And use it to fix SG2042.

Change from v6:
- https://lore.kernel.org/all/20251103030526.1092365-1-inochiama@gmail.com
1. patch 2: fixed kdoc warning

Change from v5:
- https://lore.kernel.org/all/20251031012428.488184-1-inochiama@gmail.com
1. patch 1: remove duplicate empty line

Change from v4:
- https://lore.kernel.org/all/20251028003858.267040-1-inochiama@gmail.com
1. patch 3: add const qualifier to struct sg2042_dwmac_data

Change from v3:
- https://lore.kernel.org/all/20251024015524.291013-1-inochiama@gmail.com
1. patch 1: fix binding check error

Change from v2:
- https://lore.kernel.org/all/20251020095500.1330057-1-inochiama@gmail.com
1. patch 3: fix comment typo
2. patch 3: add check for PHY_INTERFACE_MODE_NA.

Change from v1:
- https://lore.kernel.org/all/20251017011802.523140-1-inochiama@gmail.com
1. Add phy-mode property to dt-bindings of sophgo,sg2044-dwmac
2. Add common helper for fixing RGMII phy mode
3. Use struct to hold the compatiable data.

Inochi Amaoto (3):
  dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
  net: phy: Add helper for fixing RGMII PHY mode based on internal mac
    delay
  net: stmmac: dwmac-sophgo: Add phy interface filter

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 19 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 84 insertions(+), 1 deletion(-)

--
2.51.2


