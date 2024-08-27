Return-Path: <netdev+bounces-122167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977C960381
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D7FB2290B
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 07:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19611714BE;
	Tue, 27 Aug 2024 07:44:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702015687D;
	Tue, 27 Aug 2024 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724744675; cv=none; b=PpR8BNg+Jw/AuQxCo6ZxFd5s6h6VsKrQIjcqW8a41eegHYHPcx18Tgh826Nfuu3NpKo5OcE9X8/RdhbLRRHnsQp5pw10hIgGz1xfWZqcZsLoUTD95gK7dbarZqHr0ysOvebCMwPdmT7pYrePAGgit6j2MyUMAWn9R/jVZbQUzuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724744675; c=relaxed/simple;
	bh=FmnCQgh5y8QTcvKLPj+0RP8eZftc6EGi834E9IF6Pik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mzPgCG0LCJP+klbq9ZuUEqj4X57fyoVWdDLcYOrVoxA6vX072JTob6J92Sk+oxDKbL+hHJT+e4gZzeM2Mu2qoaxc0zHXYM7lGrKppoDlxv3R9IDOksya+ZTyw9JZHttDvr8+OvU/NbTwq536SNxac/pNu0x64a3O/6af5obsSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WtKJn3TYmzpSwL;
	Tue, 27 Aug 2024 15:42:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id BF1131800FF;
	Tue, 27 Aug 2024 15:44:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 27 Aug
 2024 15:44:28 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/7] net: Simplified with scoped function
Date: Tue, 27 Aug 2024 15:52:12 +0800
Message-ID: <20240827075219.3793198-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Simplify with scoped for each OF child loop and __free().

Jinjie Ruan (7):
  net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped() and
    __free()
  net: dsa: realtek: Use for_each_child_of_node_scoped() and __free()
  net: phy: Fix missing of_node_put() for leds
  net: mdio: mux-mmioreg: Simplified with scoped function and
    dev_err_probe()
  net: mv643xx_eth: Simplify with scoped for each OF child loop
  net: dsa: microchip: Use scoped function and __free() to simplfy code
  net: bcmasp: Simplify with scoped for each OF child loop

 drivers/net/dsa/microchip/ksz_common.c        | 12 ++---
 drivers/net/dsa/realtek/rtl8366rb.c           | 11 ++--
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 18 +++----
 drivers/net/ethernet/marvell/mv643xx_eth.c    |  5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 20 +++-----
 drivers/net/mdio/mdio-mux-mmioreg.c           | 51 ++++++++-----------
 drivers/net/phy/phy_device.c                  |  6 +--
 7 files changed, 46 insertions(+), 77 deletions(-)

-- 
2.34.1


