Return-Path: <netdev+bounces-233347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA0C122E7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 01:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90ADE4E77D6
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 00:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75E1E520C;
	Tue, 28 Oct 2025 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdphfSy2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31C11AA7BF
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761611949; cv=none; b=VKrtRb2rSkmb5gbhUkl4Saiew9UGERE9Mv2Pbjx7Rv/soLUq8/f+cTZYHfcjz8d0wU3yxssLLJ8JHt0P9ZVnk/jmLkbE7RNV5O5Ao2yYVCgDIeD4US6Zkhh8rYXNQZCph18T850LRS0ZHS6e4IcWb8oPVs73IC6jUVggT11xmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761611949; c=relaxed/simple;
	bh=92L3b4Ntl7Ogh3uo+qzMPWm7sN+t4dOvnC1FUrJY5ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ipn8a9gfcALBGNI1+Rsqnqr/NWiTo06lv+6JFSHYka5GlXrbEk5IBhIxs20IOaBrzbhkoeUlzziF+aIGMGBhddH61+gkXFEaxc69hyS3iW5XJENfC9vg6OyxhHqMlP7JeO+umjdagTTepToE5L2s9alj/zOdKS72pkBMdRTctX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdphfSy2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6cf25c9ad5so4161527a12.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761611947; x=1762216747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8s7zFl+2eb3TMAz+jhCE+xRnt2/MEJ1FXnvoxEqZlz4=;
        b=OdphfSy2Jgme1nDOPVPRgiDi/WcEMqgEj9oqJreVYWDXtWlj8j/No49Bnhk33+G/8z
         SMv3rTF8uCbxR/87540IQ8FaSP4CtEEYboi7Pq5J0oysH++AaNmCXQOIgHXipKHZOvhH
         xYZ6MUd+pRg9iOIVK2G/9zVOHwZS1G5FtOicFdL/AlvHMKl9Cs9wYf5aPdTgE2koAqBz
         d53EP5jnFFhh2afZ7NlIQ50ncZ1Pl86O+luFde/Curv4XDrWC5foIHuOjPJoZbU6AO40
         JoDk7LiffKoQNvTULTrmayaAG3dyggEgL3QslANCMQM+DDd7O+iJaq/XqhFVRaAsBkIN
         Zm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761611947; x=1762216747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8s7zFl+2eb3TMAz+jhCE+xRnt2/MEJ1FXnvoxEqZlz4=;
        b=AwYG9PpMqPTjyT8x9aNJVUQgKki0838zWyaMT58kZpuRIQXhh79tirWrslFalYpEN0
         HIrTD1EymeLapKP0fl5LcVr4ddGo6j6Lit1EDn0BX8ha3aGzkSVv0WxoqVMWsX5kS28g
         IR07GRnIWc1no4C56vb6yEgb+2zdjP1K0IplKUdt8ZLScWaxT0xHLaZ+YZOFd2mO95i4
         6fa8rOt9nljbiMiwAHu8bSwSJyEqjG5CR1lWjwIA4nSoihwp/Ki0zlXhpbxwmJUXWOfX
         fdORqxq8FQlzKDK48w9VsMP3w/UDVVDAH8Ket3Fkj/FFqFDYvK1Ql0Xo8IFtSYnfNZie
         dQRw==
X-Gm-Message-State: AOJu0Yz360PqM6Jt00jV/XHAHFHuSt/53J22zHGn8JdACzISwvYnX2CX
	EMC36cTvkI7iGDfbHLuH00XOiVXu4rAMY0RQzjI3sKQKmS+wwvqK3kNm
X-Gm-Gg: ASbGnct5q8VJFiSSfc0tr7VAPoX+W9PbtGSq4Me/K+ole+Thjn2DoydotA7f5G8ShAn
	nYJpgabXk23i0gPyVpdGbnze6j4VthQFqJxsE21EPcK4UuHZ4NgRf9X79wiLkkUILN+jsUcoF8o
	3zjDpN+yZ3O9ZBKagPL/zgwFXUUZgAQ9urB39cGCZNaPKkD6OQ81Qv4F71DtcBrL3s2vWA9I7sM
	UdXBo5WSkhXxwcl3sgkKnmcoSiN47yALmw00uweRoY90bdkR7m7Y8D40aS62vOsN6/lzQ0mOhD3
	Z8R4uJxbyMUyuD2HpkCA4E1oTQ/Po6LWW8oH297KyakZtj1Hg71LQmNAjYidkFebpcSE2FvXHJZ
	zua4nEXg6MB3wspSbKzPGagNkW8CX8RCPBYYrA5h5Zh+pWd3WCB3azAtWiKaM47B2cZ5aP9tyzp
	YLGUO3S7WgK7v/27dsG9xe
X-Google-Smtp-Source: AGHT+IF5ghXu9jBruY6ziKGQyMSMM4oq3ugUChPGlRqBf0309+0SovNGzWf+rJoqR49uQlRPUDRaYw==
X-Received: by 2002:a17:902:c402:b0:290:b14c:4f36 with SMTP id d9443c01a7336-294cb52db11mr21604075ad.31.1761611947142;
        Mon, 27 Oct 2025 17:39:07 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm94353925ad.12.2025.10.27.17.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 17:39:06 -0700 (PDT)
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
Subject: [PATCH v4 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Tue, 28 Oct 2025 08:38:55 +0800
Message-ID: <20251028003858.267040-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
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

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 85 insertions(+), 1 deletion(-)

--
2.51.1


