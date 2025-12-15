Return-Path: <netdev+bounces-244743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE9FCBDF13
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6979530237A1
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439B9296BDE;
	Mon, 15 Dec 2025 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="p2epmpMH"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9E1DF73A;
	Mon, 15 Dec 2025 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803598; cv=none; b=ok8LLjTKHgFOoWlpFXCAIUMFp1V3rybYqg/pvHZbBJOFbk2VbQf5PM4sLViV7UYa9QSqy892xKrA1BkymDElIMIaGIRph1jyd/N1QPeJrWBAYNsUvQAT+lPXlUf7yQC83KgxX4LkgMvGZu1MTDGhEYgoxrKu1syhtjU6wwsJfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803598; c=relaxed/simple;
	bh=B/9m4JCwLYDQLhY5DxKYy7iB+vqInahfWgRBrObX9/A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2ghgPykLBqAkfql38i66RSflxeAIzVXKsxVDVuUJX8UOZb7zF3Z1qnBi9MZ/1rU4Iwqekstq1uYm9JrG5rQs7gezAxxmp27kqb6AZPHZ8ez8YeFscZ9O08rr3smJmK6nGYcIaoHLNuwG09PM5PJOgtVUZgR+MuePzUFpJuoki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=p2epmpMH; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WJ1ylRrc9Kqu9w07WpOpeInajb+guxw+Wb2KOCJdbaA=;
	b=p2epmpMHXci7GZMREGpnXykPZE35+SF2fcMefdmHtOs6GGZ3U8sorosx0mwyQDGGVQn8VTCvf
	fAnMtnzglGl0RyBS0YCAqupJ227UKys6waqjJGcgwnFgakYZtK9EnMTVyxyTuC85Gp8dpFDknZD
	R4HaQmhMqKEX3p+XBgLEu9E=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dVKpj4MjVz12LDf;
	Mon, 15 Dec 2025 20:57:33 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 610B618048A;
	Mon, 15 Dec 2025 20:59:48 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 15 Dec 2025 20:59:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH RFC net-next 0/6] Support PHY LED for hibmcge driver
Date: Mon, 15 Dec 2025 20:56:59 +0800
Message-ID: <20251215125705.1567527-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Support PHY LED for hibmcge driver

Jijie Shao (6):
  net: phy: change of_phy_leds() to fwnode_phy_leds()
  net: phy: add support to set default rules
  net: hibmcge: create a software node for phy_led
  net: hibmcge: support get phy_leds_reg from spec register
  net: hibmcge: support get phy device from apci
  net: phy: motorcomm: fix duplex setting error for phy leds

 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  11 ++
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 153 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   5 +
 drivers/net/phy/motorcomm.c                   |   4 +-
 drivers/net/phy/phy_device.c                  |  62 ++++---
 5 files changed, 206 insertions(+), 29 deletions(-)

-- 
2.33.0


