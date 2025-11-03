Return-Path: <netdev+bounces-234932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B047C29E8C
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 04:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A17B4E82AC
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1B154BF5;
	Mon,  3 Nov 2025 03:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN48o2W0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7671A7AE3
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 03:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139144; cv=none; b=jwYN2QJB1N0Ew27VLWetDY26sv7duVUcHuDNVrSpHyqpV8yVfu0rSWAZ0z18nGGQHEbi8ymL2dCjLkit1RQfofrep75vTqtOPmNQ7Uq4ktM1EPlZsZnDmiDzLUAhy/B/ywWn7jf7CWgPEOBWBGHxS8J0s0HXfVY1YLVHyxMU8s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139144; c=relaxed/simple;
	bh=0som6ehbnOrZUCiYGu7DmOQpitEQpLK/28RN7gfEbIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z42TJa4bN8CBbpRo9HHN2jR1gAkPwLUciNLL5AM5K0r4ufWjSmxBxcbXy7ZBPYyW1HX+knqZVyfbzA8xaHy8iCcKIy+J75LRbuIepm0ZFHlCwXF/PtjkwhKHVBM9k/JgxNzTMGNyPz9UVE7HkTWyQc13bvS2o33hJSAiFaql4XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN48o2W0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294fe7c2e69so34157445ad.0
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 19:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139143; x=1762743943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf2MtafIziFxv0+iZSQBAt6orU3b9FFBk8saiJeqI+U=;
        b=KN48o2W0KeIoGD0EwyVQvCypK9CxITQkktS6a4J2RLeF8LUaUB7LHQXvV6szbqauDq
         D+Ebhr7Vj0nZG5uvrCvP12rmJt6RvbLmOYtZUDEU1+iwWNC7u0N2e4ZeKE8b+MPTS0S1
         jTIO8Kt6lYux40PYurWOPOqaTs2QhvxM+wIDLD3GCHmrbusL0yWNC+waKhZayiD+k3Z0
         eH0x+NxTF0tGYdHzJRQX6fheO7u+3RMqriJSs6jtNqjLlw+bBHB8sGqUmbcrbaohyB7L
         ycmudcz738K2+pvL0mwFkHRDHRFhlwRlQPtj1LCYXo6S4MACFftP8stTcw5JxCTgFnrv
         P0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139143; x=1762743943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sf2MtafIziFxv0+iZSQBAt6orU3b9FFBk8saiJeqI+U=;
        b=qAfSipwC92c4gd3T1zw3swtNsswsqcc/F9YIHvuD+xDv/ETufg6rqfJe0LkBgFqZjJ
         WC3lUmPd+Go3PxJBcsRphq38UNr1Scp7qYVR4eFtacdvNhqVF3NouJ60yl5O2X3CGxWO
         2YvEwbbYkFSsi0wYTRfiXJ6YrNpSPitHF1IGc5RvH/NRFeau7An/+kE2PSY9nrhiVMof
         sU3taB4CO3LwR79qS50tsEuSfLuTqFb2GWCIqwZBq4gJnvMX9QFnfYkFrGNpYM8GJJjB
         EQxKr/r3u9rvrk1mWNL0KTF4MkiXlWRdUifpdZbRR80YpW6g+Aa5elK9xf+D7UEa3m3Y
         OWzg==
X-Gm-Message-State: AOJu0Yz8zacqge/j6GqTA7QqPz0mW0WJvpMT6MEZXRj+xk3hC8GOS9c8
	ZHARIp84wMR3sg0LSo8ff1QsMNrWuDpOr/A3ZPYYXawjTrJtLVqgnWFI
X-Gm-Gg: ASbGncseVHZUEGDktfQFvA3j1QNuVUT2O89TFvvM7aBnf58dEou4mHcERXM77abhajE
	ZJqQ3mLvqDGUJjsk+oRngtw1MH8b6YLiRhea6tCt2X7V48sutN/n4giJZfK8YyUbrcYMpuLtm//
	7fD57hsYbpCpKpKe5jFz+JxzNvZjnaZazRhKdtQGXCL1thDTNQ/2Srvb3cf9Ck9urhjcKD9F/wV
	7Kwl2ly4hClhVOxev8bRvZtXTSbFq/UoPfaHxsOrTU00xOWzccl/89Me8n2QwRoignz7QNRilVT
	1SKysoyNjs8tufSdhAHlMbZWZq1Tg2J3YClNqPtE9e0Cx1pTUruqSrxPhg2M0rn4FcZRf3anh+u
	4ZiCVCGDMqNM7yD5aZ/2+HFFOHhrKcclfrXE52zO6VMdFWIfBpLlXV4elnAs2QC5P/1WYg+hn8G
	f70DmBetLKvw==
X-Google-Smtp-Source: AGHT+IGYS/nnpitzE/eUQ+F68Ex58b2ct1BccZhqdFnCOq0bLpSK6sj1xCHRpQ3LEE1D/LOlqIwsLQ==
X-Received: by 2002:a17:903:2286:b0:295:4d24:31bd with SMTP id d9443c01a7336-2954d243448mr108631195ad.17.1762139142642;
        Sun, 02 Nov 2025 19:05:42 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295c2eb15f5sm11691785ad.2.2025.11.02.19.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:05:42 -0800 (PST)
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
Subject: [PATCH v6 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon,  3 Nov 2025 11:05:23 +0800
Message-ID: <20251103030526.1092365-1-inochiama@gmail.com>
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


