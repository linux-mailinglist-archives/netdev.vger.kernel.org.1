Return-Path: <netdev+bounces-231282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C4BF6F0F
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F4793551CF
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AC33C503;
	Tue, 21 Oct 2025 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NnSgJHuo"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5369430F7F7;
	Tue, 21 Oct 2025 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055252; cv=none; b=R3hPuoyZnxsPIHHUrXCSHXJgeY4tD+iGNrewxQ+o6EJbO84Po96i6PoUTIK0SzFzRcLe2tgylXlHKWR/GKK4uBxLp4mxS0xmkjv6xawMuUjUhldlCCF1DPX0j5qb/kBdrMxiXOiO9CZ/VApwT3yNxiDpDOr0n8dUrVnXxR2eHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055252; c=relaxed/simple;
	bh=BDMsfozhcqQEaX/Dezr8cmV3QOUI0/xewnpgp5i+gDE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LxxMar2YJbIqXyOzewlou/ghQIbstEYAoAV5D35c+SHNyHmaNlCDl/5Z/xbrtPrpSI/jrHwugqIZNFBYgbPycQ1LB3s9hd9nKpXAsVWrNxx7qirgn3IGbyKY8G6Ao0YsCDoLcwWunXq5N2uq4vIfvvQv2280BQPAzIf1D8c7osw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NnSgJHuo; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=szKYzJwaE/2jp6EVgDqTBBfYkraAiXzMw9T6oQMBQac=;
	b=NnSgJHuo8oxqejnae/p3RSP7sxPsbkM7boJLx9LXdOzyq/VM3D6pjVXja5PYAkIAQdCk1SDQO
	FVFOwZoSovLNANNLElRgvpfOosyJtuNqPYIsni0ospuPBYAqY5nUROcksZIoIUnRyIpaX7K0n3c
	x/Yzz6aj5qxwKIeXNlsqH9A=
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4crYpX1PkKzKm5G;
	Tue, 21 Oct 2025 22:00:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 28ECA1A0188;
	Tue, 21 Oct 2025 22:00:44 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 22:00:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 0/3] There are some bugfix for hibmcge ethernet driver
Date: Tue, 21 Oct 2025 22:00:13 +0800
Message-ID: <20251021140016.3020739-1-shaojijie@huawei.com>
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

This patch set is intended to fix several issues for hibmcge driver:
1. Patch1 fixes the issue where buf avl irq is disabled after irq_handle.
2. Patch2 eliminates the error logs in scenarios without phy.
3. Patch3 fixes the issue where the network port becomes unusable
   after a PCIe RAS event.


Jijie Shao (3):
  net: hibmcge: fix rx buf avl irq is not re-enabled in irq_handle issue
  net: hibmcge: remove unnecessary check for np_link_fail in scenarios
    without phy.
  net: hibmcge: fix the inappropriate netif_device_detach()

 drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c    | 10 ++++++----
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c     |  3 +++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c    |  1 +
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c   |  1 -
 5 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.33.0


