Return-Path: <netdev+bounces-123107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C69963B3C
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 08:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56BB1C208C3
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFAF152165;
	Thu, 29 Aug 2024 06:23:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54DC13E02A
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912603; cv=none; b=C3KZONhgMDT9/7hmwOaLR4JfNNpXVluw7XCiqf3NowbqYuAFoKmFTgbrFmrFtfP+PkanYONwWlTuhbKumXnsGY0tgJJjTkWZA1fvMgyoR858LN66DPwlPDB3nx+EOyq+EcqHiNytSzzFkd2kZkoiEyul8JEZcat7agHK83nLqM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912603; c=relaxed/simple;
	bh=w9V2nYpCOv3yUpxRlfoF+9rM9Ej4RplyKeeZ3zq/f+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LH/f4MFDf4twkWOiCRdk6gsIaVaNr06QHGXDqbzP9GacJGQV4OSnzth74XzsjXobZZcVC6vZ8JKa5dAF7ZgN+vCPjB9ddYYtEtJgd088YdU9w4mEqwheFbaWfCjzCdrPaNo1Bc6jDE7KpY+Oqd9j40cl+DnJ1v5O6lQfaRAAIz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WvWR90bpqz18Mp4;
	Thu, 29 Aug 2024 14:22:29 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E3681401F2;
	Thu, 29 Aug 2024 14:23:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 14:23:17 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <mcoquelin.stm32@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <ansuelsmth@gmail.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcom.com>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<krzk@kernel.org>, <jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v3 00/13] net: Simplified with scoped function
Date: Thu, 29 Aug 2024 14:31:05 +0800
Message-ID: <20240829063118.67453-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Simplify with scoped for each OF child loop and __free(), as well as
dev_err_probe().

Changes in v3:
- Sort the variables, longest first, shortest last.
- Add Reviewed-by.

Changes in v2:
- Subject prefix: next -> net-next.
- Split __free() from scoped for each OF child loop clean.
- Fix use of_node_put() instead of __free() for the 5th patch.

Jinjie Ruan (13):
  net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
  net: stmmac: dwmac-sun8i: Use __free() to simplify code
  net: dsa: realtek: Use for_each_child_of_node_scoped()
  net: dsa: realtek: Use __free() to simplify code
  net: phy: Fix missing of_node_put() for leds
  net: phy: Use for_each_available_child_of_node_scoped()
  net: mdio: mux-mmioreg: Simplified with scoped function
  net: mdio: mux-mmioreg: Simplified with dev_err_probe()
  net: mv643xx_eth: Simplify with scoped for each OF child loop
  net: dsa: microchip: Use scoped function to simplfy code
  net: dsa: microchip: Use __free() to simplfy code
  net: bcmasp: Simplify with scoped for each OF child loop
  net: bcmasp: Simplify with __free()

 drivers/net/dsa/microchip/ksz_common.c        | 12 ++---
 drivers/net/dsa/realtek/rtl8366rb.c           | 21 +++-----
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 18 +++----
 drivers/net/ethernet/marvell/mv643xx_eth.c    |  5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 20 +++-----
 drivers/net/mdio/mdio-mux-mmioreg.c           | 51 ++++++++-----------
 drivers/net/phy/phy_device.c                  |  7 +--
 7 files changed, 51 insertions(+), 83 deletions(-)

-- 
2.34.1


