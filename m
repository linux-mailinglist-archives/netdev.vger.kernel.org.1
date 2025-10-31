Return-Path: <netdev+bounces-234549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50EC22DE1
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB3954217D5
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CF23D7F8;
	Fri, 31 Oct 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvF2W5T0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228523BD1A
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761873894; cv=none; b=FHod0QN2dxLP+147QFPbgfq3JC2UEpqroEsbIuoJxOA8Uiyd/0huzFeT29RtbVqDrzul4SXRtKWzQZ5DBQJn1riqHb8z1bk0X+4FkM2329l37dCXP+sgEuvm1aTPdgnEyv5nDgIZqDW3F9xT47MFAMWYAt+DwlMJXikrdqLarpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761873894; c=relaxed/simple;
	bh=1O5Q6QjcYdLu+tr6/vdj/EJ3D91zuR19wO0QY5I8Boo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gplEw0TDdMlsmA9BwBXxul1cEzrp+n46StHG+rjPvpc+4GhSF+aqPLncnfz1iNvKqHVE+FxDGaOXVNLKnO7sXUJcHBhuvbtSWOvI5udxq76zoDmOlbz4HolGwcpza4ZJ7XXFOtQ616309sUEWikQooKW4S3JLTFnI0FPkmajASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvF2W5T0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a76584ea6cso651785b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761873892; x=1762478692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4k5u4IDHa2ldPO/YRgbWN7ExpsWnE3pSTkUg9MZsePQ=;
        b=SvF2W5T0rRMj+hqOKjR14mfT5talv1v6rA0Za0tJ8x8kj2iPTWx4J9LYJ9Uwo8KnLE
         EO+mcU3c7ChrHYZmIw2Cnqc4fI3uPUr0XKUNHJhUVMA3JoaPqpbFYemmD0vWIFyfA2rw
         Fp3Bp7UvH4W45IgM8ZFlvmt4vQIPDeSYvthOh9HbfcjuoEov4LFJaWP0sJtCi8dN5Hr5
         CaMWLd79Tki1v/EsX1XoFtARzrOBfOqrHMbwSaGjFoOR4Qf0dxiuAGPs7mRtWkYXiWrr
         MsDoZimsYbmyo6zowP41pUOojysWgczJRWPa42US4ZxbDBE14vNw21agCDKfF7QJcbX0
         svVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761873892; x=1762478692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4k5u4IDHa2ldPO/YRgbWN7ExpsWnE3pSTkUg9MZsePQ=;
        b=aM0m0B5DS5khzKEJ4VrtB4foCpvQ9VgSaatjp6hJ6gkZDgtj8a82LgKdqE50ePQK5T
         7Uspf+1MMu5uFP+7VwtIvcnh8Pis+PXfQNJ6U4GzAP7uf+bRBtAoni6jmzXjB9lVZ/Ve
         8tFUqxJAWu9B9EQ917ojVYXWlQIVYHexeLTv0qED9P1d6gq3qRuYWjC9LwSx6c32vqD/
         SMvLXJZqr06As/8uqcAePfedLNJKevLOiZ4q4GeWykpx2ZW0g42cs5hjPbe4rYJV7Tp1
         exAhaz1giJB2r3jRiGNKbZcmeltnRhgBTdtGIwCGFJdvh0QFmq+AHQfBrJUO/NV8S41C
         Sbdw==
X-Gm-Message-State: AOJu0Yzf8PhUTiNAQFh5irib2aRKCkv5/Y30qRny2oI0FciJyfPqK4po
	tIPn916OOzJb8I5jk9e1LRopjvLOvW+UAcZ/CEMWPbiPfV+Z1iFqVCRe
X-Gm-Gg: ASbGncvmLozUhUVsrCllOVW6ElvnNtf4ighN+qC7m4oCrH/MxWXQRP5SLd9rRHX2XO4
	xewT2kWhNlYIB4gm4NaudaUZja1tYAYGZ/hZdDDRhAy2CJ7rpfDfyuNSCODUJGUJ6elsr1nKrvt
	UyhQZHcYdou0ZzJu+s6F75nQIwsSOGgV8SQMkS/VhsBjtYNUrxvd3lrEmGOSnFbTw91Y+ITAa3G
	9yB51Lkl8UdRBgNCKwbPi9iMn8BFUrtDNaqEeJnJ2nAr4hgFpNSQXY5/PvM+7mzPj4JVyS+SHL1
	oZcbqjT1ePJONxOTW69+O8etwDucfc5ylWP6ZR8LDo58p/8KuwlKvGnYlVL/D4gZCiS0gS14/A6
	jVqcB387UHvm8tFK6WmpxBeo/GpRwnJAOadpRFMNGRqv6dS3w6mO5fuJ9J6DSqG227yDyLaw9IV
	g=
X-Google-Smtp-Source: AGHT+IEKj3bBCS9FtDr97rBmPSsnGuT/6Hzs7PvtGv6PRK2iG5dvba7cpbCl+e/48QRV8/RBzMyxUg==
X-Received: by 2002:a17:902:c401:b0:24b:182b:7144 with SMTP id d9443c01a7336-2951a38fdf9mr20303525ad.7.1761873892179;
        Thu, 30 Oct 2025 18:24:52 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699baabsm3091035ad.76.2025.10.30.18.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 18:24:51 -0700 (PDT)
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
Subject: [PATCH v5 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 31 Oct 2025 09:24:25 +0800
Message-ID: <20251031012428.488184-1-inochiama@gmail.com>
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

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 20 +++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 85 insertions(+), 1 deletion(-)

--
2.51.2


