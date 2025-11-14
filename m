Return-Path: <netdev+bounces-238538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23DC5AD00
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DE75355D19
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 00:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96721FF38;
	Fri, 14 Nov 2025 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGhS8/Fb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3804242D70
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 00:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763080716; cv=none; b=DaoD/hQ570uK07QlW6vTAOxbuWVymmvjdLY2jUVJpGA9TxC69JK07qigvd84qufCklPizCaN2ybdTQUZ7B1DN9I76d9h8t9gs81r2JthdLwJfgHFpcIWdaoxlKwPNvRdV3wFjF52xhaN4ellVOTWAyxudGbihINMWGhp9Lipxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763080716; c=relaxed/simple;
	bh=KRzqLJ2KAD3SSV1T/Z+RQ+x63XYbWGfjYNte8LTxVXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZwMtQvopNMU7UkZztAG0gE7JhI2WGoNHxAmz50jmzUwZBgtluORgwcYtoNDi+sbSoNBuq98bzNrJjivm6qOFxcWE+ThdiY3MwGcUMmEGbcShG7UdUVcoec839AFTeqUs8M8bHxknAC1wt/eLardXM4VBC/QxFBhHMQH3X2Zv3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGhS8/Fb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7aad4823079so1375616b3a.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763080713; x=1763685513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FVPzw5zfoDTWTXFnR/h7NqjV1cTezTe2Ib/OrTkeKgU=;
        b=bGhS8/Fb/FHBMkrfkGP857BFqMYOfa7bGcmXHI4bSwAppLjBpb3VfLCMNJ/ke2aUBd
         ySohgjOSDNSa9D2AUEpW9H1XBqOtRSN3r3tEfetJgrj7auIhWmNrX7uobT1iqZ0Vt7jq
         W/neKHMuxnnnhUNLF9p0alvge34NO2M/WQtsfkz30XRZaTQRCcYEw/RRKgrXeslPhMad
         I3TBPrdFnav6R4IisHQhu/wnAnS3minLfXTI/c848jFB2ZC98E2sF0zgBQ2XUzTyFH8P
         mJQ8me3wki2uQZG4X4o+3wuTVLRhR+9PwGnURMVdYFZoAPHNUss5Wo9cT7sQp1kWxjzS
         iwJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763080713; x=1763685513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVPzw5zfoDTWTXFnR/h7NqjV1cTezTe2Ib/OrTkeKgU=;
        b=Men2wUWbl8R+vUSW6AacEv6B4w1zjosm7pw6Qj9pppRiW+BSY1NlwEmhsIpdI3/EyL
         7VG/PjL7Cg4fgakuaaI+CGyhXy+AT9zHWqOkjeYhRPBDhrq1HWeggTcchlqhhyLA4pLO
         VlY75vhhhrxcPVDJh7jtfR0mEZ+dcpqm+F9biOrEDOCVRsxZijfktZvPmXcZ86tjOwyO
         F2HH2x3P/Ds9l7i7vnInnEuTq/+m4KlSv8UHZfVqlC3FZO0tx19wdpTvdYElX3IugVfs
         RaeLmgLiVEO7mIOPZ0mOfvjOX55bT7omkwSDrWOhCxQjBcfarSQ7UeH0DYc+8QCPsZ+1
         ckNQ==
X-Gm-Message-State: AOJu0YxzDDDEEsXkCCM5CG1CZePQI+I3iYkkS7WhIGbAvfpRBLgrxDrQ
	woO3+DAzn00Cq1A8gsYj9H+v6UreUh7PhVdtwds3RARoZhKmXmGmQNIb
X-Gm-Gg: ASbGncvFU56+ZWQ/q6uJEhRLRakjWe1ZOs4WfzDqu6XDGtcqd5UTuyBVbUTsXoRgsln
	fGPdJ4kUcDZJ6Q67ApECHjzdnsEzeG26T1r4xLIarLLi4TB3/edypL/6RosdxCp389YTWUPnW5w
	K63hD0H3jxHQW1Usz/gkwSZ3Ec8Mfwx6HaGdW2esxXOamD6FljVZ1tPRWllQRFnMfI1aF34pC1R
	umk397TgdltUpj7y8HQRSjfbeRCegRQG6Bdy3KaUoNv507EGHKRNOQK5+a+sckZ6QelG+gVhucP
	+9OGRlIS9bNTR2v0kTDG4sYfkJsYjXQgGAQqRnJelr6hUVhozIX6pyAB88qpg+SLE9EUIr0xscC
	vZ4d/ELb+LP9NnBOdGttaJ/XpfRzWsfnXRB+NCxWh+gC0sjmfG/W1iGWZup15xGxptwg9lPCs0r
	M=
X-Google-Smtp-Source: AGHT+IFMN4Id0VDWD4vgNY5yrLAnESY2doxKYngxGOLEfNZ2u1GtM7J0GBLB9kpY4AWTmMpVtXfBvw==
X-Received: by 2002:a05:7022:6284:b0:119:e56b:91ed with SMTP id a92af1059eb24-11b412096e8mr571996c88.30.1763080712752;
        Thu, 13 Nov 2025 16:38:32 -0800 (PST)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885c0sm3384978c88.3.2025.11.13.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 16:38:32 -0800 (PST)
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
Subject: [PATCH v8 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 14 Nov 2025 08:38:02 +0800
Message-ID: <20251114003805.494387-1-inochiama@gmail.com>
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

Change from v7:
- https://lore.kernel.org/all/20251107111715.3196746-1-inochiama@gmail.com
1. patch 1: fix a mistake that using rgmii-txid instead of rgmii-rxid
            for SG2042

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


