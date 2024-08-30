Return-Path: <netdev+bounces-123580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860B3965589
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C202858B9
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 03:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCDE137745;
	Fri, 30 Aug 2024 03:06:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02688121B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 03:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724987174; cv=none; b=mQy07FaDCE/+rOZY5G5Ejp1eU61yvgd1RDJd/GSTU1tkUhdMc1oKvqEcCKpX7dLlVS+PI3y0HkvlrXFDe6D3RdLnbfpbIqaTbbNX+XnGIaMTGsgzIL68l653fb6L6lyrtr59CmuYeczqwee5vvsIz6Q+nQQuk+oq0Zina8UBHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724987174; c=relaxed/simple;
	bh=pmdoyZjfQSnf3oExzOabBeh8t3v+zj+dpDtS/vqTI84=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ck84bSnOijHISKlVgFjwaqKTfVo+uLHMpD5LXyU1zNnSMO5tz+nCaNts3EviOeYuiVUueXkOr5cG7bRuvnTO/1oj2uxodTuourgO+kWzxBN8raxCO2JyTyxOerhOK9MR2rR8LGnoCDl61fqA6oXAxbUu5qKVE0W/D8oNz71a1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ww31L0F6Kz1j7pV;
	Fri, 30 Aug 2024 11:05:26 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 508371402C6;
	Fri, 30 Aug 2024 11:05:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 Aug
 2024 11:05:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <woojung.huh@microchip.com>, <andrew@lunn.ch>, <f.fainelli@gmail.com>,
	<olteanv@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linus.walleij@linaro.org>,
	<alsi@bang-olufsen.dk>, <justin.chen@broadcom.com>,
	<sebastian.hesselbarth@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-stm32@st-md-mailman.stormreply.com>, <krzk@kernel.org>,
	<jic23@kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net-next v4 0/8] net: Simplified with scoped function
Date: Fri, 30 Aug 2024 11:13:17 +0800
Message-ID: <20240830031325.2406672-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Simplify with scoped for each OF child loop, as well as dev_err_probe().

Changes in v4:
- Drop the fix patch and __free() patch.
- Rebased on the fix patch has been stripped out.
- Remove the extra parentheses.
- Ensure Signed-off-by: should always be last.
- Add Reviewed-by.
- Update the cover letter commit message.

Changes in v3:
- Sort the variables, longest first, shortest last.
- Add Reviewed-by.

Changes in v2:
- Subject prefix: next -> net-next.
- Split __free() from scoped for each OF child loop clean.
- Fix use of_node_put() instead of __free() for the 5th patch.

Jinjie Ruan (8):
  net: stmmac: dwmac-sun8i: Use for_each_child_of_node_scoped()
  net: dsa: realtek: Use for_each_child_of_node_scoped()
  net: phy: Use for_each_available_child_of_node_scoped()
  net: mdio: mux-mmioreg: Simplified with scoped function
  net: mdio: mux-mmioreg: Simplified with dev_err_probe()
  net: mv643xx_eth: Simplify with scoped for each OF child loop
  net: dsa: microchip: Use scoped function to simplfy code
  net: bcmasp: Simplify with scoped for each OF child loop

 drivers/net/dsa/microchip/ksz_common.c        |  5 +-
 drivers/net/dsa/realtek/rtl8366rb.c           |  8 ++-
 drivers/net/ethernet/broadcom/asp2/bcmasp.c   |  5 +-
 drivers/net/ethernet/marvell/mv643xx_eth.c    |  5 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |  6 +--
 drivers/net/mdio/mdio-mux-mmioreg.c           | 54 ++++++++-----------
 drivers/net/phy/phy_device.c                  |  5 +-
 7 files changed, 35 insertions(+), 53 deletions(-)

-- 
2.34.1


