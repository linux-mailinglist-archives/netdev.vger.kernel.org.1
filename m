Return-Path: <netdev+bounces-232317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD68AC040D7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 03:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F9F3B68C1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA321E0DE8;
	Fri, 24 Oct 2025 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7R45KQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C01B85F8
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270938; cv=none; b=gaaar6cjQgfzgi3eCXwbPwsRA75dfEbOjALHYTuftjUi7Szi7n/siryD3YqZYN0YecahCiew/PXEAgMRDBuaJcG+1KSXlbMf8ru+aXVqVhBqJFfSLOaQsxviMt1AelT72Q4HpSKR3kyqxPxFp6iZ1uHSMK7AHxHnPKbiyDmcBn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270938; c=relaxed/simple;
	bh=DFXDK1dq0hZtDmvIA9ZvRGa1Eqyq6GKOH8gUqjVv1bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB9078xaG1ccdGFtQcHMyPBisNHXybvHbTz94Z1ad/51vek4cbqvbvjB0kDTnFmHsNU0oeni+uFlyWBmbN6I8+JKZUrmQr8bTJYNC06ieU78YtvW/vXmpa2IrCPyCNdjAxFTOxoD5SDGmPLyC8XaeXLRJ2tLHOPV87pU4QpFGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7R45KQ+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so1980383a91.1
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270936; x=1761875736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM2K5UWuNXprZvBDJ5c1mMhJQmIFaH7Nb7GuoKXsnbg=;
        b=i7R45KQ+HKIZnwZA7TEAxwgektKV+Ifjnb9xExKvyPZxNf3gzwCkB/PTQblkRmW1Hp
         ze4seehUn71GJHErvfPjOLMsBvuVw6prEv7+JdF2BfROfS3YC5brF8UCknQc52rVdzwt
         IJiqPiyVVyPfaVJAquL3Wkj9mOcowhJNfaIDi9S9hGVw2b8fEA6IdF9uj//BXSyKpZIP
         qP1Vfx2t5QZwieQU8JX7u+9ailFq0S5UVIiRu/2ce5zvxxnU4l2VCYZ7eB4neBsxE/CR
         d6emKMlJYD589frzlVMteR+v5ydbMq+nmInAPA5W7ac4x7VDnj6CH5XchEGxmkQTOpAw
         XEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270936; x=1761875736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM2K5UWuNXprZvBDJ5c1mMhJQmIFaH7Nb7GuoKXsnbg=;
        b=oBwEFWFT+ZiIE2SfJ5yBxKNWJmbUjqfPFgFdqgUA9CTn8L+/xVzrZk+tPFkqDNpQK6
         b5jnFWE4XPG3OIZddwp+qDouKlXzWiIFkuvNkT3I7+N0CQ1dDLhN2oRpLDh+cej91cyx
         bbMX4kR3ruHUbf/iUcfX9qI1OMMNJvAne8Qwp/L8qWUmsPjABGoOuVfaZwrnfd/1KVqj
         1/gM0l1i2fyyfdA/h0WpGKgp178hH6R3saBm6Fdm+cij/o4Jrk5MPe3sMqpn6bVWTUpj
         CmnHiv7trdb+U5UtEmyN+sob+62R4t+Id0zp/1x3TmahESA69A8N/1DyNFHsrZ31mD+w
         bbwQ==
X-Gm-Message-State: AOJu0Yzzae5sb7NwTOSZOzfVVgvbiiLU8mFfzujs0XeaWWztcS4O5dry
	p6WTfCKABL23HZB3qfwJD+7FmOokuLeH1q+endqGGQTR81gwxujPXd7a
X-Gm-Gg: ASbGncsGE4OuOHE3YIATSq268sz0Cc6E08sA+yQBOKKw3J40WM8MtiliB1G6EKQ5eYq
	RMfOH13UeYLF6T8ea4Ln9N+BazP9lm7w/joWGUCpo+SI+MChN+eZTH/ElgbpKoR4bxTCChmOecE
	E8XWiuY0U1RWLUObS/gPK/HgwTZUmP5eCK6RbkwP+ZZPoNYGkDgOSDzvLsRmsSfOFerkYcjyGGx
	i+QdeTfwWc3uPfEuMU6au5leykFjG/J6iA5Durk55lFxO+hHwkzNzy2wqmomR+Vtz3lIFa1ObUi
	aW99/hb6HKLG8K3MXFKIQC2SSdzOes/m3plvj6fc9yJUi6SzhMXhUCsBu5jHsR6iDK8lqRNSdZi
	Xx6O6XUdQ6mIdbY02kedKPI4MzmPx74Vom5SzD9deaayYE+rv9C6jXa7Z2u3f7vQCwXuejX6ik2
	tliEVrkrIZiQ==
X-Google-Smtp-Source: AGHT+IFGuiuD5qMaB237ASMVYM5OY1+My1nEaULow6/U2LgSioG18/RvbKuul7ZQNTuvhLccqeac+g==
X-Received: by 2002:a17:90b:5386:b0:32e:749d:fcb6 with SMTP id 98e67ed59e1d1-33bcf86b5c6mr38689912a91.12.1761270936488;
        Thu, 23 Oct 2025 18:55:36 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c3a6csm4951393a91.5.2025.10.23.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:36 -0700 (PDT)
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
Subject: [PATCH v3 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 24 Oct 2025 09:55:21 +0800
Message-ID: <20251024015524.291013-1-inochiama@gmail.com>
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

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 17 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 82 insertions(+), 1 deletion(-)

--
2.51.1


